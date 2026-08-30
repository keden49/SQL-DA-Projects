USE md_water_services;

-- join visits on location
SELECT 
l.province_name,
l.province_name,
v.visit_count,
v.location_id
FROM location l
JOIN visits v ON l.location_id = v.location_id;

-- join water source
SELECT 
l.province_name,
l.province_name,
v.visit_count,
l.location_type,
v.location_id
FROM location l
JOIN visits v ON l.location_id = v.location_id
JOIN water_source ws ON v.source_id = ws.source_id
WHERE v.visit_count = 1;

-- view of visits
SELECT *
FROM visits;


-- adding well pollution
-- left join to avoid discarding most of the material
SELECT 
l.province_name,
l.province_name,
v.visit_count,
ws.number_of_people_served AS people_served,
l.location_type,
v.location_id,
wp.results
FROM visits v
LEFT JOIN well_pollution wp ON v.source_id = wp.source_id
JOIN location l ON l.location_id = v.location_id
JOIN water_source ws ON v.source_id = ws.source_id
WHERE v.visit_count = 1;


CREATE VIEW combined_analysis_table AS

SELECT
water_source.type_of_water_source AS source_type,
location.province_name,
location.province_name,
location.location_type,
water_source.number_of_people_served AS people_served,
visits.time_in_queue,
well_pollution.results
FROM
visits
LEFT JOIN
well_pollution
ON well_pollution.source_id = visits.source_id
INNER JOIN
location
ON location.location_id = visits.location_id
INNER JOIN
water_source
ON water_source.source_id = visits.source_id
WHERE
visits.visit_count = 1;

