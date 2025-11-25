--HOW TO OPEN THIS TABLE
--EXPAND - ON DATABASES, EXPAND TABLES, RIGHT CLICK ON DBO.CUSTOMER, 
--SCRIPT TABLE AS, CREATE TO, NEW QUERY EDITOR WINDOW


USE [EmadeDev]
GO

/****** Object:  Table [dbo].[Customer]    Script Date: 24/11/2025 02:40:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Customer](
	[CustomerID] [int] NULL,
	[CustomerFirstName] [varchar](50) NULL,
	[CustomerLastName] [varchar](50) NULL,
	[Gender] [varchar](50) NULL,
	[MaritalStatus] [varchar](50) NULL,
	[Country] [varchar](50) NULL
) ON [PRIMARY]
GO



--HOW TO CREATE A TABLE
Create Table Noble
(
[Year] int Not Null,
[Subject] Varchar (50) Null,
[Winner] Varchar (50) Null
)

--HOW TO CHECK A TABLE
Select *
From Noble


--HOW TO LOAD DATA TO A TABLE
Insert into Noble
(Year, Subject, Winner)
Values
(1960, 'Economics', 'Samuel'),
(1961, 'Biology', 'Hope'),
(1962, 'Physics', 'Fortune'),
(1963, 'Maths', 'James'),
(1964, 'English', 'Jerry'),
(1965, 'Economics', 'Adele'),
(1966, 'Economics', 'Samuel'),
(1967, 'Accounting', 'Samuel'),
(1968, 'French', 'Moses'),
(1969, 'English', 'Fortune'),
(1970, 'Biology', 'Hope'),
(1971, 'Economics', 'Hope'),
(1972, 'Physics', 'Hope'),
(1973, 'Physics', 'Ken'),
(1974, 'Economics', 'Samuel'),
(1975, 'Biology', 'David'),
(1976, 'Biology', 'David'),
(1977, 'Accounting', 'Ben'),
(1978, 'Cybersecurity', 'Abel'),
(1979, 'Cybersecurity', 'Ben'),
(1980, 'Economics', 'Frank')

Select * 
From Noble

--WHAT IS CRUD
--CREATE, READ ( MEANS SELECTING FROM A TABLE) UPDATE(UPDATE A DATA IN A TABLE) AND DELETE

--HOW TO UPDATE A TABLE
Update Noble
Set Subject = 'Machine Learning'
Where Subject = 'Robotics'

Select *
From Noble
Where Subject = 'Robotics'

Select *
From Noble
Where Subject = 'Machine Learning'


--HOW TO REMOVE A RECORD FROM A TABLE
Delete
From Noble 
Where Subject = 'Machine Learning'


--TRUNCATE TABLE MEANS YOU CLEAR ALL RECORDS IN THE TABLE
--AND ONLY KEEP THE STRUCTURE OF THE TABLE

Truncate Table Noble

--HOW TO REORDER OR SORT DATA IN A TABLE

Select *
From Noble
Order by Year DESC

--HOW TO CREATE A VIEW (vIEW IS A SNAPSHOT OF THE CURRENT STATE OF THINGS/DATE)

Create View vwNoble1960s AS 
Select * 
From Noble 
Where Year < 1970

--HOW TO CHECK OR RUN A VIEW

Select *
From vwNoble1960s

--HOW TO REMOVE A VIEW FROM A DATABASE
Drop View nwNoble1970s

--CLASS WORK
--WRITE A VIEW THAT DO NOT SHOW 1960S RECORD
Create View vwNoble1970s AS
Select *
From Noble
Where Year > 1960

Select *
From vwNoble1970s

--EQUALITY SIGN : <> =,
--OPERATORS: (In/Not In, Between) 
--Create Using To
Create View vwNoble1960to1965 AS
Select *
From Noble
Where Year Between 1960 AND 1965

Select *
From vwNoble1960to1965


--Create Using AND
Create View vwNoble1972AND1975 AS
Select *
From Noble
Where Year Between 1972 AND 1975

Select *
From vwNoble1972AND1975


Select * 
From Noble
Where Year In (1972, 1975)

Select *
From Noble
Where Year = 1972 OR Year = 1975

Create View vwNoble1975AND1990 AS
Select *
From Noble
Where Year = 1975 OR Year = 1990

Select *
From vwNoble1975AND1990


--DATA FLOW LOGIC: CASE STATEMENT 
--CLASSWORK
--ANYONE BORN IN THE 60SBABY BOOMER AND 70S GENX AND 80S IS GENY
Select 
Year,
Subject,
Winner,
Case
     When Year Between 1960 AND 1969 then 'Baby Boomer'
	 When Year Between 1970 AND 1979 then 'Gen Z'
	 When Year Between 1980 and 1989 then 'Gen Y'
	 End AS Generation
	 From Noble 


	 --METHOD 2
Select 
Year,
Subject,
Winner,
Case
     When Year <= 1969 then 'Baby Boomer'
	 When Year <= 1979 then 'Gen Z'
	 When Year <= 1989 then 'Gen Y'
	 End AS Generation
	 From Noble 


	 --METHOD 3
Select 
Year,
Subject,
Winner,
Case
     When Year <= 1969 then 'Baby Boomer'
	 When Year <= 1979 then 'Gen Z'
	 Else 'Gen Y'
	 End AS Generation
	 From Noble 


	 --CLASS WORK
	 --CREATE A VIEW FOR GENERATION TYPE
Create view vwGeneration AS
Select 
Year,
Subject,
Winner,
Case
     When Year <= 1969 then 'Baby Boomer'
	 When Year <= 1979 then 'Gen Z'
	 Else 'Gen Y'
	 End AS Generation
	 From Noble 

	 --TO CHECK vwGeneration
	 Select *
	 From vwGeneration

	 
	 --SHOW THE NUMBERS BY GENERATION
	 Select Generation,
	 Count (*) AS TotalNumberByGeneration
	 From vwGeneration
	 Group By Generation
	 