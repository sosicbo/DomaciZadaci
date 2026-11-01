USE bootcamp.nothern_star;
--Domaci zadatak 6.1
--1
SELECT COUNT(*) FROM players; --681
CREATE SCHEMA IF NOT EXISTS bootcamp.sandbox;
USE bootcamp.sandbox;

DESCRIBE bootcamp.nothern_star.players;

CREATE OR REPLACE TABLE dim_player AS
SELECT
player_id,
first_name,
last_name,
position,
nationality
FROM bootcamp.nothern_star.players;

SELECT COUNT(*) FROM dim_player; --681

--2
CREATE OR REPLACE TABLE dim_date AS
SELECT CAST(DATE_FORMAT(d, 'yyyyMMdd') AS INT) AS date_key,
       d                                       AS full_date,
       DATE_FORMAT(d, 'EEEE')                  AS weekday_name,
       DAYOFWEEK(d) IN (1, 7)                  AS is_weekend,
       CASE WHEN MONTH(d) >= 7 THEN CONCAT(YEAR(d), '/', SUBSTRING(CAST(YEAR(d) + 1 AS STRING), 3, 2))
            ELSE CONCAT(YEAR(d) - 1, '/', SUBSTRING(CAST(YEAR(d) AS STRING), 3, 2))
       END                                     AS season
FROM (SELECT EXPLODE(SEQUENCE(DATE'2023-07-01', DATE'2025-06-30', INTERVAL 1 DAY)) AS d);

SELECT * FROM dim_date;

CREATE OR REPLACE TABLE fact_player_match AS
SELECT
s.match_id,                                            
CAST(DATE_FORMAT(m.kickoff_ts, 'yyyyMMdd') AS INT) AS date_key,
s.player_id,
s.team_id,
s.minutes_played,
s.shots,
s.passes,
s.rating
FROM bootcamp.nothern_star.player_match_stats s
JOIN bootcamp.nothern_star.matches m ON m.match_id = s.match_id
WHERE m.status = 'played';

SELECT COUNT(*) FROM fact_player_match;--30400
--Jedan red-jedan igrac na jednoj utakmici
--30400

--3
SELECT
p.position,
ROUND(AVG(f.rating), 2) AS prosecna_ocena
FROM fact_player_match f
JOIN dim_player p ON p.player_id=f.player_id
JOIN dim_date d ON d.date_key=f.date_key
WHERE d.season='2024/25'
GROUP BY p.position
ORDER BY prosecna_ocena DESC;

--4
ALTER TABLE fact_player_match ADD COLUMNS (goals INT);
--SELECT * FROM fact_player_match;
--UPDATE fact_player_match SET goals=0;
--SELECT COUNT(*) FROM fact_player_match;
UPDATE fact_player_match f
SET goals=( SELECT COUNT(*)
            FROM bootcamp.nothern_star.match_events e
            WHERE e.match_id=f.match_id AND e.player_id=f.player_id AND e.event_type IN ('goal', 'penalty_goal')
);
SELECT SUM(goals) FROM fact_player_match;--2043



