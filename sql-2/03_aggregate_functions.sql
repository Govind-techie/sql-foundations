
/*
AGGREGATE FUNCTIONS IN SQL:

- Aggregate functions perform calculations on a set of rows and return a single summary value.
- Common aggregate functions include:
    1. COUNT(): Counts the number of rows (or non-NULL values in a column).
    2. SUM(): Calculates the total sum of a numeric column.
    3. MAX(): Finds the maximum value in a column.
    4. MIN(): Finds the minimum value in a column.
    5. AVG(): Calculates the average value of a numeric column.
- These functions are often used with the GROUP BY clause to get grouped summaries.
- Aggregate functions ignore NULL values (except COUNT(*) which counts all rows).
- Useful for generating insights, statistics, and overall summary information from tables.
*/

-- AGGREGATE FUNCTIONS
-- Aggregate functions perform a calculation on a set of values and return a single value.
-- They are often used with the GROUP BY clause but can also be used without it to get overall statistics.

-- Use the 'instagram' database
USE instagram;

-- MAX(): Returns the maximum value from a column
-- Here, we are finding the user who has the highest number of followers
SELECT max(followers) FROM users; 
-- NOTE: Only returns the highest followers count, not the user details

-- COUNT(): Returns the number of rows that match a specified condition
-- Here, we are counting how many users are 14 years old
SELECT count(age) FROM users
WHERE age = 14; 
-- NOTE: COUNT(column_name) counts non-NULL values in that column
--       COUNT(*) could also be used to count all rows regardless of NULLs

-- SUM(): Returns the total sum of a numeric column
-- Here, we are calculating the total number of followers across all users
SELECT sum(followers) FROM users; 
-- NOTE: SUM ignores NULL values in the column

-- KEY POINTS ABOUT AGGREGATE FUNCTIONS:
-- 1. Common aggregate functions: COUNT(), SUM(), MAX(), MIN(), AVG()
-- 2. They always return a single value for the entire set of rows (or per group if GROUP BY is used)
-- 3. They ignore NULLs except in COUNT(*)
-- 4. Useful for generating summary statistics from tables