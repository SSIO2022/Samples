--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 7: UNDERSTAND TABLE FEATURES
-- T-SQL SAMPLE 7
--
-- Create custom column defined as an nvarchar column with a max length of 100 characters
CREATE TYPE CustomerNameType
FROM NVARCHAR(100);
GO

/*
-- Use defined column when created a table
CREATE TABLE Sales.Customers (
    CustomerID INT NOT NULL,
    CustomerName CustomerNameType, -- can override nullability of the type here
    --UDT can adversely affect data quality as there are not additional methods of providing data protection
*/
-- Create a database-wide default
CREATE DEFAULT CustomerNameDefault AS 'NA';
GO
