/*
LIMIT & ORDER BY CLAUSES: OVERVIEW & NOTES
1. The LIMIT clause sets an upper limit on the number of rows (tuples) returned by a query.
2. It helps restrict the output, especially when working with large datasets.
3. LIMIT is generally used at the end of a SELECT statement.
4. The ORDER BY clause sorts the result set based on one or more columns.
5. ORDER BY can sort in ASC (ascending) or DESC (descending) order.
6. ORDER BY can be applied to numeric, string, or date columns.
7. When ORDER BY is used on strings, SQL compares them lexicographically (character by character using ASCII/Unicode values).
8. LIMIT and ORDER BY are often used together to get a specific sorted subset of data.

NOTE:
- ASC is the default sort order if not specified.
- ORDER BY sorts first by the first column; if values are the same, it moves to the next column.
- LIMIT is MySQL-specific; other databases like SQL Server use TOP, and PostgreSQL uses LIMIT with OFFSET.
*/

USE instagram; -- Select the 'instagram' database to work with.


-- Example 1: LIMIT Clause
-- LIMIT sets the maximum number of rows that will appear in the result.
-- Useful for testing or previewing only a few rows from a large dataset.
SELECT * FROM users
LIMIT 2; 
-- Fetches only the first 2 rows from the 'users' table.


-- Example 2: ORDER BY Clause (Descending order)
-- ORDER BY sorts the result set based on specified columns.
-- DESC keyword sorts the data in descending order (highest → lowest).
SELECT name, age, followers FROM users
ORDER BY followers DESC; 
-- Fetches users sorted by follower count from highest to lowest.


-- Example 3: ORDER BY Clause (Ascending order)
-- ASC keyword sorts data in ascending order (lowest → highest).
SELECT name, age FROM users
ORDER BY age ASC;
-- Fetches users sorted by age from youngest to oldest.
-- NOTE: If ASC is not specified, ascending order is applied by default.


-- Example 4: ORDER BY Clause with Strings
-- When sorting strings, SQL converts each character to its ASCII/Unicode value 
-- and compares them lexicographically (character by character).
SELECT name FROM users
ORDER BY name DESC; 
-- Sorts names in reverse alphabetical order (Z → A).
-- NOTE: 'ORDER BY name DESC' sorts based on ASCII values internally.