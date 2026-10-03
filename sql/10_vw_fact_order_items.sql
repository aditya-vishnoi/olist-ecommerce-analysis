CREATE VIEW vw_fact_order_items AS
SELECT
    order_id,
    product_id,
    seller_id,
    price,
    freight_value
FROM Order_items;

