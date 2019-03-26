#1.three percenatge on tight shots? 
/* 
select 
name, avg(shot_made_flag) as three_pct
from funX.threes
where dribbles<1 and touch_time<1 
and defender_distance<(select avg(defender_distance) from funX.threes) 
group by name 
having count(*)>100 
order by 2 desc */

#avg def distance 
/* 
select avg(defender_distance) as avg, #6 ft
avg(touch_time) as avg_touch  #1.71 s 
from funX.threes */ 

/* 
#2. percent shots where defender (avg =6 ft) <3 feet? 70 for lilard 490 shots 
select 
count(shot_made_flag) as count_shots,
count(shot_made_flag)*100.0/(select count(*) from funX.threes) as percent_shots, 
name 
from funX.threes 
where defender_distance<=3 
group by name 
order by 2 desc */ 

#3. percent shots where defender < 3 and touch_time< 1s 
/* 
select 
count(shot_made_flag) as count_shots,
count(shot_made_flag)*100.0/(select count(*) from funX.threes) as percent_shots, 
name 
from funX.threes 
where defender_distance<=3 and touch_time<=0.5  
group by name 
order by 2 desc */ 

#4. percent makes on less 1 second touch and 3 feet def? 14-15
/* 
select name,
avg(shot_made_flag) as avg_pct,
count(name) as count_shots 
from funX.threes 
where defender_distance <3 and touch_time<1
group by name 
having count(*)>20 */ 

#5. defender distance with lowest 3p?
/* 
select defender_name,
count(defender_name) as count,  
avg(threes.defender_distance) as avg_def_dist,
avg(shot_made_flag) as pct_three 
from funX.threes 
where dribbles > 0.89 
group by defender_name
#having count(*) >
order by count desc */ 


#6. which players shoot best depending on dribbles?
/* 
select name,
avg(case when dribbles between 0 and 1 then shot_made_flag else null end) as three_dribble1,
count(case when dribbles between 0 and 1 then name else null end) as count_dribble1,
avg(case when dribbles between 2 and 3 then shot_made_flag else null end) as three_dribble2,
count(case when dribbles between 2 and 3 then name else null end) as count_dribble2
from funX.threes
group by name 
having count(*)>50  
order by 2 desc  */ 

#7. late game threes? all players shoot 28.4% 
/* 
select name,count(name) as name,
avg(shot_made_flag) as avg_three
from funX.threes1 
where minutes_remaining<2 and period=4
group by name 
having count(*)>=20 
order by 3 desc */ 

#8. which team takes fewest dribbles on threes?
/* 
select team_name, avg(dribbles) as avg_dribbles,
avg(shot_distance) as shot_dist 
from funX.threes1
group by 1
order by 2 desc */ 


#9. dribbles?
/*
select avg(dribbles) as avg_dribbles,
name
from funX.threes
group by name 
having count(*) >75 
order by 1 desc */ 

#10. dribbles before and after threes
/* 
#select * from funX.threes 
select defender_name,
avg(dribbles) as avg_dribbles,
avg(shot_distance) as avg_distance
from funX.threes1
group by defender_name 
having count(*) >100 */

#11. kyle korver 
/* 
select name,avg(shot_made_flag) as avg_threes,
avg(dribbles) as avg_dribbles, avg(touch_time) as avg_touch,
avg(defender_distance) as avg_dist, avg(shot_clock) as avg_shot_clock
from funX.threes2 
group by name
having count(*)>100 
order by 2 desc */

/* 
select 
avg(shot_made_flag) as avg
from funX.threes1 */ 

#taking less dribbles? ------- 
/* 
select avg(touch_time) as avg_touch,
avg(shot_made_flag) as avg_pct, 
name
from funX.threes1
group by name 
having count(*) >100 
order by 2 desc */ 




















































