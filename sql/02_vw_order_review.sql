/* Realtion in late delivery and customer satisfaction */

CREATE VIEW vw_order_review AS
WITH ranked AS (
    SELECT review_id, order_id,
    review_score,
    ROW_NUMBER() OVER (PARTITION BY order_id
                              ORDER BY review_creation_date DESC) AS rn
    FROM Order_reviews
)


SELECT review_id, order_id, review_score
FROM ranked
WHERE rn = 1; 


SELECT
    r.review_score,
    COUNT(*) AS delivered_orders,
    SUM(d.is_late) AS late_delivered,
    ROUND(SUM(CAST(d.is_late AS float)) / COUNT(*) * 100, 2) AS pct_late
FROM vw_delivered_orders AS d
INNER JOIN vw_order_review AS r
    ON r.order_id = d.order_id
GROUP BY r.review_score
ORDER BY r.review_score DESC;

