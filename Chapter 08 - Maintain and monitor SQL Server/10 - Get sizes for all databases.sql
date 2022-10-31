--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

DECLARE @fileProperty TABLE (
    DatabaseName SYSNAME
    , DatabaseFileName NVARCHAR(500)
    , FileLocation NVARCHAR(500)
    , FileId INT
    , [type_desc] VARCHAR(50)
    , FileSizeMB DECIMAL(19, 2)
    , SpaceUsedMB DECIMAL(19, 2)
    , AvailableMB DECIMAL(19, 2)
    , FreePercent DECIMAL(19, 2)
    );

INSERT INTO @fileProperty
EXEC sp_MSforeachdb 'USE [?];

SELECT [d].[name] AS [Database_Name]
    , [df].[name] AS [Database_Logical_File_Name]
    , [df].[physical_name] AS [File_Location]
    , [df].[file_id]
    , [df].[type_desc]
    , CAST([df].[size] / 128.0 AS DECIMAL(19, 2)) AS [FileSize_MB]
    , CAST(CAST(FILEPROPERTY([df].[name], ''SpaceUsed'') AS INT) / 128.0 AS DECIMAL(19, 2)) AS [SpaceUsed_MB]
    , CAST([df].[size] / 128.0 - CAST(FILEPROPERTY([df].[name], ''SpaceUsed'') AS INT) / 128.0 AS DECIMAL(19, 2)) AS [Available_MB]
    , CAST(((([df].[size] / 128.0) - (CAST(FILEPROPERTY([df].[name], ''SpaceUsed'') AS INT) * 8 / 1024.0)) / ([df].[size] * 8 / 1024.0)) * 100. AS DECIMAL(19, 2)) AS [FreePercent]
FROM [sys].[database_files] AS [df]
CROSS APPLY [sys].[databases] AS [d]
WHERE [d].[database_id] = DB_ID();
'

--Find files with least amount of free space at top 
SELECT *
FROM @fileProperty
WHERE SpaceUsedMB IS NOT NULL
ORDER BY FreePercent ASC;
