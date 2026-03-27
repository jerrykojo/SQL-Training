-- =============================================
-- DEVELOPER:		OSIM JEREMIAH
-- Create date: 02-24-2026
-- Description:	Team Work On MedalOfHonor & AfricaTemperature
-- Revise Date: 02-24-2026 
-- Version:		v1.0
-- =============================================


use EmadeDev

drop table if exists MedalOfHonor

create table dbo.MedalOfHonor (
Id int identity (1,1) primary key,
MilRank varchar (50),
SoldierName varchar (50),
YearOfAction varchar(4)
)
insert into dbo.MedalOfHonor (MilRank, SoldierName, YearOfAction)
values
('Staff Sergeant','Ty Carter', '2009'),
('Captain', 'Florent Groberg', '2012'), 
('Major', 'William D. Swenson', '2009'), 
('Corporal', 'Frank L. Anders', '1899'), 
('First Lieutenant', 'George C. Shaw', '1903')

--Questions--
/**
Assign a pay grade as follows 
if the Mil Rank is a Sergent,show as Level 6,
if the Mil Rank is a Captain,show as Level 3,
if the Mil Rank is a Major,show as Level 4,
if the Mil Rank is a Corporal,show as Level 2,
if the Mil Rank is a Lueitenant,show as Level 1,
Make sure to show no rank for non of the conditions Above
Show a new column as Grade Scale
**/

-- To check the Data on Table Created
Select *
From dbo.MedalOfHonor 

--To Check for the Grades only
SELECT 
    Id,
    MilRank,
    SoldierName,
    YearOfAction,
    CASE 
        WHEN MilRank LIKE '%Sergeant%' THEN 'Level 6'
        WHEN MilRank = 'Captain' THEN 'Level 3'
        WHEN MilRank = 'Major' THEN 'Level 4'
        WHEN MilRank = 'Corporal' THEN 'Level 2'
        WHEN MilRank LIKE '%Lieutenant%' THEN 'Level 1'
        ELSE NULL
    END AS [Grade Scale]
FROM dbo.MedalOfHonor

--To check for only the Grades
SELECT 
    MilRank,
    CASE 
        WHEN MilRank LIKE '%Sergeant%' THEN 'Level 6'
        WHEN MilRank = 'Captain' THEN 'Level 3'
        WHEN MilRank = 'Major' THEN 'Level 4'
        WHEN MilRank = 'Corporal' THEN 'Level 2'
        WHEN MilRank LIKE '%Lieutenant%' THEN 'Level 1'
        ELSE NULL
    END AS [Grade Scale]
FROM dbo.MedalOfHonor



--QUESTION 2
DROP TABLE IF EXISTS AfricaTemperature;

CREATE TABLE AfricaTemperature
(
    [RecordedDate] DATE NOT NULL,
    [DegreeInFahrenheit] DECIMAL(4, 2) NULL
);

INSERT INTO AfricaTemperature
(
    [RecordedDate],
    [DegreeInFahrenheit]
)
VALUES
('01-01-2023', '32.60'),
('01-02-2023', '31.20'),
('01-03-2023', '42.00'),
('01-04-2023', '44.60'),
('01-05-2023', '39.40'),
('01-06-2023', '31.70'),
('01-07-2023', NULL),
('01-08-2023', '21.20'),
('01-09-2023', '19.15'),
('01-10-2023', '07.90');


/**
Business requirements:

DegreeInFahrenheit is more than 40.00' , show as Hot
If DegreeInFahrenheit is below 32:00, show as 'It''s too cold outside!'
If DegreeInFahrenheit is not available, show as  'Why didn''t you record this?'
Otherwise, shows as Sounds about right'
Show the result in a new column Weather
**/

--Check Table AfricaTemperature
Select *
From AfricaTemperature

SELECT 
    RecordedDate,
    DegreeInFahrenheit,
    CASE 
        WHEN DegreeInFahrenheit IS NULL 
            THEN 'Why didn''t you record this?'
        WHEN DegreeInFahrenheit > 40.00 
            THEN 'Hot'
        WHEN DegreeInFahrenheit < 32.00 
            THEN 'It''s too cold outside!'
        ELSE 'Sounds about right'
    END AS Weather
FROM AfricaTemperature
ORDER BY RecordedDate


--To check for each
SELECT *
FROM AfricaTemperature
WHERE DegreeInFahrenheit > 40.00

SELECT *
FROM AfricaTemperature
WHERE DegreeInFahrenheit  IS NULL

SELECT *
FROM AfricaTemperature
WHERE DegreeInFahrenheit < 32.00




/**Question 3
show the highest year of action 
The lowest year of action
**/
SELECT *
From dbo.MedalOfHonor
WHERE YearOfAction =
    (
    SELECT
    --MAX(CAST(YearOfAction AS INT)) AS HighestYearOfAction,
    MIN(CAST(YearOfAction AS INT)) AS LowestYearOfAction
FROM dbo.MedalOfHonor
)

-- TO GET HIGHEST AND LOWEST ID , MILRANK, SOLDIERNMAE, HIGH  LOW
SELECT ID, MILRANK, SOLDIERNAME, 
    MAX(CAST(YearOfAction AS INT)) AS HighestYearOfAction,
    MIN(CAST(YearOfAction AS INT)) AS LowestYearOfAction
FROM dbo.MedalOfHonor
GROUP BY ID, MILRANK, SOLDIERNAME;
--The highest year is the newest record, and the lowest year is the oldest record in the dataset.


/**Question 4
Produce a report to show the unique weather count
**/
SELECT 
    Weather,
    COUNT(*) AS WeatherCount
FROM 
(
 SELECT 
      CASE 
           WHEN DegreeInFahrenheit IS NULL 
           THEN 'Why didn''t you record this?'
           WHEN DegreeInFahrenheit > 40.00 
           THEN 'Hot'
           WHEN DegreeInFahrenheit < 32.00 
           THEN 'It''s too cold outside!'
       ELSE 'Sounds about right'
      END AS Weather
  FROM AfricaTemperature
) AS WeatherReport
GROUP BY Weather

--The weather counts how many times each weather condition occurred in the dataset


--FROM MR. EMMANUEL
           select Weather,
  count(*) WeatherCount
  from 
  (
		  select *,
		  case
		   when DegreeInFahrenheit > 40.00 then 'Hot'
		   when DegreeInFahrenheit < 32.00 then 'It''s too cold outside!'
		   when DegreeInFahrenheit is NULL then 'Why didn''t you record this?'
		   else 'Sounds about right'
		   end as Weather
		   from AfricaTemperature
   ) X
   group by Weather

--Another Approach
   
		  select 
		  Weather = case
		   when DegreeInFahrenheit > 40.00 then 'Hot'
		   when DegreeInFahrenheit < 32.00 then 'It''s too cold outside!'
		   when DegreeInFahrenheit is NULL then 'Why didn''t you record this?'
		   else 'Sounds about right'
		   end,
		   WeatherCount = Count(case
		   when DegreeInFahrenheit > 40.00 then 'Hot'
		   when DegreeInFahrenheit < 32.00 then 'It''s too cold outside!'
		   when DegreeInFahrenheit is NULL then 'Why didn''t you record this?'
		   else 'Sounds about right'
		   end)
		   from AfricaTemperature
		   group by case
		   when DegreeInFahrenheit > 40.00 then 'Hot'
		   when DegreeInFahrenheit < 32.00 then 'It''s too cold outside!'
		   when DegreeInFahrenheit is NULL then 'Why didn''t you record this?'
		   else 'Sounds about right'
		   end
