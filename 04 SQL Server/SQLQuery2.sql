SELECT
    *
FROM
    sales.customers
WHERE
    state = 'CA'
ORDER BY
    first_name asc;

--Order by 

--SELECT
--    select_list
--FROM
--    table_name
--ORDER BY 
--    column_name | expression [ASC | DESC ];

SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    city,
    first_name desc;


SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    state; 

--  from where select order by

select first_name,last_name,city
from sales.customers
order by 
	3;


 --  postgre sql  limit 10

select * from production.products;



select top 100
	* from production.products
order by list_price desc;


select top 100 * from production.stocks
order by quantity asc;


select top 20 * from sales.orders
order by order_date desc;


---- offset & fetch 
----ORDER BY column_list [ASC |DESC]
---- OFFSET offset_row_count {ROW | ROWS}
---- FETCH {FIRST | NEXT} fetch_row_count {ROW | ROWS} ONLY

select * from sales.orders
ORDER BY
    order_id 
OFFSET 10 ROWS 
FETCH NEXT 10 ROWS ONLY;

select * from sales.orders
ORDER BY
    order_id 
OFFSET 10 ROWS 
FETCH NEXT 20 ROWS ONLY;


--Distinct 

--SELECT 
--  DISTINCT column_name 
--FROM 
--  table_name;

select distinct(state) from sales.customers;


SELECT 
  DISTINCT state, city
FROM 
  sales.customers 
ORDER BY 
  city, 
  state;

select phone from sales.customers;

-- Alias 
--AS Column_name
select DISTINCT phone as unique_phone_number
	from sales.customers
order by phone asc

-- import pandas as pd


select product_name ,list_price,brand_id , model_year from production.products
where model_year = 2018 and list_price > 1000 and list_price < 2000; 


SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    list_price > 3000 OR model_year = 2018
ORDER BY
    list_price DESC;


select product_name ,list_price,brand_id , model_year from production.products
where list_price between 1000 and 2000;