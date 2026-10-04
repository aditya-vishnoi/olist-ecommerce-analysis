WITH order_weight AS (
    SELECT
        oi.order_id,
        SUM(p.product_weight_g) AS total_weight_g
    FROM Order_items AS oi
    INNER JOIN Products AS p ON p.product_id = oi.product_id
    GROUP BY oi.order_id
)

SELECT
    CASE
        WHEN ow.total_weight_g IS NULL THEN '5. No Weight Data'
        WHEN ow.total_weight_g < 500 THEN '1. Light (<500g)'
        WHEN ow.total_weight_g < 2000 THEN '2. Medium (500g-2kg)'
        WHEN ow.total_weight_g < 10000 THEN '3. Heavy (2-10kg)'
        ELSE '4. Very Heavy (10kg+)'
    END AS weight_bucket,
    COUNT(*) AS orders,
    ROUND(SUM(CAST(fo.is_late AS float)) / COUNT(*) * 100, 2) AS late_pct
FROM order_weight AS ow
INNER JOIN vw_order_analysis AS fo ON fo.order_id = ow.order_id
GROUP BY CASE
        WHEN ow.total_weight_g IS NULL THEN '5. No Weight Data'
        WHEN ow.total_weight_g < 500 THEN '1. Light (<500g)'
        WHEN ow.total_weight_g < 2000 THEN '2. Medium (500g-2kg)'
        WHEN ow.total_weight_g < 10000 THEN '3. Heavy (2-10kg)'
        ELSE '4. Very Heavy (10kg+)'
    END
ORDER BY weight_bucket;

