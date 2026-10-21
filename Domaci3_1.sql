USE bootcamp.nothern_star;
--Domaci 3.1

--1
SELECT season 
, COUNT(*) AS num_match
, SUM(home_goals+away_goals) AS sum_goals
, AVG(home_goals+away_goals) AS avg_goals
FROM matches_flat
WHERE status='played'
GROUP BY season;

--2
SELECT stadium_name 
, MIN(attendance) AS min_att
, MAX(attendance) AS max_att
, AVG(attendance) AS avg_att
, COUNT(match_id) AS num_match
FROM matches_flat
WHERE attendance IS NOT NULL
GROUP BY stadium_name ;

--3
SELECT referee_name
, COUNT(match_id) AS num_match
, SUM(home_yellow_cards+away_yellow_cards) AS sum_yellow_cards
FROM matches_flat
WHERE status='played'
GROUP BY referee_name
HAVING num_match>=10 AND sum_yellow_cards>=20;

--4
SELECT 
CASE WHEN COALESCE(home_goals,0)+COALESCE(away_goals,0)>=3 THEN 'Mnogo golova' 
    WHEN COALESCE(home_goals,0)+COALESCE(away_goals,0) BETWEEN 1 AND 2 THEN 'Malo golova'
    WHEN COALESCE(home_goals,0)+COALESCE(away_goals,0)=0 THEN 'Bez golova'
    ELSE 'Error' END AS `Kategorija`
, COUNT(*) AS num_match
, MAX(COALESCE(home_goals,0)+COALESCE(away_goals,0)) as max_goals     
FROM matches_flat
WHERE status='played'
GROUP BY `Kategorija`;

--5
SELECT home_team
, COUNT(*) AS num_home
, SUM(CASE WHEN home_goals> away_goals THEN 1 ELSE 0 END) AS sum_win 
, SUM(CASE WHEN home_goals<away_goals THEN 1 ELSE 0 END) AS sum_lose 
FROM matches_flat
WHERE status='played'
GROUP BY home_team
HAVING num_home>=10;

--6
SELECT referee_name
, COUNT(match_id) AS num_match
, SUM(CASE WHEN (home_red_cards+away_red_cards)>0 THEN 1 ELSE 0 END) AS sum_red_cards
, (100*(SUM(CASE WHEN (home_red_cards+away_red_cards)>0 THEN 1 ELSE 0 END)))/COUNT(match_id) AS perc_red
FROM matches_flat
WHERE status='played'
GROUP BY referee_name;

--7
SELECT season 
, COUNT(*) as num_match
, SUM(CASE WHEN home_goals> away_goals THEN 1 ELSE 0 END) AS win_home
, SUM(CASE WHEN home_goals=away_goals THEN 1 ELSE 0 END) AS num_even
,SUM(CASE WHEN home_goals< away_goals THEN 1 ELSE 0 END) AS win_away
, (100*(SUM(CASE WHEN home_goals=away_goals THEN 1 ELSE 0 END)))/COUNT(*) AS perc_even
FROM matches_flat
WHERE status='played'
GROUP BY season;



