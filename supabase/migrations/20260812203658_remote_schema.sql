


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE TYPE "public"."ad_status" AS ENUM (
    'pending',
    'active',
    'ended',
    'rejected'
);


ALTER TYPE "public"."ad_status" OWNER TO "postgres";


CREATE TYPE "public"."app_role" AS ENUM (
    'admin',
    'moderator',
    'support',
    'supplier',
    'carrier_dz',
    'carrier_eu',
    'freight_forwarder',
    'delivery_company',
    'buyer_eu'
);


ALTER TYPE "public"."app_role" OWNER TO "postgres";


CREATE TYPE "public"."business_status" AS ENUM (
    'draft',
    'pending_review',
    'rejected',
    'active',
    'suspended',
    'closed'
);


ALTER TYPE "public"."business_status" OWNER TO "postgres";


CREATE TYPE "public"."contact_type" AS ENUM (
    'commercial',
    'logistics',
    'management',
    'technical',
    'other'
);


ALTER TYPE "public"."contact_type" OWNER TO "postgres";


CREATE TYPE "public"."continent_type" AS ENUM (
    'africa',
    'europe',
    'asia',
    'america',
    'oceania'
);


ALTER TYPE "public"."continent_type" OWNER TO "postgres";


CREATE TYPE "public"."conversation_status" AS ENUM (
    'active',
    'closed'
);


ALTER TYPE "public"."conversation_status" OWNER TO "postgres";


CREATE TYPE "public"."incoterm_type" AS ENUM (
    'FOB',
    'CIF',
    'CFR',
    'EXW',
    'DAP',
    'DDP',
    'FCA'
);


ALTER TYPE "public"."incoterm_type" OWNER TO "postgres";


CREATE TYPE "public"."kyc_status" AS ENUM (
    'pending',
    'verified',
    'rejected'
);


ALTER TYPE "public"."kyc_status" OWNER TO "postgres";


CREATE TYPE "public"."legal_form" AS ENUM (
    'sarl',
    'spa',
    'eurl',
    'snc',
    'surl',
    'sas',
    'auto_entrepreneur',
    'association'
);


ALTER TYPE "public"."legal_form" OWNER TO "postgres";


CREATE TYPE "public"."measurement_unit" AS ENUM (
    'kg',
    'ton',
    'liter',
    'm3',
    'unit',
    'm2',
    'ml',
    'carton',
    'pallet'
);


ALTER TYPE "public"."measurement_unit" OWNER TO "postgres";


CREATE TYPE "public"."notification_type" AS ENUM (
    'new_message',
    'new_quote_request',
    'quote_response',
    'status_change',
    'new_review',
    'subscription_alert',
    'transport_request',
    'transit_request',
    'kyc_approved',
    'kyc_rejected',
    'system'
);


ALTER TYPE "public"."notification_type" OWNER TO "postgres";


CREATE TYPE "public"."order_status" AS ENUM (
    'confirmed',
    'preparing',
    'ready_to_ship',
    'shipped',
    'delivered',
    'cancelled',
    'disputed'
);


ALTER TYPE "public"."order_status" OWNER TO "postgres";


CREATE TYPE "public"."package_type" AS ENUM (
    'pallet',
    'container_20',
    'container_40',
    'carton',
    'bulk',
    'tank'
);


ALTER TYPE "public"."package_type" OWNER TO "postgres";


CREATE TYPE "public"."payment_method" AS ENUM (
    'card',
    'transfer',
    'ccp',
    'check'
);


ALTER TYPE "public"."payment_method" OWNER TO "postgres";


CREATE TYPE "public"."product_status" AS ENUM (
    'draft',
    'published',
    'archived',
    'rejected'
);


ALTER TYPE "public"."product_status" OWNER TO "postgres";


CREATE TYPE "public"."quote_response_status" AS ENUM (
    'pending',
    'accepted',
    'refused'
);


ALTER TYPE "public"."quote_response_status" OWNER TO "postgres";


CREATE TYPE "public"."quote_status" AS ENUM (
    'sent',
    'seen',
    'answered',
    'cancelled',
    'expired'
);


ALTER TYPE "public"."quote_status" OWNER TO "postgres";


CREATE TYPE "public"."review_status" AS ENUM (
    'published',
    'moderated',
    'reported'
);


ALTER TYPE "public"."review_status" OWNER TO "postgres";


CREATE TYPE "public"."shipment_status" AS ENUM (
    'preparing',
    'loaded',
    'in_transit',
    'arrived',
    'delivered',
    'delayed'
);


ALTER TYPE "public"."shipment_status" OWNER TO "postgres";


CREATE TYPE "public"."shipping_doc_type" AS ENUM (
    'bl',
    'awb',
    'commercial_invoice',
    'certificate_of_origin',
    'phytosanitary',
    'packing_list',
    'customs_declaration',
    'insurance',
    'other'
);


ALTER TYPE "public"."shipping_doc_type" OWNER TO "postgres";


CREATE TYPE "public"."sub_status" AS ENUM (
    'active',
    'expired',
    'cancelled'
);


ALTER TYPE "public"."sub_status" OWNER TO "postgres";


CREATE TYPE "public"."subscription_plan" AS ENUM (
    'free',
    'starter',
    'pro',
    'enterprise'
);


ALTER TYPE "public"."subscription_plan" OWNER TO "postgres";


CREATE TYPE "public"."supplier_doc_status" AS ENUM (
    'pending',
    'approved',
    'rejected'
);


ALTER TYPE "public"."supplier_doc_status" OWNER TO "postgres";


CREATE TYPE "public"."supplier_doc_type" AS ENUM (
    'nrc',
    'nif',
    'export_register',
    'articles_of_association',
    'tax_certificate',
    'other'
);


ALTER TYPE "public"."supplier_doc_type" OWNER TO "postgres";


CREATE TYPE "public"."transaction_status" AS ENUM (
    'pending',
    'completed',
    'failed',
    'refunded'
);


ALTER TYPE "public"."transaction_status" OWNER TO "postgres";


CREATE TYPE "public"."transaction_type" AS ENUM (
    'subscription',
    'commission',
    'refund'
);


ALTER TYPE "public"."transaction_type" OWNER TO "postgres";


CREATE TYPE "public"."transport_mode" AS ENUM (
    'maritime',
    'air',
    'road',
    'rail',
    'multimodal'
);


ALTER TYPE "public"."transport_mode" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_public_catalogue_categories"() RETURNS TABLE("category" "text")
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $$
  SELECT DISTINCT p.category::text
  FROM public.products_catalog p
  JOIN public.suppliers s ON s.id = p.supplier_id
  WHERE p.active = true
    AND s.active = true
    AND p.category IS NOT NULL
    AND p.category <> ''
  ORDER BY 1
  LIMIT 100;
$$;


