select * from sales;

select SaleDate,Amount,Customers from sales;

select  Amount,Customers,GeoID from sales;

select SaleDate,Amount,Boxes,Amount/Boxes from sales;

select SaleDate,Amount,Boxes,Amount/Boxes as 'Amount per box'from sales;

select * from sales
where Amount > 10000;

select * from sales
where Amount > 10000
order by Amount desc;

select * from sales
where GeoID = 'G1'
order by PID,Amount desc;

select * from sales
where Amount > 10000 and SaleDate >= '2022-01-01';

select saledate , amount from sales
where Amount > 10000 and year(saledate) = 2022
order by Amount desc;

select * from sales 
where Boxes between 0 and 50;

select SaleDate,Amount,Boxes,weekday(saledate) as 'day of week' from sales
where weekday(saledate) = 4;

select * from people
where team = 'delish' or team = 'jucies';

select * from people
where Team in ('delish','jucies');

/* pattern matching*/
select * from people
where Salesperson like 'B%';

select * from people
where Salesperson like '%B%';

select * from sales;

select saledate ,amount,
	case 	when amount < 1000 then 'under 1k'
			when amount < 5000 then  'under 5k'
            when amount < 10000 then 'under 10k'
		else '10k or more'
	end as 'Amount Category'
from sales;

select s.SaleDate,s.Amount,p.Salesperson,s.SPID,p.SPID
from sales s
join people p on p.SPID = s.SPID;
 
select s.SaleDate, s.Amount, pr.Product
from sales s
left join products pr on pr.pid = s.pid;
 
select s.SaleDate,s.Amount,p.team,pr.Product
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.pid = s.pid 
where s.Amount < 500
and p.Team = 'Delish';
  
select s.SaleDate,s.Amount,p.team,pr.Product
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.pid = s.pid 
join geo g on g.GeoID = s.GeoID
where s.Amount < 500
and p.Team = 'Delish'
and g.Geo in ('New Zealand','India')
order by s.SaleDate desc;

/*  1.Print details of shipments (sales) where amounts are > 2,000 and boxes are <100?*/
select * from sales;

select *
from sales
where Amount > 2000 and boxes < 100;

/* 2. How many shipments (sales) each of the sales persons had in the month of January 2022?*/
select p.Salesperson,count(*) as shipment_count
from sales as s
join people as p
on s.SPID = p.SPID
where SaleDate between '2022-01-01' and '2022-01-31' 
group by Salesperson;


/* 3. Which product sells more boxes? Milk Bars or Eclairs?*/
select * from sales;
select * from products;

select p.product, sum(boxes) as total_boxes
from sales as s
join products as p
on p.PID = s.PID
where p.Product in ('Milk Bars','Eclairs')
group by p.Product;

/* 4. Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?*/
select pr.product,sum(Boxes) as box_count
from sales as s
join products as pr
on pr.PID = s.PID
where pr.Product in ('Milk Bars','Eclairs') 
and s.SaleDate between '2022-02-01' and '2022-02-07'
group by pr.Product;


/*5. Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?*/

select * 
from sales
where Customers < 100 and boxes < 100;

select *,
case  when weekday(SaleDate)=2 then "wednesday"
else ""
end as w
from sales
where Customers < 100 and boxes < 100;

/*6. What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?*/

select * from people;
select * from sales;

select distinct p.SPID,p.Salesperson,s.SaleDate
from people as p
join sales as s on p.SPID = s.SPID
where s.SaleDate between '2022-01-01' and '2022-01-07';

/*7.Which salespersons did not make any shipments in the first 7 days of January 2022?*/

select p.SPID,p.Salesperson
from people as p 
where p.SPID not in(select distinct s.spid from sales as s where s.SaleDate between '2022-01-01' and '2022-01-07');
