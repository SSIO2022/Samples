-- SQL Server 2022 Administration Inside Out (Chapter 13)
-- This is a sample script that accompanies the above title.
--
-- Find names of system-generated ledger objects in the database.

SELECT ts.[name] + '.' + t.[name] AS [ledger_table]
	, hs.[name] + '.' + h.[name] AS [history_table]
	, vs.[name] + '.' + v.[name] AS [ledger_view]
FROM sys.tables AS t
INNER JOIN sys.tables AS h ON h.object_id = t.history_table_id
INNER JOIN sys.views v ON v.object_id = t.ledger_view_id
INNER JOIN sys.schemas ts ON ts.schema_id = t.schema_id
INNER JOIN sys.schemas hs ON hs.schema_id = h.schema_id
INNER JOIN sys.schemas vs ON vs.schema_id = v.schema_id;
GO
