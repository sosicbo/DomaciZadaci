--Domaci zadatak 2.2.
USE bootcamp.nothern_star;

--SELECT * FROM bootcamp.nothern_star.matches_flat LIMIT 50;
--1
SELECT match_id,match_report, home_team, away_team
FROM matches_flat 
WHERE match_report ILIKE '%goal%';

--2
SELECT match_id
, COALESCE(referee_name, 'Unknown') AS referee_name
FROM matches_flat 
ORDER BY match_id
LIMIT 20;

--3
SELECT match_id
, match_report, LENGTH(match_report) as len_match_report
FROM matches_flat 
WHERE LENGTH(match_report)>40;


--4
SELECT match_id,kickoff_ts, home_team, away_team
FROM matches_flat 
WHERE kickoff_ts >= '2025-01-01' AND kickoff_ts < '2025-01-16'
AND status='played';

--5
SELECT COUNT(*) AS num_friday
FROM matches_flat
WHERE dayofweek(kickoff_ts)=6;
--rezultat 0

SELECT match_id,kickoff_ts,DATE_FORMAT(kickoff_ts, 'EEEE') AS weekday_name, dayofweek(kickoff_ts) AS day_num, to_date(kickoff_ts) as datum
FROM matches_flat 
WHERE dayofweek(kickoff_ts)=6;

--6
SELECT COUNT(*) AS match_num
--SELECT match_id, season, attendance
FROM matches_flat
WHERE season='2024/25' AND attendance BETWEEN 20000 AND 35000;
--188

--7
SELECT DISTINCT first_goal_scorer
FROM matches_flat
WHERE first_goal_scorer like 'A%' OR 
first_goal_scorer like '%-%';

--8
SELECT match_id, season, kickoff_ts, home_team, away_team
FROM matches_flat
WHERE season='2024/25' AND
date_format(kickoff_ts, 'HH:mm:ss') >='18:00:00' AND  date_format(kickoff_ts, 'HH:mm:ss') <'21:00:01';

--9
SELECT COUNT(*) AS broj
FROM matches_flat
WHERE MONTH(kickoff_ts) IN (3,4,5)
AND YEAR(kickoff_ts)=2025
AND match_report ILIKE '%win%'
AND status='played';
--rezultat 5

--Dodatni zadaci

--1
SELECT COUNT(*) as br
FROM matches_flat
WHERE referee_name IS NULL AND attendance IS NULL;
--0

--2
SELECT match_id, home_team, away_team, kickoff_ts
FROM matches_flat
WHERE kickoff_ts >= '2025-03-01' AND kickoff_ts<'2025-04-01'
AND status='played'
ORDER BY kickoff_ts; 

--3
/*SELECT match_id, home_team, away_team, kickoff_ts
FROM matches_flat
WHERE kickoff_ts >= '2024-12-20' AND kickoff_ts<'2025-01-11'
AND status='played';*/

SELECT COUNT(*) as num_match
FROM matches_flat
WHERE kickoff_ts >= '2024-12-20' AND kickoff_ts<'2025-01-11'
AND status='played';

--4
SELECT kickoff_ts, home_team, away_team
, COALESCE(CAST(attendance AS STRING), 'Unknown') AS attendance_status
FROM matches_flat;

--5
SELECT match_id, home_team, away_team, kickoff_ts, home_goals,away_goals, home_goals+away_goals AS sum_goal
FROM matches_flat
WHERE kickoff_ts >= '2025-04-01' AND kickoff_ts<'2025-05-01'
AND (home_goals+away_goals) between 2 AND 4
AND status='played'
ORDER BY kickoff_ts; 

--6
SELECT match_id, home_team, away_team, kickoff_ts
, CONCAT(home_goals_ht,':',away_goals_ht) AS ht_score
, CONCAT(home_goals,':',away_goals) AS score_final
FROM matches_flat
WHERE home_goals_ht=away_goals_ht
AND (home_goals<>away_goals);
--ako se misli razlicit od statusa neresen

SELECT match_id, home_team, away_team, kickoff_ts
, CONCAT(home_goals_ht,':',away_goals_ht) AS ht_score
, CONCAT(home_goals,':',away_goals) AS score_final
FROM matches_flat
WHERE home_goals_ht=away_goals_ht
AND (CONCAT(home_goals_ht,':',away_goals_ht)<>CONCAT(home_goals,':',away_goals));
--ako se misli razlicit u smislu moze i neresen ali ne istog rezultata kao na poluvremenu













