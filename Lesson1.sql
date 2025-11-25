--How to create a Database
Create Database EmadeDev

--create another Database and call it EmadeTest and another as EmadeProd

--How to remove a Database
Drop Database EmadeTest

Create Database EmadeTest

Create Database EmadeProd

--How to access a Database
Use EmadeDev

--How to create a Table

--Check Data in a Tabale
Select *
From Customer


--Show customer in USA
Select *
From Customer
Where Country = 'USA'


--Show Customer ID 1,3,5
Select *
From Customer
Where CustomerID In (1,3,5)


--Show how many customers we have in the table
Select Count (*) AS Total_Customer
From Customer


--Showe the highest Id we have in the table
Select MAX (CustomerID) AS HighestCustomerID
From Customer 


--Show the lowest Id we have in the table
Select MIN (CustomerID) AS HighestCustomerID
From Customer



--ASSIGNMENT
--Show the Gender = Male
--Show FirstNAme = Jerry
--Show Record of People = Single


