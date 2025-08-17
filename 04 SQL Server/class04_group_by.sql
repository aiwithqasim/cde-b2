SELECT
	e.staff_id as emp_id,
    e.first_name + ' ' + e.last_name employee,
    m.first_name + ' ' + m.last_name manager,
	m.manager_id 
FROM
    sales.staffs e
INNER JOIN sales.staffs m ON m.staff_id = e.manager_id
ORDER BY
    manager;


SELECT
	e.staff_id as emp_id,
    e.first_name + ' ' + e.last_name employee,
    m.first_name + ' ' + m.last_name manager,
	m.manager_id 
FROM
    sales.staffs e
left JOIN sales.staffs m ON m.staff_id = e.manager_id
ORDER BY
    manager;


SELECT
    c1.city,c1.customer_id,
    c1.first_name + ' ' + c1.last_name customer_1
FROM
    sales.customers c1;


SELECT
    c1.city,
    c1.first_name + ' ' + c1.last_name customer_1,
    c2.first_name + ' ' + c2.last_name customer_2
FROM
    sales.customers c1
INNER JOIN sales.customers c2 ON c1.customer_id > c2.customer_id
AND c1.city = c2.city
ORDER BY
    city,
    customer_1,
    customer_2;


	-- Group by 

-- Syntax 

--SELECT
--    select_list
--FROM
--    table_name
--GROUP BY
--    column_name1,
--    column_name2 ,...;


-- year()

select customer_id,
	year(order_date) as order_year
from sales.orders
order by customer_id;

-- count 1 (1 time in 2016 & 2 times in 2018)

select customer_id,
	year(order_date) as order_year
from sales.orders
group by 
	customer_id,
	year(order_date)
order by customer_id;


select 
	customer_id
from 
	sales.orders
group by 
	customer_id
order by 
	customer_id;



-- aggregate functions (sum,max ,min , count avg) 
select 
	customer_id,
	year(order_date) as order_year,
	count(order_id) as total_orders
from sales.orders
group by customer_id, year(order_date)
order by customer_id;


-- find customers count by city and highest no. of customers from which city ?
-- add state as well 
select c.city , count(order_id) as order_count
from sales.customers c
inner join sales.orders o 
on o.customer_id = c.customer_id
group by c.city
order by count(order_id) desc;


-- find total sales by customer id 
-- quantity * list_price - discount 

select * from sales.order_items;

--  2 * 1799.99 * (1 - 0.20) 20%  100 -20 = 80 
-- 3599.98 * 0.80
-- 2879.984


select customer_id,
	sum(ot.quantity * ot.list_price * (1- ot.discount)) as sales_value
	from sales.orders o
inner join sales.order_items ot 
	on ot.order_id = o.order_id
group by customer_id
order by customer_id;


select customer_id,
	year(o.order_date) as order_year,
	sum(ot.quantity * ot.list_price * (1- ot.discount)) as sales_value
	from sales.orders o
inner join sales.order_items ot 
	on ot.order_id = o.order_id
group by customer_id, year(o.order_date)
order by customer_id;


-- task:  find brand name and avg price for 2018
SELECT b.brand_name, AVG(p.list_price) as avg_price
FROM production.brands b
INNER JOIN production.products p
ON b.brand_id = p.brand_id
WHERE p.model_year = 2018
GROUP BY brand_name;




--SELECT b.brand_name, AVG(p.list_price) as avg_price
--FROM production.brands b
--INNER JOIN production.products p
--ON b.brand_id = p.brand_id
--GROUP BY brand_name
--where AVG(p.list_price) > 1000;



SELECT b.brand_name, AVG(p.list_price) as avg_price
FROM production.brands b
INNER JOIN production.products p
ON b.brand_id = p.brand_id
GROUP BY brand_name
having AVG(p.list_price) > 1000;


SELECT b.brand_name, AVG(p.list_price) as avg_price
FROM production.brands b
INNER JOIN production.products p
ON b.brand_id = p.brand_id
where p.model_year = 2018
GROUP BY brand_name
having AVG(p.list_price) > 1000;



SELECT
    brand_name,
    MIN (list_price) min_price,
    MAX (list_price) max_price
FROM
    production.products p
INNER JOIN production.brands b ON b.brand_id = p.brand_id
WHERE
    model_year = 2018
GROUP BY
    brand_name
ORDER BY
    brand_name;


select customer_id,
	year(o.order_date) as order_year,
	sum(ot.quantity * ot.list_price * (1- ot.discount)) as sales_value
	from sales.orders o
inner join sales.order_items ot 
	on ot.order_id = o.order_id
group by customer_id, year(o.order_date)
having sum(ot.quantity * ot.list_price * (1- ot.discount)) > 1000
order by customer_id;

-- task: count orders by staff_id 
select s.staff_id, count(o.order_id) as orders_by_staff from sales.staffs s
inner join sales.orders o
	on o.staff_id = s.staff_id
group by s.staff_id
order by count(o.order_id) desc;




SELECT
    customer_id,
	year(order_date) as order_year,
	count(order_id) order_placed
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
group by 
	customer_id,
	year(order_date)
ORDER BY
    customer_id;
