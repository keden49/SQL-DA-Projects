-- Rank all the orders of a specific customer from the most recent to the least recent using window functions. Assume that the customer ID is 'ALFKI'.

SELECT OrderDate, RANK() OVER(ORDER BY OrderDate DESC) AS ranks
FROM orders
WHERE CustomerID = 'ALFKI';

-- Calculate a running total of the quantity of orders using window functions.

SELECT OrderID,Quantity, SUM(Quantity) OVER(ORDER BY OrderID) AS running_quantity
FROM orderdetails;

-- view of orders table
SELECT *
FROM orders
LIMIT 5;

-- Use window functions to find the difference in successive order dates for each customer. 

WITH timestamps AS (
	SELECT CustomerID, OrderDate AS previous_date, 
	LEAD(OrderDate, 1) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS successive_date
	FROM orders)

	SELECT CustomerID, previous_date,
	successive_date, timestampdiff(DAY, previous_date, successive_date) AS day_differences
FROM timestamps;


-- Calculate the moving average of the quantity of the last 3 orders for each product using window function
-- Window / group by products
-- in that window order by Orderid (oldest- newest order)
-- limit calculation of average by number of row 
-- finally order for visual appeal

SELECT OrderID, ProductID,
AVG(Quantity) OVER (PARTITION BY ProductID ORDER BY OrderID
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_average
FROM orderdetails
ORDER BY ProductID,OrderID;









