SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict e6cEgDTx0vEC0TYitT0KGSXWtF9anOLAhbteS9nGNX8J8IiYhofOrWQmbMKfoxf

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
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: buyers_eu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."buyers_eu" ("id", "user_id", "company_name", "contact_name", "email", "phone", "buyer_type", "address", "city", "country", "tax_id", "stripe_customer_id", "notes", "active", "created_at", "updated_at", "legal_form", "business_status", "deleted_at") VALUES
	('2a99a6d9-d352-4ffe-b258-6cac56208fc6', 'b64c1eb5-d875-4175-aa3c-8efe3b73799f', 'Test Direct', NULL, NULL, NULL, NULL, NULL, NULL, 'France', NULL, NULL, NULL, true, '2026-08-09 11:02:23.515754+00', '2026-08-09 11:02:23.515754+00', NULL, 'active', NULL);


--
-- Data for Name: wilayas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."wilayas" ("code", "name_fr", "name_en", "name_ar", "created_at") VALUES
	('01', 'Adrar', 'Adrar', 'أدرار', '2026-08-09 23:55:52.277404+00'),
	('02', 'Chlef', 'Chlef', 'الشلف', '2026-08-09 23:55:52.277404+00'),
	('03', 'Laghouat', 'Laghouat', 'الأغواط', '2026-08-09 23:55:52.277404+00'),
	('04', 'Oum El Bouaghi', 'Oum El Bouaghi', 'أم البواقي', '2026-08-09 23:55:52.277404+00'),
	('05', 'Batna', 'Batna', 'باتنة', '2026-08-09 23:55:52.277404+00'),
	('06', 'Béjaïa', 'Bejaia', 'بجاية', '2026-08-09 23:55:52.277404+00'),
	('07', 'Biskra', 'Biskra', 'بسكرة', '2026-08-09 23:55:52.277404+00'),
	('08', 'Béchar', 'Bechar', 'بشار', '2026-08-09 23:55:52.277404+00'),
	('09', 'Blida', 'Blida', 'البليدة', '2026-08-09 23:55:52.277404+00'),
	('10', 'Bouira', 'Bouira', 'البويرة', '2026-08-09 23:55:52.277404+00'),
	('11', 'Tamanrasset', 'Tamanrasset', 'تمنراست', '2026-08-09 23:55:52.277404+00'),
	('12', 'Tébessa', 'Tebessa', 'تبسة', '2026-08-09 23:55:52.277404+00'),
	('13', 'Tlemcen', 'Tlemcen', 'تلمسان', '2026-08-09 23:55:52.277404+00'),
	('14', 'Tiaret', 'Tiaret', 'تيارت', '2026-08-09 23:55:52.277404+00'),
	('15', 'Tizi Ouzou', 'Tizi Ouzou', 'تيزي وزو', '2026-08-09 23:55:52.277404+00'),
	('16', 'Alger', 'Algiers', 'الجزائر', '2026-08-09 23:55:52.277404+00'),
	('17', 'Djelfa', 'Djelfa', 'الجلفة', '2026-08-09 23:55:52.277404+00'),
	('18', 'Jijel', 'Jijel', 'جيجل', '2026-08-09 23:55:52.277404+00'),
	('19', 'Sétif', 'Setif', 'سطيف', '2026-08-09 23:55:52.277404+00'),
	('20', 'Saïda', 'Saida', 'سعيدة', '2026-08-09 23:55:52.277404+00'),
	('21', 'Skikda', 'Skikda', 'سكيكدة', '2026-08-09 23:55:52.277404+00'),
	('22', 'Sidi Bel Abbès', 'Sidi Bel Abbes', 'سيدي بلعباس', '2026-08-09 23:55:52.277404+00'),
	('23', 'Annaba', 'Annaba', 'عنابة', '2026-08-09 23:55:52.277404+00'),
	('24', 'Guelma', 'Guelma', 'قالمة', '2026-08-09 23:55:52.277404+00'),
	('25', 'Constantine', 'Constantine', 'قسنطينة', '2026-08-09 23:55:52.277404+00'),
	('26', 'Médéa', 'Medea', 'المدية', '2026-08-09 23:55:52.277404+00'),
	('27', 'Mostaganem', 'Mostaganem', 'مستغانم', '2026-08-09 23:55:52.277404+00'),
	('28', 'M''Sila', 'M''Sila', 'المسيلة', '2026-08-09 23:55:52.277404+00'),
	('29', 'Mascara', 'Mascara', 'معسكر', '2026-08-09 23:55:52.277404+00'),
	('30', 'Ouargla', 'Ouargla', 'ورقلة', '2026-08-09 23:55:52.277404+00'),
	('31', 'Oran', 'Oran', 'وهران', '2026-08-09 23:55:52.277404+00'),
	('32', 'El Bayadh', 'El Bayadh', 'البيض', '2026-08-09 23:55:52.277404+00'),
	('33', 'Illizi', 'Illizi', 'إليزي', '2026-08-09 23:55:52.277404+00'),
	('34', 'Bordj Bou Arréridj', 'Bordj Bou Arreridj', 'برج بوعريريج', '2026-08-09 23:55:52.277404+00'),
	('35', 'Boumerdès', 'Boumerdes', 'بومرداس', '2026-08-09 23:55:52.277404+00'),
	('36', 'El Tarf', 'El Tarf', 'الطارف', '2026-08-09 23:55:52.277404+00'),
	('37', 'Tindouf', 'Tindouf', 'تندوف', '2026-08-09 23:55:52.277404+00'),
	('38', 'Tissemsilt', 'Tissemsilt', 'تيسمسيلت', '2026-08-09 23:55:52.277404+00'),
	('39', 'El Oued', 'El Oued', 'الوادي', '2026-08-09 23:55:52.277404+00'),
	('40', 'Khenchela', 'Khenchela', 'خنشلة', '2026-08-09 23:55:52.277404+00'),
	('41', 'Souk Ahras', 'Souk Ahras', 'سوق أهراس', '2026-08-09 23:55:52.277404+00'),
	('42', 'Tipaza', 'Tipaza', 'تيبازة', '2026-08-09 23:55:52.277404+00'),
	('43', 'Mila', 'Mila', 'ميلة', '2026-08-09 23:55:52.277404+00'),
	('44', 'Aïn Defla', 'Ain Defla', 'عين الدفلى', '2026-08-09 23:55:52.277404+00'),
	('45', 'Naâma', 'Naama', 'النعامة', '2026-08-09 23:55:52.277404+00'),
	('46', 'Aïn Témouchent', 'Ain Temouchent', 'عين تموشنت', '2026-08-09 23:55:52.277404+00'),
	('47', 'Ghardaïa', 'Ghardaia', 'غرداية', '2026-08-09 23:55:52.277404+00'),
	('48', 'Relizane', 'Relizane', 'غليزان', '2026-08-09 23:55:52.277404+00'),
	('49', 'Timimoun', 'Timimoun', 'تيميمون', '2026-08-09 23:55:52.277404+00'),
	('50', 'Bordj Badji Mokhtar', 'Bordj Badji Mokhtar', 'برج باجي مختار', '2026-08-09 23:55:52.277404+00'),
	('51', 'Ouled Djellal', 'Ouled Djellal', 'أولاد جلال', '2026-08-09 23:55:52.277404+00'),
	('52', 'Béni Abbès', 'Beni Abbes', 'بني عباس', '2026-08-09 23:55:52.277404+00'),
	('53', 'In Salah', 'In Salah', 'عين صالح', '2026-08-09 23:55:52.277404+00'),
	('54', 'In Guezzam', 'In Guezzam', 'عين قزام', '2026-08-09 23:55:52.277404+00'),
	('55', 'Touggourt', 'Touggourt', 'تقرت', '2026-08-09 23:55:52.277404+00'),
	('56', 'Djanet', 'Djanet', 'جانت', '2026-08-09 23:55:52.277404+00'),
	('57', 'El M''Ghair', 'El M''Ghair', 'المغير', '2026-08-09 23:55:52.277404+00'),
	('58', 'El Meniaa', 'El Meniaa', 'المنيعة', '2026-08-09 23:55:52.277404+00'),
	('59', 'Aflou', 'Aflou', 'أفلو', '2026-08-09 23:55:52.277404+00'),
	('60', 'Barika', 'Barika', 'بريكة', '2026-08-09 23:55:52.277404+00'),
	('61', 'El Kantara', 'El Kantara', 'القنطرة', '2026-08-09 23:55:52.277404+00'),
	('62', 'Bir El Ater', 'Bir El Ater', 'بئر العاتر', '2026-08-09 23:55:52.277404+00'),
	('63', 'El Aricha', 'El Aricha', 'العريشة', '2026-08-09 23:55:52.277404+00'),
	('64', 'Bou Saâda', 'Bou Saada', 'بوسعادة', '2026-08-09 23:55:52.277404+00'),
	('65', 'Ksar El Boukhari', 'Ksar El Boukhari', 'قصر البخاري', '2026-08-09 23:55:52.277404+00'),
	('66', 'Ksar Chellala', 'Ksar Chellala', 'قصر الشلالة', '2026-08-09 23:55:52.277404+00'),
	('67', 'Messaad', 'Messaad', 'مسعد', '2026-08-09 23:55:52.277404+00'),
	('68', 'Aïn Oussera', 'Ain Oussera', 'عين وسارة', '2026-08-09 23:55:52.277404+00'),
	('69', 'El Abiodh Sidi Cheikh', 'El Abiodh Sidi Cheikh', 'الأبيض سيدي الشيخ', '2026-08-09 23:55:52.277404+00');


