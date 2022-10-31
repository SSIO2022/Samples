--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

CREATE INDEX [IX_Application_People_IsEmployee]
ON [Application].[People]([IsEmployee]) 
WHERE IsEmployee = 1;
WITH (DROP_EXISTING = ON)
