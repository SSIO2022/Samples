--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 7: UNDERSTAND TABLE FEATURES
-- T-SQL SAMPLE 10
--

-- Assumes the database has been prepared to support memory-optimized

-- Creating UserDetails as a memory-optimized table because it's heavily accessed
CREATE TABLE dbo.UserDetails (
    UserId    int NOT NULL,
    DetailId  int NOT NULL,
    Detail    nvarchar(50) NOT NULL,
    CONSTRAINT PK_UserDetails PRIMARY KEY NONCLUSTERED (UserId, DetailId)
) WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA);
GO
CREATE PROCEDURE dbo.GetUserName
    @userId int
WITH NATIVE_COMPILATION, SCHEMABINDING
AS
BEGIN ATOMIC
    WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT,
          LANGUAGE = N’us_english’)
    SELECT Detail
    FROM dbo.UserDetails
    WHERE UserId = @userId
        -- Assume this refers to the name
        AND DetailId = 1;
END;
GO
