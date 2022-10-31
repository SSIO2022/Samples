--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

SELECT [mid].[statement]
    , CONCAT (
        'CREATE NONCLUSTERED INDEX IDX_NC_'
        , TRANSLATE(REPLACE([mid].[equality_columns], ' ', ''), '],[', '___')
        , TRANSLATE(REPLACE([mid].[inequality_columns], ' ', ''), '],[', '___')
        , ' ON '
        , [mid].[statement]
        , ' ('
        , [mid].[equality_columns]
        , CASE 
            WHEN [mid].[equality_columns] IS NOT NULL
                AND [mid].[inequality_columns] IS NOT NULL
                THEN ','
            ELSE ''
            END
        , [mid].[inequality_columns]
        , ')'
        , ' INCLUDE ('
        , [mid].[included_columns]
        , ')'
        ) AS [create_index_statement]
    , [migs].[unique_compiles]
    , [migs].[user_seeks]
    , [migs].[user_scans]
    , [migs].[last_user_seek]
    , [migs].[avg_total_user_cost]
    , [migs].[avg_user_impact]
    , [mid].[equality_columns]
    , [mid].[inequality_columns]
    , [mid].[included_columns]
FROM [sys].[dm_db_missing_index_groups] AS [mig]
INNER JOIN [sys].[dm_db_missing_index_group_stats] AS [migs] ON [migs].[group_handle] = [mig].[index_group_handle]
INNER JOIN [sys].[dm_db_missing_index_details] AS [mid] ON [mig].[index_handle] = [mid].[index_handle]
INNER JOIN [sys].[tables] AS [t] ON [t].[object_id] = [mid].[object_id]
INNER JOIN [sys].[schemas] AS [s] ON [s].[schema_id] = [t].[schema_id]
WHERE [mid].[database_id] = DB_ID()
-- count of query compilations that needed this proposed index
--AND       migs.unique_compiles > 10
-- count of query seeks that needed this proposed index
--AND       migs.user_seeks > 10
-- average percentage of cost that could be alleviated with this proposed index
--AND       migs.avg_user_impact > 75
-- Sort by indexes that will have the most impact to the costliest queries
ORDER BY [migs].[avg_user_impact] * [migs].[avg_total_user_cost] DESC;
