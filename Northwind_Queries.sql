#Which companies should work within certain areas( judging them on the basis of order number )  last 3 month

select s.CompanyName,s.City,count(distinct o.orderid) as No_Of_Orders from orders o 
join `order details` od on o.orderid=od.OrderID
join products p on od.productid=p.ProductID
join suppliers s on p.SupplierID=s.SupplierID
group by s.City
order by No_Of_Orders desc
limit 5;



#.Identifying areas with fewer orders.

select o.Shipcountry,count(distinct o.orderid) as Least_No_Of_Orders #dense rank
from orders o join `order details` od on o.orderid=od.OrderID 
group by o.shipcountry
order by Least_No_Of_Orders  asc
limit 10;


#.Which products and categories are sold within certain areas?(On the basis of revenue) #categoryname in grp by

select * from
(select *,rank() over ( partition by categoryname order by total_revenue desc)as product_ranking
from (select CategoryName,productname,sum(od.UnitPrice*od.Quantity)as total_revenue from categories cg join products p on cg.categoryid=p.CategoryID
join `order details` od on p.productid=od.ProductID 
group by productname order by CategoryName,total_revenue desc)all_products)as product_rankings 
where product_ranking<=5;



#.Which employees are handling more orders, showing higher productivity and increasing customer loyalty(  last 3month)
select e.EmployeeID,concat(e.firstname,"   ",e.lastname) as Employee_Name, count(distinct o.orderid) as No_Of_Orders 
from orders o 
join employees e 
    on o.EmployeeID=e.EmployeeID
join `order details` od 
    on o.orderid=od.orderid
group by e.EmployeeID
order by No_Of_Orders desc
limit 5;



#top 7 products in beverager category
select c.categoryname,p.productname,count(distinct o.OrderID) as No_of_Orders from products p
join categories c 
    on p.categoryid=c.categoryid
join `order details` od 
	on p.productid=od.productid
join orders o 
    on od.orderid=o.OrderID
where c.categoryname="Beverages"
group by p.ProductName 
order by No_of_Orders desc 
limit 7;



#top 7products in seafood category
select c.categoryname,p.productname,count(distinct o.OrderID) as No_of_Orders from products p
join categories c 
    on p.categoryid=c.categoryid
join `order details` od 
    on p.productid=od.productid
join orders o 
    on od.orderid=o.OrderID
where c.categoryname="seafood"
group by p.ProductName 
order by No_of_Orders desc 
limit 7;



#top 7 products in confctions category
select c.categoryname,p.productname,count(distinct o.OrderID) as No_of_Orders from products p
join categories c 
     on p.categoryid=c.categoryid
join `order details` od 
     on p.productid=od.productid
join orders o 
     on od.orderid=o.OrderID
where c.categoryname="confections"
group by p.ProductName 
order by No_of_Orders desc 
limit 7;



#top 7 products in dairy category
select c.categoryname,p.productname,count(distinct o.OrderID) as No_of_Orders from products p
join categories c 
    on p.categoryid=c.categoryid
join `order details` od 
    on p.productid=od.productid
join orders o 
	on od.orderid=o.OrderID
where c.categoryname="dairy products"
group by p.ProductName 
order by No_of_Orders desc 
limit 7;