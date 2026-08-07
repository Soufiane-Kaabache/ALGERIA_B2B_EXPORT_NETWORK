# Algeria B2B Export Network

Plateforme B2B mettant en relation les acteurs du commerce d'export entre l'Algérie et la France : fournisseurs algériens, transporteurs (nationaux et internationaux), transitaires, grossistes/importateurs et commerçants au détail en France.

> Basé sur le starter [Next.js Subscription Payments](https://github.com/vercel/nextjs-subscription-payments) (Next.js + Supabase + Stripe).

## À propos

Le projet centralise :

- **Fournisseurs Algérie** — avec onboarding et validation KYC
- **Transporteurs** — nationaux (Algérie) et internationaux (Algérie → France)
- **Transitaires**
- **Taux de change officiels** — mise à jour automatique (taux officiel uniquement, pas de marché parallèle)
- **Grossistes / importateurs** en France de produits algériens
- **Commerçants au détail** en France
- **Sociétés de livraison**

Catalogue strictement B2B : tous les acteurs référencés sont des entreprises.

## Stack technique

- **Framework** : Next.js 14
- **Base de données & Auth** : Supabase (PostgreSQL)
- **Paiements & abonnements** : Stripe (Checkout + Customer Portal + webhooks)
- **Déploiement** : Vercel

## Fonctionnalités principales

- Authentification et gestion des utilisateurs via Supabase
- Onboarding fournisseur avec validation KYC (Algérie)
- Gestion des abonnements et paiements via Stripe
- Synchronisation automatique des plans tarifaires et statuts d'abonnement via les webhooks Stripe

## Développement local

### Installer les dépendances

```bash
pnpm install
```

### Lier le projet Vercel

```bash
pnpm dlx vercel login
pnpm dlx vercel link
```

### Variables d'environnement

Copier les fichiers d'exemple :

```bash
cp .env.local.example .env.local
cp .env.example .env
```

Renseigner au minimum :

- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- `SUPABASE_SERVICE_ROLE_KEY`
- `NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY`
- `STRIPE_SECRET_KEY`
- `STRIPE_WEBHOOK_SECRET`

### Supabase en local (recommandé)

Nécessite [Docker](https://www.docker.com/get-started/).

```bash
pnpm supabase:start
pnpm supabase:status
```

### Stripe — tester les webhooks en local

```bash
pnpm stripe:login
pnpm stripe:listen
```

### Lancer le serveur de développement

```bash
pnpm dev
```

Puis ouvrir [http://localhost:3000](http://localhost:3000).

## Déploiement

1. Importer le repo sur [Vercel](https://vercel.com/new)
2. Renseigner les variables d'environnement Supabase et Stripe en production
3. Configurer le webhook Stripe vers `https://<votre-domaine>/api/webhooks`
4. Redéployer après ajout des variables (sans utiliser le cache de build existant)

## Licence

MIT