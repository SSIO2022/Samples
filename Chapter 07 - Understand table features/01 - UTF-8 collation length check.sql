--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 7: UNDERSTAND TABLE FEATURES
-- T-SQL SAMPLE 1
--
-- If COUNT > 0, then there are rows whose data size will be larger than the
-- current column width supports

SELECT COUNT(*)
FROM dbo.CollationTest
/* This WHERE clause is used to determine which values will no longer fit
    in the width of the column (8 bytes) after altering the column to use
    a collation from the UTF-8 family of collations, where a single character
    might take up four times as much space (8 * 4 = 32).
    Note: quadrupling the byte count of the source column is not necessary,
    any value larger than the source column width will do.
    Two CASTs are required:
    The inner CAST converts val from varchar(8) to varchar(32) to simulate the UTF-8 column width.
    The outer CAST converts provides val at the UTF-8 collation.
    This needs to be varchar(32) to analyze the converted UTF-8 records in the column val */
WHERE DATALENGTH(CAST(CAST(val AS VARCHAR(32))
    COLLATE Latin1_General_100_CS_AS_SC_UTF8 AS VARCHAR(32))) > 8;