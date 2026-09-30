Create view vw_order_analysis as


Select
	do.order_id,
	ssd.seller_id,
	do.customer_state,
	do.is_late,
	do.days_vs_estimate,
	vor.review_score,
	ssd.seller_state,
	ssd.distance_km,
	c.customer_unique_id,
	Cast(o.order_purchase_timestamp as date) as order_date,
	CAST(o.order_delivered_customer_date AS date) AS delivery_date
from vw_delivered_orders as do
Left join vw_order_review as vor
on do.order_id = vor.order_id
left join vw_single_seller_distance as ssd
on do.order_id = ssd.order_id
inner join customers as c 
on c.customer_id = do.customer_id
inner join orders as o 
on o.order_id = do.order_id


Select count(*) from vw_order_analysis