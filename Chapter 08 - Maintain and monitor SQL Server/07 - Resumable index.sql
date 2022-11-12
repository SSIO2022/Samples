--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

ALTER INDEX [PK_Sales_OrderLines] ON [Sales].[OrderLines] REBUILD
	WITH (ONLINE = ON, RESUMABLE = ON);

-- Run this query from another session
SELECT OBJECT_NAME([object_id]) AS [object_name]
    , * 
FROM [sys].[index_resumable_operations];

-- Also Run this from another session
ALTER INDEX [PK_Sales_OrderLines] ON [Sales].[OrderLines] PAUSE;

-- Show that the INDEX rebuild IS PAUSED:
SELECT OBJECT_NAME([object_id]) AS [object_name]
    , *
FROM [sys].[index_resumable_operations];

ALTER INDEX [PK_Sales_OrderLines] ON [Sales].[OrderLines] RESUME;
