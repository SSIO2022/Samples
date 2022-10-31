--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

SELECT [g].[DatabaseName] AS [DB]
    , [mf].[name] AS [Logical_File_Name]
    , [mf].[physical_name] AS [Physical_File_Loc]
    , [mf].[type]
    ,
    -- The size in MB (converted from the number of 8KB pages) the file increased. 
    CONVERT(DECIMAL(19, 2), [g].[IntegerData] * 8 / 1024.) AS [EventGrowth_MB]
    , [g].[StartTime]
    , --Time of the autogrowth event 
    -- Length of time (in seconds) necessary to extend the file. 
    CONVERT(DECIMAL(19, 2), [g].[Duration] / 1000. / 1000.) AS [EventDuration_s]
    , CASE 
        WHEN [mf].[is_percent_growth] = 1
            THEN CONVERT(CHAR(2), [mf].[growth]) + ' % '
        ELSE CONVERT(VARCHAR(30), [mf].[growth] * 8. / 1024.) + 'MB'
        END AS [Current_Auto_Growth_Set]
    , CONVERT(DECIMAL(19, 2), [mf].[size] * 8. / 1024.) AS [Current_File_Size_MB]
    , [d].[recovery_model_desc]
FROM [sys].[fn_trace_gettable]((
            SELECT SUBSTRING((
                        SELECT [path]
                        FROM [sys].[traces]
                        WHERE [is_default] = 1
                        ), 0, CHARINDEX('\log_', (
                            SELECT [path]
                            FROM [sys].[traces]
                            WHERE [is_default] = 1
                            ), 0) + 4) + '.trc'
            ), DEFAULT) AS [g]
INNER JOIN [sys].[master_files] AS [mf] ON [mf].[database_id] = [g].[DatabaseID]
    AND [g].[FileName] = [mf].[name]
INNER JOIN [sys].[databases] AS [d] ON [d].[database_id] = [g].[DatabaseID]
ORDER BY [g].[StartTime] DESC;