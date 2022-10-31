-- SQL Server 2022 Administration Inside Out (Chapter 13)
-- This is a sample script that accompanies the above title.
--
-- Create a ledger table called dbo.Products
-- with an anonymous (system-generated) history table.

CREATE TABLE dbo.Products (
	ProductId INT NOT NULL PRIMARY KEY CLUSTERED
	, ProductName VARCHAR(50) NOT NULL
	, CategoryId INT NOT NULL
	, SalesPrice MONEY NOT NULL
)
	WITH (
    SYSTEM_VERSIONING = ON,
    LEDGER = ON
);
