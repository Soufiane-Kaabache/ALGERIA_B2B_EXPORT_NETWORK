import Link from 'next/link';
import { createClient } from '@/utils/supabase/server';
import { redirect } from 'next/navigation';

export default async function DashboardLayout({
  children
}: {
  children: React.ReactNode;
}) {
  const supabase = createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) redirect('/signin');

  return (
    <div className="min-h-screen bg-zinc-950 text-zinc-100">
      <nav className="bg-zinc-900/80 border-b border-zinc-800">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex">
              <div className="flex-shrink-0 flex items-center">
                <Link href="/" className="text-xl font-bold text-emerald-500">
                  Algeria B2B
                </Link>
              </div>
              <div className="hidden sm:ml-6 sm:flex sm:space-x-4">
                <Link href="/admin" className="text-zinc-400 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Admin</Link>
                <Link href="/finance" className="text-zinc-400 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Finance</Link>
                <Link href="/kyc" className="text-zinc-400 hover:text-white px-3 py-2 rounded-md text-sm font-medium">KYC</Link>
                <Link href="/support" className="text-zinc-400 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Support</Link>
                <Link href="/logistics" className="text-zinc-400 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Logistique</Link>
                <Link href="/catalog" className="text-zinc-400 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Catalogue</Link>
                <Link href="/moderation" className="text-zinc-400 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Modération</Link>
              </div>
            </div>
            <div className="flex items-center">
              <Link href="/account" className="text-zinc-500 hover:text-zinc-300 px-3 py-2 rounded-md text-sm font-medium">
                Mon compte
              </Link>
            </div>
          </div>
        </div>
      </nav>
      <main className="py-10">
        <div className="max-w-7xl mx-auto sm:px-6 lg:px-8">{children}</div>
      </main>
    </div>
  );
}
