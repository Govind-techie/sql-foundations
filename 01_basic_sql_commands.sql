-- SQL BASICS: DATABASE CREATION, TABLE CREATION, AND DATA INSERTION
-- This script demonstrates the fundamental SQL operations:
-- 1. Creating and managing databases.
-- 2. Creating tables to organize data into structured columns.
-- 3. Inserting multiple rows (records) into a table.
-- 4. Retrieving data using SELECT statements.
--
-- SQL (Structured Query Language) is a standard language used to
-- manage and manipulate relational databases such as MySQL, SQL Server, or PostgreSQL.

-- DATABASE CREATION & MANAGEMENT IN SQL

CREATE DATABASE college; 
-- The CREATE DATABASE statement is used to create a new database named 'college'.
-- Think of a database as a container that holds multiple related tables.

CREATE DATABASE user; 
-- This creates another database named 'user'.
-- NOTE: SQL is a case-insensitive language, meaning 'CREATE' and 'create' work the same way.
-- However, using uppercase for SQL keywords is a good practice for readability and clarity.

DROP DATABASE user; 
-- The DROP DATABASE command permanently deletes the entire database along with all its tables and data.
-- Warning: Once dropped, the data cannot be recovered unless a backup exists.
-- Use it carefully, especially in production environments.

USE college; 
-- The USE command selects the database you want to work with.
-- After this command, all your subsequent SQL statements (like CREATE TABLE, INSERT, etc.)
-- will be executed inside the 'college' database.

-- TABLE CREATION IN SQL

CREATE TABLE student ( 
-- The CREATE TABLE command creates a new table inside the selected database ('college' here).
-- Tables store data in rows (records) and columns (fields), similar to an Excel sheet.

	rollno INT, 
    -- 'rollno' is a column of type INT (integer), used to store whole numbers.
    -- Example: 101, 102, 103 etc.
    -- Typically, 'rollno' can act as a unique identifier for each student.

    name VARCHAR(30), 
    -- 'name' is a column of type VARCHAR, used to store text (string) values.
    -- The number (30) defines the maximum allowed characters.
    -- Example: 'Rahul', 'Priya', 'Amit Sharma'

    age INT
    -- 'age' is a column of type INT, used to store numerical age values.
    -- Example: 18, 20, 22
);
-- After executing this command, a table named 'student' will be created within the 'college' database.

-- INSERTING DATA INTO A TABLE

INSERT INTO student 
VALUES
(101, 'adam', 12),
(102, 'bob', 14),
(103, 'casey', 13); 
-- The INSERT INTO command adds new records (rows) into the 'student' table.
-- Each set of parentheses represents one row of data.
-- String values (like names) must always be enclosed in single quotes (' ').
-- Multiple rows can be inserted in a single command by separating them with commas.

-- RETRIEVING DATA FROM A TABLE

SELECT * FROM student;
-- The SELECT statement is used to fetch data from a table.
-- The asterisk (*) means "select all columns".
-- This will display the entire 'student' table, showing all rows and columns.

-- ADDITIONAL NOTES AND BEST PRACTICES

-- 1. Each column in the table has:
--      - A name (identifier)
--      - A data type (defines the kind of data it can store)

-- 2. Common SQL Data Types:
--      INT           → for whole numbers (e.g., 10, 20)
--      VARCHAR(n)    → for text strings with a character limit (e.g., 'John')
--      DATE          → for date values (e.g., '2025-10-30')
--      FLOAT/DECIMAL → for decimal numbers (e.g., 99.75)

-- 3. Each SQL statement typically ends with a semicolon (;) — 
--    this indicates the end of a command and is a good habit to maintain.

-- 4. Using UPPERCASE for SQL keywords (CREATE, INSERT, SELECT, etc.) 
--    and lowercase for database/table/column names improves readability.

-- 5. SQL commands can be categorized as:
--      DDL (Data Definition Language): CREATE, DROP, ALTER
--      DML (Data Manipulation Language): INSERT, UPDATE, DELETE
--      DQL (Data Query Language): SELECT
--      DCL (Data Control Language): GRANT, REVOKE

-- 6. You can use:
--      SHOW DATABASES;   → to list all databases.
--      SHOW TABLES;      → to list all tables in the current database.
--      DESCRIBE student; → to see the structure of the 'student' table.