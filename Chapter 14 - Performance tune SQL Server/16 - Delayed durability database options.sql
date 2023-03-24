-- At the database level, you can set the DELAYED_DURABILITY option to DISABLED (default), ALLOWED, or FORCED.
-- ALLOWED allows any explicit transaction to be coded to be optionally set to delayed durability, using:
COMMIT TRANSACTION WITH ( DELAYED_DURABILITY = ON );
-- Setting the DELAYED_DURABILITY option FORCED option means that every transaction, regardless of what the person writing the COMMIT statement wishes, will have asynchronous log writes. This obviously has implications on the entirety of the users of the database, and you should consider it carefully with existing applications.
-- Additionally, for natively compiled procedures, you can specify DELAYED_DURABILITY in the BEGIN ATOMIC block. Take, for example, this header of a procedure in the WideWorldImporters database:
CREATE PROCEDURE [Website].[RecordColdRoomTemperatures_DD]
@SensorReadings Website.SensorDataList READONLY
WITH NATIVE_COMPILATION, SCHEMABINDING, EXECUTE AS OWNER
AS
BEGIN ATOMIC WITH
(
    TRANSACTION ISOLATION LEVEL = SNAPSHOT,
    LANGUAGE = N'English',
    DELAYED_DURABILITY = ON
)
    BEGIN TRY
     …


--You also can force a flush of the transaction log with the system stored procedure sys.sp_flush_log. 