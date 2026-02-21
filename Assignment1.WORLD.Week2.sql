
--ASSIGNMENT 1 - WORLD  Week 2

Use EmadeDev
DROP TABLE IF EXISTS World 
--create table named World
CREATE TABLE World
(
CountryName varchar (50) null,
Continent varchar (50) null,
Area int  not null,
"Population" int not null,
Gdp bigint not null
);

--Insert values to the Worlds table
INSERT INTO World
(
CountryName,
Continent,
Area,
"Population",
Gdp
)
VALUES
('Afghanistan', 'Asia', 652230, 25500100, 20343000000),
('Albania', 'Europe', 28748, 2831741, 12960000000),
('Algeria', 'Africa', 2381741, 37100000, 188681000000),
('Andorra', 'Europe', 468, 78115, 3712000000),
('Angola', 'Africa', 1246700, 20609294, 100990000000)

--Display the Worlds table

SELECT *
FROM World

--Write SQL Queries to answer the questions below:

--1: Show the area of 468
--2: Show the county name of Angola
--3: Show the country with the lowest Gdp 
--4: Create a view named vwlowGdpCountries to only include record with the lowest GDP
--5: Create a view named vwOldGames to only include records showing year before 2008
--6: Check the view vwlowGdpCountries
--7: Show the number of records in the world table
--8: Write a query which result to exclude Continents of Asia and Africa 



--1: Show the area of 468
SELECT *
FROM World
WHERE Area = 468;

--2: Show the county name of Angola
SELECT CountryName
FROM World
WHERE CountryName = 'Angola';

--3: Show the country with the lowest Gdp 
SELECT TOP 1 *
FROM World
ORDER BY Gdp ASC;

--4: Create a view named vwlowGdpCountries to only include record with the lowest GDP
CREATE VIEW vwlowGdpCountries AS
SELECT TOP 1 *
FROM World
ORDER BY Gdp ASC;

--5: Create a view named vwOldGames to only include records showing year before 2008
ALTER TABLE World
ADD Year int;

UPDATE World SET Year = 2005 WHERE CountryName = 'Afghanistan';
UPDATE World SET Year = 2010 WHERE CountryName = 'Albania';
UPDATE World SET Year = 2003 WHERE CountryName = 'Algeria';
UPDATE World SET Year = 2007 WHERE CountryName = 'Andorra';
UPDATE World SET Year = 2012 WHERE CountryName = 'Angola';

CREATE VIEW vwOldGames AS
SELECT *
FROM World
WHERE Year < 2008;

SELECT *
FROM vwOldGames;

--6: Check the view vwlowGdpCountries
SELECT *
FROM vwlowGdpCountries;


--7: Show the number of records in the world table
SELECT COUNT(*) AS TotalRecords
FROM World;


--8: Write a query which result to exclude Continents of Asia and Africa 
SELECT *
FROM World
WHERE Continent NOT IN ('Asia', 'Africa');

