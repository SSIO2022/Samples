--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

USE [WideWorldImporters];

SELECT DB_NAME([s].[database_id]) AS [DB]
	, [sc].[name] AS [schema_name]
	, [o].[name] AS [table_name]
	, [i].[name] AS [index_name]
	, [s].[index_type_desc]
	, [s].[partition_number] 			-- If the object is partitioned 
	, [s].[avg_fragmentation_in_percent] AS [avg_fragmentation_pct]
	, [s].[page_count] 					-- Pages in object partition 
FROM [sys].[indexes] AS [i]
	CROSS APPLY [sys].[dm_db_index_physical_stats](DB_ID(), [i].[object_id], [i].[index_id], NULL, NULL) AS [s]
	INNER JOIN [sys].[objects] AS [o] ON [o].[object_id] = [s].[object_id]
	INNER JOIN [sys].[schemas] AS [sc] ON [o].[schema_id] = [sc].[schema_id]
WHERE [i].[is_disabled] = 0
	AND [o].[object_id] = OBJECT_ID('Sales.Orders');
