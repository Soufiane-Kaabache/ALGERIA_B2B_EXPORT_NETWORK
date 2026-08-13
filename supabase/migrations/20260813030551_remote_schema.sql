create extension if not exists "pg_cron" with schema "pg_catalog";

drop policy "items_manage" on "public"."order_items";

drop policy "orders_insert" on "public"."orders";

drop policy "orders_select" on "public"."orders";

drop policy "orders_update" on "public"."orders";

drop policy "payments_select" on "public"."payments";

drop policy "qr_update" on "public"."quote_requests";

drop policy "quotes_insert" on "public"."quotes";

drop policy "quotes_select" on "public"."quotes";

drop policy "quotes_update" on "public"."quotes";

drop policy "reviews_insert" on "public"."reviews";

drop policy "reviews_select" on "public"."reviews";

alter type "public"."app_role" rename to "app_role__old_version_to_be_dropped";

create type "public"."app_role" as enum ('admin', 'moderator', 'support', 'supplier', 'carrier_dz', 'carrier_eu', 'freight_forwarder', 'delivery_company', 'buyer_eu', 'finance', 'kyc_officer', 'logistics', 'catalog_manager', 'developer');

alter type "public"."notification_type" rename to "notification_type__old_version_to_be_dropped";

create type "public"."notification_type" as enum ('new_message', 'new_quote_request', 'quote_response', 'status_change', 'new_review', 'subscription_alert', 'transport_request', 'transit_request', 'kyc_approved', 'kyc_rejected', 'system', 'document_expiring');

alter type "public"."order_status" rename to "order_status__old_version_to_be_dropped";

create type "public"."order_status" as enum ('confirmed', 'preparing', 'ready_to_ship', 'shipped', 'delivered', 'cancelled', 'disputed', 'draft', 'quotes_requested', 'quotes_received');

alter type "public"."quote_status" rename to "quote_status__old_version_to_be_dropped";

create type "public"."quote_status" as enum ('sent', 'seen', 'answered', 'cancelled', 'expired', 'open', 'quoted');


  create table "public"."audit_logs" (
    "id" uuid not null default gen_random_uuid(),
    "table_name" text not null,
    "record_id" uuid not null,
    "action" text not null,
    "old_data" jsonb,
    "new_data" jsonb,
    "changed_by" uuid,
    "changed_at" timestamp with time zone not null default now()
      );


alter table "public"."audit_logs" enable row level security;


  create table "public"."company_contacts" (
    "id" uuid not null default gen_random_uuid(),
    "entity_type" character varying(50) not null,
    "entity_id" uuid not null,
    "contact_type" public.contact_type not null default 'other'::public.contact_type,
    "full_name" character varying(150) not null,
    "email" character varying(150),
    "phone" character varying(50),
    "is_primary" boolean not null default false,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now(),
    "deleted_at" timestamp with time zone
      );


alter table "public"."company_contacts" enable row level security;


  create table "public"."shipments" (
    "id" uuid not null default gen_random_uuid(),
    "order_id" uuid not null,
    "transport_mode" public.transport_mode not null,
    "package_type" public.package_type,
    "incoterm" public.incoterm_type,
    "status" public.shipment_status not null default 'preparing'::public.shipment_status,
    "carrier_type" character varying(50),
    "carrier_id" uuid,
    "tracking_number" character varying(100),
    "origin_location" text,
    "destination_location" text,
    "departed_at" timestamp with time zone,
    "arrived_at" timestamp with time zone,
    "delivered_at" timestamp with time zone,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now()
      );


alter table "public"."shipments" enable row level security;


  create table "public"."subscriptions" (
    "id" uuid not null default gen_random_uuid(),
    "entity_type" character varying(50) not null,
    "entity_id" uuid not null,
    "plan" public.subscription_plan not null default 'free'::public.subscription_plan,
    "status" public.sub_status not null default 'active'::public.sub_status,
    "billing_cycle" character varying(20) not null default 'monthly'::character varying,
    "amount_eur" numeric not null,
    "payment_method" public.payment_method,
    "stripe_subscription_id" text,
    "current_period_start" date,
    "current_period_end" date,
    "cancelled_at" timestamp with time zone,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now()
      );


alter table "public"."subscriptions" enable row level security;


  create table "public"."transactions" (
    "id" uuid not null default gen_random_uuid(),
    "type" public.transaction_type not null,
    "status" public.transaction_status not null default 'pending'::public.transaction_status,
    "amount_eur" numeric not null,
    "currency" character varying(3) not null default 'EUR'::character varying,
    "related_order_id" uuid,
    "related_subscription_id" uuid,
    "related_payout_id" uuid,
    "payment_method" public.payment_method,
    "stripe_reference" text,
    "notes" text,
    "created_at" timestamp with time zone default now()
      );


alter table "public"."transactions" enable row level security;


  create table "public"."vehicles" (
    "id" uuid not null default gen_random_uuid(),
    "carrier_type" character varying(50) not null,
    "carrier_id" uuid not null,
    "plate_number" character varying(50) not null,
    "vehicle_type" character varying(50),
    "capacity_kg" numeric,
    "is_refrigerated" boolean not null default false,
    "active" boolean not null default true,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now(),
    "deleted_at" timestamp with time zone
      );


alter table "public"."vehicles" enable row level security;

alter table "public"."user_roles" alter column role type "public"."app_role" using role::text::"public"."app_role";

drop type "public"."app_role__old_version_to_be_dropped";

drop type "public"."notification_type__old_version_to_be_dropped";

drop type "public"."order_status__old_version_to_be_dropped";

drop type "public"."quote_status__old_version_to_be_dropped";

alter table "public"."buyers_eu" add column "business_status" public.business_status not null default 'active'::public.business_status;

alter table "public"."buyers_eu" add column "deleted_at" timestamp with time zone;

alter table "public"."buyers_eu" add column "legal_form" public.legal_form;

alter table "public"."carriers_dz" drop column "wilaya";

alter table "public"."carriers_dz" add column "business_status" public.business_status not null default 'active'::public.business_status;

alter table "public"."carriers_dz" add column "deleted_at" timestamp with time zone;

alter table "public"."carriers_dz" add column "legal_form" public.legal_form;

alter table "public"."carriers_dz" add column "wilaya_code" character varying;

alter table "public"."carriers_eu" add column "business_status" public.business_status not null default 'active'::public.business_status;

alter table "public"."carriers_eu" add column "deleted_at" timestamp with time zone;

alter table "public"."carriers_eu" add column "legal_form" public.legal_form;

alter table "public"."delivery_companies" add column "business_status" public.business_status not null default 'active'::public.business_status;

alter table "public"."delivery_companies" add column "deleted_at" timestamp with time zone;

alter table "public"."delivery_companies" add column "legal_form" public.legal_form;

alter table "public"."freight_forwarders" add column "business_status" public.business_status not null default 'active'::public.business_status;

alter table "public"."freight_forwarders" add column "deleted_at" timestamp with time zone;

alter table "public"."freight_forwarders" add column "legal_form" public.legal_form;

alter table "public"."kyc_documents" add column "document_number" character varying(100);

alter table "public"."kyc_documents" add column "expiry_date" date;

alter table "public"."orders" add column "deleted_at" timestamp with time zone;

alter table "public"."orders" alter column "status" set default 'draft'::public.order_status;

alter table "public"."orders" alter column "status" set data type public.order_status using "status"::public.order_status;

alter table "public"."products_catalog" add column "deleted_at" timestamp with time zone;

alter table "public"."products_catalog" add column "status" public.product_status not null default 'published'::public.product_status;

alter table "public"."quote_requests" alter column "status" set default 'open'::public.quote_status;

alter table "public"."quote_requests" alter column "status" set data type public.quote_status using "status"::public.quote_status;

alter table "public"."quotes" alter column "status" set default 'pending'::public.quote_response_status;

alter table "public"."quotes" alter column "status" set data type public.quote_response_status using "status"::public.quote_response_status;

alter table "public"."reviews" add column "status" public.review_status not null default 'published'::public.review_status;

alter table "public"."suppliers" drop column "wilaya";

alter table "public"."suppliers" add column "business_status" public.business_status not null default 'active'::public.business_status;

alter table "public"."suppliers" add column "deleted_at" timestamp with time zone;

alter table "public"."suppliers" add column "legal_form" public.legal_form;

alter table "public"."suppliers" add column "wilaya_code" character varying;

CREATE UNIQUE INDEX audit_logs_pkey ON public.audit_logs USING btree (id);

CREATE UNIQUE INDEX company_contacts_pkey ON public.company_contacts USING btree (id);

CREATE INDEX idx_audit_logs_changed_at ON public.audit_logs USING btree (changed_at DESC);

CREATE INDEX idx_audit_logs_changed_by ON public.audit_logs USING btree (changed_by);

CREATE INDEX idx_audit_logs_table_record ON public.audit_logs USING btree (table_name, record_id);

CREATE INDEX idx_buyers_eu_active ON public.buyers_eu USING btree (active) WHERE ((active = true) AND (deleted_at IS NULL));

CREATE INDEX idx_carriers_dz_active ON public.carriers_dz USING btree (active) WHERE ((active = true) AND (deleted_at IS NULL));

CREATE INDEX idx_carriers_dz_kyc_status ON public.carriers_dz USING btree (kyc_status);

CREATE INDEX idx_carriers_dz_wilaya_code ON public.carriers_dz USING btree (wilaya_code);

CREATE INDEX idx_carriers_dz_zones ON public.carriers_dz USING gin (zones_covered);

CREATE INDEX idx_carriers_eu_active ON public.carriers_eu USING btree (active) WHERE ((active = true) AND (deleted_at IS NULL));

CREATE INDEX idx_carriers_eu_linked_buyer ON public.carriers_eu USING btree (linked_buyer_id);

CREATE INDEX idx_carriers_eu_zones ON public.carriers_eu USING gin (zones_covered);

CREATE INDEX idx_chat_messages_conv ON public.chat_messages USING btree (conversation_id, created_at DESC);

CREATE INDEX idx_company_contacts_entity ON public.company_contacts USING btree (entity_type, entity_id);

CREATE INDEX idx_conv_participants_conv ON public.conversation_participants USING btree (conversation_id);

CREATE INDEX idx_conversations_order ON public.conversations USING btree (order_id);

