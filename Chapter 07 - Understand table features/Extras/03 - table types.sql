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
CREATE TYPE dbo.MyTableType AS TABLE
( id int NOT NULL IDENTITY (1,1), val varchar(20));
GO

CREATE PROCEDURE dbo.MyProcedure
	@table MyTableType READONLY
AS
BEGIN
	SELECT * FROM @table
END;
GO

CREATE FUNCTION dbo.MyFunction
	(@table MyTableType READONLY)
RETURNS int
AS
BEGIN
	DECLARE @return int;
	SELECT top 1 @return = id FROM @table;
	RETURN @return;
END;
GO

DECLARE @table MyTableType;
INSERT INTO @table VALUES ('value 1'), ('value 2');

EXEC dbo.MyProcedure @table;

DECLARE @return int;
EXEC @return = dbo.MyFunction @table;
SELECT @return;
