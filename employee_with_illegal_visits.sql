-- Q) Finding employees with illegal visits (MySQL version) -- Ankit Bansal
-- we need to display The name of the employee, total_visits, most_visited_floor and the resources_used by the employees.

CREATE TABLE entries ( 
    name VARCHAR(20),
    address VARCHAR(20),
    email VARCHAR(20),
    floor INT,
    resources VARCHAR(10)
);

INSERT INTO entries (name, address, email, floor, resources) 
VALUES 
    ('A', 'Bangalore', 'A@gmail.com', 1, 'CPU'),
    ('A', 'Bangalore', 'A1@gmail.com', 1, 'CPU'),
    ('A', 'Bangalore', 'A2@gmail.com', 2, 'DESKTOP'),
    ('B', 'Bangalore', 'B@gmail.com', 2, 'DESKTOP'),
    ('B', 'Bangalore', 'B1@gmail.com', 2, 'DESKTOP'),
    ('B', 'Bangalore', 'B2@gmail.com', 1, 'MONITOR');

SELECT * FROM entries;

with visit_flag as (
SELECT 
    name, 
    floor,
    COUNT(1) as total_visit_flag,
    RANK() OVER(partition by name ORDER BY count(1) DESC) AS rn
FROM entries
GROUP BY name, floor
),
resource_used_flag as (
select 
    name,
    COUNT(1) AS total_visits,
    group_concat(distinct resources) As resources_used
from entries
group by name
)
select 
    vf.name, 
    ruf.total_visits, 
    vf.floor AS most_visited_floor, 
    ruf.resources_used
from 
    resource_used_flag As ruf
join 
    visit_flag as vf
on 
    ruf.name = vf.name
where vf.rn=1;


