ALTER TABLE products ADD COLUMN standard_postage_cents INTEGER;
ALTER TABLE products ADD COLUMN express_postage_cents INTEGER;

UPDATE products SET standard_postage_cents=850, express_postage_cents=950 WHERE sku LIKE 'VK-550-%';
UPDATE products SET standard_postage_cents=950, express_postage_cents=950 WHERE sku LIKE 'VK-700-%';
UPDATE products SET standard_postage_cents=850, express_postage_cents=950 WHERE sku LIKE 'VK-LARGE-%';
UPDATE products SET standard_postage_cents=800, express_postage_cents=950 WHERE sku LIKE 'VK-1L-%';
UPDATE products SET standard_postage_cents=800, express_postage_cents=950 WHERE sku LIKE 'VK-3L-%';
UPDATE products SET standard_postage_cents=850, express_postage_cents=950 WHERE sku='VK-BUNDLE-5';
UPDATE products SET standard_postage_cents=1500, express_postage_cents=1800 WHERE sku='VK-BUNDLE-10';
