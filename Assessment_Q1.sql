-- Assessment_Q1: customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.

-- Tables Used
SELECT 
	-- Select user ID and full name
    uc.id, 
    CONCAT(uc.first_name, ' ', uc.last_name) AS Name, 
    -- Count the number of regular savings plans for each user
    COUNT(CASE WHEN pp.is_regular_savings = 1 THEN 1 END) AS savings_count,
    -- Count the number of fixed investment plans for each user
    COUNT(CASE WHEN pp.is_a_fund = 1 THEN 1 END) AS investment_count,
    -- Calculate the total confirmed amount deposited by each user
    SUM(ss.confirmed_amount) AS total_deposit
-- Join the users table with the plans table using user ID
FROM users_customuser uc
JOIN plans_plan pp ON uc.id = pp.owner_id
-- Join the users table with the savings account table using user ID
JOIN savings_savingsaccount ss ON uc.id = ss.owner_id
-- Group the results by user ID and name to aggregate savings and investments
GROUP BY uc.id, Name
HAVING savings_count > 0 AND investment_count > 0
-- Order the result by total deposit in ascending order 
ORDER BY total_deposit;


