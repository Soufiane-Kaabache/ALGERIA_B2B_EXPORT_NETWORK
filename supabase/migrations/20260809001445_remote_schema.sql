


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


CREATE OR REPLACE FUNCTION "public"."current_user_business_id"() RETURNS "uuid"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select business_id
  from public.user_profiles
  where id = auth.uid();
$$;


ALTER FUNCTION "public"."current_user_business_id"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."default_business_type_id"() RETURNS "uuid"
    LANGUAGE "sql" STABLE
    SET "search_path" TO 'public'
    AS $$
  select id from public.business_types where name_en = 'Other';
$$;


ALTER FUNCTION "public"."default_business_type_id"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."default_viewer_role_id"() RETURNS "uuid"
    LANGUAGE "sql" STABLE
    SET "search_path" TO 'public'
    AS $$
  select id from public.user_roles where name = 'viewer';
$$;


ALTER FUNCTION "public"."default_viewer_role_id"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."increment_quote_count"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
begin
  update public.products
  set quote_request_count = quote_request_count + 1
  where id = new.product_id;

  return new;
end;
$$;


ALTER FUNCTION "public"."increment_quote_count"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_platform_admin"() RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select exists (
    select 1
    from public.user_profiles p
    where p.id = auth.uid()
      and p.role_id = (
        select id
        from public.user_roles
        where name = 'platform_admin'
      )
  );
$$;


ALTER FUNCTION "public"."is_platform_admin"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."protect_business_sensitive_fields"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
  if auth.uid() is not null and not public.is_platform_admin() then
    if new.created_by is distinct from old.created_by then
      raise exception 'created_by cannot be changed';
    end if;

    if new.subscription_plan is distinct from old.subscription_plan then
      raise exception 'subscription_plan cannot be changed directly';
    end if;

    if new.validated_at is distinct from old.validated_at then
      raise exception 'validated_at cannot be changed directly';
    end if;

    if new.validated_by is distinct from old.validated_by then
      raise exception 'validated_by cannot be changed directly';
    end if;

    if new.rejection_reason is distinct from old.rejection_reason then
      raise exception 'rejection_reason cannot be changed directly';
    end if;
  end if;

  return new;
end;
$$;


ALTER FUNCTION "public"."protect_business_sensitive_fields"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."protect_user_profile_sensitive_fields"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
  if auth.uid() is not null and not public.is_platform_admin() then
    if new.id is distinct from old.id then
      raise exception 'user_profiles.id cannot be changed';
    end if;

    if new.role_id is distinct from old.role_id then
      raise exception 'role_id cannot be changed directly';
    end if;

    if new.is_active is distinct from old.is_active then
      raise exception 'is_active cannot be changed directly';
    end if;
  end if;

  return new;
end;
$$;


ALTER FUNCTION "public"."protect_user_profile_sensitive_fields"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_business_rating"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
declare
  v_avg numeric(3,2);
  v_count int;
begin
  if tg_op = 'DELETE' then
    select avg(rating), count(*)
    into v_avg, v_count
    from public.business_reviews
    where reviewed_business_id = old.reviewed_business_id;
  else
    select avg(rating), count(*)
    into v_avg, v_count
    from public.business_reviews
    where reviewed_business_id = new.reviewed_business_id;
  end if;

  update public.businesses
  set avg_rating = coalesce(v_avg, 0),
      review_count = coalesce(v_count, 0)
  where id = coalesce(new.reviewed_business_id, old.reviewed_business_id);

  if tg_op = 'DELETE' then
    return old;
  end if;

  return new;
end;
$$;


ALTER FUNCTION "public"."update_business_rating"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_timestamp"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
  new.updated_at = now();
  return new;
end;
$$;


ALTER FUNCTION "public"."update_timestamp"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."validate_dz_phone"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $_$
begin
  if new.phone is not null and new.phone !~ '^0[5-7][0-9]{8}$' then
    raise exception 'Invalid Algerian phone number. Format: 05XXXXXXXX, 06XXXXXXXX or 07XXXXXXXX';
  end if;

  if new.phone2 is not null and new.phone2 !~ '^0[5-7][0-9]{8}$' then
    raise exception 'Invalid Algerian phone number for phone2. Format: 05XXXXXXXX, 06XXXXXXXX or 07XXXXXXXX';
  end if;

  return new;
end;
$_$;


ALTER FUNCTION "public"."validate_dz_phone"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."validate_dz_phone_contact"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $_$
begin
  if new.phone is not null and new.phone !~ '^0[5-7][0-9]{8}$' then
    raise exception 'Invalid Algerian phone number';
  end if;

  if new.whatsapp is not null and new.whatsapp !~ '^0[5-7][0-9]{8}$' then
    raise exception 'Invalid Algerian WhatsApp number';
  end if;

  return new;
end;
$_$;


ALTER FUNCTION "public"."validate_dz_phone_contact"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."action_logs" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "action" character varying(100) NOT NULL,
    "table_name" character varying(50) NOT NULL,
    "record_id" "uuid" NOT NULL,
    "details" "jsonb",
    "ip_address" character varying(45),
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."action_logs" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."activity_sectors" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name_en" character varying(150) NOT NULL,
    "name_ar" character varying(150),
    "is_active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."activity_sectors" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."ads" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "business_id" "uuid" NOT NULL,
    "title_en" character varying(250) NOT NULL,
    "title_ar" character varying(250),
    "content_en" "text",
    "content_ar" "text",
    "image" character varying(255),
    "link" character varying(255),
    "start_date" "date" NOT NULL,
    "end_date" "date" NOT NULL,
    "impression_count" integer DEFAULT 0,
    "click_count" integer DEFAULT 0,
    "status" "public"."ad_status" DEFAULT 'pending'::"public"."ad_status",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."ads" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."articles" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "author_id" "uuid" NOT NULL,
    "title_en" character varying(300) NOT NULL,
    "title_ar" character varying(300),
    "content_en" "text",
    "content_ar" "text",
    "image" character varying(255),
    "slug" character varying(320) NOT NULL,
    "tags" "jsonb",
    "view_count" integer DEFAULT 0,
    "is_published" boolean DEFAULT false,
    "published_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."articles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."business_contacts" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "business_id" "uuid" NOT NULL,
    "first_name" character varying(100) NOT NULL,
    "last_name" character varying(100) NOT NULL,
    "job_title" character varying(150),
    "email" character varying(200),
    "phone" character varying(20),
    "whatsapp" character varying(20),
    "contact_type" "public"."contact_type" DEFAULT 'commercial'::"public"."contact_type",
    "is_primary" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."business_contacts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."business_reviews" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "reviewed_business_id" "uuid" NOT NULL,
    "reviewer_business_id" "uuid" NOT NULL,
    "reviewer_user_id" "uuid" NOT NULL,
    "rating" smallint NOT NULL,
    "product_quality" smallint,
    "deadline_compliance" smallint,
    "communication" smallint,
    "comment" "text",
    "order_id" "uuid",
    "response" "text",
    "responded_at" timestamp with time zone,
    "status" "public"."review_status" DEFAULT 'published'::"public"."review_status",
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "business_reviews_communication_check" CHECK ((("communication" IS NULL) OR (("communication" >= 1) AND ("communication" <= 5)))),
    CONSTRAINT "business_reviews_deadline_compliance_check" CHECK ((("deadline_compliance" IS NULL) OR (("deadline_compliance" >= 1) AND ("deadline_compliance" <= 5)))),
    CONSTRAINT "business_reviews_product_quality_check" CHECK ((("product_quality" IS NULL) OR (("product_quality" >= 1) AND ("product_quality" <= 5)))),
    CONSTRAINT "business_reviews_rating_check" CHECK ((("rating" >= 1) AND ("rating" <= 5)))
);