CREATE INDEX idx_delivery_companies_active ON public.delivery_companies USING btree (active) WHERE ((active = true) AND (deleted_at IS NULL));

CREATE INDEX idx_delivery_companies_user_id ON public.delivery_companies USING btree (user_id);

CREATE INDEX idx_documents_type ON public.documents USING btree (doc_type);

CREATE INDEX idx_exchange_rates_pair_date ON public.exchange_rates USING btree (currency_from, currency_to, rate_date DESC);

CREATE INDEX idx_freight_forwarders_active ON public.freight_forwarders USING btree (active) WHERE ((active = true) AND (deleted_at IS NULL));

CREATE INDEX idx_freight_forwarders_ports ON public.freight_forwarders USING gin (ports_covered);

CREATE INDEX idx_kyc_docs_entity ON public.kyc_documents USING btree (entity_type, entity_id);

CREATE INDEX idx_kyc_docs_status ON public.kyc_documents USING btree (status);

CREATE INDEX idx_notifications_user_read ON public.notifications USING btree (user_id, read, created_at DESC);

CREATE INDEX idx_order_items_product ON public.order_items USING btree (product_id);

CREATE INDEX idx_order_items_supplier ON public.order_items USING btree (supplier_id);

CREATE INDEX idx_orders_buyer_status ON public.orders USING btree (buyer_id, status);

CREATE INDEX idx_orders_created_at ON public.orders USING btree (created_at DESC);

CREATE INDEX idx_orders_not_deleted ON public.orders USING btree (buyer_id, status) WHERE (deleted_at IS NULL);

CREATE INDEX idx_orders_status ON public.orders USING btree (status);

CREATE INDEX idx_payments_status ON public.payments USING btree (status);

CREATE INDEX idx_payments_stripe ON public.payments USING btree (stripe_payment_id);

CREATE INDEX idx_payouts_payee ON public.payouts USING btree (payee_type, payee_id);

CREATE INDEX idx_payouts_status ON public.payouts USING btree (status);

CREATE INDEX idx_products_active_status ON public.products_catalog USING btree (active, status) WHERE ((active = true) AND (deleted_at IS NULL));

CREATE INDEX idx_products_catalog_status ON public.products_catalog USING btree (status);

CREATE INDEX idx_products_category ON public.products_catalog USING btree (category);

CREATE INDEX idx_products_not_deleted ON public.products_catalog USING btree (supplier_id, active) WHERE (deleted_at IS NULL);

CREATE INDEX idx_quote_requests_order ON public.quote_requests USING btree (order_id);

CREATE INDEX idx_quote_requests_status ON public.quote_requests USING btree (status);

CREATE INDEX idx_quote_requests_supplier ON public.quote_requests USING btree (supplier_id);

CREATE INDEX idx_quotes_provider ON public.quotes USING btree (provider_type, provider_id);

CREATE INDEX idx_quotes_status ON public.quotes USING btree (status);

CREATE INDEX idx_reviews_order ON public.reviews USING btree (order_id);

CREATE INDEX idx_reviews_status ON public.reviews USING btree (status);

CREATE INDEX idx_shipments_carrier ON public.shipments USING btree (carrier_type, carrier_id);

CREATE INDEX idx_shipments_order ON public.shipments USING btree (order_id);

CREATE INDEX idx_shipments_order_id ON public.shipments USING btree (order_id);

CREATE INDEX idx_shipments_status ON public.shipments USING btree (status);

CREATE INDEX idx_subscriptions_entity ON public.subscriptions USING btree (entity_type, entity_id);

CREATE INDEX idx_subscriptions_status ON public.subscriptions USING btree (status);

CREATE INDEX idx_suppliers_active ON public.suppliers USING btree (active) WHERE ((active = true) AND (deleted_at IS NULL));

CREATE INDEX idx_suppliers_kyc_status ON public.suppliers USING btree (kyc_status);

CREATE INDEX idx_suppliers_not_deleted ON public.suppliers USING btree (id) WHERE (deleted_at IS NULL);

CREATE INDEX idx_suppliers_product_categories ON public.suppliers USING gin (product_categories);

CREATE INDEX idx_suppliers_wilaya_code ON public.suppliers USING btree (wilaya_code);

CREATE INDEX idx_transactions_order ON public.transactions USING btree (related_order_id);

CREATE INDEX idx_transactions_status ON public.transactions USING btree (status);

CREATE INDEX idx_transactions_subscription ON public.transactions USING btree (related_subscription_id);

CREATE INDEX idx_transactions_type ON public.transactions USING btree (type);

CREATE INDEX idx_user_roles_role ON public.user_roles USING btree (role);

CREATE INDEX idx_user_roles_user ON public.user_roles USING btree (user_id);

CREATE INDEX idx_vehicles_active ON public.vehicles USING btree (active) WHERE ((active = true) AND (deleted_at IS NULL));

CREATE INDEX idx_vehicles_carrier ON public.vehicles USING btree (carrier_type, carrier_id);

CREATE UNIQUE INDEX shipments_pkey ON public.shipments USING btree (id);

CREATE UNIQUE INDEX subscriptions_pkey ON public.subscriptions USING btree (id);

CREATE UNIQUE INDEX transactions_pkey ON public.transactions USING btree (id);

CREATE UNIQUE INDEX uq_wilayas_name_fr ON public.wilayas USING btree (name_fr);

CREATE UNIQUE INDEX vehicles_pkey ON public.vehicles USING btree (id);

alter table "public"."audit_logs" add constraint "audit_logs_pkey" PRIMARY KEY using index "audit_logs_pkey";

alter table "public"."company_contacts" add constraint "company_contacts_pkey" PRIMARY KEY using index "company_contacts_pkey";

alter table "public"."shipments" add constraint "shipments_pkey" PRIMARY KEY using index "shipments_pkey";

alter table "public"."subscriptions" add constraint "subscriptions_pkey" PRIMARY KEY using index "subscriptions_pkey";

alter table "public"."transactions" add constraint "transactions_pkey" PRIMARY KEY using index "transactions_pkey";

alter table "public"."vehicles" add constraint "vehicles_pkey" PRIMARY KEY using index "vehicles_pkey";

alter table "public"."audit_logs" add constraint "audit_logs_action_check" CHECK ((action = ANY (ARRAY['INSERT'::text, 'UPDATE'::text, 'DELETE'::text]))) not valid;

alter table "public"."audit_logs" validate constraint "audit_logs_action_check";

alter table "public"."audit_logs" add constraint "audit_logs_changed_by_fkey" FOREIGN KEY (changed_by) REFERENCES auth.users(id) not valid;

alter table "public"."audit_logs" validate constraint "audit_logs_changed_by_fkey";

alter table "public"."carriers_dz" add constraint "chk_carriers_dz_vehicles_array" CHECK (((vehicle_types IS NULL) OR (jsonb_typeof(vehicle_types) = 'array'::text))) not valid;

alter table "public"."carriers_dz" validate constraint "chk_carriers_dz_vehicles_array";

alter table "public"."carriers_dz" add constraint "chk_carriers_dz_zones_array" CHECK (((zones_covered IS NULL) OR (jsonb_typeof(zones_covered) = 'array'::text))) not valid;

alter table "public"."carriers_dz" validate constraint "chk_carriers_dz_zones_array";

alter table "public"."carriers_dz" add constraint "fk_carriers_dz_wilaya_code" FOREIGN KEY (wilaya_code) REFERENCES public.wilayas(code) not valid;

alter table "public"."carriers_dz" validate constraint "fk_carriers_dz_wilaya_code";

alter table "public"."carriers_eu" add constraint "chk_carriers_eu_vehicles_array" CHECK (((vehicle_types IS NULL) OR (jsonb_typeof(vehicle_types) = 'array'::text))) not valid;

alter table "public"."carriers_eu" validate constraint "chk_carriers_eu_vehicles_array";

alter table "public"."carriers_eu" add constraint "chk_carriers_eu_zones_array" CHECK (((zones_covered IS NULL) OR (jsonb_typeof(zones_covered) = 'array'::text))) not valid;

alter table "public"."carriers_eu" validate constraint "chk_carriers_eu_zones_array";

alter table "public"."delivery_companies" add constraint "chk_delivery_vehicles_array" CHECK (((vehicle_types IS NULL) OR (jsonb_typeof(vehicle_types) = 'array'::text))) not valid;

alter table "public"."delivery_companies" validate constraint "chk_delivery_vehicles_array";

alter table "public"."delivery_companies" add constraint "chk_delivery_zones_array" CHECK (((zones_covered IS NULL) OR (jsonb_typeof(zones_covered) = 'array'::text))) not valid;

alter table "public"."delivery_companies" validate constraint "chk_delivery_zones_array";

alter table "public"."freight_forwarders" add constraint "chk_freight_ports_array" CHECK (((ports_covered IS NULL) OR (jsonb_typeof(ports_covered) = 'array'::text))) not valid;

alter table "public"."freight_forwarders" validate constraint "chk_freight_ports_array";

alter table "public"."freight_forwarders" add constraint "chk_freight_services_array" CHECK (((services IS NULL) OR (jsonb_typeof(services) = 'array'::text))) not valid;

alter table "public"."freight_forwarders" validate constraint "chk_freight_services_array";

alter table "public"."shipments" add constraint "shipments_order_id_fkey" FOREIGN KEY (order_id) REFERENCES public.orders(id) not valid;

alter table "public"."shipments" validate constraint "shipments_order_id_fkey";

alter table "public"."suppliers" add constraint "fk_suppliers_wilaya_code" FOREIGN KEY (wilaya_code) REFERENCES public.wilayas(code) not valid;

alter table "public"."suppliers" validate constraint "fk_suppliers_wilaya_code";

alter table "public"."transactions" add constraint "transactions_related_order_id_fkey" FOREIGN KEY (related_order_id) REFERENCES public.orders(id) not valid;

alter table "public"."transactions" validate constraint "transactions_related_order_id_fkey";

alter table "public"."transactions" add constraint "transactions_related_payout_id_fkey" FOREIGN KEY (related_payout_id) REFERENCES public.payouts(id) not valid;

alter table "public"."transactions" validate constraint "transactions_related_payout_id_fkey";

