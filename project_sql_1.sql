use coronavirus;
-- Table overview
select * from sql_data;
-- to get number of entries of table
select count(*) from dataset11;
-- Data cleaning a nd processing
-- we have to convert dates i proper format (yyyy-mm-dd)
update dataset11
set date= DATE_FORMAT(STR_TO_DATE(date, '%d-%m-%Y'), '%Y-%m=%d');
-- chamging the type of date column of table
alter table dataset11
modify column Date DATE;
-- to get information about dataset we need to describe key word
DESCRIBE dataset11;
-- check the null values in all colomn using "is null"
select * from dataset11
WHERE Province IS NULL OR
Country IS NULL OR 
Latitude IS NULL OR 
Longitude IS NULL OR 
Date IS NULL OR 
Confirmed IS NULL OR
Deaths IS NULL OR
Recovered IS NULL  ;
-- updating the these values and replacing them
update dataset11
set
Province = coalesce(Province, "N/A"),
Country = coalesce(Country, "N/A"),
Latitude = coalesce(Latitude, "N/A"),
Longitude = coalesce(Longitude, 0.0),
Longitude = coalesce(Longitude, 0.0),
date = coalesce(Date, (SELECT min(date))),
Confirmed = coalesce(Confirmed, 0),
Deaths = coalesce(Deaths, "N/A"),
Recovered= coalesce(Recovered, "N/A");
-- data analysis
-- check the time period of data collected
select 
	min(STR_TO_DATE(date, '%Y-%m-%d')) as start_date,
    max(STR_TO_DATE(date, '%Y-%m-%d')) as end_date
from dataset11;
-- to get distint month count
select count(DISTINCT DATE_fORMAT(str_to_date(date,'%Y-%m-%d'),'%Y-%m'))as distict_month_count 
FROM dataset11;
-- check the avarage cases of Deaths, Recovered, Confirmed are shown below for month
select DATE_FORMAT(STR_TO_DATE(date, '%Y-%m-%d'),'%Y-%m') as month_year,
avg(Deaths) as avg_of_deaths,
avg(Recovered) as avg_of_deaths,
avg(Confirmed) as avg_of_confirmed 
from dataset11
group by DATE_FORMAT(STR_TO_DATE(date, '%Y-%m-%d'),'%Y-%m')
order by month_year;

-- check the minimum cases of Deaths, Recovered, Confirmed are shown below for year
select DATE_FORMAT(date, '%Y') as per_year,
min(Deaths) as min_of_deaths,
min(Recovered) as min_of_deaths,
min(Confirmed) as min_of_confirmed 
from dataset11
group by DATE_FORMAT(date, '%Y')
order by per_year;
-- check the Total cases of Deaths, Recovered, Confirmed are shown below per month
select DATE_FORMAT(date, '%Y-%m') as per_month,
sum(Deaths) as total_of_deaths,
sum(Recovered) as total_of_deaths,
sum(Confirmed) as total_of_confirmed 
from dataset11
group by DATE_FORMAT(date, '%Y-%m')
order by per_month;

-- to check the how corona virus spread out with respect to confired case(Total confired cases, average,varience, standard dev)
select 
    round(sum(confirmed)) as Total_confirmed_cases,
	round(avg(Confirmed)) as Avg_confirmed_cases,
	round(var_samp(Confirmed)) as varience_confirmed_cases, 
    round(STDDEV_SAMP(Confirmed))as stdev_of_confirmed 
FROM dataset11;
-- to check the how corona virus spread out with respect to deaths case(Total confired cases, average,varience, standard dev)
select DATE_FORMAT(date, '%Y-%m') as per_month,
	round(sum(deaths)) as Total_deaths_cases,
	round(avg(deaths)) as avg_deaths_cases,
	round(var_samp(deaths)) as var_deaths_cases, 
    round(STDDEV_SAMP(deaths))as std_deaths_cases
FROM dataset11
group by DATE_FORMAT(date, '%Y-%m')
order by per_month;
-- -- to check the how corona virus spread out with respect to recovered case(Total confired cases, average,varience, standard dev)
select 
    round(sum(Recovered)) as Total_rcved_cases,
	round(avg(Recovered)) as Avg_rcved_cases,
	round(var_samp(Recovered)) as varience_rcved_cases, 
    round(STDDEV_SAMP(Recovered))as stdev_of_rcved 
FROM dataset11;
-- the country having highest number of confirmed cases
select Country,sum(confirmed)as Max_cnfed_cases
from dataset11
group by country
order by max_cnfed_cases desc
limit 1;
--  country having lowest number of death cases
select Country,sum(deaths)as lowest_death_cases
from dataset11
group by country
order by lowest_death_cases asc
limit 1;
-- Top Five country having highest number of Recovered cases
select Country,sum(Recovered)as max_recoverd_cases
from dataset11
group by country
order by max_recoverd_cases desc
limit 5;

-- Sammary
-- US is the country having highest number of confirmed cases

-- The number of deaths are higher in 2021 as compare to 2020

-- India, Brazil, US, Turkey, Russia are the country's having most recoveries.

-- Dominica is the country having least deaths due to corona

-- The cases of corona have been increased in late 2020 and early 2021

-- 1443 is the Average of recovered cases and 2157 is the average of confirmed cases

-- This result are showing the increasing numbers for confirmed cases, Deaths and Recovered cases per month till 2021-6


