select * from items;

/* How many distinct items were ordered? */

select count(distinct name)
from items;

/* what is the distribution of veg and non veg? */

select is_veg, count(name) as item
from items
group by is_veg;

/* write a query to show the word chicken contain in the items ? */

select *
from items
where name like '%chicken%';

/* what is the average number of items per order? */

select count(name)/count(distinct order_id) as avgitemsperorder
from items;

/* How many times each item were ordered? */

select name, count(*)
from items
group by name
order by count(*)  desc;

/* what are the different values of rain mode?*/

select * from orders;

select distinct rain_mode
from orders;

/* How many times on_time was delivered?*/

select count(on_time)
from orders;
 
/*  From how many distinct restaurant food were ordered?*/

select count(distinct restaurant_name)
from orders;

/*Is there any favorite restaurant?*/

select restaurant_name,count(*)
from orders
group by restaurant_name
order by count(*) desc;

/*what was the month which like they had a most number of orders?*/

select date_format(order_time, '%y-%M') as month, count(distinct order_id)
from orders
group by month
order by count(distinct order_id) desc;

/*when was the last ordered were made or more recent ordered?*/

select max(order_time)
from orders;

/*How much revenue was made by swiggy in each of the month?*/

select date_format(order_time,'%y%M') as month,sum(order_total) as totalrevenue
from orders
group by month
order by totalrevenue desc;

/*on average per order how much do customer spend money?*/

select sum(order_total)/count(distinct order_id) as average
from orders;

/*for every year how much money spent on swiggy and the year on year change in revenue?*/

with final as(
select year(order_time) as yearorder,sum(order_total) as revenue
from orders
group by yearorder)
select yearorder,revenue,
lag(revenue)over(order by yearorder) as previousrevenue
from final;

/*for every year how much money spent on swiggy and find the rank revenue?*/

with final as(
select year(order_time) as yearorder,sum(order_total) as total_revenue
from orders
group by yearorder)
select yearorder,total_revenue,
rank()over(order by total_revenue desc) as ranking
from final;

/*For every restaurent how much money spent on swiggy and find the rank revenue?*/

with restaurant as(
select restaurant_name, sum(order_total) as revenue
from orders
group by restaurant_name)
select restaurant_name, revenue,
rank()over(order by revenue desc) as ranking
from restaurant;

/*What money was made in the various type of rain mode? */

select  rain_mode, sum(order_total) as revenue
from orders
group by rain_mode;

/*In each order what items were ordered? */
select items.name,items.is_veg, orders.restaurant_name
from items
join orders on items.order_id = orders.order_id;









