--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

ALTER TABLE [dbo].[Transactions]
    ALTER INDEX [IDX_NC_H Transactions_1] REBUILD
        WITH (BUCKET_COUNT = 524288);
        --will always round up to the nearest power of two