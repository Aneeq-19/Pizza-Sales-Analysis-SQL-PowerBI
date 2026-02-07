DROP TABLE  IF EXISTS pizza_delivery

CREATE TABLE pizza_delivery(
pizza_id INT PRIMARY KEY,
order_id INT,
pizza_name_id VARCHAR(100),
quantity INT,
order_date DATE,
order_time TIME,
unit_price FLOAT,
total_price FLOAT,
pizza_size VARCHAR(5),
pizza_category VARCHAR(20),
pizza_ingredients VARCHAR(100),
pizza_name VARCHAR(100)

)
SELECT * FROM pizza_delivery
LIMIT 5
--total revenue 
SELECT SUM(total_price) AS total_revenue 
FROM pizza_delivery

-- AVG ORDER VALUE
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS avg_order_value
FROM pizza_delivery

-- TOTAL PIZZA SOLD
SELECT SUM(quantity) AS total_pizza_sold
FROM pizza_delivery

-- ORDERS PLACED 
SELECT COUNT(DISTINCT order_id ) AS total_orders 
FROM pizza_delivery

--AVG PIZZA PER ORDER
SELECT CAST(CAST(SUM(quantity) AS NUMERIC(10,2)) / 
CAST(COUNT(DISTINCT order_id ) AS NUMERIC(10,2)) 
AS NUMERIC(10,2)) AS AVG_PIZZA_PER_ORDER 
FROM pizza_delivery

-- DAILY TREND 
SELECT 
TRIM(TO_CHAR(order_date, 'Day')) AS DAY_NAME,
COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_delivery
GROUP BY  TRIM(TO_CHAR(order_date, 'Day')) 


-- MONTHLy TREND FOR TOTAL ORDERS 
SELECT 
TRIM(TO_CHAR(order_date, 'Month')) AS Month_NAME,
COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_delivery
GROUP BY  TRIM(TO_CHAR(order_date, 'Month')) 
ORDER BY Total_Orders DESC

-- Hourly Trend
SELECT EXTRACT(Hour From order_time ) AS hour,
COUNT (DISTINCT order_id) AS Total_Orders
FROM pizza_delivery
GROUP BY EXTRACT(Hour From order_time )
ORDER BY total_orders DESC

-- SALES PERCENTAGE ACCORDING TO CATEGORY ACCORDING TO MONTH
SELECT pizza_category , sum(total_price) AS total_sales , sum(total_price)*100 / 
(SELECT SUM(total_price) FROM pizza_delivery 
WHERE EXTRACT(Month FROM order_date) = '05')  
AS sales_percentage
FROM pizza_delivery
WHERE EXTRACT(Month FROM order_date) = '05'
GROUP BY pizza_category

-- SALES PERCENTAGE ACCORDING TO PIZZA SIZE 
SELECT pizza_size, SUM(total_price) AS total_sales, CAST(sum(total_price) * 100 /
(SELECT SUM(total_price) FROM pizza_delivery) AS NUMERIC(10,2))
AS sales_percentage
FROM pizza_delivery
GROUP BY pizza_size
ORDER BY sales_percentage DESC


-- TOP 5 best sellers by REVENUE 
SELECT pizza_name , SUM(total_price) AS total_revenue
FROM pizza_delivery
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5
-- TOP 5 best sellers by  Total quantity
SELECT pizza_name , SUM(quantity) AS total_quantity
FROM pizza_delivery
GROUP BY pizza_name
ORDER BY total_quantity DESC
LIMIT 5
-- TOP 5 best sellers by  total orders
SELECT pizza_name , COUNT(DISTINCT order_id) AS total_orders
FROM pizza_delivery
GROUP BY pizza_name
ORDER BY total_orders DESC
LIMIT 5

-- Bottom 5 sellers by REVENUE
SELECT pizza_name , SUM(total_price) AS total_revenue
FROM pizza_delivery
GROUP BY pizza_name
ORDER BY total_revenue ASC
LIMIT 5

-- Bottm 5 sellers by total_quantity
SELECT pizza_name , SUM(quantity) AS total_quantity
FROM pizza_delivery
GROUP BY pizza_name
ORDER BY total_quantity ASC
LIMIT 5

-- bottom 5 sellers by total orders
SELECT pizza_name , COUNT(DISTINCT order_id) AS total_orders
FROM pizza_delivery
GROUP BY pizza_name
ORDER BY total_orders ASC
LIMIT 5