ALTER TABLE "public"."business_reviews" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."business_types" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name_en" character varying(100) NOT NULL,
    "name_ar" character varying(100),
    "description" "text",
    "is_active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."business_types" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."businesses" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_by" "uuid",
    "trade_name" character varying(200) NOT NULL,
    "legal_name" character varying(200) NOT NULL,
    "nif" character varying(20),
    "nrc" character varying(20),
    "nis" character varying(20),
    "ai" character varying(20),
    "export_register_number" character varying(50),
    "business_type_id" "uuid" DEFAULT "public"."default_business_type_id"() NOT NULL,
    "legal_form" "public"."legal_form" DEFAULT 'sarl'::"public"."legal_form",
    "sector_id" "uuid",
    "creation_date" "date",
    "share_capital" numeric(15,2),
    "employee_count" integer,
    "description" "text",
    "website" character varying(255),
    "logo" character varying(255),
    "cover_photo" character varying(255),
    "certifications" "jsonb",
    "wilaya_code" character varying(2),
    "daira_id" "uuid",
    "commune_id" "uuid",
    "address" "text",
    "latitude" numeric(10,8),
    "longitude" numeric(11,8),
    "phone_country_code" character varying(5) DEFAULT '+213'::character varying,
    "phone" character varying(20),
    "phone2" character varying(20),
    "email" character varying(200),
    "fax" character varying(20),
    "action_radius_km" integer,
    "status" "public"."business_status" DEFAULT 'draft'::"public"."business_status" NOT NULL,
    "rejection_reason" "text",
    "subscription_plan" "public"."subscription_plan" DEFAULT 'free'::"public"."subscription_plan",
    "registered_at" timestamp with time zone DEFAULT "now"(),
    "validated_at" timestamp with time zone,
    "validated_by" "uuid",
    "avg_rating" numeric(3,2) DEFAULT 0,
    "review_count" integer DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."businesses" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."categories" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "parent_id" "uuid",
    "name_en" character varying(150) NOT NULL,
    "name_ar" character varying(150),
    "slug" character varying(180) NOT NULL,
    "icon" character varying(100),
    "image" character varying(255),
    "sort_order" integer DEFAULT 0,
    "is_active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."categories" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."communes" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "daira_id" "uuid" NOT NULL,
    "wilaya_code" character varying(2) NOT NULL,
    "name_en" character varying(150) NOT NULL,
    "name_ar" character varying(150) NOT NULL,
    "postal_code" character varying(5)
);


ALTER TABLE "public"."communes" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."conversations" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "business_a_id" "uuid" NOT NULL,
    "business_b_id" "uuid" NOT NULL,
    "subject" character varying(255),
    "product_id" "uuid",
    "last_message_at" timestamp with time zone,
    "unread_count_a" integer DEFAULT 0,
    "unread_count_b" integer DEFAULT 0,
    "status" "public"."conversation_status" DEFAULT 'active'::"public"."conversation_status",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."conversations" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."countries" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name_en" character varying(100) NOT NULL,
    "name_ar" character varying(100),
    "iso2" character(2) NOT NULL,
    "iso3" character(3) NOT NULL,
    "phone_code" character varying(5),
    "continent" "public"."continent_type" DEFAULT 'africa'::"public"."continent_type"
);


ALTER TABLE "public"."countries" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."dairas" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "wilaya_code" character varying(2) NOT NULL,
    "name_en" character varying(150) NOT NULL,
    "name_ar" character varying(150) NOT NULL,
    "code" character varying(10)
);


ALTER TABLE "public"."dairas" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."forwarding_quotes" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "order_id" "uuid" NOT NULL,
    "forwarder_id" "uuid" NOT NULL,
    "proposed_price" numeric(15,2) NOT NULL,
    "delivery_days" integer,
    "included_documents" "jsonb",
    "conditions" "text",
    "status" "public"."quote_response_status" DEFAULT 'pending'::"public"."quote_response_status",
    "responded_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."forwarding_quotes" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."messages" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "conversation_id" "uuid" NOT NULL,
    "sender_id" "uuid" NOT NULL,
    "content" "text" NOT NULL,
    "attachment" character varying(255),
    "is_read" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."messages" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."notifications" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "type" "public"."notification_type" NOT NULL,
    "title" character varying(200) NOT NULL,
    "content" "text",
    "link" character varying(255),
    "is_read" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."notifications" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."order_lines" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "order_id" "uuid" NOT NULL,
    "product_id" "uuid" NOT NULL,
    "description" character varying(250) NOT NULL,
    "quantity" numeric(15,2) NOT NULL,
    "unit" character varying(30) NOT NULL,
    "unit_price" numeric(15,2) NOT NULL,
    "line_total" numeric(15,2) NOT NULL
);


ALTER TABLE "public"."order_lines" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."orders" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "reference" character varying(30) NOT NULL,
    "quote_request_id" "uuid",
    "buyer_id" "uuid" NOT NULL,
    "seller_id" "uuid" NOT NULL,
    "total_amount" numeric(15,2) NOT NULL,
    "status" "public"."order_status" DEFAULT 'confirmed'::"public"."order_status",
    "confirmed_at" timestamp with time zone,
    "shipped_at" timestamp with time zone,
    "delivered_at" timestamp with time zone,
    "internal_notes" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."orders" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."product_images" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "product_id" "uuid" NOT NULL,
    "file_path" character varying(255) NOT NULL,
    "sort_order" integer DEFAULT 0,
    "is_primary" boolean DEFAULT false
);


ALTER TABLE "public"."product_images" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."product_seq"
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."product_seq" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."product_specifications" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "product_id" "uuid" NOT NULL,
    "name" character varying(150) NOT NULL,
    "value" character varying(255) NOT NULL
);


ALTER TABLE "public"."product_specifications" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."products" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "business_id" "uuid" NOT NULL,
    "category_id" "uuid" NOT NULL,
    "name_en" character varying(250) NOT NULL,
    "name_ar" character varying(250),
    "slug" character varying(280) NOT NULL,
    "description_en" "text",
    "description_ar" "text",
    "reference" character varying(80),
    "hs_code" character varying(20),
    "unit" "public"."measurement_unit" DEFAULT 'unit'::"public"."measurement_unit",
    "min_price" numeric(15,2),
    "max_price" numeric(15,2),
    "min_order_quantity" numeric(15,2),
    "stock_available" numeric(15,2),
    "gross_weight_kg" numeric(10,3),
    "net_weight_kg" numeric(10,3),
    "origin_wilaya_code" character varying(2),
    "storage_conditions" character varying(255),
    "shelf_life" character varying(100),
    "product_certifications" "jsonb",
    "brand" character varying(150),
    "preparation_days" integer,
    "view_count" integer DEFAULT 0,
    "quote_request_count" integer DEFAULT 0,
    "status" "public"."product_status" DEFAULT 'draft'::"public"."product_status",
    "is_featured" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."products" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."quote_requests" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "reference" character varying(30) NOT NULL,
    "buyer_id" "uuid" NOT NULL,
    "seller_id" "uuid" NOT NULL,
    "product_id" "uuid" NOT NULL,
    "requested_quantity" numeric(15,2) NOT NULL,
    "unit" character varying(30) NOT NULL,
    "message" "text",
    "destination_country_id" "uuid",
    "destination_port" character varying(150),
    "desired_delivery_date" "date",
    "incoterm" "public"."incoterm_type" DEFAULT 'FOB'::"public"."incoterm_type",
    "status" "public"."quote_status" DEFAULT 'sent'::"public"."quote_status",
    "responded_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."quote_requests" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."quote_responses" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "quote_request_id" "uuid" NOT NULL,
    "proposed_price" numeric(15,2) NOT NULL,
    "delivery_days" integer,
    "special_conditions" "text",
    "validity_days" integer,
    "attached_file" character varying(255),
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."quote_responses" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."shipment_documents" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "shipment_id" "uuid" NOT NULL,
    "document_type" "public"."shipping_doc_type" NOT NULL,
    "file_path" character varying(255) NOT NULL,
    "document_date" "date",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."shipment_documents" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."shipments" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "order_id" "uuid" NOT NULL,
    "carrier_id" "uuid",
    "forwarder_id" "uuid",
    "transport_mode" "public"."transport_mode" NOT NULL,
    "bl_number" character varying(80),
    "awb_number" character varying(80),
    "cmr_number" character varying(80),
    "departure_port" character varying(150),
    "arrival_port" character varying(150),
    "departure_date" timestamp with time zone,
    "expected_arrival_date" "date",
    "actual_arrival_date" "date",
    "total_weight_kg" numeric(12,3),
    "total_volume_m3" numeric(12,3),
    "package_count" integer,
    "package_type" "public"."package_type",
    "status" "public"."shipment_status" DEFAULT 'preparing'::"public"."shipment_status",
    "tracking_url" character varying(255),
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."shipments" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."subscriptions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "business_id" "uuid" NOT NULL,
    "plan" "public"."subscription_plan" NOT NULL,
    "start_date" "date" NOT NULL,
    "end_date" "date" NOT NULL,
    "amount_paid" numeric(10,2),
    "status" "public"."sub_status" DEFAULT 'active'::"public"."sub_status",
    "payment_method" "public"."payment_method",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."subscriptions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."supplier_documents" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "business_id" "uuid" NOT NULL,
    "document_type" "public"."supplier_doc_type" NOT NULL,
    "file_path" character varying(255) NOT NULL,
    "status" "public"."supplier_doc_status" DEFAULT 'pending'::"public"."supplier_doc_status" NOT NULL,
    "rejection_reason" "text",
    "reviewed_by" "uuid",
    "reviewed_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."supplier_documents" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."transactions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "business_id" "uuid" NOT NULL,
    "subscription_id" "uuid",
    "type" "public"."transaction_type" NOT NULL,
    "amount" numeric(12,2) NOT NULL,
    "payment_reference" character varying(100),
    "method" "public"."payment_method",
    "status" "public"."transaction_status" DEFAULT 'pending'::"public"."transaction_status",
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."transactions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."transport_quotes" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "order_id" "uuid" NOT NULL,
    "carrier_id" "uuid" NOT NULL,
    "proposed_price" numeric(15,2) NOT NULL,
    "delivery_days" integer,
    "conditions" "text",
    "status" "public"."quote_response_status" DEFAULT 'pending'::"public"."quote_response_status",
    "responded_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."transport_quotes" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_profiles" (
    "id" "uuid" NOT NULL,
    "business_id" "uuid",
    "role_id" "uuid" DEFAULT "public"."default_viewer_role_id"() NOT NULL,
    "first_name" character varying(100) NOT NULL,
    "last_name" character varying(100) NOT NULL,
    "phone" character varying(20),
    "photo" character varying(255),
    "job_title" character varying(150),
    "is_active" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."user_profiles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."user_roles" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" character varying(50) NOT NULL,
    "description" "text",
    "access_level" integer DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."user_roles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."wilayas" (
    "code" character varying(2) NOT NULL,
    "name_en" character varying(100) NOT NULL,
    "name_ar" character varying(100) NOT NULL,
    "postal_code_prefix" character varying(2),
    "is_active" boolean DEFAULT true
);


