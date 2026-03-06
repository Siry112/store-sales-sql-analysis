-- =====================================================
-- Store Sales Dataset
-- Tables:
-- customers
-- products
-- orders
-- order_items
--
-- Revenue formula:
-- quantity * unit_price
-- =====================================================

DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS order_items;

CREATE TABLE customers (
    customer_id INTEGER,
    customer_name TEXT,
    country TEXT,
    signup_year INTEGER
);

CREATE TABLE products (
    product_id INTEGER,
    product_name TEXT,
    category TEXT
);

CREATE TABLE orders (
    order_id INTEGER,
    customer_id INTEGER,
    order_date TEXT
);

CREATE TABLE order_items (
    order_item_id INTEGER,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    unit_price INTEGER
);

INSERT INTO customers VALUES
(1, 'Alice', 'USA', 2022),
(2, 'Bob', 'USA', 2023),
(3, 'Carol', 'Canada', 2021),
(4, 'Dave', 'Canada', 2023),
(5, 'Eva', 'Germany', 2022),
(6, 'Frank', 'Germany', 2024);

INSERT INTO products VALUES
(1, 'Protein Powder', 'Supplements'),
(2, 'Creatine', 'Supplements'),
(3, 'Shaker Bottle', 'Accessories'),
(4, 'Resistance Bands', 'Equipment'),
(5, 'Yoga Mat', 'Equipment');

INSERT INTO orders VALUES
(101, 1, '2024-01-05'),
(102, 1, '2024-02-10'),
(103, 2, '2024-01-15'),
(104, 3, '2024-01-20'),
(105, 4, '2024-03-01'),
(106, 5, '2024-03-10');

INSERT INTO order_items VALUES
(1, 101, 1, 1, 100),
(2, 101, 3, 2, 20),

(3, 102, 2, 1, 60),

(4, 103, 1, 1, 100),
(5, 103, 3, 1, 20),

(6, 104, 2, 2, 60),

(7, 105, 4, 1, 40),
(8, 105, 5, 1, 30),

(9, 106, 1, 1, 100),
(10, 106, 2, 1, 60);