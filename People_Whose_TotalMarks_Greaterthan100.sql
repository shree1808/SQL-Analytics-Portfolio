USE practise;

CREATE TABLE Person (
    PersonID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100),
    Score INT
);
INSERT INTO Person (PersonID, Name, Email, Score) VALUES
(1, 'Alice', 'alice2018@hotmail.com', 88),
(2, 'Bob', 'bob2018@hotmail.com', 11),
(3, 'Davis', 'davis2018@hotmail.com', 27),
(4, 'Tara', 'tara2018@hotmail.com', 45),
(5, 'John', 'john2018@hotmail.com', 63);

CREATE TABLE Friend (
    PersonID INT,
    FriendID INT,
    PRIMARY KEY (PersonID, FriendID),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
    FOREIGN KEY (FriendID) REFERENCES Person(PersonID)
);

INSERT INTO Friend (PersonID, FriendID) VALUES
(1, 2),
(1, 3),
(2, 1),
(2, 3),
(3, 5),
(4, 2),
(4, 3),
(4, 5);

-- Query-- 
WITH score_flag AS (
SELECT f.personId, COUNT(1) AS num_friends, SUM(p.Score) AS total_score
from friend as f
inner join person p on f.friendId = p.personId
GROUP BY f.personId 
HAVING SUM(p.Score) > 100
order by f.personId ASC
)
SELECT p.Name, sc.*
FROM Person p
INNER JOIN score_flag AS sc ON p.personId = sc.personId