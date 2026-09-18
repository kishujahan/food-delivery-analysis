
-- Note: Revenue = Net order value (delivered orders only) + delivery fees (delivered only)
-- Does not account for restaurant commissions or driver payouts

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    SUM(CASE 
        WHEN o.order_status = 'Delivered' THEN o.total_amount ELSE 0 END) AS gross_order_value,
    SUM(CASE 
        WHEN o.order_status = 'Delivered' THEN o.total_amount - o.discount_applied ELSE 0 END) AS net_order_value,
    (SELECT SUM(delivery_fee) FROM deliveries_fact WHERE delivery_status = 'Delivered') AS delivery_fee_revenue,
    SUM(CASE 
        WHEN o.order_status = 'Delivered' THEN o.total_amount - o.discount_applied ELSE 0 END) + 
            (SELECT SUM(delivery_fee) FROM deliveries_fact WHERE delivery_status = 'Delivered') AS revenue,
    ROUND(AVG(o.feedback_rating), 2) AS overall_rating
FROM 
    orders_fact o

