-- ============================================================
-- FoodHub Database Seed Script
-- Run this script to create and populate the FoodHub database
-- used in the Practice Exercise: Build and Troubleshoot Notebook Queries
-- ============================================================

CREATE DATABASE IF NOT EXISTS foodhub;
USE foodhub;

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
(1,  'Mama Rocks Burger',    'American',   4.5),
(2,  'Spice Route',          'Indian',     4.2),
(3,  'Dragon Palace',        'Chinese',    3.9),
(4,  'La Bella Italia',      'Italian',    4.7),
(5,  'Nairobi Grill House',  'Kenyan',     4.3),
(6,  'Sushi Sora',           'Japanese',   4.6),
(7,  'The Jollof Kitchen',   'West African', 4.1),
(8,  'Peri Peri Place',      'Portuguese', 3.8),
(9,  'Green Bowl',           NULL,         4.0),
(10, 'Street Bites',         NULL,         3.5);

-- ------------------------------------------------------------
-- Table: customers
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY,
    name        VARCHAR(100),
    city        VARCHAR(50)
);

INSERT INTO customers VALUES
(1,  'Amara Osei',       'Accra'),
(2,  'Fatima Al-Rashid', 'Nairobi'),
(3,  'Kofi Mensah',      'Accra'),
(4,  'Zanele Dube',      'Lagos'),
(5,  'Emeka Eze',        'Lagos'),
(6,  'Priya Nair',       'Nairobi'),
(7,  'David Kimani',     'Nairobi'),
(8,  'Sofia Andrade',    'Lagos'),
(9,  'Liam Okonkwo',     'Accra'),
(10, 'Aisha Conteh',     'Lagos');

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
(1,  1,  1,  'Classic Cheeseburger',    2, 18.00, '2024-01-10'),
(2,  1,  2,  'Butter Chicken',          1,  9.50, '2024-01-12'),
(3,  2,  3,  'Dim Sum Basket',          3, 22.50, '2024-01-13'),
(4,  2,  4,  'Margherita Pizza',        1, 14.00, '2024-01-14'),
(5,  3,  5,  'Nyama Choma Platter',     2, 20.00, '2024-01-15'),
(6,  3,  6,  'Salmon Sashimi',          1, 17.00, '2024-01-16'),
(7,  4,  7,  'Jollof Rice and Chicken', 2, 16.50, '2024-01-17'),
(8,  4,  8,  'Peri Peri Chicken',       1, 13.00, '2024-01-18'),
(9,  5,  9,  'Veggie Wrap',             1,  8.00, '2024-01-19'),
(10, 5,  10, 'Grilled Corn',            4,  6.00, '2024-01-20'),
(11, 6,  1,  'BBQ Bacon Burger',        1, 16.00, '2024-01-21'),
(12, 6,  2,  'Palak Paneer',            2, 11.00, '2024-01-22'),
(13, 7,  3,  'Kung Pao Noodles',        1,  9.00, '2024-01-23'),
(14, 7,  4,  'Spaghetti Carbonara',     2, 28.00, '2024-01-24'),
(15, 8,  5,  'Ugali and Sukuma',        3, 18.00, '2024-01-25'),
(16, 8,  6,  'Tuna Roll',               2, 19.00, '2024-01-26'),
(17, 9,  7,  'Egusi Soup',              1, 12.00, '2024-01-27'),
(18, 9,  8,  'Garlic Prawns',           2, 24.00, '2024-01-28'),
(19, 10, 9,  'Smoothie Bowl',           1,  7.50, '2024-01-29'),
(20, 10, 10, 'Plantain Chips',          5,  5.00, '2024-01-30');
