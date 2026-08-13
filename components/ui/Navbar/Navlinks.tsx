'use client';

import Link from 'next/link';
import { SignOut } from '@/utils/auth-helpers/server';
import { handleRequest } from '@/utils/auth-helpers/client';
import { usePathname, useRouter } from 'next/navigation';
import { getRedirectMethod } from '@/utils/auth-helpers/settings';
import s from './Navbar.module.css';

interface NavlinksProps {
  user?: any;
}

export default function Navlinks({ user }: NavlinksProps) {
  const router = getRedirectMethod() === 'client' ? useRouter() : null;

  return (
    <div className="relative flex flex-row justify-between py-4 align-center md:py-6">
      <div className="flex items-center flex-1">
        <Link href="/" className={s.logo} aria-label="Logo">
          <span className="font-bold text-white text-lg mr-2">Algeria B2B</span>
        </Link>
        <nav className="ml-6 space-x-4 lg:block">
          <Link href="/catalogue" className={s.link}>
            Catalogue
          </Link>
          <Link href="/supplier/onboarding" className={s.link}>
            Devenir Fournisseur
          </Link>
          {user && (
            <Link href="/finance" className={s.link}>
              Dashboard
            </Link>
          )}
        </nav>
      </div>
      <div className="flex justify-end space-x-4">
        {user ? (
          <div className="flex items-center space-x-4">
            <Link href="/account" className={s.link}>
              Mon Compte
            </Link>
            <form onSubmit={(e) => handleRequest(e, SignOut, router)}>
              <input type="hidden" name="pathName" value={usePathname()} />
              <button type="submit" className={s.link}>
                Déconnexion
              </button>
            </form>
          </div>
        ) : (
          <Link href="/signin" className="inline-flex items-center justify-center px-4 py-2 rounded-md bg-emerald-600 hover:bg-emerald-500 text-sm font-semibold text-white transition-colors">
            Connexion
          </Link>
        )}
      </div>
    </div>
  );
}