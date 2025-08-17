-- we need to finds products whose list_price is greater than
-- avg price 


-- 1st we need to find avg price 

select avg(list_price)
from production.products;
-- 1520.59

select * from production.products
where list_price > 1520.59;

select * from production.products -- outer query 
where list_price > 
	(	
		select avg(list_price)  -- inner query/ nested  query 
		from production.products
	);
	-- order of execution inner query -> outer query 


-- first inner query find customer id of 'new york'
-- outer query 

select customer_id
	from sales.customers
where city = 'New York';

select order_id, order_date, customer_id 
	from sales.orders
where customer_id IN --(16,178,327,411,854,927,1016)
	(
		select customer_id
			from sales.customers
		where city = 'New York'
	)
-- without sub query try it with inner join 


SELECT
    brand_id
FROM
    production.brands
WHERE
    brand_name = 'Strider'
OR brand_name = 'Trek';


SELECT
            AVG (list_price)
        FROM
            production.products
        WHERE
            brand_id IN (6,9);


SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price > (
        2450.279855)
ORDER BY
    list_price;



SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price > (
        SELECT
            AVG (list_price)
        FROM
            production.products
        WHERE
            brand_id IN (
                SELECT
                    brand_id
                FROM
                    production.brands
                WHERE
                    brand_name = 'Strider'
                OR brand_name = 'Trek'
            )
    )
ORDER BY
    list_price;


--             category_name = 'Mountain Bikes'
--       OR category_name = 'Road Bikes'

-- find product id,  product name 


select category_id 
	from production.categories
	where category_name = 'Mountain Bikes'
      OR category_name = 'Road Bikes'


select product_id, product_name 
from production.products 
where category_id in (
	select category_id 
	from production.categories
	where category_name = 'Mountain Bikes'
      OR category_name = 'Road Bikes'
	  ) 

-- Select 
select order_id, order_date ,
	(select max(list_price) 
		from production.products
	) as max_list_price 
from sales.orders


select order_id, order_date ,
	(select max(list_price) 
		from sales.order_items ot
		where ot.order_id = o.order_id
	) as max_list_price 
from sales.orders o;

-- >= ANY 
	-- (50,70) -- 45X 50 , 60, 90-- minumum value true
-- >= ALL 
	-- (50,70) --  85, 55X 60X 68X 71 -- maximum value true 


select avg(list_price)
	from production.products
group by brand_id 


select product_name, list_price 
	from production.products 
where list_price >= ANY(
	select avg(list_price)
		from production.products
	group by brand_id 
	)
	--500, 3000

select product_name, list_price 
	from production.products 
where list_price >= ALL(
	select avg(list_price)
		from production.products
	group by brand_id 
	)

-- Exists  or Not Exists

select staff_id,
	count(order_id) as order_count
from sales.orders
group by
	staff_id;

-- Find avg of order count 

select 
	avg(order_count) as avg_order_count
from 
	(
	select staff_id,
	count(order_id) as order_count
	from sales.orders
	group by
		staff_id
	) as t 


SELECT
    product_name,
    list_price,
    category_id
FROM
    production.products p1
WHERE
    list_price IN (
        SELECT
            MAX (p2.list_price)
        FROM
            production.products p2
        WHERE
            p2.category_id = p1.category_id
        GROUP BY
            p2.category_id
    )
ORDER BY
    category_id,
    product_name;



	--Iteration 1 : -> a
	-- outer query 
	--	categoory_id 1 - product name a
		
	--  inner query 
	--	categoory_id 1 - product name a  
	--	max_value  = 120 
		
	