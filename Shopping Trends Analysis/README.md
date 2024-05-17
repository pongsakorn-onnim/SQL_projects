# Overview
This is an analysis of a customer shopping trends dataset from Kaggle. The project focuses on uncovering consumer behavior, revenue, and product insight. Discovering these insights can help businesses make informed decisions, optimize product offerings, and enhance customer satisfaction. This dataset is a synthetic dataset created for learning purposes.

# Dataset Detail
The dataset consists of 19 columns and 3900 rows without missing values. It contains features about customer age, gender, purchase amount, location, etc. 

-	**Customer ID** - Unique identifier for each customer
-	**Age** - Age of the customer
-	**Gender** - Gender of the customer (Male/Female)
-	**Item Purchased** - The item purchased by the customer
-	**Category** - Category of the item purchased
-	**Purchase Amount (USD)** - The amount of the purchase in USD
-	**Location** - Location where the purchase was made
-	**Size** - Size of the purchased item
-	**Color** - The color of the purchased item
-	**Season** - Season during which the purchase was made
-	**Review Rating** - Rating given by the customer for the purchased item
-	**Subscription Status** - Indicates if the customer has a subscription (Yes/No)
-	**Shipping Type** - The type of shipping chosen by the customer
-	**Discount Applied** - Indicates if a discount was applied to the purchase (Yes/No)
-	**Promo Code Used** - Indicates if a promo code was used for the purchase (Yes/No)
-	**Previous Purchases** - The total count of transactions concluded by the customer at the store, excluding the ongoing transaction
-	**Payment Method** - Customer's most preferred payment method
-	**Frequency of Purchases** - Frequency at which the customer makes purchases (e.g., Weekly, Fortnightly, Monthly)

*To make it more convenient for querying, I have changed column names to lowercase and replaced spaces with underscores. For example, the column 'Customer ID' -> 'customer_id'.

# Querying to answer business questions

```sql
-- Inspect the dataset.
SELECT TOP 10 *
FROM shopping_trends;
```
![query_00](https://github.com/pongsakorn-onnim/SQL_projects/assets/87061596/f1facc32-6fef-477a-aa21-e941130df552)

```sql
-- 1. What are the total sales (sum of purchase amounts) for each category of items?
SELECT category, SUM(purchase_amount) AS total_purchase_amount
FROM shopping_trends
GROUP BY category
ORDER BY total_purchase_amount DESC;
```
![query_01](https://github.com/pongsakorn-onnim/SQL_projects/assets/87061596/12fd9b13-a31b-49b4-a062-1539dcec42b3)


```sql
-- 2. How many unique customers have made purchases in each location?
SELECT location, COUNT(customer) AS number_of_customers
FROM shopping_trends
GROUP BY location
ORDER BY number_of_customers DESC;
```
![query_02](https://github.com/pongsakorn-onnim/SQL_projects/assets/87061596/c2114dee-e8b9-4d84-8ec9-074a270c45d6)

```sql
-- 3. What is the average purchase amount for each season?
SELECT season, ROUND(AVG(purchase_amount),2) AS avg_purchase_amount
FROM shopping_trends
GROUP BY season
ORDER BY avg_purchase_amount DESC;
```
![query_03](https://github.com/pongsakorn-onnim/SQL_projects/assets/87061596/f0dffb7b-2ac0-4a08-993e-a3d1e919a316)

```sql
-- 4. Which gender has made the highest number of purchases, and what is the total amount spent by each gender?
SELECT gender, COUNT(gender) AS number_of_purchases, SUM(purchase_amount) AS total_purchase_amount
FROM shopping_trends
GROUP BY gender
ORDER BY number_of_purchases DESC;
```
![query_04](https://github.com/pongsakorn-onnim/SQL_projects/assets/87061596/8c03817c-33d5-4f9c-a1ef-77cf9bdc03e2)

```sql
-- 5. What is the most common payment method used by customers, and how many times has each payment method been used?
SELECT payment_method, COUNT(*) AS number_of_usage
FROM shopping_trends
GROUP BY payment_method
ORDER BY number_of_usage DESC;
```
![query_05](https://github.com/pongsakorn-onnim/SQL_projects/assets/87061596/e25bf134-af04-4e37-b404-6f994843fcb8)

```sql
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
```
![query_06](https://github.com/pongsakorn-onnim/SQL_projects/assets/87061596/9cef6b4b-1bd1-489e-9290-6ded645b29d4)

```sql
-- 7. Which location has the highest average purchase amount per transaction?
SELECT 
	location, 
	ROUND(AVG(purchase_amount),2) AS avg_purchase_amount
FROM shopping_trends
GROUP BY location
ORDER BY avg_purchase_amount DESC;
```
![query_07](https://github.com/pongsakorn-onnim/SQL_projects/assets/87061596/90c1d3de-8ca0-4ee3-b2df-af805366d3ba)

```sql
-- 8. Is there a correlation between the season and the type of items purchased? For example, do customers tend to buy more winter clothing during colder months?
SELECT 
	season, 
	category, 
	COUNT(*) AS total_items_purchased,
	ROUND(CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY Season) AS numeric), 2) AS percentage_of_total_items_purchased
FROM shopping_trends
GROUP BY season, category
ORDER BY season, total_items_purchased DESC;

SELECT COUNT(*)
FROM shopping_trends
```
![query_08](https://github.com/pongsakorn-onnim/SQL_projects/assets/87061596/b2d2ddb0-0eea-4d83-843e-70e61e349bd5)

# Insights
- **Top Category**: Clothing has the highest total purchase amount at $104,264.
- **Top Locations by Customers**: Montana, California, Idaho, Illinois, and Alabama.
- **Seasonal Sales**: Fall has the highest average sales, but sales are similar across all seasons.
- **Gender Comparison**: Male customers' purchase amounts are nearly twice that of female customers.
- **Popular Payment Methods**: PayPal, Credit Card, and Cash.
- **Purchase Frequency Decline**: Customers who made more than 20 purchases last year averaged 17 this year.
- **Top Locations by Purchase Amount**: Alaska, Pennsylvania, Arizona, West Virginia, and Nevada.
- **Seasonal Purchase Distribution**: The percentage of total items purchased is similar across all seasons, ranking from clothing, accessories, footwear, to outerwear.
