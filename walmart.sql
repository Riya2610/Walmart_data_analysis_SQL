CREATE DATABASE WALMART_SALES;
USE WALMART_SALES;
DROP TABLE SALES;
CREATE TABLE SALES(invoice_id VARCHAR(30) NOT NULL,
				   branch VARCHAR(5) NOT NULL,
                   city VARCHAR(30) NOT NULL,
                   customer_type VARCHAR(30) NOT NULL,
                   gender VARCHAR(30) NOT NULL,
                   product_line VARCHAR(100)NOT NULL,
                   unit_price DECIMAL(10,2) NOT NULL,
                   quantity INT NOT NULL,
                   VAT FLOAT(6,4) NOT NULL,
                   total DECIMAL(12,4) NOT NULL,
                   date DATETIME NOT NULL,
                   time TIME NOT NULL,
                   payment_method VARCHAR(15) NOT NULL,
                   cogs DECIMAL (10,2) NOT NULL,
                   gross_margin_pct FLOAT(11,9),
                   gross_income DECIMAL(12,4) NOT NULL,
                   rating FLOAT(2,1)
                   );
SELECT * FROM SALES;

ALTER TABLE SALES DROP COLUMN total_cost_per_unit;
SELECT * FROM temp_sales_data;

















-- --------------------------------------------------------------
-- --------------------------------------------------------------
-- --------------------------------------------------------------
--                     Feature Engineering
-- --------------------------------------------------------------                
-- --------------------------------------------------------------
-- --------------------------------------------------------------

-- Create a Feature for Total Cost Per Unit AND ADDING IN THE TABLE:
CREATE TEMPORARY TABLE temp_sales_data AS
SELECT 
  invoice_id,
  (unit_price * quantity) AS total_cost_per_unit
FROM SALES;



ALTER TABLE SALES ADD COLUMN total_cost_per_unit DECIMAL(12, 2);

UPDATE SALES
SET total_cost_per_unit = (
    SELECT temp_sales_data.total_cost_per_unit
    FROM temp_sales_data
    WHERE temp_sales_data.invoice_id = SALES.invoice_id
);










