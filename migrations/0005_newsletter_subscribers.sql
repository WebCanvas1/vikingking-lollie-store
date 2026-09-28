CREATE TABLE IF NOT EXISTS newsletter_subscribers (
  id TEXT PRIMARY KEY,
  email TEXT NOT NULL UNIQUE COLLATE NOCASE,
  status TEXT NOT NULL DEFAULT 'subscribed' CHECK (status IN ('subscribed','unsubscribed')),
  source TEXT NOT NULL DEFAULT 'website',
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  unsubscribed_at TEXT
);

CREATE INDEX IF NOT EXISTS idx_newsletter_subscribers_status_created
  ON newsletter_subscribers(status, created_at DESC);
