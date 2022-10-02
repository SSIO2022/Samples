--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 7: UNDERSTAND TABLE FEATURES
-- T-SQL SAMPLE 6
--
-- Define the sequence
CREATE SEQUENCE dbo.MySequence AS int
    START WITH 1001
    INCREMENT BY 1
    MINVALUE 1001
    MAXVALUE 1003
    CYCLE;

-- Declare a loop counter
DECLARE @i int = 1;
-- Execute 4 times
WHILE (@i <= 4)
BEGIN
    -- Retrieve the next value from the sequence
    SELECT NEXT VALUE FOR dbo.MySequence AS NextValue;
    -- Increment the loop counter
    SET @i = @i + 1;
END;

/*
-- The first and the second column of the new row will have the same value
INSERT INTO dbo.SomeTable VALUES (NEXT VALUE FOR dbo.MySequence,
    NEXT VALUE FOR dbo.MySequence, 'More data...');

-- Define the sequence object’s increment to 2 and for one of the columns, add 1 to the sequence value
INSERT INTO dbo.SomeTable VALUES (NEXT VALUE FOR dbo.MySequence,
    NEXT VALUE FOR dbo.MySequence + 1, 'More data...');
*/

-- Declare variables to hold the metadata
DECLARE @FirstVal sql_variant, @LastVal sql_variant,
    @Increment sql_variant, @CycleCount int,
    @MinVal sql_variant, @MaxVal sql_variant;

-- Generate 5 numbers and capture all metadata
EXEC sp_sequence_get_range dbo.MySequence
    , @range_size = 5
    , @range_first_value = @FirstVal OUTPUT
    , @range_last_value = @LastVal OUTPUT
    , @range_cycle_count = @CycleCount OUTPUT
    , @sequence_increment = @Increment OUTPUT
    , @sequence_min_value = @MinVal OUTPUT
    , @sequence_max_value = @MaxVal OUTPUT;

-- Output the values of the output parameters
SELECT @FirstVal AS FirstVal, @LastVal AS LastVal
    , @CycleCount AS CycleCount, @Increment AS Increment
    , @MinVal AS MinVal, @MaxVal AS MaxVal;
