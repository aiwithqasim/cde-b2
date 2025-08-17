CREATE SCHEMA pm;
GO

CREATE TABLE pm.projects(
    id INT PRIMARY KEY IDENTITY,
    title VARCHAR(255) NOT NULL
);

CREATE TABLE pm.members(
    id INT PRIMARY KEY IDENTITY,
    name VARCHAR(120) NOT NULL,
    project_id INT,
    FOREIGN KEY (project_id) 
        REFERENCES pm.projects(id)
);



INSERT INTO 
    pm.projects(title)
VALUES
    ('New CRM for Project Sales'),
    ('ERP Implementation'),
    ('Develop Mobile Sales Platform');


INSERT INTO
    pm.members(name, project_id)
VALUES
    ('John Doe', 1),
    ('Lily Bush', 1),
    ('Jane Doe', 2),
    ('Jack Daniel', null);

select * from pm.projects;
select * from pm.members;


select * from pm.projects p
left join pm.members m
 on p.id = m.project_id;


 select * from pm.projects p
right join pm.members m
 on p.id = m.project_id;


select * from pm.projects p
full outer join pm.members m 
 on p.id = m.project_id;

-- Cross join (Carteisan product) 
-- left table 3 rows
-- right table 4 rows  (3 * 4 = 12) 4 + 4 + 4 

 -- 3 * 5 
 -- 1000000 * 500000 = 


 -- SYNTAX

--SELECT
--  select_list
--FROM
--  T1
--CROSS JOIN T2;

SELECT * FROM pm.projects p
CROSS JOIN pm.members;


select p.product_id, product_name, s.store_id , 
	0 as quantity
from production.products p 
cross join sales.stores s 
order by     
	product_name,
    store_id;



-- Self join 


select * from sales.staffs

select 
	emp.first_name as emp_name,
	mgr.first_name as mgr_name
from sales.staffs emp
inner join sales.staffs mgr 
	on emp.staff_id = mgr.manager_id