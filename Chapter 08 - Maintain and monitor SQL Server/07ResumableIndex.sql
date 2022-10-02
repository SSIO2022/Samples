

ALTER INDEX PK_Sales_OrderLines ON [Sales].[OrderLines] REBUILD
	WITH (
			ONLINE = ON
			,RESUMABLE = ON
			);

--Run this query from another session
SELECT object_name = object_name(object_id)
	,*
FROM sys.index_resumable_operations;

--Also Run this from another session
ALTER INDEX PK_Sales_OrderLines ON [Sales].[OrderLines] PAUSE;

Show that the INDEX rebuild IS

PAUSED:

SELECT object_name = object_name(object_id)
	,*
FROM sys.index_resumable_operations;

ALTER INDEX PK_Sales_OrderLines ON [Sales].[OrderLines] RESUME

