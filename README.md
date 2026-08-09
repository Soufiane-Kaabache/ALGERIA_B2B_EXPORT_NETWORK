# Algeria B2B Export Network

Plateforme B2B mettant en relation les acteurs du commerce d'export entre l'Algérie et la France : fournisseurs algériens, transporteurs (nationaux et internationaux), transitaires, grossistes/importateurs et commerçants au détail en France.

Catalogue strictement B2B : tous les acteurs référencés sont des entreprises.

## À propos

Le projet centralise :
- Fournisseurs Algérie — avec onboarding et validation KYC
- Transporteurs — nationaux (Algérie) et internationaux (Algérie → France)
- Transitaires
- Taux de change officiels — mise à jour automatique (taux officiel uniquement)
- Grossistes / importateurs en France de produits algériens
- Commerçants au détail en France
- Sociétés de livraison

**Modèle de paiement prévu :**
- Fournisseurs et transporteurs algériens : abonnement payé en dinars pour être référencés
- Clients internationaux (Europe, Amérique du Nord, Asie) : paiement via Stripe
- Commission prélevée sur chaque transaction, avec transferts de fonds via un compte bancaire dédié en France (BEA)

## Stack technique

- **Frontend / Backend** : Next.js 14 (App Router)
- **Base de données & Auth** : Supabase (PostgreSQL + Row Level Security)
- **Fonctions serveur** : Supabase Edge Functions (Deno)
- **Paiements** : Stripe (Checkout + Customer Portal)
- **Hébergement** : Vercel

## Développement local

Nécessite Docker (pour Supabase local).

\`\`\`bash
# Installer les dépendances
npm install

# Configurer les variables d'environnement
cp .env.local.example .env.local

# Démarrer Supabase en local
npm run supabase:start

# Lancer le serveur de développement
npm run dev
\`\`\`

Puis ouvrir http://localhost:3000.

## Déploiement

Le projet est lié à Vercel. Un `git push` sur la branche `main` déploie automatiquement la mise à jour en production.

## État du projet

Le schéma de données a été entièrement remplacé par le vrai modèle B2B (fournisseurs, transporteurs, transitaires, commandes multi-fournisseurs). Le webhook Stripe (`app/api/webhooks/route.ts`) doit encore être adapté à ce modèle (actuellement il correspond à l'ancien starter SaaS générique).