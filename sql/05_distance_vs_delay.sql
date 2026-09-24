

SELECT
    CASE
        WHEN distance_km < 200 THEN '1. Near (<200km)'
        WHEN distance_km < 500 THEN '2. Medium (200-500km)'
        WHEN distance_km < 1000 THEN '3. Far (500-1000km)'
        ELSE '4. Very Far (1000km+)'
    END AS distance_bucket,
    COUNT(*) AS total_orders,
    SUM(is_late) AS late_orders,
    ROUND(SUM(CAST(is_late AS float)) / COUNT(*) * 100, 2) AS late_pct
FROM vw_single_seller_distance as ssd
inner join vw_delivered_orders as do
on ssd.order_id = do.order_id
GROUP BY CASE
        WHEN distance_km < 200 THEN '1. Near (<200km)'
        WHEN distance_km < 500 THEN '2. Medium (200-500km)'
        WHEN distance_km < 1000 THEN '3. Far (500-1000km)'
        ELSE '4. Very Far (1000km+)'
    END
ORDER BY distance_bucket;
