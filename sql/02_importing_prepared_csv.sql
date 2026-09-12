-- Import the prepared CSV into the existing table
BULK INSERT dbo.global_ads_performance
FROM 'C:\Users\kusha\OneDrive\Desktop\DA\My projects\Marketing Campaign Analysis\Prepared data\global_ads_performance_prepared.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

-- Verifying that the prepared dataset was imported correctly.
-- expecting exactly 1,800 rows.


SELECT COUNT(*) AS total_rows
FROM dbo.global_ads_performance;

-- Preview the first 10 imported records.
SELECT TOP 10 *
FROM dbo.global_ads_performance;