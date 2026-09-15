-- ============================================================
-- SNOWFLAKE TUTORIAL ASSIGNMENT
-- Topics:
-- 1. SnowSQL Login and Connection
-- 2. Creation of Snowflake Objects
-- 3. Data Loading Using SnowSQL
-- 4. Snowflake Time Travel
-- 5. Data Recovery Using Time Travel
-- ============================================================


-- ============================================================
-- QUESTION 1: SNOWSQL LOGIN AND CONNECTION
-- ============================================================

SELECT CURRENT_USER() AS USER_NAME,
       CURRENT_ROLE() AS ROLE_NAME,
       CURRENT_WAREHOUSE() AS WAREHOUSE_NAME,
       CURRENT_DATABASE() AS DATABASE_NAME,
       CURRENT_SCHEMA() AS SCHEMA_NAME;


-- ============================================================
-- QUESTION 2: CREATION OF SNOWFLAKE OBJECTS
-- ============================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS SNOWFLAKE_ASSIGNMENT;

USE DATABASE SNOWFLAKE_ASSIGNMENT;

-- Create Schema
CREATE SCHEMA IF NOT EXISTS ASSIGNMENT_SCHEMA;

USE SCHEMA ASSIGNMENT_SCHEMA;

-- Create Warehouse
CREATE WAREHOUSE IF NOT EXISTS ASSIGNMENT_WH
WITH
    WAREHOUSE_SIZE = 'X-SMALL'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE;

USE WAREHOUSE ASSIGNMENT_WH;

-- Create Student Table
CREATE TABLE IF NOT EXISTS STUDENTS (
    STUDENT_ID INTEGER,
    NAME VARCHAR(50),
    DEPARTMENT VARCHAR(50),
    CGPA FLOAT,
    AGE INTEGER
);

-- Insert Sample Records
INSERT INTO STUDENTS VALUES
(101, 'Richard', 'CSE', 8.5, 20),
(102, 'Arun', 'CSE', 8.2, 20),
(103, 'Priya', 'BDA', 9.1, 19),
(104, 'Rahul', 'ECE', 7.8, 21),
(105, 'Ananya', 'BDA', 8.9, 20);

-- Display Records
SELECT * FROM STUDENTS;

-- INSERT Operation
INSERT INTO STUDENTS
VALUES (106, 'Kavin', 'CSE', 8.0, 20);

SELECT * FROM STUDENTS;

-- UPDATE Operation
UPDATE STUDENTS
SET CGPA = 8.4
WHERE STUDENT_ID = 106;

SELECT * FROM STUDENTS
WHERE STUDENT_ID = 106;

-- DELETE Operation
DELETE FROM STUDENTS
WHERE STUDENT_ID = 106;

SELECT * FROM STUDENTS;

-- Create Stage
CREATE STAGE IF NOT EXISTS STUDENT_STAGE;

SHOW STAGES;


-- ============================================================
-- QUESTION 3: DATA LOADING USING SNOWSQL
-- ============================================================

-- Create table for CSV data
CREATE TABLE IF NOT EXISTS STUDENT_LOAD (
    STUDENT_ID INTEGER,
    NAME VARCHAR(50),
    DEPARTMENT VARCHAR(50),
    CGPA FLOAT,
    AGE INTEGER
);

-- Create CSV file format
CREATE FILE FORMAT IF NOT EXISTS CSV_FORMAT
TYPE = 'CSV'
FIELD_DELIMITER = ','
SKIP_HEADER = 1;

-- Upload CSV file using SnowSQL
-- PUT 'file://C:/snowflake/students.csv' @STUDENT_STAGE;

-- Verify file in stage
-- LIST @STUDENT_STAGE;

-- Load data from stage
-- COPY INTO STUDENT_LOAD
-- FROM @STUDENT_STAGE
-- FILE_FORMAT = CSV_FORMAT;

-- Verify loaded data
SELECT * FROM STUDENT_LOAD;


-- ============================================================
-- QUESTION 4: SNOWFLAKE TIME TRAVEL
-- ============================================================

CREATE TABLE IF NOT EXISTS TIME_TRAVEL_STUDENTS (
    STUDENT_ID INTEGER,
    NAME VARCHAR(50),
    DEPARTMENT VARCHAR(50),
    CGPA FLOAT
);

INSERT INTO TIME_TRAVEL_STUDENTS VALUES
(301, 'Alice', 'CSE', 8.5),
(302, 'Bob', 'BDA', 9.0),
(303, 'Charlie', 'ECE', 7.8),
(304, 'Diana', 'CSE', 8.7);

-- Display original records
SELECT * FROM TIME_TRAVEL_STUDENTS;

-- Record timestamp before modifications
SELECT CURRENT_TIMESTAMP();

-- Update a record
UPDATE TIME_TRAVEL_STUDENTS
SET CGPA = 9.5
WHERE STUDENT_ID = 302;

-- Delete a record
DELETE FROM TIME_TRAVEL_STUDENTS
WHERE STUDENT_ID = 303;

-- Display current data
SELECT * FROM TIME_TRAVEL_STUDENTS;

-- Time Travel query
-- Replace the timestamp with the timestamp recorded
-- before UPDATE and DELETE.
--
-- SELECT *
-- FROM TIME_TRAVEL_STUDENTS
-- AT (TIMESTAMP => 'YOUR_TIMESTAMP');


-- ============================================================
-- QUESTION 5: DATA RECOVERY USING TIME TRAVEL
-- ============================================================

-- Find the deleted record using Time Travel.
-- Replace YOUR_TIMESTAMP with the timestamp recorded earlier.
--
-- SELECT *
-- FROM TIME_TRAVEL_STUDENTS
-- AT (TIMESTAMP => 'YOUR_TIMESTAMP')
-- WHERE STUDENT_ID = 303;

-- Recover the deleted record.
-- Replace YOUR_TIMESTAMP with the correct timestamp.
--
-- INSERT INTO TIME_TRAVEL_STUDENTS
-- SELECT *
-- FROM TIME_TRAVEL_STUDENTS
-- AT (TIMESTAMP => 'YOUR_TIMESTAMP')
-- WHERE STUDENT_ID = 303;

-- Verify recovery
SELECT * FROM TIME_TRAVEL_STUDENTS;
