USE quickbite;

-- The compliance team suspects some orders in both systems were placed by ghost accounts—order records with no matching 
-- customer entry. Use an INNER JOIN to surface only orders with a verified customer on both platforms.

SELECT *
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;


SELECT *
FROM foodhub.orders o
JOIN customers c ON o.customer_id = c.customer_id;


-- 1. Use UNION to produce a single combined list of all unique customer names across both platforms. Alias the result as 'All Customers'. Explain what UNION does to duplicate names.
-- 2. Use INTERSECT to return only customer names that appear on both platforms. Alias the result as 'Shared Customers'.
-- 3. Use EXCEPT to return customer names that appear on FoodHub but not on QuickBite. Alias the result as 'FoodHub Exclusive'.
-- Add a single-line comment above each set operator explaining what it returns.

SELECT * 
FROM 
(SELECT name
FROM foodhub.customers c

UNION 

SELECT name
FROM customers c)
ALL_customers;
 
 -- intersect 

SELECT F.name AS shared_customers 
FROM foodhub.customers F

JOIN quickbite.customers ON F.name = quickbite.customers.name;


-- Except 


SELECT F.name AS exclusive_customers
FROM foodhub.customers F
WHERE name NOT IN (SELECT name FROM quickbite.customers);


-- 1. Uses an INNER JOIN on restaurant name to return only restaurants that appear on both platforms.
-- 2. Returns the restaurant name, FoodHub avg_rating aliased as 'FoodHub Rating', and QuickBite avg_rating aliased as 'QuickBite Rating'.
-- 3. Adds a calculated column aliased as 'Rating Difference' showing the absolute difference between the two ratings.
-- 4. Orders the results by Rating Difference in descending order.
-- Explain in a comment why you joined on name rather than restaurant_id.

SELECT *
FROM foodhub.restaurants f
JOIN quickbite.restaurants r ON f.name = r.name;

SELECT f.name, f.avg_rating AS foodhub_rating, r.avg_rating AS QuickBite_Rating
FROM foodhub.restaurants f
JOIN quickbite.restaurants r ON f.name = r.name;

SELECT f.name, f.avg_rating AS foodhub_rating, r.avg_rating AS QuickBite_Rating, ABS(f.avg_rating - r.avg_rating) AS Rating_difference
FROM foodhub.restaurants f
JOIN quickbite.restaurants r ON f.name = r.name;



SELECT f.name, f.avg_rating AS foodhub_rating, r.avg_rating AS QuickBite_Rating, ABS(f.avg_rating - r.avg_rating) AS Rating_difference
FROM foodhub.restaurants f
JOIN quickbite.restaurants r ON f.name = r.name
ORDER BY Rating_difference DESC;


-- 1. Uses UNION, not UNION ALL, to combine all orders from both platforms and remove any identical rows.
-- 2. Wraps the UNION in a subquery and calculates total combined revenue as SUM(quantity * price), aliased as 'Total Combined Revenue'.
-- 3. Returns the total number of unique orders as COUNT(*), aliased as 'Total Orders'.
-- Explain in a comment what UNION is doing to prevent double-counting.

SELECT * 
FROM foodhub.orders 

UNION 

SELECT * 
FROM quickbite.orders;

SELECT SUM(quantity * price) AS Total_Orders
FROM (SELECT * 
FROM foodhub.orders 

UNION 

SELECT * 
FROM quickbite.orders) unison;

SELECT COUNT(*) AS Total_orders
FROM (SELECT * 
FROM foodhub.orders 

UNION 

SELECT * 
FROM quickbite.orders) unison


















 
 




