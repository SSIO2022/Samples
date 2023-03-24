/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

/* 	Create a ledger table called dbo.Products  with an anonymous 
	(system-generated) history table. */
CREATE TABLE [dbo].[Products] (
	[ProductId] INT NOT NULL PRIMARY KEY CLUSTERED
	, [ProductName] VARCHAR(50) NOT NULL
	, [CategoryId] INT NOT NULL
	, [SalesPrice] MONEY NOT NULL
)
	WITH (
    SYSTEM_VERSIONING = ON,
    LEDGER = ON
);
