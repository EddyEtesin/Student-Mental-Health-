SELECT * FROM dbms2.`student mental health analysis during online learning`;

#1. What is the average screen time per day for students in the dataset?
SELECT Avg(`Screen Time (hrs/day)`) as AverageScreentime 
FROM dbms2.`student mental health analysis during online learning`;

#2. What is the distribution of stress levels among students (Low, Medium, High)?
SELECT `Stress Level`, count(*) as Distribution 
FROM dbms2.`student mental health analysis during online learning`
group by `Stress Level` ;

#3. What is the average sleep duration for male vs. female students?
SELECT Gender, Avg(`Sleep Duration (hrs)`) as Average_sleep_duration 
FROM dbms2.`student mental health analysis during online learning`
group by Gender;

#4. How many students reported feeling anxious before exams?
Select `Anxious Before Exams`, count(*) as Count FROM dbms2.`student mental health analysis during online learning`
group by `Anxious Before Exams`;

#5. Is there a correlation between screen time and stress level?
#Calculate Pearson correlation coefficient between screen time and stress level
WITH numeric_stress AS (
    SELECT 
        `Screen Time (hrs/day)` AS screen_time,
        CASE 
            WHEN `Stress Level` = 'Low' THEN 1
            WHEN `Stress Level` = 'Medium' THEN 2
            WHEN `Stress Level` = 'High' THEN 3
        END AS stress_numeric
    FROM dbms2.`student mental health analysis during online learning`
)

SELECT 
    ROUND(
        (
            COUNT(*) * SUM(screen_time * stress_numeric) 
            - SUM(screen_time) * SUM(stress_numeric)
        ) / 
        SQRT(
            (COUNT(*) * SUM(screen_time * screen_time) - POWER(SUM(screen_time), 2)) *
            (COUNT(*) * SUM(stress_numeric * stress_numeric) - POWER(SUM(stress_numeric), 2))
        ),
    3) AS pearson_correlation_coefficient
FROM numeric_stress;


#6. Does physical activity time relate to sleep duration?
SELECT 
    ROUND(
        (
            COUNT(*) * SUM(`Physical Activity (hrs/week)` * `Sleep Duration (hrs)`) 
            - SUM(`Physical Activity (hrs/week)`) * SUM(`Sleep Duration (hrs)`)
        ) / 
        SQRT(
            (COUNT(*) * SUM(POWER(`Physical Activity (hrs/week)`, 2)) - POWER(SUM(`Physical Activity (hrs/week)`), 2)) *
            (COUNT(*) * SUM(POWER(`Sleep Duration (hrs)`, 2)) - POWER(SUM(`Sleep Duration (hrs)`), 2))
        ),
    3) AS pearson_correlation_coefficient
FROM dbms2.`student mental health analysis during online learning`;



#7. How does academic performance change relate to stress levels?
with performance_vs_stress as (
select case 
			WHEN `Stress Level` = 'Low' THEN 1
            WHEN `Stress Level` = 'Medium' THEN 2
            WHEN `Stress Level` = 'High' THEN 3
        END AS stress_numeric, 
        case 
			WHEN `Academic Performance change` = 'Declined' THEN 0
            WHEN `Academic Performance change` = 'Same' THEN 1
            WHEN `Academic Performance change` = 'Improved' THEN 2
        END AS Academic_Performance_numeric
	FROM dbms2.`student mental health analysis during online learning`)
SELECT 
  ROUND((
      COUNT(*) * SUM(`Academic_Performance_numeric` * `stress_numeric`) - SUM(`Academic_Performance_numeric`) * SUM(`stress_numeric`)
  ) / 
  SQRT(
      (COUNT(*) * SUM(POWER(`Academic_Performance_numeric`, 2)) - POWER(SUM(`Academic_Performance_numeric`), 2)) * 
      (COUNT(*) * SUM(POWER(`stress_numeric`, 2)) - POWER(SUM(`stress_numeric`), 2))
  ), 3) AS pearson_correlation
FROM performance_vs_stress;

#8 Are students who feel anxious before exams more likely to have their academic performance decline?
with anxious_vs_performance 
		as (
			select  case 
			when `Anxious Before Exams` = 'No' then 0
            when `Anxious Before Exams` = 'Yes' then 1
            end as Anxious_numeric, 
            case 
            when `Academic Performance change` = 'Declined' then 0
            when `Academic Performance change` = 'Same' then 1
            when `Academic Performance change` = 'Improved' then 2
            end as performance_numeric
from dbms2.`student mental health analysis during online learning`)
select 
		round((
				count(*) * sum(Anxious_numeric * performance_numeric) - sum(Anxious_numeric) * sum(performance_numeric)
                )/ sqrt(
                (count(*) * sum(power(Anxious_numeric,2)) - power(sum(Anxious_numeric),2)) * 
                (count(*) * sum(power(performance_numeric,2)) - power(sum(performance_numeric),2))
        ),3) as Pearson_correlation 
        from anxious_vs_performance ;
  
#9. Which education level has the highest average stress level?

with 
stress_level_num as 
			(select `Education Level`,
            case when `Stress Level` = 'low' then 1
			when `Stress Level` = 'Medium' then 2
			when `Stress Level` = 'High' then 3
			end as Stress_level_numeric 
			from dbms2.`student mental health analysis during online learning`)
            
select `Education Level`, avg(Stress_level_numeric) as average_stress_l 
from stress_level_num
group by `Education Level`;

