-- Database Sales Retail p1
Create DATABASE sales_retail_p1;
USE sales_retail_p1;
-- create table

CREATE TABLE Sales
				(
                transactions_id	int primary key,
                sale_date	DATE,
                sale_time	TIME,
                customer_id INT,	
                gender	Varchar(10),
                age INT,	
                category varchar(15),	
                quantiy	int,
                price_per_unit	Float,
                cogs	Float,
                total_sale Float

                );


-- Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05:
Select * from Sales 
Where sale_date = '2022-04-13';

-- Q2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022:
Select * from sales 
Where 
category = "Clothing"
  AND
quantiy > 2
  AND
 Date_format(sale_date, '%Y-%m') = '2022-11';
 
 -- Q3 Write a SQL query to calculate the total sales (total_sale) for each category.
 Select category, sum(total_sale) as net_sale, 
 COUNT(*) as total_orders
 From sales
 Group by category;
 
 -- Q4  Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
 
 Select Round(avg(age),2) as avg_age
 from sales
 where category = "Beauty";


-- Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
Select * from sales
where total_sale >1000;

-- Q6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

Select category, Gender , count(*) as Total_transactions
from sales
group by 
category , Gender
Order by category;

-- Q7 Write a SQL query to find the top 5 customers based on the highest total sales 

Select customer_id , sum(total_sale) as total_sale
from sales
Group by customer_id 
Order BY total_sale DESC
Limit 5;

-- Q8 Write a SQL query to find the number of unique customers who purchased items from each category.
select category , sum(DISTINCT customer_id)
from sales 
group by category;

-- Q9 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
select * from (
Select 
	Year(sale_date) as year,
	MONTH(sale_date) as month,
	avg(total_sale) as avg_sale,
	RANK() OVER (partition by Year(sale_date) ORDER BY avg(total_sale) DESC )  as R
	from sales
	group by 1,2
) as out1
where R = 1; 

-- Q10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
With Hourly_time as
(
SELECT * ,
	CASE
		WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 and 17 THEN 'Afternoon'
        ELSE 'Evening'
        END AS shift
        From sales
	)
    
    Select 
    shift, 
    Count(*) as total_orders
    From Hourly_time
    GROUP BY shift
    Order by 1;