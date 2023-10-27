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
