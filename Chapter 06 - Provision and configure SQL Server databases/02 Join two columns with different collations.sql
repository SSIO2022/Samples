SELECT * 
FROM CS_AS.sales.sales s1
    INNER JOIN CI_AS.sales.sales s2
        ON s1.[salestext] COLLATE SQL_Latin1_General_CP1_CI_AS = s2.[salestext];