WITH province_totals AS (-- This CTE calculates the population of each province
SELECT
province_name,
SUM(people_served) AS total_ppl_serv
FROM
combined_analysis_table
GROUP BY
province_name
)
SELECT
ct.province_name,
-- These case statements create columns for each type of source.
-- The results are aggregated and percentages are calculated
ROUND((SUM(CASE WHEN source_type = 'river'
THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS river,
ROUND((SUM(CASE WHEN source_type = 'shared_tap'
THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS shared_tap,
ROUND((SUM(CASE WHEN source_type = 'tap_in_home'
THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS tap_in_home,
ROUND((SUM(CASE WHEN source_type = 'tap_in_home_broken'
THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS tap_in_home_broken,
ROUND((SUM(CASE WHEN source_type = 'well'
THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS well
FROM
combined_analysis_table ct
JOIN
province_totals pt ON ct.province_name = pt.province_name
GROUP BY
ct.province_name
ORDER BY
ct.province_name;

-- 
SELECT
province_name,
town_name,
SUM(people_served) AS total_ppl_serv
FROM
combined_analysis_table
GROUP BY
province_name,town_name
order by province_name, town_name;

SELECT
*
FROM
combined_analysis_table
order by province_name, town_name;

WITH town_totals AS (--  This CTE calculates the population of each town
-- Since there are two Harare towns, we have to group by province_name and town_name
SELECT province_name, town_name, SUM(people_served) AS total_ppl_serv
FROM combined_analysis_table
GROUP BY province_name,town_name
)

SELECT
ct.province_name,
ct.town_name,
ROUND((SUM(CASE WHEN source_type = 'river'
THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS river,
ROUND((SUM(CASE WHEN source_type = 'shared_tap'
THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS shared_tap,
ROUND((SUM(CASE WHEN source_type = 'tap_in_home'
THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS tap_in_home,
ROUND((SUM(CASE WHEN source_type = 'tap_in_home_broken'
THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS tap_in_home_broken,
ROUND((SUM(CASE WHEN source_type = 'well'
THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS well
FROM
combined_analysis_table ct
JOIN -- Since the town names are not unique, we have to join on a composite key
town_totals tt ON ct.province_name = tt.province_name AND ct.town_name = tt.town_name
GROUP BY --  We group by province first, then by town.
ct.province_name,
ct.town_name
ORDER BY
ct.town_name;


-- creating temporary table 

CREATE TEMPORARY TABLE town_aggregated_water_access

WITH town_totals AS (--  This CTE calculates the population of each town
-- Since there are two Harare towns, we have to group by province_name and town_name
SELECT province_name, town_name, SUM(people_served) AS total_ppl_serv
FROM combined_analysis_table
GROUP BY province_name,town_name
)
SELECT
ct.province_name,
ct.town_name,
ROUND((SUM(CASE WHEN source_type = 'river'
THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS river,
ROUND((SUM(CASE WHEN source_type = 'shared_tap'
THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS shared_tap,
ROUND((SUM(CASE WHEN source_type = 'tap_in_home'
THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS tap_in_home,
ROUND((SUM(CASE WHEN source_type = 'tap_in_home_broken'
THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS tap_in_home_broken,
ROUND((SUM(CASE WHEN source_type = 'well'
THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS well
FROM
combined_analysis_table ct
JOIN -- Since the town names are not unique, we have to join on a composite key
town_totals tt ON ct.province_name = tt.province_name AND ct.town_name = tt.town_name
GROUP BY --  We group by province first, then by town.
ct.province_name,
ct.town_name
ORDER BY
ct.town_name;

SELECT *
FROM town_aggregated_water_access
ORDER BY river DESC;


-- which town has the highest ratio of people who have taps, but have no running water?


SELECT province_name, town_name, ROUND(tap_in_home_broken / (tap_in_home_broken + tap_in_home) * 100,0) AS Pct_broken_taps
FROM town_aggregated_water_access;


CREATE TABLE Project_progress (
Project_id SERIAL PRIMARY KEY,
/* Project_id  -- Unique key for sources in case we visit the same

source more than once in the future.

*/
source_id VARCHAR(20) NOT NULL REFERENCES water_source(source_id) ON DELETE CASCADE ON UPDATE CASCADE,
/* source_id −− Each of the sources we want to improve should exist,

and should refer to the source table. This ensures data integrity.

*/
Address VARCHAR(50), -- Street address
Town VARCHAR(30),
Province VARCHAR(30),
Source_type VARCHAR(50),
Improvement VARCHAR(50), -- What the engineers should do at that place
Source_status VARCHAR(50) DEFAULT 'Backlog' CHECK (Source_status IN ('Backlog', 'In progress', 'Complete')),
/* Source_status −− We want to limit the type of information engineers can give us, so we
limit Source_status.
− By DEFAULT all projects are in the "Backlog" which is like a TODO list.
− CHECK() ensures only those three options will be accepted. This helps to maintain clean data.
*/
Date_of_completion DATE, -- −− Engineers will add this the day the source has been upgraded.
Comments TEXT -- Engineers can leave comments. We use a TEXT type that has no limit on char length
);



--  Project_progress_query
SELECT
location.address,
location.town_name,
location.province_name,
water_source.source_id,
water_source.type_of_water_source,
well_pollution.results
FROM
water_source
LEFT JOIN
well_pollution ON water_source.source_id = well_pollution.source_id
INNER JOIN
visits ON water_source.source_id = visits.source_id
JOIN location ON visits.location_id = location.location_id;



-- 1. Only records with visit_count = 1 are allowed.
-- 2. Any of the following rows can be included:
-- a. Where shared taps have queue times over 30 min.
-- b. Only wells that are contaminated are allowed 
-- Include any river and tap_in_home_broken sources.
-- So we exclude wells that are Clean

SELECT
l.address,
l.town_name,
l.province_name,
ws.source_id,
ws.type_of_water_source,
wp.results,
CASE
WHEN wp.results = 'Contaminated: Chemical' THEN 'Install RO filter'
WHEN wp.results = 'Contaminated: Biological' THEN 'Install UV and RO filter'
WHEN ws.type_of_water_source = 'river' THEN 'Drill well'
WHEN ws.type_of_water_source = 'shared_tap' AND v.time_in_queue >= 30 THEN CONCAT('Install ', FLOOR(time_in_queue / 30), ' taps nearby')
WHEN ws.type_of_water_source = 'tap_in_home_broken' THEN 'Diagnose local infrastructure'
END AS Improvements
FROM
water_source ws
LEFT JOIN
well_pollution wp ON ws.source_id = wp.source_id
INNER JOIN
visits v ON ws.source_id = v.source_id
JOIN location l ON v.location_id = l.location_id
WHERE v.visit_count = 1
AND (ws.type_of_water_source = 'shared_tap' AND v.time_in_queue >= 30
 OR wp.results != 'Clean'
 OR ws.type_of_water_source IN ( 'river','tap_in_home_broken'))
 LIMIT 30000;



SELECT DISTINCT type_of_water_source
FROM water_source;

SELECT distinct results
FROM well_pollution;

-- populating project_progress
INSERT INTO Project_progress (source_id, Address, Town, Province, Source_type, Improvement)

SELECT
ws.source_id,
l.address,
l.town_name,
l.province_name,
ws.type_of_water_source,
CASE
WHEN wp.results = 'Contaminated: Chemical' THEN 'Install RO filter'
WHEN wp.results = 'Contaminated: Biological' THEN 'Install UV and RO filter'
WHEN ws.type_of_water_source = 'river' THEN 'Drill well'
WHEN ws.type_of_water_source = 'shared_tap' AND v.time_in_queue >= 30 THEN CONCAT('Install ', FLOOR(time_in_queue / 30), ' taps nearby')
WHEN ws.type_of_water_source = 'tap_in_home_broken' THEN 'Diagnose local infrastructure'
END AS Improvements
FROM
water_source ws
LEFT JOIN
well_pollution wp ON ws.source_id = wp.source_id
INNER JOIN
visits v ON ws.source_id = v.source_id
JOIN location l ON v.location_id = l.location_id
WHERE v.visit_count = 1
AND (ws.type_of_water_source = 'shared_tap' AND v.time_in_queue >= 30
 OR wp.results != 'Clean'
 OR ws.type_of_water_source IN ( 'river','tap_in_home_broken'))
 LIMIT 30000;
 
 
 SELECT *
 FROM project_progress;
 
 
 





