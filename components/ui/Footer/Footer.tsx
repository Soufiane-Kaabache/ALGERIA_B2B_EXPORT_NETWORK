import Link from 'next/link';
import Logo from '@/components/icons/Logo';

export default function Footer() {
  return (
    <footer className="bg-zinc-900 border-t border-zinc-800">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="grid grid-cols-1 gap-8 py-12 md:grid-cols-4">
          
          {/* Identité */}
          <div className="col-span-1">
            <Link href="/" className="flex items-center font-bold text-white">
              <span className="mr-2 border rounded-full border-zinc-700 p-0.5">
                <Logo />
              </span>
              <span>Algeria B2B</span>
            </Link>
            <p className="mt-4 text-sm text-zinc-500">
              La plateforme de référence pour le sourcing B2B entre l&apos;Algérie et l&apos;Europe.
            </p>
          </div>

          {/* Plateforme */}
          <div>
            <h3 className="text-sm font-semibold text-zinc-300 uppercase tracking-wider">Plateforme</h3>
            <ul className="mt-4 space-y-3">
              <li><Link href="/catalogue" className="text-sm text-zinc-500 hover:text-emerald-400 transition-colors">Catalogue Export</Link></li>
              <li><Link href="/supplier/onboarding" className="text-sm text-zinc-500 hover:text-emerald-400 transition-colors">Devenir Fournisseur</Link></li>
              <li><Link href="/signin" className="text-sm text-zinc-500 hover:text-emerald-400 transition-colors">Espace Acheteur</Link></li>
            </ul>
          </div>

          {/* Support */}
          <div>
            <h3 className="text-sm font-semibold text-zinc-300 uppercase tracking-wider">Support</h3>
            <ul className="mt-4 space-y-3">
              <li><Link href="/support" className="text-sm text-zinc-500 hover:text-emerald-400 transition-colors">Centre d&apos;aide</Link></li>
              <li><Link href="/contact" className="text-sm text-zinc-500 hover:text-emerald-400 transition-colors">Nous contacter</Link></li>
            </ul>
          </div>

          {/* Légal */}
          <div>
            <h3 className="text-sm font-semibold text-zinc-300 uppercase tracking-wider">Légal</h3>
            <ul className="mt-4 space-y-3">
              <li><Link href="/mentions-legales" className="text-sm text-zinc-500 hover:text-emerald-400 transition-colors">Mentions légales</Link></li>
              <li><Link href="/confidentialite" className="text-sm text-zinc-500 hover:text-emerald-400 transition-colors">Politique de confidentialité</Link></li>
              <li><Link href="/cgv" className="text-sm text-zinc-500 hover:text-emerald-400 transition-colors">CGU / CGV</Link></li>
            </ul>
          </div>

        </div>

        {/* Copyright Propre */}
        <div className="flex flex-col items-center justify-between py-8 border-t border-zinc-800 md:flex-row">
          <p className="text-sm text-zinc-600">
            &copy; {new Date().getFullYear()} Algeria B2B Export Network. Tous droits réservés.
          </p>
          <p className="text-sm text-zinc-700 mt-2 md:mt-0">
            Conçu pour le commerce Algéro-Européen.
          </p>
        </div>
      </div>
    </footer>
  );
}
