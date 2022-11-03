--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

CREATE CREDENTIAL [https://ssio2022.blob.core.windows.net/onprembackup]
    WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
    -- Remember to remove the leading ? from the token
    SECRET = 'sv=2018-03-28&ss=<...>';

BACKUP DATABASE SamplesTest
    TO URL = 'https://ssio2022.blob.core.windows.net/onprembackup/db.bak'
    -- WITH FORMAT to overwrite the existing file
    WITH FORMAT;
