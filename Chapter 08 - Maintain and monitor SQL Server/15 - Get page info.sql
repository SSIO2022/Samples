--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################


SELECT [r].[request_id]
	, [pi].[database_id]
	, [pi].[file_id]
	, [pi].[page_id]
	, [pi].[object_id]
	, [pi].[page_type_desc]
	, [pi].[index_id]
	, [pi].[page_level]
	, [pi].[slot_count] AS [rows_in_page]
FROM [sys].[dm_exec_requests] AS [r]
	CROSS APPLY [sys].[fn_PageResCracker]([r].[page_resource]) AS [prc]
	CROSS APPLY [sys].[dm_db_page_info]([r].[database_id], [prc].[file_id], [prc].[page_id], 'DETAILED') AS [pi];
