CREATE DATABASE WalmartSales;

USE WalmartSales;

CREATE TABLE Sales (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(10) NOT NULL,
    city VARCHAR(20) NOT NULL,
    customer_type VARCHAR(20) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10 , 2 ) NOT NULL,
    quantity INT NOT NULL,
    vat FLOAT(6 , 4 ) NOT NULL,
    total DECIMAL(12 , 4 ) NOT NULL,
    Date DATE NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10 , 2 ) NOT NULL,
    gross_margin_pct FLOAT(11 , 9 ) NOT NULL,
    gross_income DECIMAL(12 , 4 ) NOT NULL,
    rating FLOAT(2 , 1 ) NOT NULL
);

*****************************FEATURE ENGINEERING********************************
1. Adding new column time_of_day
SELECT 
    time,
    (CASE
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END) AS time_of_day
FROM
    sales;

alter table sales add column time_of_day varchar(20);
UPDATE sales 
SET 
    time_of_day = (CASE
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END);

2.Extracting Dayname from date
  
SELECT 
    date, DAYNAME(date) AS day_name
FROM
    sales;

alter table sales add column day_name varchar(20);
UPDATE sales 
SET 
    day_name = DAYNAME(date);

3.Extracting month from date
  
SELECT 
    date, MONTHNAME(date) AS month_name
FROM
    sales;
alter table sales add column month_name varchar(20);
UPDATE sales 
SET 
    month_name = MONTHNAME(date);

**********************************Exploratory Data Analysis***************************************
GENERIC QUESTIONS
-- 1.How many distinct cities are present in the dataset?
SELECT DISTINCT
    city
FROM
    sales;
    
-- 2.In which city is each branch situated?
select distinct city,branch from sales;

PRODUCT ANALYSIS
-- 1.How many distinct product lines are there in the dataset?
SELECT 
    COUNT(DISTINCT product_line)
FROM
    sales;
    
-- 2.What is the most common payment method?
SELECT 
    payment, COUNT(payment)
FROM
    sales
GROUP BY payment
ORDER BY COUNT(payment) DESC;

-- 3.What is the most selling product line?
SELECT 
    product_line, COUNT(product_line)
FROM
    sales
GROUP BY product_line
ORDER BY COUNT(product_line) DESC;

-- 4.What is the total revenue by month?
SELECT 
    SUM(total) AS total_revenue, month_name
FROM
    sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- 5.Which month recorded the highest Cost of Goods Sold (COGS)?
SELECT 
    month_name, SUM(cogs) AS total_cogs
FROM
    sales
GROUP BY month_name
ORDER BY total_cogs DESC
LIMIT 1;

-- 6.Which product line generated the highest revenue?
SELECT 
    product_line, SUM(total) AS total_revenue
FROM
    sales
GROUP BY product_line
ORDER BY total_revenue DESC
LIMIT 1;

-- 7.Which city has the highest revenue?
SELECT 
    city, SUM(total) AS total_revenue
FROM
    sales
GROUP BY city
ORDER BY total_revenue DESC
LIMIT 1; 

-- 8.Which product line incurred the highest VAT?
SELECT 
    product_line, SUM(vat) AS VAT
FROM
    sales
GROUP BY product_line
ORDER BY VAT DESC
LIMIT 1; 

-- 9.Retrieve each product line and add a column product_category, indicating 'Good' or 'Bad,'based on whether its sales are above the average
alter table sales add column product_category varchar(20);
use walmartsales;
UPDATE sales s
JOIN (
    SELECT AVG(total) AS avg_total
    FROM sales
) avg_sales
SET s.product_category = 
    CASE 
        WHEN s.total >= avg_sales.avg_total THEN 'Good'
        ELSE 'Bad'
    END;

-- 10.Which branch sold more products than average product sold?
SELECT 
    branch, SUM(quantity) AS quantity
FROM
    sales
GROUP BY branch
HAVING SUM(quantity) > AVG(quantity)
ORDER BY quantity DESC
LIMIT 1;

-- 11.What is the most common product line by gender?
SELECT 
    gender, product_line, COUNT(gender) total_count
FROM
    sales
GROUP BY gender , product_line
ORDER BY total_count DESC;

-- 12.What is the average rating of each product line?
SELECT 
    product_line, ROUND(AVG(rating), 2) average_rating
FROM
    sales
GROUP BY product_line
ORDER BY average_rating DESC;

SALES ANALYSIS
-- 1.Number of sales made in each time of the day per weekday
SELECT 
    time_of_day, day_name, COUNT(invoice_id) as total_Sales
FROM
    sales
GROUP BY time_of_day , day_name
HAVING day_name NOT IN ('Saturday' , 'Sunday');

-- 2.Identify the customer type that generates the highest revenue.
SELECT 
    customer_type, SUM(total) AS total_revenue
FROM
    sales
GROUP BY customer_type
ORDER BY total_revenue DESC limit 1;

-- 3.Which city has the largest tax percent/ VAT (Value Added Tax)?
SELECT 
    SUM(vat) AS total_vat, city
FROM
    sales
GROUP BY city
ORDER BY total_vat DESC
LIMIT 1;

-- 4.Which customer type pays the most in VAT?
SELECT 
    SUM(vat) AS total_vat, customer_type
FROM
    sales
GROUP BY customer_type
ORDER BY total_vat DESC
LIMIT 1;

 CUSTOMER ANALYSIS
-- 1.How many unique customer types does the data have?
select count(distinct(customer_type)) as customer_type_count from sales;

-- 2.How many unique payment methods does the data have?
select count(distinct(payment)) as payment_method_count from sales;

-- 3.Which is the most common customer type?
SELECT 
    customer_type, COUNT(customer_type) AS customer_type_count
FROM
    sales
GROUP BY customer_type
ORDER BY customer_type_count DESC limit 1;

-- 4.Which customer type buys the most?
SELECT 
    customer_type, SUM(total) AS most_buyer
FROM
    sales
GROUP BY customer_type
ORDER BY most_buyer DESC
LIMIT 1;

-- 5.What is the gender of most of the customers?
SELECT 
    COUNT(gender), gender
FROM
    sales
GROUP BY gender
ORDER BY COUNT(gender) DESC
LIMIT 1;

-- 6.What is the gender distribution per branch?
SELECT 
    branch, COUNT(gender), gender
FROM
    sales
GROUP BY branch , gender
ORDER BY branch;

-- 7.Which time of the day do customers give most ratings?
SELECT 
    time_of_day, AVG(rating)
FROM
    sales
GROUP BY time_of_day
ORDER BY AVG(rating) DESC
LIMIT 1;

-- 8.Which time of the day do customers give most ratings per branch?
SELECT 
    time_of_day, AVG(rating),branch
FROM
    sales
GROUP BY time_of_day,branch
ORDER BY AVG(rating) DESC limit 1;

-- 9.Which day of the week has the best avg ratings?
SELECT 
    day_name, AVG(rating)
FROM
    sales
GROUP BY day_name
ORDER BY AVG(rating) DESC limit 1;

-- 10.Which day of the week has the best average ratings per branch?
SELECT 
    day_name, AVG(rating),branch
FROM
    sales
GROUP BY day_name,branch
ORDER BY AVG(rating) DESC limit 1;





