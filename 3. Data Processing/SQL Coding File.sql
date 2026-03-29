Select * 
From `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1` limit 10;
------------------------------------------------------------------------------------------------
----Checking the transaction date
----They started transacting from the 1st of January 2023 to the 30th of June 2023, which is a 6 ----months transactions
-------------------------------------------------------------------------------------------------
Select MIN(transaction_date) AS Start_date,
       MAX(transaction_date) AS End_date
From `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;
-------------------------------------------------------------------------------------------------
---Finding the top 5 performing products
---5 Top selling products: Coffee, Tea, Bakery, Drinking Chocolate and Coffee beans
-------------------------------------------------------------------------------------------------
Select DISTINCT product_category, 
        SUM(transaction_qty*unit_price) AS Revenue
From `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
Group by product_category
Order by Revenue Desc
Limit 5; 
-----------------------------------------------------------------------------------------------
---Store performance from lowest to highest revenue
---Lower Manhattan, Astoria and Hell's Kitchen respectively
-----------------------------------------------------------------------------------------------
Select DISTINCT store_location, 
        SUM(transaction_qty*unit_price) AS Revenue
From `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
Group by store_location
Order by Revenue Asc;
----------------------------------------------------------------------------------------------
----Checking Average revenue per store
----------------------------------------------------------------------------------------------
Select DISTINCT store_location, 
        AVG(transaction_qty*unit_price) AS Average_Revenue
From `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
Group by store_location
Order by Average_Revenue Asc;
---------------------------------------------------------------------------------------------
----Checking Average revenue per product
---------------------------------------------------------------------------------------------
Select DISTINCT product_category, 
        AVG(transaction_qty*unit_price) AS Average_Revenue
From `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
Group by product_category;
 
-----------------------------------------------------------------------------------------------
----Checking number of sales by product and store
-----------------------------------------------------------------------------------------------
Select  store_location,
        product_category, 
        COUNT(transaction_id) AS Number_of_sales
From `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
Group by store_location,
          product_category;

----------------------------------------------------------------------------------------------------
----Checking the products sold in the coffee shop
----There are 9 products sold, Coffee, Tea, Drinking Chocolate, Bakery, Flavours, Loose Tea, Coffee ----beans, Packaged chocolate and Branded.
----------------------------------------------------------------------------------------------------

Select DISTINCT  product_category  
From `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

----------------------------------------------------------------------------------------------------
Select DISTINCT  product_detail  
From `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

----------------------------------------------------------------------------------------------------
Select DISTINCT  product_type 
From `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

--------------------------------------------------------------------------------------------
---Checking lowest and highest price
---The lowest item is sold 0.8 whereas the highest is 45.
--------------------------------------------------------------------------------------------

Select MIN(unit_price) AS Lowest_price,
       MAX(unit_price) AS Highest_price
From `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

-------------------------------------------------------------------------------------------
---Retrieving the day and month names
-------------------------------------------------------------------------------------------
Select 
        transaction_date,
        Dayname(transaction_date) AS Day_name,
        Monthname(transaction_date) AS Month_name
From `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

------------------------------------------------------------------------------------------
-----Revenue across all stores
------------------------------------------------------------------------------------------
Select unit_price,
       transaction_qty,
       transaction_qty*unit_price AS Revenue
From `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

-----------------------------------------------------------------------------------------
----Total revenue across all stores
----Revenue made for all stores is R698812.33
-----------------------------------------------------------------------------------------
Select SUM(transaction_qty*unit_price) AS Revenue
From `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

-----------------------------------------------------------------------------------------
---Retrieving all columns from the dataset
-----------------------------------------------------------------------------------------
Select *
From `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

-----------------------------------------------------------------------------------------
---New columns analysis
-----------------------------------------------------------------------------------------
Select   transaction_date,
         transaction_time, 
         transaction_id,
         transaction_qty,  
         store_id,
         store_location,
         product_id,
         unit_price,
         product_category,
         product_type,
         product_detail,

----------------------------------------------------------------------------------------------       
----Extracting day name, month name and date of month
----------------------------------------------------------------------------------------------
       Dayname(transaction_date) AS Day_name,
       Monthname(transaction_date) AS Month_name,
       Dayofmonth(transaction_date) AS Date_of_month,

----------------------------------------------------------------------------------------------
-----Extracting weekdays
----------------------------------------------------------------------------------------------
      Case
          WHEN Day_name IN ('Sat','Sun') THEN 'Weekend'
          ELSE 'Weekday'
          END AS Day_classification,

----------------------------------------------------------------------------------------------
----Checking the time of the day
----------------------------------------------------------------------------------------------
      Case
          WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '05:00:00' AND '09:59:59' THEN 'Morning'
          WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '11:59:59' AND '14:59:59' THEN 'Mid-day'
          WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '15:59:59' AND '18:59:59' THEN 'Afternoon'
          ELSE 'Night'
          END AS Time_classification,

------------------------------------------------------------------------------------------------
----Checking how customers spend
------------------------------------------------------------------------------------------------
          Case
             WHEN (transaction_qty*unit_price)<=50 THEN 'Low spend'
             WHEN (transaction_qty*unit_price) BETWEEN 51 AND 200 THEN 'Medium spend'
             WHEN (transaction_qty*unit_price) BETWEEN 201 AND 300 THEN 'High spend'
          ELSE 'Big spender'
          END AS Spend_buckets,

-----------------------------------------------------------------------------------------------
----Revenue 
-----------------------------------------------------------------------------------------------
         transaction_qty*unit_price AS Revenue,

-----------------------------------------------------------------------------------------------
----Retrieving number of products, sales and stores
-----------------------------------------------------------------------------------------------
         COUNT(DISTINCT transaction_id) AS Number_of_sales,
         COUNT(DISTINCT product_id) AS Number_of_products,
         COUNT(DISTINCT store_id) AS Number_of_stores

-----------------------------------------------------------------------------------------------
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
Group by   transaction_date,
           transaction_time, 
           transaction_id,
           transaction_qty,  
           store_id,
           store_location,
           product_id,
           unit_price,
           product_category,
           product_type,
           product_detail;

    