ALTER FUNCTION "public"."get_public_catalogue_categories"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_public_catalogue_products"("search_text" "text" DEFAULT NULL::"text", "category_filter" "text" DEFAULT NULL::"text", "limit_count" integer DEFAULT 48) RETURNS TABLE("product_id" "uuid", "product_name" character varying, "category" character varying, "description" "text", "unit" character varying, "price_dzd" numeric, "min_order_qty" numeric, "available_qty" numeric, "image_url" "text", "created_at" timestamp with time zone, "supplier_id" "uuid", "supplier_company_name" character varying, "supplier_rating_avg" numeric, "supplier_city" character varying, "supplier_wilaya" character varying)
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $$
  SELECT
    p.id AS product_id,
    p.product_name,
    p.category,
    p.description,
    p.unit,
    p.price_dzd,
    p.min_order_qty,
    p.available_qty,
    p.image_url,
    p.created_at,
    s.id AS supplier_id,
    s.company_name AS supplier_company_name,
    s.rating_avg AS supplier_rating_avg,
    s.city AS supplier_city,
    s.wilaya AS supplier_wilaya
  FROM public.products_catalog p
  JOIN public.suppliers s ON s.id = p.supplier_id
  WHERE p.active = true
    AND s.active = true
    AND (
      category_filter IS NULL
      OR p.category = category_filter
    )
    AND (
      search_text IS NULL
      OR p.product_name ILIKE '%' || search_text || '%'
      OR p.description ILIKE '%' || search_text || '%'
    )
  ORDER BY p.created_at DESC
  LIMIT limit_count;
$$;


ALTER FUNCTION "public"."get_public_catalogue_products"("search_text" "text", "category_filter" "text", "limit_count" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $$ DECLARE user_role TEXT; company_name TEXT;
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


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_admin"() RETURNS boolean
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $$ BEGIN RETURN (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin'; END; $$;


ALTER FUNCTION "public"."is_admin"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_current_user_actor"("p_type" "text", "p_id" "uuid") RETURNS boolean
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $$ BEGIN
    RETURN (
        (p_type = 'carrier_dz' AND EXISTS (SELECT 1 FROM public.carriers_dz WHERE id = p_id AND user_id = auth.uid())) OR
        (p_type = 'freight_forwarder' AND EXISTS (SELECT 1 FROM public.freight_forwarders WHERE id = p_id AND user_id = auth.uid())) OR
        (p_type = 'carrier_eu' AND EXISTS (SELECT 1 FROM public.carriers_eu WHERE id = p_id AND user_id = auth.uid())) OR
        (p_type = 'supplier' AND EXISTS (SELECT 1 FROM public.suppliers WHERE id = p_id AND user_id = auth.uid()))
    );
END; $$;


ALTER FUNCTION "public"."is_current_user_actor"("p_type" "text", "p_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_rating_avg"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $_$ DECLARE target_table TEXT; avg_rating NUMERIC(2,1);
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
END; $_$;


ALTER FUNCTION "public"."update_rating_avg"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_updated_at_column"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$ BEGIN NEW.updated_at = NOW(); RETURN NEW; END; $$;


ALTER FUNCTION "public"."update_updated_at_column"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."validate_payout_payee"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$ BEGIN
    CASE NEW.payee_type
        WHEN 'supplier' THEN IF NOT EXISTS (SELECT 1 FROM public.suppliers WHERE id = NEW.payee_id) THEN RAISE EXCEPTION 'Invalid supplier'; END IF;
        WHEN 'carrier_dz' THEN IF NOT EXISTS (SELECT 1 FROM public.carriers_dz WHERE id = NEW.payee_id) THEN RAISE EXCEPTION 'Invalid carrier_dz'; END IF;
        WHEN 'freight_forwarder' THEN IF NOT EXISTS (SELECT 1 FROM public.freight_forwarders WHERE id = NEW.payee_id) THEN RAISE EXCEPTION 'Invalid forwarder'; END IF;
        WHEN 'carrier_eu' THEN IF NOT EXISTS (SELECT 1 FROM public.carriers_eu WHERE id = NEW.payee_id) THEN RAISE EXCEPTION 'Invalid carrier_eu'; END IF;
    END CASE; RETURN NEW;
END; $$;


ALTER FUNCTION "public"."validate_payout_payee"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."validate_quote_provider"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$ BEGIN
    CASE NEW.provider_type
        WHEN 'carrier_dz' THEN IF NOT EXISTS (SELECT 1 FROM public.carriers_dz WHERE id = NEW.provider_id) THEN RAISE EXCEPTION 'Invalid carrier_dz'; END IF;
        WHEN 'freight_forwarder' THEN IF NOT EXISTS (SELECT 1 FROM public.freight_forwarders WHERE id = NEW.provider_id) THEN RAISE EXCEPTION 'Invalid forwarder'; END IF;
        WHEN 'carrier_eu' THEN IF NOT EXISTS (SELECT 1 FROM public.carriers_eu WHERE id = NEW.provider_id) THEN RAISE EXCEPTION 'Invalid carrier_eu'; END IF;
    END CASE; RETURN NEW;
END; $$;


ALTER FUNCTION "public"."validate_quote_provider"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."buyers_eu" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "company_name" character varying(255) NOT NULL,
    "contact_name" character varying(255),
    "email" character varying(255),
    "phone" character varying(50),
    "buyer_type" character varying(50),
    "address" "text",
    "city" character varying(100),
    "country" character varying(100) DEFAULT 'France'::character varying,
    "tax_id" character varying(100),
    "stripe_customer_id" "text",
    "notes" "text",
    "active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."buyers_eu" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."carriers_dz" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "company_name" character varying(255) NOT NULL,
    "contact_name" character varying(255),
    "email" character varying(255),
    "phone" character varying(50),
    "carrier_number" character varying(100),
    "address" "text",
    "city" character varying(100),
    "wilaya" character varying(100),
    "zones_covered" "jsonb" DEFAULT '[]'::"jsonb",
    "transport_capacity" "text",
    "vehicle_types" "jsonb" DEFAULT '[]'::"jsonb",
    "tax_id" character varying(100),
    "bank_details" "jsonb",
    "rating_avg" numeric(2,1) DEFAULT 0,
    "active" boolean DEFAULT true,
    "notes" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "kyc_status" "public"."kyc_status" DEFAULT 'pending'::"public"."kyc_status" NOT NULL,
    "kyc_reviewed_at" timestamp with time zone,
    "kyc_reviewed_by" "uuid"
);


ALTER TABLE "public"."carriers_dz" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."carriers_eu" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "company_name" character varying(255) NOT NULL,
    "contact_name" character varying(255),
    "email" character varying(255),
    "phone" character varying(50),
    "carrier_number" character varying(100),
    "address" "text",
    "city" character varying(100),
    "country" character varying(100) DEFAULT 'France'::character varying,
    "zones_covered" "jsonb" DEFAULT '[]'::"jsonb",
    "transport_capacity" "text",
    "vehicle_types" "jsonb" DEFAULT '[]'::"jsonb",
    "linked_buyer_id" "uuid",
    "tax_id" character varying(100),
    "bank_details" "jsonb",
    "rating_avg" numeric(2,1) DEFAULT 0,
    "active" boolean DEFAULT true,
    "notes" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "kyc_status" "public"."kyc_status" DEFAULT 'pending'::"public"."kyc_status" NOT NULL,
    "kyc_reviewed_at" timestamp with time zone,
    "kyc_reviewed_by" "uuid"
);


ALTER TABLE "public"."carriers_eu" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."chat_messages" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "conversation_id" "uuid" NOT NULL,
    "sender_id" "uuid" NOT NULL,
    "content" "text" NOT NULL,
    "read_by" "jsonb" DEFAULT '[]'::"jsonb",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."chat_messages" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."conversation_participants" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "conversation_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "joined_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."conversation_participants" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."conversations" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "order_id" "uuid",
    "subject" character varying(255),
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."conversations" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."delivery_companies" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "company_name" character varying NOT NULL,
    "contact_name" character varying,
    "email" character varying,
    "phone" character varying,
    "delivery_number" character varying,
    "address" "text",
    "city" character varying,
    "country" character varying DEFAULT 'France'::character varying,
    "zones_covered" "jsonb" DEFAULT '[]'::"jsonb",
    "vehicle_types" "jsonb" DEFAULT '[]'::"jsonb",
    "tax_id" character varying,
    "bank_details" "jsonb",
    "rating_avg" numeric DEFAULT 0,
    "kyc_status" "public"."kyc_status" DEFAULT 'pending'::"public"."kyc_status" NOT NULL,
    "kyc_reviewed_at" timestamp with time zone,
    "kyc_reviewed_by" "uuid",
    "active" boolean DEFAULT true,
    "notes" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."delivery_companies" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."documents" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "order_id" "uuid",
    "doc_type" character varying(100) NOT NULL,
    "file_name" character varying(500),
    "file_url" "text" NOT NULL,
    "file_size" integer,
    "mime_type" character varying(100),
    "uploaded_by" "uuid",
    "visible_to" "jsonb" DEFAULT '["admin"]'::"jsonb",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."documents" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."exchange_rates" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "currency_from" character varying(3) DEFAULT 'EUR'::character varying NOT NULL,
    "currency_to" character varying(3) DEFAULT 'DZD'::character varying NOT NULL,
    "rate" numeric(12,6) NOT NULL,
    "source" character varying(100),
    "rate_date" "date" DEFAULT CURRENT_DATE NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "exchange_rates_rate_check" CHECK (("rate" > (0)::numeric))
);


