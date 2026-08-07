import { createClient } from '@/utils/supabase/server';
import { getUser } from '@/utils/supabase/queries';

export default async function HomePage() {
  const supabase = createClient();
  const user = await getUser(supabase);

  return (
    <section className="mx-auto max-w-6xl px-4 py-16 sm:px-6 lg:px-8">
      <h1 className="text-4xl font-extrabold sm:text-5xl">
        Algeria B2B Export Network
      </h1>
      <p className="mt-4 max-w-2xl text-lg text-zinc-300">
        Plateforme B2B mettant en relation fournisseurs algériens,
        transporteurs, transitaires, grossistes et commerçants en France.
      </p>
      {!user && (
        <p className="mt-8 text-sm text-zinc-400">
          Connectez-vous pour accéder à votre espace fournisseur.
        </p>
      )}
    </section>
  );
}