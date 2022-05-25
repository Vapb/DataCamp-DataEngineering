-- Hello World
SELECT 'Hello World' AS result;

-- Simple Select
SELECT name
FROM films;

-- SELECTing multiple columns
SELECT title, release_year, country
FROM films;

-- SELECT ALL COLS
SELECT * 
FROM films;

-- SELECT DISTINCT
SELECT country
FROM films;

-- COUNT -> Count does not count missing
SELECT COUNT(*)
FROM films;

-- COUNT AND DISTINCT
SELECT COUNT(DISTINCT languages)
FROM films;

-- WHERE
SELECT title, release_year
FROM films
WHERE release_year > 2000;

SELECT *
FROM films
WHERE language = 'French';

-- AND OR
SELECT title, release_year
FROM films
WHERE (release_year >= 1990 AND release_year < 2000)
AND (language = 'French' OR language = 'Spanish')
AND (gross > 2000000)

-- BETWEEN
SELECT title, release_year
FROM films
WHERE release_year BETWEEN 1990 AND 2000

-- IN
SELECT title, language
FROM films
WHERE language IN ('English', 'Spanish', 'French')

-- NULL 
SELECT name
FROM people
WHERE deathdate IS NULL

-- LIKE, NOT LIKE
SELECT name
FROM people
WHERE name LIKE 'B%'

SELECT name
FROM people
WHERE name NOT LIKE 'A%'

-- Aggregate Functions
-- SUM
SELECT SUM(duration)
FROM films;

-- AVG
SELECT AVG(duration)
FROM films;

-- MIN
SELECT MIN(duration)
FROM films;

-- MAX
SELECT MAX(duration)
FROM films;

-- ALIAS AS 
SELECT title, (gross - budget) AS net_profit
FROM films

SELECT COUNT(deathdate) * 100.0 / COUNT(NAME) AS percentage_dead
FROM people

