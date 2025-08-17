-- revision

use BikeStores;
select 
first_name,
last_name
from 
sales.customers;

select
* 
from 
sales.customers;

select 
first_name,
last_name,
email
from 
sales.customers;

--ORDER BY
select
first_name,
last_name
from
sales.customers
order by 
first_name;

SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name 
OFFSET 10 ROWS;

SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name 
OFFSET 10 ROWS 
FETCH NEXT 10 ROWS ONLY;

select
 DISTINCT product_name
from
production.products
order by
product_name;

select
* 
from
production.products

select
* 
from
production.products
where 
category_id=1 and list_price>400
order by
list_price DESC;

select
* 
from
production.products
where 
category_id=1 and brand_id=1 and list_price>400
order by
list_price DESC;

select *
from 
production.products
where (brand_id = 1 or brand_id = 2) and list_price>1000
order by
list_price DESC;

select * 
from 
production.products
where list_price < 200
or list_price >600
order by 
list_price ;



create schema hr;
go


-- syntax 
--Create table table_name(
--	column_name data_type contraints
--	column_name dataype
--		)

create table hr.candidates(
	id INT PRIMARY KEY IDENTITY,
	fullname varchar(100) Not Null
)
create table hr.employees(
	id INT PRIMARY KEY IDENTITY,
	fullname varchar(100) Not Null
)

select * from hr.candidates;

insert into hr.candidates(fullname) values
    ('John Doe'),
    ('Lily Bush'),
    ('Peter Drucker'),
    ('Jane Doe');

	INSERT INTO 
    hr.employees(fullname)
VALUES
    ('John Doe'),
    ('Jane Doe'),
    ('Michael Scott'),
    ('Jack Sparrow');

select id as ID,fullname as fn from hr.employees;
select * from hr.candidates;



select c.id, c.fullname, e.id,e.fullname
from hr.candidates c
inner join hr.employees e 
	on e.fullname = c.fullname;

select e.id as emp, e.fullname as emp_name, c.id as candid_id, c.fullname as candid_name
from hr.employees e
left join hr.candidates c
	on c.fullname = e.fullname;

select e.id as emp, e.fullname      as emp_name, c.id as candid_id, c.fullname as candid_name
from hr.employees e
right join hr.candidates c
	on c.fullname = e.fullname;


select c.id as candid_id, c.fullname, e.id  as emp_id,e.fullname
from hr.candidates c
inner join hr.employees e 
	on e.fullname = c.fullname;

select e.id as ID, e.fullname as fn
from hr.employees e ;


-- inner join 

select * from production.products;

select * from production.categories;

select  p.product_id, p.product_name, c.category_name
from production.products  p
inner join production.categories c
	on p.category_id = c.category_id;

select  p.product_id, p.product_name, c.category_name
from production.products  p
inner join production.categories c
	on p.category_id = c.category_id
where c.category_name ='Mountain Bikes';



select product_name,category_name,brand_name, list_price from 
production.products p
inner join production.categories c
	on c.category_id = p.category_id
inner join production.brands b
	on b.brand_id= p.brand_id;


select c.first_name, c.last_name, p.product_name, o.order_status from sales.customers c
inner join sales.orders o
	on c.customer_id = o.customer_id
inner join sales.order_items ot
	on ot.order_id = o.order_id
inner join production.products p
	on p.product_id = ot.product_id;


select st.store_name, s.quantity from sales.stores st
inner join production.stocks s
	on s.store_id = st.store_id




select p.product_name, c.category_name
from production.products p
inner join production.categories c
	on p.category_id = c.category_id