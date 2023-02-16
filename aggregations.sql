--Find the total amount of poster_qty paper ordered in the orders table.

--Find the total amount of standard_qty paper ordered in the orders table.

--Find the total dollar amount of sales using the total_amt_usd in the orders table.

--Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table.

--Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator.


SELECT
SUM(poster_qty) as total_poster_qty,
SUM(standard_qty) as total_standard_qty,
SUM(total_amt_usd) as total_amt_usd
FROM orders;

SELECT id,
SUM(standard_amt_usd ) as total_standard_amt_usd,
SUM(gloss_amt_usd ) as total_standard_amt_usd
FROM orders
GROUP BY id
ORDER BY id;

SELECT standard_qty,
SUM(standard_amt_usd ) as total_standard_amt_usd
FROM orders
GROUP BY standard_qty
ORDER BY standard_qty;

SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;

ELECT MIN(occurred_at)
FROM orders;

SELECT MIN(occurred_at)
FROM web_events;

SELECT occurred_at
FROM orders 
ORDER BY occurred_at limit 1;

SELECT occurred_at
FROM web_events 
ORDER BY occurred_at limit 1;

SELECT AVG(standard_qty) mean_standard, AVG(gloss_qty) mean_gloss, 
           AVG(poster_qty) mean_poster, AVG(standard_amt_usd) mean_standard_usd, 
           AVG(gloss_amt_usd) mean_gloss_usd, AVG(poster_amt_usd) mean_poster_usd
FROM orders;

SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;


SELECT acc.name,ord.occurred_at
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
ORDER BY ord.occurred_at;

SELECT acc.name,SUM(total_amt_usd) as SUM
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY acc.name
ORDER BY SUM DESC;

SELECT acc.name,web.channel,web.occurred_at as recent_order_date
FROM web_events web
JOIN accounts acc
ON web.account_id = acc.id
ORDER BY recent_order_date DESC
;

SELECT web.channel,count(*)
FROM web_events web
GROUP BY web.channel 
;

SELECT acc.name,min(ord.total_amt_usd)
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY acc.name 
;

SELECT reg.name,count(sp.name) as CNT
FROM sales_reps sp
JOIN region reg
ON sp.region_id = reg.id
GROUP BY reg.name 
ORDER BY CNT
;

SELECT accounts.name,
ROUND(AVG(standard_qty),2) AS std_avg, 
ROUND(AVG(gloss_qty),2) AS gloss_avg,
ROUND(AVG(poster_qty),2) AS pos_avg
FROM orders
JOIN accounts
ON accounts.id = orders.account_id
GROUP BY accounts.name;

SELECT accounts.name,
ROUND(AVG(standard_amt_usd),2) AS std_avg, 
ROUND(AVG(gloss_amt_usd),2) AS gloss_avg,
ROUND(AVG(poster_amt_usd),2) AS pos_avg
FROM orders
JOIN accounts
ON accounts.id = orders.account_id
GROUP BY accounts.name;
