-- Une seule ligne par paire de devises et par jour (permet l'upsert propre)
alter table public.exchange_rates
  add constraint exchange_rates_unique_daily
  unique (currency_from, currency_to, rate_date);

-- Index pour que tes dashboards/requêtes historiques soient rapides
create index if not exists idx_exchange_rates_pair_date
  on public.exchange_rates (currency_from, currency_to, rate_date desc);

-- Extensions nécessaires pour déclencher l'Edge Function automatiquement chaque jour
create extension if not exists pg_cron with schema extensions;
create extension if not exists pg_net with schema extensions;

-- Planifie l'appel quotidien à 17h UTC (après la publication BCE ~16h CET)
select cron.schedule(
  'sync-exchange-rates-daily',
  '0 17 * * *',
  $$
  select net.http_post(
    url := 'https://oixmzaqqfybdynqmjeaa.supabase.co/functions/v1/sync-exchange-rates',
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'x-cron-secret', current_setting('app.settings.cron_secret', true)
    ),
    body := '{}'::jsonb
  );
  $$
);