ALTER TABLE "public"."exchange_rates" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."freight_forwarders" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "company_name" character varying(255) NOT NULL,
    "contact_name" character varying(255),
    "email" character varying(255),
    "phone" character varying(50),
    "license_number" character varying(100),
    "address" "text",
    "city" character varying(100),
    "country" character varying(100),
    "ports_covered" "jsonb" DEFAULT '[]'::"jsonb",
    "services" "jsonb" DEFAULT '[]'::"jsonb",
    "tax_id" character varying(100),
    "bank_details" "jsonb",
    "rating_avg" numeric(2,1) DEFAULT 0,
    "active" boolean DEFAULT true,
    "notes" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "kyc_status" "public"."kyc_status" DEFAULT 'pending'::"public"."kyc_status" NOT NULL,
    "kyc_reviewed_at" timestamp with time zone,
    "kyc_reviewed_by" "uuid"
);


ALTER TABLE "public"."freight_forwarders" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."kyc_documents" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "entity_type" character varying NOT NULL,
    "entity_id" "uuid" NOT NULL,
    "doc_type" character varying NOT NULL,
    "file_name" character varying,
    "file_url" "text" NOT NULL,
    "file_size" integer,
    "mime_type" character varying,
    "uploaded_by" "uuid",
    "status" "public"."kyc_status" DEFAULT 'pending'::"public"."kyc_status" NOT NULL,
    "reviewed_at" timestamp with time zone,
    "reviewed_by" "uuid",
    "rejection_reason" "text",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."kyc_documents" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."notifications" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "title" character varying(255) NOT NULL,
    "message" "text" NOT NULL,
    "type" character varying(50) DEFAULT 'info'::character varying NOT NULL,
    "link" "text",
    "read" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."notifications" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."order_items" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "order_id" "uuid" NOT NULL,
    "supplier_id" "uuid" NOT NULL,
    "product_id" "uuid" NOT NULL,
    "quantity" numeric(12,2) NOT NULL,
    "unit_price_dzd" numeric(12,2) NOT NULL,
    "unit_price_eur" numeric(12,2),
    "subtotal_eur" numeric(12,2) GENERATED ALWAYS AS (("quantity" * COALESCE("unit_price_eur", (0)::numeric))) STORED,
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "order_items_quantity_check" CHECK (("quantity" > (0)::numeric)),
    CONSTRAINT "order_items_unit_price_dzd_check" CHECK (("unit_price_dzd" >= (0)::numeric)),
    CONSTRAINT "order_items_unit_price_eur_check" CHECK (("unit_price_eur" >= (0)::numeric))
);


ALTER TABLE "public"."order_items" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."orders" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "buyer_id" "uuid" NOT NULL,
    "status" character varying(50) DEFAULT 'draft'::character varying,
    "total_amount_eur" numeric(12,2),
    "total_amount_dzd" numeric(14,2),
    "exchange_rate_id" "uuid",
    "exchange_rate_value" numeric(12,6),
    "notes" "text",
    "confirmed_at" timestamp with time zone,
    "paid_at" timestamp with time zone,
    "delivered_at" timestamp with time zone,
    "cancelled_at" timestamp with time zone,
    "cancellation_reason" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "orders_total_amount_dzd_check" CHECK (("total_amount_dzd" >= (0)::numeric)),
    CONSTRAINT "orders_total_amount_eur_check" CHECK (("total_amount_eur" >= (0)::numeric))
);


ALTER TABLE "public"."orders" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."payments" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "order_id" "uuid" NOT NULL,
    "stripe_payment_id" "text",
    "amount_eur" numeric(12,2) NOT NULL,
    "status" character varying(50) DEFAULT 'pending'::character varying,
    "paid_at" timestamp with time zone,
    "metadata" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "payments_amount_eur_check" CHECK (("amount_eur" > (0)::numeric))
);


ALTER TABLE "public"."payments" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."payouts" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "order_id" "uuid" NOT NULL,
    "payee_type" character varying(50) NOT NULL,
    "payee_id" "uuid" NOT NULL,
    "amount_eur" numeric(12,2) NOT NULL,
    "amount_dzd" numeric(14,2),
    "status" character varying(50) DEFAULT 'pending'::character varying,
    "method" character varying(50) DEFAULT 'BEA_virement'::character varying,
    "reference" "text",
    "sent_at" timestamp with time zone,
    "confirmed_at" timestamp with time zone,
    "notes" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "payouts_amount_eur_check" CHECK (("amount_eur" > (0)::numeric))
);


ALTER TABLE "public"."payouts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."products_catalog" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "supplier_id" "uuid" NOT NULL,
    "product_name" character varying(255) NOT NULL,
    "category" character varying(100),
    "description" "text",
    "unit" character varying(50) DEFAULT 'kg'::character varying NOT NULL,
    "price_dzd" numeric(12,2) NOT NULL,
    "min_order_qty" numeric(12,2),
    "available_qty" numeric(12,2),
    "image_url" "text",
    "active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "products_catalog_available_qty_check" CHECK (("available_qty" >= (0)::numeric)),
    CONSTRAINT "products_catalog_min_order_qty_check" CHECK (("min_order_qty" >= (0)::numeric)),
    CONSTRAINT "products_catalog_price_dzd_check" CHECK (("price_dzd" >= (0)::numeric))
);


