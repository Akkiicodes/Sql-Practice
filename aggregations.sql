--Find the total amount of poster_qty paper ordered in the orders table.

--Find the total amount of standard_qty paper ordered in the orders table.

--Find the total dollar amount of sales using the total_amt_usd in the orders table.

SELECT
SUM(poster_qty) as total_poster_qty,
SUM(standard_qty) as total_standard_qty,
SUM(total_amt_usd) as total_amt_usd
FROM orders;

--Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table.

SELECT id,
SUM(standard_amt_usd ) as total_standard_amt_usd,
SUM(gloss_amt_usd ) as total_standard_amt_usd
FROM orders
GROUP BY id
ORDER BY id;

--Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator.

SELECT standard_qty,
SUM(standard_amt_usd ) as total_standard_amt_usd
FROM orders
GROUP BY standard_qty
ORDER BY standard_qty;

-- Though the price/standard_qty paper varies from one order to the next. I would like this ratio across all of the sales made in the orders table

SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;

-- When was the earliest order ever placed?

SELECT MIN(occurred_at)
FROM orders;

SELECT MIN(occurred_at)
FROM web_events;

-- When was the earliest order ever placed without using an aggregation function?

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

-- what is the MEDIAN total_usd spent on all orders? 
-- Note, this is more advanced than the topics we have covered thus far to build a general solution, but we can hard code a solution in the following way.

SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

-- Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.

SELECT acc.name,ord.occurred_at
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
ORDER BY ord.occurred_at;

-- Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name

SELECT acc.name,SUM(total_amt_usd) as SUM
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY acc.name
ORDER BY SUM DESC;

-- Via what channel did the most recent (latest) web_event occur,
-- which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.

SELECT acc.name,web.channel,web.occurred_at as recent_order_date
FROM web_events web
JOIN accounts acc
ON web.account_id = acc.id
ORDER BY recent_order_date DESC
;

-- Find the total number of times each type of channel from the web_events was used.
-- Your final table should have two columns - the channel and the number of times the channel was used.

SELECT web.channel,count(*)
FROM web_events web
GROUP BY web.channel 
;

-- What was the smallest order placed by each account in terms of total usd.
-- Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.

SELECT acc.name,min(ord.total_amt_usd)
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY acc.name 
;

-- Find the number of sales reps in each region. 
-- Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.

SELECT reg.name,count(sp.name) as CNT
FROM sales_reps sp
JOIN region reg
ON sp.region_id = reg.id
GROUP BY reg.name 
ORDER BY CNT
;

-- For each account, determine the average amount of each type of paper they purchased across their orders.
-- Your result should have four columns - one for the account name and one for the average spent on each of the paper types.

SELECT accounts.name,
ROUND(AVG(standard_qty),2) AS std_avg, 
ROUND(AVG(gloss_qty),2) AS gloss_avg,
ROUND(AVG(poster_qty),2) AS pos_avg
FROM orders
JOIN accounts
ON accounts.id = orders.account_id
GROUP BY accounts.name;

-- For each account, determine the average amount spent per order on each paper type. 
-- Your result should have four columns - one for the account name and one for the average amount spent on each paper type.

SELECT accounts.name,
ROUND(AVG(standard_amt_usd),2) AS std_avg, 
ROUND(AVG(gloss_amt_usd),2) AS gloss_avg,
ROUND(AVG(poster_amt_usd),2) AS pos_avg
FROM orders
JOIN accounts
ON accounts.id = orders.account_id
GROUP BY accounts.name;

-- Determine the number of times a particular channel was used in the web_events table for each sales rep. 
-- Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences.
-- Order your table with the highest number of occurrences first.

FROM web_events web
JOIN accounts acc
ON web.account_id = acc.id
JOIN sales_reps sp
ON acc.sales_rep_id = sp.id
GROUP BY sp.name,web.channel
ORDER BY web.channel,count desc
;

-- Determine the number of times a particular channel was used in the web_events table for each region. 
-- Your final table should have three columns - the region name, the channel, and the number of occurrences. 
-- Order your table with the highest number of occurrences first.

SELECT reg.name,web.channel,count(web.channel)
FROM web_events web
JOIN accounts acc
ON web.account_id = acc.id
JOIN sales_reps sp
ON acc.sales_rep_id = sp.id
JOIN region reg
ON reg.id = sp.region_id
GROUP BY reg.name,web.channel
ORDER BY web.channel,count desc
;

--How many of the sales reps have more than 5 accounts that they manage?

select sales_rep_id,count(accounts.id)
from accounts
group by sales_rep_id
having count(accounts.id) > 5;

-- How many accounts have more than 20 orders?
select count(*) 
from 
(select count(orders.account_id)
from orders
group by orders.account_id
having count(orders.account_id) > 20) AS T1;

--Which account has the most orders?
select orders.account_id,count(orders.account_id)
from orders
group by orders.account_id
having count(orders.account_id) > 20
order by count(orders.account_id) desc
limit 1;

--Which accounts spent more than 30,000 usd total across all orders?
select orders.account_id,SUM(orders.total_amt_usd)
from orders
group by orders.account_id
having SUM(orders.total_amt_usd) > 30000
order by SUM(orders.total_amt_usd) desc;

--Which accounts spent less than 1,000 usd total across all orders?
select orders.account_id,SUM(orders.total_amt_usd)
from orders
group by orders.account_id
having SUM(orders.total_amt_usd) < 1000
order by SUM(orders.total_amt_usd) desc;

--Which account has spent the most with us?

select orders.account_id,SUM(orders.total_amt_usd)
from orders
group by orders.account_id
order by SUM(orders.total_amt_usd) desc
limit 1;

--Which account has spent the least with us?

select orders.account_id,SUM(orders.total_amt_usd)
from orders
group by orders.account_id
order by SUM(orders.total_amt_usd) 
limit 1;

--Which accounts used facebook as a channel to contact customers more than 6 times?
select we.account_id,we.channel, count(we.channel)
from web_events we
group by we.channel,we.account_id
having count(we.channel) > 6 ;

--Which account used facebook most as a channel?
select we.account_id,we.channel, count(we.channel)
from web_events we
group by we.channel,we.account_id
having count(we.channel) > 6 
order by count(we.channel) desc
limit 1;

--Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?

SELECT DATE_PART('year',occurred_at),SUM(total_amt_usd)
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

-- Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?

SELECT DATE_PART('month',occurred_at),SUM(total_amt_usd)
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

--Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?

SELECT DATE_PART('year',occurred_at),count(*)
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

-- Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?

SELECT DATE_PART('month',occurred_at),count(*)
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

--In which month of which year did Walmart spend the most on gloss paper in terms of dollars?

SELECT DATE_PART('year',occurred_at) Y,DATE_PART('month',occurred_at) M,accounts.name,SUM(orders.gloss_amt_usd)
FROM orders
JOIN accounts
on accounts.id = orders.account_id
where accounts.name = 'Walmart'
GROUP BY 1,2,3
ORDER BY 4 DESC;

-- 
