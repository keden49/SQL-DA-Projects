-- You have inherited a database from a previous analyst who stored everything in a single flat table called foodhub\_flat. 
-- Every order, customer detail, and restaurant attribute — all in one place, repeating endlessly. 
-- Your task is to decompose this table into a properly normalised relational schema, define the right keys, and produce and evaluate an ERD. 


USE foodhub_legacy;

-- dercomposing orders 
CREATE TABLE orders 
AS SELECT order_id,item_name,quantity,price, order_date FROM foodhub_flat;



-- creating customers table

CREATE TABLE Customers AS 
SELECT 
    ROW_NUMBER() OVER (ORDER BY customer_name, customer_city) AS CustomerID,
    customer_name AS CustomerName,
    customer_city AS City,
    membership_tier AS MembershipTier
FROM foodhub_legacy.foodhub_flat
GROUP BY customer_name, customer_city, membership_tier;



ALTER TABLE Customers ADD PRIMARY KEY (CustomerID);

SELECT *
FROM Customers;


-- creating restaurants table
CREATE TABLE restraunts AS 

SELECT ROW_NUMBER() OVER (ORDER BY restaurant_name) AS restaurant_id,
restaurant_name,
cuisine,
avg_rating
FROM  foodhub_legacy.foodhub_flat

GROUP BY restaurant_name,cuisine,avg_rating;

ALTER TABLE restraunts ADD PRIMARY KEY (restaurant_id);




-- creating menu items 

CREATE TABLE menu_items AS 

SELECT 
ROW_NUMBER() OVER (ORDER BY r.restaurant_id, item_name) AS ItemID,
r.restaurant_id,
item_name,
price

FROM foodhub_flat f
JOIN restraunts r ON f.restaurant_name = r.restaurant_name

GROUP BY r.restaurant_id, item_name, price ;


