-- Limit the number of rows returned
SELECT 
  TOP (50) points 
FROM 
  eurovision;

-- Return Distinct using ALIAS
SELECT 
  DISTINCT country AS unique_country 
FROM 
  eurovision;

-- Return Percentage
SELECT 
  TOP (50) PERCENT * 
FROM 
  eurovision;

-- WHERE


-- IN 

-- LIKE 

-- SUM, MIN, MAX, AVG
SELECT 
  SUM(demand_loss_mw) AS MRO_demand_loss 
FROM 
  grid 
WHERE
  demand_loss_mw IS NOT NULL 
  AND nerc_region = 'MRO';

-- LEN
SELECT 
  LEN (description) AS description_length 
FROM 
  grid;

-- RIGHT LEFT
-- Select the first 25 characters from the left of the description column
SELECT 
  RIGHT(description, 25) AS last_25_right 
FROM 
  grid;

-- CHARINDEX
SELECT 
  description, 
  CHARINDEX('Weather', description) 
FROM 
  grid
WHERE description LIKE '%Weather%';

-- SUBSTRING
SELECT TOP (10)
  description, 
  CHARINDEX('Weather', description) AS start_of_string, 
  LEN ('Weather') AS length_of_string, 
  SUBSTRING(
    description, 
    15, 
    LEN(description)
  ) AS additional_description 
FROM 
  grid
WHERE description LIKE '%Weather%';

-- GROUP BY
SELECT 
  region,
  SUM(demand_loss_mw) AS demand_loss
FROM 
  grid
WHERE 
  demand_loss_mw IS NOT NULL
GROUP BY 
  nerc_region
ORDER BY 
  demand_loss DESC;

-- HAVING
SELECT 
  nerc_region, 
  SUM (demand_loss_mw) AS demand_loss 
FROM 
  grid 
WHERE demand_loss_mw  IS NOT NULL
GROUP BY 
  nerc_region 
HAVING 
  SUM(demand_loss_mw) > 10000 
ORDER BY 
  demand_loss DESC;