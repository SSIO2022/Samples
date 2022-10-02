--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 7: UNDERSTAND TABLE FEATURES
-- T-SQL SAMPLE 4a
--

DECLARE @SomeJSON nvarchar(50) = '{ "test": "value" }';

SELECT ISJSON(@SomeJSON) IsValid, JSON_VALUE(@SomeJSON, '$.test') [Status];
