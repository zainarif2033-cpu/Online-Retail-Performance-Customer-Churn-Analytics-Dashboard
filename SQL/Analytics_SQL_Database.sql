-- Create the database
create database Analytics_1;
-- Select the database 
use Analytics_1;

-- Create the raw table (original CSV data, untouched)
CREATE TABLE online_retail (
    InvoiceNo   VARCHAR(20),
    StockCode   VARCHAR(20),
    Description VARCHAR(255),
    Quantity    INT,
    InvoiceDate VARCHAR(30),
    UnitPrice   DECIMAL(10,2),
    CustomerID  VARCHAR(20),
    Country     VARCHAR(100)
);
-- Load the raw CSV file into the online_retail table (skipping the header row)
LOAD DATA LOCAL INFILE "C:/Users/Laptop Land/Downloads/IKEA Gifting Dataset/IKEA Gifting Dataset/online_retail_II page 1.csv"
INTO TABLE online_retail
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Count the total number of rows in the raw table
SELECT COUNT(*) FROM online_retail;

-- Preview all rows in the raw table
select * from online_retail;

-- Find duplicate rows (same values in all key columns) and how many times each repeats
SELECT InvoiceNO, StockCode, Quantity, InvoiceDate, UnitPrice, `CustomerID`, Country, COUNT(*) 
FROM online_retail
GROUP BY InvoiceNo, StockCode, Quantity, InvoiceDate, UnitPrice, `CustomerID`, Country 
HAVING COUNT(*) > 1;

-- Disable safe update mode 
set sql_safe_updates = 0;

-- Replace NULL descriptions with 'Unknown Product'
UPDATE online_retail 
SET Description = 'Unknown Product' 
WHERE Description IS NULL;

-- Find rows with zero/negative price or quantity 
SELECT * FROM online_retail WHERE UnitPrice <= 0 OR Quantity <= 0;

-- Create a cleaned copy of the raw table with duplicate rows removed (DISTINCT)
CREATE TABLE online_retail_cleaned 
SELECT DISTINCT InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, `CustomerID`, Country
FROM online_retail;

-- Replace NULL descriptions with 'Unknown Product' in the cleaned table
UPDATE online_retail_cleaned
SET Description = 'Unknown Product'
WHERE Description IS NULL;

-- Create a view of valid sales (positive quantity and price) with a TotalRevenue column
CREATE VIEW vw_clean_revenue as
SELECT *, 
       (Quantity * UnitPrice) AS TotalRevenue
FROM online_retail_cleaned
WHERE Quantity > 0 AND UnitPrice > 0;

-- List all tables and views in the database
SHOW TABLES;

-- Data quality check on the cleaned table: count of bad quantities, bad prices, cancelled invoices and NULL descriptions
SELECT 
    COUNT(*) AS total_rows,
    SUM(Quantity <= 0) AS bad_quantity,
    SUM(UnitPrice <= 0) AS bad_price,
    SUM(InvoiceNo LIKE 'C%') AS cancelled,
    SUM(Description IS NULL) AS null_desc
FROM online_retail_cleaned;

DROP TABLE IF EXISTS page1_final;

-- Create the final table: valid sales only (no cancelled invoices, positive quantity and price) with a TotalRevenue column
CREATE TABLE page1_final AS
SELECT 
    InvoiceNo, StockCode, Description, Quantity,
    InvoiceDate, UnitPrice, `CustomerID`, Country,
    Quantity * UnitPrice AS TotalRevenue
FROM online_retail_cleaned
WHERE InvoiceNo NOT LIKE 'C%'
  AND Quantity > 0
  AND UnitPrice > 0;
  
  CREATE TABLE page1_final AS
SELECT 
    InvoiceNo, StockCode, Description, Quantity,
    InvoiceDate, UnitPrice, `CustomerID`, Country,
    Quantity * UnitPrice AS TotalRevenue
FROM online_retail_cleaned
WHERE InvoiceNo NOT LIKE 'C%'
  AND Quantity > 0
  AND UnitPrice > 0;
  
  -- Verify the final table: bad quantity, bad price and cancelled invoices should all be 0, and get total revenue
  SELECT 
    COUNT(*) AS total_rows,
    SUM(Quantity <= 0) AS bad_quantity,
    SUM(UnitPrice <= 0) AS bad_price,
    SUM(InvoiceNo LIKE 'C%') AS cancelled,
    SUM(TotalRevenue) AS total_revenue
FROM page1_final;

-- Count rows with a missing Customer ID (guest purchases), kept in the table for revenue analysis
SELECT 
    COUNT(*) AS total_rows,
    SUM(`CustomerID` IS NULL OR TRIM(`CustomerID`) = '') AS missing_customer
FROM page1_final;

select * from page1_final;
show tables;

-- Count rows whose Description contains quotes, commas or line breaks (these can break CSV export)
SELECT COUNT(*) AS suspicious_rows
FROM page1_final
WHERE Description LIKE '%"%'
   OR Description LIKE '%,%'
   OR Description LIKE CONCAT('%', CHAR(10), '%')
   OR Description LIKE CONCAT('%', CHAR(13), '%');