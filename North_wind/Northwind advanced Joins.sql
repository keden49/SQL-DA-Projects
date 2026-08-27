USE northwind;

-- Retrieve product details from products that have been ordered by customers from the 


SELECT *
FROM products 
WHERE ProductID IN(
SELECT ProductID
FROM orderdetails
WHERE OrderID IN(
SELECT OrderID
FROM orders 
WHERE CustomerID IN(
SELECT CustomerID
FROM customers 
WHERE Country = 'UK')));

WITH uk_customers AS (
    SELECT CustomerID 
    FROM customers 
    WHERE Country = 'UK'
)
SELECT DISTINCT p.*
FROM products p
JOIN orderdetails od ON p.ProductID = od.ProductID
JOIN orders o ON od.OrderID = o.OrderID
JOIN uk_customers c ON o.CustomerID = c.CustomerID;

WITH avg_rating AS (
SELECT AVG(Quantity * UnitPrice) AS average
FROM orderdetails)

SELECT DISTINCT ContactName
FROM customers c
JOIN orders o ON c.CustomerID = o.CustomerID
JOIN orderdetails od ON o.OrderID = od.OrderID
WHERE Quantity * UnitPrice > (SELECT average FROM avg_rating);


-- Write a CTE to find the most ordered product by each customer.


WITH customers_orders AS
(SELECT CustomerID,OrderID
FROM orders
GROUP BY CustomerID,OrderID),

customer_groups AS(
SELECT customers_orders.CustomerID, ProductID, COUNT(*) AS units_bought, 
ROW_NUMBER() OVER(partition by  customers_orders.CustomerID ORDER BY COUNT(*) DESC) AS Ranks 
FROM orderdetails od 
JOIN customers_orders  ON od.OrderID = customers_orders.OrderID
GROUP BY customers_orders.CustomerID, ProductID
ORDER BY units_bought DESC)


SELECT c.CustomerID, p.ProductName
FROM customer_groups c
JOIN products p ON c.ProductID = p.ProductID
WHERE Ranks = 1;



WITH product_counts AS (
    SELECT 
        c.CustomerID,
        c.CompanyName,
        p.ProductID,
        p.ProductName,
        COUNT(*) AS total_orders,
        ROW_NUMBER() OVER (
            PARTITION BY c.CustomerID 
            ORDER BY COUNT(*) DESC
        ) AS rank_num
    FROM customers c
    JOIN orders o ON c.CustomerID = o.CustomerID
    JOIN orderdetails od ON o.OrderID = od.OrderID
    JOIN products p ON od.ProductID = p.ProductID
    GROUP BY c.CustomerID, c.CompanyName, p.ProductID, p.ProductName
)
SELECT 
    CustomerID,
    CompanyName,
    ProductName,
    total_orders
FROM product_counts
WHERE rank_num = 1;



SELECT *
FROM orderdetails
ORDER BY OrderID
LIMIT 5;



-- Using a CTE, list employees who have more than the average number of reports.

SELECT EmployeeID, ReportsTo
FROM employees
ORDER BY EmployeeID;

-- get reports counts for each employee
WITH report_counts AS
(SELECT EmployeeID,COUNT(ReportsTo) AS average
FROM employees
GROUP BY EmployeeID),

-- get total average reports 
avg_report AS
(
SELECT AVG(average) AS average_count
FROM report_counts
)
-- find employee infromation
SELECT e.EmployeeID, CONCAT(LastName,FirstName) AS full_name
FROM employees e 
JOIN report_counts a ON e.EmployeeID = a.EmployeeID
WHERE a.average > (SELECT average_count FROM avg_report) ;


WITH avg_reports AS (
    SELECT AVG(report_count) AS average_count
    FROM (
        SELECT COUNT(*) AS report_count
        FROM employees
        JOIN employees AS reports ON employees.EmployeeID = reports.ReportsTo
        GROUP BY employees.EmployeeID
    ) AS report_counts
)
SELECT employees.*
FROM employees
JOIN employees AS reports ON employees.EmployeeID = reports.ReportsTo
GROUP BY employees.EmployeeID
HAVING COUNT(*) > (SELECT average_count FROM avg_reports);



SELECT 
    e.EmployeeID, 
    CONCAT(e.LastName, ' ', e.FirstName) AS full_name, 
    a.report_count
FROM employees e 
JOIN (
    SELECT ReportsTo AS EmployeeID, COUNT(*) AS report_count
    FROM employees
    WHERE ReportsTo IS NOT NULL
    GROUP BY ReportsTo
) a ON e.EmployeeID = a.EmployeeID
WHERE a.report_count > (
    SELECT AVG(report_count) 
    FROM (
        SELECT COUNT(*) AS report_count 
        FROM employees 
        WHERE ReportsTo IS NOT NULL 
        GROUP BY ReportsTo
    ) AS sub
);


-- find managers reports 
-- pool containing manager and who reports to them 

SELECT ReportsTo AS manager, EmployeeID
FROM employees
ORDER BY manager;


-- creating views

CREATE VIEW Employee_View AS 
SELECT LastName, FirstName, Title, Country
FROM Employees;



-- find counts of this managers reports

WITH manager_reports AS 
(SELECT ReportsTo AS manager, COUNT(EmployeeID) as num_reports
FROM employees
GROUP BY manager),

average_reports AS 
(SELECT AVG(num_reports) as average
FROM manager_reports)

SELECT CONCAT(LastName,' ',FirstName) AS full_name, m.num_reports
FROM employees e
JOIN manager_reports m ON e.EmployeeID = m.manager
WHERE m.num_reports > (SELECT average FROM average_reports);



SELECT COUNT(*) AS report_count
FROM employees
JOIN employees AS reports ON employees.EmployeeID = reports.ReportsTo
GROUP BY employees.EmployeeID;

SELECT *
FROM employees
JOIN employees AS reports ON employees.EmployeeID = reports.ReportsTo;





































