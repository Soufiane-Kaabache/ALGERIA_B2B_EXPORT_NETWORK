import { SupabaseClient } from '@supabase/supabase-js';
import { cache } from 'react';
import type { Database } from '@/types_db';

type SupabasePublicClient = SupabaseClient<Database>;

export const getUser = cache(async (supabase: SupabasePublicClient) => {
  const {
    data: { user }
  } = await supabase.auth.getUser();
  return user;
});

export const getSubscription = cache(async (supabase: SupabasePublicClient) => {
  const { data: subscription, error } = await supabase
    .from('subscriptions')
    .select('*')
    .eq('status', 'active')
    .maybeSingle();

  return subscription;
});

export const getUserDetails = cache(async (supabase: SupabasePublicClient) => {
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) return null;
  const meta = user.user_metadata || {};
  const full = [meta.first_name, meta.last_name].filter(Boolean).join(' ').trim();
  return { full_name: full || user.email || '' };
});
