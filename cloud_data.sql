SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict iqdZLvhF0bI8xW3jIhxt9GJmYmhKeyoBhqMjVYUDYNSN1RKhMIdayelPRXzofZy

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."flow_state" ("id", "user_id", "auth_code", "code_challenge_method", "code_challenge", "provider_type", "provider_access_token", "provider_refresh_token", "created_at", "updated_at", "authentication_method", "auth_code_issued_at", "invite_token", "referrer", "oauth_client_state_id", "linking_target_id", "email_optional") VALUES
	('d51919f0-48db-4966-8d11-e20069a8162d', '7f56a7de-4ee3-4c70-983a-30fa1850dca8', 'a0cd804c-f513-4476-ba6b-29688bdf8fc6', 's256', 'F-NF-ztW-_lDFwhLy8Q61ks0Ow1m_xNd1lJJF40h0fo', 'email', '', '', '2026-08-05 23:42:21.336041+00', '2026-08-05 23:42:21.336041+00', 'email/signup', NULL, NULL, NULL, NULL, NULL, false),
	('e8740ebc-5733-4621-af3f-08ca2486d630', '9293abba-51c6-4958-8120-6885d933c1f8', 'd68e7b51-f54c-45c8-8a64-f20c8ad2f8fb', 's256', 'mzibwLqU8h3tvtaXWM5cHJkgFqyNIb1hUxDPZvTsrg4', 'email', '', '', '2026-08-08 10:27:00.718943+00', '2026-08-08 10:27:00.718943+00', 'email/signup', NULL, NULL, NULL, NULL, NULL, false),
	('5f914aa5-0453-4ca6-a5a2-fc1f543be76b', '9293abba-51c6-4958-8120-6885d933c1f8', '32935d77-4acd-41c8-8e97-4268728e516e', 's256', 'ToBtFxXHmFxFvAypSvugTnrznefRYd1q_JvfUCTSTCQ', 'email', '', '', '2026-08-08 14:41:12.823578+00', '2026-08-08 14:41:12.823578+00', 'email/signup', NULL, NULL, NULL, NULL, NULL, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', 'b64c1eb5-d875-4175-aa3c-8efe3b73799f', 'authenticated', 'authenticated', 'test@exemple.com', 'bfN.NmByTxyzQ', '2026-08-09 11:02:23.515754+00', NULL, '', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '{"role": "buyer_eu", "company_name": "Test Direct"}', NULL, '2026-08-09 11:02:23.515754+00', '2026-08-09 11:02:23.515754+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: buyers_eu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."buyers_eu" ("id", "user_id", "company_name", "contact_name", "email", "phone", "buyer_type", "address", "city", "country", "tax_id", "stripe_customer_id", "notes", "active", "created_at", "updated_at") VALUES
	('2a99a6d9-d352-4ffe-b258-6cac56208fc6', 'b64c1eb5-d875-4175-aa3c-8efe3b73799f', 'Test Direct', NULL, NULL, NULL, NULL, NULL, NULL, 'France', NULL, NULL, NULL, true, '2026-08-09 11:02:23.515754+00', '2026-08-09 11:02:23.515754+00');


--
-- Data for Name: carriers_dz; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: carriers_eu; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: exchange_rates; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: chat_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: conversation_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: freight_forwarders; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: products_catalog; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: payouts; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: quote_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: quotes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id", "type") VALUES
	('supplier-docs', 'supplier-docs', NULL, '2026-08-07 17:07:48.931934+00', '2026-08-07 17:07:48.931934+00', false, false, NULL, NULL, NULL, 'STANDARD');


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 1, false);


--
-- PostgreSQL database dump complete
--

-- \unrestrict iqdZLvhF0bI8xW3jIhxt9GJmYmhKeyoBhqMjVYUDYNSN1RKhMIdayelPRXzofZy

RESET ALL;
