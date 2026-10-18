--Domaci zadatak 2.1.
USE bootcamp.nothern_star;

--SELECT * FROM bootcamp.nothern_star.matches_flat LIMIT 50;

--1
SELECT  
match_id, stadium_capacity, attendance
, stadium_capacity-attendance AS empty_seats
FROM matches_flat 
ORDER BY stadium_capacity-attendance DESC
LIMIT 5;
--zajednisko im je stadium_capacity od 80000

--2
SELECT COUNT(DISTINCT referee_id) AS referee_count
FROM matches_flat 
WHERE home_team='Riverton Athletic';
--ima ih 15
--dodato u DISTINC referee_id jer se moze desiti da vise sudija imaju isto ime

--3
SELECT 
match_id,away_goals_ht,home_goals_ht, home_goals,away_goals 
FROM matches_flat 
WHERE away_goals_ht>home_goals_ht 
AND home_goals>away_goals; 
--15 utakmica

SELECT COUNT(*) AS match_number
FROM matches_flat 
WHERE away_goals_ht>home_goals_ht 
AND home_goals>away_goals; 

--4
SELECT 
match_id, home_team, away_team
,CONCAT(home_goals_ht,':',away_goals_ht) AS scoreline_ht
,CONCAT(home_goals,':',away_goals) AS scoreline
,(home_goals+away_goals)-(home_goals_ht+away_goals_ht) AS top_2ht
FROM matches_flat
ORDER BY (home_goals+away_goals)-(home_goals_ht+away_goals_ht) DESC
LIMIT 1;
--Northport United-Newbury Forest	1:0	6:3	8

--5
SELECT status--COUNT(*)
FROM matches_flat 
WHERE season='2023/24' 
AND (weather='snow' OR weather='fog')
AND status='played';
--24

--6
SELECT home_team, away_team, kickoff_ts
,CONCAT(home_goals,':',away_goals) AS scoreline
, CASE WHEN home_goals>away_goals THEN home_team
        ELSE CASE WHEN home_goals=away_goals THEN 'Even'
             ELSE away_team END END AS winner
FROM matches_flat 
WHERE (home_team= 'Northport United' OR away_team = 'Northport United')
AND (home_team= 'Northport City' OR away_team = 'Northport City')
ORDER BY kickoff_ts;

--7
SELECT match_id, kickoff_ts
--HOUR(kickoff_ts), MINUTE(kickoff_ts), SECOND(kickoff_ts)
FROM matches_flat 
WHERE season='2024/25' 
--ORDER BY kickoff_ts,HOUR(kickoff_ts), MINUTE(kickoff_ts), SECOND(kickoff_ts) ;
ORDER BY kickoff_ts ASC NULLS LAST, match_id ASC
LIMIT 3;

--ima ih cak 6 sa datumom 2024-08-17T15:00:00.000+00:00
-- moze se dodati dodatni krijterijum za poredjenje sata, minuta, sekunde, milisekunde ali i oni su jednaki u ovom slucaju
--u zavisnoti od kriterijuma zadatka moze se svih 6 staviti kao redni broj 2 pa u trecu najraniju utakmicu "uci" i utakmica sa vremenom 2024-08-17T17:30:00.000+00:00
--ali da se ne bi koristio RANK() opredelila sam se za dodatni ORDER po match_id ukoliko je utakmica odigrana ranije ce imati manji ID, ako je autoincrement, iako se to moze odnositi na samo redosled unosa u bazu

--8
SELECT match_id,first_goal_scorer 
FROM matches_flat 
WHERE first_goal_scorer="Sean O'Neill";
--2 utakmice









