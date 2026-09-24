create view vw_order_analysis as

Select
	do.order_id,
	do.customer_state,
	do.is_late,
	do.days_vs_estimate,
	vor.review_score,
	ssd.seller_state,
	ssd.distance_km
from vw_delivered_orders as do
Left join vw_order_review as vor
on do.order_id = vor.order_id
left join vw_single_seller_distance as ssd
on do.order_id = ssd.order_id


Select * from vw_order_analysis