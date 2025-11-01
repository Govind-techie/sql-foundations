/*
GROUP BY & HAVING CLAUSES IN SQL:

- GROUP BY is used to group rows that have the same values in specified columns.
- HAVING is used to filter these groups after aggregation.
- Aggregate functions (COUNT, SUM, MAX, MIN, AVG) are often used with both GROUP BY and HAVING.
- Syntax overview:
    SELECT column1, aggregate_function(column2)
    FROM table_name
    GROUP BY column1
    HAVING aggregate_function(column2) condition;

- Key points:
    1. Columns in SELECT that are not aggregated must appear in GROUP BY.
    2. Use WHERE to filter rows before grouping; use HAVING to filter aggregated results.
    3. GROUP BY comes after FROM and before ORDER BY (if used).
    4. HAVING comes after GROUP BY.
    5. Multiple columns can be used to group by or filter by more complex criteria.
- Useful for analyzing data in categories, e.g., counting users by age or summing sales by region.
*/

-- USE DATABASE
USE instagram;

-----------------------------
-- GROUP BY CLAUSE EXAMPLES
-----------------------------

-- Example 1: Count of users per age group using id
SELECT age, COUNT(id) AS user_count
FROM users
GROUP BY age;
-- EXPLANATION:
-- 1. GROUP BY age: Groups all users by their age.
-- 2. COUNT(id) counts the number of non-NULL 'id' values in each age group.
-- 3. AS user_count provides a readable alias for the resulting column.

-- Example 2: Sum of followers per age group
SELECT age, SUM(followers) AS total_followers
FROM users
GROUP BY age;
-- EXPLANATION:
-- 1. Groups users based on their age.
-- 2. SUM(followers) calculates the total followers in each age group.
-- 3. AS total_followers provides a readable alias to the output column.

-----------------------------
-- HAVING CLAUSE EXAMPLES
-----------------------------

-- Example 3: Select age groups where the maximum followers is at least 150
SELECT age, MAX(followers) AS max_followers
FROM users
GROUP BY age
HAVING MAX(followers) >= 150; 
-- EXPLANATION:
-- 1. GROUP BY age: Groups all users by age.
-- 2. MAX(followers): Finds the maximum followers in each age group.
-- 3. HAVING MAX(followers) >= 150: Filters groups whose max followers < 150.
-- 4. AS max_followers: Provides a readable alias for the resulting column.

-- Example 4: Select age groups having more than 2 users
SELECT age, COUNT(id) AS user_count
FROM users
GROUP BY age
HAVING COUNT(id) > 2;
-- EXPLANATION:
-- 1. GROUP BY age: Groups all users by age.
-- 2. COUNT(id): Counts the number of users in each age group.
-- 3. HAVING COUNT(id) > 2: Filters out age groups with 2 or fewer users.
-- 4. AS user_count: Provides a readable alias for the resulting column.
-- NOTE:
-- - HAVING is essential here because we are filtering based on an aggregate (COUNT).
-- - Using WHERE instead would not work, as it cannot filter aggregated results.