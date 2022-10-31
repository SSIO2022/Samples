--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

/* suggested indexes: */
CREATE NONCLUSTERED INDEX IDX_NC_Gamelog_Team1 
    ON dbo.gamelog (Team1) 
    INCLUDE (GameYear, GameWeek, Team1Score, Team2Score);

CREATE NONCLUSTERED INDEX IDX_NC_Gamelog_Team1_GameWeek_GameYear 
    ON dbo.gamelog (Team1, GameWeek, GameYear) 
    INCLUDE (Team1Score);

CREATE NONCLUSTERED INDEX IDX_NC_Gamelog_Team1_GameWeek_GameYear_Team2 
    ON dbo.gamelog (Team1, GameWeek, GameYear, Team2);

/* Combined into the useful index: */
CREATE NONCLUSTERED INDEX IDX_NC_Gamelog_Team1_GameWeek_GameYear_Team2
ON dbo.gamelog (Team1, GameWeek, GameYear, Team2)
INCLUDE (Team1Score, Team2Score);
