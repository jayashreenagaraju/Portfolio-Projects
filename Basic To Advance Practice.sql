create table customer
(customer_id int8 primary key,
 first_name varchar(50),
 last_name varchar(50),
 address_id int8);
 
 select * from customer;
 insert into customer values
(1,'mary','smith',5),
(3,'linda','williams',7),
(4,'barbara','jones',8),
(2,'madan','mohan',6);
 select * from customer;
 
 create table payment
 (customer_id int8 primary key,
  amount int8,
  mode varchar(50),
  payment_date date);
  
  insert into payment values
  (1,60,'cash','2020-09-24'),
  (2,30,'credit card','2020-04-27'),
  (8,110,'cash','2021-01-26'),
  (10,70,'mobile payment','2021-02-28'),
  (11,80,'cash','2021-03-01');
  select * from payment;
  
  select * 
  from customer as c
  inner join payment as p
  on c.customer_id = p.customer_id;
  
  select * 
  from customer as c
  left join payment as p
  on c.customer_id = p.customer_id;
 
  select c.first_name,c.last_name,p.customer_id
  from customer as c
  right join payment as p
  on c.customer_id = p.customer_id;
  
  select * 
  from customer as c
  left join payment as p
  on c.customer_id = p.customer_id
  union 
  select *
  from customer as c
  right join payment as p
  on c.customer_id = p.customer_id;
  
  select * 
  from customer as c
  left join payment as p
  on c.customer_id = p.customer_id
  union all 
  select *
  from customer as c
  right join payment as p
  on c.customer_id = p.customer_id;
  
  select c.customer_id,c.first_name,c.last_name,p.amount,p.mode
  from customer as c
  join payment as p
  on c.customer_id = p.customer_id
  order by amount desc;
  
  select * from payment;
  
 
  select * 
  from payment 
  where amount > ( select avg(amount) from payment);
  
  select customer_id,amount,mode
  from payment
  where customer_id in (select customer_id from customer);
  
  select first_name,last_name 
  from customer as c
  where exists(select customer_id,amount
               from payment as p
			   where c.customer_id = p.customer_id and
               amount > 30);
  
  create table test_data
  (new_id int,
   new_cat varchar(50));
   
   Insert into test_data values
   (100 ,'agni'),
   (200 ,'agni'),
   (500 ,'dharti'), 
   (700 ,'dharti'),
   (200 ,'vayu'),
   (300 ,'vayu'),
   (500 ,'vayu');
   select * from test_data;
   
select new_id,new_cat,
sum(new_id) over(order by new_id rows between unbounded preceding and unbounded following) as total,
avg(new_id) over(order by new_id rows between unbounded preceding and unbounded following) as average,
count(new_id) over(order by new_id rows between unbounded preceding and unbounded following) as count,  
 min(new_id) over(order by new_id rows between unbounded preceding and unbounded following) as min, 
 max(new_id) over(order by new_id rows between unbounded preceding and unbounded following) as max
 from test_data;
 
 select new_id,
 row_number() over(order by new_id) as rownum,
 rank() over (order by new_id) as ranking,
 dense_rank() over (order by new_id) as dense,
 percent_rank() over(order by new_id) as per
 from test_data;
 
 select new_id,
 first_value(new_id) over (order by new_id) as firstvalue,
 last_value(new_id) over (order by new_id) as lastvalue,
 lead(new_id) over (order by new_id) as ld,
 lag(new_id)over (order by new_id)as lg
 from test_data;
 
 select * from customer;
 select * from payment;
 
 with my_cte as(
   select * ,avg(amount) over (order by p.customer_id desc) as average
   from payment as p
   inner join customer as c
   on p.customer_id = c.customer_id
 )
 select first_name,amount
 from my_cte;
  
  
