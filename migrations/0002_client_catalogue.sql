PRAGMA foreign_keys = ON;

-- Replace the demonstration catalogue with the client's confirmed offers.
UPDATE products SET active = 0, updated_at = CURRENT_TIMESTAMP;
UPDATE jar_sizes SET available = 0, updated_at = CURRENT_TIMESTAMP;

INSERT INTO categories (id,name,slug,image_url,active,display_order,created_at,updated_at)
VALUES
  ('cat-jars','Lollie Mix Jars','lollie-mix-jars',NULL,1,1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('cat-multibuy','Multi-buy Offers','multi-buy-offers',NULL,1,2,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('cat-bundles','Value Bundles','value-bundles',NULL,1,3,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
ON CONFLICT(id) DO UPDATE SET name=excluded.name,slug=excluded.slug,active=1,display_order=excluded.display_order,updated_at=CURRENT_TIMESTAMP;

INSERT INTO products (id,name,slug,sku,price_cents,sale_price_cents,description,short_description,image_url,stock,low_stock_threshold,ingredients,allergens,dietary_labels,featured,best_seller,active,display_order,created_at,updated_at)
VALUES
  ('offer-550-1','550ml Lollie Mix Jar','550ml-lollie-mix-jar','VK-550-1',900,NULL,'One 550ml lollie mix jar.','1 × 550ml jar','/hero-jar.webp',100,5,'Ingredients vary by selected mix.','Allergen information varies by selected mix.','',1,1,1,1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('offer-550-2','Two 550ml Lollie Mix Jars','two-550ml-lollie-mix-jars','VK-550-2',1300,NULL,'Two 550ml lollie mix jars.','2 × 550ml jars','/hero-jar.webp',100,5,'Ingredients vary by selected mix.','Allergen information varies by selected mix.','',1,0,1,2,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('offer-550-3','Three 550ml Lollie Mix Jars','three-550ml-lollie-mix-jars','VK-550-3',1900,NULL,'Three 550ml lollie mix jars.','3 × 550ml jars','/hero-jar.webp',100,5,'Ingredients vary by selected mix.','Allergen information varies by selected mix.','',1,0,1,3,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('offer-700-1','700ml Lollie Mix Jar','700ml-lollie-mix-jar','VK-700-1',1500,NULL,'One 700ml lollie mix jar.','1 × 700ml jar','/hero-jar.webp',100,5,'Ingredients vary by selected mix.','Allergen information varies by selected mix.','',1,0,1,4,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('offer-700-2','Two 700ml Lollie Mix Jars','two-700ml-lollie-mix-jars','VK-700-2',1900,NULL,'Two 700ml lollie mix jars.','2 × 700ml jars','/hero-jar.webp',100,5,'Ingredients vary by selected mix.','Allergen information varies by selected mix.','',1,0,1,5,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('offer-large-1','Large Lollie Mix Jar','large-lollie-mix-jar','VK-LARGE-1',1600,NULL,'One large lollie mix jar.','1 × large jar','/hero-jar.webp',100,5,'Ingredients vary by selected mix.','Allergen information varies by selected mix.','',1,0,1,6,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('offer-large-2','Two Large Lollie Mix Jars','two-large-lollie-mix-jars','VK-LARGE-2',1900,NULL,'Two large lollie mix jars.','2 × large jars','/hero-jar.webp',100,5,'Ingredients vary by selected mix.','Allergen information varies by selected mix.','',1,0,1,7,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('offer-large-3','Three Large Lollie Mix Jars','three-large-lollie-mix-jars','VK-LARGE-3',2200,NULL,'Three large lollie mix jars.','3 × large jars','/hero-jar.webp',100,5,'Ingredients vary by selected mix.','Allergen information varies by selected mix.','',1,0,1,8,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('offer-1l-1','1L Lollie Mix Jar','1l-lollie-mix-jar','VK-1L-1',1400,NULL,'One 1 litre lollie mix jar.','1 × 1L jar','/hero-jar.webp',100,5,'Ingredients vary by selected mix.','Allergen information varies by selected mix.','',1,1,1,9,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('offer-1l-2','Two 1L Lollie Mix Jars','two-1l-lollie-mix-jars','VK-1L-2',1800,NULL,'Two 1 litre lollie mix jars.','2 × 1L jars','/hero-jar.webp',100,5,'Ingredients vary by selected mix.','Allergen information varies by selected mix.','',1,0,1,10,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('offer-1l-3','Three 1L Lollie Mix Jars','three-1l-lollie-mix-jars','VK-1L-3',3000,NULL,'Three 1 litre lollie mix jars.','3 × 1L jars','/hero-jar.webp',100,5,'Ingredients vary by selected mix.','Allergen information varies by selected mix.','',1,0,1,11,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('offer-3l-1','3L Lollie Mix Jar','3l-lollie-mix-jar','VK-3L-1',2200,NULL,'One 3 litre lollie mix jar.','1 × 3L jar','/hero-jar.webp',100,5,'Ingredients vary by selected mix.','Allergen information varies by selected mix.','',1,0,1,12,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('offer-3l-2','Two 3L Lollie Mix Jars','two-3l-lollie-mix-jars','VK-3L-2',2600,NULL,'Two 3 litre lollie mix jars.','2 × 3L jars','/hero-jar.webp',100,5,'Ingredients vary by selected mix.','Allergen information varies by selected mix.','',1,0,1,13,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('offer-3l-3','Three 3L Lollie Mix Jars','three-3l-lollie-mix-jars','VK-3L-3',3200,NULL,'Three 3 litre lollie mix jars.','3 × 3L jars','/hero-jar.webp',100,5,'Ingredients vary by selected mix.','Allergen information varies by selected mix.','',1,0,1,14,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('offer-bundle-5','Five Jar Mixed Bundle','five-jar-mixed-bundle','VK-BUNDLE-5',5000,NULL,'Three 1L jars and two 550ml jars.','3 × 1L + 2 × 550ml jars','/hero-jar.webp',100,5,'Ingredients vary by selected mix.','Allergen information varies by selected mix.','',1,1,1,15,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('offer-bundle-10','Ten Jar Mixed Bundle','ten-jar-mixed-bundle','VK-BUNDLE-10',10000,NULL,'Four 1L jars and six 550ml jars.','4 × 1L + 6 × 550ml jars','/hero-jar.webp',100,5,'Ingredients vary by selected mix.','Allergen information varies by selected mix.','',1,1,1,16,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
ON CONFLICT(id) DO UPDATE SET name=excluded.name,slug=excluded.slug,sku=excluded.sku,price_cents=excluded.price_cents,sale_price_cents=NULL,description=excluded.description,short_description=excluded.short_description,image_url=excluded.image_url,stock=excluded.stock,ingredients=excluded.ingredients,allergens=excluded.allergens,featured=excluded.featured,best_seller=excluded.best_seller,active=1,display_order=excluded.display_order,updated_at=CURRENT_TIMESTAMP;

DELETE FROM product_categories WHERE product_id LIKE 'offer-%';
INSERT INTO product_categories (product_id,category_id) VALUES
  ('offer-550-1','cat-jars'),('offer-550-2','cat-multibuy'),('offer-550-3','cat-multibuy'),
  ('offer-700-1','cat-jars'),('offer-700-2','cat-multibuy'),
  ('offer-large-1','cat-jars'),('offer-large-2','cat-multibuy'),('offer-large-3','cat-multibuy'),
  ('offer-1l-1','cat-jars'),('offer-1l-2','cat-multibuy'),('offer-1l-3','cat-multibuy'),
  ('offer-3l-1','cat-jars'),('offer-3l-2','cat-multibuy'),('offer-3l-3','cat-multibuy'),
  ('offer-bundle-5','cat-bundles'),('offer-bundle-10','cat-bundles');

INSERT INTO jar_sizes (id,name,volume,description,price_cents,image_url,max_selections,available,display_order,created_at,updated_at)
VALUES
  ('jar-client-550','550ml Jar','550ml','Build your own 550ml mix.',900,'/hero-jar.webp',6,1,1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('jar-client-700','700ml Jar','700ml','Build your own 700ml mix.',1500,'/hero-jar.webp',7,1,2,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('jar-client-large','Large Jar','Large','Build your own large mix.',1600,'/hero-jar.webp',8,1,3,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('jar-client-1l','1L Jar','1L','Build your own 1 litre mix.',1400,'/hero-jar.webp',8,1,4,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
  ('jar-client-3l','3L Jar','3L','Build your own 3 litre mix.',2200,'/hero-jar.webp',10,1,5,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
ON CONFLICT(id) DO UPDATE SET name=excluded.name,volume=excluded.volume,description=excluded.description,price_cents=excluded.price_cents,image_url=excluded.image_url,max_selections=excluded.max_selections,available=1,display_order=excluded.display_order,updated_at=CURRENT_TIMESTAMP;

INSERT INTO shipping_settings (id,method,label,rate_cents,free_threshold_cents,enabled,display_order)
VALUES
  ('ship-standard','standard','Standard postage',850,NULL,1,1),
  ('ship-express','express','Express postage',950,NULL,1,2)
ON CONFLICT(method) DO UPDATE SET label=excluded.label,rate_cents=excluded.rate_cents,free_threshold_cents=NULL,enabled=1,display_order=excluded.display_order;

INSERT INTO site_settings (key,value,updated_at) VALUES
  ('contact_email','lensairways1@icloud.com',CURRENT_TIMESTAMP),
  ('shipping_note','Standard and express postage are available Australia wide. Rates depend on the selected jar offer.',CURRENT_TIMESTAMP)
ON CONFLICT(key) DO UPDATE SET value=excluded.value,updated_at=CURRENT_TIMESTAMP;

UPDATE faqs SET answer='Yes. Standard and express postage are available Australia wide. The applicable rate is shown securely at checkout.' WHERE id='faq-3';
