SELECT
    b.brand_name AS brand,
    c.category_name AS category,
    p.model_year,
    round(
        SUM (
            quantity * i.list_price * (1 - discount)
        ),
        0
    ) sales INTO sales.sales_summary
FROM
    sales.order_items i
INNER JOIN production.products p ON p.product_id = i.product_id
INNER JOIN production.brands b ON b.brand_id = p.brand_id
INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY
    b.brand_name,
    c.category_name,
    p.model_year
ORDER BY
    b.brand_name,
    c.category_name,
    p.model_year;

select * from sales.sales_summary;

-- select brand, category, sales
-- group by brand, category 
select brand, category, sum(sales) as sales
from sales.sales_summary
group by brand, category 

-- select brand, sales
-- group by brand 

select brand, sum(sales) as sales
from sales.sales_summary
group by brand 

-- select  category, sales
-- group by category 

select  category, sum(sales) as sales
from sales.sales_summary
group by category 

-- find total sales 
select sum(sales) as sales
from sales.sales_summary

-- (brand, category) 2(n) 2(2) -> 4
-- (brand)
-- (category)
-- ()

select brand, category, sum(sales) as sales
from sales.sales_summary
group by brand, category 

Union all 

select brand, null, sum(sales) as sales
from sales.sales_summary
group by brand 

Union all 


select null, category, sum(sales) as sales
from sales.sales_summary
group by category 

union all 

select null, null, sum(sales) as sales
from sales.sales_summary

-- Grouping sets 
select 
	brand, category, sum(sales) as sales
from 
	sales.sales_summary
group by 
	GROUPING sets(
	(brand,category),
	(brand),
	(category),
	()
);


-- d1, d2, d3 -> 2(n) -> 2(3) -> 8
	--(d1, d2, d3)
	--(d1, d2)
	--(d1,d3)
	--(d2,d3)
	--(d1)
	--(d2)
	--(d3)
	--()

-- Cube

select 
	brand, category, sum(sales) as sales
from 
	sales.sales_summary
group by 
	cube(brand, category)


select 
	brand, category, sum(sales) as sales
from 
	sales.sales_summary
group by 
	brand, 
	cube(category)

 -- brand (category)
 -- brand ()

-- cube(category) 2(1)-> 2
-- (category)
-- ()

--select d1,d2,d3
--	from sales
--group by (
--	d1,
--	cube(d2,d3))

	--d1 (d2,d3)
	--d1 (d2)
	--d1 (d3)
	--d1 ()

-- d1, d2, d3

-- rollup(d1,d2,d3)
-- (d1,d2,d3)
-- (d1,d2)
-- (d1)
-- ()

-- (d1,d2)
-- d1
-- ()

-- (year, quarter, month)
-- (year, quarter, month)
-- (year,quarter)
--	(year)
-- ()


select 
	brand, category, sum(sales) as sales
from 
	sales.sales_summary
group by 
	Rollup(brand, category)
	-- (brand, category) (brand) ()  -- (category) X

select 
	brand, category, sum(sales) as sales
from 
	sales.sales_summary
group by 
	Rollup(category, brand)
	--  (category, brand) ,(category), ()

select 
	brand, category, sum(sales) as sales
from 
	sales.sales_summary
group by 
	brand,
	Rollup(category) -- (category) ()
	-- brand category
	-- brand ()


select 
	brand, category, sum(sales) as sales
from 
	sales.sales_summary
group by 
	category,
	Rollup( brand ) -- (brand) ()
	-- category brand
	-- category ()