alter table "public"."transactions" add constraint "transactions_related_subscription_id_fkey" FOREIGN KEY (related_subscription_id) REFERENCES public.subscriptions(id) not valid;

alter table "public"."transactions" validate constraint "transactions_related_subscription_id_fkey";

alter table "public"."wilayas" add constraint "uq_wilayas_name_fr" UNIQUE using index "uq_wilayas_name_fr";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.audit_trigger_func()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  IF TG_OP = 'DELETE' THEN
    INSERT INTO public.audit_logs (table_name, record_id, action, old_data, changed_by)
    VALUES (TG_TABLE_NAME, OLD.id, TG_OP, to_jsonb(OLD), auth.uid());
    RETURN OLD;

  ELSIF TG_OP = 'UPDATE' THEN
    INSERT INTO public.audit_logs (table_name, record_id, action, old_data, new_data, changed_by)
    VALUES (TG_TABLE_NAME, NEW.id, TG_OP, to_jsonb(OLD), to_jsonb(NEW), auth.uid());
    RETURN NEW;

  ELSIF TG_OP = 'INSERT' THEN
    INSERT INTO public.audit_logs (table_name, record_id, action, new_data, changed_by)
    VALUES (TG_TABLE_NAME, NEW.id, TG_OP, to_jsonb(NEW), auth.uid());
    RETURN NEW;
  END IF;

  RETURN NULL;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_buyer_id()
 RETURNS uuid
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
  SELECT id FROM public.buyers_eu WHERE user_id = auth.uid() LIMIT 1;
$function$
;

CREATE OR REPLACE FUNCTION public.get_carrier_dz_id()
 RETURNS uuid
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
  SELECT id FROM public.carriers_dz WHERE user_id = auth.uid() LIMIT 1;
$function$
;

CREATE OR REPLACE FUNCTION public.get_carrier_eu_id()
 RETURNS uuid
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
  SELECT id FROM public.carriers_eu WHERE user_id = auth.uid() LIMIT 1;
$function$
;

CREATE OR REPLACE FUNCTION public.get_delivery_company_id()
 RETURNS uuid
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
  SELECT id FROM public.delivery_companies WHERE user_id = auth.uid() LIMIT 1;
$function$
;

CREATE OR REPLACE FUNCTION public.get_freight_forwarder_id()
 RETURNS uuid
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
  SELECT id FROM public.freight_forwarders WHERE user_id = auth.uid() LIMIT 1;
$function$
;

CREATE OR REPLACE FUNCTION public.get_supplier_id()
 RETURNS uuid
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
  SELECT id FROM public.suppliers WHERE user_id = auth.uid() LIMIT 1;
$function$
;

CREATE OR REPLACE FUNCTION public.handle_updated_at()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.is_catalog_manager()
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM public.user_roles
    WHERE user_id = auth.uid() AND role IN ('admin', 'catalog_manager')
  );
$function$
;

CREATE OR REPLACE FUNCTION public.is_conversation_participant(conv_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM public.conversation_participants
    WHERE conversation_id = conv_id AND user_id = auth.uid()
  );
$function$
;

CREATE OR REPLACE FUNCTION public.is_developer()
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM public.user_roles
    WHERE user_id = auth.uid() AND role IN ('admin', 'developer')
  );
$function$
;

CREATE OR REPLACE FUNCTION public.is_finance()
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM public.user_roles
    WHERE user_id = auth.uid() AND role IN ('admin', 'finance')
  );
$function$
;

CREATE OR REPLACE FUNCTION public.is_kyc_officer()
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM public.user_roles
    WHERE user_id = auth.uid() AND role IN ('admin', 'kyc_officer')
  );
$function$
;

CREATE OR REPLACE FUNCTION public.is_logistics()
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM public.user_roles
    WHERE user_id = auth.uid() AND role IN ('admin', 'logistics')
  );
$function$
;

CREATE OR REPLACE FUNCTION public.is_moderator()
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM public.user_roles
    WHERE user_id = auth.uid() AND role IN ('admin', 'moderator')
  );
$function$
;

CREATE OR REPLACE FUNCTION public.is_order_participant(o_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM public.orders o
    WHERE o.id = o_id AND o.buyer_id = public.get_buyer_id()
  ) OR EXISTS (
    SELECT 1 FROM public.order_items oi
    WHERE oi.order_id = o_id AND oi.supplier_id = public.get_supplier_id()
  ) OR EXISTS (
    SELECT 1 FROM public.quote_requests qr
    WHERE qr.order_id = o_id AND qr.supplier_id = public.get_supplier_id()
  );
$function$
;

CREATE OR REPLACE FUNCTION public.is_support()
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM public.user_roles
    WHERE user_id = auth.uid() AND role IN ('admin', 'support')
  );
$function$
;

CREATE OR REPLACE FUNCTION public.notify_expiring_documents()
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'pg_temp'
AS $function$
BEGIN
  INSERT INTO public.notifications (user_id, title, message, type, link, read)
  SELECT
    owner.user_id,
    'Document bientôt expiré',
    format('Le document "%s" expire le %s', kd.doc_type, to_char(kd.expiry_date, 'DD/MM/YYYY')),
    'document_expiring'::notification_type,
    '/documents/' || kd.id::text,
    false
  FROM public.kyc_documents kd
  CROSS JOIN LATERAL (
    SELECT CASE
      WHEN kd.entity_type = 'vehicle' THEN (
        SELECT CASE v.carrier_type
          WHEN 'carrier_dz' THEN (SELECT c.user_id FROM public.carriers_dz c WHERE c.id = v.carrier_id)
          WHEN 'carrier_eu' THEN (SELECT c.user_id FROM public.carriers_eu c WHERE c.id = v.carrier_id)
          WHEN 'delivery_company' THEN (SELECT d.user_id FROM public.delivery_companies d WHERE d.id = v.carrier_id)
        END
        FROM public.vehicles v WHERE v.id = kd.entity_id
      )
      WHEN kd.entity_type = 'supplier' THEN (SELECT s.user_id FROM public.suppliers s WHERE s.id = kd.entity_id)
      WHEN kd.entity_type = 'carrier_dz' THEN (SELECT c.user_id FROM public.carriers_dz c WHERE c.id = kd.entity_id)
      WHEN kd.entity_type = 'carrier_eu' THEN (SELECT c.user_id FROM public.carriers_eu c WHERE c.id = kd.entity_id)
      WHEN kd.entity_type = 'freight_forwarder' THEN (SELECT f.user_id FROM public.freight_forwarders f WHERE f.id = kd.entity_id)
      WHEN kd.entity_type = 'delivery_company' THEN (SELECT d.user_id FROM public.delivery_companies d WHERE d.id = kd.entity_id)
      WHEN kd.entity_type = 'buyer_eu' THEN (SELECT b.user_id FROM public.buyers_eu b WHERE b.id = kd.entity_id)
    END AS user_id
  ) owner
  WHERE kd.expiry_date IS NOT NULL
    AND kd.status = 'verified'
    AND kd.expiry_date BETWEEN CURRENT_DATE AND (CURRENT_DATE + INTERVAL '30 days')
    AND owner.user_id IS NOT NULL
    AND NOT EXISTS (
      SELECT 1 FROM public.notifications n
      WHERE n.link = '/documents/' || kd.id::text
        AND n.type = 'document_expiring'::notification_type
        AND n.created_at > now() - INTERVAL '7 days'
    );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.trg_validate_contact()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  IF NOT public.validate_polymorphic_ref(NEW.entity_type, NEW.entity_id) THEN
    RAISE EXCEPTION 'Contacts : entity_id (%) introuvable pour le type %', NEW.entity_id, NEW.entity_type;
  END IF;
  RETURN NEW;
END; $function$
;

CREATE OR REPLACE FUNCTION public.trg_validate_kyc()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  IF NOT public.validate_polymorphic_ref(NEW.entity_type, NEW.entity_id) THEN
    RAISE EXCEPTION 'KYC : entity_id (%) introuvable pour le type %', NEW.entity_id, NEW.entity_type;
  END IF;
  RETURN NEW;
END; $function$
;

CREATE OR REPLACE FUNCTION public.trg_validate_payout()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  IF NOT public.validate_polymorphic_ref(NEW.payee_type, NEW.payee_id) THEN
    RAISE EXCEPTION 'Payouts : payee_id (%) introuvable pour le type %', NEW.payee_id, NEW.payee_type;
  END IF;
  RETURN NEW;
END; $function$
;

CREATE OR REPLACE FUNCTION public.trg_validate_quote()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  IF NOT public.validate_polymorphic_ref(NEW.provider_type, NEW.provider_id) THEN
    RAISE EXCEPTION 'Quotes : provider_id (%) introuvable pour le type %', NEW.provider_id, NEW.provider_type;
  END IF;
  RETURN NEW;
END; $function$
;

CREATE OR REPLACE FUNCTION public.trg_validate_review()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  IF NOT public.validate_polymorphic_ref(NEW.target_type, NEW.target_id) THEN
    RAISE EXCEPTION 'Reviews : target_id (%) introuvable pour le type %', NEW.target_id, NEW.target_type;
  END IF;
  RETURN NEW;
END; $function$
;

CREATE OR REPLACE FUNCTION public.trg_validate_shipment()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  IF NEW.carrier_type IS NOT NULL AND NEW.carrier_id IS NOT NULL THEN
    IF NOT public.validate_polymorphic_ref(NEW.carrier_type, NEW.carrier_id) THEN
      RAISE EXCEPTION 'Shipments : carrier_id (%) introuvable pour le type %', NEW.carrier_id, NEW.carrier_type;
    END IF;
  END IF;
  RETURN NEW;
END; $function$
;

CREATE OR REPLACE FUNCTION public.trg_validate_sub()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  IF NOT public.validate_polymorphic_ref(NEW.entity_type, NEW.entity_id) THEN
    RAISE EXCEPTION 'Subscriptions : entity_id (%) introuvable pour le type %', NEW.entity_id, NEW.entity_type;
  END IF;
  RETURN NEW;
END; $function$
;

CREATE OR REPLACE FUNCTION public.trg_validate_vehicle()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  IF NOT public.validate_polymorphic_ref(NEW.carrier_type, NEW.carrier_id) THEN
    RAISE EXCEPTION 'Vehicles : carrier_id (%) introuvable pour le type %', NEW.carrier_id, NEW.carrier_type;
  END IF;
  RETURN NEW;
