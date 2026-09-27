CREATE VIEW vw_dim_customer AS
With customer_unique_info as 
(
Select
	c.customer_unique_id,
	c.customer_zip_code_prefix,
	c.customer_city,
	c.customer_state,
	row_number() over(partition by c.customer_unique_id order by o.order_purchase_timestamp desc) as row_per_customer
from Customers as c
inner join orders as o 
on c.customer_id = o.customer_id
)

Select
	customer_unique_id,
	customer_zip_code_prefix,
	customer_city,
	customer_state
from customer_unique_info
where row_per_customer = 1



SELECT * FROM vw_dim_customer;