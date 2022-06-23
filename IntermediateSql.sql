--- CASE
-- Case When Then  (CASE RETURN THEN when WHEN IS MEET)
SELECT 
	CASE WHEN hometeam_id = 10189 THEN 'FC Schalke 04'
        WHEN hometeam_id = 9823 THEN 'FC Bayern Munich'
        ELSE 'Other' END AS home_team,
	COUNT(id) AS total_matches
FROM matches_germany
GROUP BY home_team;

SELECT 
	date,
	CASE WHEN home_goal > away_goal THEN 'Home win!'
         WHEN home_goal < away_goal THEN 'Home loss :(' 
         ELSE 'Tie' END AS outcome
FROM matches_spain;

SELECT 
	date,
	CASE WHEN hometeam_id = 8634 THEN 'FC Barcelona' 
             ELSE 'Real Madrid CF' END AS home,
	CASE WHEN awayteam_id = 8634 THEN 'FC Barcelona' 
             ELSE 'Real Madrid CF' END AS away
FROM matches_spain
WHERE (awayteam_id = 8634 OR hometeam_id = 8634)
      AND (awayteam_id = 8633 OR hometeam_id = 8633);

SELECT 
	season,
    date,
	home_goal,
	away_goal
FROM matches_italy
WHERE 
-- Exclude games not won by Bologna
	CASE WHEN hometeam_id = 9857 AND home_goal > away_goal THEN 'Bologna Win'
		 WHEN awayteam_id = 9857 AND away_goal > home_goal THEN 'Bologna Win' 
		 END IS NOT NULL;

-- CASE IN WHERE CLAUSE
SELECT *
FROM Customer
WHERE Salary =
    CASE
    WHEN First_Name = 'RAM' THEN Salary
    WHEN Last_Name = 'SHARMA' THEN Salary
    ELSE NULL 
    END;


-- CASE WHEN AGREGATE
--- CASE COUNT -> COUNT EVERY THEN WHEN CASE IS MEET 
SELECT season,
       COUNT (CASE WHEN hometeam_id = 8650 AND home_goal > away_goal THEN id END) AS home_wins,
       COUNT (CASE WHEN awayteam_id = 8650 AND home_goal < away_goal THEN id END) AS away_wins
FROM match
GROUP BY season;

--- CASE SUM
SELECT season,
       SUM (CASE WHEN hometeam_id = 8650 THEN home_goal END) AS all_homegoals,
       SUM (CASE WHEN awayteam_id = 8650 THEN away_goal END) AS all_awaygoals
FROM match
GROUP BY season;

--- CASE AVG
SELECT season,
       AVG (CASE WHEN hometeam_id = 8650 THEN home_goal END) AS avg_homegoals,
       AVG (CASE WHEN awayteam_id = 8650 THEN away_goal END) AS avg_awaygoals
FROM match
GROUP BY season;

--- CASE to get percentage with AVG
SELECT season,
       AVG (CASE WHEN hometeam_id = 8650 AND home_goal > away_goal THEN 1
                 WHEN hometeam_id = 8650 AND home_goal < away_goal THEN 0
                 END) AS pct_homewins,
       AVG (CASE WHEN awayteam_id = 8650 AND away_goal > home_goal THEN 1
                 WHEN awayteam_id = 8650 AND away_goal < home_goal THEN 0
                 END) AS pct_awaywins,
FROM match
GROUP BY season;

--- Example CASE SUM
SELECT 
	c.name AS country,
    -- Sum the total records in each season where the home team won
	SUM(CASE WHEN m.season = '2012/2013' AND m.home_goal > m.away_goal 
        THEN 1 ELSE 0 END) AS matches_2012_2013,
 	SUM(CASE WHEN m.season = '2013/2014' AND m.home_goal > m.away_goal 
        THEN 1 ELSE 0 END) AS matches_2013_2014,
	SUM(CASE WHEN m.season = '2014/2015' AND m.home_goal > m.away_goal
        THEN 1 ELSE 0 END) AS matches_2014_2015
FROM country AS c
LEFT JOIN match AS m
ON c.id = m.country_id
-- Group by country name alias
GROUP BY country;





--- SUBQUERIES
--Subqueries can return Scalar quantities (3.1112, -2, 0.0202); A list (id=(1,2,3)); A table.

-- Simple subquery
SELECT 
	-- Select the date, home goals, and away goals scored
    date,
	home_goal,
	away_goal
FROM  matches_2013_2014
-- Filter for matches where total goals exceeds 3x the average
WHERE (home_goal + away_goal) > 
       (SELECT 3 * AVG(home_goal + away_goal)
        FROM matches_2013_2014); 

-- Filtering using a subquery with a list
SELECT 
	-- Select the team long and short names
	team_long_name,
	team_short_name
FROM team 
-- Exclude all values from the subquery
WHERE team_api_id NOT IN
     (SELECT DISTINCT hometeam_id FROM match);


-- Subqueries in FROM -> Prefiltering your data; Calculating Aggregates.

SELECT
	-- Select country name and the count match IDs
    c.name AS country_name,
    COUNT(sub.id) AS matches
FROM country AS c
-- Inner join the subquery onto country
-- Select the country id and match id columns
INNER JOIN (SELECT country_id, id 
           FROM match
           -- Filter the subquery by matches with 10+ goals
           WHERE (home_goal + away_goal) >= 10) AS sub
ON c.id = sub.country_id
GROUP BY country_name;


-- Subqueries in SELECT -> Return single value, good for calculations

SELECT 
	l.name AS league,
    -- Select and round the league's total goals
    ROUND(AVG(m.home_goal + m.away_goal), 2) AS avg_goals,
    -- Select & round the average total goals for the season
    (SELECT ROUND(AVG(m.home_goal + m.away_goal), 2) 
     FROM match as m
     WHERE season = '2013/2014') AS overall_avg
FROM league AS l
LEFT JOIN match AS m
ON l.country_id = m.country_id
-- Filter for the 2013/2014 season
WHERE season = '2013/2014'
GROUP BY league;

SELECT
	-- Select the league name and average goals scored
	l.name AS league,
	ROUND(AVG(m.home_goal + m.away_goal), 2) AS avg_goals,
    -- Subtract the overall average from the league average
	ROUND(AVG(m.home_goal + m.away_goal) - 
		(SELECT AVG(home_goal + away_goal)
		 FROM match 
         WHERE season = '2013/2014'),2) AS diff
FROM league AS l
LEFT JOIN match AS m
ON l.country_id = m.country_id
-- Only include 2013/2014 results
WHERE season = '2013/2014'
GROUP BY l.name;

-- Multiple Subquerys
SELECT 
	-- Select the stage and average goals from s
	s.stage,
    ROUND(s.avg_goals,2) AS avg_goal,
    -- Select the overall average for 2012/2013
    (SELECT AVG(home_goal + away_goal) FROM match WHERE season = '2012/2013') AS overall_avg
FROM 
	-- Select the stage and average goals in 2012/2013 from match
	(SELECT
		 stage,
         AVG(home_goal + away_goal) AS avg_goals
	 FROM match
	 WHERE season = '2012/2013'
	 GROUP BY stage) AS s
WHERE 
	-- Filter the main query using the subquery
	s.avg_goals > (SELECT AVG(home_goal + away_goal) 
                    FROM match WHERE season = '2012/2013');