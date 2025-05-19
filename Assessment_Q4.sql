-- Assessment_Q4: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value

-- Tables Used
select * from savings_savingsaccount;
select * from users_customuser;

-- Summarize each customer's transaction activity
WITH Transaction_Summary AS (
  SELECT 
    ss.owner_id,
    CONCAT(uc.first_name, ' ', uc.last_name) AS Name,
    COUNT(ss.id) AS total_transactions, -- Estimated average profit per transaction (0.1% of amount)
    AVG(ss.confirmed_amount) * 0.001 AS avg_profit_per_transaction
  FROM savings_savingsaccount ss
  JOIN users_customuser uc ON ss.owner_id = uc.id
  GROUP BY ss.owner_id, Name
),
-- Get the maximum transaction date in the dataset (used later to account tenure)
Max_data_date AS (
	SELECT MAX(transaction_date) as max_dd 
    FROM savings_savingsaccount
),
-- Calculate account tenure (in months) from signup to latest data
Account_Tenure AS (
  SELECT 
    uc.id AS owner_id,
    TIMESTAMPDIFF(MONTH, uc.date_joined, (SELECT max_dd FROM Max_data_date)) AS tenure_months
  FROM users_customuser uc
),
-- Calculate Estimated Customer Lifetime Value (CLV)
CLV_Calculation AS (
  SELECT 
    ts.owner_id,
    ts.Name,
    at.tenure_months,
    ts.total_transactions,
    ts.avg_profit_per_transaction,
    -- Apply CLV formula: (transactions/month) * 12 months * avg profit per transaction
    (ts.total_transactions / NULLIF(at.tenure_months, 0)) * 12 * ts.avg_profit_per_transaction AS estimated_clv
  FROM Transaction_Summary ts
  JOIN Account_Tenure at ON ts.owner_id = at.owner_id
)
-- Final output with rounded values, ordered by highest CLV
SELECT 
  owner_id,
  Name,
  tenure_months,
  total_transactions,
  ROUND(estimated_clv, 2) AS estimated_clv
FROM CLV_Calculation 
ORDER BY estimated_clv DESC;
