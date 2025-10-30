-- SQL DATABASE MANAGEMENT COMMANDS
-- This script demonstrates essential SQL operations related to 
-- database management. These commands are part of the Data Definition
-- Language (DDL) in SQL, which is responsible for creating, modifying, 
-- and deleting database structures.
--
-- Covered Concepts:
-- 1. Creating databases.
-- 2. Conditional database creation and deletion.
-- 3. Viewing existing databases and tables.
-- 4. Selecting a specific database to work in.
--
-- Note:
-- The term "query" is generally used for any SQL statement we execute.
-- Technically, these are DDL commands, but when executed, they are 
-- referred to as queries in day-to-day usage.

CREATE DATABASE college; 
-- Creates a new database named 'college'.
-- A database is a logical container that holds multiple tables and related data.
-- If a database with the same name already exists, this command will produce an error.

CREATE DATABASE IF NOT EXISTS instagram;
-- Creates a new database named 'instagram' only if it does not already exist.
-- The 'IF NOT EXISTS' clause prevents an error if the database is already present.
-- This is a safer and preferred approach in most cases.

DROP DATABASE IF EXISTS college;
-- Deletes (drops) the 'college' database, but only if it exists.
-- The 'IF EXISTS' clause ensures that SQL does not throw an error if the database is missing.
-- Be cautious: this action permanently removes the database and all its data.

SHOW DATABASES;
-- Displays a list of all available databases on the MySQL server.
-- It helps verify which databases exist before performing operations.

USE instagram;
-- Selects the 'instagram' database for the current SQL session.
-- All subsequent commands (like creating tables or inserting data)
-- will be executed inside this selected database until another one is chosen.

SHOW TABLES;
-- Lists all tables present in the currently selected database ('instagram' here).
-- It’s useful to confirm the structure or presence of tables before performing further operations.

-- ADDITIONAL NOTES:
-- 1. Databases group related tables, making data management organized and efficient.
-- 2. The 'USE' command defines your working context; without it, you cannot create or access tables.
-- 3. The 'SHOW' commands (SHOW DATABASES, SHOW TABLES) are used for inspection and verification.
-- 4. Always use 'IF EXISTS' or 'IF NOT EXISTS' to make your SQL scripts more reliable and error-resistant.
-- 5. These commands belong to the DDL (Data Definition Language) category, 
--    which deals with the structure and schema of the database rather than the data itself.