#10. How does age relate to screen time usage?
select 
round((
count(*) * sum(age * `Screen Time (hrs/day)`) - sum(age) * sum(`Screen Time (hrs/day)`))/
sqrt(
(count(*) * sum(power(age,2)) - power(sum(age),2)) *
(count(*) * sum(power(`Screen Time (hrs/day)`,2)) - power(sum(`Screen Time (hrs/day)`),2))
 ),3) as pearson_Correlation
 from dbms2.`student mental health analysis during online learning`;

#11. Is there a difference in sleep duration between undergraduate and graduate students?
Select 
case when `Education level` in ( 'class 8' , 'BTech' , 'BA' , 'Class 11' , 'class 9' , 'class 10' ,'Bsc')  then 'Undergraduate'
else 'Graduate' 
end as Grad_undergrad
, Avg(`Sleep Duration (hrs)`) as average_sleep_duration
from dbms2.`student mental health analysis during online learning`
group by Grad_undergrad;

#12. Do male and female students differ in their physical activity levels?
Select Gender, avg(`Physical Activity (hrs/week)`) as avg_PA_level from dbms2.`student mental health analysis during online learning`
group by Gender;

#13. What combination of factors (screen time, sleep, activity) is most associated with improved academic performance?
select `Academic Performance Change`, 
round(avg(`Screen Time (hrs/day)`),2) as ScreenTime,
round(avg(`Sleep Duration (hrs)`),2) as SleepDuration,
round(avg(`Physical Activity (hrs/week)`),2) as PhysicalActivity 
From dbms2.`student mental health analysis during online learning`
group by `Academic Performance Change`;

#14. Are students with both high screen time and low sleep duration more likely to report high stress?
select `Stress Level`, round(avg(`Screen Time (hrs/day)`),2) as ScreenTime , round(avg(`Sleep Duration (hrs)`),2) as SleepDuration
From dbms2.`student mental health analysis during online learning`
group by `Stress Level`
order by ScreenTime desc, SleepDuration asc;

select `Stress Level`, count(*) as num_students
from 
(select * from dbms2.`student mental health analysis during online learning`
where `Screen Time (hrs/day)` > 6 and `Sleep Duration (hrs)` < 6) as high_screen_low_sleep 
group by `Stress Level`
order by num_students;

#15. What percentage of students with "Declined" academic performance have both high screen time and low physical activity?
select
  round(
    (count(case
        when `Screen Time (hrs/day)` > 6 and `Physical Activity (hrs/week)` < 2 
        then 1 end) 
    * 100.0 / count(*)), 2
  ) as percent_declined_highScreen_lowActivity
from dbms2.`student mental health analysis during online learning`
where `Academic Performance change` = 'Declined';

#16. Is there a relationship between age and feeling anxious before exams?
with anxious as (
select age as age, 
case when `Anxious Before Exams` = 'Yes' then 1 
when `Anxious Before Exams` = 'No' then 0
end as anxious_numeric 
from `student mental health analysis during online learning`)
select  
		round((
			count(*) * sum(age * anxious_numeric) - sum(age) * sum(anxious_numeric))/
            sqrt (
            (count(*) * sum(power(age,2)) - power(sum(age),2)) * 
            (count(*) * sum(power(anxious_numeric,2)) - power(sum(anxious_numeric),2))
),3) as Pearson_correlation
from anxious;

#17. What's the average sleep duration for students whose academic performance improved?
select avg(`Sleep Duration (hrs)`) as AverageSleepDur 
from `student mental health analysis during online learning`
where `Academic Performance Change` = 'Improved';

#18. How many students with high stress levels also have low physical activity?
select count(*) from `student mental health analysis during online learning`
where `Stress Level` = 'High' and `Physical Activity (hrs/week)` < 4;

#19. What percentage of Class 12 students report high stress levels compared to other education levels?
with class12 as (
    select * 
    from `student mental health analysis during online learning` 
    where lower(`education level`) = 'class 12'
),

other_classes as (
    select * 
    from `student mental health analysis during online learning` 
    where lower(`education level`) <> 'class 12'
)

select
    (select count(*) from class12 where lower(`stress level`) = 'high') * 100.0 / nullif((select count(*) from class12), 0) as class12_high_stress_percent,
    (select count(*) from other_classes where lower(`stress level`) = 'high') * 100.0 / nullif((select count(*) from other_classes), 0) as others_high_stress_percent;


#20. Do students in technical programs (BTech, MTech) have different stress levels than those in arts programs (BA, MA)?
with stress_by_programs as
(select case when `Education Level` in ('BTech', 'MTech') then 'Technical'
when `Education Level` in  ('BA', 'MA') then 'Arts' 
else 'others'
end as Education_L, 
case when `Stress Level` = 'Low' then 0
when `Stress Level` = 'Medium' then 1
when `Stress Level` = 'High' then 2
end as Stress_numeric
from `student mental health analysis during online learning`)
select Education_L, avg(Stress_numeric) as `Stress Level` 
from stress_by_programs
where Education_L in ('Technical', 'Arts')
group by Education_L;

#21. Is there a relationship between screen time and sleep duration?
select 
round((
		count(*) *  sum(`Screen Time (hrs/day)` * `Sleep Duration (hrs)`) - sum(`Screen Time (hrs/day)`) * sum(`Sleep Duration (hrs)`))/
        sqrt(
        (count(*) * sum(power(`Screen Time (hrs/day)`,2)) - power(sum(`Screen Time (hrs/day)`),2))*
        (count(*) * sum(power(`Sleep Duration (hrs)`,2)) - power(sum(`Sleep Duration (hrs)`),2))
        ),3) as Pearson_correlation
from `student mental health analysis during online learning`;


##22. What's the average physical activity time for students with different stress levels?
select `stress level` , avg(`Physical Activity (hrs/week)`) as Average_PA_time from `student mental health analysis during online learning`
group by `stress level`