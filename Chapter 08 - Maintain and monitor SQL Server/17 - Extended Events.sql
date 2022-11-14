/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

DECLARE @XELFile NVARCHAR(256)
	, @XELFiles NVARCHAR(256)
	, @XELPath NVARCHAR(256);

-- Get the folder path where the system_health .xel files are 
SELECT @XELFile = CAST([t].[target_data] AS XML).value('EventFileTarget[1]/File[1]/@name', 'NVARCHAR(256)')
FROM [sys].[dm_xe_session_targets] AS [t]
	INNER JOIN [sys].[dm_xe_sessions] AS [s] ON [s].[address] = [t].[event_session_address]
WHERE [s].[name] = 'system_health'
	AND [t].[target_name] = 'event_file';

-- Provide wildcard path search for all currently retained .xel files 
SELECT @XELPath = LEFT(@XELFile, LEN(@XELFile) - CHARINDEX('\', REVERSE(@XELFile)))

SELECT @XELFiles = @XELPath + '\system_health_*.xel';

-- Query the .xel files for deadlock reports 
SELECT CAST([event_data] AS XML) AS DeadlockGraph
	, Row_Number() OVER (ORDER BY [file_name], [file_offset]
		) AS [DeadlockID]
FROM [sys].[fn_xe_file_target_read_file](@XELFiles, NULL, NULL, NULL) AS [F]
WHERE [event_data] LIKE '<event name="xml_deadlock_report%';
