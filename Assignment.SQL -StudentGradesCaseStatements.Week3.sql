-- =============================================
-- DEVELOPER:		OSIM JEREMIAH
-- Create date: 02-12-2026
-- Description:	StudentGradesCaseStatements (WEEK 3 ASSIGNMENT)
-- Revise Date: 02-12-2026 
-- Version:		v1.0
-- =============================================


Drop table if exists [Results]
Create table [Results]
(
ID int not null,
NAME varchar (50) null,
SCORE int not null
)

Insert into [Results]
(
ID,
NAME,
SCORE
)
values
(1, 'Simisola', 60),
(2, 'Ivan', 80),
(3, 'Metodija', 52),
(4, 'Callum', 98),
(5, 'Leia', 84),
(6, 'Aparecida', 82),
(7, 'Ursula', 69),
(8, 'Ramazan', 78),
(9, 'Corona', 87),
(10, 'Alise', 57),
(11, 'Galadriel', 89),
(12, 'Merel', 99),
(13, 'Cherice', 55),
(14, 'Nithya', 81),
(15, 'Elsad', 71),
(16, 'Liisi', 90),
(17, 'Johanna', 90),
(18, 'Anfisa', 90),
(19, 'Ryosuke', 97),
(20, 'Sakchai', 61),
(21, 'Elbert', 63),
(22, 'Katelyn', 51)
;

--To view the table
Select *
From Results

/**
Create queries that return the following

When score is 94 or higher, the row will have the value of A.

If  score is  94 gets an  A, If  score is  90 gets an  A- ,

If  score is  87 gets an  B+  ,If  score is  83 gets an  B  ,

If  score is  80 gets an  B- ,If  score is  77 gets an  C+ ,

If  score is  73 gets an  C , If  score is  70 gets an  C- ,

If  score is  67 gets an  D+ ,If  score is  60 gets an  D,

If students get none of these scores, you should assign an F.
**/

USE EmadeDev;

/* 1) Add Grade column safely */
IF COL_LENGTH('dbo.Results', 'Grade') IS NULL
BEGIN
    ALTER TABLE dbo.Results
    ADD Grade varchar(5) NULL;
END

/* 1) Update Grade values */
UPDATE dbo.Results
SET Grade = CASE 
    WHEN Score >= 94 THEN 'A'
    WHEN Score = 90 THEN 'A-'
    WHEN Score = 87 THEN 'B+'
    WHEN Score = 83 THEN 'B'
    WHEN Score = 80 THEN 'B-'
    WHEN Score = 77 THEN 'C+'
    WHEN Score = 73 THEN 'C'
    WHEN Score = 70 THEN 'C-'
    WHEN Score = 67 THEN 'D+'
    WHEN Score = 60 THEN 'D'
    ELSE 'F'
END

/* Show grades highest to lowest */
SELECT *
FROM dbo.Results
ORDER BY Score DESC;
GO

/* 2) Pass/Fail analysis */
SELECT 
    CASE WHEN Score >= 60 THEN 'Pass' ELSE 'Fail' END AS Result,
    COUNT(*) AS NumStudents
FROM dbo.Results
GROUP BY CASE WHEN Score >= 60 THEN 'Pass' ELSE 'Fail' 
END


/* 3) View for Question 1 */
CREATE OR ALTER VIEW dbo.vwResult
AS
SELECT 
    ID, NAME, SCORE,
    CASE 
        WHEN Score >= 94 THEN 'A'
        WHEN Score = 90 THEN 'A-'
        WHEN Score = 87 THEN 'B+'
        WHEN Score = 83 THEN 'B'
        WHEN Score = 80 THEN 'B-'
        WHEN Score = 77 THEN 'C+'
        WHEN Score = 73 THEN 'C'
        WHEN Score = 70 THEN 'C-'
        WHEN Score = 67 THEN 'D+'
        WHEN Score = 60 THEN 'D'
        ELSE 'F'
    END AS Grade
FROM dbo.Results


SELECT * 
FROM dbo.vwResult
ORDER BY Score DESC

/* 4) View for Question 2 */
CREATE OR ALTER VIEW dbo.vwResultAnalysis
AS
SELECT 
    CASE WHEN Score >= 60 THEN 'Pass' ELSE 'Fail' END AS Result,
    COUNT(*) AS NumStudents
FROM dbo.Results
GROUP BY CASE WHEN Score >= 60 THEN 'Pass' ELSE 'Fail' 
END

SELECT * 
FROM dbo.vwResultAnalysis
