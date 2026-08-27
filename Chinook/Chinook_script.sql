USE chinook;

-- : Use a string function to remove leading and trailing spaces from the Email column.

SELECT CustomerId, TRIM(Email) AS CleanedEmail 
FROM Customer;

--  Use string concatenation and case conversion functions to format the FirstName and LastName columns.

SELECT UPPER(CONCAT(FirstName,LastName)) AS Fullname
FROM customer
LIMIT 5;

-- Attempt 2

SELECT UPPER(CONCAT(LastName, ', ', FirstName)) AS FullName
FROM Customer;

-- Use string concatenation to combine the employee details into a single column.

SELECT CONCAT(FirstName," ", LastName, ', ', Title,': ', Phone) AS employee_info
FROM employee;


-- The logistics team wants to analyze customer distribution. 
-- They need a report showing the CustomerId, FirstName, LastName, and a new column called CityCode. 
-- The CityCode should be the first three characters of the City column, in lowercase.

SELECT CustomerId, FirstName, LastName, LOWER(LEFT(City, 3)) AS Citycode
FROM customer;

-- The accounting department needs a report of all invoices. 
-- They want the InvoiceDate to be formatted as a string in the YYYY-MM-DD format. 
-- The report should include the InvoiceId, CustomerId, and the new formatted date column.

SELECT InvoiceId, CustomerId, DATE_FORMAT(InvoiceDate, '%Y-%m-%d') AS Formatteddate
FROM invoice;

-- view of invoice table

SELECT *
FROM invoice
LIMIT 5;

-- For internal system checks, the IT department needs a unique, standardized identifier for each customer. 
-- Create a report with CustomerId and a new column called CustomerID_Hash. 
-- This hash should be a string created by concatenating the first two letters of the FirstName and the first two letters of the LastName, both in lowercase.

SELECT CustomerId, LOWER(CONCAT(LEFT(FirstName, 2), LEFT(LastName, 2))) AS CustomerID_Hash
FROM customer;


-- The reporting tool used by management expects the InvoiceId to be a string. 
-- Create a query that shows the InvoiceId, but with its data type explicitly converted to CHAR (or VARCHAR) using CAST(). 
-- Also, include the CustomerId and Total for each invoice.

SELECT CAST(InvoiceId AS  CHAR) AS Casted_id, CustomerId, Total
FROM invoice;

-- The IT team wants to audit the email domains used by customers. 
-- Create a report that shows the FirstName, LastName, and a new column EmailDomain. 
-- The EmailDomain should be the portion of the email address that comes after the '@' symbol.

SELECT FirstName, LastName, SUBSTRING(Email, POSITION('@' IN Email) + 1) AS EmailDomain
FROM customer;

SELECT FirstName, LastName, SUBSTRING(Email, LOCATE('@', Email) + 1) AS EmailDomain 
FROM Customer;

-- The marketing team is running a survey and wants to know the length of each customer's first name. 
-- Create a report showing the CustomerId, FirstName, and a new column called NameLength that shows the number of characters in their first name.

SELECT CustomerId, FirstName,LENGTH(FirstName) AS NameLength
FROM Customer;


-- HR wants a report to audit employee titles. They've noticed some titles are in mixed cases and want to see them all in lowercase. 
-- Create a report showing EmployeeId, LastName, and a new column Title_Lowercase with the title in all lowercase.

SELECT EmployeeId, LastName, LOWER(Title) AS Title_Lowercase
FROM employee;










