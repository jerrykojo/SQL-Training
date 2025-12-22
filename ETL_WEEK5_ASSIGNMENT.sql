/**

ETL ASSIGNMENT
WEEK 5

**/



use EmadeDev


Select * 
From EmadeCategoriesBulk

Select * 
From EmadeProducts


BULK INSERT dbo.EmadeProducts
FROM 'C:\Users\HP\Documents\EMADE\ETL_Training\Inbound\Jeremiah Osim - EmadeProducts - Jeremiah Osim - EmadeProducts.csv'
WITH (
FIRSTROW = 2, -- skip header row
FIELDTERMINATOR = ',', -- column delimiter
ROWTERMINATOR = '0x0D0A', -- line break (LF)
TABLOCK,
KEEPNULLS,
CODEPAGE = '65001' -- UTF-8 (important for NVARCHAR)
)





C:\Users\HP\Documents\EMADE\ETL_Training\Inbound

Select @@SERVERNAME

Exec xp_fileexist 'C:\Users\HP\Documents\EMADE\ETL_Training\Inbound\Jeremiah Osim - EmadeProducts - Jeremiah Osim - EmadeProducts.csv'

SELECT servicename, service_account
FROM sys.dm_server_services;


C:\Users\HP\Documents\EMADE\ETL_Training\Inbound\Jeremiah Osim - EmadeProducts - Jeremiah Osim - EmadeProducts.csv


Create Table EmadeProducts
(product_id INT	 NOT Null,
product_name	Nvarchar(50),
brand_id	INT Not Null,
category_id	INT Not Null,
model_year	Nvarchar(50),
list_price Nvarchar(50)
)



-- Write queries to answer the questions below:

--Show total
--number of records for each file.

Select *
From [dbo].[EmadeBrands]

Select Count(*) AS Total_records 
From EmadeBrands

Select Count(*) AS Total_records 
From EmadeCategories

Select Count(*) AS Total_records 
From EmadeCustomers

Select Count(*) AS Total_records 
From EmadeOrderItems

Select Count(*) AS Total_records 
From EmadeOrders

Select Count(*) AS Total_records 
From EmadeProducts

Select Count(*) AS Total_records 
From EmadeStaffs

Select Count(*) AS Total_records 
From EmadeStocks

Select Count(*) AS Total_records 
From EmadeStores





--How many
--different categories of products are there?

Select *
From EmadeProducts



--QUESTIONS AND ANSWERS

--List all the
--customers who are from New York city.

Select *
From [dbo].[EmadeCustomers]
Where City = 'New York'


--What are the
--top 5 products with the highest prices?

Select Top 5 *
from [dbo].[EmadeProducts]
order by List_price Desc


--What cities are
--the customers from? Note: show only unique values by removing duplicates in the
--results.

Select Distinct city --First_name,Last_name
From [dbo].[EmadeCustomers]


--Find the
--customer IDs who ordered the first 10 days in October 2018. Hint: Use the
--table: EmadeOrders

Select Distinct Customer_ID
from Emadeorders
Where Order_date >= '2018-10-01' and Order_date < '2018-10-11'

Select *
From Emadeorders
Where year(Order_date) = 2018
and Month (Order_date) = 10


--Find all the
--Trek bicycles from 2017 model. Hint: Use the table: EmadeProducts

Select *
From Emadeproducts
Where Product_Name Like '%Trek%'
and Model_year = 2017



--What are the
--total number of customers in the Customers table? Hint: Use the table:
--EmadeCustomers

Select Count (*) as Total_number
From Emadecustomers

Select Count (Customer_ID) as Total_number
From Emadecustomers



--What is the
--total quantity of the products sold? Hint: Use the table: EmadeOrderItems


Alter Table Emadeorderitems
Alter Column quantity Int

Select  Sum(quantity) as Total_quantity
From EmadeOrderitems


--Which product

--has the highest price? Hint: Use the table: EmadeOrderItems

Select  Max(List_Price) as Highest_Price
From EmadeOrderitems


