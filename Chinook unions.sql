USE chinook;

-- Chinook needs to consolidate contact information scattered across customer and employee databases for an upcoming company-wide communication initiative. 
-- Marketing requires a unified view of all cities where the company has a presence, while HR is building a directory that merges customer and employee contact details. Your queries will combine data from separate tables to create these consolidated reports.

-- These activities require you to use SQL UNION statements to stack rows from multiple queries, based on the principle that the selected columns must be compatible (same number, order, and datatype).



-- Task 1: Create a Master Contact List (UNION ALL)

-- Instructions

-- Generate a consolidated list of all customers and all employees. The list must include their:

-- Full name
-- City
-- Email address
-- Include all rows, even if duplicates exist.

-- Query requirement

-- Use UNION ALL to combine data from the Customer and Employee tables. Use CONCAT to combine first and last names into a single name column.


-- getting customer details 

SELECT CONCAT(FirstName,' ',LastName) AS Fullname,
City, Email
FROM customer

UNION ALL

SELECT CONCAT(FirstName,' ',LastName) AS Fullname,
City, Email
FROM employee;


-- Task 2: Identify Unique Cities with Company Contacts (UNION)

-- Instructions

-- Create a single list of unique cities where either a customer or an employee is located. Filter to include only:

-- Customers where Company is not NULL
-- Employees where Title is not NULL
-- Query requirement

-- Use UNION to combine city lists from both tables so duplicates are removed across the combined result set.

SELECT City
FROM customer
WHERE Company IS NOT NULL 

UNION

SELECT City
FROM employee
WHERE Title IS NOT NULL;


-- Task 3: Alphabetical List of Contacts (UNION with Ordering)

-- Instructions

-- Generate a unified, alphabetically sorted list of all last names and first names from both the Customer and Employee tables.

-- Requirements

-- Output must contain exactly two columns: LastName, FirstName
-- Sort by LastName, then FirstName
-- Query requirement

-- Use UNION and apply ORDER BY to the final combined result.


SELECT FirstName,
LastName 
FROM customer

UNION

SELECT FirstName,
LastName 
FROM employee

ORDER BY LastName, FirstName;



-- Task 4: Managers and IT Staff List (UNION)

-- Instructions

-- Create a single list showing the FullName and Title of employees whose title contains either "Manager" or "IT Staff". Each employee should appear only once in the final list, even if their title contains both terms.

-- Requirements

-- Output must contain two columns: FullName, Title
-- Remove duplicate entries
-- Sort by Title (ascending)
-- Query requirement

-- Use UNION to combine two SELECT statements that filter on Title. Use CONCAT to build the full name.

SELECT

CONCAT(FirstName, ' ', LastName) AS FullName,

Title

FROM Employee

WHERE Title LIKE '%Manager%'
UNION


SELECT

CONCAT(FirstName, ' ', LastName) AS FullName,

Title

FROM Employee

WHERE Title LIKE '%IT Staff%'

UNION

SELECT

CONCAT(FirstName, ' ', LastName) AS FullName,

Title

FROM Employee

WHERE Title LIKE '%Manager%'


ORDER BY Title;

