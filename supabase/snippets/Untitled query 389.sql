-- =========================================================
-- RLS PRODUCTION V4 — Algérie B2B Export Network
-- =========================================================

-- ---------- 1. FONCTIONS D'AIDE ----------
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN
LANGUAGE plpgsql STABLE SECURITY DEFINER
SET search_path = public, pg_temp
AS $$ BEGIN
    RETURN (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin';
END;
 $$;

CREATE OR REPLACE FUNCTION public.is_current_user_actor(p_type TEXT, p_id UUID)
RETURNS BOOLEAN
LANGUAGE plpgsql STABLE SECURITY DEFINER
SET search_path = public, pg_temp
AS $$ BEGIN
    RETURN (
        (p_type = 'carrier_dz' AND EXISTS (SELECT 1 FROM public.carriers_dz WHERE id = p_id AND user_id = auth.uid())) OR
        (p_type = 'freight_forwarder' AND EXISTS (SELECT 1 FROM public.freight_forwarders WHERE id = p_id AND user_id = auth.uid())) OR
        (p_type = 'carrier_eu' AND EXISTS (SELECT 1 FROM public.carriers_eu WHERE id = p_id AND user_id = auth.uid())) OR
        (p_type = 'supplier' AND EXISTS (SELECT 1 FROM public.suppliers WHERE id = p_id AND user_id = auth.uid()))
    );
END;
 $$;

-- ---------- 2. VUE PUBLIQUE POUR LES DEVIS ----------
CREATE OR REPLACE VIEW public.provider_directory AS
SELECT 
    'carrier_dz' AS provider_type, id, company_name, city, wilaya AS region, rating_avg
FROM public.carriers_dz WHERE active = true
UNION ALL
SELECT 
    'freight_forwarder' AS provider_type, id, company_name, city, country AS region, rating_avg
FROM public.freight_forwarders WHERE active = true
UNION ALL
SELECT 
    'carrier_eu' AS provider_type, id, company_name, city, country AS region, rating_avg
FROM public.carriers_eu WHERE active = true;

GRANT SELECT ON public.provider_directory TO anon, authenticated;

-- ---------- 3. NETTOYAGE DES ANCIENNES POLICIES ----------
DO $$ 
DECLARE tbl TEXT;
BEGIN
    FOR tbl IN SELECT table_name FROM information_schema.tables 
               WHERE table_schema = 'public' AND table_type = 'BASE TABLE' 
               AND table_name NOT IN ('schema_migrations', 'spatial_ref_sys')
    LOOP
        EXECUTE format('DROP POLICY IF EXISTS "dev_full_access" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "anon_read_only" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "profiles_select" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "profiles_update" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "profiles_insert" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "products_public_read" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "products_manage" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "orders_select" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "orders_insert" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "orders_update" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "orders_delete" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "items_select" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "items_manage" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "qr_select" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "qr_insert" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "qr_update" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "qr_delete" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "quotes_select" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "quotes_insert" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "quotes_update" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "quotes_delete" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "payments_select" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "payouts_admin_only" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "docs_select" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "docs_insert" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "docs_update" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "docs_delete" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "reviews_select" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "reviews_insert" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "conv_select" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "conv_insert" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "part_select" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "part_insert" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "msg_select" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "msg_insert" ON public.%I', tbl);
        EXECUTE format('DROP POLICY IF EXISTS "rates_public_read" ON public.%I', tbl);
    END LOOP;
END $$;

-- ---------- 4. PROFILS ----------
CREATE POLICY "profiles_insert" ON public.suppliers FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "profiles_select" ON public.suppliers FOR SELECT USING (public.is_admin() OR user_id = auth.uid());
CREATE POLICY "profiles_update" ON public.suppliers FOR UPDATE USING (public.is_admin() OR user_id = auth.uid());

CREATE POLICY "profiles_insert" ON public.carriers_dz FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "profiles_select" ON public.carriers_dz FOR SELECT USING (public.is_admin() OR user_id = auth.uid());
CREATE POLICY "profiles_update" ON public.carriers_dz FOR UPDATE USING (public.is_admin() OR user_id = auth.uid());

CREATE POLICY "profiles_insert" ON public.carriers_eu FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "profiles_select" ON public.carriers_eu FOR SELECT USING (public.is_admin() OR user_id = auth.uid());
CREATE POLICY "profiles_update" ON public.carriers_eu FOR UPDATE USING (public.is_admin() OR user_id = auth.uid());

CREATE POLICY "profiles_insert" ON public.freight_forwarders FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "profiles_select" ON public.freight_forwarders FOR SELECT USING (public.is_admin() OR user_id = auth.uid());
CREATE POLICY "profiles_update" ON public.freight_forwarders FOR UPDATE USING (public.is_admin() OR user_id = auth.uid());

CREATE POLICY "profiles_insert" ON public.buyers_eu FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "profiles_select" ON public.buyers_eu FOR SELECT USING (public.is_admin() OR user_id = auth.uid());
CREATE POLICY "profiles_update" ON public.buyers_eu FOR UPDATE USING (public.is_admin() OR user_id = auth.uid());

-- ---------- 5. CATALOGUE PRODUITS ----------
CREATE POLICY "products_public_read" ON public.products_catalog FOR SELECT USING (true);
CREATE POLICY "products_manage" ON public.products_catalog FOR ALL USING (
    public.is_admin() OR supplier_id IN (SELECT id FROM public.suppliers WHERE user_id = auth.uid())
);

-- ---------- 6. COMMANDES ----------
CREATE POLICY "orders_select" ON public.orders FOR SELECT USING (
    public.is_admin() OR
    buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid()) OR
    id IN (SELECT order_id FROM public.order_items WHERE supplier_id IN (SELECT id FROM public.suppliers WHERE user_id = auth.uid())) OR
    id IN (SELECT qr.order_id FROM public.quotes q JOIN public.quote_requests qr ON q.quote_request_id = qr.id WHERE q.status = 'selected' AND public.is_current_user_actor(q.provider_type, q.provider_id))
);

