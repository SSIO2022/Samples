/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

SELECT *
FROM [sys].[dm_os_wait_stats]
WHERE [wt].[wait_type] NOT LIKE ' % SLEEP % ' -- Can be safely ignored, sleeping 
	AND [wt].[wait_type] NOT LIKE 'BROKER % ' -- Internal process 
	AND [wt].[wait_type] NOT LIKE ' % XTP_WAIT % ' -- For memory-optimized tables 
	AND [wt].[wait_type] NOT LIKE ' % SQLTRACE % ' -- internal process 
	AND [wt].[wait_type] NOT LIKE 'QDS % ' -- Asynchronous Query Store data 
	AND [wt].[wait_type] NOT IN (
		-- Common benign wait types 
		'CHECKPOINT_QUEUE' , 'CLR_AUTO_EVENT', 'CLR_MANUAL_EVENT'
		, 'CLR_SEMAPHORE', 'DBMIRROR_DBM_MUTEX', 'DBMIRROR_EVENTS_QUEUE'
		, 'DBMIRRORING_CMD', 'DIRTY_PAGE_POLL', 'DISPATCHER_QUEUE_SEMAPHORE'
		, 'FT_IFTS_SCHEDULER_IDLE_WAIT', 'FT_IFTSHC_MUTEX'
		, 'HADR_FILESTREAM_IOMGR_IOCOMPLETION', 'KSOURCE_WAKEUP', 'LOGMGR_QUEUE'
		, 'ONDEMAND_TASK_QUEUE', 'REQUEST_FOR_DEADLOCK_SEARCH'
		, 'XE_DISPATCHER_WAIT', 'XE_TIMER_EVENT'
		-- Ignorable HADR waits 
		,'HADR_WORK_QUEUE', 'HADR_TIMER_TASK', 'HADR_CLUSAPI_CALL'
		);
