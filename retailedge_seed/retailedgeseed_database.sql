-- ============================================================
-- RetailEdge Database Seed Script
-- Run this script to create and populate the RetailEdge database
-- used in the Practice Exercise: Numeric Functions and Aggregations
-- ============================================================

CREATE DATABASE IF NOT EXISTS retailedge;
USE retailedge;

-- ------------------------------------------------------------
-- Table: products
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS products (
    product_id     INT PRIMARY KEY,
    name           VARCHAR(100),
    category       VARCHAR(50),
    unit_price     DECIMAL(8,2),
    stock_quantity INT
);

INSERT INTO products VALUES
(1,  'Wireless Headphones',  'Electronics',  89.99,  120),
(2,  'USB-C Hub',            'Electronics',  34.99,  200),
(3,  'Desk Lamp',            'Home Office',  24.99,  150),
(4,  'Ergonomic Chair',      'Home Office', 299.99,   40),
(5,  'Yoga Mat',             'Sports',       19.99,  300),
(6,  'Resistance Bands',     'Sports',        9.99,  500),
(7,  'Blender',              'Kitchen',      49.99,   80),
(8,  'Air Fryer',            'Kitchen',      99.99,   60),
(9,  'Notebook Set',         'Stationery',    8.99,  400),
(10, 'Ballpoint Pens 10pk',  'Stationery',    4.99,  600);

-- ------------------------------------------------------------
-- Table: customers
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS customers (
    customer_id    INT PRIMARY KEY,
    name           VARCHAR(100),
    region         VARCHAR(50),
    membership_tier VARCHAR(20)
);

INSERT INTO customers VALUES
(1,  'Amara Osei',       'West Africa',  'Gold'),
(2,  'Fatima Al-Rashid', 'East Africa',  'Silver'),
(3,  'Kofi Mensah',      'West Africa',  'Bronze'),
(4,  'Zanele Dube',      'Southern Africa', 'Gold'),
(5,  'Emeka Eze',        'West Africa',  'Silver'),
(6,  'Priya Nair',       'East Africa',  'Gold'),
(7,  'David Kimani',     'East Africa',  'Bronze'),
(8,  'Sofia Andrade',    'Southern Africa', 'Silver'),
(9,  'Liam Okonkwo',     'West Africa',  'Bronze'),
(10, 'Aisha Conteh',     'West Africa',  'Gold');

-- ------------------------------------------------------------
-- Table: orders
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS orders (
    order_id    INT PRIMARY KEY,
    customer_id INT,
    product_id  INT,
    quantity    INT,
    unit_price  DECIMAL(8,2),
    discount    DECIMAL(4,2),
    order_date  DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id)  REFERENCES products(product_id)
);

INSERT INTO orders VALUES
(1,  1,  1,  2,  89.99, 0.10, '2024-01-05'),
(2,  1,  3,  1,  24.99, 0.00, '2024-01-06'),
(3,  2,  5,  4,  19.99, 0.05, '2024-01-07'),
(4,  2,  6,  2,   9.99, 0.00, '2024-01-08'),
(5,  3,  7,  1,  49.99, 0.10, '2024-01-09'),
(6,  3,  9,  5,   8.99, 0.00, '2024-01-10'),
(7,  4,  4,  1, 299.99, 0.15, '2024-01-11'),
(8,  4,  2,  3,  34.99, 0.05, '2024-01-12'),
(9,  5,  8,  2,  99.99, 0.10, '2024-01-13'),
(10, 5,  10, 6,   4.99, 0.00, '2024-01-14'),
(11, 6,  1,  1,  89.99, 0.00, '2024-01-15'),
(12, 6,  5,  3,  19.99, 0.05, '2024-01-16'),
(13, 6,  3,  2,  24.99, 0.00, '2024-01-17'),
(14, 7,  6,  5,   9.99, 0.00, '2024-01-18'),
(15, 7,  9,  3,   8.99, 0.05, '2024-01-19'),
(16, 8,  7,  1,  49.99, 0.10, '2024-01-20'),
(17, 8,  2,  2,  34.99, 0.00, '2024-01-21'),
(18, 9,  8,  1,  99.99, 0.00, '2024-01-22'),
(19, 9,  10, 4,   4.99, 0.05, '2024-01-23'),
(20, 10, 4,  1, 299.99, 0.20, '2024-01-24'),
(21, 10, 1,  2,  89.99, 0.10, '2024-01-25'),
(22, 1,  6,  3,   9.99, 0.00, '2024-01-26'),
(23, 2,  8,  1,  99.99, 0.05, '2024-01-27'),
(24, 3,  2,  2,  34.99, 0.00, '2024-01-28'),
(25, 4,  5,  6,  19.99, 0.10, '2024-01-29');
