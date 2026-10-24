--Vezba2-dosije kluba
--1
WITH club AS (SELECT team_id FROM teams WHERE team_name='Lakeside Rangers')
,
 pom AS (
SELECT m.match_id as match_id,home_team_id as team_id,'domacin' status,
CASE WHEN m.home_goals>m.away_goals THEN 'pobeda'
WHEN m.home_goals=m.away_goals THEN 'nereseno'
ELSE 'izgubio' END as rezultat
, home_goals AS dati_golovi_domacin
, 0 AS dati_golovi_gost
, away_goals AS primljeni_golovi_domacin
, 0 AS primljeni_golovi_gost
, CASE WHEN m.home_goals>m.away_goals THEN 3
WHEN m.home_goals=m.away_goals THEN 1
ELSE 0 END as bodovi
FROM matches m
WHERE m.season='2024/25' AND m.status='played'
UNION ALL
SELECT m.match_id as match_id, away_team_id as team_id,'gost' status,
CASE WHEN m.home_goals<m.away_goals THEN 'pobeda'
WHEN m.home_goals=m.away_goals THEN 'nereseno'
ELSE 'izgubio' END as rezultat
,0 AS dati_golovi_domacin
, away_goals AS dati_golovi_gost
, 0 AS primljeni_golovi_domacin
, home_goals AS primljeni_golovi_gost
,CASE WHEN m.home_goals<m.away_goals THEN 3
WHEN m.home_goals=m.away_goals THEN 1
ELSE 0 END as bodovi
FROM matches m
WHERE m.season='2024/25' AND m.status='played')

SELECT 
pom.team_id
, COUNT(match_id) as broj_utakmica
, COUNT_IF(rezultat='pobeda') as br_pobeda
, COUNT_IF(rezultat='nereseno') as br_nereseno
, COUNT_IF(rezultat='izgubio') as br_poraza
, SUM(dati_golovi_domacin+dati_golovi_gost) AS dati_golovi
, SUM(primljeni_golovi_gost+primljeni_golovi_domacin) AS primljeni_golovi
, SUM(bodovi) AS osvojeni_bodovi
FROM pom
GROUP BY team_id
HAVING team_id =(SELECT team_id FROM club);

--2. Код куће и у гостима: исти бројеви, одвојено за домаће и гостујуће утакмице
WITH club AS (SELECT team_id FROM teams WHERE team_name='Lakeside Rangers')
,pom AS (
SELECT m.match_id as match_id,m.home_team_id as team_id,'domacin' status,
CASE WHEN m.home_goals>m.away_goals THEN 'pobeda'
WHEN m.home_goals=m.away_goals THEN 'nereseno'
ELSE 'izgubio' END as rezultat
, m.home_goals AS dati_golovi_domacin
, 0 AS dati_golovi_gost
, m.away_goals AS primljeni_golovi_domacin
, 0 AS primljeni_golovi_gost
, CASE WHEN m.home_goals>m.away_goals THEN 3
WHEN m.home_goals=m.away_goals THEN 1
ELSE 0 END as bodovi
FROM matches m
WHERE m.season='2024/25' AND m.status='played'
UNION ALL
SELECT m.match_id as match_id, m.away_team_id as team_id,'gost' status,
CASE WHEN m.home_goals<m.away_goals THEN 'pobeda'
WHEN m.home_goals=m.away_goals THEN 'nereseno'
ELSE 'izgubio' END as rezultat
,0 AS dati_golovi_domacin
, m.away_goals AS dati_golovi_gost
, 0 AS primljeni_golovi_domacin
, m.home_goals AS primljeni_golovi_gost
,CASE WHEN m.home_goals<m.away_goals THEN 3
WHEN m.home_goals=m.away_goals THEN 1
ELSE 0 END as bodovi
FROM matches m
WHERE m.season='2024/25' AND m.status='played')
SELECT
pom.team_id,pom.status
, COUNT(match_id) as broj_utakmica
, COUNT_IF(rezultat='pobeda') as br_pobeda
, COUNT_IF(rezultat='nereseno') as br_nereseno
, COUNT_IF(rezultat='izgubio') as br_poraza
, SUM(dati_golovi_domacin+dati_golovi_gost) AS dati_golovi
, SUM(primljeni_golovi_gost+primljeni_golovi_domacin) AS primljeni_golovi
, SUM(bodovi) AS osvojeni_bodovi
FROM pom
GROUP BY pom.team_id,pom.status
HAVING team_id =(SELECT team_id FROM club);