ALTER TABLE "public"."products_catalog" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."quote_requests" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "order_id" "uuid" NOT NULL,
    "supplier_id" "uuid" NOT NULL,
    "transport_mode" character varying(50),
    "status" character varying(50) DEFAULT 'open'::character varying,
    "deadline" "date",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."quote_requests" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."quotes" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "quote_request_id" "uuid" NOT NULL,
    "provider_type" character varying(50) NOT NULL,
    "provider_id" "uuid" NOT NULL,
    "price_eur" numeric(12,2) NOT NULL,
    "price_breakdown" "jsonb",
    "estimated_days" integer,
    "status" character varying(50) DEFAULT 'pending'::character varying,
    "valid_until" "date",
    "notes" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "quotes_estimated_days_check" CHECK (("estimated_days" > 0)),
    CONSTRAINT "quotes_price_eur_check" CHECK (("price_eur" >= (0)::numeric))
);


ALTER TABLE "public"."quotes" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."reviews" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "order_id" "uuid",
    "reviewer_id" "uuid" NOT NULL,
    "target_type" character varying(50) NOT NULL,
    "target_id" "uuid" NOT NULL,
    "rating" integer NOT NULL,
    "comment" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "reviews_rating_check" CHECK ((("rating" >= 1) AND ("rating" <= 5)))
);


ALTER TABLE "public"."reviews" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."suppliers" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "company_name" character varying(255) NOT NULL,
    "contact_name" character varying(255),
    "email" character varying(255),
    "phone" character varying(50),
    "supplier_number" character varying(100),
    "address" "text",
    "city" character varying(100),
    "wilaya" character varying(100),
    "product_categories" "jsonb" DEFAULT '[]'::"jsonb",
    "certifications" "jsonb" DEFAULT '[]'::"jsonb",
    "tax_id" character varying(100),
    "bank_details" "jsonb",
    "rating_avg" numeric(2,1) DEFAULT 0,
    "notes" "text",
    "active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "kyc_status" "public"."kyc_status" DEFAULT 'pending'::"public"."kyc_status" NOT NULL,
    "kyc_reviewed_at" timestamp with time zone,
    "kyc_reviewed_by" "uuid"
);


ALTER TABLE "public"."suppliers" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_roles" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "role" "public"."app_role" NOT NULL,
    "granted_at" timestamp with time zone DEFAULT "now"(),
    "granted_by" "uuid"
);


ALTER TABLE "public"."user_roles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."wilayas" (
    "code" character varying(2) NOT NULL,
    "name_fr" character varying(100) NOT NULL,
    "name_en" character varying(100) NOT NULL,
    "name_ar" character varying(100) NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."wilayas" OWNER TO "postgres";


ALTER TABLE ONLY "public"."buyers_eu"
    ADD CONSTRAINT "buyers_eu_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."carriers_dz"
    ADD CONSTRAINT "carriers_dz_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."carriers_eu"
    ADD CONSTRAINT "carriers_eu_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."chat_messages"
    ADD CONSTRAINT "chat_messages_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."conversation_participants"
    ADD CONSTRAINT "conv_participants_unique" UNIQUE ("conversation_id", "user_id");



ALTER TABLE ONLY "public"."conversation_participants"
    ADD CONSTRAINT "conversation_participants_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."conversations"
    ADD CONSTRAINT "conversations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."delivery_companies"
    ADD CONSTRAINT "delivery_companies_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."documents"
    ADD CONSTRAINT "documents_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."exchange_rates"
    ADD CONSTRAINT "exchange_rates_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."exchange_rates"
    ADD CONSTRAINT "exchange_rates_unique_date" UNIQUE ("currency_from", "currency_to", "rate_date");



ALTER TABLE ONLY "public"."freight_forwarders"
    ADD CONSTRAINT "freight_forwarders_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."kyc_documents"
    ADD CONSTRAINT "kyc_documents_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."notifications"
    ADD CONSTRAINT "notifications_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."order_items"
    ADD CONSTRAINT "order_items_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."orders"
    ADD CONSTRAINT "orders_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."payments"
    ADD CONSTRAINT "payments_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."payouts"
    ADD CONSTRAINT "payouts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."products_catalog"
    ADD CONSTRAINT "products_catalog_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."quote_requests"
    ADD CONSTRAINT "quote_requests_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."quotes"
    ADD CONSTRAINT "quotes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."reviews"
    ADD CONSTRAINT "reviews_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."reviews"
    ADD CONSTRAINT "reviews_unique" UNIQUE ("order_id", "reviewer_id", "target_type", "target_id");



ALTER TABLE ONLY "public"."suppliers"
    ADD CONSTRAINT "suppliers_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_user_id_role_key" UNIQUE ("user_id", "role");



ALTER TABLE ONLY "public"."wilayas"
    ADD CONSTRAINT "wilayas_pkey" PRIMARY KEY ("code");



CREATE INDEX "idx_buyers_eu_user_id" ON "public"."buyers_eu" USING "btree" ("user_id");



CREATE INDEX "idx_carriers_dz_user_id" ON "public"."carriers_dz" USING "btree" ("user_id");



CREATE INDEX "idx_carriers_eu_user_id" ON "public"."carriers_eu" USING "btree" ("user_id");



CREATE INDEX "idx_chat_conv" ON "public"."chat_messages" USING "btree" ("conversation_id");



CREATE INDEX "idx_conv_participants_user" ON "public"."conversation_participants" USING "btree" ("user_id");



CREATE INDEX "idx_documents_order" ON "public"."documents" USING "btree" ("order_id");



CREATE INDEX "idx_freight_forwarders_user_id" ON "public"."freight_forwarders" USING "btree" ("user_id");



CREATE INDEX "idx_order_items_order" ON "public"."order_items" USING "btree" ("order_id");



CREATE INDEX "idx_orders_buyer" ON "public"."orders" USING "btree" ("buyer_id");



CREATE INDEX "idx_payments_order" ON "public"."payments" USING "btree" ("order_id");



CREATE INDEX "idx_payouts_order" ON "public"."payouts" USING "btree" ("order_id");



CREATE INDEX "idx_products_catalog_active_category" ON "public"."products_catalog" USING "btree" ("active", "category");



CREATE INDEX "idx_products_supplier" ON "public"."products_catalog" USING "btree" ("supplier_id");



CREATE INDEX "idx_qr_order" ON "public"."quote_requests" USING "btree" ("order_id");



CREATE INDEX "idx_quotes_request" ON "public"."quotes" USING "btree" ("quote_request_id");



CREATE INDEX "idx_reviews_target" ON "public"."reviews" USING "btree" ("target_type", "target_id");



CREATE INDEX "idx_suppliers_user_id" ON "public"."suppliers" USING "btree" ("user_id");



CREATE OR REPLACE TRIGGER "trigger_update_rating_avg" AFTER INSERT OR DELETE OR UPDATE ON "public"."reviews" FOR EACH ROW EXECUTE FUNCTION "public"."update_rating_avg"();



