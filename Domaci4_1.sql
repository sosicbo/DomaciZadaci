USE bootcamp.nothern_star;

--Domaci 4.1
--1
SELECT 
COUNT(*)
FROM matches m
JOIN player_match_stats ps ON m.match_id=ps.match_id
WHERE m.season='2024/25';--15200

--tabele meceva i statistike(player_match_stats) su u odnosu one to many
--Dobija se jedan red po statistici a podaci o mecevima se ponavljaju po podacima sadrzanim u statistici kao npr razliciti igraci

--2
WITH IgracSezona AS (SELECT s.player_id, m.season
, COUNT(DISTINCT s.team_id) AS br
FROM player_match_stats s
JOIN matches m on m.match_id=s.match_id AND m.status='played'
GROUP BY s.player_id, m.season
HAVING br=2
ORDER BY 1)

SELECT COUNT(*) FROM IgracSezona; --35

--3
WITH kartoni_poMecu AS (SELECT m.match_id
                        ,COUNT(e.event_type) as br
                        FROM matches m
                        LEFT JOIN match_events e ON e.match_id=m.match_id AND event_type IN ('yellow_card','second_yellow','red_card')
                        WHERE m.status='played'
                        GROUP BY m.match_id
                        ORDER BY 1)

--SELECT AVG(br) FROM kartoni_poMecu--3.5236842105263158

SELECT COUNT(*)
FROM kartoni_poMecu
WHERE br>(SELECT AVG(br) FROM kartoni_poMecu);--370

--4
SELECT COUNT(p.player_id) FROM players p
WHERE p.player_id IN (SELECT s.player_id
                    FROM player_match_stats s
                    JOIN matches m ON m.match_id=s.match_id
                    WHERE m.season='2024/25' AND m.status='played'
                    AND s.minutes_played>0
                    GROUP BY s.player_id
                    HAVING count(DISTINCT s.match_id)>10);--383
--5
SELECT h.team_id, h.team_name
FROM matches m
JOIN teams h ON h.team_id=m.home_team_id
WHERE m.season='2024/25' AND m.status='played' 
UNION
SELECT a.team_id, a.team_name
FROM matches m
JOIN teams a ON a.team_id=m.away_team_id   
WHERE m.season='2024/25' AND m.status='played';

SELECT h.team_id, h.team_name
FROM matches m
JOIN teams h ON h.team_id=m.home_team_id
WHERE m.season='2024/25' AND m.status='played' 
UNION ALL
SELECT a.team_id, a.team_name
FROM matches m
JOIN teams a ON a.team_id=m.away_team_id   
WHERE m.season='2024/25' AND m.status='played';

SELECT COUNT(*) FROM matches
WHERE season = '2024/25' AND status = 'played';--380

--svaki mec daje dva reda - za gosta i domacina
--kada se koristi UNION ne prikazuju se duplikati tima pa daje 20 redova jedinstvenih klubova a kada se koristi UNION ALL se prikazuju 760 redova jer se svaki klub prikazuje onoliko puta koliko je meceva odigrao 38*20










