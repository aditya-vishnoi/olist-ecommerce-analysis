CREATE VIEW vw_delivered_orders AS
SELECT
    o.order_id,
    o.customer_id,
    c.customer_unique_id,
    c.customer_state,
    DATEDIFF(day, o.order_estimated_delivery_date,
                  o.order_delivered_customer_date) AS days_vs_estimate,
    CASE WHEN DATEDIFF(day, o.order_estimated_delivery_date,
                            o.order_delivered_customer_date) > 0
         THEN 1 ELSE 0 END AS is_late
FROM Orders AS o
INNER JOIN Customers AS c
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL;


select
    *
from vw_delivered_orders;