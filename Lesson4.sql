--LESSON 4
--TOPIC IS ON PIVOT 
--PIVOT is transposing or flip from header to colum and vice versa

Use EmadeDev

Select *
From Noble

--using a sample for PIVOT
--Go to your Database
--Expand on Tables
--Expand customer
--pick the columns folder and drop here just as seen below

Select * 
From
(
Select [CustomerID], [CustomerFirstName], [CustomerLastName], [Gender], [MaritalStatus], [Country]
From Customer
) Source
Pivot(count (Gender)
For Gender IN ([Male], [Female])
)AS Target