--
-- Data for Name: carriers_dz; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."carriers_dz" ("id", "user_id", "company_name", "contact_name", "email", "phone", "carrier_number", "address", "city", "zones_covered", "transport_capacity", "vehicle_types", "tax_id", "bank_details", "rating_avg", "active", "notes", "created_at", "updated_at", "kyc_status", "kyc_reviewed_at", "kyc_reviewed_by", "legal_form", "business_status", "deleted_at", "wilaya_code") VALUES
	('21224e17-3573-4e6d-8a59-aabb9346e147', NULL, 'SNTR - Société Nationale des Transports Routiers SPA', NULL, NULL, NULL, NULL, NULL, 'Kouba, Alger', '["national"]', 'Entreprise publique, flotte de véhicules poids lourds', '["camions", "semi-remorques"]', NULL, NULL, 0.0, true, 'Entreprise publique historique de transport routier de marchandises. Siège Route Nationale n°5, Cinq Maisons, Mohammadia/Kouba Alger. Source: annuaires Pages Jaunes DZ / El Mouchir CACI.', '2026-08-14 05:06:18.816788+00', '2026-08-14 05:06:18.816788+00', 'pending', NULL, NULL, NULL, 'active', NULL, '16'),
	('fe54e563-04d0-4826-8e8f-3755a9eef9b0', NULL, 'Transports Chakour (Groupe Chakour)', NULL, NULL, NULL, NULL, NULL, NULL, '["national"]', 'Plus de 40 ans d''expérience, spécialiste transport exceptionnel pour industrie, travaux publics et secteur pétrolier', '["vrac", "palettes", "conteneurisé", "convois exceptionnels"]', NULL, NULL, 0.0, true, 'Leader de la logistique routière en Algérie. Source: groupe-chakour.com', '2026-08-14 05:06:18.816788+00', '2026-08-14 05:06:18.816788+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('6565f597-2d40-40d5-82c4-91481d2c766a', NULL, 'EPS Benali Trans', NULL, NULL, NULL, NULL, NULL, 'Ouargla', '["Ouargla", "Sud algérien"]', 'Location de matériel de transport routier', '["citernes lubrifiant", "citernes produits pétroliers", "citernes eau industrielle et potable"]', NULL, NULL, 0.0, true, 'Source: annuaire Kompass Algérie, wilaya Ouargla.', '2026-08-14 05:18:58.647014+00', '2026-08-14 05:18:58.647014+00', 'pending', NULL, NULL, NULL, 'active', NULL, '30');


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
-- Data for Name: company_contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: conversation_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: delivery_companies; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: freight_forwarders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."freight_forwarders" ("id", "user_id", "company_name", "contact_name", "email", "phone", "license_number", "address", "city", "country", "ports_covered", "services", "tax_id", "bank_details", "rating_avg", "active", "notes", "created_at", "updated_at", "kyc_status", "kyc_reviewed_at", "kyc_reviewed_by", "legal_form", "business_status", "deleted_at") VALUES
	('2170ae0d-6d2e-4db0-ad2b-e9173432c299', NULL, 'AICAL Consignation Transit & Conseils', NULL, NULL, NULL, NULL, NULL, 'Alger', 'Algérie', '["Alger", "Skikda", "Annaba", "El-Ayoun"]', '["commissionnaire en douane agréé", "consignation maritime", "transit international", "transport véhicules"]', NULL, NULL, 0.0, true, 'Agréée en douane en 2004. Agences à Alger, Skikda, Annaba et poste frontalier El-Ayoun. Source: aical.dz', '2026-08-14 05:06:18.816788+00', '2026-08-14 05:06:18.816788+00', 'pending', NULL, NULL, NULL, 'active', NULL),
	('c2e839af-c0c9-4b1a-b7f4-e1f57f291c40', NULL, 'BRAKTA Transit', NULL, NULL, NULL, NULL, NULL, 'Alger', 'Algérie', '["Alger"]', '["commissionnaire en douane agréé", "dédouanement import/export", "EDI SIGAD", "gestion électronique des documents"]', NULL, NULL, 0.0, true, 'Agréée en douane en 2006. Source: braktatransit.com', '2026-08-14 05:06:18.816788+00', '2026-08-14 05:06:18.816788+00', 'pending', NULL, NULL, NULL, 'active', NULL),
	('50dd086f-ea2a-4b4f-96af-f5767a3c5843', NULL, 'Transit Harieche (TRANST HARIECHE - Transit Air Terre Mer)', NULL, NULL, NULL, NULL, NULL, 'Alger', 'Algérie', '["Alger"]', '["dédouanement import/export", "conseil douanier", "transit air/terre/mer"]', NULL, NULL, 0.0, true, 'Entreprise familiale créée en janvier 1999 par un ancien directeur général des douanes par intérim. Source: transit-harieche.com', '2026-08-14 05:06:18.816788+00', '2026-08-14 05:06:18.816788+00', 'pending', NULL, NULL, NULL, 'active', NULL),
	('4cebe5da-0e12-4a8a-b3a5-73cccadc366f', NULL, 'Kiffani Transit', NULL, NULL, NULL, NULL, NULL, NULL, 'Algérie', '[]', '["commissionnaire en douanes agréé", "fret aérien", "transport routier", "transit portuaire", "transport exceptionnel", "solution ferroviaire"]', NULL, NULL, 0.0, true, 'Référencé sur annuaire Kompass Algérie, catégorie agents d''expédition/transitaires.', '2026-08-14 05:06:18.816788+00', '2026-08-14 05:06:18.816788+00', 'pending', NULL, NULL, NULL, 'active', NULL),
	('f14783d3-53ba-4416-ab3f-d0619dd249cb', NULL, 'EL BAHIA TRANSIT SARL', NULL, NULL, NULL, NULL, NULL, 'Oran', 'Algérie', '["Oran"]', '["commissionnaire agréé en douane", "consignation", "transport national et international"]', NULL, NULL, 0.0, true, 'Source: annuaire Pagesmaghreb.', '2026-08-14 05:14:41.528505+00', '2026-08-14 05:14:41.528505+00', 'pending', NULL, NULL, NULL, 'active', NULL),
	('b4486742-f999-48c2-b5db-8587a0a523fc', NULL, 'SARL TRANS BTM', NULL, NULL, NULL, NULL, NULL, 'Oran', 'Algérie', '["Oran"]', '["transit", "dédouanement", "fret", "transport", "commissionnaire en douane"]', NULL, NULL, 0.0, true, 'Connexion directe au centre de saisie des douanes. Source: transit-btm.com', '2026-08-14 05:14:41.528505+00', '2026-08-14 05:14:41.528505+00', 'pending', NULL, NULL, NULL, 'active', NULL),
	('b8c530e8-cab3-4fc3-b23e-fff4f4b06ff8', NULL, 'West Freight Logistics (GIE OLM / Actrans)', NULL, NULL, NULL, NULL, NULL, 'Oran', 'Algérie', '["Mostaganem", "Oran", "Arzew", "Béthioua", "Béni Saf", "Ghazaouet"]', '["commissionnaire en douane", "commissionnaire en transport"]', NULL, NULL, 0.0, true, 'Groupement d''Intérêt Économique entre OLM (commissionnaire en douane) et Actrans (commissionnaire en transport), couvre toute la région Ouest. Adresse: 48 Bd Mohamed Maata, Oran. Source: LinkedIn OLM logistique & manutention.', '2026-08-14 05:14:41.528505+00', '2026-08-14 05:14:41.528505+00', 'pending', NULL, NULL, NULL, 'active', NULL),
	('b0a25a2d-f1b6-4221-adf5-fbefbcee64d5', NULL, 'EL BAHDJAOUI TRANSIT', NULL, NULL, NULL, NULL, NULL, 'Béjaïa', 'Algérie', '["Béjaïa"]', '["commissionnaire en douanes", "transport"]', NULL, NULL, 0.0, true, 'Source: annuaire Pagesmaghreb.', '2026-08-14 05:14:41.528505+00', '2026-08-14 05:14:41.528505+00', 'pending', NULL, NULL, NULL, 'active', NULL),
	('b60badc9-a084-4b23-9e2a-5f9fb53a3fa8', NULL, 'Transit El Bahdja', NULL, NULL, NULL, NULL, NULL, 'Béjaïa', 'Algérie', '["Béjaïa"]', '["commissionnaire en douane"]', NULL, NULL, 0.0, true, 'Source: transitelbahdja.com', '2026-08-14 05:14:41.528505+00', '2026-08-14 05:14:41.528505+00', 'pending', NULL, NULL, NULL, 'active', NULL),
	('a558d0c5-c6f7-48d0-8d0c-5387a5d3dc6e', NULL, 'GH Logistique', NULL, NULL, NULL, NULL, NULL, 'Béjaïa', 'Algérie', '["Béjaïa"]', '["dédouanement", "logistique", "stockage", "fret air/mer", "transport routier de marchandises"]', NULL, NULL, 0.0, true, 'Localisée à proximité du port et de l''aéroport de Béjaïa. Source: ghlogistique.com', '2026-08-14 05:14:41.528505+00', '2026-08-14 05:14:41.528505+00', 'pending', NULL, NULL, NULL, 'active', NULL),
	('a8dec2a4-e4a4-4b01-8507-2217a6ec6b63', NULL, 'ALTRANS TRANSIT', NULL, NULL, NULL, NULL, NULL, 'Skikda', 'Algérie', '["Skikda"]', '["transitaire", "commissionnaire en douanes", "assistance et conseil import/export", "dédouanement marchandises et véhicules"]', NULL, NULL, 0.0, true, 'Source: annuaire Pagesmaghreb.', '2026-08-14 05:14:41.528505+00', '2026-08-14 05:14:41.528505+00', 'pending', NULL, NULL, NULL, 'active', NULL),
	('6c1a01bc-2bd4-4c71-a5e0-9380f1a97f9f', NULL, 'Transit Feteissa Skikda', NULL, NULL, NULL, NULL, NULL, 'Skikda', 'Algérie', '["Skikda"]', '["commissionnaire en douane"]', NULL, NULL, 0.0, true, 'Adresse: Rue de l''Ecole, Beni Malek, Skikda. Source: annuaire vitaminedz.com.', '2026-08-14 05:14:41.528505+00', '2026-08-14 05:14:41.528505+00', 'pending', NULL, NULL, NULL, 'active', NULL),
	('b226c680-5670-4c2c-97db-82aba8acf5d7', NULL, 'Transit Meridji', NULL, NULL, NULL, NULL, NULL, 'Mostaganem', 'Algérie', '["Mostaganem"]', '["dédouanement import/export"]', NULL, NULL, 0.0, true, 'Source: annuaire Pagesmaghreb.', '2026-08-14 05:14:41.528505+00', '2026-08-14 05:14:41.528505+00', 'pending', NULL, NULL, NULL, 'active', NULL),
	('5e79d4ee-1608-4b04-83e3-310f0f163868', NULL, 'Piramid Logistics', NULL, NULL, NULL, NULL, NULL, 'Mostaganem', 'Algérie', '["Mostaganem"]', '["commissionnaire en douane", "transit logistique", "transport routier et maritime", "shipping"]', NULL, NULL, 0.0, true, 'Source: annuaire Pagesmaghreb.', '2026-08-14 05:14:41.528505+00', '2026-08-14 05:14:41.528505+00', 'pending', NULL, NULL, NULL, 'active', NULL),
	('e2e436a4-58d9-41e3-bd43-9250ae522740', NULL, 'Zone logistique extra-portuaire de Tixter (ex-port sec, rattaché au port de Béjaïa)', NULL, NULL, NULL, NULL, NULL, 'Tixter, Bordj Bou Arréridj', 'Algérie', '["Béjaïa"]', '["dédouanement (guichet unique douanes)", "transbordement conteneurs", "stockage sous douane", "liaison ferroviaire dédiée"]', NULL, NULL, 0.0, true, 'Gérée par l''Entreprise Portuaire de Béjaïa (EPB). Superficie 55 ha, à 20-25 km de Bordj Bou Arréridj et 30-41 km de Sétif. Dessert le bassin économique Sétif/Bordj Bou Arréridj/M''sila. Inaugurée en 2016, fermée en 2020-2021 avec les 21 autres ports secs du pays pour non-conformité (décision présidentielle), puis réouverte officiellement le 11 mars 2025 sous le nouveau statut de "zone d''espace" sous contrôle douanier du port de Béjaïa. Premier train de conteneurs Béjaïa-Tixter le 13 mars 2025. Présentée comme le 1er de 5 pôles logistiques extra-portuaires prévus pour être reliés à tous les ports du pays. Sources: El Moudjahid, El Watan, Algérie Éco, ObservAlgérie, mars 2025.', '2026-08-14 05:18:58.647014+00', '2026-08-14 05:18:58.647014+00', 'pending', NULL, NULL, NULL, 'active', NULL);


--
-- Data for Name: kyc_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."suppliers" ("id", "user_id", "company_name", "contact_name", "email", "phone", "supplier_number", "address", "city", "product_categories", "certifications", "tax_id", "bank_details", "rating_avg", "notes", "active", "created_at", "updated_at", "kyc_status", "kyc_reviewed_at", "kyc_reviewed_by", "legal_form", "business_status", "deleted_at", "wilaya_code") VALUES
	('314aa6f7-2c65-4288-afd4-5e16e82b6c3a', NULL, 'Alelea', NULL, NULL, NULL, NULL, NULL, NULL, '["huile d''olive"]', '[]', NULL, NULL, 0.0, 'Marque d''huile d''olive commercialisée en Algérie, référencée sur superetti.dz', true, '2026-08-12 19:57:52.966038+00', '2026-08-12 19:57:52.966038+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('fcdb95ca-899c-4c04-8cea-008d4e197c80', NULL, 'El Hourra / Al Hourra', NULL, NULL, NULL, NULL, NULL, NULL, '["huile d''olive"]', '[]', NULL, NULL, 0.0, 'Marque(s) d''huile d''olive commercialisées en Algérie sous variantes El-Horra / El-Hourra / Al-Hourra, référencées sur superetti.dz', true, '2026-08-12 19:57:52.966038+00', '2026-08-12 19:57:52.966038+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('8e72fb5f-d844-49d0-be10-0bb6262adbb2', NULL, 'El Djaouda (El-Ghosn Lmobarak)', NULL, NULL, NULL, NULL, NULL, NULL, '["huile d''olive"]', '[]', NULL, NULL, 0.0, 'Marque d''huile d''olive commercialisée en Algérie, référencée sur superetti.dz', true, '2026-08-12 19:57:52.966038+00', '2026-08-12 19:57:52.966038+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('a98affeb-eb19-4399-bf06-e087da1d4b87', NULL, 'SOS (riz)', NULL, NULL, NULL, NULL, NULL, NULL, '["riz"]', '[]', NULL, NULL, 0.0, 'Marque de riz blanc long grain distribuée en Algérie, référencée sur superetti.dz', true, '2026-08-12 19:57:52.966038+00', '2026-08-12 19:57:52.966038+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('93826b4e-19c2-47e4-b652-a06456320da1', NULL, 'Azul Cosmétique', NULL, NULL, NULL, NULL, NULL, NULL, '["cosmétiques naturels", "huile d''olive cosmétique", "savons"]', '[]', NULL, NULL, 0.0, 'Marque algérienne "Made in Algeria" de cosmétiques naturels (huile d''olive de Kabylie, huile de pépins de figue de barbarie, savons saponifiés à froid). Site: azul-cosmetique-dz.com', true, '2026-08-12 20:00:33.802834+00', '2026-08-12 20:00:33.802834+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('8fb9ac9a-f26c-4581-9221-a322f80a2353', NULL, 'Savonneries Algériennes (Aigle / Sido / Le Chat)', NULL, NULL, NULL, NULL, NULL, NULL, '["savon", "entretien / nettoyage"]', '[]', NULL, NULL, 0.0, 'Regroupe plusieurs marques distinctes de savon de Marseille et produits d''entretien distribuées en Algérie (Aigle, Sido, Le Chat), référencées sur superetti.dz', true, '2026-08-12 20:00:33.802834+00', '2026-08-12 20:00:33.802834+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('6df6d1cd-5a84-4568-9deb-f05008db148a', NULL, 'Ifri (Ibrahim & Fils)', NULL, NULL, NULL, NULL, NULL, 'Ighzer Amokrane', '["boissons", "eaux", "huile d''olive"]', '[]', NULL, NULL, 0.0, 'Groupe agroalimentaire algérien (eaux, boissons, huile d''olive), siège à Ighzer Amokrane, Béjaïa', true, '2026-08-12 19:57:52.966038+00', '2026-08-13 02:16:13.547126+00', 'pending', NULL, NULL, NULL, 'active', NULL, '06'),
	('52ca1de2-4821-400c-bed7-636eb8f7a43b', NULL, 'Baghlia (Huilerie traditionnelle)', NULL, NULL, NULL, NULL, NULL, 'Baghlia', '["huile d''olive"]', '[]', NULL, NULL, 0.0, 'Marque régionale d''huile d''olive de Kabylie, catégorie Baghlia extra vierge, référencée sur superetti.dz', true, '2026-08-12 19:57:52.966038+00', '2026-08-13 02:16:13.547126+00', 'pending', NULL, NULL, NULL, 'active', NULL, '06'),
	('7b87c62c-9d16-499c-8806-e31bea7a67bf', NULL, 'Ghezzal Dattes', NULL, NULL, NULL, NULL, NULL, 'Biskra', '["dattes"]', '[]', NULL, NULL, 0.0, 'Marque de dattes Deglet Nour et dérivés (pâte de datte), région de Biskra', true, '2026-08-12 19:57:52.966038+00', '2026-08-13 02:16:13.547126+00', 'pending', NULL, NULL, NULL, 'active', NULL, '07'),
	('1d7fabfd-4d70-41e8-b37c-3ec6b298f9de', NULL, 'GICA - Groupe Industriel des Ciments d''Algérie', NULL, 'secretariat.dg@gica.dz', '+213 25 33 57 94', NULL, NULL, 'Meftah', '["ciment", "matériaux de construction"]', '[]', NULL, NULL, 0.0, 'Leader national du ciment en Algérie, 14 cimenteries, normes NA 442/2013. Siège: Route de Dar El Beida - Meftah (W. Blida)', true, '2026-08-12 20:00:33.802834+00', '2026-08-13 02:16:13.547126+00', 'pending', NULL, NULL, NULL, 'active', NULL, '09'),
	('b7cd2b77-f5fd-4e0f-a8fd-cc571dd6127b', NULL, 'Amor Benamor', NULL, NULL, NULL, NULL, NULL, 'Guelma', '["pâtes alimentaires", "couscous", "conserves", "concentré de tomate"]', '[]', NULL, NULL, 0.0, 'Groupe agroalimentaire algérien historique, pâtes, couscous et conserves, siège à Guelma', true, '2026-08-12 19:57:52.966038+00', '2026-08-13 02:16:13.547126+00', 'pending', NULL, NULL, NULL, 'active', NULL, '24'),
	('ca00849a-ce1e-4e34-b001-940f14984105', NULL, 'Tosyali Algérie', NULL, 'ventes@tosyalidz.com', NULL, NULL, NULL, 'Bethioua', '["acier", "rond à béton", "fil machine"]', '[]', NULL, NULL, 0.0, 'Premier producteur de fer et acier d''Algérie, rond à béton TOSYALI 500 (acier B500B, norme NF A 35-080-1). Pôle Économique Plateau Gourirate, Commune de Bethioua, Wilaya d''Oran. Contact export: export@tosyalidz.com', true, '2026-08-12 20:00:33.802834+00', '2026-08-13 02:16:13.547126+00', 'pending', NULL, NULL, NULL, 'active', NULL, '31'),
	('8e9dd2c8-2457-47f6-811c-98672f223eeb', NULL, 'Condor Electronics', NULL, NULL, NULL, NULL, NULL, 'Bordj Bou Arréridj', '["climatisation", "électroménager", "téléviseurs", "téléphonie", "machines à laver"]', '[]', NULL, NULL, 0.0, 'Entreprise algérienne d''électronique et électroménager, filiale à 100% du groupe Benhamadi, créée en 2002. Leader du marché algérien (35% électroménager, 55% téléphonie mobile). Exporte vers 35 pays dont France, Tunisie, Jordanie, Mauritanie, Sénégal, Bénin (source: Wikipedia/presse). Siège: ZAC Route de M''Sila, Bordj Bou Arréridj', true, '2026-08-12 20:03:35.312664+00', '2026-08-13 02:16:13.547126+00', 'pending', NULL, NULL, NULL, 'active', NULL, '34'),
	('cebf5d2a-0d77-48fa-ae91-5e1e6fe40c75', NULL, 'CCLS Ouargla - Coopérative des Céréales et Légumes Secs', NULL, NULL, NULL, NULL, NULL, 'Ouargla', '["céréales", "légumes secs", "semences"]', '[]', NULL, NULL, 0.0, 'Filiale du réseau OAIC (Office Algérien Interprofessionnel des Céréales), qui contrôle environ 80% du marché algérien des céréales via 41 CCLS. Source: annuaire Pages Jaunes DZ / rapport IPEMED.', true, '2026-08-14 05:14:41.528505+00', '2026-08-14 05:14:41.528505+00', 'pending', NULL, NULL, NULL, 'active', NULL, '30'),
	('62c987f9-4093-4f49-afe3-eab021fd4cea', NULL, 'CCLS El Affroun (Blida) - Coopérative des Céréales et Légumes Secs', NULL, NULL, NULL, NULL, NULL, 'El Affroun', '["céréales", "légumes secs"]', '[]', NULL, NULL, 0.0, 'Réseau OAIC. Source: annuaire Pages Jaunes DZ.', true, '2026-08-14 05:14:41.528505+00', '2026-08-14 05:14:41.528505+00', 'pending', NULL, NULL, NULL, 'active', NULL, '09'),
	('0e0c0172-bd20-4b43-821f-8f35d0d4074d', NULL, 'CCLS Relizane - Coopérative des Céréales et Légumes Secs', NULL, NULL, NULL, NULL, NULL, 'Relizane', '["céréales", "légumes secs"]', '[]', NULL, NULL, 0.0, 'Réseau OAIC. Source: annuaire Pages Jaunes DZ.', true, '2026-08-14 05:14:41.528505+00', '2026-08-14 05:14:41.528505+00', 'pending', NULL, NULL, NULL, 'active', NULL, '48'),
	('f7eb09f6-d624-4556-8f64-553f4780d7aa', NULL, 'CCLS Aïn M''lila - Coopérative des Céréales et Légumes Secs', NULL, NULL, NULL, NULL, NULL, 'Aïn M''lila', '["céréales", "légumes secs", "semences", "engrais"]', '[]', NULL, NULL, 0.0, 'Fournit aussi semences et engrais aux agriculteurs. Réseau OAIC. Source: ccls-ainmlila.dz', true, '2026-08-14 05:14:41.528505+00', '2026-08-14 05:14:41.528505+00', 'pending', NULL, NULL, NULL, 'active', NULL, '04'),
	('d583041b-25f4-49b1-ba05-5ee715a002f2', NULL, 'CCLS Sidi Bel Abbès (Lamtar) - Coopérative des Céréales et Légumes Secs', NULL, NULL, NULL, NULL, NULL, 'Lamtar, Sidi Bel Abbès', '["céréales", "légumes secs"]', '[]', NULL, NULL, 0.0, 'Réseau OAIC. Source: annuaire Pages Jaunes DZ.', true, '2026-08-14 05:14:41.528505+00', '2026-08-14 05:14:41.528505+00', 'pending', NULL, NULL, NULL, 'active', NULL, '22'),
	('aecea1c4-60b3-4983-b18e-a2b7aed4b7fb', NULL, 'CCLS Tiaret - Coopérative des Céréales et Légumes Secs', NULL, NULL, NULL, NULL, NULL, 'Tiaret', '["céréales", "légumes secs"]', '[]', NULL, NULL, 0.0, 'Réseau OAIC. Source: annuaire Pages Jaunes DZ.', true, '2026-08-14 05:14:41.528505+00', '2026-08-14 05:14:41.528505+00', 'pending', NULL, NULL, NULL, 'active', NULL, '14'),
	('9d1001e8-1998-4e9e-b553-fae50742a9d9', NULL, 'Agrodat', NULL, NULL, NULL, NULL, NULL, 'Biskra', '["dattes"]', '[]', NULL, NULL, 0.0, 'Unité moderne de traitement, emballage et exportation de dattes, zone d''équipement de Biskra. Source: El Watan.', true, '2026-08-14 05:14:56.584123+00', '2026-08-14 05:14:56.584123+00', 'pending', NULL, NULL, NULL, 'active', NULL, '07'),
	('e2948df7-ae77-4874-b254-879aa3cd1751', NULL, 'Sud Datte Company (Sudaco)', NULL, NULL, NULL, NULL, NULL, 'Biskra', '["dattes"]', '[]', NULL, NULL, 0.0, 'Entreprise nationale de conditionnement de dattes, en partenariat avec des exportateurs privés pour promouvoir la datte algérienne à l''export. Source: étude filière dattes.', true, '2026-08-14 05:14:56.584123+00', '2026-08-14 05:14:56.584123+00', 'pending', NULL, NULL, NULL, 'active', NULL, '07'),
	('6beaf5c0-2c9b-422f-bdc4-3e76c4726d49', NULL, 'Datol Export', NULL, NULL, NULL, NULL, NULL, 'Tolga, Biskra', '["dattes", "fruits et légumes"]', '[]', NULL, NULL, 0.0, 'Adresse: 122 avenue Si El Haoues, Tolga, Biskra. Source: annuaire vitaminedz.com.', true, '2026-08-14 05:14:56.584123+00', '2026-08-14 05:14:56.584123+00', 'pending', NULL, NULL, NULL, 'active', NULL, '07'),
	('6f088f19-52c8-46e8-a7ea-a7552b7d1e7a', NULL, 'Laboratoires Vénus / SAPECO', NULL, NULL, NULL, NULL, NULL, 'Ouled Yaïch, Blida', '["shampooings", "démêlants", "masques capillaires", "crèmes coiffantes", "laque", "sérums capillaires", "shampooing et lotion anti-poux", "gel douche", "mousse de douche", "savon liquide", "gel antibactérien", "déodorant", "brume parfumée", "cire et crème dépilatoires", "soins dermiques Viderm (purifiant, anti-âge, soin, régulateur)", "démaquillant et lingettes micellaires", "dentifrices (Dentomint, Buccowhite)", "gamme bébé (shampooing, lait de toilette, eau de cologne, eau de toilette, lingettes)", "crèmes solaires Viderm Solaire", "gamme homme Venus Men (gel douche, déodorant, body spray, deo roll-on)"]', '[]', NULL, NULL, 0.0, 'Entreprise familiale fondée en 1981 par Mourad Moula (aujourd''hui dirigée par Kamel Moula), leader du cosmétique/hygiène en Algérie avec ~33% de part de marché, plus de 500 salariés, 5 sites dont un laboratoire de recherche et un laboratoire métrologique (2014). Exporte vers Libye, Tunisie, Maroc, Niger, Côte d''Ivoire, Madagascar. Adresse: 202 Rue du 17 septembre 1956, 09086 Ouled Yaïch, Blida. Contact: contact@labovenus.dz / +213 (0)560 215 456. Sources: laboratoiresvenus.com, El Mouchir CACI, Jeune Afrique, Le Matin d''Algérie.', true, '2026-08-14 05:21:43.135806+00', '2026-08-14 05:21:43.135806+00', 'pending', NULL, NULL, NULL, 'active', NULL, '09'),
	('b245b5b0-c931-452c-9e9e-513cda7a29df', NULL, 'Vivacos Cosmétique', NULL, NULL, NULL, NULL, NULL, 'Boumerdès', '["dentifrice", "crème dépilatoire", "savon antibactérien", "savon liquide", "huile pour cheveux", "vaseline"]', '[]', NULL, NULL, 0.0, 'Fabricant algérien de produits cosmétiques et d''hygiène corporelle. Source: annuaire Kompass Algérie, page Facebook Vivacos Cosmetique Boumerdas, vivacos.net.', true, '2026-08-14 05:21:43.135806+00', '2026-08-14 05:21:43.135806+00', 'pending', NULL, NULL, NULL, 'active', NULL, '35'),
	('28832b50-c371-470e-8218-ea10df3bd65b', NULL, 'Les Laboratoires Albocos', NULL, NULL, NULL, NULL, NULL, 'Alger', '["produits dépilatoires (marque MIM)"]', '[]', NULL, NULL, 0.0, 'Fondée par Abdelhakim Rehouma, plus de 25 ans d''expérience, spécialisée dans les produits dépilatoires, distribution sur tout le territoire algérien. Source: annuaire Kompass Algérie / Mantooj.net.', true, '2026-08-14 05:21:43.135806+00', '2026-08-14 05:21:43.135806+00', 'pending', NULL, NULL, NULL, 'active', NULL, '16'),
	('2a39af09-fab5-4adf-b751-0ae56388e597', NULL, 'Hayat DHC Algérie', NULL, NULL, NULL, NULL, NULL, 'Bouinan, Blida', '["serviettes hygiéniques (marque Molped)", "couches bébé (marque Molfix)"]', '[]', NULL, NULL, 0.0, 'Filiale du groupe turc Hayat, investissements lancés en 2005 dans le complexe de production de Bouinan (Blida), deux usines de production. Source: annuaire Kompass Algérie.', true, '2026-08-14 05:21:43.135806+00', '2026-08-14 05:21:43.135806+00', 'pending', NULL, NULL, NULL, 'active', NULL, '09'),
	('78d7fbae-ad31-4764-8315-645362799481', NULL, 'Cevital Agro-Industrie', NULL, NULL, NULL, NULL, NULL, 'Bejaïa (complexe portuaire)', '["sucre", "huiles alimentaires", "margarines et graisses végétales", "céréales", "boissons fruitées", "eaux minérales", "chaux"]', '[]', NULL, NULL, 0.0, 'Filiale du groupe Cevital (fondé par Issad Rebrab en 1998), 1er groupe agro-industriel privé d''Algérie. Complexe de Bejaïa: plus grande raffinerie de sucre au monde (2 Mt/an) et plus grande raffinerie d''huile d''Afrique (570 000 t/an), plus grand terminal de déchargement portuaire du bassin méditerranéen. A fait passer l''Algérie du statut d''importateur à exportateur pour huiles, margarines et sucre; exporte vers Europe, Maghreb, Moyen-Orient, Afrique de l''Ouest. Sources: cevital.com, Wikipédia, Jeune Afrique.', true, '2026-08-14 05:21:43.135806+00', '2026-08-14 05:21:43.135806+00', 'pending', NULL, NULL, NULL, 'active', NULL, '06'),
	('201d63bb-9f34-4bf4-83e4-904637c34ba4', NULL, 'NCA Rouiba (Nouvelle Conserverie Algérienne)', NULL, NULL, NULL, NULL, NULL, 'Rouiba, Alger', '["jus de fruits", "nectars", "boissons à base de fruits", "concentré de tomate", "harissa", "confitures"]', '[]', NULL, NULL, 0.0, 'Fondée en 1966 par Mohamed Said et Salah Othmani, n°1 algérien des boissons à base de fruits sous la marque Rouiba, cotée en Bourse d''Alger depuis 2003 (SPA) puis 2013 (introduction en bourse). Cevital détient 15% du capital depuis 2014. Source: Wikipédia, Jeune Afrique.', true, '2026-08-14 05:21:43.135806+00', '2026-08-14 05:21:43.135806+00', 'pending', NULL, NULL, NULL, 'active', NULL, '16'),
	('b5e23816-5c18-472b-8f8e-909a19da5957', NULL, 'Agro Vitalis', NULL, NULL, NULL, NULL, NULL, 'Boufarik, Blida', '["fruits et légumes frais"]', '[]', NULL, NULL, 0.0, 'Producteur et grossiste-exportateur de fruits et légumes frais basé à Boufarik, plaine de la Mitidja. Source: agrovitalis.com.', true, '2026-08-14 05:23:34.578793+00', '2026-08-14 05:23:34.578793+00', 'pending', NULL, NULL, NULL, 'active', NULL, '09'),
	('31d6ebc5-25a6-4c40-91b3-36351b357118', NULL, 'Condor Electronics', NULL, NULL, NULL, NULL, NULL, NULL, '["réfrigérateurs", "congélateurs", "machines à laver", "climatiseurs", "chauffe-eau", "chauffage", "tables de cuisson", "cuisinières", "petit électroménager", "téléviseurs"]', '[]', NULL, NULL, 0.0, 'Division électronique du groupe Condor. Données catalogue fournies par l''utilisateur (document master data B2B).', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('a8031057-d241-4f4c-8b56-48ebcc5eef8f', NULL, 'Condor Plast', NULL, NULL, NULL, NULL, NULL, NULL, '["mobilier plastique", "casiers de manutention", "articles ménagers plastique", "préformes PET"]', '[]', NULL, NULL, 0.0, 'Division plasturgie du groupe Condor. Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('89a8f2d3-48dd-4e3a-b91b-1753c9e808aa', NULL, 'Condor Cable', NULL, NULL, NULL, NULL, NULL, NULL, '["fils et câbles électriques domestiques"]', '[]', NULL, NULL, 0.0, 'Division câblerie du groupe Condor. Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('513b2d06-cd9d-4620-bee6-eb09c3184daa', NULL, 'ENIEM', NULL, NULL, NULL, NULL, NULL, NULL, '["réfrigérateurs", "congélateurs", "cuisinières", "machines à laver", "chauffe-eau"]', '[]', NULL, NULL, 0.0, 'Entreprise Nationale des Industries de l''Électroménager, Tizi Ouzou. Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('57436714-b13b-41fe-a2ae-8e41129352b6', NULL, 'Brandt Algérie', NULL, NULL, NULL, NULL, NULL, NULL, '["réfrigérateurs", "smartphones"]', '[]', NULL, NULL, 0.0, 'Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('a3769bc6-94e6-41a4-ab58-9e96d6b90746', NULL, 'IRIS Algérie', NULL, NULL, NULL, NULL, NULL, NULL, '["téléviseurs", "smartphones"]', '[]', NULL, NULL, 0.0, 'Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('7205e36f-3568-4896-9493-33d583bfddc6', NULL, 'Raylan', NULL, NULL, NULL, NULL, NULL, NULL, '["machines à laver", "réfrigérateurs", "micro-ondes"]', '[]', NULL, NULL, 0.0, 'Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('eb06057c-0b07-40ee-a3e4-7b08268d1116', NULL, 'Thomson (assemblé DZ)', NULL, NULL, NULL, NULL, NULL, NULL, '["téléviseurs", "tables de cuisson"]', '[]', NULL, NULL, 0.0, 'Assemblage local Algérie sous licence Thomson. Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('3b75c2e5-d6fc-45d4-8a28-61d068ca28d9', NULL, 'Cristor', NULL, NULL, NULL, NULL, NULL, NULL, '["climatiseurs"]', '[]', NULL, NULL, 0.0, 'Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('356cd740-fc57-4ef3-8d31-7357381d28a4', NULL, 'Ifri (Ets Ighriss)', NULL, NULL, NULL, NULL, NULL, NULL, '["eaux minérales", "boissons énergisantes", "jus et nectars", "sodas"]', '[]', NULL, NULL, 0.0, 'Ets Ighriss, Tazmalt (Béjaïa). Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('96b41fbc-727e-4da0-ad26-7812e247bed9', NULL, 'Hamoud Boualem', NULL, NULL, NULL, NULL, NULL, NULL, '["sodas et limonades"]', '[]', NULL, NULL, 0.0, 'Marque historique algérienne (Selecto, La Blanche, Slim, Fruital, Twist). Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('8d87d4f6-f3b7-4ea4-8f79-378012635f61', NULL, 'Groupe N''gaous', NULL, NULL, NULL, NULL, NULL, NULL, '["jus de fruits régionaux"]', '[]', NULL, NULL, 0.0, 'Spécialité région des Aurès. Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('6ff5d5c5-a558-45a0-b5a4-278b1d61f5d7', NULL, 'Groupe Ramy', NULL, NULL, NULL, NULL, NULL, NULL, '["boissons énergisantes", "jus et concentrés"]', '[]', NULL, NULL, 0.0, 'Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('2fedac56-a35e-4e2f-a7ae-9e33b42f34e4', NULL, 'Groupe BIMO', NULL, NULL, NULL, NULL, NULL, NULL, '["biscuits et gaufrettes"]', '[]', NULL, NULL, 0.0, 'Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('540ea15e-7d05-4df2-8e4b-f192ca0566dd', NULL, 'Groupe Saida', NULL, NULL, NULL, NULL, NULL, NULL, '["biscuits et gaufrettes"]', '[]', NULL, NULL, 0.0, 'Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('6c20578e-ed74-428f-b766-f64b4e599a82', NULL, 'Groupe Chiali', NULL, NULL, NULL, NULL, NULL, NULL, '["tubes PVC pression", "tubes assainissement PEHD/PVC", "profilés PVC menuiserie"]', '[]', NULL, NULL, 0.0, 'Chiali Tubes + Chiali Profiplast. Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('2f265b61-965d-4d16-ae00-c9ac3d4598dd', NULL, 'GIPEC SPA', NULL, NULL, NULL, NULL, NULL, NULL, '["carton ondulé", "papier kraft"]', '[]', NULL, NULL, 0.0, 'Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('86c08787-7656-48ea-8b6e-75ee3ba7eeb7', NULL, 'Tonic Industrie', NULL, NULL, NULL, NULL, NULL, NULL, '["emballages alvéolés carton"]', '[]', NULL, NULL, 0.0, 'Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('3f61d7a6-c457-41bb-a0ab-e6744cb290f7', NULL, 'CABEL (Câblerie de l''Est)', NULL, NULL, NULL, NULL, NULL, NULL, '["câbles électriques industriels", "câbles anti-feu", "câbles coaxiaux et puissance"]', '[]', NULL, NULL, 0.0, 'Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('f84c3b49-d6b1-4fbf-8e1b-5d56fd26913d', NULL, 'ENAD (Entreprise Nationale des Peintures)', NULL, NULL, NULL, NULL, NULL, NULL, '["peintures acryliques bâtiment", "peintures anticorrosion"]', '[]', NULL, NULL, 0.0, 'Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('871f57bf-de5f-4d96-ae6b-a04baa89f9ea', NULL, 'Groupe Djurdjura', NULL, NULL, NULL, NULL, NULL, NULL, '["chaussures et bottes"]', '[]', NULL, NULL, 0.0, 'Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('1f23a881-93a4-490b-ab85-80f038a91cd2', NULL, 'ORITEX/ENACTEX', NULL, NULL, NULL, NULL, NULL, NULL, '["vêtements de travail"]', '[]', NULL, NULL, 0.0, 'Groupe textile public. Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('b6ad0ab6-3721-4d89-90b2-9f221f292905', NULL, 'Groupe GICA', NULL, NULL, NULL, NULL, NULL, NULL, '["ciment"]', '[]', NULL, NULL, 0.0, 'Groupe Industriel des Ciments d''Algérie. Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('22c4ab0e-7b8a-4017-8118-4ca6eb952c56', NULL, 'Tosyali/SIDER', NULL, NULL, NULL, NULL, NULL, NULL, '["acier - rond à béton"]', '[]', NULL, NULL, 0.0, 'Sidérurgie. Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('eb94fb3b-66f9-4153-8d9e-1d8dcafffba2', NULL, 'Al Waha International', NULL, NULL, NULL, NULL, NULL, NULL, '["détergents et lessives", "javel et désinfectants"]', '[]', NULL, NULL, 0.0, 'Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL),
	('d4d77147-535a-4858-be66-80cd389ca117', NULL, 'Laboratoires SAFEX', NULL, NULL, NULL, NULL, NULL, NULL, '["médicaments génériques", "parapharmacie - compléments et sirops"]', '[]', NULL, NULL, 0.0, 'Données fournies par l''utilisateur.', true, '2026-08-14 07:26:41.282323+00', '2026-08-14 07:26:41.282323+00', 'pending', NULL, NULL, NULL, 'active', NULL, NULL);


--
-- Data for Name: products_catalog; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."products_catalog" ("id", "supplier_id", "product_name", "category", "description", "unit", "price_dzd", "min_order_qty", "available_qty", "image_url", "active", "created_at", "updated_at", "status", "deleted_at") VALUES
	('37771c7a-6417-4abe-9dd3-0da873a0068c', '52ca1de2-4821-400c-bed7-636eb8f7a43b', 'Baghlia Huile d''Olive Extra Vierge 750ml', 'Huile d''olive', 'Huile d''olive extra vierge, conditionnement bouteille 750 ml, marque Baghlia (Béjaïa)', 'bouteille', 1450.00, 12.00, 500.00, NULL, true, '2026-08-12 19:58:06.349552+00', '2026-08-12 19:58:06.349552+00', 'published', NULL),
	('5d96fc48-c256-42f2-83f2-48fe9ab2278f', '6df6d1cd-5a84-4568-9deb-f05008db148a', 'Ifri Huile d''Olive 25cl', 'Huile d''olive', 'Huile d''olive conditionnement 25 cl, marque Ifri', 'bouteille', 295.00, 24.00, 800.00, NULL, true, '2026-08-12 19:58:06.349552+00', '2026-08-12 19:58:06.349552+00', 'published', NULL),
	('4461a3f4-79f6-457e-a1bd-2f25a79af24b', '7b87c62c-9d16-499c-8806-e31bea7a67bf', 'Ghezzal Dattes Deglet Nour 1kg', 'Dattes', 'Dattes Deglet Nour, conditionnement boîte/sachet 1 kg, marque Ghezzal', 'kg', 995.00, 10.00, 2000.00, NULL, true, '2026-08-12 19:58:06.349552+00', '2026-08-12 19:58:06.349552+00', 'published', NULL),
	('c5b5fd79-834e-456d-91fc-15742589e263', 'b7cd2b77-f5fd-4e0f-a8fd-cc571dd6127b', 'Amor Benamor Couscous Moyen 1kg', 'Couscous / Semoule', 'Couscous moyen de blé dur, conditionnement 1 kg, marque Amor Benamor (Guelma)', 'kg', 199.00, 20.00, 1500.00, NULL, true, '2026-08-12 19:58:06.349552+00', '2026-08-12 19:58:06.349552+00', 'published', NULL),
	('835d7b51-faac-4bf1-9a92-a69d16d1c5e5', '314aa6f7-2c65-4288-afd4-5e16e82b6c3a', 'Alelea Huile d''Olive 1L', 'Huile d''olive', 'Huile d''olive conditionnement bouteille 1 litre, marque Alelea', 'bouteille', 425.00, 12.00, 600.00, NULL, true, '2026-08-12 19:58:06.349552+00', '2026-08-12 19:58:06.349552+00', 'published', NULL),
	('b3a7f8ad-16d0-4372-9ae1-dc8573a0a876', 'fcdb95ca-899c-4c04-8cea-008d4e197c80', 'El-Horra Huile d''Olive 5L', 'Huile d''olive', 'Huile d''olive bidon 5 litres, marque El-Horra', 'bidon', 3980.00, 4.00, 200.00, NULL, true, '2026-08-12 19:58:06.349552+00', '2026-08-12 19:58:06.349552+00', 'published', NULL),
	('5ee46b72-7438-42a0-a010-841d3bc94a8c', 'fcdb95ca-899c-4c04-8cea-008d4e197c80', 'El-Hourra Huile d''Olive 1L', 'Huile d''olive', 'Huile d''olive bouteille 1 litre, marque El-Hourra', 'bouteille', 825.00, 12.00, 400.00, NULL, true, '2026-08-12 19:58:06.349552+00', '2026-08-12 19:58:06.349552+00', 'published', NULL),
	('a6b42e16-d586-445d-ac3c-c7d7bb4d1165', 'fcdb95ca-899c-4c04-8cea-008d4e197c80', 'Al-Hourra Huile d''Olive Pure 1L', 'Huile d''olive', 'Huile d''olive pure bouteille 1 litre, marque Al-Hourra', 'bouteille', 865.00, 12.00, 400.00, NULL, true, '2026-08-12 19:58:06.349552+00', '2026-08-12 19:58:06.349552+00', 'published', NULL),
	('6401cea1-2059-4496-a408-b440abb21310', '8e72fb5f-d844-49d0-be10-0bb6262adbb2', 'El Djaouda Huile d''Olive 50cl', 'Huile d''olive', 'Huile d''olive conditionnement 50 cl, marque El-Ghosn Lmobarak (El Djaouda)', 'bouteille', 295.00, 24.00, 600.00, NULL, true, '2026-08-12 19:58:06.349552+00', '2026-08-12 19:58:06.349552+00', 'published', NULL),
	('1ffec759-cfa5-4115-839e-6d2a183d6855', '8e72fb5f-d844-49d0-be10-0bb6262adbb2', 'El Djaouda Huile d''Olive 25cl', 'Huile d''olive', 'Huile d''olive conditionnement 25 cl, marque El-Ghosn Lmobarak (El Djaouda)', 'bouteille', 175.00, 24.00, 600.00, NULL, true, '2026-08-12 19:58:06.349552+00', '2026-08-12 19:58:06.349552+00', 'published', NULL),
	('4a5f9db9-dfc1-4477-bdce-706984e5304f', 'a98affeb-eb19-4399-bf06-e087da1d4b87', 'SOS Riz Blanc Long Grain 500g', 'Riz', 'Riz blanc long grain, conditionnement sachet 500 g, marque SOS', 'sachet', 120.00, 40.00, 3000.00, NULL, true, '2026-08-12 19:58:06.349552+00', '2026-08-12 19:58:06.349552+00', 'published', NULL),
	('930a1c6c-22fe-4911-ad53-caa36d464e37', '6df6d1cd-5a84-4568-9deb-f05008db148a', 'Ifri Pack Eau Minérale Naturelle Non Gazeuse (6x1,5L)', 'Boissons / Eaux', 'Fardeau de 6 bouteilles de 1,5 litre d''eau minérale naturelle non gazeuse, marque Ifri', 'fardeau', 220.00, 20.00, 1000.00, NULL, true, '2026-08-12 20:00:50.781318+00', '2026-08-12 20:00:50.781318+00', 'published', NULL),
	('fdea33db-9db7-45b7-a7c8-16436b517485', '6df6d1cd-5a84-4568-9deb-f05008db148a', 'Ifri Junior Pack Eau Minérale (12x0,33L)', 'Boissons / Eaux', 'Pack de 12 bouteilles de 33 cl d''eau minérale naturelle non gazeuse, format enfant, marque Ifri', 'pack', 280.00, 20.00, 800.00, NULL, true, '2026-08-12 20:00:50.781318+00', '2026-08-12 20:00:50.781318+00', 'published', NULL),
	('305e15b8-643f-44bd-9655-06b99c04bacc', '6df6d1cd-5a84-4568-9deb-f05008db148a', 'Ifri Ifruit Boisson au Jus Citronnade 1L', 'Boissons', 'Boisson au jus de citronnade, conditionnement bouteille 1 litre, marque Ifri', 'bouteille', 110.00, 24.00, 900.00, NULL, true, '2026-08-12 20:00:50.781318+00', '2026-08-12 20:00:50.781318+00', 'published', NULL),
	('d086001f-3961-4001-87d3-91f8f5ad24e9', '93826b4e-19c2-47e4-b652-a06456320da1', 'Azul Huile de Pépins de Figue de Barbarie (Rituel anti-âge)', 'Cosmétique naturel', 'Huile de pépins de figue de barbarie, soin anti-âge, marque Azul Cosmétique (Algérie)', 'flacon', 3900.00, 6.00, 150.00, NULL, true, '2026-08-12 20:00:50.781318+00', '2026-08-12 20:00:50.781318+00', 'published', NULL),
	('d4ae5947-95b8-4975-8b7e-bef02632de91', '93826b4e-19c2-47e4-b652-a06456320da1', 'Azul Trio Rituel Antiâge', 'Cosmétique naturel', 'Pack de 3 produits (huile démaquillante, savon, huile de pépins de figue de barbarie), marque Azul Cosmétique (Algérie)', 'pack', 7100.00, 4.00, 80.00, NULL, true, '2026-08-12 20:00:50.781318+00', '2026-08-12 20:00:50.781318+00', 'published', NULL),
	('bfa46f74-82ef-4b1c-897c-f6690ea1fb5e', '8fb9ac9a-f26c-4581-9221-a322f80a2353', 'Aigle Savon de Marseille Parfumé Douceur Glycérinée 250g', 'Entretien / Hygiène', 'Savon de Marseille glycériné parfumé, pain 250g, marque Aigle', 'pièce', 150.00, 48.00, 2000.00, NULL, true, '2026-08-12 20:00:50.781318+00', '2026-08-12 20:00:50.781318+00', 'published', NULL),
	('9a72c38f-48b2-4b09-85d6-54309491561c', '8fb9ac9a-f26c-4581-9221-a322f80a2353', 'Le Chat Savon de Marseille Propreté 2.5L', 'Entretien', 'Gel savon de Marseille pour lessive/entretien, bidon 2,5 litres, marque Le Chat', 'bidon', 895.00, 12.00, 400.00, NULL, true, '2026-08-12 20:00:50.781318+00', '2026-08-12 20:00:50.781318+00', 'published', NULL),
	('35b13502-7b78-4712-aab1-c45060028faf', '8fb9ac9a-f26c-4581-9221-a322f80a2353', 'Sido Savon de Marseille', 'Entretien / Hygiène', 'Savon de Marseille traditionnel, marque Sido', 'pièce', 95.00, 48.00, 2000.00, NULL, true, '2026-08-12 20:00:50.781318+00', '2026-08-12 20:00:50.781318+00', 'published', NULL),
	('38269dbf-df58-4e0a-a8a2-236887ccc360', '1d7fabfd-4d70-41e8-b37c-3ec6b298f9de', 'Ciment CEM (norme NA 442/2013) - sac 50kg', 'Matériaux de construction', 'Ciment conforme à la norme algérienne NA 442/2013, sac papier kraft 50 kg, GICA. Prix de détail indicatif Algérie (source marché 2025: 950-1100 DZD/sac)', 'sac 50kg', 1000.00, 100.00, 5000.00, NULL, true, '2026-08-12 20:00:50.781318+00', '2026-08-12 20:00:50.781318+00', 'published', NULL),
	('ecc3777f-cee3-4b21-a762-7645eb4fdeea', 'ca00849a-ce1e-4e34-b001-940f14984105', 'Rond à Béton TOSYALI 500 (acier B500B) - diamètres 8 à 32mm', 'Matériaux de construction', 'Acier pour béton armé, nuance B500B, norme NF A 35-080-1, barres 8 à 32 mm, Tosyali Algérie. Prix indicatif au quintal (source marché 2025: 10500-12500 DZD/quintal)', 'quintal (100kg)', 11500.00, 10.00, 5000.00, NULL, true, '2026-08-12 20:00:50.781318+00', '2026-08-12 20:00:50.781318+00', 'published', NULL),
	('8ff145d9-db97-48a9-ab83-d60ee23c83e1', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Climatiseur Condor Split 18000 BTU Super Tropical Inverter', 'Climatisation', 'Climatiseur split réversible, classe climatique tropicale T3, technologie Inverter, fonctionne de -15°C à +60°C, gaz R410A/R32 selon série', 'unité', 107000.00, 5.00, 100.00, NULL, true, '2026-08-12 20:03:47.467828+00', '2026-08-12 20:03:47.467828+00', 'published', NULL),
	('c65ce6d1-23f6-43c9-b0c4-85b691f07ee8', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Climatiseur Condor Alpha Inverter Super Tropical 9000 BTU', 'Climatisation', 'Climatiseur split réversible 9000 BTU, technologie Inverter, gaz R410A, fonctionnement -15°C à +60°C, Ultra Low Voltage', 'unité', 45000.00, 5.00, 100.00, NULL, true, '2026-08-12 20:03:47.467828+00', '2026-08-12 20:03:47.467828+00', 'published', NULL),
	('19e71452-020e-4c4b-b40f-08251810894a', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Téléviseur Condor 32SG600 32" HD LED Smart TV', 'Électronique / TV', 'Téléviseur LED 32 pouces HD, Smart TV, WiFi, Ethernet, Tuner Satellite et TNT intégrés', 'unité', 29000.00, 10.00, 300.00, NULL, true, '2026-08-12 20:03:47.467828+00', '2026-08-12 20:03:47.467828+00', 'published', NULL),
	('f01a76aa-b5fd-4450-afde-17dc15faa5a5', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Téléviseur Condor G6 Google TV 43"', 'Électronique / TV', 'Téléviseur 43 pouces, Google TV, réception DVB-T/T2/C, Dolby Digital Plus', 'unité', 54000.00, 10.00, 200.00, NULL, true, '2026-08-12 20:03:47.467828+00', '2026-08-12 20:03:47.467828+00', 'published', NULL),
	('7773ad88-800d-4eae-b276-ef183dcc602c', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Smartphone Condor Mate 70 (double écran)', 'Téléphonie', 'Premier smartphone algérien à double écran, caméra principale 100MP, caméra frontale 32MP, RAM 16 Go extensible +8 Go, Android 14', 'unité', 30500.00, 20.00, 500.00, NULL, true, '2026-08-12 20:03:47.467828+00', '2026-08-12 20:03:47.467828+00', 'published', NULL),
	('74fd0896-c826-434a-a940-b4bf21ceb256', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Smartphone Condor Griffe T9', 'Téléphonie', 'Smartphone entrée de gamme, écran IPS LCD 5,45", HD, processeur Octacore 1.6GHz', 'unité', 13300.00, 20.00, 500.00, NULL, true, '2026-08-12 20:03:47.467828+00', '2026-08-12 20:03:47.467828+00', 'published', NULL),
	('c6ace484-aa83-4cc1-a653-cc922f8e7132', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Machine à Laver Condor Luca Frontale 8kg', 'Électroménager', 'Lave-linge frontal 8kg, classe énergétique A+++, 14 programmes, technologie Add Garment et Hygiène Pro, cycle rapide 15min', 'unité', 49800.00, 5.00, 150.00, NULL, true, '2026-08-12 20:03:47.467828+00', '2026-08-12 20:03:47.467828+00', 'published', NULL),
	('825f9c1d-b5ac-4f9a-b5bb-80ddce932598', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Machine à Laver Condor NEO Inverter 10,5kg', 'Électroménager', 'Lave-linge frontal 10,5kg, moteur Inverter à courant continu, essorage 1400 tr/min, technologie tambour Pascal Cube', 'unité', 71990.00, 5.00, 150.00, NULL, true, '2026-08-12 20:03:47.467828+00', '2026-08-12 20:03:47.467828+00', 'published', NULL),
	('e4086d43-2272-4454-ba3b-43082ebd72f0', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Réfrigérateur Mono Porte CRF-T24GD14', 'Réfrigérateur', '176L, distributeur d''eau, R600a', 'unité', 25000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('772ad222-c8c4-4137-aed7-7e37a4b8f4ff', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Réfrigérateur Double Porte CRDN430', 'Réfrigérateur', '430L, No Frost, Double porte', 'unité', 55000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('f0dad506-622e-47dd-b1ae-856bf6b48f2b', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Réfrigérateur VITA Double Porte CRDN570ZX', 'Réfrigérateur', '443-498L, Defrost, Inox', 'unité', 79000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('76dde45f-eae1-4552-8111-ea08c87cdc09', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Réfrigérateur Cross Door CRM55NDX', 'Réfrigérateur', '424L, Inverter, No Frost, 4 portes', 'unité', 150000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('aada768e-8833-4e42-aa69-6fcd929d2017', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Réfrigérateur Side by Side 640L', 'Réfrigérateur', '640L, Inverter, Nofrost, Multi-portes', 'unité', 170000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('60503aa3-12ef-436a-8f29-b04bd27fccc6', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Réfrigérateur Rouge Premium CRF-T24GD14R', 'Réfrigérateur', '176L, Design rouge, distributeur', 'unité', 30000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('30abb3b4-1210-4ae2-9bdb-a5471f7d6dfe', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Congélateur Vertical CFH-T13GM03', 'Congélateur', '150L, 1 porte, 10 ans garantie compresseur', 'unité', 32000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('040c2130-0229-40ed-85d5-6ebbce36921f', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Congélateur Horizontal Bahut', 'Congélateur', '130L / 168L, bahut', 'unité', 35000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('a443ffc6-90c7-41a0-a7cf-fc031cac6e96', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Machine à Laver Frontal Luna X 12kg', 'Machine à laver', '12kg, Neo Inverter Titanium, Frontal', 'unité', 65000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('ce717a37-4196-47c2-ad35-e5e265bfe984', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Machine à Laver Frontal 6kg WAF-SB420LVT', 'Machine à laver', '6kg, BLDC Inverter, Titan Grey', 'unité', 35000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('39e225ff-c8cb-4c99-96df-3a59cc8036c0', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Machine à Laver Top LUCA 8kg', 'Machine à laver', '8kg, Ouverture par le haut, automatique (fourchette 36-37k DA)', 'unité', 36500.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('5bb7724a-5fc7-4ed6-b295-0dff78be4261', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Machine à Laver Top Infinity 10.5kg', 'Machine à laver', '10.5kg, 8 programmes, Top loading', 'unité', 45000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('da989f01-e377-46b8-b930-f41164d3c3de', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Machine à Laver Semi-auto TULIPE 10.5kg', 'Machine à laver', 'Double bac, semi-automatique', 'unité', 30000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('755bc6b5-21fb-47a1-ab64-c2798e5e26c9', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Climatiseur Split Alpha 9K BTU', 'Climatiseur', '9000 BTU, Inverter, Tropical T3', 'unité', 50000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('7ab29de9-14ae-4dd9-ba8a-fb7961fd99e1', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Climatiseur Split Alpha 12K BTU', 'Climatiseur', '12000 BTU, Inverter Smart, WiFi', 'unité', 67000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('0996c441-1083-4b51-8a4e-59d3113b58ef', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Climatiseur Split Alpha 18K BTU', 'Climatiseur', '18000 BTU, Inverter Super Tropical', 'unité', 85000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('c532ed06-cb02-4f00-9265-3d29140accf0', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Climatiseur Split Alpha 24K BTU', 'Climatiseur', '24000 BTU, Réversible, CS24-AL74T3', 'unité', 110000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('24fb1b6f-73ce-446f-ad53-3838fc1b6c99', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Climatiseur Split Alpha 36K BTU', 'Climatiseur', '36000 BTU, Inverter Smart, WiFi', 'unité', 140000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('cf0010db-bd3a-4040-9991-9dd5845ab5f4', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Climatiseur Armoire 50-60K BTU', 'Climatiseur', 'Armoire, grande capacité, Inverter — prix sur devis, non fixé publiquement', 'unité', 0.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('93a5333d-1da0-46ca-8699-79b6740bd7ef', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Climatiseur Portable CP35P5B', 'Climatiseur', '12000 BTU, 3 en 1, portable', 'unité', 65000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('cf856ba5-6857-405c-96fd-da0ab1d918b0', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Climatiseur Multisplit U-EXT 42K', 'Climatiseur', 'Multisplit, 42000 BTU, unité extérieure — prix sur devis, non fixé publiquement', 'unité', 0.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('da9a756a-dd6e-42fa-a182-fdf8391d89d2', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Chauffe-eau Gaz CCG-P406 6L', 'Chauffe-eau', '6L, Double ignition, Serpentin cuivre, Afficheur', 'unité', 18000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('e328c70c-682f-4233-933c-79d2661a3e8a', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Chauffe-eau Gaz 10L', 'Chauffe-eau', '10L, Mural, sécurité coupure gaz', 'unité', 22000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('1c0aa6cb-5957-4cd0-816c-8009327eaaf8', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Chauffage Bain d''huile 11 éléments', 'Chauffage', '2500W, 11 éléments, Noir/Blanc', 'unité', 14000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('a710801a-a4a4-4a5f-966f-e8e7c047c6c2', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Chauffage Radiateur Gaz Capsule 10-12KW', 'Chauffage', '10-12KW, Détecteur CO (fourchette 25900-28000 DA)', 'unité', 26950.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('46c1934f-ad04-4c78-8997-794d93d54298', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Table Cuisson RIGATI 1 4FX Inox', 'Table de cuisson', '4 feux gaz, Inox, auto-allumage', 'unité', 16000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('c98802c3-10cd-45d5-a767-536ec25b4f69', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Table Cuisson RIGATI 2 4FX Inox', 'Table de cuisson', '4 feux gaz, Inox', 'unité', 17000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('9e835423-5f0e-4f1f-bf80-e0a6706ae05f', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Table Cuisson TERRA 4FX Inox', 'Table de cuisson', '4 feux standards, Inox', 'unité', 18000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('923ac850-1d97-4f1d-b43d-f6f93b1edcbf', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Table Cuisson WOK ASTRA 4FX+Wok Inox', 'Table de cuisson', '3 feux + Wok, Fonte', 'unité', 22000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('c5f25b48-e08c-4183-9329-2f4b237d9321', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Table Cuisson ENCAS VANILLA VN3 4FX Black Glass', 'Table de cuisson', '4 feux, Verre noir, Fonte', 'unité', 28000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('ce47e9c2-122e-480d-94e6-e5ebf1ac694f', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Cuisinière Perfetta 4 feux', 'Cuisinière', '4 feux gaz, four, élégante', 'unité', 35000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('d3be1499-2e46-48d1-abb2-faa50d548988', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'Blender Master Mix', 'Petit électroménager', '5 vitesses, batteur à main', 'unité', 3500.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('6700d39d-054a-4870-9ab8-e382c932b9f7', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'TV LED Série T4 32LD410', 'Téléviseur', '32" HD, LED, TNT, HDMI', 'unité', 25000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('1f985f05-6f18-4955-81f2-d3913fc030d2', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'TV QLED Série D5 LD530', 'Téléviseur', '40-43" FHD, QLED', 'unité', 35000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('4ea0bb24-75e1-40ec-8620-0523de6c794a', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'TV Google TV 43"', 'Téléviseur', '43" Smart Google TV', 'unité', 37000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('6b6a7bd6-ed9a-4f22-97ff-266c454fdf52', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'TV Série X9 65"', 'Téléviseur', '65" 4K UHD, Google TV, 144Hz VRR', 'unité', 130000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('0bf0b2bd-cbf8-4ba7-8472-a3f0092ce7c9', '8e9dd2c8-2457-47f6-811c-98672f223eeb', 'TV Série X9 QD-Mini LED 75"', 'Téléviseur', '75" 4K QD-Mini LED, Google TV, 144Hz', 'unité', 180000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('08ecb960-367d-4ced-ac72-48b7f7f3c558', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Réfrigérateur Mono Porte CRF-T24GD14', 'Réfrigérateur', '176L, distributeur d''eau, R600a', 'unité', 25000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('7341c116-24dc-4e4c-914f-26ec316c471a', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Réfrigérateur Double Porte CRDN430', 'Réfrigérateur', '430L, No Frost, Double porte', 'unité', 55000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('c15b0bb2-498b-4bf7-9cce-db3448ac14c5', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Réfrigérateur VITA Double Porte CRDN570ZX', 'Réfrigérateur', '443-498L, Defrost, Inox', 'unité', 79000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('8f0d79cc-c084-4d68-8d63-dfaa5db82279', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Réfrigérateur Cross Door CRM55NDX', 'Réfrigérateur', '424L, Inverter, No Frost, 4 portes', 'unité', 150000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('3879db3a-2e19-4c4c-b52d-f565a8e9d524', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Réfrigérateur Side by Side 640L', 'Réfrigérateur', '640L, Inverter, Nofrost, Multi-portes', 'unité', 170000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('16f4ebec-ee99-420b-90ad-35fdcb07a94f', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Réfrigérateur Rouge Premium CRF-T24GD14R', 'Réfrigérateur', '176L, Design rouge, distributeur', 'unité', 30000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('e0af4d40-92de-4265-bb9a-2b5236d0c1b7', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Congélateur Vertical CFH-T13GM03', 'Congélateur', '150L, 1 porte, 10 ans garantie compresseur', 'unité', 32000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('fdf8264d-b1ed-4280-9b27-7b48b25ebebd', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Congélateur Horizontal Bahut', 'Congélateur', '130L / 168L, bahut', 'unité', 35000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('2408af6d-68fb-4d18-aabe-1c22c36f4147', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Machine à Laver Frontal Luna X 12kg', 'Machine à laver', '12kg, Neo Inverter Titanium, Frontal', 'unité', 65000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('2eb2b1dc-0ae5-4f4e-a570-e4b1671525b4', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Machine à Laver Frontal 6kg WAF-SB420LVT', 'Machine à laver', '6kg, BLDC Inverter, Titan Grey', 'unité', 35000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('b08c470b-bd2a-44b8-bdc1-30d5026c8739', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Machine à Laver Top LUCA 8kg', 'Machine à laver', '8kg, Ouverture par le haut, automatique (fourchette 36-37k DA)', 'unité', 36500.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('45524b4e-ef89-4550-9bcf-7694938527a6', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Machine à Laver Top Infinity 10.5kg', 'Machine à laver', '10.5kg, 8 programmes, Top loading', 'unité', 45000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('5e37c6a4-324c-4edc-aa1a-cceb35c0d775', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Machine à Laver Semi-auto TULIPE 10.5kg', 'Machine à laver', 'Double bac, semi-automatique', 'unité', 30000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('663f0ce6-188d-46f1-b4ad-125cd387da09', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Climatiseur Split Alpha 9K BTU', 'Climatiseur', '9000 BTU, Inverter, Tropical T3', 'unité', 50000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('e117bac1-31cf-4760-bb4b-df5ac995002f', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Climatiseur Split Alpha 12K BTU', 'Climatiseur', '12000 BTU, Inverter Smart, WiFi', 'unité', 67000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('2329d646-1f2b-469a-b8a9-df50e051e9ef', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Climatiseur Split Alpha 18K BTU', 'Climatiseur', '18000 BTU, Inverter Super Tropical', 'unité', 85000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('fbb75351-5f26-4095-88e8-d40c4ad30afb', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Climatiseur Split Alpha 24K BTU', 'Climatiseur', '24000 BTU, Réversible, CS24-AL74T3', 'unité', 110000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('a2e3a259-1156-4951-8882-98bb5074061e', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Climatiseur Split Alpha 36K BTU', 'Climatiseur', '36000 BTU, Inverter Smart, WiFi', 'unité', 140000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('104a81d7-47f1-433e-a8f9-fba05ce1e01c', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Climatiseur Armoire 50-60K BTU', 'Climatiseur', 'Armoire, grande capacité, Inverter — prix sur devis, non fixé publiquement', 'unité', 0.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('473a9b50-c929-41cd-a5cc-084c4ffd0e4b', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Climatiseur Portable CP35P5B', 'Climatiseur', '12000 BTU, 3 en 1, portable', 'unité', 65000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('c4de13be-4443-46a5-b278-b0085ee2e018', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Climatiseur Multisplit U-EXT 42K', 'Climatiseur', 'Multisplit, 42000 BTU, unité extérieure — prix sur devis, non fixé publiquement', 'unité', 0.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('2579c91b-46f1-4a41-9428-14123cc08cd3', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Chauffe-eau Gaz CCG-P406 6L', 'Chauffe-eau', '6L, Double ignition, Serpentin cuivre, Afficheur', 'unité', 18000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('1bc6021f-1392-4591-aeb0-753a70911a00', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Chauffe-eau Gaz 10L', 'Chauffe-eau', '10L, Mural, sécurité coupure gaz', 'unité', 22000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('8ae03733-2338-48ea-8ccf-3774b2a77b4f', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Chauffage Bain d''huile 11 éléments', 'Chauffage', '2500W, 11 éléments, Noir/Blanc', 'unité', 14000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('92ecfa9e-61d6-4d2d-a763-3621a59d7f5d', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Chauffage Radiateur Gaz Capsule 10-12KW', 'Chauffage', '10-12KW, Détecteur CO (fourchette 25900-28000 DA)', 'unité', 26950.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('0eb4601e-8aca-4e28-8d58-a0a38243e165', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Table Cuisson RIGATI 1 4FX Inox', 'Table de cuisson', '4 feux gaz, Inox, auto-allumage', 'unité', 16000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('321e906c-1253-4749-9b52-2eb8518989a0', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Table Cuisson RIGATI 2 4FX Inox', 'Table de cuisson', '4 feux gaz, Inox', 'unité', 17000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('568a15aa-f2b0-473f-9b6e-780e963c6929', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Table Cuisson TERRA 4FX Inox', 'Table de cuisson', '4 feux standards, Inox', 'unité', 18000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('9a11f586-474d-4e31-ac70-a5fb87f569be', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Table Cuisson WOK ASTRA 4FX+Wok Inox', 'Table de cuisson', '3 feux + Wok, Fonte', 'unité', 22000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('0e4b871b-0eb6-45f6-8a06-0915a0e6f7ef', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Table Cuisson ENCAS VANILLA VN3 4FX Black Glass', 'Table de cuisson', '4 feux, Verre noir, Fonte', 'unité', 28000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('cfb2ff46-c15a-4e60-b274-4ac0666cc446', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Cuisinière Perfetta 4 feux', 'Cuisinière', '4 feux gaz, four, élégante', 'unité', 35000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('d6d40e75-0a66-4011-8f7d-fcaaf1e1d3f4', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'Blender Master Mix', 'Petit électroménager', '5 vitesses, batteur à main', 'unité', 3500.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('d9e0710c-667e-48af-bcbc-8d186dfb86a3', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'TV LED Série T4 32LD410', 'Téléviseur', '32" HD, LED, TNT, HDMI', 'unité', 25000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('3784a97d-4e60-4e2b-9ecf-cfb88b0c7a91', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'TV QLED Série D5 LD530', 'Téléviseur', '40-43" FHD, QLED', 'unité', 35000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('c653a252-a6da-4ee1-b834-78f758048fe3', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'TV Google TV 43"', 'Téléviseur', '43" Smart Google TV', 'unité', 37000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('c1ff0c95-364a-43ae-8258-f3322e557fd3', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'TV Série X9 65"', 'Téléviseur', '65" 4K UHD, Google TV, 144Hz VRR', 'unité', 130000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('268fba15-af5d-42ee-b856-12b4438b7319', '31d6ebc5-25a6-4c40-91b3-36351b357118', 'TV Série X9 QD-Mini LED 75"', 'Téléviseur', '75" 4K QD-Mini LED, Google TV, 144Hz', 'unité', 180000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('990214fb-e1ad-4fbf-9796-213f3e37e391', '513b2d06-cd9d-4620-bee6-eb09c3184daa', 'Réfrigérateur Combiné 350S', 'Réfrigérateur', '350L, Double porte', 'unité', 60000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('bf3e6260-65b6-4e53-8c62-8ce387bb6eaa', '513b2d06-cd9d-4620-bee6-eb09c3184daa', 'Réfrigérateur 320L E S025', 'Réfrigérateur', '320L, combiné, poignée', 'unité', 66470.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('f76e674f-9870-4880-8c8c-0d16cf2317f6', '513b2d06-cd9d-4620-bee6-eb09c3184daa', 'Réfrigérateur 160L Mini', 'Réfrigérateur', '160L, Petit format', 'unité', 35000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('3e9a2038-61ec-4492-95e6-b9e1378d8072', '513b2d06-cd9d-4620-bee6-eb09c3184daa', 'Congélateur Vertical 7 tiroirs', 'Congélateur', 'Vertical, 7 tiroirs', 'unité', 45000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('d59baa62-abb6-494f-bb64-184a374ed2c5', '513b2d06-cd9d-4620-bee6-eb09c3184daa', 'Congélateur Horizontal 480L', 'Congélateur', 'Bahut, 480L', 'unité', 50000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('f01b9eee-8c07-489f-84a5-b27abe703f00', '513b2d06-cd9d-4620-bee6-eb09c3184daa', 'Cuisinière 6120 Luxe 4 feux', 'Cuisinière', '4 feux gaz, four', 'unité', 25500.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('d5ba3c75-5747-45f4-8ba5-51541b69904c', '513b2d06-cd9d-4620-bee6-eb09c3184daa', 'Machine à Laver Automatique 7-8kg', 'Machine à laver', 'Automatique, top/frontal', 'unité', 40000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('d193a70c-365e-4946-959c-1030e942ffbf', '513b2d06-cd9d-4620-bee6-eb09c3184daa', 'Chauffe-eau Gaz/Électrique', 'Chauffe-eau', 'Chauffe-eau gaz et électrique, plusieurs modèles', 'unité', 15000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('90b3f244-d1a3-47ab-8701-60287ec1ed89', '57436714-b13b-41fe-a2ae-8e41129352b6', 'Réfrigérateur Cross Door 432L', 'Réfrigérateur', '432L, No Frost, Cross Door', 'unité', 120000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('86b3f3e8-81b0-4f2b-aded-bd82eea7e4fb', '57436714-b13b-41fe-a2ae-8e41129352b6', 'Smartphone BPRIME 64Go', 'Smartphone', 'Noir/gris ou argenté, robuste', 'unité', 17200.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('4fea2f3c-13af-4c15-8dc3-1ef720ccdf72', '57436714-b13b-41fe-a2ae-8e41129352b6', 'Smartphone BSTAR+ 5.45" HD+', 'Smartphone', 'Écran HD+ 5.45 pouces', 'unité', 15000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('f3ac29df-7371-4a1c-8ca9-ad3aab136670', '57436714-b13b-41fe-a2ae-8e41129352b6', 'Smartphone B-One', 'Smartphone', 'Entrée de gamme', 'unité', 14600.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('2f191bf2-13d3-4c0f-886e-2d1096ec6904', 'a3769bc6-94e6-41a4-ab58-9e96d6b90746', 'TV G4010 32" Smart', 'Téléviseur', '32" FHD Smart TV LED', 'unité', 28000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('90be7bad-9a51-4972-aeb6-e5a9de9f1792', 'a3769bc6-94e6-41a4-ab58-9e96d6b90746', 'TV G4030 40" Google TV', 'Téléviseur', '40" FHD, Google TV, Android', 'unité', 35900.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('f5f8c338-01a7-4662-81c4-b642f7fc35f2', 'a3769bc6-94e6-41a4-ab58-9e96d6b90746', 'TV Q5020 50" Google TV', 'Téléviseur', '50" FHD, QLED+, Google TV', 'unité', 55000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('3c337902-299f-44b4-a238-04e2f6961a70', 'a3769bc6-94e6-41a4-ab58-9e96d6b90746', 'TV Q4030 43" Google TV', 'Téléviseur', '43" FHD, QLED, Android 14', 'unité', 46900.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('6aa6a0b8-6342-4971-8aae-726821d73ce9', 'a3769bc6-94e6-41a4-ab58-9e96d6b90746', 'TV G5010 55" UHD Google', 'Téléviseur', '55" UHD, Google TV', 'unité', 85000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('964bdefe-7f81-4217-aa96-e5dae4a9e6f4', 'a3769bc6-94e6-41a4-ab58-9e96d6b90746', 'TV Q7010 55" QLED', 'Téléviseur', '55" QLED, UHD, Google TV', 'unité', 102300.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('f37bb75e-11d0-45be-bfb9-a41d4d2bb577', 'a3769bc6-94e6-41a4-ab58-9e96d6b90746', 'Smartphone Alpha Plus', 'Smartphone', 'Milieu de gamme', 'unité', 18800.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('72b9af74-2e56-4bed-a03c-f16287e76c00', 'a3769bc6-94e6-41a4-ab58-9e96d6b90746', 'Smartphone N30', 'Smartphone', 'Haut de gamme — prix variable selon configuration, non fixé publiquement', 'unité', 0.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('e9d5aeb2-edfb-4c92-b47c-b5dfbc8bf470', '7205e36f-3568-4896-9493-33d583bfddc6', 'Machine à Laver Frontal 10kg Inverter', 'Machine à laver', '10kg, Inverter, Frontal (fourchette 55000-73000 DA)', 'unité', 64000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('5547bc6c-9feb-481a-81a2-0af139f2ed3c', '7205e36f-3568-4896-9493-33d583bfddc6', 'Réfrigérateur 345L Blanc', 'Réfrigérateur', '345L, Blanc, garantie 24 mois', 'unité', 52000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('2c0e72c6-e72c-40d6-afdf-6022466f68d8', '7205e36f-3568-4896-9493-33d583bfddc6', 'Réfrigérateur Mini Bar RMBD-160', 'Réfrigérateur', '160L, Mini bar', 'unité', 30000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('79a60bba-be56-4580-88e0-3cd38433b686', '7205e36f-3568-4896-9493-33d583bfddc6', 'Réfrigérateur Side by Side 440L Glass', 'Réfrigérateur', '440L, 4 portes, Glass Blanc', 'unité', 230000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('2fef3270-3fd5-4254-84db-b6c08645ba1d', '7205e36f-3568-4896-9493-33d583bfddc6', 'Réfrigérateur 660L Inox No Frost', 'Réfrigérateur', '660L, Inox, Afficheur, No Frost', 'unité', 180000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('f3a2a545-475f-49a5-9224-0b582659faf9', '7205e36f-3568-4896-9493-33d583bfddc6', 'Micro-ondes 25L Blanc', 'Micro-ondes', '25L, Blanc', 'unité', 27000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('222d9313-7e7c-452a-b019-faa478ca6e8c', 'eb06057c-0b07-40ee-a3e4-7b08268d1116', 'TV Smart Android 42" TG8A11', 'Téléviseur', '42" FHD, Smart Android', 'unité', 26000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('37f777ec-4604-42a4-a309-ef0c82e1c039', 'eb06057c-0b07-40ee-a3e4-7b08268d1116', 'TV QLED Pro 65" 144Hz', 'Téléviseur', '65" QLED, Google TV, 144Hz', 'unité', 141000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('878139ba-1647-4447-91cb-464c97fb737f', 'eb06057c-0b07-40ee-a3e4-7b08268d1116', 'Table Cuisson Omega 4F Inox', 'Table de cuisson', '4 feux, Inox, encastrable', 'unité', 18000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL),
	('d6b01556-5eab-4a8b-a1ef-879cf1090046', '3b75c2e5-d6fc-45d4-8a28-61d068ca28d9', 'Climatiseur IGLOO Inverter 12-18K BTU', 'Climatiseur', 'Inverter T3 Tropical, Froid/Chaud, R410 (fourchette 55000-85000 DA)', 'unité', 70000.00, NULL, NULL, NULL, true, '2026-08-14 07:27:19.674113+00', '2026-08-14 07:27:19.674113+00', 'published', NULL);


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
-- Data for Name: shipments; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: vehicles; Type: TABLE DATA; Schema: public; Owner: postgres
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

-- \unrestrict e6cEgDTx0vEC0TYitT0KGSXWtF9anOLAhbteS9nGNX8J8IiYhofOrWQmbMKfoxf

RESET ALL;
