-- The question is simple but tricky: Given two tables, A and B, with records like this:
-- Table A    Table B
-- 1               1
-- 0               1
-- 2               3
-- 3               2
-- Null          Null
-- What’s the total number of output records for each type of join (LEFT, RIGHT, FULL OUTER, INNER), and how does the final data look?

CREATE TABLE TableA (
    column1 INT
);

INSERT INTO TableA (column1) VALUES
(1),
(0),
(2),
(3),
(NULL);

CREATE TABLE TableB (
    column1 INT
);

INSERT INTO TableB (column1) VALUES
(1),
(1),
(3),
(2),
(NULL);


-- MySQL query

    SELECT COUNT(*)
    FROM tablea t1
    LEFT JOIN tableb t2
    ON t1.column1 = t2.column1

