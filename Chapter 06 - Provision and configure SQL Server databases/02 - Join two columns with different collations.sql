/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

SELECT * 
FROM [CS_AS].[sales].[sales] AS [s1]
    INNER JOIN [CI_AS].[sales].[sales] AS [s2]
        ON [s1].[salestext] COLLATE SQL_Latin1_General_CP1_CI_AS = [s2].[salestext];
