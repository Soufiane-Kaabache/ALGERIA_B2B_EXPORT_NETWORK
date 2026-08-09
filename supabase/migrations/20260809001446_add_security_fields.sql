-- Create supplier_documents table if it doesn't exist
CREATE TABLE IF NOT EXISTS supplier_documents (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  business_id UUID NOT NULL REFERENCES businesses(id) ON DELETE CASCADE,
  document_type VARCHAR(50) NOT NULL,
  file_path VARCHAR(500) NOT NULL,
  file_hash VARCHAR(64),
  file_size INTEGER,
  uploaded_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  is_verified BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(business_id, document_type)
);

-- Add index for faster queries
CREATE INDEX IF NOT EXISTS idx_supplier_documents_business_id 
  ON supplier_documents(business_id);

-- Add security and integrity fields to user_profiles table
ALTER TABLE user_profiles 
ADD COLUMN IF NOT EXISTS role VARCHAR(50) DEFAULT 'supplier',
ADD COLUMN IF NOT EXISTS permissions JSONB DEFAULT '{}';

-- Enable Row Level Security
ALTER TABLE businesses ENABLE ROW LEVEL SECURITY;
ALTER TABLE supplier_documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;

-- ===== BUSINESSES TABLE POLICIES =====
-- Users can only view/update their own business
CREATE POLICY IF NOT EXISTS "Users can view their own business"
  ON businesses FOR SELECT
  USING (
    created_by = auth.uid()
    OR auth.uid() IN (
      SELECT id FROM user_profiles WHERE business_id = businesses.id
    )
  );

CREATE POLICY IF NOT EXISTS "Users can update their own business"
  ON businesses FOR UPDATE
  USING (created_by = auth.uid())
  WITH CHECK (created_by = auth.uid());

CREATE POLICY IF NOT EXISTS "Users can insert their own business"
  ON businesses FOR INSERT
  WITH CHECK (created_by = auth.uid());

-- Admins can view all businesses
CREATE POLICY IF NOT EXISTS "Admins can view all businesses"
  ON businesses FOR SELECT
  USING (
    auth.uid() IN (
      SELECT id FROM user_profiles WHERE role = 'admin'
    )
  );

-- ===== SUPPLIER_DOCUMENTS TABLE POLICIES =====
-- Users can view/insert documents for their business
CREATE POLICY IF NOT EXISTS "Users can view their documents"
  ON supplier_documents FOR SELECT
  USING (
    business_id IN (
      SELECT business_id FROM user_profiles WHERE id = auth.uid()
    )
  );

CREATE POLICY IF NOT EXISTS "Users can insert documents for their business"
  ON supplier_documents FOR INSERT
  WITH CHECK (
    business_id IN (
      SELECT business_id FROM user_profiles WHERE id = auth.uid()
    )
  );

CREATE POLICY IF NOT EXISTS "Users can delete their documents"
  ON supplier_documents FOR DELETE
  USING (
    business_id IN (
      SELECT business_id FROM user_profiles WHERE id = auth.uid()
    )
  );

-- Admins can view all documents
CREATE POLICY IF NOT EXISTS "Admins can view all documents"
  ON supplier_documents FOR SELECT
  USING (
    auth.uid() IN (
      SELECT id FROM user_profiles WHERE role = 'admin'
    )
  );

-- ===== USER_PROFILES TABLE POLICIES =====
-- Users can view their own profile
CREATE POLICY IF NOT EXISTS "Users can view their own profile"
  ON user_profiles FOR SELECT
  USING (id = auth.uid());

-- Users can update their own profile
CREATE POLICY IF NOT EXISTS "Users can update their own profile"
  ON user_profiles FOR UPDATE
  USING (id = auth.uid())
  WITH CHECK (id = auth.uid());

-- Admins can view all profiles
CREATE POLICY IF NOT EXISTS "Admins can view all profiles"
  ON user_profiles FOR SELECT
  USING (
    auth.uid() IN (
      SELECT id FROM user_profiles WHERE role = 'admin'
    )
  );

-- ===== CREATE RPC FUNCTION FOR ATOMIC TRANSACTIONS =====
CREATE OR REPLACE FUNCTION create_business_with_profile(
  payload_json JSONB,
  user_id UUID
) RETURNS JSONB AS $$
DECLARE
  business_id UUID;
BEGIN
  -- Insert business
  INSERT INTO businesses (
    trade_name,
    legal_name,
    legal_form,
    nif,
    nrc,
    wilaya_code,
    address,
    phone,
    email,
    status,
    created_by
  ) VALUES (
    payload_json->>'trade_name',
    payload_json->>'legal_name',
    payload_json->>'legal_form',
    NULLIF(payload_json->>'nif', ''),
    NULLIF(payload_json->>'nrc', ''),
    payload_json->>'wilaya_code',
    NULLIF(payload_json->>'address', ''),
    NULLIF(payload_json->>'phone', ''),
    NULLIF(payload_json->>'email', ''),
    'draft',
    user_id
  ) RETURNING id INTO business_id;

  -- Check if profile exists
  IF EXISTS (SELECT 1 FROM user_profiles WHERE id = user_id) THEN
    -- Update existing profile
    UPDATE user_profiles SET business_id = business_id WHERE id = user_id;
  ELSE
    -- Create new profile
    INSERT INTO user_profiles (id, business_id, role)
    VALUES (user_id, business_id, 'supplier');
  END IF;

  RETURN jsonb_build_object('id', business_id);
EXCEPTION WHEN OTHERS THEN
  RAISE EXCEPTION 'Transaction failed: %', SQLERRM;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant permission to execute the function
GRANT EXECUTE ON FUNCTION create_business_with_profile(JSONB, UUID) TO anon, authenticated;
