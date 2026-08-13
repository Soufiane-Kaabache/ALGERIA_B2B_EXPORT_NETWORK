import Link from 'next/link';
import { createClient } from '@/utils/supabase/server';
import { getUser } from '@/utils/supabase/queries';
import { 
  Building2, 
  Truck, 
  PackageCheck, 
  ShieldCheck, 
  ArrowRight, 
  TrendingUp, 
  Globe2, 
  FileCheck2,
  Boxes,
  Anchor
} from 'lucide-react';

export const revalidate = 3600; // Revalidation ISR toutes les heures pour la télémétrie

async function getTelemetryData(supabase: ReturnType<typeof createClient>) {
  try {
    // Exécution des comptages en parallèle pour de meilleures performances
    const [
      { count: suppliersCount },
      { count: productsCount },
      { count: carriersCount },
      { data: exchangeRateData }
    ] = await Promise.all([
      supabase.from('suppliers').select('*', { count: 'exact', head: true }).eq('business_status', 'active'),
      supabase.from('products_catalog').select('*', { count: 'exact', head: true }),
      supabase.from('carriers_dz').select('*', { count: 'exact', head: true }),
      supabase.from('exchange_rates').select('rate, rate_date').eq('currency_from', 'EUR').eq('currency_to', 'DZD').order('rate_date', { ascending: false }).maybeSingle()
    ]);

    return {
      suppliersCount: suppliersCount || 0,
      productsCount: productsCount || 0,
      carriersCount: carriersCount || 0,
      wilayasCount: 69, // Basé sur le découpage administratif 2025
      eurDzdRate: exchangeRateData?.rate || 148.50, // Valeur par défaut de secours si la table n'est pas encore alimentée
      rateLastUpdated: exchangeRateData?.rate_date
    };
  } catch (error) {
    console.error('Erreur lors de la récupération de la télémétrie:', error);
    return {
      suppliersCount: 0,
      productsCount: 0,
      carriersCount: 0,
      wilayasCount: 69,
      eurDzdRate: 148.50,
      rateLastUpdated: null
    };
  }
}

