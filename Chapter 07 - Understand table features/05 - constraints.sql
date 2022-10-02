--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 7: UNDERSTAND TABLE FEATURES
-- T-SQL SAMPLE 5
--

USE [WideWorldImporters];
GO

-- Add a unique constraint on WideWorldImporters.Application.Countries
-- Note: one already exists, UQ_Application_Countries_CountryName
ALTER TABLE [Application].Countries WITH CHECK
    ADD CONSTRAINT UC_CountryName UNIQUE (CountryName);

-- Add a unique constraint on WideWorldImporters.Application.Countries
-- This unique constraint allows for resumable add table constraint
--    The max duration indicates that the process of creating the constraint
--    for a maximum of 60 minutes
ALTER TABLE [Application].Countries WITH CHECK
    ADD CONSTRAINT UC_CountryName_Resume UNIQUE (CountryName);
    WITH (ONLINE = ON, RESUMABLE = ON, MAX_DURATION = 60);

-- Add check contraint on WideWorldImporters.Sales.Invoices to verify JSON
ALTER TABLE Sales.Invoices WITH CHECK 
     ADD CONSTRAINT CK_Sales_Invoices_ReturnedDeliveryData_Must_Be_Valid_JSON 
     CHECK ((ISJSON(ReturnedDeliveryData)<>(0)));

-- Add check contraint on WideWorldImporters.Sales.Invoices to enforce date last edited
ALTER TABLE Sales.Invoices WITH CHECK
   ADD CONSTRAINT CH_Comments CHECK (LastEditedWhen < '2022-09-01'
   OR Comments IS NOT NULL);

-- Add a new column with default constraint to Application.People
ALTER TABLE [Application].People
    ADD PrimaryLanguage nvarchar(50) NOT NULL
        CONSTRAINT DF_Application_People_PrimaryLanguage DEFAULT 'English';
