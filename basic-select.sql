SELECT *
FROM orders;

SELECT occurred_at,account_id,channel
FROM web_events
LIMIT 15;

SELECT *
FROM orders;

--Write a query to return the 10 earliest orders in the orders table
SELECT id,occurred_at,total_amt_usd
FROM orders
ORDER BY occurred_at 
LIMIT 10;

--Write a query to return the top 5 orders in terms of largest total_amt_usd
SELECT id,account_id,total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC 
LIMIT 5;

--Write a query to return the lowest 20 orders in terms of smallest total_amt_usd
SELECT id,account_id,total_amt_usd
FROM orders
ORDER BY total_amt_usd  
LIMIT 20;
