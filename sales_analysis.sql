-- Step 1: Only review the what type of data is
-- General Queries
select COUNT(*) FROM superstores_sales;
select * from superstores_sales;

-- Step 2: Change datatype
ALTER TABLE superstores_sales 
ALTER COLUMN "Order Date" 
TYPE DATE 
USING TO_DATE("Order Date", 'DD-MM-YYYY');

ALTER TABLE superstores_sales 
ALTER COLUMN "Ship Date" 
TYPE DATE 
USING TO_DATE("Ship Date", 'DD-MM-YYYY');

ALTER TABLE superstores_sales
ALTER COLUMN "Row ID" TYPE INT
USING "Row ID"::integer;

ALTER TABLE superstores_sales
ALTER COLUMN "Postal Code" TYPE INT
USING "Postal Code"::integer;

ALTER TABLE superstores_sales
ALTER COLUMN "Sales" TYPE NUMERIC 
USING "Sales"::NUMERIC;

-- Extract Day from Ship Date
SELECT EXTRACT(DAY FROM "Ship Date") AS order_day FROM superstores_sales;

-- Step 3: Analysis Queries
-- Top 3 Highest Selling Month
WITH MonthlySales AS (
    SELECT EXTRACT(MONTH FROM "Order Date") AS month, "Sales"
    FROM superstores_sales
)
SELECT month, SUM("Sales") AS total_sales
FROM MonthlySales
GROUP BY month
ORDER BY 2 DESC
LIMIT 3;

-- Top 3 Highest Selling Year
WITH YearlySales AS (  
    SELECT EXTRACT(YEAR FROM "Order Date") AS sales_year, 
           SUM("Sales") AS total_sales         
    FROM superstores_sales
    GROUP BY sales_year                 
)
SELECT sales_year, total_sales
FROM YearlySales
ORDER BY total_sales DESC
LIMIT 3;

-- Total Regional Sales
WITH RegionSales AS (
    SELECT "Region", SUM("Sales") AS total_sales
    FROM superstores_sales
    GROUP BY "Region"
)
SELECT "Region", ROUND(total_sales) AS total_sales
FROM RegionSales
ORDER BY total_sales DESC;

-- Top 3 Performing Products and Regions
WITH ProductRegionSales AS (
    SELECT "Product Name", "Region", SUM("Sales") AS total_sales
    FROM superstores_sales
    GROUP BY "Product Name", "Region"
)
SELECT "Product Name", "Region", total_sales
FROM (
    SELECT "Product Name", "Region", total_sales,
           ROW_NUMBER() OVER (PARTITION BY "Region" ORDER BY total_sales DESC) AS rank
    FROM ProductRegionSales
) AS ranked
WHERE rank <= 3
ORDER BY "Region", total_sales DESC;

-- Top-3 Performing Products in South Region
SELECT "Product Name", ROUND(SUM("Sales"), 2) AS total_sales, "Region"
FROM superstores_sales
WHERE "Region" = 'South'
GROUP BY "Product Name", "Region"
ORDER BY total_sales DESC
LIMIT 3;

-- Top 10 Customers with Highest Purchasing 
SELECT "Customer Name", SUM("Sales") AS total_sales
FROM superstores_sales
GROUP BY "Customer Name"
ORDER BY 2 DESC
LIMIT 10;

-- Repeat vs. One-Time Customers
-- Repeated Customers
SELECT "Customer Name", COUNT(*) AS order_count
FROM superstores_sales
GROUP BY "Customer Name"
ORDER BY 2 DESC;

-- One-Time Customers
SELECT "Customer Name", COUNT(*) AS order_count
FROM superstores_sales
GROUP BY "Customer Name"
HAVING COUNT(*) = 1
ORDER BY 2 DESC;

-- Average Order Value (AOV) per customer
SELECT "Customer Name", ROUND(AVG("Sales")) AS avg_order_value
FROM superstores_sales
GROUP BY "Customer Name"
ORDER BY avg_order_value DESC;

-- Top 3 Highest Selling Category
SELECT "Category", SUM("Sales") AS total_sales
FROM superstores_sales
GROUP BY "Category"
ORDER BY 2 DESC
LIMIT 3;

