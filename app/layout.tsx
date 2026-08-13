import { Metadata } from 'next';
import { Toaster } from '@/components/ui/Toasts/toaster';
import { PropsWithChildren, Suspense } from 'react';
import { getURL } from '@/utils/helpers';
import 'styles/main.css';

const title = 'Algeria B2B Export Network';
const description = 'Plateforme B2B Algérie-Europe';

export const metadata: Metadata = {
  metadataBase: new URL(getURL()),
  title: title,
  description: description,
  openGraph: { title, description }
};

export default async function RootLayout({ children }: PropsWithChildren) {
  return (
    <html lang="fr">
      <body className="bg-black">
        {children}
        <Suspense>
          <Toaster />
        </Suspense>
      </body>
    </html>
  );
}
