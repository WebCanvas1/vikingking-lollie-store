export interface Env {
  DB: D1Database;
  MEDIA_BUCKET: R2Bucket;
  ASSETS: Fetcher;
  APP_URL: string;
  STRIPE_SECRET_KEY: string;
  STRIPE_WEBHOOK_SECRET: string;
  RESEND_API_KEY?: string;
  ORDER_EMAIL_FROM?: string;
  ORDER_EMAIL_REPLY_TO?: string;
  ADMIN_ORDER_EMAIL?: string;
  SESSION_SECRET: string;
  ADMIN_SETUP_SECRET: string;
  TURNSTILE_SITE_KEY?: string;
  TURNSTILE_SECRET_KEY?: string;
  GA4_MEASUREMENT_ID?: string;
}
