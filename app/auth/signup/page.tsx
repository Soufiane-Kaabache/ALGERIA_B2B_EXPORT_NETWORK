'use client';

import { signupAction } from '../actions';
import { useState } from 'react';
import Link from 'next/link';

const ROLES = [
  { value: 'supplier', label: 'Fournisseur (Algérie)' },
  { value: 'carrier_dz', label: 'Transporteur National (Algérie)' },
  { value: 'carrier_eu', label: 'Transporteur International (EU)' },
  { value: 'freight_forwarder', label: 'Transitaire / Douane' },
  { value: 'buyer_eu', label: 'Acheteur / Grossiste (EU)' },
];

export default function SignupPage() {
  const [state, setState] = useState<{ error?: string; success?: string }>({});
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setLoading(true);
    setState({});

    const formData = new FormData(e.currentTarget);
    const result = await signupAction(formData);
    
    setState(result);
    setLoading(false);
  };

  return (
    <div className="flex min-h-screen items-center justify-center px-4 py-12 sm:px-6 lg:px-8">
      <div className="w-full max-w-md space-y-8">
        <div className="text-center">
          <h2 className="mt-6 text-3xl font-bold tracking-tight">
            Créer un compte B2B
          </h2>
          <p className="mt-2 text-sm opacity-80">
            Réseau d&apos;export Algérie - Europe
          </p>
        </div>
        
        <form className="mt-8 space-y-6 rounded-lg border p-8" onSubmit={handleSubmit}>
          
          {state.error && (
            <div className="rounded-md bg-red-500/20 p-4 text-sm text-red-400">
              {state.error}
            </div>
          )}
          
          {state.success && (
            <div className="rounded-md bg-green-500/20 p-4 text-sm text-green-400">
              {state.success}
            </div>
          )}

          <div>
            <label htmlFor="company_name" className="block text-sm font-medium">
              Nom de l&apos;entreprise
            </label>
            <input
              id="company_name"
              name="company_name"
              type="text"
              required
              className="mt-1 block w-full rounded-md border p-2 text-black" // text-black forcé pour être sûr de le voir
            />
          </div>

          <div>
            <label htmlFor="role" className="block text-sm font-medium">
              Je suis un...
            </label>
            <select
              id="role"
              name="role"
              required
              defaultValue="buyer_eu"
              className="mt-1 block w-full rounded-md border p-2 text-black bg-white"
            >
              {ROLES.map((role) => (
                <option key={role.value} value={role.value}>
                  {role.label}
                </option>
              ))}
            </select>
          </div>

          <div>
            <label htmlFor="email" className="block text-sm font-medium">
              Adresse email professionnelle
            </label>
            <input
              id="email"
              name="email"
              type="email"
              autoComplete="email"
              required
              className="mt-1 block w-full rounded-md border p-2 text-black"
            />
          </div>

          <div>
            <label htmlFor="password" className="block text-sm font-medium">
              Mot de passe
            </label>
            <input
              id="password"
              name="password"
              type="password"
              autoComplete="current-password"
              required
              minLength={6}
              className="mt-1 block w-full rounded-md border p-2 text-black"
            />
          </div>

          <div>
            <button
              type="submit"
              disabled={loading}
              className="group relative flex w-full justify-center rounded-md bg-blue-600 py-2 px-4 text-sm font-medium text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 disabled:opacity-50"
            >
              {loading ? 'Création du compte...' : "S'inscrire"}
            </button>
          </div>
        </form>

        <p className="text-center text-sm opacity-80">
          Déjà inscrit ?{' '}
          <Link href="/auth/login" className="font-medium text-blue-500 hover:text-blue-400">
            Se connecter
          </Link>
        </p>
      </div>
    </div>
  );
}