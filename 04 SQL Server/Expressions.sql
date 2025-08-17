-- COALESCE
 -- (Null, Null,  1,2,3,Null)

select 
	COALESCE (Null, Null,  Null,2,3,Null) as result;
-- Cases
 -- when e1 is not null then e1
 -- when e2 is not null then e2
 -- when e3 is not null then e3

select 
	COALESCE (Null, Null,  Null,Null,1) as result;

select first_name,
	last_name, 
	COALESCE(phone,'N/A') as phone,
	email
from sales.customers;

-- Cases

select first_name,
	last_name, 
	case 
		when phone is not null then phone
		else 'N/A'
		end as phone ,
	email
from sales.customers;


-- create table 
-- staff_id , hourly_rate, monthly_rate, weekly_rate 
-- use check 


CREATE TABLE sales.salaries (
    staff_id INT PRIMARY KEY,
    hourly_rate decimal,
    weekly_rate decimal,
    monthly_rate decimal,
    CHECK(
        hourly_rate IS NOT NULL OR 
        weekly_rate IS NOT NULL OR 
        monthly_rate IS NOT NULL)
);

INSERT INTO 
    sales.salaries(
        staff_id, 
        hourly_rate, 
        weekly_rate, 
        monthly_rate
    )
VALUES
    (1,20, Null,NULL),
    (2,30, NULL,NULL),
    (3,NULL, 1000,NULL),
    (4,NULL, NULL,6000),
    (5,NULL, NULL,6500);

drop table sales.salaries;

select * from sales.salaries;
-- use coalesce and find monthly salary 
-- monthly - available 
-- hourly -- rate * 8 *22
-- weekly -- rate * 4 


-- NULLIF(expression1, expression2)

select 
	NULLIF(10,10) result;


select 
	NULLIF(11,10) result;

--case 
--	when e1 = e2 then NULL 
--	else e1