CREATE OR REPLACE TRIGGER "update_buyers_eu_updated_at" BEFORE UPDATE ON "public"."buyers_eu" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_carriers_dz_updated_at" BEFORE UPDATE ON "public"."carriers_dz" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_carriers_eu_updated_at" BEFORE UPDATE ON "public"."carriers_eu" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_conversations_updated_at" BEFORE UPDATE ON "public"."conversations" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_freight_forwarders_updated_at" BEFORE UPDATE ON "public"."freight_forwarders" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_orders_updated_at" BEFORE UPDATE ON "public"."orders" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_products_catalog_updated_at" BEFORE UPDATE ON "public"."products_catalog" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_suppliers_updated_at" BEFORE UPDATE ON "public"."suppliers" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "validate_payout_payee_trigger" BEFORE INSERT OR UPDATE ON "public"."payouts" FOR EACH ROW EXECUTE FUNCTION "public"."validate_payout_payee"();



CREATE OR REPLACE TRIGGER "validate_quote_provider_trigger" BEFORE INSERT OR UPDATE ON "public"."quotes" FOR EACH ROW EXECUTE FUNCTION "public"."validate_quote_provider"();



ALTER TABLE ONLY "public"."buyers_eu"
    ADD CONSTRAINT "buyers_eu_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."carriers_dz"
    ADD CONSTRAINT "carriers_dz_kyc_reviewed_by_fkey" FOREIGN KEY ("kyc_reviewed_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."carriers_dz"
    ADD CONSTRAINT "carriers_dz_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."carriers_eu"
    ADD CONSTRAINT "carriers_eu_kyc_reviewed_by_fkey" FOREIGN KEY ("kyc_reviewed_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."carriers_eu"
    ADD CONSTRAINT "carriers_eu_linked_buyer_fkey" FOREIGN KEY ("linked_buyer_id") REFERENCES "public"."buyers_eu"("id");



ALTER TABLE ONLY "public"."carriers_eu"
    ADD CONSTRAINT "carriers_eu_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."chat_messages"
    ADD CONSTRAINT "chat_messages_conversation_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "public"."conversations"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_messages"
    ADD CONSTRAINT "chat_messages_sender_id_fkey" FOREIGN KEY ("sender_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."conversation_participants"
    ADD CONSTRAINT "conversation_participants_conversation_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "public"."conversations"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."conversation_participants"
    ADD CONSTRAINT "conversation_participants_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."conversations"
    ADD CONSTRAINT "conversations_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id");



ALTER TABLE ONLY "public"."delivery_companies"
    ADD CONSTRAINT "delivery_companies_kyc_reviewed_by_fkey" FOREIGN KEY ("kyc_reviewed_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."delivery_companies"
    ADD CONSTRAINT "delivery_companies_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."documents"
    ADD CONSTRAINT "documents_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id");



ALTER TABLE ONLY "public"."documents"
    ADD CONSTRAINT "documents_uploaded_by_fkey" FOREIGN KEY ("uploaded_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."freight_forwarders"
    ADD CONSTRAINT "freight_forwarders_kyc_reviewed_by_fkey" FOREIGN KEY ("kyc_reviewed_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."freight_forwarders"
    ADD CONSTRAINT "freight_forwarders_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."kyc_documents"
    ADD CONSTRAINT "kyc_documents_reviewed_by_fkey" FOREIGN KEY ("reviewed_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."kyc_documents"
    ADD CONSTRAINT "kyc_documents_uploaded_by_fkey" FOREIGN KEY ("uploaded_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."notifications"
    ADD CONSTRAINT "notifications_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."order_items"
    ADD CONSTRAINT "order_items_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."order_items"
    ADD CONSTRAINT "order_items_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."products_catalog"("id");



ALTER TABLE ONLY "public"."order_items"
    ADD CONSTRAINT "order_items_supplier_id_fkey" FOREIGN KEY ("supplier_id") REFERENCES "public"."suppliers"("id");



ALTER TABLE ONLY "public"."orders"
    ADD CONSTRAINT "orders_buyer_id_fkey" FOREIGN KEY ("buyer_id") REFERENCES "public"."buyers_eu"("id");



ALTER TABLE ONLY "public"."orders"
    ADD CONSTRAINT "orders_exchange_rate_id_fkey" FOREIGN KEY ("exchange_rate_id") REFERENCES "public"."exchange_rates"("id");



ALTER TABLE ONLY "public"."payments"
    ADD CONSTRAINT "payments_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id");



ALTER TABLE ONLY "public"."payouts"
    ADD CONSTRAINT "payouts_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id");



ALTER TABLE ONLY "public"."products_catalog"
    ADD CONSTRAINT "products_catalog_supplier_id_fkey" FOREIGN KEY ("supplier_id") REFERENCES "public"."suppliers"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."quote_requests"
    ADD CONSTRAINT "quote_requests_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."quote_requests"
    ADD CONSTRAINT "quote_requests_supplier_id_fkey" FOREIGN KEY ("supplier_id") REFERENCES "public"."suppliers"("id");



ALTER TABLE ONLY "public"."quotes"
    ADD CONSTRAINT "quotes_quote_request_id_fkey" FOREIGN KEY ("quote_request_id") REFERENCES "public"."quote_requests"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."reviews"
    ADD CONSTRAINT "reviews_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id");



ALTER TABLE ONLY "public"."reviews"
    ADD CONSTRAINT "reviews_reviewer_id_fkey" FOREIGN KEY ("reviewer_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."suppliers"
    ADD CONSTRAINT "suppliers_kyc_reviewed_by_fkey" FOREIGN KEY ("kyc_reviewed_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."suppliers"
    ADD CONSTRAINT "suppliers_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_granted_by_fkey" FOREIGN KEY ("granted_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id");



ALTER TABLE "public"."buyers_eu" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."carriers_dz" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."carriers_eu" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."chat_messages" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "conv_insert" ON "public"."conversations" FOR INSERT WITH CHECK (("public"."is_admin"() OR ("order_id" IN ( SELECT "orders"."id"
   FROM "public"."orders"
  WHERE ("orders"."buyer_id" IN ( SELECT "buyers_eu"."id"
           FROM "public"."buyers_eu"
          WHERE ("buyers_eu"."user_id" = "auth"."uid"()))))) OR ("order_id" IN ( SELECT "order_items"."order_id"
   FROM "public"."order_items"
  WHERE ("order_items"."supplier_id" IN ( SELECT "suppliers"."id"
           FROM "public"."suppliers"
          WHERE ("suppliers"."user_id" = "auth"."uid"())))))));



CREATE POLICY "conv_select" ON "public"."conversations" FOR SELECT USING (("public"."is_admin"() OR ("id" IN ( SELECT "conversation_participants"."conversation_id"
   FROM "public"."conversation_participants"
  WHERE ("conversation_participants"."user_id" = "auth"."uid"())))));



ALTER TABLE "public"."conversation_participants" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."conversations" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."delivery_companies" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "docs_delete" ON "public"."documents" FOR DELETE USING ("public"."is_admin"());



CREATE POLICY "docs_insert" ON "public"."documents" FOR INSERT WITH CHECK (("public"."is_admin"() OR ("uploaded_by" = "auth"."uid"())));



CREATE POLICY "docs_select" ON "public"."documents" FOR SELECT USING (("public"."is_admin"() OR ("order_id" IN ( SELECT "orders"."id"
   FROM "public"."orders"
  WHERE ("orders"."buyer_id" IN ( SELECT "buyers_eu"."id"
           FROM "public"."buyers_eu"
          WHERE ("buyers_eu"."user_id" = "auth"."uid"()))))) OR ("uploaded_by" = "auth"."uid"()) OR ("visible_to" @> '["admin"]'::"jsonb") OR ("visible_to" @> "to_jsonb"(("auth"."uid"())::"text"))));



CREATE POLICY "docs_update" ON "public"."documents" FOR UPDATE USING (("public"."is_admin"() OR ("uploaded_by" = "auth"."uid"())));



ALTER TABLE "public"."documents" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."exchange_rates" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."freight_forwarders" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "items_manage" ON "public"."order_items" USING (("public"."is_admin"() OR ("order_id" IN ( SELECT "orders"."id"
   FROM "public"."orders"
  WHERE (("orders"."buyer_id" IN ( SELECT "buyers_eu"."id"
           FROM "public"."buyers_eu"
          WHERE ("buyers_eu"."user_id" = "auth"."uid"()))) AND (("orders"."status")::"text" = ANY ((ARRAY['draft'::character varying, 'quotes_requested'::character varying, 'quotes_received'::character varying])::"text"[])))))));



CREATE POLICY "items_select" ON "public"."order_items" FOR SELECT USING (("public"."is_admin"() OR ("order_id" IN ( SELECT "orders"."id"
   FROM "public"."orders"
  WHERE ("orders"."buyer_id" IN ( SELECT "buyers_eu"."id"
           FROM "public"."buyers_eu"
          WHERE ("buyers_eu"."user_id" = "auth"."uid"()))))) OR ("supplier_id" IN ( SELECT "suppliers"."id"
   FROM "public"."suppliers"
  WHERE ("suppliers"."user_id" = "auth"."uid"())))));



ALTER TABLE "public"."kyc_documents" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "msg_insert" ON "public"."chat_messages" FOR INSERT WITH CHECK (("public"."is_admin"() OR ("conversation_id" IN ( SELECT "conversation_participants"."conversation_id"
   FROM "public"."conversation_participants"
  WHERE ("conversation_participants"."user_id" = "auth"."uid"())))));



CREATE POLICY "msg_select" ON "public"."chat_messages" FOR SELECT USING (("public"."is_admin"() OR ("conversation_id" IN ( SELECT "conversation_participants"."conversation_id"
   FROM "public"."conversation_participants"
  WHERE ("conversation_participants"."user_id" = "auth"."uid"())))));



ALTER TABLE "public"."notifications" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "notifications_insert" ON "public"."notifications" FOR INSERT WITH CHECK (false);



CREATE POLICY "notifications_select" ON "public"."notifications" FOR SELECT USING (("user_id" = "auth"."uid"()));



CREATE POLICY "notifications_update" ON "public"."notifications" FOR UPDATE USING (("user_id" = "auth"."uid"()));



ALTER TABLE "public"."order_items" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."orders" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "orders_delete" ON "public"."orders" FOR DELETE USING ("public"."is_admin"());



CREATE POLICY "orders_insert" ON "public"."orders" FOR INSERT WITH CHECK (("public"."is_admin"() OR ("buyer_id" IN ( SELECT "buyers_eu"."id"
   FROM "public"."buyers_eu"
  WHERE ("buyers_eu"."user_id" = "auth"."uid"())))));



CREATE POLICY "orders_select" ON "public"."orders" FOR SELECT USING (("public"."is_admin"() OR ("buyer_id" IN ( SELECT "buyers_eu"."id"
   FROM "public"."buyers_eu"
  WHERE ("buyers_eu"."user_id" = "auth"."uid"())))));



CREATE POLICY "orders_update" ON "public"."orders" FOR UPDATE USING (("public"."is_admin"() OR (("buyer_id" IN ( SELECT "buyers_eu"."id"
   FROM "public"."buyers_eu"
  WHERE ("buyers_eu"."user_id" = "auth"."uid"()))) AND (("status")::"text" = ANY ((ARRAY['draft'::character varying, 'quotes_requested'::character varying, 'quotes_received'::character varying])::"text"[])))));



CREATE POLICY "part_insert" ON "public"."conversation_participants" FOR INSERT WITH CHECK (("public"."is_admin"() OR ("conversation_id" IN ( SELECT "conversations"."id"
   FROM "public"."conversations"
  WHERE (("conversations"."order_id" IN ( SELECT "orders"."id"
           FROM "public"."orders"
          WHERE ("orders"."buyer_id" IN ( SELECT "buyers_eu"."id"
                   FROM "public"."buyers_eu"
                  WHERE ("buyers_eu"."user_id" = "auth"."uid"()))))) OR ("conversations"."order_id" IN ( SELECT "order_items"."order_id"
           FROM "public"."order_items"
          WHERE ("order_items"."supplier_id" IN ( SELECT "suppliers"."id"
                   FROM "public"."suppliers"
                  WHERE ("suppliers"."user_id" = "auth"."uid"()))))))))));



CREATE POLICY "part_select" ON "public"."conversation_participants" FOR SELECT USING (("public"."is_admin"() OR ("user_id" = "auth"."uid"())));



ALTER TABLE "public"."payments" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "payments_select" ON "public"."payments" FOR SELECT USING (("public"."is_admin"() OR ("order_id" IN ( SELECT "orders"."id"
   FROM "public"."orders"
  WHERE ("orders"."buyer_id" IN ( SELECT "buyers_eu"."id"
           FROM "public"."buyers_eu"
          WHERE ("buyers_eu"."user_id" = "auth"."uid"())))))));



ALTER TABLE "public"."payouts" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "payouts_admin_only" ON "public"."payouts" USING ("public"."is_admin"());



ALTER TABLE "public"."products_catalog" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "products_manage" ON "public"."products_catalog" USING (("public"."is_admin"() OR ("supplier_id" IN ( SELECT "suppliers"."id"
   FROM "public"."suppliers"
  WHERE ("suppliers"."user_id" = "auth"."uid"())))));



CREATE POLICY "products_public_read" ON "public"."products_catalog" FOR SELECT USING (true);



CREATE POLICY "profiles_insert" ON "public"."buyers_eu" FOR INSERT WITH CHECK ((("user_id" = "auth"."uid"()) OR (CURRENT_USER = ANY (ARRAY['postgres'::"name", 'authenticator'::"name"]))));



CREATE POLICY "profiles_insert" ON "public"."carriers_dz" FOR INSERT WITH CHECK ((("user_id" = "auth"."uid"()) OR (CURRENT_USER = ANY (ARRAY['postgres'::"name", 'authenticator'::"name"]))));



CREATE POLICY "profiles_insert" ON "public"."carriers_eu" FOR INSERT WITH CHECK ((("user_id" = "auth"."uid"()) OR (CURRENT_USER = ANY (ARRAY['postgres'::"name", 'authenticator'::"name"]))));



CREATE POLICY "profiles_insert" ON "public"."freight_forwarders" FOR INSERT WITH CHECK ((("user_id" = "auth"."uid"()) OR (CURRENT_USER = ANY (ARRAY['postgres'::"name", 'authenticator'::"name"]))));



CREATE POLICY "profiles_insert" ON "public"."suppliers" FOR INSERT WITH CHECK ((("user_id" = "auth"."uid"()) OR (CURRENT_USER = ANY (ARRAY['postgres'::"name", 'authenticator'::"name"]))));



CREATE POLICY "profiles_select" ON "public"."buyers_eu" FOR SELECT USING (("public"."is_admin"() OR ("user_id" = "auth"."uid"())));



CREATE POLICY "profiles_select" ON "public"."carriers_dz" FOR SELECT USING (("public"."is_admin"() OR ("user_id" = "auth"."uid"())));



CREATE POLICY "profiles_select" ON "public"."carriers_eu" FOR SELECT USING (("public"."is_admin"() OR ("user_id" = "auth"."uid"())));



CREATE POLICY "profiles_select" ON "public"."freight_forwarders" FOR SELECT USING (("public"."is_admin"() OR ("user_id" = "auth"."uid"())));



CREATE POLICY "profiles_select" ON "public"."suppliers" FOR SELECT USING (("public"."is_admin"() OR ("user_id" = "auth"."uid"())));



CREATE POLICY "profiles_update" ON "public"."buyers_eu" FOR UPDATE USING (("public"."is_admin"() OR ("user_id" = "auth"."uid"())));



CREATE POLICY "profiles_update" ON "public"."carriers_dz" FOR UPDATE USING (("public"."is_admin"() OR ("user_id" = "auth"."uid"())));



CREATE POLICY "profiles_update" ON "public"."carriers_eu" FOR UPDATE USING (("public"."is_admin"() OR ("user_id" = "auth"."uid"())));



CREATE POLICY "profiles_update" ON "public"."freight_forwarders" FOR UPDATE USING (("public"."is_admin"() OR ("user_id" = "auth"."uid"())));



CREATE POLICY "profiles_update" ON "public"."suppliers" FOR UPDATE USING (("public"."is_admin"() OR ("user_id" = "auth"."uid"())));



CREATE POLICY "qr_delete" ON "public"."quote_requests" FOR DELETE USING ("public"."is_admin"());



CREATE POLICY "qr_insert" ON "public"."quote_requests" FOR INSERT WITH CHECK (("public"."is_admin"() OR ("order_id" IN ( SELECT "orders"."id"
   FROM "public"."orders"
  WHERE ("orders"."buyer_id" IN ( SELECT "buyers_eu"."id"
           FROM "public"."buyers_eu"
          WHERE ("buyers_eu"."user_id" = "auth"."uid"())))))));



CREATE POLICY "qr_select" ON "public"."quote_requests" FOR SELECT USING (("public"."is_admin"() OR ("order_id" IN ( SELECT "orders"."id"
   FROM "public"."orders"
  WHERE ("orders"."buyer_id" IN ( SELECT "buyers_eu"."id"
           FROM "public"."buyers_eu"
          WHERE ("buyers_eu"."user_id" = "auth"."uid"()))))) OR ("supplier_id" IN ( SELECT "suppliers"."id"
   FROM "public"."suppliers"
  WHERE ("suppliers"."user_id" = "auth"."uid"()))) OR (("status")::"text" = 'open'::"text")));



CREATE POLICY "qr_update" ON "public"."quote_requests" FOR UPDATE USING (("public"."is_admin"() OR (("order_id" IN ( SELECT "orders"."id"
   FROM "public"."orders"
  WHERE ("orders"."buyer_id" IN ( SELECT "buyers_eu"."id"
           FROM "public"."buyers_eu"
          WHERE ("buyers_eu"."user_id" = "auth"."uid"()))))) AND (("status")::"text" = ANY ((ARRAY['open'::character varying, 'quoted'::character varying])::"text"[])))));



ALTER TABLE "public"."quote_requests" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."quotes" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "quotes_delete" ON "public"."quotes" FOR DELETE USING ((("public"."is_current_user_actor"(("provider_type")::"text", "provider_id") AND (("status")::"text" = 'pending'::"text")) OR "public"."is_admin"()));



CREATE POLICY "quotes_insert" ON "public"."quotes" FOR INSERT WITH CHECK (("public"."is_admin"() OR "public"."is_current_user_actor"(("provider_type")::"text", "provider_id")));



CREATE POLICY "quotes_select" ON "public"."quotes" FOR SELECT USING (("public"."is_admin"() OR "public"."is_current_user_actor"(("provider_type")::"text", "provider_id") OR ("quote_request_id" IN ( SELECT "quote_requests"."id"
   FROM "public"."quote_requests"
  WHERE (("quote_requests"."order_id" IN ( SELECT "orders"."id"
           FROM "public"."orders"
          WHERE ("orders"."buyer_id" IN ( SELECT "buyers_eu"."id"
                   FROM "public"."buyers_eu"
                  WHERE ("buyers_eu"."user_id" = "auth"."uid"()))))) OR ("quote_requests"."supplier_id" IN ( SELECT "suppliers"."id"
           FROM "public"."suppliers"
          WHERE ("suppliers"."user_id" = "auth"."uid"()))))))));



CREATE POLICY "quotes_update" ON "public"."quotes" FOR UPDATE USING ((("public"."is_current_user_actor"(("provider_type")::"text", "provider_id") AND (("status")::"text" = 'pending'::"text")) OR "public"."is_admin"()));



CREATE POLICY "rates_public_read" ON "public"."exchange_rates" FOR SELECT USING (true);



ALTER TABLE "public"."reviews" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "reviews_insert" ON "public"."reviews" FOR INSERT WITH CHECK (("public"."is_admin"() OR ("order_id" IN ( SELECT "orders"."id"
   FROM "public"."orders"
  WHERE ("orders"."buyer_id" IN ( SELECT "buyers_eu"."id"
           FROM "public"."buyers_eu"
          WHERE ("buyers_eu"."user_id" = "auth"."uid"())))))));



CREATE POLICY "reviews_select" ON "public"."reviews" FOR SELECT USING (("public"."is_admin"() OR ("order_id" IN ( SELECT "orders"."id"
   FROM "public"."orders"
  WHERE ("orders"."buyer_id" IN ( SELECT "buyers_eu"."id"
           FROM "public"."buyers_eu"
          WHERE ("buyers_eu"."user_id" = "auth"."uid"()))))) OR "public"."is_current_user_actor"(("target_type")::"text", "target_id")));



ALTER TABLE "public"."suppliers" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."user_roles" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."wilayas" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "wilayas_public_read" ON "public"."wilayas" FOR SELECT USING (true);





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";






















































































































































GRANT ALL ON FUNCTION "public"."get_public_catalogue_categories"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_public_catalogue_categories"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_public_catalogue_categories"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_public_catalogue_products"("search_text" "text", "category_filter" "text", "limit_count" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."get_public_catalogue_products"("search_text" "text", "category_filter" "text", "limit_count" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_public_catalogue_products"("search_text" "text", "category_filter" "text", "limit_count" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";



GRANT ALL ON FUNCTION "public"."is_admin"() TO "anon";
GRANT ALL ON FUNCTION "public"."is_admin"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_admin"() TO "service_role";



GRANT ALL ON FUNCTION "public"."is_current_user_actor"("p_type" "text", "p_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."is_current_user_actor"("p_type" "text", "p_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_current_user_actor"("p_type" "text", "p_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."update_rating_avg"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_rating_avg"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_rating_avg"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "service_role";



GRANT ALL ON FUNCTION "public"."validate_payout_payee"() TO "anon";
GRANT ALL ON FUNCTION "public"."validate_payout_payee"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."validate_payout_payee"() TO "service_role";



GRANT ALL ON FUNCTION "public"."validate_quote_provider"() TO "anon";
GRANT ALL ON FUNCTION "public"."validate_quote_provider"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."validate_quote_provider"() TO "service_role";


















GRANT ALL ON TABLE "public"."buyers_eu" TO "anon";
GRANT ALL ON TABLE "public"."buyers_eu" TO "authenticated";
GRANT ALL ON TABLE "public"."buyers_eu" TO "service_role";



GRANT ALL ON TABLE "public"."carriers_dz" TO "anon";
GRANT ALL ON TABLE "public"."carriers_dz" TO "authenticated";
GRANT ALL ON TABLE "public"."carriers_dz" TO "service_role";



GRANT ALL ON TABLE "public"."carriers_eu" TO "anon";
GRANT ALL ON TABLE "public"."carriers_eu" TO "authenticated";
GRANT ALL ON TABLE "public"."carriers_eu" TO "service_role";



GRANT ALL ON TABLE "public"."chat_messages" TO "anon";
GRANT ALL ON TABLE "public"."chat_messages" TO "authenticated";
GRANT ALL ON TABLE "public"."chat_messages" TO "service_role";



GRANT ALL ON TABLE "public"."conversation_participants" TO "anon";
GRANT ALL ON TABLE "public"."conversation_participants" TO "authenticated";
GRANT ALL ON TABLE "public"."conversation_participants" TO "service_role";



GRANT ALL ON TABLE "public"."conversations" TO "anon";
GRANT ALL ON TABLE "public"."conversations" TO "authenticated";
GRANT ALL ON TABLE "public"."conversations" TO "service_role";



GRANT ALL ON TABLE "public"."delivery_companies" TO "anon";
GRANT ALL ON TABLE "public"."delivery_companies" TO "authenticated";
GRANT ALL ON TABLE "public"."delivery_companies" TO "service_role";



GRANT ALL ON TABLE "public"."documents" TO "anon";
GRANT ALL ON TABLE "public"."documents" TO "authenticated";
GRANT ALL ON TABLE "public"."documents" TO "service_role";



GRANT ALL ON TABLE "public"."exchange_rates" TO "anon";
GRANT ALL ON TABLE "public"."exchange_rates" TO "authenticated";
GRANT ALL ON TABLE "public"."exchange_rates" TO "service_role";



GRANT ALL ON TABLE "public"."freight_forwarders" TO "anon";
GRANT ALL ON TABLE "public"."freight_forwarders" TO "authenticated";
GRANT ALL ON TABLE "public"."freight_forwarders" TO "service_role";



GRANT ALL ON TABLE "public"."kyc_documents" TO "anon";
GRANT ALL ON TABLE "public"."kyc_documents" TO "authenticated";
GRANT ALL ON TABLE "public"."kyc_documents" TO "service_role";



GRANT ALL ON TABLE "public"."notifications" TO "anon";
GRANT ALL ON TABLE "public"."notifications" TO "authenticated";
GRANT ALL ON TABLE "public"."notifications" TO "service_role";



GRANT ALL ON TABLE "public"."order_items" TO "anon";
GRANT ALL ON TABLE "public"."order_items" TO "authenticated";
GRANT ALL ON TABLE "public"."order_items" TO "service_role";



GRANT ALL ON TABLE "public"."orders" TO "anon";
GRANT ALL ON TABLE "public"."orders" TO "authenticated";
GRANT ALL ON TABLE "public"."orders" TO "service_role";



GRANT ALL ON TABLE "public"."payments" TO "anon";
GRANT ALL ON TABLE "public"."payments" TO "authenticated";
GRANT ALL ON TABLE "public"."payments" TO "service_role";



GRANT ALL ON TABLE "public"."payouts" TO "anon";
GRANT ALL ON TABLE "public"."payouts" TO "authenticated";
GRANT ALL ON TABLE "public"."payouts" TO "service_role";



GRANT ALL ON TABLE "public"."products_catalog" TO "anon";
GRANT ALL ON TABLE "public"."products_catalog" TO "authenticated";
GRANT ALL ON TABLE "public"."products_catalog" TO "service_role";



GRANT ALL ON TABLE "public"."quote_requests" TO "anon";
GRANT ALL ON TABLE "public"."quote_requests" TO "authenticated";
GRANT ALL ON TABLE "public"."quote_requests" TO "service_role";



GRANT ALL ON TABLE "public"."quotes" TO "anon";
GRANT ALL ON TABLE "public"."quotes" TO "authenticated";
GRANT ALL ON TABLE "public"."quotes" TO "service_role";



GRANT ALL ON TABLE "public"."reviews" TO "anon";
GRANT ALL ON TABLE "public"."reviews" TO "authenticated";
GRANT ALL ON TABLE "public"."reviews" TO "service_role";



GRANT ALL ON TABLE "public"."suppliers" TO "anon";
GRANT ALL ON TABLE "public"."suppliers" TO "authenticated";
GRANT ALL ON TABLE "public"."suppliers" TO "service_role";



GRANT ALL ON TABLE "public"."user_roles" TO "anon";
GRANT ALL ON TABLE "public"."user_roles" TO "authenticated";
GRANT ALL ON TABLE "public"."user_roles" TO "service_role";



GRANT ALL ON TABLE "public"."wilayas" TO "anon";
GRANT ALL ON TABLE "public"."wilayas" TO "authenticated";
GRANT ALL ON TABLE "public"."wilayas" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";































drop extension if exists "pg_net";

drop policy "items_manage" on "public"."order_items";

drop policy "orders_update" on "public"."orders";

drop policy "qr_update" on "public"."quote_requests";


  create policy "items_manage"
  on "public"."order_items"
  as permissive
  for all
  to public
using ((public.is_admin() OR (order_id IN ( SELECT orders.id
   FROM public.orders
  WHERE ((orders.buyer_id IN ( SELECT buyers_eu.id
           FROM public.buyers_eu
          WHERE (buyers_eu.user_id = auth.uid()))) AND ((orders.status)::text = ANY ((ARRAY['draft'::character varying, 'quotes_requested'::character varying, 'quotes_received'::character varying])::text[])))))));



  create policy "orders_update"
  on "public"."orders"
  as permissive
  for update
  to public
using ((public.is_admin() OR ((buyer_id IN ( SELECT buyers_eu.id
   FROM public.buyers_eu
  WHERE (buyers_eu.user_id = auth.uid()))) AND ((status)::text = ANY ((ARRAY['draft'::character varying, 'quotes_requested'::character varying, 'quotes_received'::character varying])::text[])))));



  create policy "qr_update"
  on "public"."quote_requests"
  as permissive
  for update
  to public
using ((public.is_admin() OR ((order_id IN ( SELECT orders.id
   FROM public.orders
  WHERE (orders.buyer_id IN ( SELECT buyers_eu.id
           FROM public.buyers_eu
          WHERE (buyers_eu.user_id = auth.uid()))))) AND ((status)::text = ANY ((ARRAY['open'::character varying, 'quoted'::character varying])::text[])))));


CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


