USE bootcamp.nothern_star;
--5.1
--1
SELECT
p.player_id, p.first_name, p.last_name
, COUNT(*) as br_golova
, DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) as dense_rnk
FROM match_events e 
INNER JOIN matches m ON e.match_id=m.match_id 
INNER JOIN players p on e.player_id=p.player_id 
WHERE m.season='2024/25' AND m.status='played' AND e.event_type IN ('goal','penalty_goal')
GROUP BY p.player_id, p.first_name, p.last_name
ORDER BY dense_rnk, p.player_id, p.first_name, p.last_name;
--INNER JOIN -ovima je iskljucen slucaj da igrac moze da ima 0 golova, pa je suvisan dodatni uslov

--2
SELECT t.team_id, t.team_name, p.first_name, p.last_name
, COUNT(*) as br_golova
, ROW_NUMBER() OVER (PARTITION BY t.team_id ORDER BY COUNT(*) DESC, p.player_id) as rn
FROM match_events e 
INNER JOIN matches m ON e.match_id=m.match_id 
INNER JOIN players p ON e.player_id=p.player_id 
INNER JOIN teams t ON e.team_id=t.team_id
WHERE m.season='2024/25' AND m.status='played' AND e.event_type IN ('goal','penalty_goal')
GROUP BY t.team_id, t.team_name,p.player_id, p.first_name, p.last_name
QUALIFY rn<=3
ORDER BY t.team_id, rn;

--3
SELECT m.match_id, m.kickoff_ts, t.team_id, t.team_name
, COUNT(e.event_id) as br_golova
, LAG(COUNT(e.event_id)) OVER (PARTITION BY t.team_id ORDER BY m.kickoff_ts) as prethodni_golovi
, COUNT(e.event_id)-LAG(COUNT(e.event_id)) OVER (PARTITION BY t.team_id ORDER BY m.kickoff_ts) as razlika
FROM matches m 
LEFT JOIN teams t ON t.team_id IN (home_team_id, away_team_id)
LEFT JOIN match_events e ON e.match_id=m.match_id AND e.team_id=t.team_id AND e.event_type IN ('goal','penalty_goal')
WHERE m.season='2024/25' AND m.status='played' 
GROUP BY m.match_id,m.kickoff_ts,t.team_id, t.team_name
ORDER BY t.team_name, m.kickoff_ts;