ALTER TABLE "public"."wilayas" OWNER TO "postgres";


ALTER TABLE ONLY "public"."action_logs"
    ADD CONSTRAINT "action_logs_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."activity_sectors"
    ADD CONSTRAINT "activity_sectors_name_en_key" UNIQUE ("name_en");



ALTER TABLE ONLY "public"."activity_sectors"
    ADD CONSTRAINT "activity_sectors_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."ads"
    ADD CONSTRAINT "ads_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."articles"
    ADD CONSTRAINT "articles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."articles"
    ADD CONSTRAINT "articles_slug_key" UNIQUE ("slug");



ALTER TABLE ONLY "public"."business_contacts"
    ADD CONSTRAINT "business_contacts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."business_reviews"
    ADD CONSTRAINT "business_reviews_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."business_types"
    ADD CONSTRAINT "business_types_name_en_key" UNIQUE ("name_en");



ALTER TABLE ONLY "public"."business_types"
    ADD CONSTRAINT "business_types_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."businesses"
    ADD CONSTRAINT "businesses_nif_key" UNIQUE ("nif");



ALTER TABLE ONLY "public"."businesses"
    ADD CONSTRAINT "businesses_nrc_key" UNIQUE ("nrc");



ALTER TABLE ONLY "public"."businesses"
    ADD CONSTRAINT "businesses_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."categories"
    ADD CONSTRAINT "categories_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."categories"
    ADD CONSTRAINT "categories_slug_key" UNIQUE ("slug");



ALTER TABLE ONLY "public"."communes"
    ADD CONSTRAINT "communes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."conversations"
    ADD CONSTRAINT "conversations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."countries"
    ADD CONSTRAINT "countries_iso2_key" UNIQUE ("iso2");



ALTER TABLE ONLY "public"."countries"
    ADD CONSTRAINT "countries_iso3_key" UNIQUE ("iso3");



ALTER TABLE ONLY "public"."countries"
    ADD CONSTRAINT "countries_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."dairas"
    ADD CONSTRAINT "dairas_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."forwarding_quotes"
    ADD CONSTRAINT "forwarding_quotes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."notifications"
    ADD CONSTRAINT "notifications_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."order_lines"
    ADD CONSTRAINT "order_lines_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."orders"
    ADD CONSTRAINT "orders_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."orders"
    ADD CONSTRAINT "orders_reference_key" UNIQUE ("reference");



ALTER TABLE ONLY "public"."product_images"
    ADD CONSTRAINT "product_images_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."product_specifications"
    ADD CONSTRAINT "product_specifications_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."products"
    ADD CONSTRAINT "products_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."products"
    ADD CONSTRAINT "products_reference_key" UNIQUE ("reference");



ALTER TABLE ONLY "public"."products"
    ADD CONSTRAINT "products_slug_key" UNIQUE ("slug");



ALTER TABLE ONLY "public"."quote_requests"
    ADD CONSTRAINT "quote_requests_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."quote_requests"
    ADD CONSTRAINT "quote_requests_reference_key" UNIQUE ("reference");



ALTER TABLE ONLY "public"."quote_responses"
    ADD CONSTRAINT "quote_responses_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."shipment_documents"
    ADD CONSTRAINT "shipment_documents_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."shipments"
    ADD CONSTRAINT "shipments_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."subscriptions"
    ADD CONSTRAINT "subscriptions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."supplier_documents"
    ADD CONSTRAINT "supplier_documents_business_id_document_type_key" UNIQUE ("business_id", "document_type");



ALTER TABLE ONLY "public"."supplier_documents"
    ADD CONSTRAINT "supplier_documents_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."transactions"
    ADD CONSTRAINT "transactions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."transport_quotes"
    ADD CONSTRAINT "transport_quotes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_profiles"
    ADD CONSTRAINT "user_profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_name_key" UNIQUE ("name");



ALTER TABLE ONLY "public"."user_roles"
    ADD CONSTRAINT "user_roles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."wilayas"
    ADD CONSTRAINT "wilayas_pkey" PRIMARY KEY ("code");



CREATE INDEX "idx_businesses_created_by" ON "public"."businesses" USING "btree" ("created_by");



CREATE INDEX "idx_businesses_search" ON "public"."businesses" USING "gin" ("to_tsvector"('"english"'::"regconfig", ((("trade_name")::"text" || ' '::"text") || COALESCE("description", ''::"text"))));



CREATE INDEX "idx_businesses_sector" ON "public"."businesses" USING "btree" ("sector_id");



CREATE INDEX "idx_businesses_status" ON "public"."businesses" USING "btree" ("status");



CREATE INDEX "idx_businesses_subscription" ON "public"."businesses" USING "btree" ("subscription_plan");



CREATE INDEX "idx_businesses_type" ON "public"."businesses" USING "btree" ("business_type_id");



CREATE INDEX "idx_businesses_wilaya" ON "public"."businesses" USING "btree" ("wilaya_code");



CREATE INDEX "idx_communes_daira" ON "public"."communes" USING "btree" ("daira_id");



CREATE INDEX "idx_communes_wilaya" ON "public"."communes" USING "btree" ("wilaya_code");



CREATE INDEX "idx_contacts_business" ON "public"."business_contacts" USING "btree" ("business_id");



CREATE INDEX "idx_conv_business_a" ON "public"."conversations" USING "btree" ("business_a_id");



CREATE INDEX "idx_conv_business_b" ON "public"."conversations" USING "btree" ("business_b_id");



CREATE INDEX "idx_conv_last_msg" ON "public"."conversations" USING "btree" ("last_message_at" DESC);



CREATE INDEX "idx_dairas_wilaya" ON "public"."dairas" USING "btree" ("wilaya_code");



CREATE INDEX "idx_fquotes_forwarder" ON "public"."forwarding_quotes" USING "btree" ("forwarder_id");



CREATE INDEX "idx_fquotes_order" ON "public"."forwarding_quotes" USING "btree" ("order_id");



CREATE INDEX "idx_fquotes_status" ON "public"."forwarding_quotes" USING "btree" ("status");



CREATE INDEX "idx_logs_table" ON "public"."action_logs" USING "btree" ("table_name", "record_id");



CREATE INDEX "idx_logs_user" ON "public"."action_logs" USING "btree" ("user_id");



CREATE INDEX "idx_messages_conv" ON "public"."messages" USING "btree" ("conversation_id", "created_at");



CREATE INDEX "idx_messages_unread" ON "public"."messages" USING "btree" ("is_read") WHERE ("is_read" = false);



CREATE INDEX "idx_notifs_user" ON "public"."notifications" USING "btree" ("user_id", "is_read", "created_at" DESC);



CREATE INDEX "idx_olines_order" ON "public"."order_lines" USING "btree" ("order_id");



CREATE INDEX "idx_orders_buyer" ON "public"."orders" USING "btree" ("buyer_id");



CREATE INDEX "idx_orders_seller" ON "public"."orders" USING "btree" ("seller_id");



CREATE INDEX "idx_orders_status" ON "public"."orders" USING "btree" ("status");



CREATE INDEX "idx_product_images_product" ON "public"."product_images" USING "btree" ("product_id");



CREATE INDEX "idx_product_specs_product" ON "public"."product_specifications" USING "btree" ("product_id");



CREATE INDEX "idx_products_business" ON "public"."products" USING "btree" ("business_id");



