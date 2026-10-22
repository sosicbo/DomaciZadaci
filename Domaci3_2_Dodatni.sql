--Dodatni zadaci 3.2
USE bootcamp.nothern_star;

--1
SELECT referee_name, 
COUNT(match_id) as br_meceva
FROM referees r
LEFT JOIN matches m ON m.referee_id=r.referee_id AND m.status='played'
GROUP BY referee_name;

--2
SELECT p.first_name, p.last_name
FROM players p
LEFT JOIN player_match_stats pm ON p.player_id=pm.player_id
WHERE pm.player_id IS NULL;

--3
SELECT t.team_name
,SUM(m.home_goals) as br_golova_domacin
FROM matches m
INNER JOIN teams t ON m.home_team_id=t.team_id
WHERE m.season='2024/25'
GROUP BY t.team_name
ORDER BY  br_golova_domacin DESC;

--1
SELECT m.season, p.position
, COUNT(me.event_id) as broj_golova
FROM matches m
INNER JOIN match_events me ON m.match_id=me.match_id AND me.event_type IN ('goal','penalty_goal')
INNER JOIN players p ON p.player_id=ME.player_id AND p.position IN ('FW','MF','DF')
GROUP BY m.season, p.position
ORDER BY broj_golova DESC;

--2
SELECT s.stadium_name
,SUM(m.attendance) as br_gledalaca
FROM stadiums s
LEFT JOIN matches m on m.stadium_id=s.stadium_id AND m.status='played'
GROUP BY s.stadium_name
ORDER BY br_gledalaca DESC;


--3
SELECT r.referee_name
, COUNT(DISTINCT e.match_id) AS broj_utakmica_penali
FROM referees r
LEFT JOIN matches m ON m.referee_id=r.referee_id 
LEFT JOIN match_events e ON e.match_id=m.match_id AND e.event_type IN ('penalty_miss','penalty_goal')
GROUP BY r.referee_name
ORDER BY broj_utakmica_penali DESC;

--1
SELECT t.team_name
, COUNT(m.match_id) as br_utakmica
FROM teams t
INNER JOIN matches m ON m.home_team_id=t.team_id AND m.season='2024/25' AND m.status='played'
GROUP BY t.team_name
ORDER BY br_utakmica DESC;

SELECT t.team_name
, COUNT(m.match_id) as br_utakmica
FROM teams t
LEFT JOIN matches m ON m.home_team_id=t.team_id AND m.season='2024/25' AND m.status='played'
GROUP BY t.team_name
ORDER BY br_utakmica DESC;
/*ukljucuje i teamove sa brojem utakmica 0
Harbor City FC	0
Dunmore County	0
Brackley Harriers	0
Fairhaven Town	0 */

--2
SELECT
p.first_name, p.last_name
, t.team_name AS klub_igraca, t2.team_name AS klub_goal
FROM match_events e
LEFT JOIN matches m ON m.match_id=e.match_id
LEFT JOIN players p ON p.player_id=e.player_id
INNER JOIN player_match_stats ps ON ps.player_id=e.player_id AND ps.match_id=e.match_id
LEFT JOIN teams t ON t.team_id=ps.team_id
LEFT JOIN teams t2 ON t2.team_id=(CASE WHEN ps.team_id=m.home_team_id THEN m.away_team_id ELSE m.home_team_id END)
WHERE e.event_type='own_goal' AND m.season='2024/25';

--3
SELECT 
t.team_name,
COUNT(DISTINCT pc.player_id) AS br_igraca
FROM player_contracts pc
JOIN teams t ON t.team_id = pc.team_id
LEFT JOIN player_match_stats ps ON ps.player_id = pc.player_id
WHERE ps.player_id IS NULL
GROUP BY t.team_id, t.team_name
ORDER BY br_igraca DESC, t.team_name;

--4
SELECT 
s.city
, COUNT(m.match_id) as broj_odigranih_utakmica
, COALESCE(SUM(m.attendance),0) AS broj_gledalaca 
FROM 
stadiums s
LEFT JOIN matches m ON m.stadium_id=s.stadium_id AND m.status='played'
GROUP BY s.city
ORDER BY broj_gledalaca DESC;

SELECT 
s.city
, COUNT(m.match_id) as broj_odigranih_utakmica
, COALESCE(SUM(m.attendance),0) AS broj_gledalaca 
FROM 
stadiums s
LEFT JOIN matches m ON m.stadium_id=s.stadium_id AND m.status='played'
GROUP BY s.city
ORDER BY broj_gledalaca DESC
LIMIT 1;

--5
SELECT DISTINCT
r.referee_name, r.nationality
FROM referees r
LEFT JOIN matches s1  ON s1.referee_id=r.referee_id and s1.season='2023/24'
LEFT JOIN matches s2  ON s2.referee_id=r.referee_id and s2.season='2024/25'
WHERE s1.referee_id IS NOT NULL AND s2.referee_id IS NULL;


