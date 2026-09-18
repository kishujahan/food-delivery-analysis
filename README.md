# Food Delivery Intelligence Dashboard

A complete end-to-end data analytics project analyzing a food delivery 
platform's operations, customer behavior, and restaurant performance 
using Excel, PostgreSQL, and Power BI.

## Tools & Skills
- **Excel & Power Query** — Data cleaning, transformation, and feature engineering

- **PostgreSQL & SQL** — Database design, data validation, and business analysis
- **Power BI & DAX** — Interactive dashboard with 4 pages and 15+ measures

## Dataset
- Source: Kaggle (synthetic food delivery platform data)

- 5 Tables: orders_fact, customers_dim, restaurants_dim, 
  deliveries_fact, delivery_persons_dim
- 1,500 orders | 500 customers | 200 restaurants | 500 delivery persons
- Date range: July 2023 – July 2025

## Business Questions Answered

### Customer Analysis
1. Are premium subscribers actually profitable compared to non-premium customers?

2. Are discounts improving customer retention or only driving one-time orders?
3. Which customer segments drive the most revenue?
4. What is the platform's customer retention and churn rate?

### Operational Analysis
5. Which vehicle types and distance tiers contribute most to SLA breaches?

6. Which operational factors drive delivery cancellations?
7. Does delivery fee influence cancellation behavior?

### Restaurant Analysis
8. Which restaurants generate high revenue but deliver poor customer satisfaction?

9. Which active restaurants are experiencing month-over-month order decline?

## Key Findings

### Customer Intelligence
- **66% churn rate** — 316 out of 484 ordering customers have not ordered in 90+ days

- **16 never-activated customers** — registered but never placed an order
- **VIP Users** generate the highest Gross Order Value among all segments, 
  contributing approximately 580K out of total 1.2M platform revenue
- **Discounts do not drive retention** — average order count is nearly identical across all discount tiers
- **Premium customers are not abusing discounts** — discount amounts are similar between premium and non-premium groups

### Operational Performance
- **Electric Bikes** have the highest SLA breach count (74) and struggle most on long distance routes

- **Long Distance** deliveries account for 246 SLA breaches vs only 27 for Short Distance
- **Delivery fee does not influence cancellations** — cancelled orders have slightly lower average fees
- **Scooters** have the highest delivery cancellation rate at ~30%

### Restaurant Health
- **Overall platform rating is 2.45/5** — indicating widespread customer dissatisfaction

- **Classic Cafe (Desserts)** has the lowest rating (0.55) among high revenue restaurants
- **Delicious Diner (French)** shows the steepest month-over-month decline (4 → 1 orders)
- **South Indian and Continental** cuisines generate the highest revenue

## Data Limitations
- Dataset is synthetic (Kaggle) — patterns may not reflect real platform behavior

- Revenue calculated as net order value (delivered orders only) + delivery fees — 
  excludes restaurant commissions and driver payouts
- 545 orders (36%) have no matching delivery record — likely cancelled before 
  delivery assignment
- 16 customers registered but never placed an order
- Delivery fees exist for cancelled/pending orders in raw data — 
  filtered to delivered orders only for accurate revenue calculation
- Month-over-month analysis limited by sparse order frequency 
  per restaurant (avg 7-8 deliveries per restaurant)

  ## Project Structure
```
food-delivery-analysis/
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_load_data.sql
│   ├── 03_data_validation.sql
│   ├── 04_customer_analysis.sql
│   ├── 05_operational_analysis.sql
│   ├── 06_restaurant_analysis.sql
│   ├── 07_retention_analysis.sql
│   └── 08_business_overview.sql
│
├── data/
│   ├── customers_dim.csv
│   ├── orders_fact.csv
│   ├── deliveries_fact.csv
│   ├── restaurants_dim.csv
│   ├── delivery_persons_dim.csv
│   ├── customer_segments.csv
│   └── declining_restaurants.csv
│
├── powerbi/
│   └── food_delivery_dashboard.pbix
│
└── README.md
```

## How to Run

### SQL
1. Set up PostgreSQL and run SQL scripts in order (01 → 08)

2. CSV files in `/data` folder are used for loading data in `02_load_data.sql`

### Power BI
1. Open `food_delivery_dashboard.pbix` in Power BI Desktop

2. Update data source paths in Transform Data if needed

## About This Project
This is an independent end-to-end portfolio project built to demonstrate 
data analytics skills across the full workflow — from raw data cleaning 
to SQL analysis to interactive dashboard.

Built as part of a career transition into data analytics, this project 
covers data cleaning (Excel/Power Query), relational database design and 
querying (PostgreSQL), and business intelligence reporting (Power BI).