END; $function$
;

CREATE OR REPLACE FUNCTION public.validate_polymorphic_ref(p_type text, p_id uuid)
 RETURNS boolean
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
  _exists boolean := false;
BEGIN
  IF p_type IS NULL OR p_id IS NULL THEN
    RETURN true; -- Si c'est nullable, on ne bloque pas
  END IF;

  CASE p_type
    WHEN 'supplier' THEN SELECT EXISTS(SELECT 1 FROM public.suppliers WHERE id = p_id) INTO _exists;
    WHEN 'carrier_dz' THEN SELECT EXISTS(SELECT 1 FROM public.carriers_dz WHERE id = p_id) INTO _exists;
    WHEN 'carrier_eu' THEN SELECT EXISTS(SELECT 1 FROM public.carriers_eu WHERE id = p_id) INTO _exists;
    WHEN 'freight_forwarder' THEN SELECT EXISTS(SELECT 1 FROM public.freight_forwarders WHERE id = p_id) INTO _exists;
    WHEN 'delivery_company' THEN SELECT EXISTS(SELECT 1 FROM public.delivery_companies WHERE id = p_id) INTO _exists;
    WHEN 'buyer_eu' THEN SELECT EXISTS(SELECT 1 FROM public.buyers_eu WHERE id = p_id) INTO _exists;
    WHEN 'order' THEN SELECT EXISTS(SELECT 1 FROM public.orders WHERE id = p_id) INTO _exists;
    ELSE
      RAISE EXCEPTION 'Type polymorphe inconnu : %. Types acceptés : supplier, carrier_dz, carrier_eu, freight_forwarder, delivery_company, buyer_eu, order.', p_type;
  END CASE;

  RETURN _exists;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.is_admin()
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM public.user_roles
    WHERE user_id = auth.uid() AND role = 'admin'
  );
$function$
;

CREATE OR REPLACE FUNCTION public.is_current_user_actor(p_type text, p_id uuid)
 RETURNS boolean
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
 SET search_path TO 'public', 'pg_temp'
AS $function$ BEGIN
    RETURN (
        (p_type = 'carrier_dz' AND EXISTS (SELECT 1 FROM public.carriers_dz WHERE id = p_id AND user_id = auth.uid())) OR
        (p_type = 'freight_forwarder' AND EXISTS (SELECT 1 FROM public.freight_forwarders WHERE id = p_id AND user_id = auth.uid())) OR
        (p_type = 'carrier_eu' AND EXISTS (SELECT 1 FROM public.carriers_eu WHERE id = p_id AND user_id = auth.uid())) OR
        (p_type = 'supplier' AND EXISTS (SELECT 1 FROM public.suppliers WHERE id = p_id AND user_id = auth.uid())) OR
        (p_type = 'buyer_eu' AND EXISTS (SELECT 1 FROM public.buyers_eu WHERE id = p_id AND user_id = auth.uid())) OR
        (p_type = 'delivery_company' AND EXISTS (SELECT 1 FROM public.delivery_companies WHERE id = p_id AND user_id = auth.uid()))
    );
END; $function$
;

grant delete on table "public"."audit_logs" to "anon";

grant insert on table "public"."audit_logs" to "anon";

grant references on table "public"."audit_logs" to "anon";

grant select on table "public"."audit_logs" to "anon";

grant trigger on table "public"."audit_logs" to "anon";

grant truncate on table "public"."audit_logs" to "anon";

grant update on table "public"."audit_logs" to "anon";

grant delete on table "public"."audit_logs" to "authenticated";

grant insert on table "public"."audit_logs" to "authenticated";

grant references on table "public"."audit_logs" to "authenticated";

grant select on table "public"."audit_logs" to "authenticated";

grant trigger on table "public"."audit_logs" to "authenticated";

grant truncate on table "public"."audit_logs" to "authenticated";

grant update on table "public"."audit_logs" to "authenticated";

grant delete on table "public"."audit_logs" to "service_role";

grant insert on table "public"."audit_logs" to "service_role";

grant references on table "public"."audit_logs" to "service_role";

grant select on table "public"."audit_logs" to "service_role";

grant trigger on table "public"."audit_logs" to "service_role";

grant truncate on table "public"."audit_logs" to "service_role";

grant update on table "public"."audit_logs" to "service_role";

grant delete on table "public"."company_contacts" to "anon";

grant insert on table "public"."company_contacts" to "anon";

grant references on table "public"."company_contacts" to "anon";

grant select on table "public"."company_contacts" to "anon";

grant trigger on table "public"."company_contacts" to "anon";

grant truncate on table "public"."company_contacts" to "anon";

grant update on table "public"."company_contacts" to "anon";

grant delete on table "public"."company_contacts" to "authenticated";

grant insert on table "public"."company_contacts" to "authenticated";

grant references on table "public"."company_contacts" to "authenticated";

grant select on table "public"."company_contacts" to "authenticated";

grant trigger on table "public"."company_contacts" to "authenticated";

grant truncate on table "public"."company_contacts" to "authenticated";

grant update on table "public"."company_contacts" to "authenticated";

grant delete on table "public"."company_contacts" to "service_role";

grant insert on table "public"."company_contacts" to "service_role";

grant references on table "public"."company_contacts" to "service_role";

grant select on table "public"."company_contacts" to "service_role";

grant trigger on table "public"."company_contacts" to "service_role";

grant truncate on table "public"."company_contacts" to "service_role";

grant update on table "public"."company_contacts" to "service_role";

grant delete on table "public"."shipments" to "anon";

grant insert on table "public"."shipments" to "anon";

grant references on table "public"."shipments" to "anon";

grant select on table "public"."shipments" to "anon";

grant trigger on table "public"."shipments" to "anon";

grant truncate on table "public"."shipments" to "anon";

grant update on table "public"."shipments" to "anon";

grant delete on table "public"."shipments" to "authenticated";

grant insert on table "public"."shipments" to "authenticated";

grant references on table "public"."shipments" to "authenticated";

grant select on table "public"."shipments" to "authenticated";

grant trigger on table "public"."shipments" to "authenticated";

grant truncate on table "public"."shipments" to "authenticated";

grant update on table "public"."shipments" to "authenticated";

grant delete on table "public"."shipments" to "service_role";

grant insert on table "public"."shipments" to "service_role";

grant references on table "public"."shipments" to "service_role";

grant select on table "public"."shipments" to "service_role";

grant trigger on table "public"."shipments" to "service_role";

grant truncate on table "public"."shipments" to "service_role";

grant update on table "public"."shipments" to "service_role";

grant delete on table "public"."subscriptions" to "anon";

grant insert on table "public"."subscriptions" to "anon";

grant references on table "public"."subscriptions" to "anon";

grant select on table "public"."subscriptions" to "anon";

grant trigger on table "public"."subscriptions" to "anon";

grant truncate on table "public"."subscriptions" to "anon";

grant update on table "public"."subscriptions" to "anon";

grant delete on table "public"."subscriptions" to "authenticated";

grant insert on table "public"."subscriptions" to "authenticated";

grant references on table "public"."subscriptions" to "authenticated";

grant select on table "public"."subscriptions" to "authenticated";

grant trigger on table "public"."subscriptions" to "authenticated";

grant truncate on table "public"."subscriptions" to "authenticated";

grant update on table "public"."subscriptions" to "authenticated";

grant delete on table "public"."subscriptions" to "service_role";

grant insert on table "public"."subscriptions" to "service_role";

grant references on table "public"."subscriptions" to "service_role";

grant select on table "public"."subscriptions" to "service_role";

grant trigger on table "public"."subscriptions" to "service_role";

grant truncate on table "public"."subscriptions" to "service_role";

grant update on table "public"."subscriptions" to "service_role";

grant delete on table "public"."transactions" to "anon";

grant insert on table "public"."transactions" to "anon";

grant references on table "public"."transactions" to "anon";

grant select on table "public"."transactions" to "anon";

grant trigger on table "public"."transactions" to "anon";

grant truncate on table "public"."transactions" to "anon";

grant update on table "public"."transactions" to "anon";

grant delete on table "public"."transactions" to "authenticated";

grant insert on table "public"."transactions" to "authenticated";

grant references on table "public"."transactions" to "authenticated";

grant select on table "public"."transactions" to "authenticated";

grant trigger on table "public"."transactions" to "authenticated";

grant truncate on table "public"."transactions" to "authenticated";

grant update on table "public"."transactions" to "authenticated";

grant delete on table "public"."transactions" to "service_role";

grant insert on table "public"."transactions" to "service_role";

grant references on table "public"."transactions" to "service_role";

grant select on table "public"."transactions" to "service_role";

grant trigger on table "public"."transactions" to "service_role";

grant truncate on table "public"."transactions" to "service_role";

grant update on table "public"."transactions" to "service_role";

grant delete on table "public"."vehicles" to "anon";

grant insert on table "public"."vehicles" to "anon";

grant references on table "public"."vehicles" to "anon";

grant select on table "public"."vehicles" to "anon";

grant trigger on table "public"."vehicles" to "anon";

grant truncate on table "public"."vehicles" to "anon";

grant update on table "public"."vehicles" to "anon";

grant delete on table "public"."vehicles" to "authenticated";

grant insert on table "public"."vehicles" to "authenticated";

grant references on table "public"."vehicles" to "authenticated";

grant select on table "public"."vehicles" to "authenticated";

grant trigger on table "public"."vehicles" to "authenticated";

grant truncate on table "public"."vehicles" to "authenticated";

grant update on table "public"."vehicles" to "authenticated";

grant delete on table "public"."vehicles" to "service_role";

grant insert on table "public"."vehicles" to "service_role";

grant references on table "public"."vehicles" to "service_role";

grant select on table "public"."vehicles" to "service_role";

grant trigger on table "public"."vehicles" to "service_role";

grant truncate on table "public"."vehicles" to "service_role";

grant update on table "public"."vehicles" to "service_role";


  create policy "audit_logs_select_dev"
  on "public"."audit_logs"
  as permissive
  for select
  to public
using (public.is_developer());



  create policy "audit_no_delete"
  on "public"."audit_logs"
  as permissive
  for delete
  to public
