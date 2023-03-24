--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 7: UNDERSTAND TABLE FEATURES
-- EXTRA T-SQL SAMPLE 3
--
CREATE TYPE [dbo].[MyTableType] AS TABLE (
    [id] INT NOT NULL IDENTITY(1, 1)
    , [val] VARCHAR(20)
    );
GO

CREATE PROCEDURE [dbo].[MyProcedure] @table MyTableType READONLY
AS
BEGIN
    SELECT * FROM @table;
END;
GO

CREATE FUNCTION [dbo].[MyFunction] (@table MyTableType READONLY)
RETURNS INT
AS
BEGIN
    DECLARE @return INT;

    SELECT TOP 1 @return = [id]
    FROM @table;

    RETURN @return;
END;
GO

DECLARE @table MyTableType;

INSERT INTO @table
VALUES ('value 1'), ('value 2');

EXEC [dbo].[MyProcedure] @table;

DECLARE @return INT;

EXEC @return = [dbo].[MyFunction] @table;

SELECT @return;