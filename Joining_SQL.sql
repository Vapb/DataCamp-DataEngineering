-- InnerJoin 
SELECT c.code,
       name,
       region,
       e.year,
       fertility_rate,
       unemployment_rate
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
INNER JOIN economies AS e
ON c.code = e.code AND p.year = e.year;

-- InnerJoin USING
SELECT c.name AS country,
       continent,
       l.name AS language,
       l.official
FROM countries AS c
INNER JOIN languages as l
USING (code)

-- SelfJoin
SELECT p1.country_code,
       p1.size AS size2010,
       p2.size AS size2015
FROM populations as p1
INNER JOIN populations as p2
ON p1.country_code = p2.country_code AND p1.year = (p2.year - 5) 

-- Case When then
SELECT name, continent, code, surface_area,
CASE 
    WHEN surface_area > 2000000 THEN 'large'
    WHEN surface_area > 350000 THEN 'medium'
    ELSE 'small' END
    AS geosize_group
FROM countries;

-- INto 


-- Cross Joins


-- Union
SELECT *
FROM economies2010
	UNION
SELECT *
FROM economies2015
ORDER BY code, year;

-- Union ALL
-- Select fields
SELECT code, year
FROM economies
    UNION ALL
SELECT country_code, year
FROM populations
ORDER BY code, year;