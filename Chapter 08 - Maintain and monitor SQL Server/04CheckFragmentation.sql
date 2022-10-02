USE WideWorldImporters;

SELECT DB = db_name(s.database_id)
	,[schema_name] = sc.name
	,[table_name] = o.name
	,index_name = i.name
	,s.index_type_desc
	,s.partition_number -- if the object is partitioned 
	,avg_fragmentation_pct = s.avg_fragmentation_in_percent
	,s.page_count -- pages in object partition 
FROM sys.indexes AS i
CROSS APPLY sys.dm_db_index_physical_stats(DB_ID(), i.object_id, i.index_id, NULL, NULL) AS s
INNER JOIN sys.objects AS o ON o.object_id = s.object_id
INNER JOIN sys.schemas AS sc ON o.schema_id = sc.schema_id
WHERE i.is_disabled = 0
	AND o.object_id = OBJECT_ID(‘Sales.Orders’);

