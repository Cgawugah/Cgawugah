select*
from dbo.pizza_sales

--TOTAL REVENUE OF ALL THE PIZZA ORDERS
select 
sum(total_price) AS total_revenue
from pizza_sales

--AVERAGE ORDER VALUE
select
sum(total_price)/Count(Distinct order_id) AS Avg_Order_Value
from pizza_sales

--TOTAL PIZZA SOLD
SELECT
sum(quantity) AS Total_Pizza_Sold
from pizza_sales

--TOTAL ORDERS PLACED
select
count(distinct order_id) AS Total_Orders
from pizza_sales

--AVERAGE PIZZA'S PER ORDER
Select
cast(cast(sum(quantity) AS Decimal(10,2)) /
cast(count(Distinct order_id)AS Decimal(10,2))AS Decimal(10,2)) AS Avg_Pizza_per_Order
from pizza_sales

--DAILY TREND FOR TOTAL ORDERS
select
Datename(DW, order_date) AS Order_Day, count(distinct order_id) AS Total_Orders
from pizza_sales 
Group by Datename(DW, order_date)

--MONTHLY TREND FOR TOTAL ORDERS
select
Datename(MONTH, order_date) AS Month_Name, count(distinct order_id) AS Total_Orders
from pizza_sales 
Group by Datename(MONTH, order_date)
order by Total_Orders desc

select*
from pizza_sales

--PERCENTAGE OF SALES BY PIZZA CATEGORY
Select pizza_category, sum(total_price) AS Total_Sales, sum(total_price) * 100 / (select sum(total_price)
from pizza_sales
where MONTH(order_date) = 1) AS PCT
from pizza_sales
Where MONTH(order_date) = 1 
Group by pizza_category

--PERCENTAGE OF SALES BY PIZZA SIZE
Select pizza_size, sum(total_price) AS Total_Sales, sum(total_price) * 100 / (select sum(total_price)
from pizza_sales
where DatePart(quarter, order_date) = 1) AS PCT
from pizza_sales
Where DatePart(quarter,order_date) = 1 
Group by pizza_size
Order by PCT DESC

--TOP 5 BEST SELLERS BY REVENUE, TOTAL QUANTITIES AND TOTAL ORDERS
Select top 5
pizza_name, sum(total_price) AS Total_Revenue
from pizza_sales
Group by pizza_name
Order by Total_Revenue Asc

--TOTAL QUANTITY
Select top 5
pizza_name, sum(quantity) AS Total_Quantity
from pizza_sales
Group by pizza_name
Order by Total_Quantity Desc

--TOTAL ORDERS
Select top 5
pizza_name, count(distinct order_id) AS Total_Orders
from pizza_sales
Group by pizza_name
Order by Total_Orders DESC