using (false);



  create policy "audit_no_update"
  on "public"."audit_logs"
  as permissive
  for update
  to public
using (false);



  create policy "audit_no_write"
  on "public"."audit_logs"
  as permissive
  for insert
  to public
with check (false);



  create policy "audit_select_admin"
  on "public"."audit_logs"
  as permissive
  for select
  to public
using (public.is_admin());



  create policy "audit_select_team"
  on "public"."audit_logs"
  as permissive
  for select
  to public
using ((public.is_finance() OR public.is_support() OR public.is_logistics() OR public.is_kyc_officer() OR public.is_catalog_manager() OR public.is_moderator()));



  create policy "buyers_insert"
  on "public"."buyers_eu"
  as permissive
  for insert
  to public
with check ((user_id = auth.uid()));



  create policy "buyers_select"
  on "public"."buyers_eu"
  as permissive
  for select
  to public
using (((id = public.get_buyer_id()) OR public.is_admin()));



  create policy "buyers_select_dev"
  on "public"."buyers_eu"
  as permissive
  for select
  to public
using (public.is_developer());



  create policy "buyers_update"
  on "public"."buyers_eu"
  as permissive
  for update
  to public
using (((id = public.get_buyer_id()) OR public.is_admin()));



  create policy "carriers_dz_insert"
  on "public"."carriers_dz"
  as permissive
  for insert
  to public
with check ((user_id = auth.uid()));



  create policy "carriers_dz_select"
  on "public"."carriers_dz"
  as permissive
  for select
  to public
using (((id = public.get_carrier_dz_id()) OR public.is_admin()));



  create policy "carriers_dz_select_dev"
  on "public"."carriers_dz"
  as permissive
  for select
  to public
using (public.is_developer());



  create policy "carriers_dz_select_kyc"
  on "public"."carriers_dz"
  as permissive
  for select
  to public
using (public.is_kyc_officer());



  create policy "carriers_dz_select_logistics"
  on "public"."carriers_dz"
  as permissive
  for select
  to public
using (public.is_logistics());



  create policy "carriers_dz_update"
  on "public"."carriers_dz"
  as permissive
  for update
  to public
using (((id = public.get_carrier_dz_id()) OR public.is_admin()));



  create policy "carriers_dz_update_kyc"
  on "public"."carriers_dz"
  as permissive
  for update
  to public
using (public.is_kyc_officer());



  create policy "carriers_eu_insert"
  on "public"."carriers_eu"
  as permissive
  for insert
  to public
with check ((user_id = auth.uid()));



  create policy "carriers_eu_select"
  on "public"."carriers_eu"
  as permissive
  for select
  to public
using (((id = public.get_carrier_eu_id()) OR public.is_admin()));



  create policy "carriers_eu_select_dev"
  on "public"."carriers_eu"
  as permissive
  for select
  to public
using (public.is_developer());



  create policy "carriers_eu_select_kyc"
  on "public"."carriers_eu"
  as permissive
  for select
  to public
using (public.is_kyc_officer());



  create policy "carriers_eu_select_logistics"
  on "public"."carriers_eu"
  as permissive
  for select
  to public
using (public.is_logistics());



  create policy "carriers_eu_update"
  on "public"."carriers_eu"
  as permissive
  for update
  to public
using (((id = public.get_carrier_eu_id()) OR public.is_admin()));



  create policy "carriers_eu_update_kyc"
  on "public"."carriers_eu"
  as permissive
  for update
  to public
using (public.is_kyc_officer());



  create policy "chat_delete"
  on "public"."chat_messages"
  as permissive
  for delete
  to public
using (public.is_admin());



  create policy "chat_delete_moderator"
  on "public"."chat_messages"
  as permissive
  for delete
  to public
using (public.is_moderator());



  create policy "chat_insert"
  on "public"."chat_messages"
  as permissive
  for insert
  to public
with check (((sender_id = auth.uid()) AND public.is_conversation_participant(conversation_id)));



  create policy "chat_insert_support"
  on "public"."chat_messages"
  as permissive
  for insert
  to public
with check ((public.is_support() AND (sender_id = auth.uid())));



  create policy "chat_select"
  on "public"."chat_messages"
  as permissive
  for select
  to public
using ((public.is_conversation_participant(conversation_id) OR public.is_admin()));



  create policy "chat_select_moderator"
  on "public"."chat_messages"
  as permissive
  for select
  to public
using (public.is_moderator());



  create policy "chat_select_support"
  on "public"."chat_messages"
  as permissive
  for select
  to public
using (public.is_support());



  create policy "chat_update"
  on "public"."chat_messages"
  as permissive
  for update
  to public
using (((sender_id = auth.uid()) OR public.is_admin()));



  create policy "chat_update_moderator"
  on "public"."chat_messages"
  as permissive
  for update
  to public
using (public.is_moderator());



  create policy "company_contacts_delete"
  on "public"."company_contacts"
  as permissive
  for delete
  to public
using ((public.is_admin() OR public.is_current_user_actor((entity_type)::text, entity_id)));



  create policy "company_contacts_insert"
  on "public"."company_contacts"
  as permissive
  for insert
  to public
with check ((public.is_admin() OR public.is_current_user_actor((entity_type)::text, entity_id)));



  create policy "company_contacts_select"
  on "public"."company_contacts"
  as permissive
  for select
  to public
using ((public.is_admin() OR public.is_current_user_actor((entity_type)::text, entity_id)));



  create policy "company_contacts_update"
  on "public"."company_contacts"
  as permissive
  for update
  to public
using ((public.is_admin() OR public.is_current_user_actor((entity_type)::text, entity_id)));



  create policy "contacts_insert"
  on "public"."company_contacts"
  as permissive
  for insert
  to public
with check (((((entity_type)::text = 'supplier'::text) AND (entity_id = public.get_supplier_id())) OR (((entity_type)::text = 'carrier_dz'::text) AND (entity_id = public.get_carrier_dz_id())) OR (((entity_type)::text = 'carrier_eu'::text) AND (entity_id = public.get_carrier_eu_id())) OR (((entity_type)::text = 'freight_forwarder'::text) AND (entity_id = public.get_freight_forwarder_id())) OR (((entity_type)::text = 'buyer_eu'::text) AND (entity_id = public.get_buyer_id())) OR (((entity_type)::text = 'delivery_company'::text) AND (entity_id = public.get_delivery_company_id())) OR public.is_admin()));



  create policy "contacts_select"
  on "public"."company_contacts"
  as permissive
  for select
  to public
using (((((entity_type)::text = 'supplier'::text) AND (entity_id = public.get_supplier_id())) OR (((entity_type)::text = 'carrier_dz'::text) AND (entity_id = public.get_carrier_dz_id())) OR (((entity_type)::text = 'carrier_eu'::text) AND (entity_id = public.get_carrier_eu_id())) OR (((entity_type)::text = 'freight_forwarder'::text) AND (entity_id = public.get_freight_forwarder_id())) OR (((entity_type)::text = 'buyer_eu'::text) AND (entity_id = public.get_buyer_id())) OR (((entity_type)::text = 'delivery_company'::text) AND (entity_id = public.get_delivery_company_id())) OR public.is_admin()));



  create policy "contacts_update"
  on "public"."company_contacts"
  as permissive
  for update
  to public
using (((((entity_type)::text = 'supplier'::text) AND (entity_id = public.get_supplier_id())) OR (((entity_type)::text = 'carrier_dz'::text) AND (entity_id = public.get_carrier_dz_id())) OR (((entity_type)::text = 'carrier_eu'::text) AND (entity_id = public.get_carrier_eu_id())) OR (((entity_type)::text = 'freight_forwarder'::text) AND (entity_id = public.get_freight_forwarder_id())) OR (((entity_type)::text = 'buyer_eu'::text) AND (entity_id = public.get_buyer_id())) OR (((entity_type)::text = 'delivery_company'::text) AND (entity_id = public.get_delivery_company_id())) OR public.is_admin()));



  create policy "conv_participants_delete"
  on "public"."conversation_participants"
  as permissive
  for delete
  to public
using (public.is_admin());



  create policy "conv_participants_insert"
  on "public"."conversation_participants"
  as permissive
  for insert
  to public
with check (public.is_admin());



  create policy "conv_participants_select"
  on "public"."conversation_participants"
  as permissive
  for select
  to public
using ((public.is_conversation_participant(conversation_id) OR public.is_admin()));



  create policy "conv_participants_select_moderator"
  on "public"."conversation_participants"
  as permissive
  for select
  to public
using (public.is_moderator());



  create policy "conv_participants_select_support"
  on "public"."conversation_participants"
  as permissive
  for select
  to public
using (public.is_support());



  create policy "conversations_insert"
  on "public"."conversations"
  as permissive
  for insert
  to public
with check ((public.is_admin() OR ((order_id IS NOT NULL) AND (EXISTS ( SELECT 1
   FROM public.orders o
  WHERE ((o.id = conversations.order_id) AND ((o.buyer_id = public.get_buyer_id()) OR public.is_order_participant(conversations.order_id))))))));



  create policy "conversations_select"
  on "public"."conversations"
  as permissive
  for select
  to public
using ((public.is_conversation_participant(id) OR public.is_admin()));



  create policy "conversations_select_moderator"
  on "public"."conversations"
  as permissive
  for select
  to public
using (public.is_moderator());



  create policy "conversations_select_support"
  on "public"."conversations"
  as permissive
  for select
  to public
using (public.is_support());



  create policy "conversations_update"
  on "public"."conversations"
  as permissive
  for update
  to public
using (public.is_admin());



  create policy "delivery_companies_select_dev"
  on "public"."delivery_companies"
  as permissive
  for select
  to public
using (public.is_developer());



  create policy "delivery_companies_select_kyc"
  on "public"."delivery_companies"
  as permissive
  for select
  to public
using (public.is_kyc_officer());



  create policy "delivery_companies_select_logistics"
  on "public"."delivery_companies"
  as permissive
  for select
  to public
using (public.is_logistics());



  create policy "delivery_companies_update_kyc"
  on "public"."delivery_companies"
  as permissive
  for update
  to public
using (public.is_kyc_officer());



  create policy "delivery_insert"
  on "public"."delivery_companies"
  as permissive
  for insert
  to public