--3. Стрелци: три најбоља стрелца клуба и најбољи асистент.
WITH club AS (SELECT team_id FROM teams WHERE team_name='Lakeside Rangers')
, pom AS (
SELECT m.match_id as match_id,m.home_team_id as team_id,'domacin' status,
CASE WHEN m.home_goals>m.away_goals THEN 'pobeda'
WHEN m.home_goals=m.away_goals THEN 'nereseno'
ELSE 'izgubio' END as rezultat
, m.home_goals AS dati_golovi_domacin
, 0 AS dati_golovi_gost
, m.away_goals AS primljeni_golovi_domacin
, 0 AS primljeni_golovi_gost
, CASE WHEN m.home_goals>m.away_goals THEN 3
WHEN m.home_goals=m.away_goals THEN 1
ELSE 0 END as bodovi
FROM matches m
WHERE m.season='2024/25' AND m.status='played'
UNION ALL
SELECT m.match_id as match_id, m.away_team_id as team_id,'gost' status,
CASE WHEN m.home_goals<m.away_goals THEN 'pobeda'
WHEN m.home_goals=m.away_goals THEN 'nereseno'
ELSE 'izgubio' END as rezultat
,0 AS dati_golovi_domacin
, m.away_goals AS dati_golovi_gost
, 0 AS primljeni_golovi_domacin
, m.home_goals AS primljeni_golovi_gost
,CASE WHEN m.home_goals<m.away_goals THEN 3
WHEN m.home_goals=m.away_goals THEN 1
ELSE 0 END as bodovi
FROM matches m
WHERE m.season='2024/25' AND m.status='played')

SELECT p.player_id, p.first_name, p.last_name
,COUNT(e.event_type) as br_golova
,COUNT_IF(e.event_type='penalty_goal') AS br_iz_penala
FROM match_events e
JOIN pom on pom.match_id=e.match_id AND pom.team_id=e.team_id
JOIN players p on p.player_id=e.player_id
WHERE e.event_type IN ('goal', 'penalty_goal')
AND pom.team_id =(SELECT team_id FROM club)
GROUP BY p.player_id, p.first_name, p.last_name
ORDER BY br_golova DESC
LIMIT 3;

SELECT p.player_id, p.first_name, p.last_name
,COUNT(e.event_type) as br_asistencija
FROM match_events e
JOIN pom on pom.match_id=e.match_id AND pom.team_id=e.team_id
JOIN players p on p.player_id=e.related_player_id
WHERE e.event_type IN ('goal', 'penalty_goal')
AND pom.team_id =(SELECT team_id FROM club)
GROUP BY p.player_id, p.first_name, p.last_name
ORDER BY br_asistencija DESC
LIMIT 1;

--4
WITH club AS (SELECT team_id FROM teams WHERE team_name='Lakeside Rangers')
,pom AS (
SELECT m.match_id as match_id,m.home_team_id as team_id,'domacin' status,
CASE WHEN m.home_goals>m.away_goals THEN 'pobeda'
WHEN m.home_goals=m.away_goals THEN 'nereseno'
ELSE 'izgubio' END as rezultat
, m.home_goals AS dati_golovi_domacin
, 0 AS dati_golovi_gost
, m.away_goals AS primljeni_golovi_domacin
, 0 AS primljeni_golovi_gost
, CASE WHEN m.home_goals>m.away_goals THEN 3
WHEN m.home_goals=m.away_goals THEN 1
ELSE 0 END as bodovi
FROM matches m
WHERE m.season='2024/25' AND m.status='played'
UNION ALL
SELECT m.match_id as match_id, m.away_team_id as team_id,'gost' status,
CASE WHEN m.home_goals<m.away_goals THEN 'pobeda'
WHEN m.home_goals=m.away_goals THEN 'nereseno'
ELSE 'izgubio' END as rezultat
,0 AS dati_golovi_domacin
, m.away_goals AS dati_golovi_gost
, 0 AS primljeni_golovi_domacin
, m.home_goals AS primljeni_golovi_gost
,CASE WHEN m.home_goals<m.away_goals THEN 3
WHEN m.home_goals=m.away_goals THEN 1
ELSE 0 END as bodovi
FROM matches m
WHERE m.season='2024/25' AND m.status='played')
, kartoni_tim_mec AS(SELECT pom.team_id, pom.match_id
,COUNT(e.event_type) as broj_kartona
FROM pom 
LEFT JOIN match_events e on pom.match_id=e.match_id AND pom.team_id=e.team_id
AND e.event_type IN ('yellow_card', 'second_yellow','red_card')
--AND pom.team_id =(SELECT team_id FROM club)
GROUP BY pom.team_id, pom.match_id)

