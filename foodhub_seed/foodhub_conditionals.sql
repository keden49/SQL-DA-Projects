USE foodhub;

--  query that returns C:



-- A column called 'Order Size' using IF() that returns 'Bulk Order' if quantity > 2, and 'Standard Order' otherwise.

SELECT order_id, item_name, quantity, price, 
IF(quantity > 2, 'Bulk order', 'Standard Order') AS order_size, IF (price > 20, 'High value','Regular') AS Value_tier
FROM orders;
 
 
 SELECT 
    order_id,
    item_name,
    quantity,
    price,
    -- Evaluates if quantity is greater than 2 for bulk orders
    IF(quantity > 2, 'Bulk Order', 'Standard Order') AS `Order Size`,
    
    -- Evaluates price to categorize into Premium (> 20), Mid-Range (10 to 20), or Budget (< 10)
    IF(price > 20.00, 'Premium', 
        IF(price >= 10.00, 'Mid-Range', 'Budget')
    ) AS `Value Tier`
FROM 
    foodhub.orders;
    
    
--  "The ops team is doing a review. I need every restaurant given a performance label based on their avg_rating: 4.5 and above is Excellent, 
-- 4.0 to 4.4 is Good, 3.5 to 3.9 is Acceptable, and anything below 3.5 is Needs Improvement. IF won't cut it here — too many conditions. Use CASE."


SELECT *, 
CASE 
WHEN avg_rating >= 4.5 THEN 'Excellent'
WHEN avg_rating >= 4.0 THEN 'Good'
WHEN avg_rating >= 3.5 THEN 'Acceptable'
ELSE 'Needs Improvement'
END AS Perfomance
FROM restaurants;



-- Uses a CASE statement to classify each order into a 'Price Tier': 'Premium' for price > 20, 'Mid-Range' for price between 10 and 20, and 'Budget' for price below 10.

-- Groups the results by Price Tier using GROUP BY.

-- Returns the Price Tier, the total number of orders in that tier aliased as 'Total Orders', and the total revenue per tier (quantity * price) aliased as 'Total Revenue'. Round Total Revenue to 2 decimal places.

-- Orders the results by Total Revenue descending.

SELECT 
CASE 
WHEN price > 20.00
THEN 'Premium'
WHEN price >= 10.00 THEN 'Mid-Range'
ELSE  'Budget'
END AS Tier,
COUNT(*) AS Total_orders,
SUM(quantity * price) AS Total_revenue
FROM orders
GROUP BY Tier
ORDER BY Total_revenue;

/*
BOARD REPORT SUMMARY:
The order value distribution reveals whether FoodHub relies on high-volume, lower-margin 
'Budget' orders or lower-volume, higher-margin 'Premium' sales to drive total revenue. 
By comparing total revenue against order count per tier, management can identify key revenue 
drivers and target marketing efforts toward boosting high-margin price segments.
*/

  
   







