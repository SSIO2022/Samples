--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 7: UNDERSTAND TABLE FEATURES
-- T-SQL SAMPLE 4
--
DECLARE @MyDate DATETIME2(0) = '2022-12-22T20:05:00';
DECLARE @TheirString VARCHAR(10) = '2022-12-20';

SELECT DATEDIFF(MINUTE, @TheirString, @MyDate);