-- TABLE QUERIES: Instagram Database Example
-- This script demonstrates basic table creation, constraints, foreign keys,
-- data insertion, and select queries in MySQL.
-- It covers:
-- 1. Creating tables with PRIMARY KEY, UNIQUE, NOT NULL, DEFAULT, and CHECK constraints.
-- 2. Creating a table with a FOREIGN KEY referencing another table.
-- 3. Inserting multiple rows into a table.
-- 4. Selecting data using basic SELECT, SELECT *, and SELECT DISTINCT queries.

-- USE DATABASE
USE instagram; -- Selects the 'instagram' database to work in

-- DROP TABLES IF THEY ALREADY EXIST TO AVOID CONSTRAINT ISSUES
DROP TABLE IF EXISTS post; -- Drop post table first because it depends on users
DROP TABLE IF EXISTS users;

-- CREATE USERS TABLE
CREATE TABLE users (
	id INT, -- ID column to uniquely identify each user
    age INT, -- Age of the user
    name VARCHAR(30) NOT NULL, -- User's name; NOT NULL constraint ensures this field cannot be empty
    -- NOTE: VARCHAR is preferred over CHAR for variable-length strings to save memory
    email VARCHAR(50) UNIQUE, -- User email; UNIQUE constraint ensures no two users can have the same email
    followers INT DEFAULT 0, -- Number of followers; DEFAULT sets the value to 0 if not provided
    following INT DEFAULT 0, -- Number of users this user is following; default 0
    CONSTRAINT CHECK (age >= 13), -- Ensures only users aged 13 or above can be added
    PRIMARY KEY (id) -- Primary key ensures each user has a unique ID
);

-- CREATE POST TABLE
CREATE TABLE post (
	id INT PRIMARY KEY, -- Primary key uniquely identifies each post
    content VARCHAR(300), -- Content of the post
    user_id INT, -- ID of the user who created the post
    FOREIGN KEY (user_id) REFERENCES users(id) -- Ensures user_id exists in the users table
	-- Note: Foreign keys can have duplicate values and can be NULL
	-- This allows multiple posts by the same user and optional user_id
);

-- INSERT DATA INTO USERS
INSERT INTO users
VALUES
(1, 15, 'Bob', 'bob123@gmail.com', 132, 145), -- User with id=1, age=15
(2, 17, 'Adam', 'adam@yahoo.com', 156, 89), -- User with id=2, age=17
(3, 21, 'Casey', 'casey243@gmail.com', 379, 402); -- User with id=3, age=21

-- SELECT QUERIES

-- Select specific columns (id, name, email) from the users table
SELECT id, name, email FROM users; 
-- Example of fetching only required columns instead of all data

-- Select all columns from users table
SELECT * FROM users; 
-- Useful to view the complete data in the table

-- Select unique ages from the users table
SELECT DISTINCT age FROM users; 
-- DISTINCT ensures each age appears only once in the result set

-- NOTES:
-- 1. Constraints used in this script:
--    - PRIMARY KEY: uniquely identifies a row
--    - NOT NULL: prevents NULL entries
--    - UNIQUE: ensures no duplicates
--    - DEFAULT: sets a default value when not provided
--    - CHECK: enforces a condition on column values
--    - FOREIGN KEY: maintains referential integrity between tables
-- 2. Best practices:
--    - Always avoid using reserved keywords as table names (like 'user'); use 'users' instead
--    - Always use single quotes for string literals in MySQL
--    - Drop existing tables before creating new ones to avoid conflicts with constraints