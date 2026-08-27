USE md_water_services;

-- Confirming duplicates in water quality and visits
SELECT record_id, COUNT(*)
FROM visits
GROUP BY record_id
HAVING COUNT(*) > 1
UNION ALL
SELECT record_id, COUNT(*)
FROM water_quality
GROUP BY record_id
HAVING COUNT(*) > 1;


CREATE TABLE `auditor_report` (
`location_id` VARCHAR(32),
`type_of_water_source` VARCHAR(64),
`true_water_source_score` int DEFAULT NULL,
`statements` VARCHAR(255)
);



SELECT 
    *
FROM
    auditor_report;

-- For the first question, we will have to compare the quality scores in the water_quality table to the auditor's scores. The auditor_report table
-- used location_id, but the quality scores table only has a record_id we can use. The visits table links location_id and record_id, so we
-- can link the auditor_report table and water_quality using the visits table.

SELECT a.location_id AS auditors_location,true_water_source_score, v.location_id AS visit_location, v.record_id
FROM auditor_report a
JOIN visits v ON a.location_id = v.location_id;


-- Now that we have the record_id for each location, our next step is to retrieve the corresponding scores from the water_quality table. We
-- are particularly interested in the subjective_quality_score. To do this, we'll JOIN the visits table and the water_quality table, using the
-- record_id as the connecting key.

SELECT a.location_id AS auditors_location,true_water_source_score, v.location_id AS visit_location, v.record_id, w.subjective_quality_score
FROM auditor_report a
JOIN visits v ON a.location_id = v.location_id
JOIN water_quality w ON w.record_id = v.record_id;


-- It doesn't matter if your columns are in a different format, because we are about to clean this up a bit. Since it is a duplicate, we can drop one of
-- the location_id columns. Let's leave record_id and rename the scores to surveyor_score and auditor_score to make it clear which scores
-- we're looking at in the results set.

SELECT a.location_id AS auditors_location,v.record_id, true_water_source_score, w.subjective_quality_score 
FROM auditor_report a
JOIN visits v ON a.location_id = v.location_id
JOIN water_quality w ON w.record_id = v.record_id;


-- seeing if they results agree 
SELECT a.location_id AS auditors_location,v.record_id, true_water_source_score, w.subjective_quality_score 
FROM auditor_report a
JOIN visits v ON a.location_id = v.location_id
JOIN water_quality w ON w.record_id = v.record_id
WHERE true_water_source_score = w.subjective_quality_score AND v.visit_count = 1
LIMIT 10000;

-- finding ratings that dont agree with the actual records 
SELECT a.location_id AS auditors_location,v.record_id, true_water_source_score, w.subjective_quality_score 
FROM auditor_report a
JOIN visits v ON a.location_id = v.location_id
JOIN water_quality w ON w.record_id = v.record_id
WHERE true_water_source_score != w.subjective_quality_score AND v.visit_count = 1;


-- joining water sources

SELECT a.location_id AS auditors_location,v.record_id,ws.type_of_water_source AS survey_source, a.type_of_water_source AS audits_source, true_water_source_score, w.subjective_quality_score 
FROM auditor_report a
JOIN visits v ON a.location_id = v.location_id
JOIN water_quality w ON w.record_id = v.record_id
JOIN water_source ws ON v.source_id = ws.source_id
WHERE true_water_source_score != w.subjective_quality_score AND v.visit_count = 1;


-- In either case, the employees are the source of the errors, so let's JOIN the assigned_employee_id for all the people on our list from the visits
-- table to our query. Remember, our query shows the shows the 102 incorrect records, so when we join the employee data, we can see which
-- employees made these incorrect records.

WITH incorrect_records AS
(
SELECT a.location_id AS auditors_location,v.record_id, e.employee_name,true_water_source_score, w.subjective_quality_score 
FROM auditor_report a
JOIN visits v ON a.location_id = v.location_id
JOIN water_quality w ON w.record_id = v.record_id
JOIN employee e ON v.assigned_employee_id = e.assigned_employee_id
WHERE true_water_source_score != w.subjective_quality_score AND v.visit_count = 1),

-- number of times employees have made mistakes 
error_count AS (
    SELECT 
        employee_name,
        COUNT(*) AS number_of_mistakes
    FROM 
        Incorrect_records
    GROUP BY 
        employee_name
),

-- 
avg_error_count_per_empl AS (
    SELECT 
        AVG(number_of_mistakes) AS avg_mistakes 
    FROM 
        error_count
)

SELECT 
    employee_name,
    number_of_mistakes
FROM 
    error_count
WHERE 
    number_of_mistakes > (SELECT avg_mistakes FROM avg_error_count_per_empl)
ORDER BY 
    number_of_mistakes DESC;
    


CREATE VIEW Incorrect_records AS
(

SELECT a.location_id AS auditors_location,v.record_id, e.employee_name,true_water_source_score, w.subjective_quality_score 
FROM auditor_report a
JOIN visits v ON a.location_id = v.location_id
JOIN water_quality w ON w.record_id = v.record_id
JOIN employee e ON v.assigned_employee_id = e.assigned_employee_id
WHERE true_water_source_score != w.subjective_quality_score AND v.visit_count = 1);


SELECT *
FROM Incorrect_records;



WITH error_count AS
(SELECT employee_name, COUNT(*) AS num_mistakes
FROM Incorrect_records
GROUP BY employee_name),

suspect_list AS 
(SELECT *
FROM error_count
WHERE num_mistakes > (SELECT AVG(num_mistakes) FROM error_count))

SELECT i.employee_name,i.auditors_location ,a.statements
FROM Incorrect_records i
JOIN auditor_report a ON i.auditors_location = a.location_id
WHERE employee_name IN (SELECT employee_name FROM suspect_list) 
;


WITH error_count AS
(SELECT employee_name, COUNT(*) AS num_mistakes
FROM Incorrect_records
GROUP BY employee_name),

suspect_list AS 
(SELECT *
FROM error_count
WHERE num_mistakes > (SELECT AVG(num_mistakes) FROM error_count))

SELECT employee_name FROM suspect_list
;


-- “Suspicion coloured villagers' descriptions of an official's aloof demeanour and apparent laziness. The reference to cash transactions casts doubt on their motives.”




SELECT e.employee_name, a.statements
FROM auditor_report a
JOIN visits v ON a.location_id = v.location_id
JOIN water_quality w ON w.record_id = v.record_id
JOIN employee e ON v.assigned_employee_id = e.assigned_employee_id
WHERE a.statements LIKE "%aloof%";


-- just missed average
-- Rudo Imani AS she had an 5 mistakes and the average was 6

WITH error_count AS
(SELECT employee_name, COUNT(*) AS num_mistakes
FROM Incorrect_records
GROUP BY employee_name),

suspect_list AS 
(SELECT *
FROM error_count
WHERE num_mistakes > (SELECT AVG(num_mistakes) FROM error_count))

SELECT *
FROM error_count
ORDER BY num_mistakes DESC;


SELECT i.employee_name,i.auditors_location ,a.statements
FROM Incorrect_records i
JOIN auditor_report a ON i.auditors_location = a.location_id
WHERE employee_name IN (SELECT employee_name FROM suspect_list)
