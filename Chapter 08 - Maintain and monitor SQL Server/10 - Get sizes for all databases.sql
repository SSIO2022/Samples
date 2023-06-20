/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

DECLARE @FILEPROPERTY TABLE (
	[DatabaseName] SYSNAME
	, [DatabaseFileName] NVARCHAR(500)
	, [FileLocation] NVARCHAR(500)
	, [FileId] INT
	, [type_desc] VARCHAR(50)
	, [FileSizeMB] DECIMAL(19, 2)
	, [SpaceUsedMB] DECIMAL(19, 2)
	, [AvailableMB] DECIMAL(19, 2)
	, [FreePercent] DECIMAL(19, 2));

INSERT INTO @FILEPROPERTY
EXEC sp_MSforeachdb 'USE [?];

SELECT [d].[name] AS [Database_Name]
	, [df].[name] AS [Database_Logical_File_Name]
	, [df].[physical_name] AS [File_Location]
	, [df].[File_ID]
	, [df].[type_desc]
	, CAST([size] / 128.0 AS DECIMAL(19, 2)) AS [FileSize_MB]
	, CAST(CAST(FILEPROPERTY([df].[name], ''SpaceUsed'') AS INT) / 128.0 AS DECIMAL(19, 2)) AS [SpaceUsed_MB]
	, CAST([size] / 128.0 - CAST(FILEPROPERTY([df].[name], ''SpaceUsed'') AS INT) / 128.0 AS DECIMAL(19, 2)) AS [Available_MB]
	, CAST(((([size] / 128.0) - (CAST(FILEPROPERTY([df].[name], ''SpaceUsed'') AS INT) * 8 / 1024.0)) / (size * 8 / 1024.0)) * 100. AS DECIMAL(19, 2)) AS [FreePercent]
FROM [sys].[database_files] AS [df]
    CROSS APPLY [sys].[databases] AS [d]
WHERE [d].[database_id] = DB_ID();'

SELECT *
FROM @FILEPROPERTY
WHERE [SpaceUsedMB] IS NOT NULL
ORDER BY [FreePercent] ASC; -- Find files with least amount of free space at top 
