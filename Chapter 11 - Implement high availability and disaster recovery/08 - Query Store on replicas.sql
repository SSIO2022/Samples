--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

-- For example, the ALTER statement that follows enables Query Store on the 
-- primary database
ALTER DATABASE [CURRENT] SET QUERY_STORE = ON;

-- This ALTER statement enables Quert Store on the secondary replicas
ALTER DATABASE [CURRENT]
	FOR SECONDARY SET QUERY_STORE = ON
	( OPERATION_MODE = READ_WRITE );
