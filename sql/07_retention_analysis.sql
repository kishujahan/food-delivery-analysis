
-- 1. Retention summary - count of active and churned customers

SELECT
    customer_status,
    COUNT(*) AS customer_count
FROM (
    with retentions AS(
        SELECT
            c.customer_id,
            c.name,
            MAX(o.order_date)::DATE AS last_purchased_date
        FROM
            customers_dim c
        LEFT JOIN orders_fact o ON o.customer_id = c.customer_id
        GROUP BY
            c.customer_id,
            c.name
        ORDER BY
            c.customer_id
    )
    SELECT
        customer_id,
        name,
        last_purchased_date,
        CASE
            WHEN last_purchased_date IS NULL THEN 'Never Ordered'
            WHEN last_purchased_date < (SELECT MAX(order_date) FROM orders_fact) - INTERVAL '90 days' 
                THEN 'Churned'
            ELSE 'Active'
        END AS customer_status
    FROM
        retentions
    ORDER BY
        customer_id 
)retention_summary
GROUP BY
    customer_status

-- 2. What factors influence customer churn?

with stats AS(
    SELECT
        c.customer_id,
        c.name,
        MAX(o.order_date)::DATE AS last_purchased_date,
        ROUND(AVG(o.feedback_rating),2) AS rating,
        ROUND(AVG(o.discount_applied),2) AS discount,
        COUNT(
            CASE WHEN o.order_status = 'Cancelled' THEN 1 END
        ) AS cancelled_orders,
        COUNT(o.order_id) AS total_orders,
        COUNT(
            CASE WHEN d.sla_breach_flag = 'Breached' THEN 1 END
        ) AS delayed_deliveries,
        COUNT(d.delivery_id) AS total_deliveries
    FROM
        customers_dim c
    LEFT JOIN orders_fact o ON o.customer_id = c.customer_id
    LEFT JOIN deliveries_fact d ON d.order_id = o.order_id
    GROUP BY
        c.customer_id,
        c.name
    ORDER BY
        c.customer_id
)
SELECT
    CASE 
        WHEN last_purchased_date < (SELECT MAX(order_date) FROM orders_fact) - INTERVAL '90 days' THEN 'Churned'
        ELSE 'Active'
    END AS customer_status,
    ROUND(AVG(rating),2) AS avg_rating,
    ROUND(AVG(discount),2) AS avg_discount,
    ROUND(SUM(cancelled_orders) :: NUMERIC / SUM(total_orders) * 100, 2) AS cancellation_rate,
    ROUND(SUM(delayed_deliveries) :: NUMERIC / SUM(total_deliveries) * 100, 2) AS breach_rate
FROM 
    stats
GROUP BY 
    customer_status



