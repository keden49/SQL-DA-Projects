-- view of customers

 SELECT name, city 
 FROM customers
 LIMIT 5;

-- view of restaurants

SELECT name, cuisine
FROM restaurants
LIMIT 5;

-- 1. Use UPPER() on the name column and alias it as 'Customer Name'.

 SELECT UPPER(name) AS Customer_Name
 FROM customers
 LIMIT 5;


-- 2. Use TRIM() on the city column to remove any leading or trailing spaces, then apply LOWER() and alias it as 'City'.

SELECT LOWER(TRIM(city)) AS City
FROM customers
LIMIT 5;

-- 3. Use CONCAT() to combine the cleaned name and city into a single column in the format 'NAME — city'. Alias it as 'Customer Label'.

 SELECT CONCAT(name, ' - ', city) AS Customer_Label
 FROM customers
 LIMIT 5;
-- write a SQL query that builds a single reporting label column for each order. 
-- The label should read: 'Order #[order_id]: [item_name] x[quantity] @ [price] USD'. 
-- Use CAST() to convert order_id, quantity, and price to CHAR where needed before concatenating. Alias the result as 'Order Summary'. 

SELECT 
    CONCAT(
        'Order #', CAST(order_id AS CHAR), 
        ': ', item_name, 
        ' x', CAST(quantity AS CHAR), 
        ' @ ', CAST(price AS CHAR), ' USD'
    ) AS `Order Summary`
FROM 
    orders;
    

-- Using the FoodHub orders table in MySQL Workbench, write a single SQL query that returns:
-- 1. order_id and order_date.
-- 2. The year, month, and day extracted from order_date as separate columns aliased as 'Year', 'Month', and 'Day'.
-- 3. The number of days between order_date and today using DATEDIFF(), aliased as 'Days Ago'.
-- 4. A simulated estimated delivery date by adding 3 days to the order_date using DATE_ADD(), aliased as 'Est. Delivery'.
-- Add a single-line SQL comment above each DateTime function explaining what it extracts or calculates. Order results by order_date ascending.

SELECT order_id, order_date,
YEAR(order_date) AS Year, MONTH(order_date) AS Month, DAY(order_date) AS Day,
DATEDIFF(CURRENT_DATE,order_date) as Days_Ago,
DATE_ADD(order_date, INTERVAL 3 DAY) AS EstDelivery
FROM orders;



