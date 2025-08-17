use BikeStores;

select list_price from production.products

select
product_name,
list_price
from 
production.products
where list_price in( 2899.99,1320.99,1799.99)
order by 
product_name;

select 
product_name,
list_price
from production.products
where list_price=1320.99 or list_price=1799.99
order by product_name;

select
product_name,
list_price
from production.products
where list_price not in (2899.99,1320.99,1799.99)
order by product_name;

select
product_name,
category_id,
list_price
from production.products
where list_price BETWEEN 149.99 AND 199.99
order by product_name;


-- left join 

select * from hr.candidates;
select * from hr.employees;

select product_name, order_id 
from production.products p
left join sales.order_items ot
	on ot.product_id = p.product_id
--where order_id is null
order by order_id;

-- from -> where -> select -> order by 
		
select p.product_name, ot.order_id, ot.item_id, o.order_date
from production.products p
left join sales.order_items ot
	on ot.product_id = p.product_id
left join sales.orders o
	on o.order_id = ot.order_id;


select product_name, order_id
from production.products p
left join  sales.order_items ot
	on ot.product_id = p.product_id
where ot.order_id =100
order by order_id;

-- 2nd method 

select product_name, order_id
from production.products p
left join  sales.order_items ot
	on ot.product_id = p.product_id
	AND ot.order_id =100
where order_id is not null
order by order_id desc;


select 
	p.product_name  as pn, 
	ot.order_id as oi, 
	ot.item_id as id,
	o.order_date as od
from
	production.products p
left join 
	sales.order_items ot
	on ot.product_id = p.product_id
left join 
	sales.orders o
	on o.order_id = ot.order_id
where ot.order_id =100
order by o.order_date ;


-- Right join
select p.product_name, ot.order_id from 
sales.order_items ot 
right join production.products p
 on p.product_id = ot.product_id
 order by ot.order_id;