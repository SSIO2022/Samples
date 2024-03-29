/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

-- This script contains sequences that should be run in two different connections

-- Run this in connection 1
CREATE TABLE [dbo].[dead] ([col1] INT);

INSERT INTO [dbo].[dead]
SELECT 1;

CREATE TABLE [dbo].[lock] ([col1] INT);

INSERT INTO [dbo].[lock]
SELECT 1;

BEGIN TRAN t1;

UPDATE [dbo].[dead]
    WITH (TABLOCK)
SET [col1] = 2;

-- Run this script in connection 2: 
BEGIN TRAN t2;

UPDATE [dbo].[lock]
    WITH (TABLOCK)
SET [col1] = 3;

UPDATE [dbo].[dead]
    WITH (TABLOCK)
SET [col1] = 3;

COMMIT TRAN t2;

-- Now, back in connection 1: 
UPDATE [dbo].[lock]
    WITH (TABLOCK)
SET [col1] = 4

COMMIT TRAN t1