SELECT ROUND(AVG(CASE WHEN team_id =(SELECT team_id FROM club) THEN broj_kartona END),2) AS kartoni_tima
, ROUND(AVG(broj_kartona),2) as kartoni_liga
FROM kartoni_tim_mec;

--5
WITH club AS (SELECT team_id FROM teams WHERE team_name='Lakeside Rangers')
,  pom AS (
SELECT m.match_id as match_id,m.home_team_id as team_id,'domacin' status,
CASE WHEN m.home_goals>m.away_goals THEN 'pobeda'
WHEN m.home_goals=m.away_goals THEN 'nereseno'
ELSE 'izgubio' END as rezultat
, m.home_goals AS dati_golovi_domacin
, 0 AS dati_golovi_gost
, m.away_goals AS primljeni_golovi_domacin
, 0 AS primljeni_golovi_gost
, CASE WHEN m.home_goals>m.away_goals THEN 3
WHEN m.home_goals=m.away_goals THEN 1
ELSE 0 END as bodovi
,m.kickoff_ts 
FROM matches m
WHERE m.season='2024/25' AND m.status='played'
UNION ALL
SELECT m.match_id as match_id, m.away_team_id as team_id,'gost' status,
CASE WHEN m.home_goals<m.away_goals THEN 'pobeda'
WHEN m.home_goals=m.away_goals THEN 'nereseno'
ELSE 'izgubio' END as rezultat
,0 AS dati_golovi_domacin
, m.away_goals AS dati_golovi_gost
, 0 AS primljeni_golovi_domacin
, m.home_goals AS primljeni_golovi_gost
,CASE WHEN m.home_goals<m.away_goals THEN 3
WHEN m.home_goals=m.away_goals THEN 1
ELSE 0 END as bodovi
,m.kickoff_ts 
FROM matches m
WHERE m.season='2024/25' AND m.status='played')

SELECT ms.spell_id,ms.manager_name, ms.start_date, ms.end_date
, COUNT(pom.match_id) as br_meceva
, SUM(bodovi) as bodovi
, ROUND(SUM(bodovi)/COUNT(pom.match_id),2) as bodovi_po_mecu
FROM pom
JOIN club ON club.team_id=pom.team_id
LEFT JOIN manager_spells ms ON ms.team_id=pom.team_id AND (pom.kickoff_ts >=ms.start_date AND pom.kickoff_ts<COALESCE(ms.end_date, '9999-12-31'))
GROUP BY ms.spell_id,ms.manager_name, ms.start_date, ms.end_date;

