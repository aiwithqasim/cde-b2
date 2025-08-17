-- Primary key 
-- No Null -  No duplicates 

select * from sales.staffs


--CREATE TABLE table_name (
--    pk_column data_type PRIMARY KEY,
--    ...
--);

create table sales.dummy(
	id VARCHAR (255),
	last_name VARCHAR (255),
	primary key (id)
	)


create table sales.dummy2(
	store_id INT,
	product_id INT ,
	primary key (store_id,product_id)
	)


	-- Not Null 
CREATE TABLE sales.events(
    event_id INT NOT NULL,
    event_name VARCHAR(255),
    start_date DATE NOT NULL,
    duration DEC(5,2)
);

insert into sales.events values(Null,Null,'12-08-2025',5.2);
select * from sales.events;

-- Unique 
-- No duplicates 
-- primary  key/ Unique 

-- NUll 
-- Unique allow one null 



-- create schema hr 
-- create table hr.persons (personid, name, email)

CREATE TABLE hr.persons(
    person_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    UNIQUE(email)
);

INSERT INTO hr.persons(first_name, last_name, email)
VALUES('John','Doe','j.doe@bike.stores');

INSERT INTO hr.persons(first_name, last_name, email)
VALUES('John','Doe','j.doe@bike.stores');

create table sales.dummy3(
	store_id INT,
	product_id INT ,
	UNIQUE  (store_id,product_id)
	)


CREATE TABLE hr.persons1(
    person_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255)
);

alter table hr.persons1
add constraint unique_email unique(email)


-- Check 
-- filteration 
create schema checkk;
go;

create table checkk.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2) CHECK(unit_price > 0) -- add not null constraints to avoid null values 
);

insert into checkk.products values('bike',-5);
select * from checkk.products;

insert into checkk.products values('bike',Null);
	

-- Case 

--CASE input   
--    WHEN e1 THEN r1
--    WHEN e2 THEN r2
--    ...
--    WHEN en THEN rn
--    [ ELSE re ]   
--END  


select distinct(order_status) from sales.orders;
-- 1 - pendings - 8 characters 
-- 2 -  in progress  - 10 


SELECT    
    Case order_status
		when 1 then 'Pending'
		when 2 then 'Processing'
		when 3 then 'Rejected'
		when 4 then 'Completed'
	END AS order_status,
    COUNT(order_id) order_count
FROM    
    sales.orders
WHERE 
    YEAR(order_date) = 2018
GROUP BY 
    order_status;


select
	sum(
		Case order_status
		when 1 then 1
		end
		)
	as 'Pending',

	sum(
		Case order_status
		when 2 then 1
		end
		)
	as 'Processing',

	sum(
		Case order_status
		when 3 then 1
		end
		)
	as 'Rejected',

	sum(
		Case order_status
		when 4 then 1
		end
		)
	as 'Completed'

	from sales.orders


-- Order priority 
-- high, medium, low 

 --  high > 5000 <= 10000  
 -- medium  > 2500  <= 5000
  --  low < 2500

-- order value - order price -> list_price * quantity 

select 
	ot.order_id,
	sum(ot.list_price * ot.quantity ) as order_value,
	case 
		when sum(ot.list_price * ot.quantity ) < 2500 then 'low'
		when sum(ot.list_price * ot.quantity ) > 2500 AND sum(ot.list_price * ot.quantity ) <= 5000 then 'medium'
		when sum(ot.list_price * ot.quantity ) > 5000 AND sum(ot.list_price * ot.quantity ) <= 15000 then 'high'
	else Null
	END as order_priority 
	from sales.order_items ot
group by 
	ot.order_id;


with cte_orders as(
	select 
	ot.order_id,
	sum(ot.list_price * ot.quantity ) as order_value,
	case 
		when sum(ot.list_price * ot.quantity ) < 2500 then 'low'
		when sum(ot.list_price * ot.quantity ) > 2500 AND sum(ot.list_price * ot.quantity ) <= 5000 then 'medium'
		when sum(ot.list_price * ot.quantity ) > 5000 AND sum(ot.list_price * ot.quantity ) <= 15000 then 'high'
	else Null
	END as order_priority 
	from sales.order_items ot
group by 
	ot.order_id
	)
select * from cte_orders
where order_priority = 'high';