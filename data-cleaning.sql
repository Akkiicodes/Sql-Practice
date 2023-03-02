--Pull these extensions and provide how many of each website type exist in the accounts table

select distinct(RIGHT(website,3)) from accounts ;

--Use the accounts table to pull the first letter of each company name to see the distribution of company names that begin with each letter

select RIGHT(name,1), count(*) from accounts
group by 1
order by 2 desc;

--Use the accounts table and a CASE statement to create two groups: one group of company names that start with a number 
--and a second group of those company names that start with a letter. What proportion of company names start with a letter?

SELECT SUM(num) nums, SUM(letter) letters
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') 
                       THEN 1 ELSE 0 END AS num, 
         CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') 
                       THEN 0 ELSE 1 END AS letter
      FROM accounts) t1;
      
--Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start with anything else?

 WITH
T1 AS (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') 
                       THEN 1 ELSE 0 END AS vowel, 
         CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') 
                       THEN 0 ELSE 1 END AS conjunction
      FROM accounts)
      
select sum(vowel) as V ,sum(conjunction) as C from t1;

--Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.

SELECT 
LEFT(primary_poc,STRPOS(primary_poc,' ')-1)
AS FN,
RIGHT(primary_poc,LENGTH(primary_poc) - STRPOS(primary_poc,' '))
FROM accounts;

--Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.
SELECT 
LEFT(name,STRPOS(name,' ')-1)
AS FN,
RIGHT(name,LENGTH(name) - STRPOS(name,' '))
AS LN
FROM sales_reps;

--We would also like to create an initial password, which they will change after their first log in. The first password will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name (lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number of letters in their first name,
--the number of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces.

WITH t1 AS (
 SELECT LEFT(primary_poc,     STRPOS(primary_poc, ' ') -1 ) first_name,  RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com'), LEFT(LOWER(first_name), 1) || RIGHT(LOWER(first_name), 1) || LEFT(LOWER(last_name), 1) || RIGHT(LOWER(last_name), 1) || LENGTH(first_name) || LENGTH(last_name) || REPLACE(UPPER(name), ' ', '')
FROM t1;

-- change date format to std sql format

SELECT
(SUBSTR(date,7,4) || '-' || SUBSTR(date,1,2) || '-' || SUBSTR(date,4,2))::date 
FROM
sf_crime_data;

-- window & running total

SELECT
standard_amt_usd,
SUM(standard_amt_usd) OVER ( ORDER BY occurred_at) as running_total
FROM orders;
