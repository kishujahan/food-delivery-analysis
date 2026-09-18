
--1. Which customer segments are most profitable? (premium vs non-premium)

SELECT    
CASE
    WHEN c.is_premium = '1' THEN 'Premium'
ELSE 'Non-Premium'
    END AS user_category,
    COUNT (order_id) AS order_count,
    SUM(total_amount) AS total_revenue,
    SUM(total_amount-discount_applied) AS net_revenue,
    SUM(discount_applied) AS total_discount,
    ROUND(AVG (total_amount),2) AS avg_order_value
FROM
    orders_fact o 
LEFT JOIN 
    customers_dim c ON o.customer_id = c.customer_id
GROUP BY
    c.is_premium


-- 2. Are discounts improving retention or only driving one-time orders?

WITH discount_category AS (
    SELECT
        percentile_cont(.33) WITHIN GROUP (ORDER BY discount_applied) AS low_cutoff,
        percentile_cont(.67) WITHIN GROUP (ORDER BY discount_applied) AS high_cutoff
    FROM
        orders_fact
),
customer_discount AS (
    SELECT
        customer_id,
    CASE
        WHEN discount_applied <= low_cutoff THEN 'Low'
        WHEN discount_applied >= high_cutoff THEN 'High'
        ELSE 'Medium'
    END AS discount_range,
    COUNT (order_id) AS order_count
    FROM
        orders_fact 
    CROSS JOIN discount_category
    GROUP BY
        customer_id,
        discount_range
)
SELECT
    discount_range,
    ROUND(AVG(order_count),2) AS avg_order_count
FROM
    customer_discount
GROUP BY
    discount_range


-- 3. Which customer segment is more valuable?

WITH customer_stats AS(
    SELECT
        customer_id,
        COUNT(order_id) AS order_count,
        ROUND(AVG(total_amount),2) AS aov 
    FROM
        orders_fact
    GROUP BY
        customer_id
),
medians AS(
    SELECT
        percentile_cont(.5) WITHIN GROUP (ORDER BY order_count) as median_frequency,
        ROUND(percentile_cont(.5) WITHIN GROUP (ORDER BY aov)::NUMERIC,2) as median_aov
    FROM
        customer_stats
),
segmentation AS(
    SELECT
        customer_id,
        order_count,
        aov,
        CASE
            WHEN order_count >= median_frequency AND aov >= median_aov THEN 'VIP_users'
            WHEN order_count >= median_frequency AND aov < median_aov THEN 'Loyal_budget_users'
            WHEN order_count < median_frequency AND aov >= median_aov THEN 'Big_spenders'
            ELSE 'At_risk'
        END AS customer_segment
    FROM
        customer_stats
    CROSS JOIN medians
)
SELECT
    customer_segment,
    COUNT(customer_id) AS customer_count,
    ROUND(AVG(aov),2) AS avg_aov,
    ROUND(AVG(order_count),2) AS avg_order_count,
    SUM(aov * order_count) AS total_revenue
FROM
    segmentation
GROUP BY
     customer_segment

