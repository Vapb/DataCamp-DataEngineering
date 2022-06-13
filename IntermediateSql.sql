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

