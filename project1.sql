create schema sql_project;
USE SQL_PROJECT;
create table RETAIL_SALES(
						transactions_id	int PRIMARY KEY ,
						sale_date DATE ,
						sale_time time,
						customer_id INT,
						gender varchar(25),
						age	INT,
                        category varchar(25),
						quantiy INT,
						price_per_unit FLOAT,
						cogs FLOAT,
						total_sale FLOAT
									);



select * from RETAIL_SALES
WHERE TRANSACTIONS_ID IS NULL 
OR
SALE_DATE IS NULL
OR 
SALE_TIME IS NULL
OR 
customer_id IS NULL
OR 
GENDER IS NULL
OR 
AGE IS NULL 
OR 
CATEGORY IS NULL 
OR 
QUANTIY IS NULL 
OR 
PRICE_PER_UNIT IS NULL
OR 
COGS IS NULL 
or
TOTAL_SALE IS NULL;

#DATA CLEANING

DELETE FROM RETAIL_SALES 
WHERE TRANSACTIONS_ID IS NULL 
OR
SALE_DATE IS NULL
OR 
SALE_TIME IS NULL
OR 
customer_id IS NULL
OR 
GENDER IS NULL
OR 
AGE IS NULL 
OR 
CATEGORY IS NULL 
OR 
QUANTIY IS NULL 
OR 
PRICE_PER_UNIT IS NULL
OR 
COGS IS NULL 
or
TOTAL_SALE IS NULL;

SELECT COUNT(*) FROM RETAIL_SALES;

# HOW MANY SALES WE HAVE ?
SELECT count(*) FROM RETAIL_SALES AS TOTAL_SALES;

# HOW MANY CUSTOMER WE HAVE ?
SELECT count(DISTINCT CUSTOMER_ID)FROM RETAIL_SALES;

-- HOW MANY CATEGORY WE HAVE ?
SELECT count(DISTINCT CATEGORY)FROM RETAIL_SALES;  

-- Q1  Write a sql query to retrieve all columnsw for sales made on '2022-11-05'.

select * from retail_sales
where sale_date ="05-11-2022";

-- Q2 Write a sql query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of nov-2022.

select  * from retail_sales 
where category="clothing" and date_format(sale_date,'%Y-%m')='2022-11'
and quantiy >=3;
-- Q3 write a sql query to caluculate the total sales(total_sale)for each category.

select category,sum(total_sale) ,count(*) as total_count from retail_sales
group by category ;
-- Q4 write a sql query to write the average age of customers who purchased items from the 'beauty 'category.
select category, avg(age) from retail_sales 
where category="beauty";
-- Q5 write a sql  query to find all transactions where the total_sale is greater than 1000.

select transactions_id,total_sale from retail_sales 
where total_sale > 1000;
-- Q6 write a sql query to find the total number of transactions (transaction_id)made by each gender in each category.
select category,gender,count(*) as tr_id
from retail_sales
 group by 1,2 order by 1;
-- Q7 write a sql query to calculate the average sale for each month. find out best selling month in each year. 
select * from(
select avg(total_sale),
extract(year from  sale_date) as year ,
extract(month from sale_date)  as month ,
rank () over(partition by extract(year from  sale_date) order by  avg(total_sale) desc  )as r_ank
from retail_sales 
group by 2,3

) as t1
where r_ank=1;

-- Q8 write a sql query to find the top 5 customers based on the highest total_sales. 
select customer_id,sum(total_sale)
from retail_sales group by customer_id 
order by sum(total_sale) desc
limit 5;

-- Q9 write a sql query to find the number of unique customers who purchased items for each category. 
select category,count(distinct customer_id) 
 from  retail_sales 
 group by category;

-- Q10 write a aql query to create each shift and number of orders (example morning <=12,afternoon between 12& 17,evening >17).

	with hourly_sale 
	as (
	select *,
	case 
	when extract(hour from sale_time) <12 then "Morning"
	when extract(hour from sale_time) between 12 and 17 then "Aftrnoon"
	else "Evening"
	end as shift
	from retail_sales
	) 
	select shift ,count(*) as total_order
	from hourly_sale 
	group by shift ;

 -- End of project 
 

