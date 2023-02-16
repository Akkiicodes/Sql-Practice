-- joins
-- first join stmt
SELECT *
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

-- exctract specific columns from tables

SELECT orders.standard_qty,orders.gloss_qty,orders.poster_qty,accounts.primary_poc,accounts
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;
