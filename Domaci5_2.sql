USE bootcamp.nothern_star;
--Domaci5_2
--1
WITH prozor AS(
SELECT 
team_id, season, match_id, kickoff_ts, goals_for
, AVG(goals_for) OVER w AS avg_gol
, COUNT(*) OVER w AS n
FROM team_matches 
WINDOW w as (
        PARTITION BY team_id, season
        ORDER BY kickoff_ts, match_id))
SELECT teams.team_id, teams.team_name, prozor.season, prozor.match_id, prozor.kickoff_ts,
prozor.avg_gol as prosek_u_posl_5
FROM prozor
JOIN teams ON teams.team_id=prozor.team_id
WHERE n=5
QUALIFY DENSE_RANK() OVER (ORDER BY prozor.avg_gol DESC)=1;

--2
WITH zbir AS (
SELECT team_id, kickoff_ts, match_id, goals_for,
SUM(goals_for) OVER w AS sum_gol
, COUNT (*) OVER w AS n
FROM team_matches
WHERE season='2024/25'
WINDOW w AS(
    PARTITION BY team_id
    ORDER BY kickoff_ts, match_id
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )
)    

SELECT zbir.team_id, teams.team_name ,zbir.n, zbir.sum_gol,zbir.kickoff_ts, zbir.match_id
FROM zbir
JOIN teams ON teams.team_id=zbir.team_id
WHERE sum_gol>=50
QUALIFY DENSE_RANK() OVER (ORDER BY zbir.kickoff_ts)=1;

--3
SELECT t.team_id, t.season,t.kickoff_ts, t.match_id
, m.attendance  AS att
, LAG(m.attendance) OVER w AS prethodni
,m.attendance - LAG(m.attendance) OVER w AS prethodni_razlika
FROM team_matches t
JOIN matches m ON m.match_id=t.match_id
WHERE t.venue='home'
WINDOW w as (
        PARTITION BY t.team_id, t.season
        ORDER BY t.kickoff_ts, t.match_id)
ORDER BY prethodni_razlika ASC NULLS LAST
LIMIT 1;
--prvi red je naveci pad, jer je posecenost nula u odnosu na prethodnu 17864

