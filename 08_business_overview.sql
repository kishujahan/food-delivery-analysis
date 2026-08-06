
SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    SUM(o.total_amount) AS gross_order_value,
    SUM(o.total_amount - o.discount_applied) AS net_order_value,
    SUM(d.delivery_fee) AS delivery_fee_revenue,
    (SUM(o.total_amount - o.discount_applied) + SUM(d.delivery_fee)) AS revenue,
    ROUND(AVG(feedback_rating),2) AS overall_rating
FROM
    orders_fact o
LEFT JOIN deliveries_fact d ON d.order_id = o.order_id

