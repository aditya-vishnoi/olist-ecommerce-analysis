ALTER VIEW vw_single_seller_distance AS
with single_seller_order as
		(
		Select
			order_id,
			min(seller_id) as seller_id
		from order_items
		group by order_id
		having count(distinct seller_id) = 1
		)


Select
	o.order_id,
	c.customer_state,
	s.seller_state,
	Round(geography::Point(gc.avg_lat, gc.avg_lng, 4326).STDistance(geography::Point(gs.avg_lat, gs.avg_lng, 4326)) / 1000.0,2) AS distance_km
	from orders as o
	inner join customers as c
	on o.customer_id = c.customer_id
	inner join single_seller_order as sso
	on o.order_id = sso.order_id
	inner join sellers as s
	on s.seller_id = sso.seller_id
	inner join vw_geolocation_clean as gc
	on c.customer_zip_code_prefix = gc.geolocation_zip_code_prefix
	inner join vw_geolocation_clean as gs
	on s.seller_zip_code_prefix = gs.geolocation_zip_code_prefix

Select * from vw_single_seller_distance