CREATE INDEX "idx_products_category" ON "public"."products" USING "btree" ("category_id");



CREATE INDEX "idx_products_featured" ON "public"."products" USING "btree" ("is_featured") WHERE ("is_featured" = true);



CREATE INDEX "idx_products_search" ON "public"."products" USING "gin" ("to_tsvector"('"english"'::"regconfig", ((("name_en")::"text" || ' '::"text") || COALESCE("description_en", ''::"text"))));



CREATE INDEX "idx_products_status" ON "public"."products" USING "btree" ("status");



CREATE INDEX "idx_profiles_business" ON "public"."user_profiles" USING "btree" ("business_id");



CREATE INDEX "idx_profiles_role" ON "public"."user_profiles" USING "btree" ("role_id");



CREATE INDEX "idx_qr_buyer" ON "public"."quote_requests" USING "btree" ("buyer_id");



CREATE INDEX "idx_qr_product" ON "public"."quote_requests" USING "btree" ("product_id");



CREATE INDEX "idx_qr_seller" ON "public"."quote_requests" USING "btree" ("seller_id");



CREATE INDEX "idx_qr_status" ON "public"."quote_requests" USING "btree" ("status");



CREATE INDEX "idx_qresp_request" ON "public"."quote_responses" USING "btree" ("quote_request_id");



CREATE INDEX "idx_reviews_order" ON "public"."business_reviews" USING "btree" ("order_id");



CREATE INDEX "idx_reviews_reviewed" ON "public"."business_reviews" USING "btree" ("reviewed_business_id");



CREATE INDEX "idx_reviews_reviewer" ON "public"."business_reviews" USING "btree" ("reviewer_business_id");



CREATE INDEX "idx_sdocs_shipment" ON "public"."shipment_documents" USING "btree" ("shipment_id");



CREATE INDEX "idx_shipments_carrier" ON "public"."shipments" USING "btree" ("carrier_id");



CREATE INDEX "idx_shipments_order" ON "public"."shipments" USING "btree" ("order_id");



CREATE INDEX "idx_shipments_status" ON "public"."shipments" USING "btree" ("status");



CREATE INDEX "idx_subs_business" ON "public"."subscriptions" USING "btree" ("business_id");



CREATE INDEX "idx_subs_status" ON "public"."subscriptions" USING "btree" ("status");



CREATE INDEX "idx_supplier_docs_business" ON "public"."supplier_documents" USING "btree" ("business_id");



CREATE INDEX "idx_supplier_docs_status" ON "public"."supplier_documents" USING "btree" ("status");



CREATE INDEX "idx_tquotes_carrier" ON "public"."transport_quotes" USING "btree" ("carrier_id");



CREATE INDEX "idx_tquotes_order" ON "public"."transport_quotes" USING "btree" ("order_id");



CREATE INDEX "idx_tquotes_status" ON "public"."transport_quotes" USING "btree" ("status");



CREATE INDEX "idx_txns_business" ON "public"."transactions" USING "btree" ("business_id");



CREATE OR REPLACE TRIGGER "articles_updated_at" BEFORE UPDATE ON "public"."articles" FOR EACH ROW EXECUTE FUNCTION "public"."update_timestamp"();



CREATE OR REPLACE TRIGGER "business_contacts_phone_validation" BEFORE INSERT OR UPDATE ON "public"."business_contacts" FOR EACH ROW EXECUTE FUNCTION "public"."validate_dz_phone_contact"();



CREATE OR REPLACE TRIGGER "businesses_phone_validation" BEFORE INSERT OR UPDATE ON "public"."businesses" FOR EACH ROW EXECUTE FUNCTION "public"."validate_dz_phone"();



CREATE OR REPLACE TRIGGER "businesses_protect_sensitive" BEFORE UPDATE ON "public"."businesses" FOR EACH ROW EXECUTE FUNCTION "public"."protect_business_sensitive_fields"();



CREATE OR REPLACE TRIGGER "businesses_updated_at" BEFORE UPDATE ON "public"."businesses" FOR EACH ROW EXECUTE FUNCTION "public"."update_timestamp"();



CREATE OR REPLACE TRIGGER "orders_updated_at" BEFORE UPDATE ON "public"."orders" FOR EACH ROW EXECUTE FUNCTION "public"."update_timestamp"();



CREATE OR REPLACE TRIGGER "products_updated_at" BEFORE UPDATE ON "public"."products" FOR EACH ROW EXECUTE FUNCTION "public"."update_timestamp"();



CREATE OR REPLACE TRIGGER "quote_requests_increment_count" AFTER INSERT ON "public"."quote_requests" FOR EACH ROW EXECUTE FUNCTION "public"."increment_quote_count"();



CREATE OR REPLACE TRIGGER "quote_requests_updated_at" BEFORE UPDATE ON "public"."quote_requests" FOR EACH ROW EXECUTE FUNCTION "public"."update_timestamp"();



CREATE OR REPLACE TRIGGER "reviews_rating_trigger" AFTER INSERT OR DELETE OR UPDATE ON "public"."business_reviews" FOR EACH ROW EXECUTE FUNCTION "public"."update_business_rating"();



CREATE OR REPLACE TRIGGER "shipments_updated_at" BEFORE UPDATE ON "public"."shipments" FOR EACH ROW EXECUTE FUNCTION "public"."update_timestamp"();



CREATE OR REPLACE TRIGGER "user_profiles_protect_sensitive" BEFORE UPDATE ON "public"."user_profiles" FOR EACH ROW EXECUTE FUNCTION "public"."protect_user_profile_sensitive_fields"();



CREATE OR REPLACE TRIGGER "user_profiles_updated_at" BEFORE UPDATE ON "public"."user_profiles" FOR EACH ROW EXECUTE FUNCTION "public"."update_timestamp"();



ALTER TABLE ONLY "public"."action_logs"
    ADD CONSTRAINT "action_logs_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."ads"
    ADD CONSTRAINT "ads_business_id_fkey" FOREIGN KEY ("business_id") REFERENCES "public"."businesses"("id");



ALTER TABLE ONLY "public"."articles"
    ADD CONSTRAINT "articles_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."business_contacts"
    ADD CONSTRAINT "business_contacts_business_id_fkey" FOREIGN KEY ("business_id") REFERENCES "public"."businesses"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."business_reviews"
    ADD CONSTRAINT "business_reviews_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id");



ALTER TABLE ONLY "public"."business_reviews"
    ADD CONSTRAINT "business_reviews_reviewed_business_id_fkey" FOREIGN KEY ("reviewed_business_id") REFERENCES "public"."businesses"("id");



ALTER TABLE ONLY "public"."business_reviews"
    ADD CONSTRAINT "business_reviews_reviewer_business_id_fkey" FOREIGN KEY ("reviewer_business_id") REFERENCES "public"."businesses"("id");



