--
SELECT channel,
AVG(count) FROM
(SELECT channel,
DATE_TRUNC('day',occurred_at) as DAY,
COUNT(*)
FROM web_events
GROUP BY 1,2 ORDER BY 3) subq
GROUP BY 1;


SELECT t2.Reg_name,t1.count,t2.tot_amt FROM 
	(SELECT r.name RNS,count(*)
	FROM orders o 
	JOIN accounts a
	ON a.id = o.account_id 
	JOIN sales_reps s
	ON a.sales_rep_id = s.id
	JOIN region r
	ON r.id = s.region_id
	GROUP BY r.name) t1
JOIN 
	(SELECT r.name Reg_name,SUM(total_amt_usd) Tot_amt
	FROM orders o 
	JOIN accounts a
	ON a.id = o.account_id 
	JOIN sales_reps s
	ON a.sales_rep_id = s.id
	JOIN region r
	ON r.id = s.region_id
	GROUP BY r.name) t2
ON t1.RNS = t2.Reg_name
order by 3 desc limit 1;



SELECT a.name,SUM(total) all_total
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name
HAVING SUM(total) > (SELECT std_qt from 
						(SELECT a.name,SUM(standard_qty) std_qt
						FROM orders o
						JOIN accounts a
						ON o.account_id = a.id
						GROUP BY a.name
						ORDER BY 2 DESC limit 1) t1
					);

SELECT *
FROM (SELECT a.name
       FROM orders o
       JOIN accounts a
       ON a.id = o.account_id
       GROUP BY 1
       HAVING SUM(o.total) > (SELECT total 
                   FROM (SELECT a.name act_name, SUM(o.standard_qty) tot_std, SUM(o.total) total
                         FROM accounts a
                         JOIN orders o
                         ON o.account_id = a.id
                         GROUP BY 1
                         ORDER BY 2 DESC
                         LIMIT 1) inner_tab)
             ) counter_tab;
			 
			 
SELECT account_id,channel,COUNT(*)
FROM web_events
GROUP BY account_id,channel
having account_id = (SELECT id from 
						(SELECT a.id,a.name,SUM(total_amt_usd)
						FROM orders o
						JOIN accounts a
						ON o.account_id = a.id
						GROUP BY 1,2
						ORDER BY 3 DESC
						LIMIT 1) t1
					);


WITH t1 AS (SELECT sp.region_id RID,sp.name SNAME, SUM(o.total_amt_usd)TUSD
		FROM orders o
		JOIN accounts a
		ON o.account_id = a.id
		JOIN sales_reps sp
		ON a.sales_rep_id = sp.id
		GROUP BY sp.region_id,sp.name
		ORDER BY TUSD DESC),

t2 AS (SELECT t1.RID,MAX(t1.TUSD) MUSD
	from t1
	GROUP BY 1) 

SELECT t1.RID ,t1.SNAME,t1.TUSD
from t1
join t2
on t1.rid = t2.rid and t1.tusd = t2.musd
;