export default async function HomePage() {
  const supabase = createClient();
  const [user, telemetry] = await Promise.all([
    getUser(supabase),
    getTelemetryData(supabase)
  ]);

  const categories = [
    { title: 'Agroalimentaire & Dattes', count: 'Deglet Nour, Huiles, Conserves', icon: '🌾', href: '/catalogue?category=agroalimentaire' },
    { title: 'Matériaux de Construction', count: 'Ciment, Clinker, Céramique, Plâtre', icon: '🏗️', href: '/catalogue?category=materiaux' },
    { title: 'Plastique & Chimie', count: 'Emballages, Polymères, Engrais', icon: '🧪', href: '/catalogue?category=chimie' },
    { title: 'Textile & Cuir', count: 'Confection, Tissus industriels, Chaussures', icon: '🧵', href: '/catalogue?category=textile' },
  ];

  return (
    <div className="bg-zinc-950 text-zinc-100 min-h-screen">
      {/* BANDEAU SUPERIEUR : TAUX DE CHANGE OFFICIEL */}
      <div className="bg-emerald-950/80 border-b border-emerald-800/40 px-4 py-2 text-xs sm:text-sm text-emerald-300">
        <div className="max-w-7xl mx-auto flex flex-wrap justify-between items-center gap-2">
          <div className="flex items-center gap-2">
            <span className="flex h-2 w-2 rounded-full bg-emerald-400 animate-pulse" />
            <span className="font-semibold">Taux de Change Officiel (Banque d'Algérie) :</span>
            <span className="font-mono bg-emerald-900/60 px-2 py-0.5 rounded text-emerald-200">
              1 EUR = {telemetry.eurDzdRate.toFixed(2)} DZD
            </span>
          </div>
          <div className="text-emerald-400/80 text-xs">
            Réseau certifié B2B • Transaction Sûre
          </div>
        </div>
      </div>

      {/* HERO SECTION */}
      <section className="relative pt-12 pb-20 px-4 sm:px-6 lg:px-8 max-w-7xl mx-auto text-center lg:text-left">
        <div className="grid lg:grid-cols-12 gap-12 items-center">
          <div className="lg:col-span-7 space-y-6">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-zinc-900 border border-zinc-800 text-xs font-medium text-emerald-400">
              <Globe2 className="w-3.5 h-3.5" />
              Plateforme B2B Algérie ↔ France / Europe
            </div>

            <h1 className="text-4xl sm:text-6xl font-extrabold tracking-tight text-white leading-tight">
              Sourcing Direct auprès des <span className="text-emerald-500">Producteurs Algériens</span>
            </h1>

            <p className="text-lg text-zinc-400 max-w-2xl">
              Accédez au premier réseau d'exportation B2B certifié. Mettez en relation vos besoins d'approvisionnement avec des industriels vérifiés (KYC), des transitaires agréés et des transporteurs internationaux.
            </p>

            <div className="flex flex-col sm:flex-row gap-4 pt-2 justify-center lg:justify-start">
              <Link
                href="/catalogue"
                className="inline-flex items-center justify-center gap-2 px-6 py-3.5 rounded-lg bg-emerald-600 hover:bg-emerald-500 font-semibold text-white transition-all shadow-lg shadow-emerald-900/20"
              >
                Explorers le Catalogue Export
                <ArrowRight className="w-4 h-4" />
              </Link>
              
              {!user ? (
                <Link
                  href="/register"
                  className="inline-flex items-center justify-center gap-2 px-6 py-3.5 rounded-lg bg-zinc-900 hover:bg-zinc-800 border border-zinc-700 font-semibold text-zinc-200 transition-all"
                >
                  Devenir Fournisseur / Transporteur
                </Link>
              ) : (
                <Link
                  href="/dashboard"
                  className="inline-flex items-center justify-center gap-2 px-6 py-3.5 rounded-lg bg-zinc-900 hover:bg-zinc-800 border border-zinc-700 font-semibold text-zinc-200 transition-all"
                >
                  Accéder à mon Espace
                </Link>
              )}
            </div>
          </div>

          {/* TELEMETRIE / KPIs CARDS */}
          <div className="lg:col-span-5 grid grid-cols-2 gap-4">
            <div className="bg-zinc-900/80 border border-zinc-800 p-5 rounded-xl space-y-2">
              <Building2 className="w-6 h-6 text-emerald-400" />
              <div className="text-3xl font-extrabold text-white">{telemetry.suppliersCount}+</div>
              <div className="text-xs text-zinc-400 font-medium">Fournisseurs Algériens Vérifiés</div>
            </div>

            <div className="bg-zinc-900/80 border border-zinc-800 p-5 rounded-xl space-y-2">
              <Boxes className="w-6 h-6 text-emerald-400" />
              <div className="text-3xl font-extrabold text-white">{telemetry.productsCount}+</div>
              <div className="text-xs text-zinc-400 font-medium">Références Exportables</div>
            </div>

            <div className="bg-zinc-900/80 border border-zinc-800 p-5 rounded-xl space-y-2">
              <Truck className="w-6 h-6 text-emerald-400" />
              <div className="text-3xl font-extrabold text-white">{telemetry.carriersCount}+</div>
              <div className="text-xs text-zinc-400 font-medium">Transporteurs & Transitaires</div>
            </div>

            <div className="bg-zinc-900/80 border border-zinc-800 p-5 rounded-xl space-y-2">
              <Globe2 className="w-6 h-6 text-emerald-400" />
              <div className="text-3xl font-extrabold text-white">{telemetry.wilayasCount}</div>
              <div className="text-xs text-zinc-400 font-medium">Wilayas Couvertes (2025)</div>
            </div>
          </div>
        </div>
      </section>

      {/* CATEGORIES PRODUITS */}
      <section className="py-16 bg-zinc-900/50 border-y border-zinc-800/80 px-4 sm:px-6 lg:px-8">
        <div className="max-w-7xl mx-auto">
          <div className="flex flex-col md:flex-row md:items-end justify-between mb-10 gap-4">
            <div>
              <h2 className="text-2xl sm:text-3xl font-bold text-white">Secteurs Majeurs à l'Export</h2>
              <p className="text-zinc-400 text-sm mt-1">Parcourez les filières industrielles et agricoles clés d'Algérie.</p>
            </div>
            <Link href="/catalogue" className="text-emerald-400 hover:text-emerald-300 text-sm font-semibold flex items-center gap-1">
              Voir tout le catalogue <ArrowRight className="w-4 h-4" />
            </Link>
          </div>

          <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {categories.map((cat, i) => (
              <Link 
                key={i} 
                href={cat.href}
                className="group bg-zinc-900 border border-zinc-800 hover:border-emerald-500/50 p-6 rounded-xl transition-all duration-200"
              >
                <div className="text-4xl mb-4">{cat.icon}</div>
                <h3 className="text-lg font-bold text-white group-hover:text-emerald-400 transition-colors">{cat.title}</h3>
                <p className="text-xs text-zinc-400 mt-2">{cat.count}</p>
              </Link>
            ))}
          </div>
        </div>
      </section>

      {/* WORKFLOW SUPPLY CHAIN */}
      <section className="py-20 px-4 sm:px-6 lg:px-8 max-w-7xl mx-auto">
        <div className="text-center max-w-3xl mx-auto mb-16">
          <h2 className="text-3xl font-extrabold text-white">Une Chaîne Logistique B2B Intégrée</h2>
          <p className="text-zinc-400 mt-3">De l'usine algérienne jusqu'à la livraison finale en France ou en Europe.</p>
        </div>

        <div className="grid md:grid-cols-4 gap-8 relative">
          <div className="bg-zinc-900/60 border border-zinc-800 p-6 rounded-xl relative">
            <div className="w-10 h-10 rounded-lg bg-emerald-950 text-emerald-400 border border-emerald-800 flex items-center justify-center font-bold mb-4">1</div>
            <h3 className="font-bold text-white text-base mb-2">Sélection & Devis</h3>
            <p className="text-xs text-zinc-400">Demande de cotation directe auprès du producteur selon les Incoterms (FOB, CIF, EXW).</p>
          </div>

          <div className="bg-zinc-900/60 border border-zinc-800 p-6 rounded-xl relative">
            <div className="w-10 h-10 rounded-lg bg-emerald-950 text-emerald-400 border border-emerald-800 flex items-center justify-center font-bold mb-4">2</div>
            <h3 className="font-bold text-white text-base mb-2">Conformité KYC</h3>
            <p className="text-xs text-zinc-400">Vérification automatique des registres de commerce (RC/NIF) et documents douaniers.</p>
          </div>

          <div className="bg-zinc-900/60 border border-zinc-800 p-6 rounded-xl relative">
            <div className="w-10 h-10 rounded-lg bg-emerald-950 text-emerald-400 border border-emerald-800 flex items-center justify-center font-bold mb-4">3</div>
            <h3 className="font-bold text-white text-base mb-2">Transit & Douanes</h3>
            <p className="text-xs text-zinc-400">Prise en charge par des transitaires locaux pour le passage en port/aéroport.</p>
          </div>

          <div className="bg-zinc-900/60 border border-zinc-800 p-6 rounded-xl relative">
            <div className="w-10 h-10 rounded-lg bg-emerald-950 text-emerald-400 border border-emerald-800 flex items-center justify-center font-bold mb-4">4</div>
            <h3 className="font-bold text-white text-base mb-2">Paiement & Fret</h3>
            <p className="text-xs text-zinc-400">Paiement sécurisé Stripe (EUR) ou virement BEA, suivi d'expédition maritime/terrestre.</p>
          </div>
        </div>
      </section>

      {/* BANDEAU REASSURANCE */}
      <section className="bg-emerald-950/40 border-t border-zinc-800 py-12 px-4 sm:px-6 lg:px-8">
        <div className="max-w-7xl mx-auto flex flex-col md:flex-row items-center justify-between gap-6 text-center md:text-left">
          <div className="space-y-1">
            <h3 className="text-xl font-bold text-white">Vous êtes un industriel ou producteur en Algérie ?</h3>
            <p className="text-sm text-zinc-400">Exposez vos produits au réseau d'acheteurs européens et développez votre chiffre à l'export.</p>
          </div>
          <Link
            href="/register?type=supplier"
            className="px-6 py-3 rounded-lg bg-emerald-500 hover:bg-emerald-400 font-bold text-zinc-950 transition-colors whitespace-nowrap"
          >
            Référencer mon Entreprise
          </Link>
        </div>
      </section>
    </div>
  );
}