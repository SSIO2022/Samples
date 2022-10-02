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
    OrderId int NOT NULL,
    OrderDetailId int NOT NULL,
    ProductId int NOT NULL,
    Quantity int NOT NULL,
    ReturnedDate date SPARSE NULL,
    ReturnedReason varchar(50) SPARSE NULL);