ALTER TABLE ONLY "public"."business_reviews"
    ADD CONSTRAINT "business_reviews_reviewer_user_id_fkey" FOREIGN KEY ("reviewer_user_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."businesses"
    ADD CONSTRAINT "businesses_business_type_id_fkey" FOREIGN KEY ("business_type_id") REFERENCES "public"."business_types"("id");



ALTER TABLE ONLY "public"."businesses"
    ADD CONSTRAINT "businesses_commune_id_fkey" FOREIGN KEY ("commune_id") REFERENCES "public"."communes"("id");



ALTER TABLE ONLY "public"."businesses"
    ADD CONSTRAINT "businesses_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."businesses"
    ADD CONSTRAINT "businesses_daira_id_fkey" FOREIGN KEY ("daira_id") REFERENCES "public"."dairas"("id");



ALTER TABLE ONLY "public"."businesses"
    ADD CONSTRAINT "businesses_sector_id_fkey" FOREIGN KEY ("sector_id") REFERENCES "public"."activity_sectors"("id");



ALTER TABLE ONLY "public"."businesses"
    ADD CONSTRAINT "businesses_validated_by_fkey" FOREIGN KEY ("validated_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."businesses"
    ADD CONSTRAINT "businesses_wilaya_code_fkey" FOREIGN KEY ("wilaya_code") REFERENCES "public"."wilayas"("code");



ALTER TABLE ONLY "public"."categories"
    ADD CONSTRAINT "categories_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "public"."categories"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."communes"
    ADD CONSTRAINT "communes_daira_id_fkey" FOREIGN KEY ("daira_id") REFERENCES "public"."dairas"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."communes"
    ADD CONSTRAINT "communes_wilaya_code_fkey" FOREIGN KEY ("wilaya_code") REFERENCES "public"."wilayas"("code");



ALTER TABLE ONLY "public"."conversations"
    ADD CONSTRAINT "conversations_business_a_id_fkey" FOREIGN KEY ("business_a_id") REFERENCES "public"."businesses"("id");



ALTER TABLE ONLY "public"."conversations"
    ADD CONSTRAINT "conversations_business_b_id_fkey" FOREIGN KEY ("business_b_id") REFERENCES "public"."businesses"("id");



ALTER TABLE ONLY "public"."conversations"
    ADD CONSTRAINT "conversations_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."products"("id");



ALTER TABLE ONLY "public"."dairas"
    ADD CONSTRAINT "dairas_wilaya_code_fkey" FOREIGN KEY ("wilaya_code") REFERENCES "public"."wilayas"("code") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."forwarding_quotes"
    ADD CONSTRAINT "forwarding_quotes_forwarder_id_fkey" FOREIGN KEY ("forwarder_id") REFERENCES "public"."businesses"("id");



ALTER TABLE ONLY "public"."forwarding_quotes"
    ADD CONSTRAINT "forwarding_quotes_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id");



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_conversation_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "public"."conversations"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_sender_id_fkey" FOREIGN KEY ("sender_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."notifications"
    ADD CONSTRAINT "notifications_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."order_lines"
    ADD CONSTRAINT "order_lines_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."order_lines"
    ADD CONSTRAINT "order_lines_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."products"("id");



ALTER TABLE ONLY "public"."orders"
    ADD CONSTRAINT "orders_buyer_id_fkey" FOREIGN KEY ("buyer_id") REFERENCES "public"."businesses"("id");



ALTER TABLE ONLY "public"."orders"
    ADD CONSTRAINT "orders_quote_request_id_fkey" FOREIGN KEY ("quote_request_id") REFERENCES "public"."quote_requests"("id");



ALTER TABLE ONLY "public"."orders"
    ADD CONSTRAINT "orders_seller_id_fkey" FOREIGN KEY ("seller_id") REFERENCES "public"."businesses"("id");



ALTER TABLE ONLY "public"."product_images"
    ADD CONSTRAINT "product_images_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."products"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."product_specifications"
    ADD CONSTRAINT "product_specifications_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."products"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."products"
    ADD CONSTRAINT "products_business_id_fkey" FOREIGN KEY ("business_id") REFERENCES "public"."businesses"("id");



ALTER TABLE ONLY "public"."products"
    ADD CONSTRAINT "products_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "public"."categories"("id");



ALTER TABLE ONLY "public"."products"
    ADD CONSTRAINT "products_origin_wilaya_code_fkey" FOREIGN KEY ("origin_wilaya_code") REFERENCES "public"."wilayas"("code");



ALTER TABLE ONLY "public"."quote_requests"
    ADD CONSTRAINT "quote_requests_buyer_id_fkey" FOREIGN KEY ("buyer_id") REFERENCES "public"."businesses"("id");



ALTER TABLE ONLY "public"."quote_requests"
    ADD CONSTRAINT "quote_requests_destination_country_id_fkey" FOREIGN KEY ("destination_country_id") REFERENCES "public"."countries"("id");



ALTER TABLE ONLY "public"."quote_requests"
    ADD CONSTRAINT "quote_requests_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."products"("id");



ALTER TABLE ONLY "public"."quote_requests"
    ADD CONSTRAINT "quote_requests_seller_id_fkey" FOREIGN KEY ("seller_id") REFERENCES "public"."businesses"("id");



ALTER TABLE ONLY "public"."quote_responses"
    ADD CONSTRAINT "quote_responses_quote_request_id_fkey" FOREIGN KEY ("quote_request_id") REFERENCES "public"."quote_requests"("id");



ALTER TABLE ONLY "public"."shipment_documents"
    ADD CONSTRAINT "shipment_documents_shipment_id_fkey" FOREIGN KEY ("shipment_id") REFERENCES "public"."shipments"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."shipments"
    ADD CONSTRAINT "shipments_carrier_id_fkey" FOREIGN KEY ("carrier_id") REFERENCES "public"."businesses"("id");



ALTER TABLE ONLY "public"."shipments"
    ADD CONSTRAINT "shipments_forwarder_id_fkey" FOREIGN KEY ("forwarder_id") REFERENCES "public"."businesses"("id");



ALTER TABLE ONLY "public"."shipments"
    ADD CONSTRAINT "shipments_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id");



ALTER TABLE ONLY "public"."subscriptions"
    ADD CONSTRAINT "subscriptions_business_id_fkey" FOREIGN KEY ("business_id") REFERENCES "public"."businesses"("id");



ALTER TABLE ONLY "public"."supplier_documents"
    ADD CONSTRAINT "supplier_documents_business_id_fkey" FOREIGN KEY ("business_id") REFERENCES "public"."businesses"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."supplier_documents"
    ADD CONSTRAINT "supplier_documents_reviewed_by_fkey" FOREIGN KEY ("reviewed_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."transactions"
    ADD CONSTRAINT "transactions_business_id_fkey" FOREIGN KEY ("business_id") REFERENCES "public"."businesses"("id");



ALTER TABLE ONLY "public"."transactions"
    ADD CONSTRAINT "transactions_subscription_id_fkey" FOREIGN KEY ("subscription_id") REFERENCES "public"."subscriptions"("id");



ALTER TABLE ONLY "public"."transport_quotes"
    ADD CONSTRAINT "transport_quotes_carrier_id_fkey" FOREIGN KEY ("carrier_id") REFERENCES "public"."businesses"("id");



ALTER TABLE ONLY "public"."transport_quotes"
    ADD CONSTRAINT "transport_quotes_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id");



ALTER TABLE ONLY "public"."user_profiles"
    ADD CONSTRAINT "user_profiles_business_id_fkey" FOREIGN KEY ("business_id") REFERENCES "public"."businesses"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."user_profiles"
    ADD CONSTRAINT "user_profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_profiles"
    ADD CONSTRAINT "user_profiles_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "public"."user_roles"("id");



