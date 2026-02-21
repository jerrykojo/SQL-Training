
SELECT s.*
FROM EmadeStocks s
LEFT JOIN EmadeProducts p
    ON s.product_id = p.product_id
WHERE p.product_id IS NULL;




-- TO CHECK FOR DUPLICATE IN ASSIGNING PRIMARY KEY

SELECT [store_id], COUNT(*) AS DuplicateCount
FROM [dbo].[EmadeStores]
GROUP BY [store_id]
HAVING COUNT(*) > 1;





--EDITING BRANDS DATA TYPE TO VARCHAR
USE [EmadeDev]

Drop Table if Exists [EmadeBrands] --To drop existing table

GO

/****** Object:  Table [dbo].[EmadeBrands]    Script Date: 05/01/2026 01:21:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EmadeBrands](
	[brand_id] [varchar] (50) NULL,
	[brand_name] [varchar](50) NULL
) ON [PRIMARY]
GO



bulk insert EmadeBrands
From 'C:\Users\HP\Documents\EMADE\ETL_Training\Inbound\EmadeBrands.csv'
WITH
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
);

Select *
From EmadeBrands





--EDITING EMADECATEGORIES DATA TYPE TO VARCHAR


Drop Table if Exists [EmadeCategories] --To drop existing table


/****** Object:  Table [dbo].[EmadeCategories]    Script Date: 05/01/2026 01:29:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EmadeCategories](
	[category_id] [varchar](50) NULL,
	[category_name] [varchar](50) NULL
) ON [PRIMARY]
GO

bulk insert EmadeCategories
From 'C:\Users\HP\Documents\EMADE\ETL_Training\Inbound\EmadeCategories.csv'
WITH
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
);

Select *
From EmadeCategories




--EDITING EMADECUSTOMERS DATA TYPE TO VARCHAR

Drop Table if Exists [EmadeCustomers] --To drop existing table

USE [EmadeDev]
GO

/****** Object:  Table [dbo].[EmadeCustomers]    Script Date: 05/01/2026 01:39:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EmadeCustomers](
	[customer_id] [varchar](50) NULL,
	[first_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL,
	[phone] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[street] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](50) NULL,
	[zip_code] [int] NULL
) ON [PRIMARY]
GO




bulk insert EmadeCustomers
From 'C:\Users\HP\Documents\EMADE\ETL_Training\Inbound\EmadeCustomers.csv'
WITH
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
);

Select *
From EmadeCustomers


--EDITING EMADEORDERITEMS DATA TYPE TO VARCHAR

Drop Table if Exists [EmadeOrderItems] --To drop existing table

USE [EmadeDev]
GO

/****** Object:  Table [dbo].[EmadeOrderItems]    Script Date: 05/01/2026 01:46:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EmadeOrderItems](
	[order_id] [varchar](50) NULL,
	[item_id] [varchar](50) NULL,
	[product_id] [varchar](50) NULL,
	[quantity] [varchar](max) NULL,
	[list_price] [varchar](max) NULL,
	[discount] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



bulk insert EmadeOrderitems
From 'C:\Users\HP\Documents\EMADE\ETL_Training\Inbound\EmadeOrderItems.csv'
WITH
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
);


Select *
From EmadeOrderItems




--EDITING EMADEORDERS DATA TYPE TO VARCHAR


Drop Table if Exists [EmadeOrders] --To drop existing table

USE [EmadeDev]
GO

/****** Object:  Table [dbo].[EmadeOrders]    Script Date: 05/01/2026 02:05:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EmadeOrders](
	[order_id] [varchar] (50) NULL,
	[customer_id] [varchar] (50) NULL,
	[order_status] [varchar] (50) NULL,
	[order_date] [varchar] (50) NULL,
	[required_date] [varchar] (50) NULL,
	[shipped_date] [varchar] (50) NULL,
	[store_id] [varchar] (50) NULL,
	[staff_id] [varchar] (50) NULL
) ON [PRIMARY]
GO



bulk insert EmadeOrders
From 'C:\Users\HP\Documents\EMADE\ETL_Training\Inbound\EmadeOrders.csv'
WITH
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
);


Select *
From EmadeOrders



--EDITING EMADEPRODUCTS DATA TYPE TO VARCHAR

Drop Table if Exists [EmadeProducts] --To drop existing table

USE [EmadeDev]
GO

/****** Object:  Table [dbo].[EmadeProducts]    Script Date: 05/01/2026 02:14:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EmadeProducts](
	[product_id] [varchar](50) NULL,
	[product_name] [varchar](MAX) NULL,
	[brand_id] [varchar](50) NULL,
	[category_id] [varchar](50) NULL,
	[model_year] [varchar](50) NULL,
	[list_price] [varchar](50) NULL
) ON [PRIMARY]
GO


bulk insert EmadeProducts
From 'C:\Users\HP\Documents\EMADE\ETL_Training\Inbound\EmadeProducts.csv'
WITH
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
);


Select *
From [EmadeProducts]





--EDITING EMADESTAFFS DATA TYPE TO VARCHAR

Drop Table if Exists [EmadeStaffs] --To drop existing table

USE [EmadeDev]
GO

/****** Object:  Table [dbo].[EmadeStaffs]    Script Date: 05/01/2026 02:27:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EmadeStaffs](
	[staff_id] [varchar](50) NULL,
	[first_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[phone] [varchar](50) NULL,
	[active] [varchar](50) NULL,
	[store_id] [varchar](50) NULL,
	[manager_id] [varchar](50) NULL
) ON [PRIMARY]
GO


bulk insert EmadeStaffs
From 'C:\Users\HP\Documents\EMADE\ETL_Training\Inbound\EmadeStaffs.csv'
WITH
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
);


Select *
From EmadeStaffs



--EDITING EMADESTOCKS DATA TYPE TO VARCHAR

Drop Table if Exists [EmadeStocks] --To drop existing table

USE [EmadeDev]
GO

/****** Object:  Table [dbo].[EmadeStocks]    Script Date: 05/01/2026 02:33:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EmadeStocks](
	[store_id] [varchar](50) NULL,
	[product_id] [varchar](50) NULL,
	[quantity] [varchar](50) NULL
) ON [PRIMARY]
GO




bulk insert EmadeStocks
From 'C:\Users\HP\Documents\EMADE\ETL_Training\Inbound\EmadeStocks.csv'
WITH
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
);


Select *
From EmadeStocks



--EDITING EMADEStores DATA TYPE TO VARCHAR


USE [EmadeDev]
GO
/****** Object:  Table [dbo].[EmadeStores]    Script Date: 10/12/2025 03:52:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Drop Table if Exists [EmadeStoresBulk]

CREATE TABLE [dbo].[EmadeStoresBulk](
	[store_id] [varchar](50) NULL,
	[store_name] [varchar](50) NULL,
	[phone] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[street] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](50) NULL,
	[zip_code] [nvarchar](50) NULL
) ON [PRIMARY]
GO

bulk insert EmadeStoresBulk
 from 'C:\Users\HP\Documents\EMADE\ETL_Training\Inbound\EmadeStores.csv'
with
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
)
;




























/**code to verify duplicate and confirm suitability of table column as PK
To ensure receiving table at end of the ERD must have PK, sender table might not 
When creating this relationship in Power BI's Model view (dragging manager_id to staff_id),
You must avoid setting the filter direction to "Both" as a default. This often causes errors.**/

