CREATE TABLE coupons (
  code TEXT PRIMARY KEY NOT NULL,
  kind TEXT NOT NULL CHECK (kind IN ('percent', 'fixed')),
  value INTEGER NOT NULL CHECK (value > 0 AND (kind <> 'percent' OR value <= 100)),
  active INTEGER NOT NULL DEFAULT 1 CHECK (active IN (0, 1))
);

ALTER TABLE orders ADD COLUMN coupon_code TEXT;
ALTER TABLE orders ADD COLUMN discount_cents INTEGER NOT NULL DEFAULT 0 CHECK (discount_cents >= 0);
