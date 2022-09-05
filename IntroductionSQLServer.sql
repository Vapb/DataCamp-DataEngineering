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