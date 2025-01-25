-- use practise;

-- create table icc_world_cup
-- (
-- Team_1 Varchar(20),
-- Team_2 Varchar(20),
-- Winner Varchar(20)
-- );

-- INSERT INTO icc_world_cup values('India','SL','India');
-- INSERT INTO icc_world_cup values('SL','Aus','Aus');
-- INSERT INTO icc_world_cup values('SA','Eng','Eng');
-- INSERT INTO icc_world_cup values('Eng','NZ','NZ');
-- INSERT INTO icc_world_cup values('Aus','India','India');
INSERT INTO icc_world_cup values('Aus','India','Draw');

select * from icc_world_cup;

select team, COUNT(MatchesPlayed) AS MatchesPlayed, SUM(win_flag) AS Wins, COUNT(MatchesPlayed) - SUM(win_flag) AS Losses, SUM(draw_flag) AS Draws
from 
(
select team_1 AS team , COUNT(team_1) MatchesPlayed,
sum(case when team_1 = winner then 1 else 0 end) as win_flag,
sum(case when winner!= team_1 and winner!= team_2 then 1 else 0 end) as draw_flag
from icc_world_cup
group by 1
UNION ALL 
select team_2 AS team , COUNT(team_2) MatchesPlayed,
sum(case when team_2 = winner then 1 else 0 end) as win_flag,
sum(case when winner!= team_1 and winner!= team_2 then 1 else 0 end) as draw_flag
from icc_world_cup
group by 1
) x
group by 1
order by Wins DESC;