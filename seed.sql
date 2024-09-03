-- Create the testdb database if it doesn't already exist
CREATE DATABASE IF NOT EXISTS testdb;

-- Switch to the testdb database
USE testdb;

-- Create the info table if it doesn't already exist, with a unique key
CREATE TABLE IF NOT EXISTS info (
    name VARCHAR(20),
    lastname VARCHAR(20),
    age INT,
    UNIQUE KEY unique_info (name, lastname, age)  -- Unique key on name, lastname, and age
);

-- Insert data into the info table, ignoring duplicates based on the unique key
INSERT IGNORE INTO info (name, lastname, age) VALUES ('John', 'Doe', 30);
INSERT IGNORE INTO info (name, lastname, age) VALUES ('Jane', 'Smith', 25);
INSERT IGNORE INTO info (name, lastname, age) VALUES ('Alice', 'Johnson', 22);
INSERT IGNORE INTO info (name, lastname, age) VALUES ('Bob', 'Brown', 35);
INSERT IGNORE INTO info (name, lastname, age) VALUES ('Charlie', 'Davis', 28);
