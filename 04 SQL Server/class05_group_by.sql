SELECT
    customer_id,
    YEAR (order_date) order_year,
    COUNT (order_id) order_placed
FROM
    sales.orders
WHERE
    customer_id IN (1, 2)
GROUP BY
    customer_id,
    YEAR (order_date)
having COUNT (order_id)>1
ORDER BY
    customer_id; 

-- U ={}
-- A ={1,2}

-- joins horizontal merging

-- union
-- column name & no should be same 
SELECT  -- 10
    first_name,
    last_name
FROM
    sales.staffs

union -- 10 + 1445 == 1455

SELECT   -- 1445
    first_name,
    last_name
FROM
    sales.customers

-- union 1454

-- union all & union
-- union removes duplicates
select   
	first_name,
    last_name
FROM
    sales.staffs

Union all -- 1445
SELECT  
    first_name,
    last_name
FROM
    sales.customers;

select 
	s.first_name,
    s.last_name
FROM
    sales.staffs s

inner join sales.customers c
	on s.first_name = c.first_name 

select * from sales.staffs;

select first_name + last_name,
	count(first_name + last_name) as count_names
	from sales.customers
group by 
	first_name + last_name
having 
	count(first_name + last_name) > 1;


select b.brand_name, c.category_name, p.model_year,
	   round(SUM (
            ot.quantity * ot.list_price * (1 - ot.discount)
        ), 0) as sales_amount

from production.brands b
inner join production.products p
	on p.brand_id = b.brand_id
inner join production.categories c
	on c.category_id = p.category_id
inner join sales.order_items ot
	on ot.product_id = p.product_id
group by 
	b.brand_name, c.category_name, p.model_year
order by 
	b.brand_name, c.category_name, p.model_year
