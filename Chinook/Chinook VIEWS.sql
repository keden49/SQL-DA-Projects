USE Chinook;

-- Create a LOOKUP view of the surname, first name, title, and country of each employee called Employee_View.
CREATE VIEW Employee_View AS 
SELECT LastName, FirstName, Title, Country
FROM employee;

SELECT *
FROM Employee_View;

-- Salse Team
SELECT * FROM Employee_View
WHERE Title LIKE '%Sales%';


SELECT * 
FROM employee;



-- Create a JOIN view that will link up all the customers with the support staff assisting them, called Customer_Support_View. 
-- 

We want to view the following:

-- First name of the customer
-- Last name (surname) of the customer
-- Country where the customer resides
-- SupportRepId
-- EmployeeId
-- Last name of the employee
-- First name of the employee
-- Job title of the employee
-- Country where the employee operated from
CREATE VIEW Customer_Support_View AS
SELECT c.FirstName AS Customer_Name,
       c.LastName AS Customer_Surname,
       c.Country AS Customer_Country,
       c.SupportRepId,
       e.EmployeeId,
       e.LastName AS Employee_surname,
       e.FirstName AS Employee_first_name,
       e.Title AS Employee_job_title,
       e.Country AS Employee_Country
FROM customer c 
INNER JOIN employee e
ON c.SupportRepId = e.EmployeeId;

-- customers serviced by employee id 3
SELECT Customer_Name, Customer_Surname 
FROM Customer_Support_View
WHERE EmployeeId = 3;

-- no  of customers serviced per country
CREATE VIEW Customer_per_Country_View AS 
SELECT COUNT(CustomerId) AS Num_customers, Country
FROM customer
GROUP BY Country;

-- most servicing country
SELECT *
FROM Customer_per_Country_View
ORDER BY Num_customers DESC
LIMIT 1;

-- dropping employee view 

DROP VIEW Employee_View;


-- Write a query that returns the number of customers that each support employee services, along with the name of the employee. 
-- Call this view Support_Person_Stats.

CREATE VIEW Support_Person_Stats AS

SELECT i.SupportRepId, CONCAT(e.FirstName, ' ', e.LastName) AS full_name, i.num_served
FROM employee e
JOIN 
(SELECT SupportRepId,COUNT(CustomerId) AS num_served
FROM 
(SELECT SupportRepId, CustomerId
FROM customer c
JOIN employee e ON c.SupportRepId = e.EmployeeId) serviced_cust
GROUP BY SupportRepId) i ON e.EmployeeId = i.SupportRepId;



CREATE VIEW Support_Person_Stat AS
SELECT 
    i.SupportRepId, 
    CONCAT(e.FirstName, ' ', e.LastName) AS full_name, 
    i.num_served
FROM employee e
JOIN (
    SELECT 
        SupportRepId, 
        COUNT(CustomerId) AS num_served
    FROM customer
    GROUP BY SupportRepId
) i ON e.EmployeeId = i.SupportRepId;


CREATE VIEW Support_Person_Sta AS
SELECT COUNT(c.SupportRepId) AS Count_of_Customers_Serviced,
       e.EmployeeId,
       e.LastName
FROM customer c 
INNER JOIN employee e
ON c.SupportRepId = e.EmployeeId
GROUP BY c.SupportRepId, e.LastName;

SELECT *
FROM Support_Person_Sta;

SELECT COUNT(c.SupportRepId) AS Count_of_Customers_Serviced,
       e.EmployeeId,
       e.LastName
FROM customer c 
INNER JOIN employee e
ON c.SupportRepId = e.EmployeeId
GROUP BY c.SupportRepId, e.LastName;













