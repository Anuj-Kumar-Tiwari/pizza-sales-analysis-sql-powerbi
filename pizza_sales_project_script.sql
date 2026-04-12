-- Orders Detail Table

Drop Table If Exists order_detail;
	
	Create Table order_detail(
		order_details_id	Bigint,
    	order_id	Bigint,
    	pizza_id	Varchar(100),
    	quantity	Int
    
		);

		Copy order_detail(order_details_id,order_id,pizza_id,quantity)
		From 'C:\Data Analyst Practice\Port Folio Project\PIZZA SALES ANALYSIS\Data\order_details.csv'
		CSV Header;

	Select * From order_detail;

-- Orders Table

Drop Table If Exists orders;

	Create Table orders(
		order_id	Bigint,
		date	Date,
		time	Time
	);
	
		Copy orders(order_id,date,time)
		From 'C:\Data Analyst Practice\Port Folio Project\PIZZA SALES ANALYSIS\Data\orders.csv'
		CSV Header;

		Select * From orders;

-- Pizza Type Table

Drop Table If Exists pizza_types;

	Create Table pizza_types(
		pizza_type_id	Varchar(100),
		name	Varchar(100),
		category	Varchar(100),
		ingredients	Varchar(200)

	);

		Copy pizza_types (pizza_type_id,name,category,ingredients)
		From 'C:\Data Analyst Practice\Port Folio Project\PIZZA SALES ANALYSIS\Data\pizza_types.csv'
		With (Format csv, Header, Encoding 'WIN1252')
	

	Select * From pizza_types;

-- Pizza Table

Drop Table If Exists pizza;

Create Table pizza(
	pizza_id	Varchar(100),
	pizza_type_id	Varchar(100),
	size	Varchar(100),
	price	Numeric(10,2)

);

		Copy pizza (pizza_id,pizza_type_id,size,price)
		From 'C:\Data Analyst Practice\Port Folio Project\PIZZA SALES ANALYSIS\Data\pizzas.csv'
		CSV Header;
	

	Select * From pizza;

										-- QUERIES --
	
-- 1. Total Revenue

	Select
	Sum(od.quantity*p.price) As Total_Revenue
	From order_detail od
	Join pizza p ON od.pizza_id = p.pizza_id;

-- 2. Total Order
	
	Select
	Count(DISTINCT order_id) 
	As Total_order
	From orders;
	
-- 3. Total Pizza Sold

	Select
	Sum(quantity) As Total_pizza_sold
	From order_detail;
	
-- 4. Average Order Value

	Select
	Round(Sum(od.quantity*p.price)/Count(DISTINCT od.order_id),2)
	As  Average_Order_Value 
	From order_detail od
	Join pizza p ON od.pizza_id = p.pizza_id;

-- 5. Total Orders Per Day

	Select
	Count(DISTINCT order_id)From orders ;
	
-- 6. Top 5 Best-Selling Pizzas

	Select
	pt.name, Sum(od.quantity) As Top_5_Best_Selling_Pizzas
	From order_detail od
	Join pizza p On od.pizza_id = p.pizza_id
	Join pizza_types pt On pt.pizza_type_id = p.pizza_type_id
	Group By pt.name Order By Top_5_Best_Selling_Pizzas Desc
	Limit 5;
	
-- 7. Peak Hours

	Select
	Extract(Hour From o.time :: Time) As Order_Hour,
	Count(DISTINCT o.order_id) As Total_order
	From orders o
	Join order_detail od On o.order_id = od.order_id
	Group By Order_Hour 
	Order By Total_order DESC;
	

-- 8. Revenue by Category (Classic/Veggie/Supreme/Chicken)

	Select
	pt.category, Sum(od.quantity * p.price) 
	As  Revenue_by_Category
	From order_detail od
	Join pizza p On od.pizza_id = p.pizza_id
	Join pizza_types pt On pt.pizza_type_id = p.pizza_type_id
	Group By pt.category Order By Revenue_by_Category;
	
-- 9. Revenue by Size (S/M/L/XL)

	Select
	p.size, Sum(od.quantity * p.price) 
	As  Revenue_by_Size
	From order_detail od
	Join pizza p On od.pizza_id = p.pizza_id
	Join pizza_types pt On pt.pizza_type_id = p.pizza_type_id
	Group By p.size Order By Revenue_by_Size;
	
-- 10. Monthly Revenue Trend

	Select
	Extract(Month From o.date :: Date) As Month
	, Sum(od.quantity * p.price) As Monthly_Revenue
	From orders o 
	Join order_detail od On o.order_id = od.order_id
	Join pizza p On p.pizza_id = od.pizza_id
	Group By Month
	Order By Month Asc;
	 
-- 11. Bottom 5 Pizzas

	Select
	pt.name, Sum(od.quantity) As Top_5_Bottom_Selling_Pizzas
	From order_detail od
	Join pizza p On od.pizza_id = p.pizza_id
	Join pizza_types pt On pt.pizza_type_id = p.pizza_type_id
	Group By pt.name Order By Top_5_Bottom_Selling_Pizzas ASC
	Limit 5;

--12. Daily Revenue Trends

	Select
	o.date, Sum(od.quantity * p.price) As Daily_Revenue
	From orders o 
	Join order_detail od On o.order_id = od.order_id
	Join pizza p On p.pizza_id = od.pizza_id
	Group By o.date
	Order By o.date ASC;

-- 13. Busiest Days of the Week

	Select
	To_CHAR(date::Date, 'Day') As Day_Name,
	Count(DISTINCT order_id) As Total_Orders
	From orders 
	Group By Day_Name 
	Order By Total_Orders Desc;

-- 14. Average Order Per Day
	
	Select
	Count(DISTINCT order_id::Numeric)/
	Count(DISTINCT date) As Average_Order_Per_Day
	From orders;

-- 15. Full Detail View(All 4 Tables Joined)

	Select
	o.order_id,
	o.date,
	o.time,
	pt.name As pizza_name,
	pt.category,
	p.size,
	od.quantity,
	p.price,
	Round((od.quantity*p.price)::Numeric,2) As Line_Total
	From orders o
	Join order_detail od On o.order_id = od.order_id
	Join pizza p On od.pizza_id = p.pizza_id
	Join pizza_types pt On p.pizza_type_id = pt.pizza_type_id
	Order By o.date, o.order_id;
	