import Link from 'next/link';
import type { Metadata } from 'next';
import { createClient } from '@/utils/supabase/server';
import { getUser } from '@/utils/supabase/queries';
import { Button } from '@/components/ui/button';
import {
  Filter,
  MapPin,
  PackageSearch,
  RefreshCw,
  Star,
} from 'lucide-react';

export const metadata: Metadata = {
  title: 'Catalogue Export | Algeria B2B Export Network',
  description:
    'Découvrez les produits exportables proposés par des fournisseurs algériens vérifiés : agroalimentaire, matériaux, industrie, chimie et plus.',
};

type CatalogueSearchParams = {
  q?: string;
  category?: string;
};

type CatalogueProduct = {
  product_id: string;
  product_name: string;
  category: string | null;
  description: string | null;
  unit: string;
  price_dzd: number;
  min_order_qty: number | null;
  available_qty: number | null;
  image_url: string | null;
  created_at: string;
  supplier_id: string;
  supplier_company_name: string;
  supplier_rating_avg: number | null;
  supplier_city: string | null;
  supplier_wilaya: string | null;
};

type CategoryRow = {
  category: string;
};

const formatDzd = (value: number) => {
  return `${new Intl.NumberFormat('fr-FR', {
    maximumFractionDigits: 0,
  }).format(value)} DZD`;
};

const formatEur = (value: number) => {
  return new Intl.NumberFormat('fr-FR', {
    style: 'currency',
    currency: 'EUR',
    maximumFractionDigits: 0,
  }).format(value);
};

const getStockLabel = (product: CatalogueProduct) => {
  if (product.available_qty === null) {
    return 'Stock disponible sur demande';
  }

  if (product.available_qty <= 0) {
    return 'Stock momentanément épuisé';
  }

  return `${new Intl.NumberFormat('fr-FR').format(
    product.available_qty
  )} ${product.unit} disponibles`;
};

