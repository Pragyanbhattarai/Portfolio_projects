USE Data_cleaning;

SELECT * FROM
retail_store_sales

-- CHECK DATA TYPES AND COLUMN INFORMATION

SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'retail_store_sales'

-- CHECK NULL VALUES

SELECT
    SUM(CASE WHEN [Transaction_ID] IS NULL THEN 1 ELSE 0 END) AS TransactionID_NullValues,
    SUM(CASE WHEN [Customer_ID] IS NULL THEN 1 ELSE 0 END) AS CustomerID_NullValues,
    SUM(CASE WHEN [Category] IS NULL THEN 1 ELSE 0 END) AS Category_NullValues,
    SUM(CASE WHEN [Item] IS NULL THEN 1 ELSE 0 END) AS Item_NullValues,                         -- 1213
    SUM(CASE WHEN [Price_Per_Unit] IS NULL THEN 1 ELSE 0 END) AS PPU_NullValues,                -- 609
    SUM(CASE WHEN [Quantity] IS NULL THEN 1 ELSE 0 END) AS Quantity_NullValues,                 -- 604
    SUM(CASE WHEN [Total_Spent] IS NULL THEN 1 ELSE 0 END) AS TotalSpent_NullValues,            -- 604
    SUM(CASE WHEN [Payment_Method] IS NULL THEN 1 ELSE 0 END) AS PaymentMethod_NullValues,
    SUM(CASE WHEN [Location] IS NULL THEN 1 ELSE 0 END) AS Location_NullValues,
    SUM(CASE WHEN [Transaction_Date] IS NULL THEN 1 ELSE 0 END) AS TransactionDate_NullValues,
    SUM(CASE WHEN [Discount_Applied] IS NULL THEN 1 ELSE 0 END) AS DiscountApplied_NullValues   -- 4199
FROM
    retail_store_sales;


SELECT * FROM
retail_store_sales

-- HANDELING NULL VALUES

-- ALL DISCOUNT VALUES HAVING NULL SET TO 0

UPDATE retail_store_sales
SET Discount_Applied = 0
WHERE Discount_Applied IS NULL;

-- CALCULATE THE MISSING VALUES

UPDATE retail_store_sales
SET Total_Spent = Price_Per_Unit * Quantity
WHERE Total_Spent IS NULL AND Price_Per_Unit IS NOT NULL AND Quantity IS NOT NULL

UPDATE retail_store_sales
SET Price_Per_Unit = Total_Spent / Quantity
WHERE Total_Spent IS NOT NULL AND Price_Per_Unit IS NULL AND Quantity IS NOT NULL

UPDATE retail_store_sales
SET Quantity = Total_Spent / Price_Per_Unit
WHERE Total_Spent IS NOT NULL AND Price_Per_Unit IS NOT NULL AND Quantity IS NULL

/* 
FOR ROWS WHERE CRITICAL INFORMATION LIKE ITEM, PRICE_PER_UNIT, AND QUANTITY ARE MISSING, 
CALCULATION IS NOT POSSIBLE. SO, WE REMOVE THE ROWS WITH MISSING INFORMATIONS. 
*/

DELETE FROM retail_store_sales
WHERE 
    Item IS NULL OR 
    (Price_Per_Unit IS NULL AND Total_Spent IS NULL) OR 
    Quantity IS NULL

-- CHECKING DUPLICATE TRANSACTIONS

SELECT Transaction_ID, COUNT(Transaction_ID) AS DUPLICATES
FROM retail_store_sales
GROUP BY Transaction_ID
HAVING COUNT(Transaction_ID) > 1;   

-- NONE FOUND

-- CLEANED READY FOR ANALYSIS



