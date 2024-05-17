-- Inspect the dataset.
SELECT TOP 10 *
FROM shopping_trends

-- 1. What are the total sales (sum of purchase amounts) for each category of items?
SELECT category, SUM(purchase_amount) AS total_purchase_amount
FROM shopping_trends
GROUP BY category
ORDER BY total_purchase_amount DESC; 

-- 2. How many unique customers have made purchases in each location?
SELECT location, COUNT(customer) AS number_of_customers
FROM shopping_trends
GROUP BY location
ORDER BY number_of_customers DESC;

-- 3. What is the average purchase amount for each season?
SELECT season, ROUND(AVG(purchase_amount),2) AS avg_purchase_amount
FROM shopping_trends
GROUP BY season
ORDER BY avg_purchase_amount DESC;

-- 4. Which gender has made the highest number of purchases, and what is the total amount spent by each gender?
SELECT gender, COUNT(gender) AS number_of_purchases, SUM(purchase_amount) AS total_purchase_amount
FROM shopping_trends
GROUP BY gender
ORDER BY number_of_purchases DESC;

-- 5. What is the most common payment method used by customers, and how many times has each payment method been used?
SELECT payment_method, COUNT(*) AS number_of_usage
FROM shopping_trends
GROUP BY payment_method
ORDER BY number_of_usage DESC;

-- 6. What is the average frequency of purchases for customers who have made previous purchases more than 20 times?
WITH cte AS (
    SELECT *,
        CASE WHEN "frequency_of_purchases" = 'Every 3 Months' THEN 4
             WHEN "frequency_of_purchases" = 'Monthly' THEN 12
             WHEN "frequency_of_purchases" = 'Quarterly' THEN 4
			 WHEN "frequency_of_purchases" = 'Annually' THEN 1
			 WHEN "frequency_of_purchases" = 'Fortnightly' THEN 26
			 WHEN "frequency_of_purchases" = 'Bi-Weekly' THEN 26
			 WHEN "frequency_of_purchases" = 'Weekly' THEN 52
             ELSE 0
        END AS purchase_frequency_in_year
    FROM shopping_trends
)
SELECT AVG(purchase_frequency_in_year) AS  avg_purchase_frequency_in_year
FROM cte
WHERE previous_purchases > 20;

-- 7. Which location has the highest average purchase amount per transaction?
SELECT 
	location, 
	ROUND(AVG(purchase_amount),2) AS avg_purchase_amount
FROM shopping_trends
GROUP BY location
ORDER BY avg_purchase_amount DESC;

-- 8.Is there a correlation between the season and the type of items purchased? For example, do customers tend to buy more winter clothing during colder months?
SELECT 
	season, 
	category, 
	COUNT(*) AS total_items_purchased,
	ROUND(CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY Season) AS numeric), 2) AS percentage_of_total_items_purchased
FROM shopping_trends
GROUP BY season, category
ORDER BY season, total_items_purchased DESC;



