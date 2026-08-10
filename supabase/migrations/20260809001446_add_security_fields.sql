-- Create supplier_documents table if it doesn't exist
CREATE TABLE IF NOT EXISTS supplier_documents (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  supplier_id UUID NOT NULL REFERENCES public.suppliers(id) ON DELETE CASCADE,
  document_type VARCHAR(50) NOT NULL,
  file_path VARCHAR(500) NOT NULL,
  file_hash VARCHAR(64),
  file_size INTEGER,
  uploaded_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  is_verified BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(supplier_id, document_type)
);

-- Add index for faster queries
CREATE INDEX IF NOT EXISTS idx_supplier_documents_supplier_id 
  ON supplier_documents(supplier_id);

-- Add security fields to suppliers table
ALTER TABLE public.suppliers
ADD COLUMN IF NOT EXISTS nif VARCHAR(20),
ADD COLUMN IF NOT EXISTS nrc VARCHAR(20),
ADD COLUMN IF NOT EXISTS role VARCHAR(50) DEFAULT 'supplier',
ADD COLUMN IF NOT EXISTS permissions JSONB DEFAULT '{}';

-- Enable Row Level Security
ALTER TABLE public.suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE supplier_documents ENABLE ROW LEVEL SECURITY;

-- ===== SUPPLIERS TABLE POLICIES =====
DROP POLICY IF EXISTS "Users can view their own supplier" ON public.suppliers;
CREATE POLICY "Users can view their own supplier"
  ON public.suppliers FOR SELECT
  USING (user_id = auth.uid() OR auth.uid() IN (
    SELECT user_id FROM public.suppliers WHERE role = 'admin'
  ));

DROP POLICY IF EXISTS "Users can update their own supplier" ON public.suppliers;
CREATE POLICY "Users can update their own supplier"
  ON public.suppliers FOR UPDATE
  USING (user_id = auth.uid())
  WITH CHECK (user_id = auth.uid());

-- Admins can view all suppliers
DROP POLICY IF EXISTS "Admins can view all suppliers" ON public.suppliers;
CREATE POLICY "Admins can view all suppliers"
  ON public.suppliers FOR SELECT
  USING (
    auth.uid() IN (
      SELECT user_id FROM public.suppliers WHERE role = 'admin'
    )
  );

-- ===== SUPPLIER_DOCUMENTS TABLE POLICIES =====
DROP POLICY IF EXISTS "Users can view their documents" ON supplier_documents;
CREATE POLICY "Users can view their documents"
  ON supplier_documents FOR SELECT
  USING (
    supplier_id IN (
      SELECT id FROM public.suppliers WHERE user_id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "Users can insert documents for their supplier" ON supplier_documents;
CREATE POLICY "Users can insert documents for their supplier"
  ON supplier_documents FOR INSERT
  WITH CHECK (
    supplier_id IN (
      SELECT id FROM public.suppliers WHERE user_id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "Users can delete their documents" ON supplier_documents;
CREATE POLICY "Users can delete their documents"
  ON supplier_documents FOR DELETE
  USING (
    supplier_id IN (
      SELECT id FROM public.suppliers WHERE user_id = auth.uid()
    )
  );

-- Admins can view all documents
DROP POLICY IF EXISTS "Admins can view all documents" ON supplier_documents;
CREATE POLICY "Admins can view all documents"
  ON supplier_documents FOR SELECT
  USING (
    auth.uid() IN (
      SELECT user_id FROM public.suppliers WHERE role = 'admin'
    )
  );

-- ===== CREATE RPC FUNCTION FOR ATOMIC DOCUMENT UPLOAD =====
CREATE OR REPLACE FUNCTION upload_supplier_document(
  p_supplier_id UUID,
  p_document_type VARCHAR,
  p_file_path VARCHAR,
  p_file_hash VARCHAR,
  p_file_size INTEGER
) RETURNS JSONB AS $$
DECLARE
  doc_id UUID;
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM public.suppliers 
    WHERE id = p_supplier_id AND user_id = auth.uid()
  ) THEN
    RAISE EXCEPTION 'Unauthorized: You do not own this supplier profile';
  END IF;

  INSERT INTO supplier_documents (
    supplier_id,
    document_type,
    file_path,
    file_hash,
    file_size,
    is_verified
  ) VALUES (
    p_supplier_id,
    p_document_type,
    p_file_path,
    p_file_hash,
    p_file_size,
    TRUE
  )
  ON CONFLICT (supplier_id, document_type)
  DO UPDATE SET
    file_path = EXCLUDED.file_path,
    file_hash = EXCLUDED.file_hash,
    file_size = EXCLUDED.file_size,
    uploaded_at = CURRENT_TIMESTAMP,
    is_verified = TRUE
  RETURNING id INTO doc_id;

  RETURN jsonb_build_object(
    'id', doc_id,
    'supplier_id', p_supplier_id,
    'document_type', p_document_type,
    'file_hash', p_file_hash,
    'file_size', p_file_size
  );
EXCEPTION WHEN OTHERS THEN
  RAISE EXCEPTION 'Transaction failed: %', SQLERRM;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION upload_supplier_document(UUID, VARCHAR, VARCHAR, VARCHAR, INTEGER) TO anon, authenticated;

-- ===== CREATE RPC FUNCTION FOR UPDATING SUPPLIER INFO =====
CREATE OR REPLACE FUNCTION update_supplier_profile(
  p_supplier_id UUID,
  p_nif VARCHAR DEFAULT NULL,
  p_nrc VARCHAR DEFAULT NULL,
  p_company_name VARCHAR DEFAULT NULL,
  p_email VARCHAR DEFAULT NULL,
  p_phone VARCHAR DEFAULT NULL
) RETURNS JSONB AS $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM public.suppliers 
    WHERE id = p_supplier_id AND user_id = auth.uid()
  ) THEN
    RAISE EXCEPTION 'Unauthorized: You do not own this supplier profile';
  END IF;

  UPDATE public.suppliers SET
    nif = COALESCE(p_nif, nif),
    nrc = COALESCE(p_nrc, nrc),
    company_name = COALESCE(p_company_name, company_name),
    email = COALESCE(p_email, email),
    phone = COALESCE(p_phone, phone),
    updated_at = CURRENT_TIMESTAMP
  WHERE id = p_supplier_id;

  RETURN jsonb_build_object(
    'id', p_supplier_id,
    'success', TRUE,
    'message', 'Supplier profile updated successfully'
  );
EXCEPTION WHEN OTHERS THEN
  RAISE EXCEPTION 'Transaction failed: %', SQLERRM;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION update_supplier_profile(UUID, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR) TO anon, authenticated;
