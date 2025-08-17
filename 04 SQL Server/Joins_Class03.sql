-- 1. List all orders along with the customer's full name and the staff member
-- (first and last) name who handled the order.

-- 2. Get all products and show stock quantities in different store. Include products even if 
-- they don't in exist in stock anywhere.

-- 3. List all orders including customer name, product names, ordered, store name 
-- and quantity ordered.
	
-- first_name || " " || last_name

select p.product_id, p.product_name,s.store_id
from production.products p
left join production.stocks  s 
on s.product_id = p.product_id



SELECT o.order_id,o.order_date, o.order_status ,
	c.first_name  + ' ' +  c.last_name  as full_name,
	concat(s.first_name,' ' , s.last_name) as staff_name
	-- concat()
FROM sales.orders o
inner join sales.customers c
	on c.customer_id = o.customer_id
inner join sales.staffs s 
	on s.staff_id = o.staff_id