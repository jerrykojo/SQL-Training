/**
Assignment 5
Jeremiah



**/




--ASSIGNMENT 5

--Categorize employees based on distanceFromHome:

CREATE TABLE Employees (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Position VARCHAR(50),
    SocialSecurity VARCHAR(20),
    distanceFromHome INT,
    Department VARCHAR(50)
)

-- Insert some sample data
INSERT INTO Employees VALUES 
(1, 'Alice Johnson', 'Senior Engineer', '123-45-6789', 8, 'Technical'),
(2, 'Bob Smith', 'Engineer', '987-65-4321', 25, 'Technical'),
(3, 'Carol Davis', 'Manager', '456-78-9012', 15, 'HR'),
(4, 'David Brown', 'Senior Engineer', '789-01-2345', 32, 'Technical'),
(5, 'Eve Wilson', 'Analyst', '234-56-7890', 5, 'Finance')


Use EmadeDev

Select *
From Employees


--Show all records for employees with the position Senior Engineer:
SELECT 
    ID,
    Name,
    Position,
    SocialSecurity,
    distanceFromHome,
    Department
FROM Employees
WHERE Position = 'Senior Engineer'


--Show all people in the Technical department:
SELECT 
    ID,
    Name,
    Position,
    SocialSecurity,
    distanceFromHome,
    Department
FROM Employees
WHERE Department = 'Technical'


--Show the employee(s) with the highest distanceFromHome including all fields:
SELECT 
    ID,
    Name,
    Position,
    SocialSecurity,
    distanceFromHome,
    Department
FROM Employees
WHERE distanceFromHome = (
    SELECT MAX(distanceFromHome) FROM Employees
)


--(Duplicate of #4) Same query to show highest distanceFromHome:
SELECT 
    ID,
    Name,
    Position,
    SocialSecurity,
    distanceFromHome,
    Department
FROM Employees
WHERE distanceFromHome = (
    SELECT MAX(distanceFromHome) FROM Employees
)