with check ((user_id = auth.uid()));



  create policy "delivery_select"
  on "public"."delivery_companies"
  as permissive
  for select
  to public
using (((id = public.get_delivery_company_id()) OR public.is_admin()));



  create policy "delivery_update"
  on "public"."delivery_companies"
  as permissive
  for update
  to public
using (((id = public.get_delivery_company_id()) OR public.is_admin()));



  create policy "documents_delete"
  on "public"."documents"
  as permissive
  for delete
  to public
using (((uploaded_by = auth.uid()) OR public.is_admin()));



  create policy "documents_insert"
  on "public"."documents"
  as permissive
  for insert
  to public
with check (((uploaded_by = auth.uid()) OR public.is_admin()));



  create policy "documents_select"
  on "public"."documents"
  as permissive
  for select
  to public
using ((public.is_admin() OR (uploaded_by = auth.uid()) OR ((order_id IS NOT NULL) AND (EXISTS ( SELECT 1
   FROM public.orders o
  WHERE ((o.id = documents.order_id) AND (o.buyer_id = public.get_buyer_id()))))) OR ((order_id IS NOT NULL) AND (EXISTS ( SELECT 1
   FROM public.order_items oi
  WHERE ((oi.order_id = oi.order_id) AND (oi.supplier_id = public.get_supplier_id())))))));



  create policy "documents_select_support"
  on "public"."documents"
  as permissive
  for select
  to public
using (public.is_support());



  create policy "documents_update"
  on "public"."documents"
  as permissive
  for update
  to public
using (public.is_admin());



  create policy "exchange_admin_write"
  on "public"."exchange_rates"
  as permissive
  for all
  to public
using (public.is_admin());



  create policy "exchange_select_all"
  on "public"."exchange_rates"
  as permissive
  for select
  to public
using (true);



  create policy "forwarders_insert"
  on "public"."freight_forwarders"
  as permissive
  for insert
  to public
with check ((user_id = auth.uid()));



  create policy "forwarders_select"
  on "public"."freight_forwarders"
  as permissive
  for select
  to public
using (((id = public.get_freight_forwarder_id()) OR public.is_admin()));



  create policy "forwarders_update"
  on "public"."freight_forwarders"
  as permissive
  for update
  to public
using (((id = public.get_freight_forwarder_id()) OR public.is_admin()));



  create policy "freight_forwarders_select_dev"
  on "public"."freight_forwarders"
  as permissive
  for select
  to public
using (public.is_developer());



  create policy "freight_forwarders_select_kyc"
  on "public"."freight_forwarders"
  as permissive
  for select
  to public
using (public.is_kyc_officer());



  create policy "freight_forwarders_select_logistics"
  on "public"."freight_forwarders"
  as permissive
  for select
  to public
using (public.is_logistics());



  create policy "freight_forwarders_update_kyc"
  on "public"."freight_forwarders"
  as permissive
  for update
  to public
using (public.is_kyc_officer());



  create policy "kyc_documents_delete"
  on "public"."kyc_documents"
  as permissive
  for delete
  to public
using (public.is_admin());



  create policy "kyc_documents_insert"
  on "public"."kyc_documents"
  as permissive
  for insert
  to public
with check ((public.is_admin() OR public.is_current_user_actor((entity_type)::text, entity_id) OR (((entity_type)::text = 'vehicle'::text) AND (entity_id IN ( SELECT vehicles.id
   FROM public.vehicles
  WHERE public.is_current_user_actor((vehicles.carrier_type)::text, vehicles.carrier_id))))));



  create policy "kyc_documents_select"
  on "public"."kyc_documents"
  as permissive
  for select
  to public
using ((public.is_admin() OR public.is_current_user_actor((entity_type)::text, entity_id) OR (((entity_type)::text = 'vehicle'::text) AND (entity_id IN ( SELECT vehicles.id
   FROM public.vehicles
  WHERE public.is_current_user_actor((vehicles.carrier_type)::text, vehicles.carrier_id)))) OR (uploaded_by = auth.uid())));



  create policy "kyc_documents_update"
  on "public"."kyc_documents"
  as permissive
  for update
  to public
using (public.is_admin());



  create policy "kyc_insert"
  on "public"."kyc_documents"
  as permissive
  for insert
  to public
with check (((((entity_type)::text = 'supplier'::text) AND (entity_id = public.get_supplier_id())) OR (((entity_type)::text = 'carrier_dz'::text) AND (entity_id = public.get_carrier_dz_id())) OR (((entity_type)::text = 'carrier_eu'::text) AND (entity_id = public.get_carrier_eu_id())) OR (((entity_type)::text = 'freight_forwarder'::text) AND (entity_id = public.get_freight_forwarder_id())) OR (((entity_type)::text = 'buyer_eu'::text) AND (entity_id = public.get_buyer_id())) OR (((entity_type)::text = 'delivery_company'::text) AND (entity_id = public.get_delivery_company_id())) OR public.is_admin()));



  create policy "kyc_select"
  on "public"."kyc_documents"
  as permissive
  for select
  to public
using (((((entity_type)::text = 'supplier'::text) AND (entity_id = public.get_supplier_id())) OR (((entity_type)::text = 'carrier_dz'::text) AND (entity_id = public.get_carrier_dz_id())) OR (((entity_type)::text = 'carrier_eu'::text) AND (entity_id = public.get_carrier_eu_id())) OR (((entity_type)::text = 'freight_forwarder'::text) AND (entity_id = public.get_freight_forwarder_id())) OR (((entity_type)::text = 'buyer_eu'::text) AND (entity_id = public.get_buyer_id())) OR (((entity_type)::text = 'delivery_company'::text) AND (entity_id = public.get_delivery_company_id())) OR public.is_admin()));



  create policy "kyc_select_officer"
  on "public"."kyc_documents"
  as permissive
  for select
  to public
using (public.is_kyc_officer());



  create policy "kyc_update"
  on "public"."kyc_documents"
  as permissive
  for update
  to public
using (public.is_admin());



  create policy "kyc_update_officer"
  on "public"."kyc_documents"
  as permissive
  for update
  to public
using (public.is_kyc_officer());



  create policy "notif_insert_own"
  on "public"."notifications"
  as permissive
  for insert
  to public
with check (((user_id = auth.uid()) OR public.is_admin()));



  create policy "notif_select_own"
  on "public"."notifications"
  as permissive
  for select
  to public
using (((user_id = auth.uid()) OR public.is_admin()));



  create policy "notif_update_own"
  on "public"."notifications"
  as permissive
  for update
  to public
using (((user_id = auth.uid()) OR public.is_admin()));



  create policy "notifications_select_support"
  on "public"."notifications"
  as permissive
  for select
  to public
using (public.is_support());



  create policy "order_items_delete"
  on "public"."order_items"
  as permissive
  for delete
  to public
using (((EXISTS ( SELECT 1
   FROM public.orders o
  WHERE ((o.id = order_items.order_id) AND (o.buyer_id = public.get_buyer_id()) AND (o.status = 'draft'::public.order_status)))) OR public.is_admin()));



  create policy "order_items_insert"
  on "public"."order_items"
  as permissive
  for insert
  to public
with check (((EXISTS ( SELECT 1
   FROM public.orders o
  WHERE ((o.id = order_items.order_id) AND (o.buyer_id = public.get_buyer_id())))) OR public.is_admin()));



  create policy "order_items_select"
  on "public"."order_items"
  as permissive
  for select
  to public
using (((supplier_id = public.get_supplier_id()) OR (EXISTS ( SELECT 1
   FROM public.orders o
  WHERE ((o.id = order_items.order_id) AND (o.buyer_id = public.get_buyer_id())))) OR public.is_admin()));



  create policy "order_items_select_dev"
  on "public"."order_items"
  as permissive
  for select
  to public
using (public.is_developer());



  create policy "order_items_select_support"
  on "public"."order_items"
  as permissive
  for select
  to public
using (public.is_support());



  create policy "order_items_update"
  on "public"."order_items"
  as permissive
  for update
  to public
using (((EXISTS ( SELECT 1
   FROM public.orders o
  WHERE ((o.id = order_items.order_id) AND (o.buyer_id = public.get_buyer_id()) AND (o.status = 'draft'::public.order_status)))) OR public.is_admin()));



  create policy "orders_select_dev"
  on "public"."orders"
  as permissive
  for select
  to public
using (public.is_developer());



  create policy "orders_select_support"
  on "public"."orders"
  as permissive
  for select
  to public
using (public.is_support());



  create policy "payments_insert"
  on "public"."payments"
  as permissive
  for insert
  to public
with check (((EXISTS ( SELECT 1
   FROM public.orders o
  WHERE ((o.id = payments.order_id) AND (o.buyer_id = public.get_buyer_id())))) OR public.is_admin()));



  create policy "payments_select_dev"
  on "public"."payments"
  as permissive
  for select
  to public
using (public.is_developer());



  create policy "payments_select_finance"
  on "public"."payments"
  as permissive
  for select
  to public
using (public.is_finance());



  create policy "payments_update"
  on "public"."payments"
  as permissive
  for update
  to public
using (public.is_admin());



  create policy "payments_update_finance"
  on "public"."payments"
  as permissive
  for update
  to public
using (public.is_finance());



  create policy "payouts_insert"
  on "public"."payouts"
  as permissive
  for insert
  to public
with check (public.is_admin());



  create policy "payouts_insert_finance"
  on "public"."payouts"
  as permissive
  for insert
  to public
with check (public.is_finance());



  create policy "payouts_select"
  on "public"."payouts"
  as permissive
  for select
  to public
using (((((payee_type)::text = 'supplier'::text) AND (payee_id = public.get_supplier_id())) OR (((payee_type)::text = 'carrier_dz'::text) AND (payee_id = public.get_carrier_dz_id())) OR (((payee_type)::text = 'carrier_eu'::text) AND (payee_id = public.get_carrier_eu_id())) OR (((payee_type)::text = 'freight_forwarder'::text) AND (payee_id = public.get_freight_forwarder_id())) OR (((payee_type)::text = 'delivery_company'::text) AND (payee_id = public.get_delivery_company_id())) OR (EXISTS ( SELECT 1
   FROM public.orders o
  WHERE ((o.id = payouts.order_id) AND (o.buyer_id = public.get_buyer_id())))) OR public.is_admin()));



  create policy "payouts_select_dev"
  on "public"."payouts"
  as permissive
  for select
  to public
