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
SELECT TOP 10 *
FROM shopping_trends;
```
![01](Shopping Trends Analysis/query_00.jpg)
