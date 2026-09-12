-- Recreate the table with the exact structure of the prepared CSV
CREATE TABLE dbo.global_ads_performance
(
    date DATE,
    platform VARCHAR(50),
    campaign_type VARCHAR(50),
    industry VARCHAR(50),
    country VARCHAR(50),

    impressions INT,
    clicks INT,

    CTR DECIMAL(10,6),
    CPC DECIMAL(10,2),
    ad_spend DECIMAL(12,2),

    conversions INT,
    CPA DECIMAL(12,2),
    revenue DECIMAL(14,2),
    ROAS DECIMAL(10,2)
);


-- Verifing the final destination table structure
-- The column order should match the prepared CSV exactly.
SELECT
    ORDINAL_POSITION,
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    NUMERIC_PRECISION,
    NUMERIC_SCALE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'global_ads_performance'
ORDER BY ORDINAL_POSITION;