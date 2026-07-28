-- show tables 
SHOW TABLES;

-- understanding water sources 

SELECT DISTINCT type_of_water_source FROM water_source;
-- visits where time in queue is more than 500 minutes 

SELECT * FROM visits WHERE time_in_queue > 500;

-- exploring unnormal water scources 
SELECT * FROM water_source WHERE source_id IN (
    'AkKi00881224',
    'AkLu01628224',
    'AkRu05234224',
    'HaRu19681224',
    'HaZa21742224',
    'SoRu36896224',
    'SoRu37635224',
    'SoRu38776224'
);

-- assesing water quality 
-- where the subjective_quality_score and homes were visited twice 

SELECT COUNT(*) FROM water_quality WHERE visit_count = 2 AND subjective_quality_score = 10;

-- investigate pollution issues 

SELECT * FROM well_pollution LIMIT 5;

-- water sources that were identified as clean but have contaminants 

SELECT * FROM well_pollution WHERE results = 'clean' AND biological > 0.01;

-- filtering incorrect descriptions 

SELECT COUNT(*) FROM well_pollution WHERE description LIKE 'Clean %' ;

-- update description column

SET SQL_SAFE_UPDATES = 0;

UPDATE well_pollution
SET description = 'Bacteria: E. coli' 
WHERE description = 'Clean Bacteria: E. coli';

UPDATE well_pollution
SET description = 'Bacteria: Giardia Lamblia'
WHERE description = 'Clean Bacteria: Giardia Lamblia';

UPDATE well_pollution
SET results = 'Contaminated: Biological'
WHERE results = 'Clean' 
  AND biological > 0.01;
  
-- creating backup 
CREATE TABLE well_pollution_copy AS (SELECT * FROM well_pollution);


-- Microbiologist

SELECT * FROM employee WHERE position = 'Micro Biologist';

-- distinct provinces 

SELECT COUNT(DISTINCT(province_name)) FROM location;

-- most used water source in total
-- each source id is distinct 

SELECT source_id, sum(number_of_people_served) AS COUNT, type_of_water_source  FROM water_source GROUP BY source_id ORDER BY COUNT DESC; 


-- water source that recorded highest number of people

SELECT * 
FROM water_source
WHERE number_of_people_served = (SELECT MAX(number_of_people_served)
FROM water_source);

-- checking for duuplicates 
SELECT source_id, COUNT(*) AS occurrence_count
FROM water_source
GROUP BY source_id
HAVING COUNT(*) > 1;

-- population of maji ndogo

SELECT * FROM global_water_access WHERE name = 'Maji Ndogo';

-- 
SELECT COUNT(*)
FROM well_pollution
WHERE description LIKE 'Clean_%' AND biological > 0.01;

-- adress of bell azibo

SELECT address FROM employee WHERE employee_name = 'Bello Azibo';

SELECT COUNT(*)
FROM well_pollution
WHERE description LIKE 'Clean_%' OR results = 'Clean' AND biological < 0.01;

-- bacteria  responsible for a contamination level of 400 and above

SELECT distinct(description) AS bacteria,biological FROM well_pollution WHERE biological > 400;

-- rural and urban counts with more than 538 min as waiting time 

SELECT location.location_type, COUNT(*)
FROM visits
JOIN location ON visits.location_id = location.location_id  
WHERE time_in_queue >= 538
GROUP BY location_type;

-- number of sources that were not visited 
SELECT COUNT(*) 
FROM md_water_services.water_source
WHERE source_id NOT IN (
    SELECT DISTINCT source_id 
    FROM md_water_services.visits
);

-- Data sciencist contact 

SELECT * FROM employee WHERE position = 'Data Scientist';

-- identify suspicious employees

SELECT * 
FROM employee
WHERE (phone_number LIKE '%86%' OR phone_number LIKE '%11%')
 AND (employee_name LIKE'% A%' OR employee_name LIKE'% M%') AND position = 'Field Surveyor';
 
 
-- number of rows returned

SELECT COUNT(*)
FROM well_pollution
WHERE description
IN ('Parasite: Cryptosporidium', 'biologically contaminated')
OR (results = 'Clean' AND biological > 0.01);

-- not a field surveyor from the Kilimani province

SELECT * 
FROM employee
WHERE province_name = 'Kilimani' AND position = 'Field Surveyor';

-- viruses 

SELECT DISTINCT description
FROM well_pollution
WHERE description LIKE '%Virus%';

-- maximum number of people served by water sources
SELECT source_id, MAX(number_of_people_served)
FROM water_source;

















 
