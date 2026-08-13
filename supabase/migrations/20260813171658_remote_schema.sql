create extension if not exists "pg_net" with schema "extensions";

drop policy "profiles_insert" on "public"."buyers_eu";

drop policy "profiles_select" on "public"."buyers_eu";

drop policy "profiles_update" on "public"."buyers_eu";

drop policy "profiles_insert" on "public"."carriers_dz";

drop policy "profiles_select" on "public"."carriers_dz";

drop policy "profiles_update" on "public"."carriers_dz";

drop policy "profiles_insert" on "public"."carriers_eu";

drop policy "profiles_select" on "public"."carriers_eu";

drop policy "profiles_update" on "public"."carriers_eu";

drop policy "profiles_insert" on "public"."freight_forwarders";

drop policy "profiles_select" on "public"."freight_forwarders";

drop policy "profiles_update" on "public"."freight_forwarders";

drop policy "kyc_insert" on "public"."kyc_documents";

drop policy "kyc_select" on "public"."kyc_documents";

drop policy "kyc_select_officer" on "public"."kyc_documents";

drop policy "kyc_update" on "public"."kyc_documents";

drop policy "kyc_update_officer" on "public"."kyc_documents";

drop policy "items_manage" on "public"."order_items";

drop policy "subscriptions_admin_write" on "public"."subscriptions";

drop policy "profiles_insert" on "public"."suppliers";

drop policy "profiles_select" on "public"."suppliers";

drop policy "profiles_update" on "public"."suppliers";

drop policy "transactions_admin_write" on "public"."transactions";

drop policy "vehicles_select_logistics" on "public"."vehicles";

drop policy "vehicles_update_logistics" on "public"."vehicles";

drop policy "wilayas_select_all" on "public"."wilayas";

CREATE UNIQUE INDEX exchange_rates_unique_daily ON public.exchange_rates USING btree (currency_from, currency_to, rate_date);

alter table "public"."exchange_rates" add constraint "exchange_rates_unique_daily" UNIQUE using index "exchange_rates_unique_daily";


  create policy "part_insert"
  on "public"."conversation_participants"
  as permissive
  for insert
  to public
with check ((public.is_admin() OR (conversation_id IN ( SELECT conversations.id
   FROM public.conversations
  WHERE ((conversations.order_id IN ( SELECT orders.id
           FROM public.orders
          WHERE (orders.buyer_id IN ( SELECT buyers_eu.id
                   FROM public.buyers_eu
                  WHERE (buyers_eu.user_id = auth.uid()))))) OR (conversations.order_id IN ( SELECT order_items.order_id
           FROM public.order_items
          WHERE (order_items.supplier_id IN ( SELECT suppliers.id
                   FROM public.suppliers
                  WHERE (suppliers.user_id = auth.uid()))))))))));



  create policy "part_select"
  on "public"."conversation_participants"
  as permissive
  for select
  to public
using ((public.is_admin() OR (user_id = auth.uid())));



  create policy "conv_insert"
  on "public"."conversations"
  as permissive
  for insert
  to public
with check ((public.is_admin() OR (order_id IN ( SELECT orders.id
   FROM public.orders
  WHERE (orders.buyer_id IN ( SELECT buyers_eu.id
           FROM public.buyers_eu
          WHERE (buyers_eu.user_id = auth.uid()))))) OR (order_id IN ( SELECT order_items.order_id
   FROM public.order_items
  WHERE (order_items.supplier_id IN ( SELECT suppliers.id
           FROM public.suppliers
          WHERE (suppliers.user_id = auth.uid())))))));



  create policy "conv_select"
  on "public"."conversations"
  as permissive
  for select
  to public
using ((public.is_admin() OR (id IN ( SELECT conversation_participants.conversation_id
   FROM public.conversation_participants
  WHERE (conversation_participants.user_id = auth.uid())))));



  create policy "rates_public_read"
  on "public"."exchange_rates"
  as permissive
  for select
  to public
using (true);



  create policy "notifications_insert"
  on "public"."notifications"
  as permissive
  for insert
  to public
with check (false);



  create policy "notifications_select"
  on "public"."notifications"
  as permissive
  for select
  to public
using ((user_id = auth.uid()));



  create policy "notifications_update"
  on "public"."notifications"
  as permissive
  for update
  to public
using ((user_id = auth.uid()));



  create policy "items_select"
  on "public"."order_items"
  as permissive
  for select
  to public
using ((public.is_admin() OR (order_id IN ( SELECT orders.id
   FROM public.orders
  WHERE (orders.buyer_id IN ( SELECT buyers_eu.id
           FROM public.buyers_eu
          WHERE (buyers_eu.user_id = auth.uid()))))) OR (supplier_id IN ( SELECT suppliers.id
   FROM public.suppliers
  WHERE (suppliers.user_id = auth.uid())))));



  create policy "orders_delete"
  on "public"."orders"
  as permissive
  for delete
  to public
using (public.is_admin());



  create policy "qr_delete"
  on "public"."quote_requests"
  as permissive
  for delete
  to public
using (public.is_admin());



  create policy "qr_insert"
  on "public"."quote_requests"
  as permissive
  for insert
  to public
with check ((public.is_admin() OR (order_id IN ( SELECT orders.id
   FROM public.orders
  WHERE (orders.buyer_id IN ( SELECT buyers_eu.id
           FROM public.buyers_eu
          WHERE (buyers_eu.user_id = auth.uid())))))));



  create policy "qr_select"
  on "public"."quote_requests"
  as permissive
  for select
  to public
using ((public.is_admin() OR (order_id IN ( SELECT orders.id
   FROM public.orders
  WHERE (orders.buyer_id IN ( SELECT buyers_eu.id
           FROM public.buyers_eu
          WHERE (buyers_eu.user_id = auth.uid()))))) OR (supplier_id IN ( SELECT suppliers.id
   FROM public.suppliers
  WHERE (suppliers.user_id = auth.uid()))) OR ((status)::text = 'open'::text)));



  create policy "quotes_delete"
  on "public"."quotes"
  as permissive
  for delete
  to public
using (((public.is_current_user_actor((provider_type)::text, provider_id) AND ((status)::text = 'pending'::text)) OR public.is_admin()));



  create policy "wilayas_public_read"
  on "public"."wilayas"
  as permissive
  for select
  to public
using (true);



