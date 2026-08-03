-- Use ROW_NUMBER() to assign a unique rank to each order within each product category, 
-- ordered by total order value (quantity * unit_price) descending. Join orders and products to get the category. 
-- Return the category, order_id, customer_id, total order value, and the row number.

SELECT p.category, o.order_id, customer_id, (quantity * o.unit_price) AS total_order_value,
ROW_NUMBER() OVER (partition by p.category ORDER BY (quantity * o.unit_price) desc) AS rowno
FROM orders o
JOIN products p ON o.product_id= p.product_id;

-- Use RANK() to rank customers by their total spend (SUM of quantity * unit_price) across all orders. 
-- Return customer_id, total spend, and their rank. Order the results by rank ascending.

SELECT customer_id, (quantity * unit_price) AS total_spend, 
RANK() OVER (ORDER BY (quantity * unit_price))
FROM orders;


-- Using the RetailEdge database in MySQL, write a SQL query that uses the LAG() window function on the orders table. 
-- For each order, return the order_id, order_date, the total order value (quantity * unit_price) aliased as 'order_value', 
-- and the total order value from the previous row ordered by order_date, aliased as 'previous_order_value'. 
-- Order the results by order_date ascending. Explain what value LAG() returns for the very first row and why.

SELECT order_id, order_date, (quantity * unit_price) AS order_value, 
LAG((quantity * unit_price), 1) OVER(ORDER BY order_date) AS previous_order_value
FROM orders;

-- Using the RetailEdge database in MySQL, extend the LAG() query from the previous step. 
-- For each order, return the order_id, order_date, the total order value (quantity * unit_price) aliased as 'order_value', 
-- the previous order value using LAG() aliased as 'previous_order_value', 
-- and a calculated column aliased as 'rate_of_change' that expresses the percentage change from the previous order value to the current one. 
-- Use the formula: ((order_value - previous_order_value) / previous_order_value) * 100. Round the result to 2 decimal places. 
-- Order by order_date ascending. Add a single-line SQL comment above the rate_of_change calculation explaining the formula.

SELECT order_id, order_date, (quantity * unit_price) AS order_value, 
LAG((quantity * unit_price), 1) OVER(ORDER BY order_date) AS previous_order_value,
ROUND((quantity * unit_price - LAG((quantity * unit_price), 1) OVER(ORDER BY order_date) / LAG((quantity * unit_price), 1) OVER(ORDER BY order_date) * 100), 2) AS rate_of_change
FROM orders;



