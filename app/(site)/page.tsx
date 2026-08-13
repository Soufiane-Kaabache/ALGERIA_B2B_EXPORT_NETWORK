import Link from 'next/link';
import { Metadata } from 'next';
import { createClient } from '@/utils/supabase/server';
import { getUser } from '@/utils/supabase/queries';
import {
  Building2,
  Truck,
  Boxes,
  Globe2,
  ArrowRight,
} from 'lucide-react';
import { 
  RadarTargetIcon, 
  MeshNetworkIcon, 
  CircuitStreamIcon, 
  AgroIcon, 
  ConstructionIcon, 
  ChemistryIcon, 
  TextileIcon 
} from '@/components/icons/AnimatedIcons';

export const revalidate = 3600;

export const metadata: Metadata = {
  title: 'AlgeriaExport B2B — Sourcing Direct Producteurs Algériens',
  description:
    'Première plateforme B2B certifiée reliant les industriels algériens aux acheteurs européens. Fournisseurs vérifiés KYC, transitaires agréés, fret international.',
  openGraph: {
    title: 'AlgeriaExport B2B',
    description: 'Sourcing direct auprès des producteurs algériens vérifiés',
    type: 'website',
  },
};

interface TelemetryData {
  suppliersCount: number;
  productsCount: number;
  transportersCount: number;
  wilayasCount: number;
  eurDzdRate: number;
  rateLastUpdated: string | null;
}

async function getTelemetryData(
  supabase: ReturnType<typeof createClient>
): Promise<TelemetryData> {
  try {
    const [
      { count: suppliersCount },
      { count: productsCount },
      { count: carriersDz },
      { count: carriersEu },
      { count: freightForwarders },
      { count: deliveryCompanies },
      { count: wilayasCount },
      { data: exchangeRateData },
    ] = await Promise.all([
      supabase.from('suppliers').select('*', { count: 'exact', head: true }).eq('kyc_status', 'verified'),
      supabase.from('products_catalog').select('*', { count: 'exact', head: true }).eq('active', true),
      supabase.from('carriers_dz').select('*', { count: 'exact', head: true }).eq('kyc_status', 'verified'),
      supabase.from('carriers_eu').select('*', { count: 'exact', head: true }).eq('kyc_status', 'verified'),
      supabase.from('freight_forwarders').select('*', { count: 'exact', head: true }).eq('kyc_status', 'verified'),
      supabase.from('delivery_companies').select('*', { count: 'exact', head: true }).eq('kyc_status', 'verified'),
      supabase.from('wilayas').select('*', { count: 'exact', head: true }),
      supabase.from('exchange_rates').select('rate, created_at').eq('currency_from', 'EUR').eq('currency_to', 'DZD').order('created_at', { ascending: false }).limit(1).maybeSingle(),
    ]);

    return {
      suppliersCount: suppliersCount || 0,
      productsCount: productsCount || 0,
      transportersCount: (carriersDz || 0) + (carriersEu || 0) + (freightForwarders || 0) + (deliveryCompanies || 0),
      wilayasCount: wilayasCount || 58,
      eurDzdRate: exchangeRateData?.rate || 148.5,
      rateLastUpdated: exchangeRateData?.created_at ?? null,
    };
  } catch (error) {
    console.error('Erreur telemetry:', error);
    return {
      suppliersCount: 0,
      productsCount: 0,
      transportersCount: 0,
      wilayasCount: 58,
      eurDzdRate: 148.5,
      rateLastUpdated: null,
    };
  }
}

const categories = [
  { title: 'Agroalimentaire & Dattes', description: 'Deglet Nour, Huiles, Conserves', icon: AgroIcon, href: '/catalogue?category=agroalimentaire' },
  { title: 'Matériaux de Construction', description: 'Ciment, Clinker, Céramique, Plâtre', icon: ConstructionIcon, href: '/catalogue?category=materiaux' },
  { title: 'Plastique & Chimie', description: 'Emballages, Polymères, Engrais', icon: ChemistryIcon, href: '/catalogue?category=chimie' },
  { title: 'Textile & Cuir', description: 'Confection, Tissus industriels, Chaussures', icon: TextileIcon, href: '/catalogue?category=textile' },
];

const workflowSteps = [
  { num: 1, title: 'Sélection & Devis', description: "Demande de cotation directe auprès du producteur selon les Incoterms (FOB, CIF, EXW)." },
  { num: 2, title: 'Conformité KYC', description: 'Vérification automatique des registres de commerce (RC/NIF) et documents douaniers.' },
  { num: 3, title: 'Transit & Douanes', description: 'Prise en charge par des transitaires locaux pour le passage en port/aéroport.' },
  { num: 4, title: 'Paiement & Fret', description: "Paiement sécurisé Stripe (EUR) ou virement BEA, suivi d'expédition maritime/terrestre." },
];