-- Top 10 Highest Selling Sub-Category
SELECT "Sub-Category", SUM("Sales") AS total_sales
FROM superstores_sales
GROUP BY "Sub-Category"
ORDER BY 2 DESC
LIMIT 10;

-- Top 3 Highest Selling in Country
SELECT "Country", SUM("Sales") AS total_sales
FROM superstores_sales
GROUP BY "Country"
ORDER BY 2 DESC;

-- Top 3 Highest Selling in State
SELECT "State", SUM("Sales") AS total_sales
FROM superstores_sales
GROUP BY "State"
ORDER BY 2 DESC
LIMIT 10;

-- Top 3 Highest Selling in City
SELECT "City", SUM("Sales") AS total_sales
FROM superstores_sales
GROUP BY "City"
ORDER BY 2 DESC
LIMIT 10;

-- Order Count by City
SELECT "City", COUNT(*) AS order_count
FROM superstores_sales
GROUP BY "City"
ORDER BY order_count DESC;

SELECT COUNT(*) AS order_count
FROM superstores_sales
ORDER BY order_count DESC;

-- Order Count by State
SELECT "State", COUNT(*) AS order_count
FROM superstores_sales
GROUP BY "State"
ORDER BY order_count DESC;

-- Shipping Time Analysis
SELECT DISTINCT "Ship Mode" FROM superstores_sales;

-- Categorizing Ship Modes by Speed and Cost with Corresponding Order Counts
SELECT 
    "Ship Mode", COUNT(*) AS order_count,
    CASE
        WHEN "Ship Mode" = 'Standard Class' THEN 'Slowest'
        WHEN "Ship Mode" = 'Second Class' THEN '2nd Faster'
        WHEN "Ship Mode" = 'First Class' THEN '1st Faster'
        WHEN "Ship Mode" = 'Same Day' THEN 'Fastest'
        ELSE 'Other'
    END AS Speed,
    CASE
        WHEN "Ship Mode" = 'Standard Class' THEN 'Lowest'
        WHEN "Ship Mode" = 'Second Class' THEN '2nd Higher'
        WHEN "Ship Mode" = 'First Class' THEN '1st Higher'
        WHEN "Ship Mode" = 'Same Day' THEN 'Highest'
        ELSE 'Other'
    END AS Cost
FROM superstores_sales
GROUP BY "Ship Mode"
ORDER BY 2 DESC;

-- Same Day Orders by City
SELECT "City", "Ship Mode", COUNT(*) AS order_count
FROM superstores_sales
WHERE "Ship Mode" = 'Same Day'
GROUP BY "City", "Ship Mode"
ORDER BY order_count DESC;

-- New York City Orders by Ship Mode
SELECT "Ship Mode", COUNT(*) AS order_count
FROM superstores_sales
WHERE "City" = 'New York City'
GROUP BY "Ship Mode"
ORDER BY order_count DESC;

-- Calculate delivery time (Ship Date - Order Date)
SELECT CONCAT(("Ship Date" - "Order Date"), ' Days') AS delivery_time, COUNT(*) AS order_count
FROM superstores_sales
GROUP BY delivery_time
ORDER BY delivery_time DESC;

-- Average Time of Delivering Orders
SELECT CONCAT(ROUND(AVG(("Ship Date" - "Order Date"))), ' Days') AS avg_delivery_time
FROM superstores_sales;

-- Identify late deliveries by city or region
SELECT "City", ROUND(AVG("Ship Date" - "Order Date")) AS avg_delivery_time
FROM superstores_sales
WHERE ("Ship Date" - "Order Date") > 4
GROUP BY "City"
ORDER BY avg_delivery_time DESC;

-- Segment-Based Analysis
-- Sales by customer segment
SELECT DISTINCT "Segment", COUNT(*) AS order_count
FROM superstores_sales
GROUP BY "Segment"
ORDER BY order_count DESC;

-- Compare average order value (AOV) by segment
SELECT "Segment", AVG("Sales") AS avg_order_value
FROM superstores_sales
GROUP BY "Segment"
ORDER BY avg_order_value DESC;
