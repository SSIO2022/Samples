--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 7: UNDERSTAND TABLE FEATURES
-- T-SQL SAMPLE 11
--
CREATE TABLE dbo.People (
     PersonId int NOT NULL PRIMARY KEY CLUSTERED,
     FirstName nvarchar(50) NOT NULL,
     LastName nvarchar(50) NOT NULL
) AS NODE;
CREATE TABLE dbo.Relationships (
    RelationshipType nvarchar(50) NOT NULL,
    -- Two people can only be related once
    CONSTRAINT UX_Relationship UNIQUE ($from_id, $to_id),
    CONSTRAINT EC_People_ConnectsTo_People CONNECTION (dbo.People TO dbo.People)
) AS EDGE;

CREATE TABLE dbo.Animals (
   AnimalId int NOT NULL PRIMARY KEY CLUSTERED,
   AnimalName nvarchar(50) NOT NULL
) AS NODE;
-- Drop and recreate the constraint, because an edge constraint cannot be altered
ALTER TABLE Relationships
    DROP CONSTRAINT EC_Relationship;
ALTER TABLE Relationships
    ADD CONSTRAINT EC_Relationship CONNECTION (dbo.People TO dbo.People,
        dbo.People TO dbo.Animals);

-- Insert a few sample people
-- $node_id is implicit and skipped
INSERT INTO dbo.People VALUES
    (1, 'Karina', 'Jakobsen'),
    (2, 'David', 'Hamilton'),
    (3, 'James', 'Hamilton'),
    (4, 'Stella', 'Rosenhain');
    
-- Insert a few sample relationships
-- The first sub-select retrieves the $node_id of the from_node
-- The second sub-select retrieves the $node_id of the to_node
INSERT INTO dbo.Relationships VALUES
    ((SELECT $node_id FROM People WHERE PersonId = 1),
     (SELECT $node_id FROM People WHERE PersonId = 2),
     'spouse'),
     ((SELECT $node_id FROM People WHERE PersonId = 2),
     (SELECT $node_id FROM People WHERE PersonId = 3),
     'father'),
     ((SELECT $node_id FROM People WHERE PersonId = 4),
     (SELECT $node_id FROM People WHERE PersonId = 2),
     'mother');
     
-- Simple graph query
SELECT P1.FirstName + ' is the ' + R.RelationshipType +
    ' of ' + P2.FirstName + '.'
FROM dbo.People P1, dbo.People P2, dbo.Relationships R
WHERE MATCH(P1-(R)->P2);

-- SHORTEST_PATH query
-- Construct Stella Rosenhain's direct descendants' family tree
-- In our example data, two rows will be returned
SELECT P1.FirstName
        , STRING_AGG(P2.FirstName, '->') WITHIN GROUP (GRAPH PATH) AS Decendents
FROM dbo.People P1
    , dbo.People FOR PATH P2
    , dbo.Relationships FOR PATH related_to1
WHERE (MATCH(SHORTEST_PATH(P1(-(related_to1)->P2)+))
    -- Stella Rosenhain
    AND P1.PersonId = 4);