CREATE POLICY "orders_insert" ON public.orders FOR INSERT WITH CHECK (
    public.is_admin() OR buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())
);

CREATE POLICY "orders_update" ON public.orders FOR UPDATE USING (
    public.is_admin() OR
    (buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid()) AND status IN ('draft', 'quotes_requested', 'quotes_received'))
);

CREATE POLICY "orders_delete" ON public.orders FOR DELETE USING (public.is_admin());

-- ---------- 7. LIGNES DE COMMANDE ----------
CREATE POLICY "items_select" ON public.order_items FOR SELECT USING (
    public.is_admin() OR
    order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())) OR
    supplier_id IN (SELECT id FROM public.suppliers WHERE user_id = auth.uid())
);

CREATE POLICY "items_manage" ON public.order_items FOR ALL USING (
    public.is_admin() OR 
    order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid()) AND status IN ('draft', 'quotes_requested', 'quotes_received'))
);

-- ---------- 8. DEVIS LOGISTIQUE ----------
CREATE POLICY "qr_select" ON public.quote_requests FOR SELECT USING (
    public.is_admin() OR
    order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())) OR
    supplier_id IN (SELECT id FROM public.suppliers WHERE user_id = auth.uid()) OR
    status = 'open'
);

CREATE POLICY "qr_insert" ON public.quote_requests FOR INSERT WITH CHECK (
    public.is_admin() OR order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid()))
);

CREATE POLICY "qr_update" ON public.quote_requests FOR UPDATE USING (
    public.is_admin() OR
    (order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())) AND status IN ('open', 'quoted'))
);

CREATE POLICY "qr_delete" ON public.quote_requests FOR DELETE USING (public.is_admin());

CREATE POLICY "quotes_select" ON public.quotes FOR SELECT USING (
    public.is_admin() OR
    public.is_current_user_actor(provider_type, provider_id) OR
    quote_request_id IN (SELECT id FROM public.quote_requests WHERE order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())) OR supplier_id IN (SELECT id FROM public.suppliers WHERE user_id = auth.uid()))
);

