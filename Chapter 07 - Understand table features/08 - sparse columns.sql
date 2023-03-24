--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 7: UNDERSTAND TABLE FEATURES
-- T-SQL SAMPLE 8
--
CREATE TABLE dbo.OrderDetails (
    OrderId INT NOT NULL
    , OrderDetailId INT NOT NULL
    , ProductId INT NOT NULL
    , Quantity INT NOT NULL
    , ReturnedDate DATE SPARSE NULL
    , ReturnedReason VARCHAR(50) SPARSE NULL
    );