export default async function CataloguePage({
  searchParams,
}: {
  searchParams?: CatalogueSearchParams | Promise<CatalogueSearchParams>;
}) {
  const resolvedSearchParams = await Promise.resolve(searchParams ?? {});

  const q =
    typeof resolvedSearchParams.q === 'string'
      ? resolvedSearchParams.q.trim()
      : '';

  const category =
    typeof resolvedSearchParams.category === 'string'
      ? resolvedSearchParams.category.trim()
      : '';

  const supabase = createClient();
  const user = await getUser(supabase);

  const [productsResponse, categoriesResponse, rateResponse] =
    await Promise.all([
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      supabase.rpc('get_public_catalogue_products' as any, {
        search_text: q || null,
        category_filter: category || null,
        limit_count: 48,
      }),
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      supabase.rpc('get_public_catalogue_categories' as any),
      supabase
        .from('exchange_rates')
        .select('rate')
        .eq('currency_from', 'EUR')
        .eq('currency_to', 'DZD')
        .order('rate_date', { ascending: false })
        .limit(1)
        .maybeSingle(),
    ]);

  const products =
    (productsResponse.data ?? []) as unknown as CatalogueProduct[];

  const categories =
    (categoriesResponse.data ?? []) as unknown as CategoryRow[];

  const rateValue = (rateResponse.data as { rate?: number } | null)?.rate;
  const eurToDzdRate = rateValue ? Number(rateValue) : null;

  const hasFilters = Boolean(q || category);

  const categoryOptions = categories.map((item) => item.category);

  if (category && !categoryOptions.includes(category)) {
    categoryOptions.unshift(category);
  }

  return (
    <div className="min-h-screen bg-black text-white">
      <div className="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
        {/* Header catalogue */}
        <div className="flex flex-col gap-6 lg:flex-row lg:items-end lg:justify-between">
          <div>
            <span className="inline-flex items-center rounded-full bg-emerald-500/10 px-3 py-1 text-sm font-medium text-emerald-400 ring-1 ring-inset ring-emerald-500/20">
              Catalogue Export
            </span>

            <h1 className="mt-4 max-w-3xl text-3xl font-extrabold tracking-tight sm:text-5xl">
              Produits algériens disponibles à l&apos;export
            </h1>

            <p className="mt-4 max-w-2xl text-base leading-relaxed text-zinc-400">
              Parcourez les produits proposés par des fournisseurs algériens
              vérifiés. Demandez une cotation, comparez les offres et organisez
              l&apos;expédition avec nos partenaires logistiques.
            </p>
          </div>

          <div className="flex flex-wrap items-center gap-3">
            {user ? (
              <Button asChild variant="outline" size="lg">
                <Link href="/account">Accéder à mon espace</Link>
              </Button>
            ) : (
              <>
                <Button asChild variant="outline" size="lg">
                  <Link href="/auth/login">Connexion</Link>
                </Button>

                <Button
                  asChild
                  size="lg"
                  className="bg-emerald-600 hover:bg-emerald-500"
                >
                  <Link href="/auth/signup">Devenir fournisseur</Link>
                </Button>
              </>
            )}
          </div>
        </div>

        {/* Filtres */}
        <form
          method="GET"
          className="mt-10 grid gap-4 rounded-2xl border border-zinc-800 bg-zinc-950/60 p-4 md:grid-cols-[minmax(0,1fr)_240px_auto_auto] md:items-center"
        >
          <input
            type="search"
            name="q"
            defaultValue={q}
            placeholder="Rechercher un produit : dattes, ciment, huile d'olive, pièces industrielles..."
            className="h-11 w-full rounded-lg border border-zinc-800 bg-black px-4 text-sm text-white placeholder:text-zinc-600 focus:border-emerald-600 focus:outline-none focus:ring-1 focus:ring-emerald-600"
          />

          <select
            name="category"
            defaultValue={category}
            className="h-11 w-full rounded-lg border border-zinc-800 bg-black px-4 text-sm text-white focus:border-emerald-600 focus:outline-none focus:ring-1 focus:ring-emerald-600"
          >
            <option value="">Toutes les catégories</option>

            {categoryOptions.map((option) => (
              <option key={option} value={option}>
                {option}
              </option>
            ))}
          </select>

          <Button
            type="submit"
            size="lg"
            className="bg-emerald-600 hover:bg-emerald-500"
          >
            <Filter className="mr-2 h-4 w-4" />
            Filtrer
          </Button>

          {hasFilters ? (
            <Button asChild variant="outline" size="lg">
              <Link href="/catalogue">
                <RefreshCw className="mr-2 h-4 w-4" />
                Réinitialiser
              </Link>
            </Button>
          ) : null}
        </form>

        {/* Erreur chargement */}
        {productsResponse.error ? (
          <div className="mt-10 rounded-2xl border border-red-500/30 bg-red-500/10 p-6 text-sm text-red-200">
            <p className="font-semibold">
              Impossible de charger le catalogue pour le moment.
            </p>

            <p className="mt-2 text-red-200/80">
              Vérifiez que les fonctions SQL{' '}
              <code>get_public_catalogue_products</code> et{' '}
              <code>get_public_catalogue_categories</code> ont bien été créées
              dans Supabase.
            </p>

            <pre className="mt-4 overflow-auto rounded-lg bg-black/40 p-4 text-xs text-red-200/80">
              {productsResponse.error.message}
            </pre>
          </div>
        ) : products.length === 0 ? (
          /* État vide */
          <div className="mt-16 flex flex-col items-center justify-center rounded-2xl border border-dashed border-zinc-800 bg-zinc-950/50 px-6 py-20 text-center">
            <PackageSearch className="h-12 w-12 text-zinc-700" />

            <h2 className="mt-6 text-xl font-semibold text-white">
              Aucun produit trouvé pour le moment
            </h2>

            <p className="mt-3 max-w-md text-sm leading-relaxed text-zinc-400">
              Aucun produit ne correspond à votre recherche ou les fournisseurs
              n&apos;ont pas encore publié de produits actifs.
            </p>

            {hasFilters ? (
              <Button asChild variant="outline" className="mt-8">
                <Link href="/catalogue">Voir tout le catalogue</Link>
              </Button>
            ) : (
              <Button asChild className="mt-8 bg-emerald-600 hover:bg-emerald-500">
                <Link href="/auth/signup">
                  Publier un produit en tant que fournisseur
                </Link>
              </Button>
            )}
          </div>
        ) : (
          /* Grille produits */
          <div className="mt-10 grid grid-cols-1 gap-6 sm:grid-cols-2 xl:grid-cols-3">
            {products.map((product) => {
              const estimatedEur =
                eurToDzdRate && Number(product.price_dzd) > 0
                  ? Number(product.price_dzd) / eurToDzdRate
                  : null;

              const showRating =
                product.supplier_rating_avg &&
                Number(product.supplier_rating_avg) > 0;

              return (
                <article
                  key={product.product_id}
                  className="group flex flex-col overflow-hidden rounded-2xl border border-zinc-800 bg-zinc-900/40 transition hover:border-emerald-700/60 hover:bg-zinc-900/70"
                >
                  {/* Image produit */}
                  <div className="relative aspect-[4/3] overflow-hidden bg-zinc-950">
                    {product.image_url ? (
                      // Pour la production, il sera préférable d'utiliser next/image
                      // après configuration des domaines d'images autorisés.
                      // eslint-disable-next-line @next/next/no-img-element
                      <img
                        src={product.image_url}
                        alt={product.product_name}
                        loading="lazy"
                        className="h-full w-full object-cover transition duration-300 group-hover:scale-105"
                      />
                    ) : (
                      <div className="flex h-full w-full items-center justify-center">
                        <PackageSearch className="h-12 w-12 text-zinc-800" />
                      </div>
                    )}

                    {product.category ? (
                      <span className="absolute left-3 top-3 rounded-full bg-black/75 px-3 py-1 text-xs font-medium text-emerald-300 ring-1 ring-inset ring-emerald-500/20">
                        {product.category}
                      </span>
                    ) : null}
                  </div>

                  {/* Contenu carte */}
                  <div className="flex flex-1 flex-col p-5">
                    <div className="flex items-start justify-between gap-4">
                      <h3 className="text-lg font-semibold leading-snug text-white">
                        {product.product_name}
                      </h3>

                      {showRating ? (
                        <span className="flex items-center gap-1 rounded-full bg-amber-500/10 px-2.5 py-1 text-xs font-medium text-amber-300 ring-1 ring-inset ring-amber-500/20">
                          <Star className="h-3.5 w-3.5 fill-current" />
                          {Number(product.supplier_rating_avg).toFixed(1)}
                        </span>
                      ) : null}
                    </div>

                    <p className="mt-2 text-sm font-medium text-zinc-300">
                      {product.supplier_company_name}
                    </p>

                    {product.supplier_city || product.supplier_wilaya ? (
                      <p className="mt-1 flex items-center gap-1 text-sm text-zinc-500">
                        <MapPin className="h-4 w-4 text-zinc-600" />
                        {[product.supplier_city, product.supplier_wilaya]
                          .filter(Boolean)
                          .join(', ')}
                      </p>
                    ) : null}

                    {product.description ? (
                      <p className="mt-3 line-clamp-2 text-sm leading-relaxed text-zinc-400">
                        {product.description}
                      </p>
                    ) : null}

                    {/* Bloc prix / MOQ / stock */}
                    <div className="mt-5 rounded-xl border border-zinc-800 bg-zinc-950 p-4">
                      <div className="flex items-baseline justify-between gap-3">
                        <span className="text-2xl font-bold text-emerald-400">
                          {formatDzd(Number(product.price_dzd))}
                        </span>

                        <span className="text-xs text-zinc-500">
                          / {product.unit}
                        </span>
                      </div>

                      {estimatedEur ? (
                        <p className="mt-1 text-sm text-zinc-500">
                          ≈ {formatEur(estimatedEur)} par unité (estimation)
                        </p>
                      ) : null}

                      <div className="mt-4 space-y-1 border-t border-zinc-800 pt-4 text-sm text-zinc-400">
                        <p>
                          {product.min_order_qty &&
                          Number(product.min_order_qty) > 0
                            ? `Quantité minimale : ${new Intl.NumberFormat(
                                'fr-FR'
                              ).format(
                                Number(product.min_order_qty)
                              )} ${product.unit}`
                            : 'Quantité minimale : sur demande'}
                        </p>

                        <p>{getStockLabel(product)}</p>
                      </div>
                    </div>

                    {/* CTA */}
                    <div className="mt-auto pt-5">
                      <Button
                        asChild
                        variant="outline"
                        className="w-full border-emerald-700/50 text-emerald-300 hover:bg-emerald-950/40 hover:text-emerald-200"
                      >
                        <Link
                          href={
                            user
                              ? `/account?product_id=${product.product_id}`
                              : '/auth/login?next=/catalogue'
                          }
                        >
                          Demander une cotation
                        </Link>
                      </Button>
                    </div>
                  </div>
                </article>
              );
            })}
          </div>
        )}

        {/* CTA fournisseurs */}
        <section className="mt-20 rounded-3xl border border-emerald-500/20 bg-gradient-to-br from-emerald-950/40 to-zinc-950 p-8 md:p-14 text-center">
          <h2 className="mx-auto max-w-3xl text-2xl font-bold sm:text-4xl">
            Vous êtes un producteur algérien ?
          </h2>

          <p className="mx-auto mt-4 max-w-2xl text-sm leading-relaxed text-zinc-400 sm:text-base">
            Publiez vos produits, recevez des demandes de cotation de la part
            d&apos;acheteurs internationaux et développez vos exportations vers
            l&apos;Europe et l&apos;Afrique.
          </p>

          <div className="mt-8 flex flex-wrap items-center justify-center gap-4">
            {user ? (
              <Button
                asChild
                size="lg"
                className="bg-emerald-600 hover:bg-emerald-500"
              >
                <Link href="/account">Gérer mes produits</Link>
              </Button>
            ) : (
              <>
                <Button
                  asChild
                  size="lg"
                  className="bg-emerald-600 hover:bg-emerald-500"
                >
                  <Link href="/auth/signup">Créer un compte fournisseur</Link>
                </Button>

                <Button asChild size="lg" variant="outline">
                  <Link href="/auth/login">J&apos;ai déjà un compte</Link>
                </Button>
              </>
            )}
          </div>
        </section>
      </div>
    </div>
  );
}