use EmadeDev

SELECT [order_id], COUNT(*) AS DuplicateCount
FROM [dbo].[EmadeOrders]
GROUP BY [order_id]
HAVING COUNT(*) > 1;

Select *
From [dbo].[EmadeOrders]


SELECT [customer_id], COUNT(*) AS DuplicateCount
FROM [dbo].[EmadeOrders]
GROUP BY [customer_id]
HAVING COUNT(*) > 1;

Use EmadeDev

GO
/****** Object:  Table [dbo].[EmadeOrderItems]    Script Date: 10/12/2025 03:52:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Drop Table if Exists [EmadeOrderItems] --To drop existing table


CREATE TABLE [dbo].[EmadeOrderItems](
	[order_id] [int] NULL,
	[item_id] [varchar](max) NULL,
	[product_id] [varchar](max) NULL,
	[quantity] [varchar](max) NULL,
	[list_price] [varchar](max) NULL,
	[discount] [varchar](max) NULL
) ON [PRIMARY]
GO

bulk insert EmadeOrderItems
From 'C:\Users\HP\Documents\EMADE\ETL_Training\Inbound\EmadeOrderItems.csv'
WITH
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
);

Select *
From EmadeOrderItems



--CHANGING EMADE PRODUCT ID ON EDMADEORDER ITEMS TO PRODUCT ID


Drop Table if Exists [EmadeOrderItems] --To drop existing table


GO
/****** Object:  Table [dbo].[EmadeOrderItems]    Script Date: 10/12/2025 03:52:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE TABLE [dbo].[EmadeOrderItems](
	[order_id] [int] NULL,
	[item_id] [varchar](max) NULL,
	[product_id] [INT] NOT NULL,
	[quantity] [varchar](max) NULL,
	[list_price] [varchar](max) NULL,
	[discount] [varchar](max) NULL
) ON [PRIMARY]
GO

bulk insert EmadeOrderItems
From 'C:\Users\HP\Documents\EMADE\ETL_Training\Inbound\EmadeOrderItems.csv'
WITH
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
);

Select *
From EmadeOrderItems



--TO CHANGE EMADE CUSTOMERS ID ON EMADE ORDERS ORDER ID

GO
/****** Object:  Table [dbo].[EmadeOrderItems]    Script Date: 10/12/2025 03:52:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Drop Table if Exists [EmadeCustomers] --To drop existing table


CREATE TABLE [dbo].[EmadeCustomers](
	[customer_id] [INT] NULL,
	[first_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL,
	[phone] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[street] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](50) NULL,
	[zip_code] [int] NULL
) ON [PRIMARY]
GO



bulk insert [EmadeCustomers]
From 'C:\Users\HP\Documents\EMADE\ETL_Training\Inbound\EmadeCustomers.csv'
WITH
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
);

Select *
From EmadeCustomers



-- TO CHANGE FOR BRANDS

Drop Table if Exists [EmadeBrands] --To drop existing table


USE [EmadeDev]
GO

/****** Object:  Table [dbo].[EmadeBrands]    Script Date: 04/01/2026 23:02:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EmadeBrands](
	[brand_id] [int] Not NULL,
	[brand_name] [varchar](50) NULL
) ON [PRIMARY]
GO

bulk insert [EmadeBrands]
From 'C:\Users\HP\Documents\EMADE\ETL_Training\Inbound\EmadeBrands.csv'
WITH
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
);

Select *
From EmadeBrands




--TO CHANGE CATEGORY & PRODUCTS

Drop Table if Exists [EmadeCategories] --To drop existing table

USE [EmadeDev]
GO

/****** Object:  Table [dbo].[EmadeCategories]    Script Date: 04/01/2026 23:10:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EmadeCategories](
	[category_id] [int] Not NULL,
	[category_name] [varchar](50) NULL
) ON [PRIMARY]
GO


bulk insert [EmadeCategories]
From 'C:\Users\HP\Documents\EMADE\ETL_Training\Inbound\EmadeCategories.csv'
WITH
(format='csv', firstrow = 2,
fieldterminator=',',
rowterminator='0x0a'
);


Select *
From EmadeCategories
