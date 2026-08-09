-- =========================================================
-- ALGERIA B2B EXPORT NETWORK — Script de Restauration Complet
-- =========================================================

-- 0. FONCTIONS
CREATE OR REPLACE FUNCTION public.update_updated_at_column() RETURNS TRIGGER AS $$ BEGIN NEW.updated_at = NOW(); RETURN NEW; END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION public.validate_quote_provider() RETURNS TRIGGER AS $$ BEGIN
    CASE NEW.provider_type
        WHEN 'carrier_dz' THEN IF NOT EXISTS (SELECT 1 FROM public.carriers_dz WHERE id = NEW.provider_id) THEN RAISE EXCEPTION 'Invalid carrier_dz'; END IF;
        WHEN 'freight_forwarder' THEN IF NOT EXISTS (SELECT 1 FROM public.freight_forwarders WHERE id = NEW.provider_id) THEN RAISE EXCEPTION 'Invalid forwarder'; END IF;
        WHEN 'carrier_eu' THEN IF NOT EXISTS (SELECT 1 FROM public.carriers_eu WHERE id = NEW.provider_id) THEN RAISE EXCEPTION 'Invalid carrier_eu'; END IF;
    END CASE; RETURN NEW;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION public.validate_payout_payee() RETURNS TRIGGER AS $$ BEGIN
    CASE NEW.payee_type
        WHEN 'supplier' THEN IF NOT EXISTS (SELECT 1 FROM public.suppliers WHERE id = NEW.payee_id) THEN RAISE EXCEPTION 'Invalid supplier'; END IF;
        WHEN 'carrier_dz' THEN IF NOT EXISTS (SELECT 1 FROM public.carriers_dz WHERE id = NEW.payee_id) THEN RAISE EXCEPTION 'Invalid carrier_dz'; END IF;
        WHEN 'freight_forwarder' THEN IF NOT EXISTS (SELECT 1 FROM public.freight_forwarders WHERE id = NEW.payee_id) THEN RAISE EXCEPTION 'Invalid forwarder'; END IF;
        WHEN 'carrier_eu' THEN IF NOT EXISTS (SELECT 1 FROM public.carriers_eu WHERE id = NEW.payee_id) THEN RAISE EXCEPTION 'Invalid carrier_eu'; END IF;
    END CASE; RETURN NEW;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION public.update_rating_avg() RETURNS TRIGGER AS $$ DECLARE target_table TEXT; avg_rating NUMERIC(2,1);
