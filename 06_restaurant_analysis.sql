
-- 1. Which restaurants generate high revenue but low customer satisfaction?


WITH revenue_rating AS(
    SELECT
        o.restaurant_id,
        r.name,
        SUM(o.total_amount) AS revenue,
        ROUND(AVG(o.feedback_rating),2) AS rating
    FROM
        orders_fact o
    LEFT JOIN restaurants_dim r ON o.restaurant_id = r.restaurant_id
    GROUP BY
        o.restaurant_id,
        r.name
),
medians AS(
    SELECT
        PERCENTILE_CONT(.5) WITHIN GROUP (ORDER BY revenue) AS median_revenue,
        PERCENTILE_CONT(.5) WITHIN GROUP (ORDER BY rating) AS median_rating
FROM
    revenue_rating
)
SELECT
    restaurant_id,
    name,
    revenue,
    rating
FROM
    revenue_rating
CROSS JOIN medians
WHERE 
    revenue >= median_revenue AND rating < median_rating
ORDER BY 
    revenue DESC


-- 2. Which active restaurants are declining month-over-month in order volume?

WITH counts AS(
    SELECT
        r.restaurant_id,
        r.name,
        TO_CHAR(o.order_date, 'YYYY-MM') AS month,
        COUNT(o.order_id) AS order_count
    FROM
        restaurants_dim r
    LEFT JOIN orders_fact o ON o.restaurant_id = r.restaurant_id
    WHERE
        r.is_active = 1
    GROUP BY
        r.restaurant_id,
        month,
        r.name
    ORDER BY
        r.restaurant_id,
        month
),
mom_comparision AS(
    SELECT
        restaurant_id,
        name,
        order_count AS current_month_orders,
        LAG(order_count) OVER (PARTITION BY restaurant_id ORDER BY month) AS prev_month_orders
    FROM
        counts
)
SELECT
    restaurant_id,
    name,
    prev_month_orders,
    current_month_orders,
    (prev_month_orders - current_month_orders) AS monthly_difference
FROM
    mom_comparision
WHERE
    current_month_orders < prev_month_orders AND 
    prev_month_orders IS NOT NULL
ORDER BY
    monthly_difference DESC,
    restaurant_id

