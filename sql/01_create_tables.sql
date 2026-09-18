CREATE TABLE customers_dim (
    customer_id INT primary key,
    name varchar(100),
    email varchar(50),
    phone varchar(50),
    location text,
    sigup_date date,
    is_premium smallint,
    preferred_cuisine varchar(100),
    total_orders INT,
    average_rating numeric (3,2) 
);

CREATE TABLE restaurants_dim(
    restaurant_id INT primary key,
    name varchar (100),
    cuisine_type varchar(50),
    location text,
    owner_name varchar(50),
    average_delivery_time INT,
    contact_number varchar(50),
    rating numeric(3,2),
    total_orders INT,
    is_active smallint
    
);

CREATE TABLE delivery_persons_dim (
    delivery_person_id INT primary key,
    name varchar (100),
    contact_number varchar (50),
    vehichle_type varchar (50),
    total_deliveries INT,
    average_rating numeric (3,2),
    location text
);

CREATE TABLE orders_fact (
    order_id INT primary key,
    customer_id INT,
    restaurant_id INT,
    order_date timestamp,
    delivery_time timestamp,
    order_status varchar(50),
    total_amount numeric (10,2),
    payment_mode varchar(50),
    feedback_rating numeric (3,2),
    total_fulfillment_minutes INT,
    discount_applied numeric (10,2)
);

CREATE TABLE deliveries_fact(
    delivery_id INT primary key,
    order_id INT,
    delivery_person_id INT,
    delivery_status varchar (50),
    distance numeric (5,2),
    delivery_time INT,
    estimated_time INT,
    delivery_fee numeric (5,2),
    vehichle_type varchar (50),
    delay_minutes INT,
    sla_breach_flag varchar (50),
    distance_tier varchar (50)
);

SELECT table_name 
FROM information_schema.tables
WHERE table_schema = 'public';