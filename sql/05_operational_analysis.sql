
--1. What factors contribute most to delayed deliveries?

SELECT
    distance_tier,
    vehichle_type,
    ROUND(AVG(delay_minutes),2) AS avg_delay_minutes,
    COUNT(
        CASE WHEN sla_breach_flag = 'Breached' THEN 1 END
    ) AS breached_deliveries_count
FROM
    deliveries_fact
GROUP BY
    distance_tier,
    vehichle_type


-- 2. Which operational factors increase cancellation rates?

WITH cancellations AS(
    SELECT
        distance_tier,
        vehichle_type,
        COUNT(delivery_status) AS total_deliveries,
        COUNT(
            CASE WHEN delivery_status = 'Cancelled' THEN 1 END
        ) AS cancelled_deliveries
    FROM
        deliveries_fact
    GROUP BY
        distance_tier,
        vehichle_type
)
SELECT
    distance_tier,
    vehichle_type,
    cancelled_deliveries,
    ROUND((cancelled_deliveries :: NUMERIC / total_deliveries) * 100,2) AS cancellation_rate
FROM
    cancellations
ORDER BY
    cancellation_rate DESC


-- 3. Does delivery fee have impact on cancellations?

SELECT
    ROUND(AVG(delivery_fee),2) AS avg_delivery_fee,
    CASE 
        WHEN delivery_status = 'Cancelled' THEN 'Cancelled_orders'
        ELSE 'Non_cancelled_orders'
    END AS order_segments
FROM
    deliveries_fact
GROUP BY    
    2
