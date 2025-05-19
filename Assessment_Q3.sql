-- Assessment_Q3: all active accounts (savings or investments) with no transactions in the last 1 year

-- Tables Used
select * from plans_plan;
select * from savings_savingsaccount;


-- Calculate the date that is 365 days before the latest transaction date
WITH Year_before AS (
	SELECT DATE_SUB(MAX(transaction_date), INTERVAL 365 DAY) AS Year_before
	FROM savings_savingsaccount ss
    JOIN plans_plan pp ON ss.owner_id = pp.owner_id 
),
-- Get the maximum transaction date in the dataset (used later to calculate inactivity days)
Max_data_date AS (
	SELECT MAX(transaction_date) as max_dd 
    FROM savings_savingsaccount
),
-- Get all transactions that occurred within the last year
Year_before_table AS (
	SELECT * 
    FROM savings_savingsaccount
	WHERE transaction_date > (SELECT Year_before FROM Year_before)
),
-- For users who did NOT have any transaction in the past year, their last transaction date, and their plan info
Last_Transactions AS (
	SELECT ss.owner_id,
		MAX(ss.transaction_date) AS last_date,
        pp.id,
		pp.is_regular_savings,
		pp.is_a_fund
    FROM savings_savingsaccount ss
    JOIN plans_plan pp ON ss.owner_id = pp.owner_id
    WHERE ss.owner_id NOT IN 
		(SELECT DISTINCT owner_id FROM Year_before_table)
	GROUP BY ss.owner_id, pp.id, pp.is_regular_savings, pp.is_a_fund
)
-- Final output
SELECT 
	lt.id,
    lt.owner_id, 
    CASE WHEN lt.is_regular_savings = 1 THEN 'Savings' ELSE 0 END AS savings,
    CASE WHEN lt.is_a_fund = 1 THEN 'Investments' ELSE 0 END AS investment,
    lt.last_date,
	DATEDIFF(md.max_dd, last_date) AS inactivity_days
FROM Last_Transactions lt
JOIN Max_data_date md;