export default async function HomePage() {
  const supabase = createClient();
  const [user, telemetry] = await Promise.all([
    getUser(supabase),
    getTelemetryData(supabase),
  ]);

  return (
    <div className="bg-zinc-950 text-zinc-100 min-h-screen">
      {/* BANDEAU SUPERIEUR : TAUX DE CHANGE OFFICIEL */}
      <div className="bg-emerald-950/80 border-b border-emerald-800/40 px-4 py-2 text-xs sm:text-sm text-emerald-300">
        <div className="max-w-7xl mx-auto flex flex-wrap justify-between items-center gap-2">
          <div className="flex items-center gap-2 flex-wrap">
            <span className="flex h-2 w-2 rounded-full bg-emerald-400 animate-pulse" aria-hidden="true" />
            <span className="font-semibold">Taux de Change Officiel (Banque d&apos;Algérie) :</span>
            <span className="font-mono bg-emerald-900/60 px-2 py-0.5 rounded text-emerald-200">
              1 EUR = {telemetry.eurDzdRate.toFixed(2)} DZD
            </span>
            {telemetry.rateLastUpdated && (
              <span className="text-emerald-500/60">
                (mis à jour le {new Date(telemetry.rateLastUpdated).toLocaleDateString('fr-FR')})
              </span>
            )}
          </div>
          <div className="text-emerald-400/80 text-xs">Réseau certifié B2B • Transaction Sûre</div>
        </div>
      </div>

      {/* HERO SECTION */}
      <section className="relative pt-12 pb-20 px-4 sm:px-6 lg:px-8 max-w-7xl mx-auto text-center lg:text-left">
        <div className="grid lg:grid-cols-12 gap-12 items-center">
          <div className="lg:col-span-7 space-y-6">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-zinc-900 border border-zinc-800 text-xs font-medium text-emerald-400">
              <Globe2 className="w-3.5 h-3.5" aria-hidden="true" />
              Plateforme B2B Algérie ↔ France / Europe
            </div>
            <h1 className="text-4xl sm:text-6xl font-extrabold tracking-tight text-white leading-tight">
              Sourcing Direct auprès des <span className="text-emerald-500">Producteurs Algériens</span>
            </h1>
            <p className="text-lg text-zinc-400 max-w-2xl">
              Accédez au premier réseau d&apos;exportation B2B certifié. Mettez en relation vos besoins d&apos;approvisionnement avec des industriels vérifiés (KYC), des transitaires agréés et des transporteurs internationaux.
            </p>
            <div className="flex flex-col sm:flex-row gap-4 pt-2 justify-center lg:justify-start">
              <Link href="/catalogue" className="inline-flex items-center justify-center gap-2 px-6 py-3.5 rounded-lg bg-emerald-600 hover:bg-emerald-500 font-semibold text-white transition-all shadow-lg shadow-emerald-900/20">
                Explorer le Catalogue Export
                <ArrowRight className="w-4 h-4" aria-hidden="true" />
              </Link>
              {!user ? (
                <Link href="/register" className="inline-flex items-center justify-center gap-2 px-6 py-3.5 rounded-lg bg-zinc-900 hover:bg-zinc-800 border border-zinc-700 font-semibold text-zinc-200 transition-all">
                  Devenir Fournisseur / Transporteur
                </Link>
              ) : (
                <Link href="/dashboard" className="inline-flex items-center justify-center gap-2 px-6 py-3.5 rounded-lg bg-zinc-900 hover:bg-zinc-800 border border-zinc-700 font-semibold text-zinc-200 transition-all">
                  Accéder à mon Espace
                </Link>
              )}
            </div>
          </div>

          {/* TELEMETRIE / KPIs CARDS */}
          <div className="lg:col-span-5 grid grid-cols-2 gap-4">
            <div className="bg-zinc-900/80 border border-zinc-800 p-5 rounded-xl space-y-2">
              <Building2 className="w-6 h-6 text-emerald-400" aria-hidden="true" />
              <div className="text-3xl font-extrabold text-white">{telemetry.suppliersCount}+</div>
              <div className="text-xs text-zinc-400 font-medium">Fournisseurs Vérifiés (KYC)</div>
            </div>
            <div className="bg-zinc-900/80 border border-zinc-800 p-5 rounded-xl space-y-2">
              <Boxes className="w-6 h-6 text-emerald-400" aria-hidden="true" />
              <div className="text-3xl font-extrabold text-white">{telemetry.productsCount}+</div>
              <div className="text-xs text-zinc-400 font-medium">Références Exportables</div>
            </div>
            <div className="bg-zinc-900/80 border border-zinc-800 p-5 rounded-xl space-y-2">
              <Truck className="w-6 h-6 text-emerald-400" aria-hidden="true" />
              <div className="text-3xl font-extrabold text-white">{telemetry.transportersCount}+</div>
              <div className="text-xs text-zinc-400 font-medium">Transporteurs & Transitaires</div>
            </div>
            <div className="bg-zinc-900/80 border border-zinc-800 p-5 rounded-xl space-y-2">
              <Globe2 className="w-6 h-6 text-emerald-400" aria-hidden="true" />
              <div className="text-3xl font-extrabold text-white">{telemetry.wilayasCount}</div>
              <div className="text-xs text-zinc-400 font-medium">Wilayas Couvertes</div>
            </div>
          </div>
        </div>
      </section>

      {/* CATEGORIES PRODUITS */}
      <section className="py-16 bg-zinc-900/50 border-y border-zinc-800/80 px-4 sm:px-6 lg:px-8">
        <div className="max-w-7xl mx-auto">
          <div className="flex flex-col md:flex-row md:items-end justify-between mb-10 gap-4">
            <div>
              <h2 className="text-2xl sm:text-3xl font-bold text-white">Secteurs Majeurs à l&apos;Export</h2>
              <p className="text-zinc-400 text-sm mt-1">Parcourez les filières industrielles et agricoles clés d&apos;Algérie.</p>
            </div>
            <Link href="/catalogue" className="text-emerald-400 hover:text-emerald-300 text-sm font-semibold flex items-center gap-1">
              Voir tout le catalogue <ArrowRight className="w-4 h-4" aria-hidden="true" />
            </Link>
          </div>
          <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {categories.map((cat, i) => (
              <Link key={i} href={cat.href} prefetch={false} className="group bg-zinc-900 border border-zinc-800 hover:border-emerald-500/50 p-6 rounded-xl transition-all duration-200">
                <cat.icon className="w-8 h-8 text-emerald-500 mb-4" />
                <h3 className="text-lg font-bold text-white group-hover:text-emerald-400 transition-colors">{cat.title}</h3>
                <p className="text-xs text-zinc-400 mt-2">{cat.description}</p>
              </Link>
            ))}
          </div>
        </div>
      </section>

      {/* WORKFLOW SUPPLY CHAIN */}
      <section className="py-20 px-4 sm:px-6 lg:px-8 max-w-7xl mx-auto">
        <div className="text-center max-w-3xl mx-auto mb-16">
          <h2 className="text-3xl font-extrabold text-white">Une Chaîne Logistique B2B Intégrée</h2>
          <p className="text-zinc-400 mt-3">De l&apos;usine algérienne jusqu&apos;à la livraison finale en France ou en Europe.</p>
        </div>
        <div className="grid md:grid-cols-4 gap-8 relative">
          <div className="hidden md:block absolute top-[3.25rem] left-[12.5%] right-[12.5%] h-px bg-gradient-to-r from-emerald-800/40 via-emerald-500/60 to-emerald-800/40" aria-hidden="true" />
          
          {workflowSteps.map((step) => (
            <div key={step.num} className="bg-zinc-900/60 border border-zinc-800 p-6 rounded-xl">
              <div className="relative z-10 w-10 h-10 rounded-lg bg-emerald-950 text-emerald-400 border border-emerald-800 flex items-center justify-center mb-4">
                {step.num === 1 && <span className="font-bold">{step.num}</span>}
                {step.num === 2 && <MeshNetworkIcon className="text-emerald-400" />}
                {step.num === 3 && <CircuitStreamIcon className="text-emerald-400" />}
                {step.num === 4 && <RadarTargetIcon className="text-emerald-400" />}
              </div>
              <h3 className="font-bold text-white text-base mb-2">{step.title}</h3>
              <p className="text-xs text-zinc-400">{step.description}</p>
            </div>
          ))}
        </div>
      </section>

      {/* BANDEAU REASSURANCE */}
      <section className="bg-emerald-950/40 border-t border-zinc-800 py-12 px-4 sm:px-6 lg:px-8">
        <div className="max-w-7xl mx-auto flex flex-col md:flex-row items-center justify-between gap-6 text-center md:text-left">
          <div className="space-y-1">
            <h3 className="text-xl font-bold text-white">Vous êtes un industriel ou producteur en Algérie ?</h3>
            <p className="text-sm text-zinc-400">Exposez vos produits au réseau d&apos;acheteurs européens et développez votre chiffre à l&apos;export.</p>
          </div>
          <Link
            href="/supplier/onboarding"
            className="px-6 py-3 rounded-lg bg-emerald-500 hover:bg-emerald-400 font-bold text-zinc-950 transition-colors whitespace-nowrap"
          >
            Référencer mon Entreprise
          </Link>
        </div>
      </section>
    </div>
  );
}