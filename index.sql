USE e_commerce;
CREATE TABLE categories (
 category_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(80) NOT NULL UNIQUE,
 description VARCHAR(255) NULL,
 CONSTRAINT chk_category_name CHECK (CHAR_LENGTH(TRIM(name)) > 0)
) ENGINE=InnoDB;

CREATE TABLE products (
 product_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 category_id INT UNSIGNED NOT NULL,
 sku VARCHAR(32) NOT NULL UNIQUE,
 name VARCHAR(120) NOT NULL,
 description TEXT NULL,
 price DECIMAL(10,2) NOT NULL,
 stock_qty INT UNSIGNED NOT NULL DEFAULT 0,
 image_url VARCHAR(255) NULL,
 is_active BOOLEAN NOT NULL DEFAULT TRUE,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT chk_product_price CHECK(price > 0),
 CONSTRAINT chk_product_name CHECK(CHAR_LENGTH(TRIM(name)) > 0),
 CONSTRAINT chk_product_stock CHECK(stock_qty >= 0),
 CONSTRAINT chk_product_active CHECK(is_active IN (0,1)),
 CONSTRAINT fk_product_category FOREIGN KEY(category_id) REFERENCES categories(category_id) ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=InnoDB;


CREATE TABLE customers (
 customer_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 full_name VARCHAR(100) NOT NULL,
 email VARCHAR(160) NOT NULL UNIQUE,
 phone VARCHAR(20) NOT NULL,
 shipping_address VARCHAR(255) NOT NULL,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT chk_customer_name CHECK(CHAR_LENGTH(TRIM(full_name)) > 0),
 CONSTRAINT chk_customer_email CHECK(email LIKE '%_@_%._%'),
 CONSTRAINT chk_customer_phone CHECK(CHAR_LENGTH(TRIM(phone)) > 0),
 CONSTRAINT chk_customer_address CHECK(CHAR_LENGTH(TRIM(shipping_address)) > 0)
) ENGINE=InnoDB;

CREATE TABLE orders (
 order_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 customer_id INT UNSIGNED NOT NULL,
 order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 status ENUM('placed','confirmed','shipped','delivered','cancelled') NOT NULL DEFAULT 'placed',
 total_amount DECIMAL(10,2) NOT NULL,
 cancelled_at DATETIME NULL,
 CONSTRAINT chk_order_total CHECK(total_amount >= 0),
 CONSTRAINT chk_order_cancelled_at CHECK((status = 'cancelled' AND cancelled_at IS NOT NULL) OR (status <> 'cancelled' AND cancelled_at IS NULL)),
 CONSTRAINT fk_order_customer FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE order_items (
 order_item_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 order_id INT UNSIGNED NOT NULL,
 product_id INT UNSIGNED NOT NULL,
 quantity INT UNSIGNED NOT NULL,
 unit_price DECIMAL(10,2) NOT NULL,
 line_total DECIMAL(10,2) NOT NULL,
 CONSTRAINT uq_order_product UNIQUE(order_id,product_id),
 CONSTRAINT chk_order_item_quantity CHECK(quantity > 0),
 CONSTRAINT chk_order_item_price CHECK(unit_price > 0),
 CONSTRAINT chk_order_item_total CHECK(line_total = quantity * unit_price),
 CONSTRAINT fk_item_order FOREIGN KEY(order_id) REFERENCES orders(order_id) ON DELETE RESTRICT ON UPDATE RESTRICT,
 CONSTRAINT fk_item_product FOREIGN KEY(product_id) REFERENCES products(product_id) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;



CREATE INDEX idx_products_category_active ON products(category_id, is_active);
CREATE INDEX idx_products_name ON products(name);
CREATE INDEX idx_orders_date_status ON orders(order_date, status);
CREATE INDEX idx_orders_customer_date ON orders(customer_id, order_date);
CREATE INDEX idx_order_items_product ON order_items(product_id);
-- FK indexes are automatically supplied when not already covered. Do not add redundant keys.

CREATE OR REPLACE VIEW vw_order_summary AS
SELECT o.order_id, o.order_date, o.status, c.customer_id, c.full_name AS customer_name,
       c.email, o.total_amount, COALESCE(SUM(oi.quantity),0) AS units,
       COUNT(oi.order_item_id) AS item_lines
FROM orders o JOIN customers c ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id,o.order_date,o.status,c.customer_id,c.full_name,c.email,o.total_amount;

CREATE OR REPLACE VIEW vw_delivered_sales AS
SELECT o.order_id, o.order_date, oi.product_id, p.name AS product_name,
       p.category_id, oi.quantity,oi.unit_price,oi.line_total
FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE o.status = 'delivered';