--6
WITH club AS (SELECT team_id FROM teams WHERE team_name='Lakeside Rangers')
,  pom AS (
SELECT m.match_id as match_id,m.home_team_id as team_id,'domacin' status,
CASE WHEN m.home_goals>m.away_goals THEN 'pobeda'
WHEN m.home_goals=m.away_goals THEN 'nereseno'
ELSE 'izgubio' END as rezultat
, m.home_goals AS dati_golovi_domacin
, 0 AS dati_golovi_gost
, m.away_goals AS primljeni_golovi_domacin
, 0 AS primljeni_golovi_gost
, CASE WHEN m.home_goals>m.away_goals THEN 3
WHEN m.home_goals=m.away_goals THEN 1
ELSE 0 END as bodovi
,m.kickoff_ts 
, m.away_team_id AS protivnik
FROM matches m
WHERE m.season='2024/25' AND m.status='played'
UNION ALL
SELECT m.match_id as match_id, m.away_team_id as team_id,'gost' status,
CASE WHEN m.home_goals<m.away_goals THEN 'pobeda'
WHEN m.home_goals=m.away_goals THEN 'nereseno'
ELSE 'izgubio' END as rezultat
,0 AS dati_golovi_domacin
, m.away_goals AS dati_golovi_gost
, 0 AS primljeni_golovi_domacin
, m.home_goals AS primljeni_golovi_gost
,CASE WHEN m.home_goals<m.away_goals THEN 3
WHEN m.home_goals=m.away_goals THEN 1
ELSE 0 END as bodovi
,m.kickoff_ts 
,m.home_team_id AS protivnik
FROM matches m
WHERE m.season='2024/25' AND m.status='played')

SELECT
pom.match_id, pom.status, t.team_name as protivnik
, dati_golovi_domacin+dati_golovi_gost as dati
,primljeni_golovi_domacin+primljeni_golovi_gost as primljeni
, (dati_golovi_domacin+dati_golovi_gost) - (primljeni_golovi_domacin+primljeni_golovi_gost) AS razlika 
FROM pom
JOIN club ON club.team_id=pom.team_id
JOIN teams t ON pom.protivnik=t.team_id
ORDER BY razlika DESC, dati DESC
LIMIT 1;--najveca pobeda 

SELECT
pom.match_id, pom.status, t.team_name as protivnik,
primljeni_golovi_domacin+primljeni_golovi_gost as primljeni
, dati_golovi_domacin+dati_golovi_gost as dati
,(dati_golovi_domacin+dati_golovi_gost) - (primljeni_golovi_domacin+primljeni_golovi_gost) AS razlika 
FROM pom
JOIN club ON club.team_id=pom.team_id
JOIN teams t ON pom.protivnik=t.team_id
ORDER BY razlika ASC, primljeni DESC
LIMIT 1; --najveci poraz

--7
WITH club AS (SELECT team_id FROM teams WHERE team_name='Lakeside Rangers')
,  pom AS (
SELECT m.match_id as match_id,m.home_team_id as team_id,'domacin' status,
CASE WHEN m.home_goals>m.away_goals THEN 'pobeda'
WHEN m.home_goals=m.away_goals THEN 'nereseno'
ELSE 'izgubio' END as rezultat
, m.home_goals AS dati_golovi_domacin
, 0 AS dati_golovi_gost
, m.away_goals AS primljeni_golovi_domacin
, 0 AS primljeni_golovi_gost
, CASE WHEN m.home_goals>m.away_goals THEN 3
WHEN m.home_goals=m.away_goals THEN 1
ELSE 0 END as bodovi
,m.kickoff_ts 
, m.away_team_id AS protivnik
FROM matches m
WHERE m.season='2024/25' AND m.status='played'
UNION ALL
SELECT m.match_id as match_id, m.away_team_id as team_id,'gost' status,
CASE WHEN m.home_goals<m.away_goals THEN 'pobeda'
WHEN m.home_goals=m.away_goals THEN 'nereseno'
ELSE 'izgubio' END as rezultat
,0 AS dati_golovi_domacin
, m.away_goals AS dati_golovi_gost
, 0 AS primljeni_golovi_domacin
, m.home_goals AS primljeni_golovi_gost
,CASE WHEN m.home_goals<m.away_goals THEN 3
WHEN m.home_goals=m.away_goals THEN 1
ELSE 0 END as bodovi
,m.kickoff_ts 
,m.home_team_id AS protivnik
FROM matches m
WHERE m.season='2024/25' AND m.status='played')

SELECT
AVG(m.attendance) as prosecna_poseta
, COUNT_IF(m.attendance IS NULL) bez_podataka
, ROUND(100*AVG(m.attendance / s.capacity),2) as popunjenost

from matches m
LEFT JOIN pom ON pom.match_id=m.match_id AND pom.status='domacin'
JOIN club ON club.team_id=pom.team_id
JOIN stadiums s ON s.stadium_id=m.stadium_id;