BEGIN
    target_table := CASE COALESCE(NEW.target_type, OLD.target_type)
        WHEN 'freight_forwarder' THEN 'freight_forwarders'
        WHEN 'carrier_dz' THEN 'carriers_dz'
        WHEN 'carrier_eu' THEN 'carriers_eu'
        WHEN 'supplier' THEN 'suppliers'
    END;
    SELECT ROUND(AVG(rating)::numeric, 1) INTO avg_rating FROM public.reviews WHERE target_type = COALESCE(NEW.target_type, OLD.target_type) AND target_id = COALESCE(NEW.target_id, OLD.target_id);
    EXECUTE format('UPDATE public.%I SET rating_avg = $1 WHERE id = $2', target_table) USING COALESCE(avg_rating, 0), COALESCE(NEW.target_id, OLD.target_id);
    RETURN NULL;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION public.is_admin() RETURNS BOOLEAN LANGUAGE plpgsql STABLE SECURITY DEFINER SET search_path = public, pg_temp AS $$ BEGIN RETURN (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin'; END; $$;

CREATE OR REPLACE FUNCTION public.is_current_user_actor(p_type TEXT, p_id UUID) RETURNS BOOLEAN LANGUAGE plpgsql STABLE SECURITY DEFINER SET search_path = public, pg_temp AS $$ BEGIN
    RETURN (
        (p_type = 'carrier_dz' AND EXISTS (SELECT 1 FROM public.carriers_dz WHERE id = p_id AND user_id = auth.uid())) OR
        (p_type = 'freight_forwarder' AND EXISTS (SELECT 1 FROM public.freight_forwarders WHERE id = p_id AND user_id = auth.uid())) OR
        (p_type = 'carrier_eu' AND EXISTS (SELECT 1 FROM public.carriers_eu WHERE id = p_id AND user_id = auth.uid())) OR
        (p_type = 'supplier' AND EXISTS (SELECT 1 FROM public.suppliers WHERE id = p_id AND user_id = auth.uid()))
    );
END; $$;

CREATE OR REPLACE FUNCTION public.handle_new_user() RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER SET search_path = public, pg_temp AS $$ DECLARE user_role TEXT; company_name TEXT;
BEGIN
    user_role := NEW.raw_user_meta_data->>'role';
    company_name := COALESCE(NEW.raw_user_meta_data->>'company_name', 'Entreprise non renseignée');
    IF user_role = 'supplier' THEN INSERT INTO public.suppliers (user_id, company_name) VALUES (NEW.id, company_name);
    ELSIF user_role = 'carrier_dz' THEN INSERT INTO public.carriers_dz (user_id, company_name) VALUES (NEW.id, company_name);
    ELSIF user_role = 'carrier_eu' THEN INSERT INTO public.carriers_eu (user_id, company_name) VALUES (NEW.id, company_name);
    ELSIF user_role = 'freight_forwarder' THEN INSERT INTO public.freight_forwarders (user_id, company_name) VALUES (NEW.id, company_name);
    ELSIF user_role = 'buyer_eu' THEN INSERT INTO public.buyers_eu (user_id, company_name) VALUES (NEW.id, company_name);
    END IF;
    RETURN NEW;
END; $$;

-- 1. TABLES
CREATE TABLE IF NOT EXISTS public.suppliers (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, user_id UUID REFERENCES auth.users(id), company_name VARCHAR(255) NOT NULL, contact_name VARCHAR(255), email VARCHAR(255), phone VARCHAR(50), supplier_number VARCHAR(100), address TEXT, city VARCHAR(100), wilaya VARCHAR(100), product_categories JSONB DEFAULT '[]', certifications JSONB DEFAULT '[]', tax_id VARCHAR(100), bank_details JSONB, rating_avg NUMERIC(2,1) DEFAULT 0, notes TEXT, active BOOLEAN DEFAULT true, created_at TIMESTAMPTZ DEFAULT NOW(), updated_at TIMESTAMPTZ DEFAULT NOW());
CREATE TABLE IF NOT EXISTS public.carriers_dz (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, user_id UUID REFERENCES auth.users(id), company_name VARCHAR(255) NOT NULL, contact_name VARCHAR(255), email VARCHAR(255), phone VARCHAR(50), carrier_number VARCHAR(100), address TEXT, city VARCHAR(100), wilaya VARCHAR(100), zones_covered JSONB DEFAULT '[]', transport_capacity TEXT, vehicle_types JSONB DEFAULT '[]', tax_id VARCHAR(100), bank_details JSONB, rating_avg NUMERIC(2,1) DEFAULT 0, active BOOLEAN DEFAULT true, notes TEXT, created_at TIMESTAMPTZ DEFAULT NOW(), updated_at TIMESTAMPTZ DEFAULT NOW());
CREATE TABLE IF NOT EXISTS public.carriers_eu (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, user_id UUID REFERENCES auth.users(id), company_name VARCHAR(255) NOT NULL, contact_name VARCHAR(255), email VARCHAR(255), phone VARCHAR(50), carrier_number VARCHAR(100), address TEXT, city VARCHAR(100), country VARCHAR(100) DEFAULT 'France', zones_covered JSONB DEFAULT '[]', transport_capacity TEXT, vehicle_types JSONB DEFAULT '[]', linked_buyer_id UUID, tax_id VARCHAR(100), bank_details JSONB, rating_avg NUMERIC(2,1) DEFAULT 0, active BOOLEAN DEFAULT true, notes TEXT, created_at TIMESTAMPTZ DEFAULT NOW(), updated_at TIMESTAMPTZ DEFAULT NOW());
CREATE TABLE IF NOT EXISTS public.freight_forwarders (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, user_id UUID REFERENCES auth.users(id), company_name VARCHAR(255) NOT NULL, contact_name VARCHAR(255), email VARCHAR(255), phone VARCHAR(50), license_number VARCHAR(100), address TEXT, city VARCHAR(100), country VARCHAR(100), ports_covered JSONB DEFAULT '[]', services JSONB DEFAULT '[]', tax_id VARCHAR(100), bank_details JSONB, rating_avg NUMERIC(2,1) DEFAULT 0, active BOOLEAN DEFAULT true, notes TEXT, created_at TIMESTAMPTZ DEFAULT NOW(), updated_at TIMESTAMPTZ DEFAULT NOW());
CREATE TABLE IF NOT EXISTS public.buyers_eu (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, user_id UUID REFERENCES auth.users(id), company_name VARCHAR(255) NOT NULL, contact_name VARCHAR(255), email VARCHAR(255), phone VARCHAR(50), buyer_type VARCHAR(50), address TEXT, city VARCHAR(100), country VARCHAR(100) DEFAULT 'France', tax_id VARCHAR(100), stripe_customer_id TEXT, notes TEXT, active BOOLEAN DEFAULT true, created_at TIMESTAMPTZ DEFAULT NOW(), updated_at TIMESTAMPTZ DEFAULT NOW());
CREATE TABLE IF NOT EXISTS public.products_catalog (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, supplier_id UUID NOT NULL REFERENCES public.suppliers(id) ON DELETE RESTRICT, product_name VARCHAR(255) NOT NULL, category VARCHAR(100), description TEXT, unit VARCHAR(50) NOT NULL DEFAULT 'kg', price_dzd NUMERIC(12,2) NOT NULL CHECK (price_dzd >= 0), min_order_qty NUMERIC(12,2) CHECK (min_order_qty >= 0), available_qty NUMERIC(12,2) CHECK (available_qty >= 0), image_url TEXT, active BOOLEAN DEFAULT true, created_at TIMESTAMPTZ DEFAULT NOW(), updated_at TIMESTAMPTZ DEFAULT NOW());
CREATE TABLE IF NOT EXISTS public.exchange_rates (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, currency_from VARCHAR(3) NOT NULL DEFAULT 'EUR', currency_to VARCHAR(3) NOT NULL DEFAULT 'DZD', rate NUMERIC(12,6) NOT NULL CHECK (rate > 0), source VARCHAR(100), rate_date DATE NOT NULL DEFAULT CURRENT_DATE, created_at TIMESTAMPTZ DEFAULT NOW(), CONSTRAINT exchange_rates_unique_date UNIQUE (currency_from, currency_to, rate_date));
CREATE TABLE IF NOT EXISTS public.orders (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, buyer_id UUID NOT NULL REFERENCES public.buyers_eu(id), status VARCHAR(50) DEFAULT 'draft', total_amount_eur NUMERIC(12,2) CHECK (total_amount_eur >= 0), total_amount_dzd NUMERIC(14,2) CHECK (total_amount_dzd >= 0), exchange_rate_id UUID REFERENCES public.exchange_rates(id), exchange_rate_value NUMERIC(12,6), notes TEXT, confirmed_at TIMESTAMPTZ, paid_at TIMESTAMPTZ, delivered_at TIMESTAMPTZ, cancelled_at TIMESTAMPTZ, cancellation_reason TEXT, created_at TIMESTAMPTZ DEFAULT NOW(), updated_at TIMESTAMPTZ DEFAULT NOW());
CREATE TABLE IF NOT EXISTS public.order_items (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, order_id UUID NOT NULL REFERENCES public.orders(id) ON DELETE CASCADE, supplier_id UUID NOT NULL REFERENCES public.suppliers(id), product_id UUID NOT NULL REFERENCES public.products_catalog(id), quantity NUMERIC(12,2) NOT NULL CHECK (quantity > 0), unit_price_dzd NUMERIC(12,2) NOT NULL CHECK (unit_price_dzd >= 0), unit_price_eur NUMERIC(12,2) CHECK (unit_price_eur >= 0), subtotal_eur NUMERIC(12,2) GENERATED ALWAYS AS (quantity * COALESCE(unit_price_eur, 0)) STORED, created_at TIMESTAMPTZ DEFAULT NOW());
CREATE TABLE IF NOT EXISTS public.quote_requests (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, order_id UUID NOT NULL REFERENCES public.orders(id) ON DELETE CASCADE, supplier_id UUID NOT NULL REFERENCES public.suppliers(id), transport_mode VARCHAR(50), status VARCHAR(50) DEFAULT 'open', deadline DATE, created_at TIMESTAMPTZ DEFAULT NOW());
CREATE TABLE IF NOT EXISTS public.quotes (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, quote_request_id UUID NOT NULL REFERENCES public.quote_requests(id) ON DELETE CASCADE, provider_type VARCHAR(50) NOT NULL, provider_id UUID NOT NULL, price_eur NUMERIC(12,2) NOT NULL CHECK (price_eur >= 0), price_breakdown JSONB, estimated_days INTEGER CHECK (estimated_days > 0), status VARCHAR(50) DEFAULT 'pending', valid_until DATE, notes TEXT, created_at TIMESTAMPTZ DEFAULT NOW());
CREATE TABLE IF NOT EXISTS public.payments (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, order_id UUID NOT NULL REFERENCES public.orders(id), stripe_payment_id TEXT, amount_eur NUMERIC(12,2) NOT NULL CHECK (amount_eur > 0), status VARCHAR(50) DEFAULT 'pending', paid_at TIMESTAMPTZ, metadata JSONB, created_at TIMESTAMPTZ DEFAULT NOW());
CREATE TABLE IF NOT EXISTS public.payouts (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, order_id UUID NOT NULL REFERENCES public.orders(id), payee_type VARCHAR(50) NOT NULL, payee_id UUID NOT NULL, amount_eur NUMERIC(12,2) NOT NULL CHECK (amount_eur > 0), amount_dzd NUMERIC(14,2), status VARCHAR(50) DEFAULT 'pending', method VARCHAR(50) DEFAULT 'BEA_virement', reference TEXT, sent_at TIMESTAMPTZ, confirmed_at TIMESTAMPTZ, notes TEXT, created_at TIMESTAMPTZ DEFAULT NOW());
CREATE TABLE IF NOT EXISTS public.documents (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, order_id UUID REFERENCES public.orders(id), doc_type VARCHAR(100) NOT NULL, file_name VARCHAR(500), file_url TEXT NOT NULL, file_size INTEGER, mime_type VARCHAR(100), uploaded_by UUID REFERENCES auth.users(id), visible_to JSONB DEFAULT '["admin"]', created_at TIMESTAMPTZ DEFAULT NOW());
CREATE TABLE IF NOT EXISTS public.reviews (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, order_id UUID REFERENCES public.orders(id), reviewer_id UUID NOT NULL REFERENCES auth.users(id), target_type VARCHAR(50) NOT NULL, target_id UUID NOT NULL, rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5), comment TEXT, created_at TIMESTAMPTZ DEFAULT NOW(), CONSTRAINT reviews_unique UNIQUE (order_id, reviewer_id, target_type, target_id));
CREATE TABLE IF NOT EXISTS public.conversations (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, order_id UUID REFERENCES public.orders(id), subject VARCHAR(255), created_at TIMESTAMPTZ DEFAULT NOW(), updated_at TIMESTAMPTZ DEFAULT NOW());
CREATE TABLE IF NOT EXISTS public.conversation_participants (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, conversation_id UUID NOT NULL REFERENCES public.conversations(id) ON DELETE CASCADE, user_id UUID NOT NULL REFERENCES auth.users(id), joined_at TIMESTAMPTZ DEFAULT NOW(), CONSTRAINT conv_participants_unique UNIQUE (conversation_id, user_id));
CREATE TABLE IF NOT EXISTS public.chat_messages (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, conversation_id UUID NOT NULL REFERENCES public.conversations(id) ON DELETE CASCADE, sender_id UUID NOT NULL REFERENCES auth.users(id), content TEXT NOT NULL, read_by JSONB DEFAULT '[]', created_at TIMESTAMPTZ DEFAULT NOW());
CREATE TABLE IF NOT EXISTS public.notifications (id UUID DEFAULT gen_random_uuid() PRIMARY KEY, user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE, title VARCHAR(255) NOT NULL, message TEXT NOT NULL, type VARCHAR(50) NOT NULL DEFAULT 'info', link TEXT, read BOOLEAN DEFAULT false, created_at TIMESTAMPTZ DEFAULT NOW());

