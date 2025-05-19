# DataAnalytics-Assessment

- Assessment_Q1 Approach
I had to count the is_regular_savings and is_a_fund column for when it indicated '1' which indicates if the user has a savings plan and an investment plan.
I joined the users_customuser and plans_plan tables on id = owner_id to match the user information from the user table to the plan table.
Then I joined the users_customuser and savings_savingsaccount tables on id = owner_id to get the total deposits of each customer in the user table from the savings table
Lastly, I selected the needed information for the output table.

- Assessment_Q2 Approach
I had to create CTEs(Common Table Expresssions) to temporarily hold calculated values for later use, This included -
1. Transaction_Count CTE to hold the total transactions of each user
2. Average_Transaction CTE to hold the average transactions per month

To categorize the transaction frequency, I used CASE statement to group the average transactions as specified.
Lastly, I selected the needed information for the output table.

- Assessment_Q3 Approach
I had to create CTEs(Common Table Expresssions) to temporarily hold calculated values for later use, This included -
1. Year_before CTE
2. Max_data_date CTE
3. Year_before_table
4. LAst Transactions CTE

- Assessment_Q4 Approach



# Challenges
I had a challenge when importing the tables initially 
- For the users_customuser table, there was no users_tier table to reference in the constraint for foreign key
- For the withdrawals_withdrawal table, there was no withdrawals_withdrawalintent table to reference in the constraint for foreign key
