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
  const { data: profile } = await supabase
    .from('user_profiles')
    .select('first_name, last_name')
    .maybeSingle();

  if (!profile) {
    return null;
  }

  return {
    full_name: `${profile.first_name} ${profile.last_name}`.trim()
  };
});