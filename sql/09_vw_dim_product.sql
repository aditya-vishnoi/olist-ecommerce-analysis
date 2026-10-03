Create view vw_dim_product as 
Select
	P.product_id,
	P.Product_category_name,
	c.Product_category_name_english,
	P.product_weight_g
from Products as P
Left Join Product_category_name as c
on p.product_category_name = c.product_category_name;

Select * from vw_dim_product