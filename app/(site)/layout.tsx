import Footer from '@/components/ui/Footer';
import Navbar from '@/components/ui/Navbar';
import { PropsWithChildren } from 'react';

export default function SiteLayout({ children }: PropsWithChildren) {
  return (
    <>
      <Navbar />
      <main className="min-h-[calc(100dvh-4rem)]">
        {children}
      </main>
      <Footer />
    </>
  );
}
