/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

-- Setting up the database mirroring certificate on the availability replica
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '<UseAReallyStrongMasterKeyPassword>';
CREATE CERTIFICATE [dbm_certificate]   
    AUTHORIZATION dbm_user
    FROM FILE = '/var/opt/mssql/data/dbm_certificate.cer'
    WITH PRIVATE KEY ( FILE = '/var/opt/mssql/data/dbm_certificate.pvk'
                        , DECRYPTION BY PASSWORD = '<UseAReallyStrongPrivateKeyPassword>');
