--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 7: UNDERSTAND TABLE FEATURES
-- EXTRA T-SQL SAMPLE 0
--
DECLARE @nBaseString NCHAR(8) = N'Test'
	, @nvBaseString NVARCHAR(8) = N'Test'
	, @vBaseString VARCHAR(8) = 'Test'
	, @BaseString CHAR(8) = 'Test';

DECLARE @UTF16string nchar(8) = @nBaseString;
DECLARE @vUTF16string nvarchar(8) = @nvBaseString;

SELECT @nBaseString
	, DATALENGTH(@BaseString COLLATE Latin1_General_CI_AS) 'Latin'
	-- The length, as expected, is 8 bytes because it's a fixed-length string
	-- Four spaces follow the word in the output
	, @BaseString COLLATE Latin1_General_100_CI_AS_SC_UTF8, DATALENGTH(@BaseString COLLATE Latin1_General_100_CI_AS_SC_UTF8) 'UTF-8'
	, DATALENGTH(@UTF16string) 'UTF-16'
	, DATALENGTH(@vBaseString COLLATE Latin1_General_CI_AS) 'Latin (v)'
	, DATALENGTH(@vBaseString COLLATE Latin1_General_100_CI_AS_SC_UTF8) 'UTF-8 (v)'
	, DATALENGTH(@vUTF16String) 'UTF-16 (v)';

SET @nBaseString = N'Tëst'; 
SET @nvBaseString = N'Tëst'; 
SET @vBaseString = 'Tëst';
SET @BaseString = 'Tëst';
SET @UTF16string = @nBaseString;
SET @vUTF16string = @nvBaseString;

SELECT @nBaseString
	, DATALENGTH(@BaseString COLLATE Latin1_General_CI_AS) 'Latin'
	-- The length, as expected, is 8 bytes because it's a fixed-length string
	-- However, when examining the output, only 3 spaces follow the word instead of the expected 4
	, @BaseString COLLATE Latin1_General_100_CI_AS_SC_UTF8, DATALENGTH(@BaseString COLLATE Latin1_General_100_CI_AS_SC_UTF8) 'UTF-8'
	, DATALENGTH(@UTF16string) 'UTF-16'
	, DATALENGTH(@vBaseString COLLATE Latin1_General_CI_AS) 'Latin (v)'
	, @vBaseString COLLATE Latin1_General_100_CI_AS_SC_UTF8 'UTF-8 value', DATALENGTH(@vBaseString COLLATE Latin1_General_100_CI_AS_SC_UTF8) 'UTF-8 length'
	, DATALENGTH(@vUTF16String) 'UTF-16 (v)';

SET @nBaseString = N'Tӗṡt';
SET @nvBaseString = N'Tӗṡt'; 
SET @vUTF16string = @nvBaseString;

SELECT @nvBaseString
	-- These characters are not supported in a non-Unicode encoding/code page
	, CAST(@nvBaseString COLLATE Latin1_General_CI_AS AS varchar(8)), DATALENGTH(CAST(@nvBaseString COLLATE Latin1_General_CI_AS AS varchar(8))) 'Latin (v)'
	-- In UTF-8, this requires 7 bytes to store, which is only 1 less than UTF-16, which is perhaps more bytes than you expected
	, CAST(@nvBaseString COLLATE Latin1_General_100_CI_AS_SC_UTF8 AS varchar(8)), DATALENGTH(CAST(@nvBaseString COLLATE Latin1_General_100_CI_AS_SC_UTF8 AS varchar(8))) 'UTF-8 (v)'
	, DATALENGTH(@vUTF16String) 'UTF-16 (v)';

-- DATA LOSS?
-- Assuming your database collation is NOT a UTF-8 collation!
-- If it is, the original 8 character string will already be truncated to 4 characters
DECLARE @Collation sql_variant;
SET @Collation = DATABASEPROPERTYEX(db_name(), 'Collation');
SELECT @Collation;

IF (RIGHT(CAST(@Collation AS VARCHAR(50)), 4) <> 'UTF8')
BEGIN
	DECLARE @Original VARCHAR(8) = 'ëëëëëëëë';
	SELECT @Original;

	-- Assume you change column collation to UTF-8
	-- If the max bytes in the column are insufficient, silent truncation will occur
	SELECT @Original, @Original COLLATE Latin1_General_100_CI_AS_SC_UTF8; 
END

-- EXTENDED DATA LOSS DEMO
USE master;
GO

CREATE DATABASE Utf8ConversionTest
	-- Use a non-UTF-8 collation
	COLLATE Latin1_General_100_CS_AS_SC;
GO

USE Utf8ConversionTest;
GO

CREATE TABLE CollationTest (
	-- This column inherits its collation from the database
	val VARCHAR(8)
);

INSERT INTO CollationTest VALUES ('ëëëëëëëë');
SELECT * FROM CollationTest;

-- Alter the database collation
ALTER DATABASE Utf8ConversionTest
	COLLATE Latin1_General_100_CS_AS_SC_UTF8;

-- Nothing bad has happened
SELECT * FROM CollationTest;

-- Should we expect data loss?
-- If COUNT > 0, then there are rows whose data size will be larger than the
-- current column width
-- With some use of sys tables, this could be automated for an entire database
SELECT COUNT(*)
FROM CollationTest
		-- Note: quadrupling the byte count isn't technically necessary
		-- Anything bigger than the original column width will do
		-- Two CASTs are required
WHERE DATALENGTH(CAST(CAST(val AS VARCHAR(32)) COLLATE Latin1_General_100_CS_AS_SC_UTF8 AS VARCHAR(32))) > 8;

-- Alter the column collation
ALTER TABLE CollationTest
	ALTER COLUMN val varchar(8) COLLATE Latin1_General_100_CS_AS_SC_UTF8;

-- Lost data!!
SELECT * FROM CollationTest;

USE master;
GO

DROP DATABASE Utf8ConversionTest;
GO