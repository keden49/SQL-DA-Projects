USE md_water_services;

SET SQL_SAFE_UPDATES = 0;
SELECT 
CONCAT(LOWER(REPLACE(employee_name, ' ', '.')), '@ndogowater.gov') AS new_email 
FROM employee;
UPDATE employee

SET email = CONCAT(LOWER(REPLACE(employee_name, ' ', '.')), '@ndogowater.gov');


-- view of employee table 

SELECT *
FROM employee
LIMIT 5;

-- fixing phone numbers 

SELECT LENGTH(TRIM(phone_number)) FROM employee;
UPDATE employee

SET phone_number = TRIM(phone_number);


-- identifying top perfoming employees 

SELECT 
assigned_employee_id, 
COUNT(location_id) AS number_of_visits
FROM visits
GROUP BY assigned_employee_id
ORDER BY number_of_visits DESC
LIMIT 3;


-- identifying resource concentration

SELECT 
province_name, 
town_name, 
COUNT(location_id) AS records_per_town
FROM location
GROUP BY province_name, town_name;

-- view of data dictionary

SELECT *
FROM data_dictionary;


-- average people served by water source

SELECT 
type_of_water_source, 
ROUND(AVG(number_of_people_served), 0) AS avg_people_per_source
FROM water_source
GROUP BY type_of_water_source;


-- percentage of people served by water sources

SELECT type_of_water_source,SUM(number_of_people_served) AS 
sum, (ROUND(SUM(number_of_people_served) /27603984, 2) * 100) AS percentage_served
FROM water_source
GROUP BY type_of_water_source;

-- count pof water source 

SELECT COUNT(*)
FROM water_source;


-- view of water source 

SELECT *
FROM water_source
LIMIT 5;

-- water sources that have priority ti fix 
SELECT 
source_id,
type_of_water_source,
number_of_people_served,
RANK() OVER (
PARTITION BY type_of_water_source 
ORDER BY number_of_people_served DESC
) AS priority_rank
FROM water_source
WHERE type_of_water_source != 'tap_in_home';


-- average queue per day 

SELECT 
DAYNAME(time_of_record) AS day_of_week,
ROUND(AVG(NULLIF(time_in_queue, 0)), 0) AS avg_queue_time
FROM visits
GROUP BY day_of_week
ORDER BY avg_queue_time DESC;

-- -- view of visits

SELECT *
FROM visits
LIMIT 5;

-- 
SELECT 
-- extract the hour of day
TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,
ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue END), 0) AS Sunday,
ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Monday' THEN time_in_queue END), 0) AS Monday,
ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Tuesday' THEN time_in_queue END), 0) AS Tuesday,
ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Wednesday' THEN time_in_queue END), 0) AS Wednesday,
ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Thursday' THEN time_in_queue END), 0) AS Thursday,
ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Friday' THEN time_in_queue END), 0) AS Friday,
ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Saturday' THEN time_in_queue END), 0) AS Saturday
FROM visits
WHERE time_in_queue != 0
GROUP BY hour_of_day
ORDER BY hour_of_day;
