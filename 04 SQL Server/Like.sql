use BikeStores
select 
customer_id,
first_name, 
last_name
from sales.customers
where last_name like 'z%'
order by last_name;

select 
customer_id,
first_name, 
last_name
from sales.customers
where last_name like '%er'
order by last_name;

Select 
customer_id,
first_name,
last_name
from sales.customers
where last_name like 't%s'
order by last_name;

select 
customer_id,
first_name,
last_name
From sales.customers
where last_name like '_u%'
order by last_name;

select
customer_id,
first_name,
last_name
from sales.customers
where last_name like '[yz]%'
order by last_name;

Select 
customer_id,
first_name,
last_name
from sales.customers
where last_name like '[A-C]%'
order by last_name;

select customer_id,
first_name,
last_name
from sales.customers
where last_name like '[^A-X]%'
order by last_name;

Select 
customer_id,
first_name,
last_name
From sales.customers
where first_name  Not like 'A%'
order by first_name;

-- street city country 
-- like '%pakistan'
-- like '%karachi%'



select 
	concat(ss.first_name, ss.last_name) as staff,
	year(o.order_date) as year,
	sum(quantity * list_price * (1 - discount)) as sales
	from sales.staffs ss 
inner join sales.orders o 
	on o.staff_id = ss.staff_id
inner join sales.order_items ot
	on ot.order_id = o.order_id
group by
	concat(ss.first_name, ss.last_name),
	year(o.order_date);

-- CTE Common table expression 

--WITH cte_name[(column_name [,...])]
--AS
--    (CTE_definition)
--SQL_statement;

with sales_by_staff AS (
	select 
		concat(ss.first_name, ss.last_name) as staff,
		year(o.order_date) as year,
		sum(quantity * list_price * (1 - discount)) as sales
		from sales.staffs ss 
	inner join sales.orders o 
		on o.staff_id = ss.staff_id
	inner join sales.order_items ot
		on ot.order_id = o.order_id
	group by
		concat(ss.first_name, ss.last_name),
		year(o.order_date)
	)
select * from sales_by_staff
where year = '2018';


use BikeStores


WITH cte_sales AS (
    SELECT 
        staff_id, 
        COUNT(*) order_count  
    FROM
        sales.orders
	WHERE 
        YEAR(order_date) = 2018
    GROUP BY
        staff_id

)
SELECT
    AVG(order_count) average_orders_by_staff
FROM 
    cte_sales;