-- FK et Index
ALTER TABLE public.carriers_eu ADD CONSTRAINT carriers_eu_linked_buyer_fkey FOREIGN KEY (linked_buyer_id) REFERENCES public.buyers_eu(id);
CREATE INDEX IF NOT EXISTS idx_suppliers_user_id ON public.suppliers(user_id);
CREATE INDEX IF NOT EXISTS idx_carriers_dz_user_id ON public.carriers_dz(user_id);
CREATE INDEX IF NOT EXISTS idx_carriers_eu_user_id ON public.carriers_eu(user_id);
CREATE INDEX IF NOT EXISTS idx_freight_forwarders_user_id ON public.freight_forwarders(user_id);
CREATE INDEX IF NOT EXISTS idx_buyers_eu_user_id ON public.buyers_eu(user_id);
CREATE INDEX IF NOT EXISTS idx_products_supplier ON public.products_catalog(supplier_id);
CREATE INDEX IF NOT EXISTS idx_orders_buyer ON public.orders(buyer_id);
CREATE INDEX IF NOT EXISTS idx_order_items_order ON public.order_items(order_id);
CREATE INDEX IF NOT EXISTS idx_qr_order ON public.quote_requests(order_id);
CREATE INDEX IF NOT EXISTS idx_quotes_request ON public.quotes(quote_request_id);
CREATE INDEX IF NOT EXISTS idx_payments_order ON public.payments(order_id);
CREATE INDEX IF NOT EXISTS idx_payouts_order ON public.payouts(order_id);
CREATE INDEX IF NOT EXISTS idx_documents_order ON public.documents(order_id);
CREATE INDEX IF NOT EXISTS idx_reviews_target ON public.reviews(target_type, target_id);
CREATE INDEX IF NOT EXISTS idx_conv_participants_user ON public.conversation_participants(user_id);
CREATE INDEX IF NOT EXISTS idx_chat_conv ON public.chat_messages(conversation_id);

