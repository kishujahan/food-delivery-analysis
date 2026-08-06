COPY customers_dim FROM 'D:/Kishwar/food_delivery_analysis/customers_dim.csv' DELIMITER ',' CSV HEADER;

COPY restaurants_dim FROM 'D:/Kishwar/food_delivery_analysis/restaurants_dim.csv' DELIMITER ',' CSV HEADER;

COPY delivery_persons_dim FROM 'D:/Kishwar/food_delivery_analysis/delivery_persons_dim.csv' DELIMITER ',' CSV HEADER;

COPY orders_fact FROM 'D:/Kishwar/food_delivery_analysis/orders_fact.csv' DELIMITER ',' CSV HEADER;

COPY deliveries_fact FROM 'D:/Kishwar/food_delivery_analysis/deliveries_fact.csv' DELIMITER ',' CSV HEADER;

SELECT COUNT(*) FROM customers_dim;
SELECT COUNT(*) FROM restaurants_dim;
SELECT COUNT(*) FROM delivery_persons_dim;
SELECT COUNT(*) FROM orders_fact;
SELECT COUNT(*) FROM deliveries_fact;