ALTER TABLE "public"."action_logs" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."activity_sectors" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."ads" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "ads_manage" ON "public"."ads" USING ((("business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"())) WITH CHECK ((("business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



CREATE POLICY "ads_select_public" ON "public"."ads" FOR SELECT USING ((("status" = 'active'::"public"."ad_status") OR ("business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



ALTER TABLE "public"."articles" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "articles_manage" ON "public"."articles" USING ("public"."is_platform_admin"()) WITH CHECK ("public"."is_platform_admin"());



CREATE POLICY "articles_select_public" ON "public"."articles" FOR SELECT USING ((("is_published" = true) OR "public"."is_platform_admin"()));



ALTER TABLE "public"."business_contacts" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."business_reviews" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."business_types" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."businesses" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "businesses_admin_update" ON "public"."businesses" FOR UPDATE USING ("public"."is_platform_admin"()) WITH CHECK ("public"."is_platform_admin"());



CREATE POLICY "businesses_insert_own" ON "public"."businesses" FOR INSERT WITH CHECK ((("auth"."uid"() IS NOT NULL) AND ("created_by" = "auth"."uid"()) AND ("status" = 'draft'::"public"."business_status") AND ("subscription_plan" = 'free'::"public"."subscription_plan") AND ("validated_at" IS NULL) AND ("validated_by" IS NULL)));



CREATE POLICY "businesses_select_public" ON "public"."businesses" FOR SELECT USING ((("status" = 'active'::"public"."business_status") OR ("id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



CREATE POLICY "businesses_update_own" ON "public"."businesses" FOR UPDATE USING ((("id" = "public"."current_user_business_id"()) AND ("status" = ANY (ARRAY['draft'::"public"."business_status", 'rejected'::"public"."business_status"])))) WITH CHECK ((("id" = "public"."current_user_business_id"()) AND ("created_by" = "auth"."uid"()) AND ("status" = ANY (ARRAY['draft'::"public"."business_status", 'pending_review'::"public"."business_status"])) AND (("status" <> 'pending_review'::"public"."business_status") OR (EXISTS ( SELECT 1
   FROM "public"."supplier_documents" "d"
  WHERE (("d"."business_id" = "businesses"."id") AND ("d"."document_type" = 'nrc'::"public"."supplier_doc_type") AND ("d"."status" = ANY (ARRAY['pending'::"public"."supplier_doc_status", 'approved'::"public"."supplier_doc_status"]))))))));



ALTER TABLE "public"."categories" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "categories_manage_admin" ON "public"."categories" USING ("public"."is_platform_admin"()) WITH CHECK ("public"."is_platform_admin"());



CREATE POLICY "categories_select_public" ON "public"."categories" FOR SELECT USING (true);



ALTER TABLE "public"."communes" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "contacts_delete_own" ON "public"."business_contacts" FOR DELETE USING ((("business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



CREATE POLICY "contacts_insert_own" ON "public"."business_contacts" FOR INSERT WITH CHECK (("business_id" = "public"."current_user_business_id"()));



CREATE POLICY "contacts_select_own" ON "public"."business_contacts" FOR SELECT USING ((("business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



CREATE POLICY "contacts_update_own" ON "public"."business_contacts" FOR UPDATE USING ((("business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"())) WITH CHECK ((("business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



CREATE POLICY "conv_insert" ON "public"."conversations" FOR INSERT WITH CHECK ((("business_a_id" = "public"."current_user_business_id"()) OR ("business_b_id" = "public"."current_user_business_id"())));



CREATE POLICY "conv_select" ON "public"."conversations" FOR SELECT USING ((("business_a_id" = "public"."current_user_business_id"()) OR ("business_b_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



CREATE POLICY "conv_update" ON "public"."conversations" FOR UPDATE USING ((("business_a_id" = "public"."current_user_business_id"()) OR ("business_b_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"())) WITH CHECK ((("business_a_id" = "public"."current_user_business_id"()) OR ("business_b_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



ALTER TABLE "public"."conversations" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."countries" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."dairas" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "docs_delete_own" ON "public"."supplier_documents" FOR DELETE USING ((("business_id" = "public"."current_user_business_id"()) AND (EXISTS ( SELECT 1
   FROM "public"."businesses" "b"
  WHERE (("b"."id" = "supplier_documents"."business_id") AND ("b"."status" = ANY (ARRAY['draft'::"public"."business_status", 'rejected'::"public"."business_status"])))))));



CREATE POLICY "docs_insert_own" ON "public"."supplier_documents" FOR INSERT WITH CHECK ((("business_id" = "public"."current_user_business_id"()) AND ("status" = 'pending'::"public"."supplier_doc_status") AND (EXISTS ( SELECT 1
   FROM "public"."businesses" "b"
  WHERE (("b"."id" = "supplier_documents"."business_id") AND ("b"."status" = ANY (ARRAY['draft'::"public"."business_status", 'rejected'::"public"."business_status"])))))));



CREATE POLICY "docs_select_own" ON "public"."supplier_documents" FOR SELECT USING ((("business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



CREATE POLICY "docs_update_admin" ON "public"."supplier_documents" FOR UPDATE USING ("public"."is_platform_admin"()) WITH CHECK ("public"."is_platform_admin"());



ALTER TABLE "public"."forwarding_quotes" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "fquotes_insert_forwarder" ON "public"."forwarding_quotes" FOR INSERT WITH CHECK (("forwarder_id" = "public"."current_user_business_id"()));



CREATE POLICY "fquotes_select" ON "public"."forwarding_quotes" FOR SELECT USING ((("forwarder_id" = "public"."current_user_business_id"()) OR (EXISTS ( SELECT 1
   FROM "public"."orders" "o"
  WHERE (("o"."id" = "forwarding_quotes"."order_id") AND (("o"."buyer_id" = "public"."current_user_business_id"()) OR ("o"."seller_id" = "public"."current_user_business_id"()))))) OR "public"."is_platform_admin"()));



CREATE POLICY "fquotes_update" ON "public"."forwarding_quotes" FOR UPDATE USING ((("forwarder_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"() OR (EXISTS ( SELECT 1
   FROM "public"."orders" "o"
  WHERE (("o"."id" = "forwarding_quotes"."order_id") AND (("o"."buyer_id" = "public"."current_user_business_id"()) OR ("o"."seller_id" = "public"."current_user_business_id"()))))))) WITH CHECK ((("forwarder_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"() OR (EXISTS ( SELECT 1
   FROM "public"."orders" "o"
  WHERE (("o"."id" = "forwarding_quotes"."order_id") AND (("o"."buyer_id" = "public"."current_user_business_id"()) OR ("o"."seller_id" = "public"."current_user_business_id"())))))));



CREATE POLICY "logs_insert_own" ON "public"."action_logs" FOR INSERT WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "logs_select_admin" ON "public"."action_logs" FOR SELECT USING ("public"."is_platform_admin"());



ALTER TABLE "public"."messages" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "msg_insert" ON "public"."messages" FOR INSERT WITH CHECK ((("sender_id" = "auth"."uid"()) AND (EXISTS ( SELECT 1
   FROM "public"."conversations" "c"
  WHERE (("c"."id" = "messages"."conversation_id") AND (("c"."business_a_id" = "public"."current_user_business_id"()) OR ("c"."business_b_id" = "public"."current_user_business_id"())))))));



CREATE POLICY "msg_select" ON "public"."messages" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."conversations" "c"
  WHERE (("c"."id" = "messages"."conversation_id") AND (("c"."business_a_id" = "public"."current_user_business_id"()) OR ("c"."business_b_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"())))));



CREATE POLICY "msg_update_own" ON "public"."messages" FOR UPDATE USING (("sender_id" = "auth"."uid"())) WITH CHECK (("sender_id" = "auth"."uid"()));



ALTER TABLE "public"."notifications" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "notifs_insert_own" ON "public"."notifications" FOR INSERT WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "notifs_select_own" ON "public"."notifications" FOR SELECT USING (("user_id" = "auth"."uid"()));



CREATE POLICY "notifs_update_own" ON "public"."notifications" FOR UPDATE USING (("user_id" = "auth"."uid"())) WITH CHECK (("user_id" = "auth"."uid"()));



CREATE POLICY "olines_manage" ON "public"."order_lines" USING ((EXISTS ( SELECT 1
   FROM "public"."orders" "o"
  WHERE (("o"."id" = "order_lines"."order_id") AND (("o"."buyer_id" = "public"."current_user_business_id"()) OR ("o"."seller_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"())))));



CREATE POLICY "olines_select" ON "public"."order_lines" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."orders" "o"
  WHERE (("o"."id" = "order_lines"."order_id") AND (("o"."buyer_id" = "public"."current_user_business_id"()) OR ("o"."seller_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"())))));



ALTER TABLE "public"."order_lines" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."orders" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "orders_select_parties" ON "public"."orders" FOR SELECT USING ((("buyer_id" = "public"."current_user_business_id"()) OR ("seller_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



CREATE POLICY "orders_update_parties" ON "public"."orders" FOR UPDATE USING ((("buyer_id" = "public"."current_user_business_id"()) OR ("seller_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"())) WITH CHECK ((("buyer_id" = "public"."current_user_business_id"()) OR ("seller_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



CREATE POLICY "pimages_manage" ON "public"."product_images" USING ((EXISTS ( SELECT 1
   FROM "public"."products" "p"
  WHERE (("p"."id" = "product_images"."product_id") AND (("p"."business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"())))));



CREATE POLICY "pimages_select" ON "public"."product_images" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."products" "p"
  WHERE (("p"."id" = "product_images"."product_id") AND (("p"."status" = 'published'::"public"."product_status") OR ("p"."business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"())))));



ALTER TABLE "public"."product_images" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."product_specifications" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."products" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "products_delete_own" ON "public"."products" FOR DELETE USING ((("business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



CREATE POLICY "products_insert_own" ON "public"."products" FOR INSERT WITH CHECK (("business_id" = "public"."current_user_business_id"()));



CREATE POLICY "products_select_public" ON "public"."products" FOR SELECT USING (((("status" = 'published'::"public"."product_status") AND (EXISTS ( SELECT 1
   FROM "public"."businesses" "b"
  WHERE (("b"."id" = "products"."business_id") AND ("b"."status" = 'active'::"public"."business_status"))))) OR ("business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



CREATE POLICY "products_update_own" ON "public"."products" FOR UPDATE USING ((("business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"())) WITH CHECK ((("business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



CREATE POLICY "profiles_insert_own" ON "public"."user_profiles" FOR INSERT WITH CHECK ((("id" = "auth"."uid"()) AND ("role_id" = "public"."default_viewer_role_id"()) AND (("business_id" IS NULL) OR (EXISTS ( SELECT 1
   FROM "public"."businesses" "b"
  WHERE (("b"."id" = "user_profiles"."business_id") AND ("b"."created_by" = "auth"."uid"())))))));



CREATE POLICY "profiles_select_own" ON "public"."user_profiles" FOR SELECT USING ((("id" = "auth"."uid"()) OR "public"."is_platform_admin"()));



CREATE POLICY "profiles_update_own" ON "public"."user_profiles" FOR UPDATE USING ((("id" = "auth"."uid"()) OR "public"."is_platform_admin"())) WITH CHECK (("public"."is_platform_admin"() OR (("id" = "auth"."uid"()) AND (("business_id" IS NULL) OR (EXISTS ( SELECT 1
   FROM "public"."businesses" "b"
  WHERE (("b"."id" = "user_profiles"."business_id") AND ("b"."created_by" = "auth"."uid"()))))))));



CREATE POLICY "pspecs_manage" ON "public"."product_specifications" USING ((EXISTS ( SELECT 1
   FROM "public"."products" "p"
  WHERE (("p"."id" = "product_specifications"."product_id") AND (("p"."business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"())))));



CREATE POLICY "pspecs_select" ON "public"."product_specifications" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."products" "p"
  WHERE (("p"."id" = "product_specifications"."product_id") AND (("p"."status" = 'published'::"public"."product_status") OR ("p"."business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"())))));



CREATE POLICY "qresponses_insert_seller" ON "public"."quote_responses" FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."quote_requests" "qr"
  WHERE (("qr"."id" = "quote_responses"."quote_request_id") AND ("qr"."seller_id" = "public"."current_user_business_id"())))));



CREATE POLICY "qresponses_select_parties" ON "public"."quote_responses" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."quote_requests" "qr"
  WHERE (("qr"."id" = "quote_responses"."quote_request_id") AND (("qr"."buyer_id" = "public"."current_user_business_id"()) OR ("qr"."seller_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"())))));



ALTER TABLE "public"."quote_requests" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."quote_responses" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "quotes_insert_buyer" ON "public"."quote_requests" FOR INSERT WITH CHECK (("buyer_id" = "public"."current_user_business_id"()));



CREATE POLICY "quotes_select_parties" ON "public"."quote_requests" FOR SELECT USING ((("buyer_id" = "public"."current_user_business_id"()) OR ("seller_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



CREATE POLICY "quotes_update_parties" ON "public"."quote_requests" FOR UPDATE USING ((("buyer_id" = "public"."current_user_business_id"()) OR ("seller_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"())) WITH CHECK ((("buyer_id" = "public"."current_user_business_id"()) OR ("seller_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



CREATE POLICY "ref_manage_activity_sectors" ON "public"."activity_sectors" USING ("public"."is_platform_admin"()) WITH CHECK ("public"."is_platform_admin"());



CREATE POLICY "ref_manage_business_types" ON "public"."business_types" USING ("public"."is_platform_admin"()) WITH CHECK ("public"."is_platform_admin"());



CREATE POLICY "ref_manage_communes" ON "public"."communes" USING ("public"."is_platform_admin"()) WITH CHECK ("public"."is_platform_admin"());



CREATE POLICY "ref_manage_countries" ON "public"."countries" USING ("public"."is_platform_admin"()) WITH CHECK ("public"."is_platform_admin"());



CREATE POLICY "ref_manage_dairas" ON "public"."dairas" USING ("public"."is_platform_admin"()) WITH CHECK ("public"."is_platform_admin"());



CREATE POLICY "ref_manage_user_roles" ON "public"."user_roles" USING ("public"."is_platform_admin"()) WITH CHECK ("public"."is_platform_admin"());



CREATE POLICY "ref_manage_wilayas" ON "public"."wilayas" USING ("public"."is_platform_admin"()) WITH CHECK ("public"."is_platform_admin"());



CREATE POLICY "ref_select_activity_sectors" ON "public"."activity_sectors" FOR SELECT USING (true);



CREATE POLICY "ref_select_business_types" ON "public"."business_types" FOR SELECT USING (true);



CREATE POLICY "ref_select_communes" ON "public"."communes" FOR SELECT USING (true);



CREATE POLICY "ref_select_countries" ON "public"."countries" FOR SELECT USING (true);



CREATE POLICY "ref_select_dairas" ON "public"."dairas" FOR SELECT USING (true);



CREATE POLICY "ref_select_user_roles" ON "public"."user_roles" FOR SELECT USING (true);



CREATE POLICY "ref_select_wilayas" ON "public"."wilayas" FOR SELECT USING (true);



CREATE POLICY "reviews_insert_reviewer" ON "public"."business_reviews" FOR INSERT WITH CHECK ((("reviewer_business_id" = "public"."current_user_business_id"()) AND ("reviewer_user_id" = "auth"."uid"())));



CREATE POLICY "reviews_respond" ON "public"."business_reviews" FOR UPDATE USING (("reviewed_business_id" = "public"."current_user_business_id"())) WITH CHECK (("reviewed_business_id" = "public"."current_user_business_id"()));



CREATE POLICY "reviews_select_public" ON "public"."business_reviews" FOR SELECT USING ((("status" = 'published'::"public"."review_status") OR ("reviewer_business_id" = "public"."current_user_business_id"()) OR ("reviewed_business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



CREATE POLICY "reviews_update_reviewer" ON "public"."business_reviews" FOR UPDATE USING (("reviewer_user_id" = "auth"."uid"())) WITH CHECK (("reviewer_user_id" = "auth"."uid"()));



CREATE POLICY "sdocs_manage" ON "public"."shipment_documents" USING ((EXISTS ( SELECT 1
   FROM "public"."shipments" "s"
  WHERE (("s"."id" = "shipment_documents"."shipment_id") AND (("s"."carrier_id" = "public"."current_user_business_id"()) OR ("s"."forwarder_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"())))));



CREATE POLICY "sdocs_select" ON "public"."shipment_documents" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."shipments" "s"
  WHERE (("s"."id" = "shipment_documents"."shipment_id") AND ((EXISTS ( SELECT 1
           FROM "public"."orders" "o"
          WHERE (("o"."id" = "s"."order_id") AND (("o"."buyer_id" = "public"."current_user_business_id"()) OR ("o"."seller_id" = "public"."current_user_business_id"()))))) OR ("s"."carrier_id" = "public"."current_user_business_id"()) OR ("s"."forwarder_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"())))));



ALTER TABLE "public"."shipment_documents" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."shipments" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "shipments_select" ON "public"."shipments" FOR SELECT USING (((EXISTS ( SELECT 1
   FROM "public"."orders" "o"
  WHERE (("o"."id" = "shipments"."order_id") AND (("o"."buyer_id" = "public"."current_user_business_id"()) OR ("o"."seller_id" = "public"."current_user_business_id"()))))) OR ("carrier_id" = "public"."current_user_business_id"()) OR ("forwarder_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



CREATE POLICY "shipments_update" ON "public"."shipments" FOR UPDATE USING ((("carrier_id" = "public"."current_user_business_id"()) OR ("forwarder_id" = "public"."current_user_business_id"()) OR (EXISTS ( SELECT 1
   FROM "public"."orders" "o"
  WHERE (("o"."id" = "shipments"."order_id") AND ("o"."seller_id" = "public"."current_user_business_id"())))) OR "public"."is_platform_admin"())) WITH CHECK ((("carrier_id" = "public"."current_user_business_id"()) OR ("forwarder_id" = "public"."current_user_business_id"()) OR (EXISTS ( SELECT 1
   FROM "public"."orders" "o"
  WHERE (("o"."id" = "shipments"."order_id") AND ("o"."seller_id" = "public"."current_user_business_id"())))) OR "public"."is_platform_admin"()));



CREATE POLICY "subs_manage" ON "public"."subscriptions" USING ("public"."is_platform_admin"()) WITH CHECK ("public"."is_platform_admin"());



CREATE POLICY "subs_select" ON "public"."subscriptions" FOR SELECT USING ((("business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



ALTER TABLE "public"."subscriptions" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."supplier_documents" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "tquotes_insert_carrier" ON "public"."transport_quotes" FOR INSERT WITH CHECK (("carrier_id" = "public"."current_user_business_id"()));



CREATE POLICY "tquotes_select" ON "public"."transport_quotes" FOR SELECT USING ((("carrier_id" = "public"."current_user_business_id"()) OR (EXISTS ( SELECT 1
   FROM "public"."orders" "o"
  WHERE (("o"."id" = "transport_quotes"."order_id") AND (("o"."buyer_id" = "public"."current_user_business_id"()) OR ("o"."seller_id" = "public"."current_user_business_id"()))))) OR "public"."is_platform_admin"()));



CREATE POLICY "tquotes_update" ON "public"."transport_quotes" FOR UPDATE USING ((("carrier_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"() OR (EXISTS ( SELECT 1
   FROM "public"."orders" "o"
  WHERE (("o"."id" = "transport_quotes"."order_id") AND (("o"."buyer_id" = "public"."current_user_business_id"()) OR ("o"."seller_id" = "public"."current_user_business_id"()))))))) WITH CHECK ((("carrier_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"() OR (EXISTS ( SELECT 1
   FROM "public"."orders" "o"
  WHERE (("o"."id" = "transport_quotes"."order_id") AND (("o"."buyer_id" = "public"."current_user_business_id"()) OR ("o"."seller_id" = "public"."current_user_business_id"())))))));



ALTER TABLE "public"."transactions" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."transport_quotes" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "txns_select" ON "public"."transactions" FOR SELECT USING ((("business_id" = "public"."current_user_business_id"()) OR "public"."is_platform_admin"()));



ALTER TABLE "public"."user_profiles" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."user_roles" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."wilayas" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";






















































































































































GRANT ALL ON FUNCTION "public"."current_user_business_id"() TO "anon";
GRANT ALL ON FUNCTION "public"."current_user_business_id"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."current_user_business_id"() TO "service_role";



GRANT ALL ON FUNCTION "public"."default_business_type_id"() TO "anon";
GRANT ALL ON FUNCTION "public"."default_business_type_id"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."default_business_type_id"() TO "service_role";



GRANT ALL ON FUNCTION "public"."default_viewer_role_id"() TO "anon";
GRANT ALL ON FUNCTION "public"."default_viewer_role_id"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."default_viewer_role_id"() TO "service_role";



GRANT ALL ON FUNCTION "public"."increment_quote_count"() TO "anon";
GRANT ALL ON FUNCTION "public"."increment_quote_count"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."increment_quote_count"() TO "service_role";



GRANT ALL ON FUNCTION "public"."is_platform_admin"() TO "anon";
GRANT ALL ON FUNCTION "public"."is_platform_admin"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_platform_admin"() TO "service_role";



GRANT ALL ON FUNCTION "public"."protect_business_sensitive_fields"() TO "anon";
GRANT ALL ON FUNCTION "public"."protect_business_sensitive_fields"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."protect_business_sensitive_fields"() TO "service_role";



GRANT ALL ON FUNCTION "public"."protect_user_profile_sensitive_fields"() TO "anon";
GRANT ALL ON FUNCTION "public"."protect_user_profile_sensitive_fields"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."protect_user_profile_sensitive_fields"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_business_rating"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_business_rating"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_business_rating"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_timestamp"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_timestamp"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_timestamp"() TO "service_role";



GRANT ALL ON FUNCTION "public"."validate_dz_phone"() TO "anon";
GRANT ALL ON FUNCTION "public"."validate_dz_phone"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."validate_dz_phone"() TO "service_role";



GRANT ALL ON FUNCTION "public"."validate_dz_phone_contact"() TO "anon";
GRANT ALL ON FUNCTION "public"."validate_dz_phone_contact"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."validate_dz_phone_contact"() TO "service_role";


















GRANT ALL ON TABLE "public"."action_logs" TO "anon";
GRANT ALL ON TABLE "public"."action_logs" TO "authenticated";
GRANT ALL ON TABLE "public"."action_logs" TO "service_role";



GRANT ALL ON TABLE "public"."activity_sectors" TO "anon";
GRANT ALL ON TABLE "public"."activity_sectors" TO "authenticated";
GRANT ALL ON TABLE "public"."activity_sectors" TO "service_role";



GRANT ALL ON TABLE "public"."ads" TO "anon";
GRANT ALL ON TABLE "public"."ads" TO "authenticated";
GRANT ALL ON TABLE "public"."ads" TO "service_role";



GRANT ALL ON TABLE "public"."articles" TO "anon";
GRANT ALL ON TABLE "public"."articles" TO "authenticated";
GRANT ALL ON TABLE "public"."articles" TO "service_role";



GRANT ALL ON TABLE "public"."business_contacts" TO "anon";
GRANT ALL ON TABLE "public"."business_contacts" TO "authenticated";
GRANT ALL ON TABLE "public"."business_contacts" TO "service_role";



GRANT ALL ON TABLE "public"."business_reviews" TO "anon";
GRANT ALL ON TABLE "public"."business_reviews" TO "authenticated";
GRANT ALL ON TABLE "public"."business_reviews" TO "service_role";



GRANT ALL ON TABLE "public"."business_types" TO "anon";
GRANT ALL ON TABLE "public"."business_types" TO "authenticated";
GRANT ALL ON TABLE "public"."business_types" TO "service_role";



GRANT ALL ON TABLE "public"."businesses" TO "anon";
GRANT ALL ON TABLE "public"."businesses" TO "authenticated";
GRANT ALL ON TABLE "public"."businesses" TO "service_role";



GRANT ALL ON TABLE "public"."categories" TO "anon";
GRANT ALL ON TABLE "public"."categories" TO "authenticated";
GRANT ALL ON TABLE "public"."categories" TO "service_role";



GRANT ALL ON TABLE "public"."communes" TO "anon";
GRANT ALL ON TABLE "public"."communes" TO "authenticated";
GRANT ALL ON TABLE "public"."communes" TO "service_role";



GRANT ALL ON TABLE "public"."conversations" TO "anon";
GRANT ALL ON TABLE "public"."conversations" TO "authenticated";
GRANT ALL ON TABLE "public"."conversations" TO "service_role";



GRANT ALL ON TABLE "public"."countries" TO "anon";
GRANT ALL ON TABLE "public"."countries" TO "authenticated";
GRANT ALL ON TABLE "public"."countries" TO "service_role";



GRANT ALL ON TABLE "public"."dairas" TO "anon";
GRANT ALL ON TABLE "public"."dairas" TO "authenticated";
GRANT ALL ON TABLE "public"."dairas" TO "service_role";



GRANT ALL ON TABLE "public"."forwarding_quotes" TO "anon";
GRANT ALL ON TABLE "public"."forwarding_quotes" TO "authenticated";
GRANT ALL ON TABLE "public"."forwarding_quotes" TO "service_role";



GRANT ALL ON TABLE "public"."messages" TO "anon";
GRANT ALL ON TABLE "public"."messages" TO "authenticated";
GRANT ALL ON TABLE "public"."messages" TO "service_role";



GRANT ALL ON TABLE "public"."notifications" TO "anon";
GRANT ALL ON TABLE "public"."notifications" TO "authenticated";
GRANT ALL ON TABLE "public"."notifications" TO "service_role";



GRANT ALL ON TABLE "public"."order_lines" TO "anon";
GRANT ALL ON TABLE "public"."order_lines" TO "authenticated";
GRANT ALL ON TABLE "public"."order_lines" TO "service_role";



GRANT ALL ON TABLE "public"."orders" TO "anon";
GRANT ALL ON TABLE "public"."orders" TO "authenticated";
GRANT ALL ON TABLE "public"."orders" TO "service_role";



GRANT ALL ON TABLE "public"."product_images" TO "anon";
GRANT ALL ON TABLE "public"."product_images" TO "authenticated";
GRANT ALL ON TABLE "public"."product_images" TO "service_role";



GRANT ALL ON SEQUENCE "public"."product_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."product_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."product_seq" TO "service_role";



GRANT ALL ON TABLE "public"."product_specifications" TO "anon";
GRANT ALL ON TABLE "public"."product_specifications" TO "authenticated";
GRANT ALL ON TABLE "public"."product_specifications" TO "service_role";



GRANT ALL ON TABLE "public"."products" TO "anon";
GRANT ALL ON TABLE "public"."products" TO "authenticated";
GRANT ALL ON TABLE "public"."products" TO "service_role";



GRANT ALL ON TABLE "public"."quote_requests" TO "anon";
GRANT ALL ON TABLE "public"."quote_requests" TO "authenticated";
GRANT ALL ON TABLE "public"."quote_requests" TO "service_role";



GRANT ALL ON TABLE "public"."quote_responses" TO "anon";
GRANT ALL ON TABLE "public"."quote_responses" TO "authenticated";
GRANT ALL ON TABLE "public"."quote_responses" TO "service_role";



GRANT ALL ON TABLE "public"."shipment_documents" TO "anon";
GRANT ALL ON TABLE "public"."shipment_documents" TO "authenticated";
GRANT ALL ON TABLE "public"."shipment_documents" TO "service_role";



GRANT ALL ON TABLE "public"."shipments" TO "anon";
GRANT ALL ON TABLE "public"."shipments" TO "authenticated";
GRANT ALL ON TABLE "public"."shipments" TO "service_role";



GRANT ALL ON TABLE "public"."subscriptions" TO "anon";
GRANT ALL ON TABLE "public"."subscriptions" TO "authenticated";
GRANT ALL ON TABLE "public"."subscriptions" TO "service_role";



GRANT ALL ON TABLE "public"."supplier_documents" TO "anon";
GRANT ALL ON TABLE "public"."supplier_documents" TO "authenticated";
GRANT ALL ON TABLE "public"."supplier_documents" TO "service_role";



GRANT ALL ON TABLE "public"."transactions" TO "anon";
GRANT ALL ON TABLE "public"."transactions" TO "authenticated";
GRANT ALL ON TABLE "public"."transactions" TO "service_role";



GRANT ALL ON TABLE "public"."transport_quotes" TO "anon";
GRANT ALL ON TABLE "public"."transport_quotes" TO "authenticated";
GRANT ALL ON TABLE "public"."transport_quotes" TO "service_role";



GRANT ALL ON TABLE "public"."user_profiles" TO "anon";
GRANT ALL ON TABLE "public"."user_profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."user_profiles" TO "service_role";



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































