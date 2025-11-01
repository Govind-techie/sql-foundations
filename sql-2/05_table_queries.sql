
/*
TABLE QUERIES IN SQL:

- SQL provides several commands to manipulate and manage tables and their data.
- Common table operations include:

  1. UPDATE: Modify existing records in a table.
     - Use WHERE clause to target specific rows.
     - Safe update mode may prevent updates without key columns.

  2. DELETE: Remove specific records from a table.
     - Always use WHERE to avoid deleting all rows.
     - DELETE without WHERE removes all rows but keeps table structure.

  3. ALTER TABLE: Modify table structure.
     - ADD COLUMN: Add new columns with optional default values.
     - DROP COLUMN: Remove columns permanently.
     - RENAME TABLE: Change the table name.
     - CHANGE COLUMN: Rename a column and/or modify its datatype.
     - MODIFY COLUMN: Change datatype or default without renaming.

  4. TRUNCATE TABLE: Remove all data from a table quickly while keeping its structure.
     - Resets auto-increment counters.
     - Cannot filter rows; all rows are deleted.

  5. DROP TABLE: Permanently deletes a table and all its data.
     - Use with caution; cannot be rolled back in most cases.

- SELECT * FROM table_name can be used to verify changes after any operation.
- Always ensure proper backups or testing before performing destructive operations like DELETE, TRUNCATE, or DROP.
*/


-- TABLE QUERIES IN SQL
-- This file demonstrates basic table operations: UPDATE, DELETE, ALTER, TRUNCATE, and DROP.

-- Use the 'instagram' database
USE instagram;

-----------------------------
-- UPDATE
-----------------------------
-- Temporarily disable safe update mode to allow updates on non-key columns
SET SQL_SAFE_UPDATES = 0;

-- Update the 'followers' column for users aged 15
UPDATE users
SET followers = 600
WHERE age = 15;
-- NOTE: Safe update mode prevents updating rows without a key column in WHERE.
--       Using WHERE ensures only targeted rows are updated.

-----------------------------
-- DELETE
-----------------------------
-- Delete users with age = 14
DELETE FROM users
WHERE age = 14;
-- NOTE: Always use a WHERE clause with DELETE to avoid deleting all rows.
--       Without WHERE, the entire table would be erased.

-----------------------------
-- ALTER TABLE
-----------------------------
-- 1. ADD COLUMN
ALTER TABLE users
ADD COLUMN city VARCHAR(25) DEFAULT "Mumbai";
-- Adds a new column 'city' with default value 'Mumbai' to all rows.

-- 2. DROP COLUMN
ALTER TABLE users
DROP COLUMN age;
-- Removes the 'age' column permanently from the table.

-- 3. RENAME TABLE
ALTER TABLE users
RENAME TO instaUsers;
-- Renames the table 'users' to 'instaUsers'.

-- 4. CHANGE COLUMN
ALTER TABLE instaUsers
CHANGE COLUMN followers subscribers INT DEFAULT 0;
-- Renames column 'followers' to 'subscribers' and changes its datatype to INT with default 0.

-- 5. MODIFY COLUMN
ALTER TABLE instaUsers
MODIFY COLUMN subscribers INT DEFAULT 5;
-- Modifies the 'subscribers' column to have a default value of 5.  
-- NOTE: MODIFY changes datatype or default, without renaming the column.

-----------------------------
-- TRUNCATE TABLE
-----------------------------
TRUNCATE TABLE instaUsers;
-- Removes all rows from 'instaUsers' but keeps the table structure intact.  
-- Faster than DELETE without WHERE because it resets the auto-increment counter.

-----------------------------
-- DROP TABLE
-----------------------------
DROP TABLE post;
-- Permanently deletes the 'post' table and all its data.  
-- NOTE: Cannot be rolled back in most cases; use with caution.