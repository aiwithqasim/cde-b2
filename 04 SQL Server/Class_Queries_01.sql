
select * from production.brands;
select * from sales.customers;

SELECT
    first_name,
    last_name, email
FROM
    sales.customers;

	SELECT
    product_id,
    product_name,
    list_price
FROM
    production.products;



SELECT
    *
FROM
    sales.customers
WHERE state = 'NY' ;


SELECT
    *
FROM
    sales.customers
WHERE city = 'Fairport' ;



SELECT
    *
FROM
    sales.customers
WHERE state = 'NY' or state = 'CA' ;

SELECT
    *
FROM
    sales.customers
WHERE state = 'NY' AND city = 'Fairport' ;

SELECT * 
FROM sales.customers
where state = 'NY'
ORDER BY first_name DESC; --ASC


SELECT * 
FROM sales.customers
where state = 'NY'
ORDER BY customer_id DESC; 

select*
From production.products
order by model_year ASC ,list_price DESC; 