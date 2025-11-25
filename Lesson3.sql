--Lesson 3
--Data Flow Process
--Operators: are OR, AND, BETWEEN, LIKE, NOT IN, IN
--Equality Signs: these are <, >, <=, >=, !

use EmadeDev

Select * 
From Noble


/**
WRITE A LOGIC THAT SHOWS WINNERS FROM 1960 TO 1962 AS GOOD
WINNERS FROM 1963 TO 1966 AS BETTER
WINNERS THAT ARE BEYOND 1966 AS BEST

SHOW THE RESULT AS CATEGORY
/**

Select
[Year], 
[Subject], 
[Winner],
Case
    When [Year] Between 1960 AND 1962 Then 'GOOD'
    When [Year] > 1962 AND [YEAR] <= 1966 Then 'BETTER' 
    When [Year] > 1966 Then 'BEST'
    End AS CATEGORY
    From Noble



--ANOTHER APPROACH
Select
[Year], 
[Subject], 
[Winner],
Case
    When [Year] IN (1960,1961, 1962) Then 'GOOD'
    When [Year]  NOT IN (1960, 1961, 1962, 1967, 1968, 1969)  Then 'BETTER' 
    ELSE 'BEST'
    End AS CATEGORY
    From Noble

    --ANOTHER APPROACH 2
Select
[Year], 
[Subject], 
[Winner],
Case
    When [Year] < 1963 Then 'GOOD'
    When [Year]  >= 1963 AND [Year] <= 1966  Then 'BETTER' 
    ELSE 'BEST'
    End AS CATEGORY
    From Noble

    --CREATE A View vwWinnerCategory
Create View vwWinnerCategory As
Select
[Year], 
[Subject], 
[Winner],
Case
    When [Year] < 1963 Then 'GOOD'
    When [Year]  >= 1963 AND [Year] <= 1966  Then 'BETTER' 
    ELSE 'BEST'
    End AS CATEGORY
    From Noble

    --CHECK THE VIEW
    --WHERE CATEGORY IS GOOD
    Select *
    From vwWinnerCategory
    Where Category = 'Good'

    --WHERE CATEGORY IS BEST
    Select *
    From vwWinnerCategory
    Where Category = 'Best'