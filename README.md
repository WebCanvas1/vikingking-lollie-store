# VikingKing Lollie Pick n Mix

Production-ready ecommerce foundation for VikingKing, designed to run independently on Cloudflare. Hatchable is not required.

## Stack

- React, TypeScript and Vite frontend
- Cloudflare Worker backend and static asset hosting
- Cloudflare D1 database
- Cloudflare R2 media storage
- Stripe Checkout and signed webhooks
- PBKDF2 admin passwords and secure HTTP-only sessions
- Optional Cloudflare Turnstile verification

## Important before launch

All current products, prices, ingredients, allergen details, shipping rates, testimonials and policy text are demo content. The store owner must confirm them before accepting live orders.

## 1. Clone and install

```bash
git clone https://github.com/YOUR_ACCOUNT/YOUR_REPOSITORY.git
cd YOUR_REPOSITORY
npm install
```

Use Node.js 22 or newer.

## 2. Create the D1 database

```bash
npx wrangler login
npx wrangler d1 create vikingking-store
```

Copy the returned database UUID into `wrangler.jsonc`, replacing:

```json
"database_id": "00000000-0000-0000-0000-000000000000"
```

## 3. Apply database migrations

For local development:

```bash
npm run db:local
```

For production:

```bash
npm run db:remote
```

The initial migration creates and seeds products, lollies, jar sizes, categories, shipping settings, FAQs and website settings. Demo pricing must be confirmed.

## 4. Create the R2 bucket

```bash
npx wrangler r2 bucket create vikingking-media
```

The Worker exposes stored objects at `/media/<R2_KEY>`. Admin uploads accept JPEG, PNG, WebP or AVIF files up to 5 MB.

## 5. Configure local secrets

```bash
cp .dev.vars.example .dev.vars
```

Add Stripe test credentials and long random secrets to `.dev.vars`. This file is ignored by Git.

Generate secrets with:

```bash
openssl rand -base64 48
```

Use a different generated value for `SESSION_SECRET` and `ADMIN_SETUP_SECRET`.

## 6. Configure production secrets

```bash
npx wrangler secret put STRIPE_SECRET_KEY
npx wrangler secret put STRIPE_WEBHOOK_SECRET
npx wrangler secret put SESSION_SECRET
npx wrangler secret put ADMIN_SETUP_SECRET
```

If Turnstile is enabled:

```bash
npx wrangler secret put TURNSTILE_SECRET_KEY
```

Never commit secret values.

## 7. Update the public application URL

Change `APP_URL` in `wrangler.jsonc` from localhost to the final Workers URL or custom domain before production checkout:

```json
"APP_URL": "https://www.example.com.au"
```

Also replace `YOUR_DOMAIN` in `public/robots.txt` and `public/sitemap.xml`.

## 8. Create the first admin

Deploy once, then call the protected one-time setup route:

```bash
curl -X POST "https://YOUR_DOMAIN/api/admin/setup" \
  -H "Content-Type: application/json" \
  -H "X-Setup-Secret: YOUR_ADMIN_SETUP_SECRET" \
  --data '{"email":"admin@example.com","password":"USE-A-LONG-UNIQUE-PASSWORD"}'
```

The route refuses to create another admin after the first account exists. Admin access is available at `/admin`.

## 9. Configure Stripe

1. Open Stripe Dashboard and remain in test mode.
2. Go to Developers > Webhooks.
3. Add `https://YOUR_DOMAIN/api/stripe/webhook`.
4. Subscribe to `checkout.session.completed`.
5. Copy the signing secret into `STRIPE_WEBHOOK_SECRET` using `wrangler secret put`.
6. Complete a test purchase with Stripe test card `4242 4242 4242 4242`.
7. Confirm the order changes to `paid` in D1 and appears in admin.

The Worker reads all prices from D1, validates stock and jar selection limits, creates the Stripe Checkout Session and verifies webhook signatures. Processed Stripe event IDs are stored to prevent duplicate webhook processing.

## 10. Run locally

Build the frontend and start the full Worker runtime:

```bash
npm run preview
```

Open the URL printed by Wrangler. Local D1 and R2 data are separate from production.

## 11. Deploy manually

```bash
npm run deploy
```

## 12. Deploy automatically from GitHub

The repository includes `.github/workflows/deploy.yml`.

In GitHub repository Settings > Secrets and variables > Actions, add:

- `CLOUDFLARE_API_TOKEN`
- `CLOUDFLARE_ACCOUNT_ID`

The API token needs Workers Scripts edit, D1 edit and R2 edit permissions for the target account. A push to `main` will build and deploy.

## 13. Add a custom domain

In Cloudflare Dashboard:

1. Open Workers & Pages.
2. Open `vikingking-lollie-store`.
3. Open Domains & Routes.
4. Add the final custom domain.
5. Update `APP_URL`, Stripe webhook URL, robots.txt and sitemap.xml.

## Production checklist

- Confirm product and jar prices with the owner.
- Confirm ingredients, dietary labels and allergen warnings.
- Replace all demo images and content.
- Confirm shipping rates, service areas and free-shipping threshold.
- Review Privacy, Terms, Shipping, Returns and Food Information with the owner.
- Create the first admin and test session expiry.
- Enable Turnstile for admin login and contact form if desired.
- Test R2 image uploads.
- Run Stripe test checkout and verify the webhook updates the order once.
- Test out-of-stock products and unavailable lollies.
- Test mobile navigation, custom mix limits and cart persistence.
- Configure GA4 and Meta Pixel only with real IDs.
- Switch Stripe from test to live credentials only after final approval.

## Useful commands

```bash
npm run build
npm run preview
npm run deploy
npx wrangler tail
npx wrangler d1 execute vikingking-store --remote --command "SELECT * FROM orders ORDER BY created_at DESC LIMIT 10"
```
