/*
WHERE CLAUSE: OVERVIEW & NOTES
1. The WHERE clause is used to filter records based on a specified condition.
2. It allows you to retrieve only the rows that meet certain criteria.
3. WHERE can be used with SELECT, UPDATE, and DELETE statements.
4. It always appears after the FROM clause in a query.
5. Conditions inside WHERE can use:
     - Comparison Operators: =, !=, >, <, >=, <=
     - Logical Operators: AND, OR, NOT
     - Special Operators: BETWEEN, IN, LIKE, IS NULL
6. WHERE works row by row — each record is checked against the condition.
7. Logical operators (AND, OR, NOT) combine multiple conditions.
8. WHERE only filters data; it does not change it.

NOTE:
- 'AND' and 'OR' are logical operators (not bitwise).
- Use WHERE carefully in UPDATE or DELETE statements — it directly affects data.
- WHERE is case-insensitive in SQL (keywords like WHERE, AND, etc. are not case-sensitive).
*/

USE instagram; -- Select the 'instagram' database to work with.


-- Example 1: Basic WHERE condition
SELECT * FROM users
WHERE followers >= 200; 
-- Fetches all users whose followers are greater than or equal to 200.

-- NOTE: WHERE is used with SELECT, UPDATE, DELETE, etc., to apply conditions on data.


-- Example 2: Fetching specific columns with a condition
SELECT name FROM users
WHERE age <= 16; 
-- Returns only the names of users who are 16 years old or younger.


-- Operators in WHERE Clause
-- WHERE supports arithmetic, comparison, and logical operators.


-- Example 3: Arithmetic operator inside WHERE
SELECT name FROM users
WHERE age + 1 = 18;  
-- Adds 1 to the age column and checks if it equals 18.
-- NOTE: Arithmetic operations can be applied on columns directly inside WHERE.


-- Example 4: Logical AND operator
SELECT name, age, followers FROM users
WHERE age > 15 AND followers > 100; 
-- AND operator returns rows only when BOTH conditions are true.

-- NOTE: 'AND' is a logical operator, not bitwise. 
-- It works with boolean (true/false) results of conditions, not bits.


-- Example 5: Logical OR operator
SELECT name, age, followers FROM users
WHERE age < 17 OR followers > 200; 
-- OR operator returns rows when EITHER one of the conditions is true.

-- NOTE: 'OR' is also a logical operator.
-- Use it when you want results matching at least one condition.


-- Example 6: BETWEEN operator
SELECT name, age FROM users
WHERE age BETWEEN 15 AND 18;  
-- Returns rows where the 'age' value is between 15 and 18 (inclusive).
-- NOTE: BETWEEN includes both the lower and upper bounds (15 and 18).


-- Example 7: IN operator
SELECT name, age, email FROM users
WHERE email IN ("bob123@gmail.com", "casey243@gmail.com", "abc@gmail.com");
-- Returns users whose email matches any one of the listed values.
-- NOTE: IN is a shorthand for multiple OR conditions. 
-- Example: email = 'bob123@gmail.com' OR email = 'casey243@gmail.com' OR email = 'abc@gmail.com'


-- Example 8: NOT IN operator
SELECT name, age FROM users
WHERE age NOT IN (14, 16);
-- Returns users whose age is neither 14 nor 16.

-- NOTE: Use NOT IN to exclude multiple values from the result set.