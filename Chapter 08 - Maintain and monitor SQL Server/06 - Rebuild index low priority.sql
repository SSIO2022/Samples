/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

ALTER INDEX [PK_Sales_OrderLines] ON [Sales].[OrderLines] REBUILD
WITH (ONLINE = ON (WAIT_AT_LOW_PRIORITY(MAX_DURATION = 50 MINUTES, ABORT_AFTER_WAIT = SELF)));