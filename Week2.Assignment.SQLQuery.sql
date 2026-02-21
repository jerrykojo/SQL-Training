--Assignment 1 -  Week 2:

-- Create queries that return the following:

use Emadedev

Drop Table if exists Games
Create Table Games
(
year int not null,
City varchar (50) null
)
 --Insert values to the Games table
Insert into Games
(
year,
City
)
values
(2000, 'Sydney'),
(2004, 'Athens'),
(2008, 'Beijing'),
(2012, 'London')

--Display the Games table
select *
from Games

--Write SQL Queried to answer the questions below:

--1: Show the year 2004
--2: Show the city of london
--3: Show the latest year in the games table
--4: Add the next olympic games in the year 2024, which will be held in the city of Paris
--5: Create a view named vwOldGames to only include records showing year before 2008
--6: Check the view vwOldGames
--7: Show the number of records in the Games table
--8: Write a query which result to exclude London and Athens

--ANSWERS 

--Create Table
CREATE TABLE Games
(
    year INT NOT NULL,
    city VARCHAR(50) NULL
)

--Insert Values into the Table
INSERT INTO Games (year, city)
Values
(2000, 'Sydney'),
(2004, 'Athens'),
(2008, 'Beijing'),
(2012, 'London')


-- To check Table created
Select *
From Games


--1. To Show the year 2004
Select *
From Games
Where year = 2004

--2. TO  Show the city of london
Select * 
From Games
Where City = 'London'

--3. To Show the latest year in the games table
Select MAX(year) AS LatestYear
From Games

--4. To Add the next Olympic games in 2024, held in Paris
Insert INTO Games (year, city)
Values (2024, 'Paris')

--5. To Create a view named vwOldGames for years before 2008
Create View vwOldGames AS
SELECT *
From Games
Where year < 2008

--6. To Check the view vwOldGames
Select *
From vwOldGames

--7. To Show the number of records in the Games table
Select Count(*) AS TotalRecords
From Games

--8. To Exclude London and Athens
Select *
From Games
Where city NOT IN ('London', 'Athens')

