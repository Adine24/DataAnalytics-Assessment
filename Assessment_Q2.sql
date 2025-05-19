-- Assessment_Q2: the average number of transactions per customer per month and categorize them

-- Tables Used
select * from savings_savingsaccount;
select * from users_customuser;

-- Create a CTE to count total transactions per user
WITH Transaction_Count AS (
    SELECT 
        ss.owner_id,
        COUNT(id) AS transaction_count
    FROM savings_savingsaccount ss
    JOIN users_customuser uc ON ss.owner_id = uc.id
    GROUP BY owner_id
),
Average_Transaction AS (
    SELECT AVG(transaction_count) AS avg_transactions_per_month
    FROM Transaction_Count
)
SELECT 
    -- Categorize frequency based on average transaction count
    CASE
        WHEN at.avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN at.avg_transactions_per_month > 3 AND at.avg_transactions_per_month < 10 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(tc.owner_id) AS customer_count,
    at.avg_transactions_per_month
FROM Transaction_Count tc
JOIN Average_Transaction at;