using (public.is_developer());



  create policy "payouts_select_finance"
  on "public"."payouts"
  as permissive
  for select
  to public
using (public.is_finance());



  create policy "payouts_update"
  on "public"."payouts"
  as permissive
  for update
  to public
using (public.is_admin());



  create policy "payouts_update_finance"
  on "public"."payouts"
  as permissive
  for update
  to public
using (public.is_finance());



  create policy "products_delete"
  on "public"."products_catalog"
  as permissive
  for delete
  to public
using (((supplier_id = public.get_supplier_id()) OR public.is_admin()));



  create policy "products_insert"
  on "public"."products_catalog"
  as permissive
  for insert
  to public
with check (((supplier_id = public.get_supplier_id()) OR public.is_admin()));



  create policy "products_select"
  on "public"."products_catalog"
  as permissive
  for select
  to public
using ((((active = true) AND (status = 'published'::public.product_status) AND (deleted_at IS NULL)) OR (supplier_id = public.get_supplier_id()) OR public.is_admin()));



  create policy "products_select_dev"
  on "public"."products_catalog"
  as permissive
  for select
  to public
using (public.is_developer());



  create policy "products_select_manager"
  on "public"."products_catalog"
  as permissive
  for select
  to public
using (public.is_catalog_manager());



  create policy "products_update"
  on "public"."products_catalog"
  as permissive
  for update
  to public
using (((supplier_id = public.get_supplier_id()) OR public.is_admin()));



  create policy "products_update_manager"
  on "public"."products_catalog"
  as permissive
  for update
  to public
using (public.is_catalog_manager());



  create policy "quote_req_insert"
  on "public"."quote_requests"
  as permissive
  for insert
  to public
with check (((EXISTS ( SELECT 1
   FROM public.orders o
  WHERE ((o.id = quote_requests.order_id) AND (o.buyer_id = public.get_buyer_id())))) OR public.is_admin()));



  create policy "quote_req_select"
  on "public"."quote_requests"
  as permissive
  for select
  to public
using (((supplier_id = public.get_supplier_id()) OR (EXISTS ( SELECT 1
   FROM public.orders o
  WHERE ((o.id = quote_requests.order_id) AND (o.buyer_id = public.get_buyer_id())))) OR public.is_admin()));



  create policy "quote_req_update"
  on "public"."quote_requests"
  as permissive
  for update
  to public
using (public.is_admin());



  create policy "reviews_delete_moderator"
  on "public"."reviews"
  as permissive
  for delete
  to public
using (public.is_moderator());



  create policy "reviews_select_moderator"
  on "public"."reviews"
  as permissive
  for select
  to public
using (public.is_moderator());



  create policy "reviews_update"
  on "public"."reviews"
  as permissive
  for update
  to public
using (public.is_admin());



  create policy "reviews_update_moderator"
  on "public"."reviews"
  as permissive
  for update
  to public
using (public.is_moderator());



  create policy "shipments_admin_delete"
  on "public"."shipments"
  as permissive
  for delete
  to public
using (public.is_admin());



  create policy "shipments_admin_insert_delete"
  on "public"."shipments"
  as permissive
  for insert
  to public
with check (public.is_admin());



  create policy "shipments_insert"
  on "public"."shipments"
  as permissive
  for insert
  to public
with check (((((carrier_type)::text = 'carrier_dz'::text) AND (carrier_id = public.get_carrier_dz_id())) OR (((carrier_type)::text = 'carrier_eu'::text) AND (carrier_id = public.get_carrier_eu_id())) OR (((carrier_type)::text = 'freight_forwarder'::text) AND (carrier_id = public.get_freight_forwarder_id())) OR (((carrier_type)::text = 'delivery_company'::text) AND (carrier_id = public.get_delivery_company_id())) OR public.is_admin()));



  create policy "shipments_insert_logistics"
  on "public"."shipments"
  as permissive
  for insert
  to public
with check (public.is_logistics());



  create policy "shipments_select"
  on "public"."shipments"
  as permissive
  for select
  to public
using (((EXISTS ( SELECT 1
   FROM public.orders o
  WHERE ((o.id = shipments.order_id) AND (o.buyer_id = public.get_buyer_id())))) OR (((carrier_type)::text = 'carrier_dz'::text) AND (carrier_id = public.get_carrier_dz_id())) OR (((carrier_type)::text = 'carrier_eu'::text) AND (carrier_id = public.get_carrier_eu_id())) OR (((carrier_type)::text = 'freight_forwarder'::text) AND (carrier_id = public.get_freight_forwarder_id())) OR (((carrier_type)::text = 'delivery_company'::text) AND (carrier_id = public.get_delivery_company_id())) OR public.is_admin()));



  create policy "shipments_select_logistics"
  on "public"."shipments"
  as permissive
  for select
  to public
using (public.is_logistics());



  create policy "shipments_update"
  on "public"."shipments"
  as permissive
  for update
  to public
using (((((carrier_type)::text = 'carrier_dz'::text) AND (carrier_id = public.get_carrier_dz_id())) OR (((carrier_type)::text = 'carrier_eu'::text) AND (carrier_id = public.get_carrier_eu_id())) OR (((carrier_type)::text = 'freight_forwarder'::text) AND (carrier_id = public.get_freight_forwarder_id())) OR (((carrier_type)::text = 'delivery_company'::text) AND (carrier_id = public.get_delivery_company_id())) OR public.is_admin()));



  create policy "shipments_update_logistics"
  on "public"."shipments"
  as permissive
  for update
  to public
using (public.is_logistics());



  create policy "subscriptions_admin_write"
  on "public"."subscriptions"
  as permissive
  for all
  to public
using (public.is_admin())
with check (public.is_admin());



  create policy "subscriptions_insert"
  on "public"."subscriptions"
  as permissive
  for insert
  to public
with check (public.is_admin());



  create policy "subscriptions_select"
  on "public"."subscriptions"
  as permissive
  for select
  to public
using (((((entity_type)::text = 'supplier'::text) AND (entity_id = public.get_supplier_id())) OR (((entity_type)::text = 'carrier_dz'::text) AND (entity_id = public.get_carrier_dz_id())) OR (((entity_type)::text = 'carrier_eu'::text) AND (entity_id = public.get_carrier_eu_id())) OR (((entity_type)::text = 'freight_forwarder'::text) AND (entity_id = public.get_freight_forwarder_id())) OR (((entity_type)::text = 'buyer_eu'::text) AND (entity_id = public.get_buyer_id())) OR (((entity_type)::text = 'delivery_company'::text) AND (entity_id = public.get_delivery_company_id())) OR public.is_admin()));



  create policy "subscriptions_select_finance"
  on "public"."subscriptions"
  as permissive
  for select
  to public
using (public.is_finance());



  create policy "subscriptions_update"
  on "public"."subscriptions"
  as permissive
  for update
  to public
using (public.is_admin());



  create policy "subscriptions_update_finance"
  on "public"."subscriptions"
  as permissive
  for update
  to public
using (public.is_finance());



  create policy "suppliers_insert"
  on "public"."suppliers"
  as permissive
  for insert
  to public
with check ((user_id = auth.uid()));



  create policy "suppliers_select"
  on "public"."suppliers"
  as permissive
  for select
  to public
using (((id = public.get_supplier_id()) OR public.is_admin()));



  create policy "suppliers_select_catalog"
  on "public"."suppliers"
  as permissive
  for select
  to public
using (public.is_catalog_manager());



  create policy "suppliers_select_dev"
  on "public"."suppliers"
  as permissive
  for select
  to public
using (public.is_developer());



  create policy "suppliers_select_kyc"
  on "public"."suppliers"
  as permissive
  for select
  to public
using (public.is_kyc_officer());



  create policy "suppliers_update"
  on "public"."suppliers"
  as permissive
  for update
  to public
using (((id = public.get_supplier_id()) OR public.is_admin()));



  create policy "suppliers_update_kyc"
  on "public"."suppliers"
  as permissive
  for update
  to public
using (public.is_kyc_officer());



  create policy "transactions_admin_write"
  on "public"."transactions"
  as permissive
  for all
  to public
using (public.is_admin())
with check (public.is_admin());



  create policy "transactions_insert"
  on "public"."transactions"
  as permissive
  for insert
  to public
with check (public.is_admin());



  create policy "transactions_insert_finance"
  on "public"."transactions"
  as permissive
  for insert
  to public
with check (public.is_finance());



  create policy "transactions_select"
  on "public"."transactions"
  as permissive
  for select
  to public
using (((EXISTS ( SELECT 1
   FROM public.orders o
  WHERE ((o.id = transactions.related_order_id) AND (o.buyer_id = public.get_buyer_id())))) OR (EXISTS ( SELECT 1
   FROM public.subscriptions s
  WHERE ((s.id = transactions.related_subscription_id) AND (s.entity_id = ANY (ARRAY[public.get_supplier_id(), public.get_buyer_id(), public.get_carrier_dz_id(), public.get_carrier_eu_id(), public.get_freight_forwarder_id(), public.get_delivery_company_id()]))))) OR public.is_admin()));



  create policy "transactions_select_dev"
  on "public"."transactions"
  as permissive
  for select
  to public
using (public.is_developer());



  create policy "transactions_select_finance"
  on "public"."transactions"
  as permissive
  for select
  to public
using (public.is_finance());



  create policy "transactions_update"
  on "public"."transactions"
  as permissive
  for update
  to public
using (public.is_admin());



  create policy "transactions_update_finance"
  on "public"."transactions"
  as permissive
  for update
  to public
using (public.is_finance());



  create policy "roles_delete_admin"
  on "public"."user_roles"
  as permissive
  for delete
  to public
using (public.is_admin());



  create policy "roles_delete_by_admin"
  on "public"."user_roles"
  as permissive
  for delete
  to public
using (public.is_admin());



  create policy "roles_insert_admin"
  on "public"."user_roles"
  as permissive
  for insert
  to public
with check (public.is_admin());



  create policy "roles_insert_by_admin"
  on "public"."user_roles"
  as permissive
  for insert
  to public
with check (public.is_admin());



  create policy "roles_select_admin"
  on "public"."user_roles"
  as permissive
  for select
  to public
