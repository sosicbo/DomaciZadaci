--Domaci 3.2
USE bootcamp.nothern_star;

--1
SELECT t.team_name AS team_name, s.stadium_name AS stadium_name
FROM teams t
LEFT JOIN stadiums s ON s.stadium_id=t.stadium_id;

--2
SELECT DISTINCT p.first_name AS ime, p.last_name AS prezime, t.team_name AS klub
FROM player_match_stats s
JOIN matches m ON m.match_id=s.match_id
JOIN players p ON p.player_id=s.player_id
JOIN teams t ON t.team_id=s.team_id
WHERE m.season='2024/25' AND s.minutes_played>0
ORDER BY ime, prezime;

--3
SELECT m.match_id, CAST(m.kickoff_ts AS DATE) AS datum_odigravanja
, s.stadium_name AS stadijum, m.attendance AS broj_gledalaca
FROM matches m
LEFT JOIN stadiums s ON s.stadium_id=m.stadium_id
WHERE m.season='2024/25' AND m.status='played';

--1
SELECT m.match_id, CAST(m.kickoff_ts AS DATE) AS DATUM
, ht.team_name AS DomaciKlub, at.team_name AS GostujuciKlub
FROM matches m
LEFT JOIN teams ht ON m.home_team_id=ht.team_id
LEFT JOIN teams at ON m.away_team_id=at.team_id
WHERE (m.attendance IS NULL OR m.attendance=0) AND m.status='played'
ORDER BY DATUM,m.match_id;
--u zavisnoti od tumacenja moze se staviti i samo m.attendance IS NULL

--2
SELECT s.stadium_name AS stadijum
FROM stadiums s
LEFT JOIN matches m ON m.stadium_id=s.stadium_id AND m.season='2024/25' AND m.status='played'
WHERE m.match_id IS NULL;
--Fairhaven Lane	1

--3
SELECT t.team_id, t.team_name as klub
, COUNT(m.match_id) AS zuti_kartoni
FROM teams t
LEFT JOIN match_events e ON e.team_id=t.team_id AND e.event_type IN ('yellow_card','second_yellow')
LEFT JOIN matches m ON m.match_id=e.match_id AND m.season='2024/25'
GROUP BY t.team_id, t.team_name
ORDER BY zuti_kartoni DESC;

--1
SELECT 
p.player_id,p.first_name, p.last_name
,COUNT(m.match_id) AS br_asistencija
FROM match_events e
INNER JOIN matches m ON m.match_id=e.match_id 
INNER JOIN players p ON p.player_id=e.related_player_id
WHERE e.event_type='goal' AND m.season='2024/25'
GROUP BY p.player_id,p.first_name, p.last_name
ORDER BY br_asistencija DESC
LIMIT 5;

--2
SELECT p.first_name, p.last_name--, t.team_name
, SUM(s.minutes_played) AS odigrani_minuti
FROM player_match_stats s
INNER JOIN players p ON p.player_id=s.player_id
INNER JOIN teams t ON t.team_id=s.team_id
INNER JOIN matches m ON m.match_id=s.match_id
WHERE m.season='2024/25'
GROUP BY p.first_name, p.last_name--, t.team_name
ORDER BY odigrani_minuti DESC
LIMIT 3;

--3
SELECT m.season, t.team_name
, COUNT(e.event_type) AS br
FROM match_events e
INNER JOIN matches m ON m.match_id=e.match_id 
INNER JOIN teams t ON t.team_id=e.team_id
WHERE e.event_type IN('red_card','second_yellow')
GROUP BY m.season, t.team_name
HAVING br>0;