-- Verrouillage strict des devis par statut
CREATE POLICY "quotes_insert" ON public.quotes FOR INSERT WITH CHECK (
    public.is_admin() OR public.is_current_user_actor(provider_type, provider_id)
);

CREATE POLICY "quotes_update" ON public.quotes FOR UPDATE USING (
    (public.is_current_user_actor(provider_type, provider_id) AND status = 'pending') OR
    public.is_admin()
);

CREATE POLICY "quotes_delete" ON public.quotes FOR DELETE USING (
    (public.is_current_user_actor(provider_type, provider_id) AND status = 'pending') OR
    public.is_admin()
);

-- ---------- 9. PAIEMENTS & REVERSEMENTS ----------
CREATE POLICY "payments_select" ON public.payments FOR SELECT USING (public.is_admin() OR order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())));
CREATE POLICY "payouts_admin_only" ON public.payouts FOR ALL USING (public.is_admin());

-- ---------- 10. DOCUMENTS ----------
CREATE POLICY "docs_select" ON public.documents FOR SELECT USING (
    public.is_admin() OR
    order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())) OR
    uploaded_by = auth.uid() OR
    visible_to @> '["admin"]'::jsonb OR visible_to @> to_jsonb(auth.uid()::text)
);

CREATE POLICY "docs_insert" ON public.documents FOR INSERT WITH CHECK (public.is_admin() OR uploaded_by = auth.uid());
CREATE POLICY "docs_update" ON public.documents FOR UPDATE USING (public.is_admin() OR uploaded_by = auth.uid());
CREATE POLICY "docs_delete" ON public.documents FOR DELETE USING (public.is_admin());

-- ---------- 11. AVIS ----------
CREATE POLICY "reviews_select" ON public.reviews FOR SELECT USING (
    public.is_admin() OR
    order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())) OR
    public.is_current_user_actor(target_type, target_id)
);

CREATE POLICY "reviews_insert" ON public.reviews FOR INSERT WITH CHECK (
    public.is_admin() OR order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid()))
);

-- ---------- 12. MESSAGERIE ----------
CREATE POLICY "conv_select" ON public.conversations FOR SELECT USING (public.is_admin() OR id IN (SELECT conversation_id FROM public.conversation_participants WHERE user_id = auth.uid()));

CREATE POLICY "conv_insert" ON public.conversations FOR INSERT WITH CHECK (
    public.is_admin() OR
    (order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid()))) OR
    (order_id IN (SELECT order_id FROM public.order_items WHERE supplier_id IN (SELECT id FROM public.suppliers WHERE user_id = auth.uid())))
);

CREATE POLICY "part_select" ON public.conversation_participants FOR SELECT USING (public.is_admin() OR user_id = auth.uid());

CREATE POLICY "part_insert" ON public.conversation_participants FOR INSERT WITH CHECK (
    public.is_admin() OR
    conversation_id IN (SELECT id FROM public.conversations WHERE 
        order_id IN (SELECT id FROM public.orders WHERE buyer_id IN (SELECT id FROM public.buyers_eu WHERE user_id = auth.uid())) OR
        order_id IN (SELECT order_id FROM public.order_items WHERE supplier_id IN (SELECT id FROM public.suppliers WHERE user_id = auth.uid()))
    )
);

CREATE POLICY "msg_select" ON public.chat_messages FOR SELECT USING (public.is_admin() OR conversation_id IN (SELECT conversation_id FROM public.conversation_participants WHERE user_id = auth.uid()));

CREATE POLICY "msg_insert" ON public.chat_messages FOR INSERT WITH CHECK (public.is_admin() OR conversation_id IN (SELECT conversation_id FROM public.conversation_participants WHERE user_id = auth.uid()));

-- ---------- 13. TAUX DE CHANGE ----------
CREATE POLICY "rates_public_read" ON public.exchange_rates FOR SELECT USING (true);