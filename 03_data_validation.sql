
SELECT count (*)
FROM orders_fact o 
LEFT JOIN customers_dim c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT count (*)
FROM orders_fact o 
LEFT JOIN restaurants_dim r ON o.restaurant_id = r.restaurant_id
WHERE r.restaurant_id IS NULL;

SELECT count(*)
FROM deliveries_fact d
LEFT JOIN orders_fact o ON d.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT count (*)
FROM deliveries_fact d
LEFT JOIN delivery_persons_dim p ON d.delivery_person_id = p.delivery_person_id
WHERE p.delivery_person_id IS NULL;