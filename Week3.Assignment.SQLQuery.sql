**/
ASSIGNMENT 3
Jeremiah

/**


--Total number of Drama movies



 --List of all movies with price over 20, sorted by price

SELECT *
FROM Movies
WHERE Price > 20
ORDER BY Price ASC;

--All movies sorted by QTY in decreasing order

SELECT *
FROM Movies
ORDER BY Qty DESC

--Report: total by movie type, current value, and replacement value

--Current Value = SUM(Qty * Price)

--Replacement Value = SUM(Qty * Price * 1.15)

SELECT 
    Type,
    SUM(Qty * Price) AS CurrentValue,
    SUM(Qty * Price * 1.15) AS ReplacementValue
FROM Movies
GROUP BY Type

 --Replacement value for all movies (QTY * Price * 1.15)

--This gives you movie-by-movie replacement cost.

SELECT 
    Name,
    Qty,
    Price,
    (Qty * Price * 1.15) AS ReplacementValue
FROM Movies


 --Count movies where rating is NOT 'G'

SELECT COUNT(*) AS NonGRatedMovies
FROM Movies
WHERE Rating <> 'G'

