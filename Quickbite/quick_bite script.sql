-- ============================================================
-- QuickBite Database Seed Script
-- QuickBite is a rival food-delivery platform to FoodHub.
-- Some customers and restaurants overlap between the two platforms.
-- Used in: Practice Exercise: Joins and Set Operations
-- ============================================================

CREATE DATABASE IF NOT EXISTS quickbite;
USE quickbite;

-- ------------------------------------------------------------
-- Table: restaurants
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS restaurants (
    restaurant_id INT PRIMARY KEY,
    name          VARCHAR(100),
    cuisine       VARCHAR(50),
    avg_rating    DECIMAL(3,1)
);

INSERT INTO restaurants VALUES
(1,  'Dragon Palace',         'Chinese',      4.1),
(2,  'La Bella Italia',       'Italian',      4.8),
(3,  'Sushi Sora',            'Japanese',     4.5),
(4,  'The Jollof Kitchen',    'West African', 4.3),
(5,  'Spice Route',           'Indian',       4.0),
(6,  'Burger Barn',           'American',     3.9),
(7,  'Taco Fiesta',           'Mexican',      4.2),
(8,  'Cape Malay Kitchen',    'South African',4.6);

-- ------------------------------------------------------------
-- Table: customers
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY,
    name        VARCHAR(100),
    city        VARCHAR(50)
);

INSERT INTO customers VALUES
(1,  'Fatima Al-Rashid', 'Nairobi'),
(2,  'Zanele Dube',      'Lagos'),
(3,  'Priya Nair',       'Nairobi'),
(4,  'Liam Okonkwo',     'Accra'),
(5,  'Aisha Conteh',     'Lagos'),
(6,  'Nadia Osei',       'Accra'),
(7,  'Tariq Hassan',     'Nairobi'),
(8,  'Yemi Adeyemi',     'Lagos');

-- ------------------------------------------------------------
-- Table: orders
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS orders (
    order_id      INT PRIMARY KEY,
    customer_id   INT,
    restaurant_id INT,
    item_name     VARCHAR(100),
    quantity      INT,
    price         DECIMAL(6,2),
    order_date    DATE,
    FOREIGN KEY (customer_id)   REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

INSERT INTO orders VALUES
(1,  1, 1, 'Kung Pao Noodles',         2, 11.00, '2024-01-05'),
(2,  1, 2, 'Spaghetti Carbonara',      1, 18.00, '2024-01-07'),
(3,  2, 3, 'Salmon Sashimi',           2, 19.00, '2024-01-09'),
(4,  2, 4, 'Egusi Soup',               1, 12.00, '2024-01-11'),
(5,  3, 5, 'Butter Chicken',           2,  9.50, '2024-01-13'),
(6,  3, 6, 'Double Smash Burger',      1, 14.00, '2024-01-15'),
(7,  4, 7, 'Chicken Tacos',            3, 15.00, '2024-01-17'),
(8,  5, 8, 'Bobotie',                  1, 17.00, '2024-01-19'),
(9,  6, 1, 'Dim Sum Basket',           2, 13.50, '2024-01-21'),
(10, 6, 2, 'Margherita Pizza',         1, 14.00, '2024-01-23'),
(11, 7, 3, 'Tuna Roll',                2, 16.00, '2024-01-25'),
(12, 7, 7, 'Beef Burrito',             1, 13.00, '2024-01-27'),
(13, 8, 4, 'Jollof Rice and Chicken',  2, 16.50, '2024-01-29'),
(14, 8, 6, 'BBQ Ribs',                 1, 22.00, '2024-01-30');
