select * from pizza_sales;

/* converting the column order_date data type into 'date' data type */
alter table pizza_sales
add column order_dates date;

update pizza_sales
set order_dates = str_to_date(order_dates, '%d-%m-%y');

update pizza_sales
set order_dates = order_date;

alter table pizza_sales
drop column order_date;

/* converting the column order_time data type into 'time' data type */
alter table pizza_sales
add column orders_time time;

update pizza_sales
set orders_time = str_to_date(orders_time,'%H:%i:%s');

update pizza_sales
set orders_time = order_time;

alter table pizza_sales
drop column order_time;

desc pizza_sales;

-- KPI's Requirements --

select sum(total_price) as Total_Revenue from pizza_sales;

select sum(total_price)/count(distinct order_id) as Avg_Order_Value 
from pizza_sales;

select sum(quantity) as Total_Pizza_Sold from pizza_sales;

select count(distinct order_id) as Total_Orders from pizza_sales;

select sum(quantity)/count(distinct order_id) as Avg_Pizzas_Per_order
from pizza_sales;

-- Hourly Trend for Total Pizzas Sold --

select hour(orders_time) as order_hour,sum(quantity) as Total_Pizzas_Sold
from pizza_sales
group by order_hour
order by order_hour;

-- Weekly Trend for Total Orders --

select week(order_dates,3) as ISO_Week_Number, year(order_dates) as Order_Year,
count(distinct order_id) as Total_Orders 
from pizza_sales
group by ISO_Week_Number, Order_Year
order by ISO_Week_Number, Order_Year;

-- Percentage of Sales by Pizza_Category

select pizza_category,sum(total_price) as total_revenue,
(sum(total_price) * 100)/(select sum(total_price) from pizza_sales) as PCT
from pizza_sales 
group by pizza_category;

-- Percentage of Sales by Pizza_Category and filtered by Month
/*  Indicates January , Cast indicates after decimal point there are 10 numbers but we want only 2 numbers so (10,2)*/

select pizza_category,cast(sum(total_price) as decimal (10,2))as total_revenue,
cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales 
where month(order_dates)=1) as decimal (10,2)) as PCT
from pizza_sales
where month(order_dates) = 1
group by pizza_category;

-- Percentage of sales by pizza size --

select pizza_size, sum(total_price) as total_revenue,
sum(total_price) * 100 /(select sum(total_price) from pizza_sales) as PCT
from pizza_sales
group by pizza_size  
order by PCT desc;

-- Total Pizzas sold by Pizza category filtered by month--

select pizza_category, sum(quantity) as Total_Quantity_Sold
from pizza_sales
where month(order_dates) = 4
group by pizza_category 
order by Total_Quantity_Sold desc;

-- Top 5 Pizzas by revenue --

select pizza_name, sum(total_price) as Total_Revenue from pizza_sales
group by pizza_name
order by Total_Revenue desc
limit 5;

-- Bottom 5 Pizzas by revenue --

select pizza_name, sum(total_price) as Total_Revenue from pizza_sales
group by pizza_name
order by Total_Revenue 
limit 5;

-- Top 5 Pizzas By Quantity -- 

SELECT  pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
limit 5;

-- Bottom 5 Pizzas By Quantity --

SELECT  pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold 
limit 5;

-- Top 5 Pizzas by Total orders --

select pizza_name, count(distinct order_id) as Total_Orders
from pizza_sales
group by pizza_name
order by Total_Orders desc
limit 5;

-- Bottom 5 Pizzas by Total orders --

select pizza_name, count(distinct order_id) as Total_Orders
from pizza_sales
group by pizza_name
order by Total_Orders asc
limit 5;


