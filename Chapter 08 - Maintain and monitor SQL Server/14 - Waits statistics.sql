/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

SELECT TOP (25) [wait_type]
	, [wait_time_ms] / 1000.0 AS [wait_time_s]
	, 100.0 * [wait_time_ms] / NULLIF(SUM([wait_time_ms]) OVER (), 0) AS [Pct]
	, [wait_time_ms] / NULLIF([waiting_tasks_count], 0) AS [avg_ms_per_wait]
FROM [sys].[dm_os_wait_stats] AS [wt]
ORDER BY [Pct] DESC;

-- Script to setup capturing these statistics over time 
CREATE TABLE [dbo].[usr_sys_dm_os_wait_stats] (
	[id] INT NOT NULL IDENTITY(1, 1)
	, [datecapture] DATETIMEOFFSET(0) NOT NULL
	, [wait_type] NVARCHAR(512) NOT NULL
	, [wait_time_s] DECIMAL(19, 1) NOT NULL
	, [Pct] DECIMAL(9, 1) NOT NULL
	, [avg_ms_per_wait] DECIMAL(19, 1) NOT NULL
	, CONSTRAINT [PK_sys_dm_os_wait_stats] PRIMARY KEY CLUSTERED ([id])
	);

-- This part of the script should be in a SQL Agent job, run regularly 
INSERT INTO [dbo].[usr_sys_dm_os_wait_stats] ([datecapture], [wait_type], [wait_time_s], [Pct], [avg_ms_per_wait])
SELECT SYSDATETIMEOFFSET() AS [datacapture]
	, [wait_type]
	, CONVERT(DECIMAL(19, 1), ROUND([wait_time_ms] / 1000.0, 1)) AS [wait_time_s]
	, [wait_time_ms] / NULLIF(SUM([wait_time_ms]) OVER (), 0) AS [Pct]
	, [wait_time_ms] / NULLIF([waiting_tasks_count], 0) AS [avg_ms_per_wait]
FROM [sys].[usr_dm_os_wait_stats] AS [wt]
WHERE [wait_time_ms] > 0
ORDER BY [wait_time_s];
