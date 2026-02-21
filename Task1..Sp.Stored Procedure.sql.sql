-- =============================================
-- DEVELOPER:		OSIM JEREMIAH
-- Create date: 02-18-2026
-- Description:	Creating Stored Procedure (SpLoanAmount),
-- Modification and Parameritarization (Task)
-- Revise Date: 02-18-2026 
-- Version:		v1.0
-- =============================================
Use EmadeDev

Create Procedure SpLoansAmount
AS 
BEGIN 
Select *
From LoansAccounts
END

--We create Stored Procedure for Secureity
--We crete stored procedure for Reuse
--And for performance

--How To Run A Stored Procedure
Exec SpLoansAmount

--With Stored procedure we can do paramaterize Procedure

--How To Modify /Alter Stored Procedure
--Instead of dropping the Table you make the changes using this process
Create OR Alter Procedure SpLoansAmount
@AccNo int NULL,
@Installments int --you can add more 
AS 
BEGIN 
Select *
From LoansAccounts
WHERE AccNo = @AccNo
AND @installments = @installments
END


--How to run a Parametarized Stored Procedure
Exec SpLoansAmount -- Error because no parameter 

--When you add a parameter
Exec SpLoansAmount 5, 36



--CLASSWORK
--1. Write a stored procedure using the Encounter Table 
--2. Create Parameter using the EncounterClass Field
-

Create Procedure spEncounterClass
As 
Begin
Select * 
From [dbo].[encounters]
End

--How to run stored procedure
Exec spEncounterClass

Select *
From [dbo].[encounters]


Create or Alter Procedure spEncounterClass

@ENCOUNTERCLASS varchar(50) 
As 
Begin
Select * 
From [dbo].[encounters]
Where ENCOUNTERCLASS = @ENCOUNTERCLASS
End


-- How to run a parameterized store procedure
Exec spEncounterClass 'Emergency'



Select *
From [dbo].[encounters]


Create or Alter Procedure spEncounterClass
@ENCOUNTERCLASS varchar(50) ,
@Description varchar (max)
As 
Begin
Select * 
From .[EmadeEncounters]
Where ENCOUNTERCLASS = @ENCOUNTERCLASS
And [DESCRIPTION] = @Description
End


-- How to run a parameterized store procedure
spEncounterClass 'Emergency' , 'Emergency Room Admission'



Use EmadeDev

Create table LoansAccounts(
AccNo int identity(1,1),
Cust_Name varchar(50),
Loan_Amount bigint, 
Installments int,
Int_Rate decimal(10,2),
[Start_Date] date
)

insert into LoansAccounts
values
('R.K. Gupta', 300000, 36, 12.00, '2009-07-19'),
('S.P. Sharma', 500000, 45, 10.00, '2008-03-22'),
('K.P. Jain', 300000, 36, Null, '2007-03-08'),
('M.P. Yadav', 800000, 60, 10.00, '2008-12-06'),
('S.P. Sinha', 200000, 36, 12.50, '2010-01-03'),
('P. Sharma', 700000, 60, 12.50, '2008-06-05'),
('K.S. Dhall', 500000, 48, Null, '2008-03-05')



--Write SQl queries for the following business questions
--1.Display the details of all the loans
Select *
From LoansAccounts

--2.Display the AccNo, Cust_name and Loan_amount of all the Loans
Select AccNo, Cust_Name, Loan_Amount
From LoansAccounts

--3.Display the details of all the loans with less than 40 installments
Select *
From LoansAccounts
WHERE Installments < 40

--4.Display the AccNo and Loan amounts of loans before 2009-04-01
Select *
From LoansAccounts
WHERE Start_Date < '2009-04-01'

--5.Display the int_rate of all the loans started after 2009-04-01
Select Int_Rate
From LoansAccounts
WHERE Start_Date > '2009-04-01'

--6.Display the details of all loans whose interest rate is null
Select *
From LoansAccounts
WHERE Int_Rate IS NULL

--7.Display the details of all loans whose interest rate is not null
Select *
From LoansAccounts
WHERE Int_Rate IS NOT NULL

--8.Display the distinctamounts of various loans from the table. Loan amount should appear only once
Select DISTINCT Loan_Amount
From LoansAccounts

--9.Display the number of installments of various loans. Installment should appear only once
Select 
Count ( Distinct Installments) as total
From LoansAccounts

Select Installments,
Count ( Installments) as total
From LoansAccounts
Group by Installments
Order by total desc

