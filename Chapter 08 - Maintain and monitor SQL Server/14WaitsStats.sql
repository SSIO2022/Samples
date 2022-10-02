SELECT TOP (25) wait_type
	,wait_time_s = wait_time_ms / 1000.
	,Pct = 100. * wait_time_ms / nullif(sum(wait_time_ms) OVER (), 0)
	,avg_ms_per_wait = wait_time_ms / nullif(waiting_tasks_count, 0)
FROM sys.dm_os_wait_stats AS wt
ORDER BY Pct DESC;

--Script to setup capturing these statistics over time 
CREATE TABLE dbo.usr_sys_dm_os_wait_stats (
	id INT NOT NULL IDENTITY(1, 1)
	,datecapture DATETIMEOFFSET(0) NOT NULL
	,wait_type NVARCHAR(512) NOT NULL
	,wait_time_s DECIMAL(19, 1) NOT NULL
	,Pct DECIMAL(9, 1) NOT NULL
	,avg_ms_per_wait DECIMAL(19, 1) NOT NULL
	,CONSTRAINT PK_sys_dm_os_wait_stats PRIMARY KEY CLUSTERED (id)
	);

--This part of the script should be in a SQL Agent job, run regularly 
INSERT INTO dbo.usr_sys_dm_os_wait_stats (
	datecapture
	,wait_type
	,wait_time_s
	,Pct
	,avg_ms_per_wait
	)
SELECT datecapture = SYSDATETIMEOFFSET()
	,wait_type
	,wait_time_s = convert(DECIMAL(19, 1), round(wait_time_ms / 1000.0, 1))
	,Pct = wait_time_ms / nullif(sum(wait_time_ms) OVER (), 0)
	,avg_ms_per_wait = wait_time_ms / nullif(waiting_tasks_count, 0)
FROM sys.usr_dm_os_wait_stats wt
WHERE wait_time_ms > 0
ORDER BY wait_time_s;
