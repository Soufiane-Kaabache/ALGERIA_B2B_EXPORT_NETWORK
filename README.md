# Algeria B2B Export Network

Plateforme B2B mettant en relation les acteurs du commerce d'export entre l'Algérie et la France : fournisseurs algériens, transporteurs (nationaux et internationaux), transitaires, grossistes/importateurs et commerçants au détail en France.

> Basé sur le starter [Next.js Subscription Payments](https://github.com/vercel/nextjs-subscription-payments) (Next.js + Supabase + Stripe), adapté à un catalogue B2B.

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

**Modèle de paiement prévu :**
- Fournisseurs et transporteurs algériens : abonnement payé en dinars pour être référencés
- Clients internationaux (Europe, Amérique du Nord, Asie) : paiement via Stripe
- Commission prélevée sur chaque transaction, avec transferts de fonds et gestion des devises via un compte bancaire dédié en France

## Stack technique

- **Framework** : Next.js 14
- **Base de données & Auth** : Supabase (PostgreSQL)
- **Paiements** : Stripe (Checkout + Customer Portal)
- **Déploiement** : Vercel

## Fonctionnalités principales

- Authentification et gestion des utilisateurs via Supabase
- Onboarding fournisseur avec validation KYC (Algérie)

## État du projet / travaux en cours

Ce projet part du starter Stripe Subscription Payments de Vercel, dont le schéma de données a été en grande partie remplacé par le vrai modèle B2B (`businesses`, `subscriptions` adaptées aux plans fournisseur/transporteur, etc.). Certaines parties héritées du starter d'origine restent à reconstruire :

- **Webhook Stripe** (`app/api/webhooks/route.ts` + `utils/supabase/admin.ts`) : compile, mais la logique de synchronisation (`products`/`prices`/`customers`) correspond encore à l'ancien modèle Stripe SaaS générique et doit être réécrite pour le vrai modèle d'abonnement fournisseur/transporteur (`business_id`, `plan`, `amount_paid`, commission).
- **Page de tarifs** : la page d'accueil est temporairement simplifiée ; une vraie page de plans (fournisseurs/transporteurs en dinars, clients internationaux via Stripe) reste à construire.

## Développement local

### Installer les dépendances

```bash
npm install
```

### Lier le projet Vercel

```bash
npx vercel login
npx vercel link
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
npm run supabase:start
npm run supabase:status
```

### Stripe — tester les webhooks en local

```bash
npm run stripe:login
npm run stripe:listen
```

### Lancer le serveur de développement

```bash
npm run dev
```

Puis ouvrir [http://localhost:3000](http://localhost:3000).

## Déploiement

1. Importer le repo sur [Vercel](https://vercel.com/new)
2. Renseigner les variables d'environnement Supabase et Stripe en production
3. Configurer le webhook Stripe vers `https://<votre-domaine>/api/webhooks` (voir la section « État du projet » ci-dessus avant d'activer ce webhook en production)
4. Redéployer après ajout des variables (sans utiliser le cache de build existant)

## Licence

MIT