-- CREATE SEQUENCE
CREATE SEQUENCE product_id_seq START 1;

-- CREATE TABLE
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    status VARCHAR(1) DEFAULT '1',
    created_at TIMESTAMP DEFAULT now(),
    name VARCHAR(255) DEFAULT NULL,
    slug VARCHAR(255) DEFAULT NULL,
    image VARCHAR(255) DEFAULT NULL,
    price NUMERIC(10,2) DEFAULT NULL,
    qty INTEGER
);

-- INSERT
INSERT INTO "products" ("name", "slug", "image", "price", "qty") VALUES ('Product 1 pcs', 'product-1-pcs', '1.jpg', '5200.00', 100);
INSERT INTO "products" ("name", "slug", "image", "price", "qty") VALUES ('Product 2 (4pcs)', 'product-4-pcs', '2.jpg', '9800.00', 100);
INSERT INTO "products" ("name", "slug", "image", "price", "qty") VALUES ('Product 3 (lusin)', 'product-lusin', '3.jpg', '6200.00', 200);
