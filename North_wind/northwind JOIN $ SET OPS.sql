USE northwind;

-- Task 2: Exclusive Customer Contacts (EXCEPT Simulation)

-- Instructions

-- Identify the contact names that appear in the Customers table but not in the Suppliers table. This task simulates the EXCEPT or MINUS operation, which is not natively supported in MySQL.
-- Requirements

-- Use a subquery to exclude supplier contact names
-- Output must contain unique customer contact names only


SELECT ContactName
FROM customers
WHERE ContactName NOT IN (

SELECT ContactName
FROM suppliers);

SELECT
    CONCAT(LastName, ', ', FirstName) AS FullName,
    LOWER(Title) AS LowercaseTitle,
    TRIM(TRAILING '.' FROM TitleOfCourtesy) AS CourtesyTitle
FROM Employees;



-- Task 4: Products with Long Category Descriptions

-- Instructions

-- List all products whose category description is longer than 50 characters.

-- Requirements

-- Display only CategoryName and ProductName
-- Join the Products and Categories tables
-- Order results by CategoryName


SELECT
    c.CategoryName,
    p.ProductName
FROM Products p
JOIN Categories c
    ON p.CategoryID = c.CategoryID
WHERE LENGTH(c.Description) > 50
ORDER BY c.CategoryName;


-- Task 5: Matching Orders and Territories (INNER JOIN)

-- Instructions

-- List all orders that were handled by employees who have at least one assigned territory.

-- Requirements

-- Display: OrderID, Employee full name, TerritoryDescription
-- Use joins across the relevant tables
-- Include only orders associated with employees who have territories

SELECT DISTINCT
    o.OrderID,
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeFullName,
    t.TerritoryDescription
FROM Orders o
JOIN Employees e
    ON o.EmployeeID = e.EmployeeID
JOIN EmployeeTerritories et
    ON e.EmployeeID = et.EmployeeID
JOIN Territories t
    ON et.TerritoryID = t.TerritoryID
ORDER BY o.OrderID;


-- view of employee territories


SELECT *
FROM employeeterritories
LIMIT 5;


SELECT
    CONCAT(FirstName, ' ', LastName) AS FullName,
    'Manager' AS RoleCategory
FROM Employees
WHERE ReportsTo IS NULL
UNION ALL


SELECT

CONCAT(FirstName, ' ', LastName) AS FullName,

'Staff' AS RoleCategory

FROM Employees

WHERE ReportsTo IS NOT NULL


ORDER BY FullName;


SELECT CONCAT(FirstName, ' ', LastName) AS FullName,
IF(ReportsTo IS NULL, 'Manager', 'Staff') AS RoleCategory,
ReportsTo
FROM employees;





