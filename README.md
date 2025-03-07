## Walmart Sales Data Analysis using SQL

## ABOUT:
This project focuses on analyzing Walmart's sales data to pinpoint top-performing branches and products, examine the sales trends of different items and understanding customer behavior. The main aim is to refine and optimize sales strategies. The dataset used in this analysis is from the Kaggle.

## PURPOSE:
The main aim of this project is to analyze Walmart's sales data, investigating the different factors that affect sales performance at various branches. The goal is to uncover insights that can help improve sales strategies across the company.

## DATA DESCRIPTION:

invoice_id : Invoice of the sales made	VARCHAR(30)

branch : Branch at which sales were made	VARCHAR(10)

city : The location of the branch	VARCHAR(20)

customer_type : 	The type of the customer	VARCHAR(20)

gender : Gender of the customer making purchase	VARCHAR(10)

product_line :	Product line of the product sold	VARCHAR(100)

unit_price : The price of each product	DECIMAL(10, 2)

quantity : The amount of the product sold	INT

VAT	: The amount of tax on the purchase	FLOAT(6, 4)

total	: The total cost of the purchase	DECIMAL(12, 4)

date	: The date on which the purchase was made	DATETIME

time	: The time at which the purchase was made	TIME

payment	: The total amount paid	VARCHAR(15)

cogs	: Cost Of Goods sold	DECIMAL(10, 2)

gross_margin_pct	: Gross margin percentage	FLOAT(11, 9)

gross_income	: Gross Income	DECIMAL(12, 4)

rating	: Rating	FLOAT(2, 1)

## APPROACH USED:

1.Data Wrangling

In this stage, the dataset is carefully reviewed to identify any missing or NULL values. 

Database Creation: A database is created to store the dataset.

Table Creation and Data Insertion: A table is created, and the data is inserted, with the NOT NULL constraint applied to ensure no missing values in the table.

Checking for NULL Values: A check is conducted to confirm that no NULL values exist in the data, as the NOT NULL constraints were applied during the table creation process to prevent them.

2.Feature Engineering

In this phase, new features (columns) are created from existing data to provide more meaningful insights.

Time of Day: A new column, time_of_day, is added to categorize the sales into Morning, Afternoon, and Evening. This helps identify which time of day generates the most sales.

Day of the Week: A column named day_name is created, extracting the day of the week (e.g., Mon, Tue, Wed) for each transaction. This allows us to understand which days of the week see the highest sales activity for each branch.

Month of the Year: A new column, month_name, is introduced, which extracts the month from the transaction date (e.g., Jan, Feb, Mar). This helps to identify trends in sales and profits throughout different months of the year.

3.Exploratory Data Analysis (EDA)

Conducting exploratory data analysis is essential to address the project's listed questions and objectives.

## Business Questions to Answer:

## Generic Questions

1.How many distinct cities are present in the dataset?

2.In which city is each branch situated?

## Product Analysis

1.How many distinct product lines are there in the dataset?

2.What is the most common payment method?

3.What is the most selling product line?

4.What is the total revenue by month?

5.Which month recorded the highest Cost of Goods Sold (COGS)?

6.Which product line generated the highest revenue?

7.Which city has the highest revenue?

8.Which product line incurred the highest VAT?

9.Retrieve each product line and add a column product_category, indicating 'Good' or 'Bad,' based on whether its sales are above the average.

10.Which branch sold more products than average product sold?

11.What is the most common product line by gender?

12.What is the average rating of each product line?

## Sales Analysis

1.Number of sales made in each time of the day per weekday

2.Identify the customer type that generates the highest revenue.

3.Which city has the largest tax percent/ VAT (Value Added Tax)?

4.Which customer type pays the most VAT?

## Customer Analysis

1.How many unique customer types does the data have?

2.How many unique payment methods does the data have?

3.Which is the most common customer type?

4.Which customer type buys the most?

5.What is the gender of most of the customers?

6.What is the gender distribution per branch?

7.Which time of the day do customers give most ratings?

8.Which time of the day do customers give most ratings per branch?

9.Which day of the week has the best avg ratings?

10.Which day of the week has the best average ratings per branch?