-- Triggers updated_at
DO $$ DECLARE tbl TEXT; trg TEXT;
BEGIN
    FOR tbl, trg IN VALUES ('suppliers', 'update_suppliers_updated_at'), ('carriers_dz', 'update_carriers_dz_updated_at'), ('carriers_eu', 'update_carriers_eu_updated_at'), ('freight_forwarders', 'update_freight_forwarders_updated_at'), ('buyers_eu', 'update_buyers_eu_updated_at'), ('products_catalog', 'update_products_catalog_updated_at'), ('orders', 'update_orders_updated_at'), ('conversations', 'update_conversations_updated_at')
    LOOP EXECUTE format('DROP TRIGGER IF EXISTS %I ON public.%I', trg, tbl);
    EXECUTE format('CREATE TRIGGER %I BEFORE UPDATE ON public.%I FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column()', trg, tbl);
    END LOOP;
END $$;

DROP TRIGGER IF EXISTS validate_quote_provider_trigger ON public.quotes;
CREATE TRIGGER validate_quote_provider_trigger BEFORE INSERT OR UPDATE ON public.quotes FOR EACH ROW EXECUTE FUNCTION public.validate_quote_provider();
DROP TRIGGER IF EXISTS validate_payout_payee_trigger ON public.payouts;
CREATE TRIGGER validate_payout_payee_trigger BEFORE INSERT OR UPDATE ON public.payouts FOR EACH ROW EXECUTE FUNCTION public.validate_payout_payee();
DROP TRIGGER IF EXISTS trigger_update_rating_avg ON public.reviews;
CREATE TRIGGER trigger_update_rating_avg AFTER INSERT OR UPDATE OR DELETE ON public.reviews FOR EACH ROW EXECUTE FUNCTION public.update_rating_avg();
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- RLS & Policies de base (Sécurisé pour le trigger d'inscription)
DO $$ DECLARE tbl TEXT;
BEGIN
    FOR tbl IN SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_type = 'BASE TABLE' AND table_name NOT IN ('schema_migrations', 'spatial_ref_sys')
    LOOP EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY', tbl);
    END LOOP;
END $$;

CREATE POLICY "notifications_select" ON public.notifications FOR SELECT USING (user_id = auth.uid());
CREATE POLICY "notifications_update" ON public.notifications FOR UPDATE USING (user_id = auth.uid());
CREATE POLICY "notifications_insert" ON public.notifications FOR INSERT WITH CHECK (false);

CREATE POLICY "profiles_insert" ON public.suppliers FOR INSERT WITH CHECK (user_id = auth.uid() OR current_user IN ('postgres', 'authenticator'));
CREATE POLICY "profiles_select" ON public.suppliers FOR SELECT USING (public.is_admin() OR user_id = auth.uid());
CREATE POLICY "profiles_update" ON public.suppliers FOR UPDATE USING (public.is_admin() OR user_id = auth.uid());

CREATE POLICY "profiles_insert" ON public.carriers_dz FOR INSERT WITH CHECK (user_id = auth.uid() OR current_user IN ('postgres', 'authenticator'));
CREATE POLICY "profiles_select" ON public.carriers_dz FOR SELECT USING (public.is_admin() OR user_id = auth.uid());
CREATE POLICY "profiles_update" ON public.carriers_dz FOR UPDATE USING (public.is_admin() OR user_id = auth.uid());

CREATE POLICY "profiles_insert" ON public.carriers_eu FOR INSERT WITH CHECK (user_id = auth.uid() OR current_user IN ('postgres', 'authenticator'));
CREATE POLICY "profiles_select" ON public.carriers_eu FOR SELECT USING (public.is_admin() OR user_id = auth.uid());
CREATE POLICY "profiles_update" ON public.carriers_eu FOR UPDATE USING (public.is_admin() OR user_id = auth.uid());

CREATE POLICY "profiles_insert" ON public.freight_forwarders FOR INSERT WITH CHECK (user_id = auth.uid() OR current_user IN ('postgres', 'authenticator'));
CREATE POLICY "profiles_select" ON public.freight_forwarders FOR SELECT USING (public.is_admin() OR user_id = auth.uid());
CREATE POLICY "profiles_update" ON public.freight_forwarders FOR UPDATE USING (public.is_admin() OR user_id = auth.uid());

CREATE POLICY "profiles_insert" ON public.buyers_eu FOR INSERT WITH CHECK (user_id = auth.uid() OR current_user IN ('postgres', 'authenticator'));
CREATE POLICY "profiles_select" ON public.buyers_eu FOR SELECT USING (public.is_admin() OR user_id = auth.uid());
CREATE POLICY "profiles_update" ON public.buyers_eu FOR UPDATE USING (public.is_admin() OR user_id = auth.uid());

CREATE POLICY "products_public_read" ON public.products_catalog FOR SELECT USING (true);
CREATE POLICY "products_manage" ON public.products_catalog FOR ALL USING (public.is_admin() OR supplier_id IN (SELECT id FROM public.suppliers WHERE user_id = auth.uid()));
CREATE POLICY "orders_select" ON public.orders FOR SELECT USING (public.is_admin() OR buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid()));
CREATE POLICY "orders_insert" ON public.orders FOR INSERT WITH CHECK (public.is_admin() OR buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid()));
CREATE POLICY "orders_update" ON public.orders FOR UPDATE USING (public.is_admin() OR (buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid()) AND status IN ('draft', 'quotes_requested', 'quotes_received')));
CREATE POLICY "orders_delete" ON public.orders FOR DELETE USING (public.is_admin());
CREATE POLICY "items_select" ON public.order_items FOR SELECT USING (public.is_admin() OR order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())) OR supplier_id IN (SELECT id FROM public.suppliers WHERE user_id = auth.uid()));
CREATE POLICY "items_manage" ON public.order_items FOR ALL USING (public.is_admin() OR order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid()) AND status IN ('draft', 'quotes_requested', 'quotes_received')));
CREATE POLICY "qr_select" ON public.quote_requests FOR SELECT USING (public.is_admin() OR order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())) OR supplier_id IN (SELECT id FROM public.suppliers WHERE user_id = auth.uid()) OR status = 'open');
CREATE POLICY "qr_insert" ON public.quote_requests FOR INSERT WITH CHECK (public.is_admin() OR order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())));
CREATE POLICY "qr_update" ON public.quote_requests FOR UPDATE USING (public.is_admin() OR (order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())) AND status IN ('open', 'quoted')));
CREATE POLICY "qr_delete" ON public.quote_requests FOR DELETE USING (public.is_admin());
CREATE POLICY "quotes_select" ON public.quotes FOR SELECT USING (public.is_admin() OR public.is_current_user_actor(provider_type, provider_id) OR quote_request_id IN (SELECT id FROM public.quote_requests WHERE order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())) OR supplier_id IN (SELECT id FROM public.suppliers WHERE user_id = auth.uid())));
CREATE POLICY "quotes_insert" ON public.quotes FOR INSERT WITH CHECK (public.is_admin() OR public.is_current_user_actor(provider_type, provider_id));
CREATE POLICY "quotes_update" ON public.quotes FOR UPDATE USING ((public.is_current_user_actor(provider_type, provider_id) AND status = 'pending') OR public.is_admin());
CREATE POLICY "quotes_delete" ON public.quotes FOR DELETE USING ((public.is_current_user_actor(provider_type, provider_id) AND status = 'pending') OR public.is_admin());
CREATE POLICY "payments_select" ON public.payments FOR SELECT USING (public.is_admin() OR order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())));
CREATE POLICY "payouts_admin_only" ON public.payouts FOR ALL USING (public.is_admin());
CREATE POLICY "docs_select" ON public.documents FOR SELECT USING (public.is_admin() OR order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())) OR uploaded_by = auth.uid() OR visible_to @> '["admin"]'::jsonb OR visible_to @> to_jsonb(auth.uid()::text));
CREATE POLICY "docs_insert" ON public.documents FOR INSERT WITH CHECK (public.is_admin() OR uploaded_by = auth.uid());
CREATE POLICY "docs_update" ON public.documents FOR UPDATE USING (public.is_admin() OR uploaded_by = auth.uid());
CREATE POLICY "docs_delete" ON public.documents FOR DELETE USING (public.is_admin());
CREATE POLICY "reviews_select" ON public.reviews FOR SELECT USING (public.is_admin() OR order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())) OR public.is_current_user_actor(target_type, target_id));
CREATE POLICY "reviews_insert" ON public.reviews FOR INSERT WITH CHECK (public.is_admin() OR order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())));
CREATE POLICY "conv_select" ON public.conversations FOR SELECT USING (public.is_admin() OR id IN (SELECT conversation_id FROM public.conversation_participants WHERE user_id = auth.uid()));
CREATE POLICY "conv_insert" ON public.conversations FOR INSERT WITH CHECK (public.is_admin() OR (order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid()))) OR (order_id IN (SELECT order_id FROM public.order_items WHERE supplier_id IN (SELECT id FROM public.suppliers WHERE user_id = auth.uid()))));
CREATE POLICY "part_select" ON public.conversation_participants FOR SELECT USING (public.is_admin() OR user_id = auth.uid());
CREATE POLICY "part_insert" ON public.conversation_participants FOR INSERT WITH CHECK (public.is_admin() OR conversation_id IN (SELECT id FROM public.conversations WHERE order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())) OR order_id IN (SELECT order_id FROM public.order_items WHERE supplier_id IN (SELECT id FROM public.suppliers WHERE user_id = auth.uid()))));
CREATE POLICY "msg_select" ON public.chat_messages FOR SELECT USING (public.is_admin() OR conversation_id IN (SELECT conversation_id FROM public.conversation_participants WHERE user_id = auth.uid()));
CREATE POLICY "msg_insert" ON public.chat_messages FOR INSERT WITH CHECK (public.is_admin() OR conversation_id IN (SELECT conversation_id FROM public.conversation_participants WHERE user_id = auth.uid()));
CREATE POLICY "rates_public_read" ON public.exchange_rates FOR SELECT USING (true);