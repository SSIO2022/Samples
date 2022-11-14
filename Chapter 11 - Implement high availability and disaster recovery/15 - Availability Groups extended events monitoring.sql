/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

/* Create Extended Events session to monitor availability group synchronization
   Recommended for diagnostic purposes only
   For monitoring events on Primary Replica */
CREATE EVENT SESSION [AG_Synchronization_Events_Primary] ON SERVER
ADD EVENT sqlserver.hadr_log_block_group_commit,
ADD EVENT sqlserver.log_flush_start,
ADD EVENT sqlserver.hadr_log_block_send_complete,
ADD EVENT sqlserver.log_flush_complete,
ADD EVENT ucs.ucs_connection_send_msg,
ADD EVENT sqlserver.hadr_receive_harden_lsn_message,
ADD EVENT sqlserver.hadr_db_commit_mgr_harden
ADD TARGET package0.event_file
     (SET filename=N'Synchronization_Events_Primary.xel',
     max_file_size=(5),max_rollover_files=(2))
WITH (STARTUP_STATE=ON);
GO

/* Recommended for diagnostic purposes only
   for monitoring events on a Secondary Replica */
CREATE EVENT SESSION [AG_Synchronization_Events_Secondary] ON SERVER
ADD EVENT sqlserver.hadr_transport_receive_log_block_message,
ADD EVENT sqlserver.log_flush_start,
ADD EVENT sqlserver.log_flush_complete,
ADD EVENT sqlserver.hadr_send_harden_lsn_message,
ADD EVENT ucs.ucs_connection_send_msg
ADD TARGET package0.event_file
    (SET filename=N'Synchronization_Events_Secondary.xel',
     max_file_size=(5),max_rollover_files=(2))
WITH (STARTUP_STATE=ON);
GO

ALTER EVENT SESSION [AG_Synchronization_Events_Secondary] ON SERVER STATE=START
ALTER EVENT SESSION [AG_Synchronization_Events_Primary] ON SERVER STATE=START