using (public.is_admin());



  create policy "roles_select_by_admin"
  on "public"."user_roles"
  as permissive
  for select
  to public
using (public.is_admin());



  create policy "roles_update_admin"
  on "public"."user_roles"
  as permissive
  for update
  to public
using (public.is_admin());



  create policy "roles_update_by_admin"
  on "public"."user_roles"
  as permissive
  for update
  to public
using (public.is_admin());



  create policy "vehicles_delete"
  on "public"."vehicles"
  as permissive
  for delete
  to public
using ((public.is_admin() OR public.is_current_user_actor((carrier_type)::text, carrier_id)));



  create policy "vehicles_insert"
  on "public"."vehicles"
  as permissive
  for insert
  to public
with check (((((carrier_type)::text = 'carrier_dz'::text) AND (carrier_id = public.get_carrier_dz_id())) OR (((carrier_type)::text = 'carrier_eu'::text) AND (carrier_id = public.get_carrier_eu_id())) OR (((carrier_type)::text = 'delivery_company'::text) AND (carrier_id = public.get_delivery_company_id())) OR public.is_admin()));



  create policy "vehicles_select"
  on "public"."vehicles"
  as permissive
  for select
  to public
using (((((carrier_type)::text = 'carrier_dz'::text) AND (carrier_id = public.get_carrier_dz_id())) OR (((carrier_type)::text = 'carrier_eu'::text) AND (carrier_id = public.get_carrier_eu_id())) OR (((carrier_type)::text = 'delivery_company'::text) AND (carrier_id = public.get_delivery_company_id())) OR public.is_admin()));



  create policy "vehicles_select_logistics"
  on "public"."vehicles"
  as permissive
  for select
  to public
using (public.is_logistics());



  create policy "vehicles_update"
  on "public"."vehicles"
  as permissive
  for update
  to public
using (((((carrier_type)::text = 'carrier_dz'::text) AND (carrier_id = public.get_carrier_dz_id())) OR (((carrier_type)::text = 'carrier_eu'::text) AND (carrier_id = public.get_carrier_eu_id())) OR (((carrier_type)::text = 'delivery_company'::text) AND (carrier_id = public.get_delivery_company_id())) OR public.is_admin()));



  create policy "vehicles_update_logistics"
  on "public"."vehicles"
  as permissive
  for update
  to public
using (public.is_logistics());



  create policy "wilayas_admin_write"
  on "public"."wilayas"
  as permissive
  for all
  to public
using (public.is_admin());



  create policy "wilayas_select_all"
  on "public"."wilayas"
  as permissive
  for select
  to public
using (true);



  create policy "items_manage"
  on "public"."order_items"
  as permissive
  for all
  to public
using ((public.is_admin() OR (order_id IN ( SELECT orders.id
   FROM public.orders
  WHERE ((orders.buyer_id IN ( SELECT buyers_eu.id
           FROM public.buyers_eu
          WHERE (buyers_eu.user_id = auth.uid()))) AND ((orders.status)::text = ANY (ARRAY['draft'::text, 'quotes_requested'::text, 'quotes_received'::text])))))));



  create policy "orders_insert"
  on "public"."orders"
  as permissive
  for insert
  to public
with check (((buyer_id = public.get_buyer_id()) OR public.is_admin()));



  create policy "orders_select"
  on "public"."orders"
  as permissive
  for select
  to public
using (((buyer_id = public.get_buyer_id()) OR public.is_order_participant(id) OR public.is_admin()));



  create policy "orders_update"
  on "public"."orders"
  as permissive
  for update
  to public
using ((((buyer_id = public.get_buyer_id()) AND (status = 'draft'::public.order_status)) OR public.is_admin()));



  create policy "payments_select"
  on "public"."payments"
  as permissive
  for select
  to public
using (((EXISTS ( SELECT 1
   FROM public.orders o
  WHERE ((o.id = payments.order_id) AND (o.buyer_id = public.get_buyer_id())))) OR public.is_admin()));



  create policy "qr_update"
  on "public"."quote_requests"
  as permissive
  for update
  to public
using ((public.is_admin() OR ((order_id IN ( SELECT orders.id
   FROM public.orders
  WHERE (orders.buyer_id IN ( SELECT buyers_eu.id
           FROM public.buyers_eu
          WHERE (buyers_eu.user_id = auth.uid()))))) AND ((status)::text = ANY (ARRAY['open'::text, 'quoted'::text])))));



  create policy "quotes_insert"
  on "public"."quotes"
  as permissive
  for insert
  to public
with check (((((provider_type)::text = 'supplier'::text) AND (provider_id = public.get_supplier_id())) OR (((provider_type)::text = 'carrier_dz'::text) AND (provider_id = public.get_carrier_dz_id())) OR (((provider_type)::text = 'carrier_eu'::text) AND (provider_id = public.get_carrier_eu_id())) OR (((provider_type)::text = 'freight_forwarder'::text) AND (provider_id = public.get_freight_forwarder_id())) OR (((provider_type)::text = 'delivery_company'::text) AND (provider_id = public.get_delivery_company_id())) OR public.is_admin()));



  create policy "quotes_select"
  on "public"."quotes"
  as permissive
  for select
  to public
using (((((provider_type)::text = 'supplier'::text) AND (provider_id = public.get_supplier_id())) OR (((provider_type)::text = 'carrier_dz'::text) AND (provider_id = public.get_carrier_dz_id())) OR (((provider_type)::text = 'carrier_eu'::text) AND (provider_id = public.get_carrier_eu_id())) OR (((provider_type)::text = 'freight_forwarder'::text) AND (provider_id = public.get_freight_forwarder_id())) OR (((provider_type)::text = 'delivery_company'::text) AND (provider_id = public.get_delivery_company_id())) OR (EXISTS ( SELECT 1
   FROM (public.quote_requests qr
     JOIN public.orders o ON ((o.id = qr.order_id)))
  WHERE ((qr.id = quotes.quote_request_id) AND (o.buyer_id = public.get_buyer_id())))) OR public.is_admin()));



  create policy "quotes_update"
  on "public"."quotes"
  as permissive
  for update
  to public
using (((((provider_type)::text = 'supplier'::text) AND (provider_id = public.get_supplier_id())) OR (((provider_type)::text = 'carrier_dz'::text) AND (provider_id = public.get_carrier_dz_id())) OR (((provider_type)::text = 'carrier_eu'::text) AND (provider_id = public.get_carrier_eu_id())) OR (((provider_type)::text = 'freight_forwarder'::text) AND (provider_id = public.get_freight_forwarder_id())) OR (((provider_type)::text = 'delivery_company'::text) AND (provider_id = public.get_delivery_company_id())) OR public.is_admin()));



  create policy "reviews_insert"
  on "public"."reviews"
  as permissive
  for insert
  to public
with check ((reviewer_id = auth.uid()));



  create policy "reviews_select"
  on "public"."reviews"
  as permissive
  for select
  to public
using (((status = 'published'::public.review_status) OR (reviewer_id = auth.uid()) OR public.is_admin()));


CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.buyers_eu FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.carriers_dz FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.carriers_eu FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER check_contact_entity BEFORE INSERT OR UPDATE ON public.company_contacts FOR EACH ROW EXECUTE FUNCTION public.trg_validate_contact();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.company_contacts FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.conversations FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.delivery_companies FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.freight_forwarders FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER check_kyc_entity BEFORE INSERT OR UPDATE ON public.kyc_documents FOR EACH ROW EXECUTE FUNCTION public.trg_validate_kyc();

CREATE TRIGGER audit_order_items AFTER INSERT OR DELETE OR UPDATE ON public.order_items FOR EACH ROW EXECUTE FUNCTION public.audit_trigger_func();

CREATE TRIGGER audit_orders AFTER INSERT OR DELETE OR UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.audit_trigger_func();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER audit_payments AFTER INSERT OR DELETE OR UPDATE ON public.payments FOR EACH ROW EXECUTE FUNCTION public.audit_trigger_func();

CREATE TRIGGER audit_payouts AFTER INSERT OR DELETE OR UPDATE ON public.payouts FOR EACH ROW EXECUTE FUNCTION public.audit_trigger_func();

CREATE TRIGGER check_payout_payee BEFORE INSERT OR UPDATE ON public.payouts FOR EACH ROW EXECUTE FUNCTION public.trg_validate_payout();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.products_catalog FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER audit_quote_requests AFTER INSERT OR DELETE OR UPDATE ON public.quote_requests FOR EACH ROW EXECUTE FUNCTION public.audit_trigger_func();

CREATE TRIGGER audit_quotes AFTER INSERT OR DELETE OR UPDATE ON public.quotes FOR EACH ROW EXECUTE FUNCTION public.audit_trigger_func();

CREATE TRIGGER check_quote_provider BEFORE INSERT OR UPDATE ON public.quotes FOR EACH ROW EXECUTE FUNCTION public.trg_validate_quote();

CREATE TRIGGER check_review_target BEFORE INSERT OR UPDATE ON public.reviews FOR EACH ROW EXECUTE FUNCTION public.trg_validate_review();

CREATE TRIGGER audit_shipments AFTER INSERT OR DELETE OR UPDATE ON public.shipments FOR EACH ROW EXECUTE FUNCTION public.audit_trigger_func();

CREATE TRIGGER check_shipment_carrier BEFORE INSERT OR UPDATE ON public.shipments FOR EACH ROW EXECUTE FUNCTION public.trg_validate_shipment();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.shipments FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER audit_subscriptions AFTER INSERT OR DELETE OR UPDATE ON public.subscriptions FOR EACH ROW EXECUTE FUNCTION public.audit_trigger_func();

CREATE TRIGGER check_sub_entity BEFORE INSERT OR UPDATE ON public.subscriptions FOR EACH ROW EXECUTE FUNCTION public.trg_validate_sub();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.subscriptions FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.suppliers FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER audit_transactions AFTER INSERT OR DELETE OR UPDATE ON public.transactions FOR EACH ROW EXECUTE FUNCTION public.audit_trigger_func();

CREATE TRIGGER check_vehicle_carrier BEFORE INSERT OR UPDATE ON public.vehicles FOR EACH ROW EXECUTE FUNCTION public.trg_validate_vehicle();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.vehicles FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();


