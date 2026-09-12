-- ============================================================
-- STEP 1: OVERALL MARKETING PERFORMANCE BASELINE
-- ============================================================
-- Calculating the overall performance of all
-- advertising observations in the dataset.
--
-- KPI calculations are performed from the underlying measures
-- rather than relying on the pre-calculated KPI columns.
-- ============================================================
USE MarketingCampaignAnalysis
SELECT 
  -- Total Advertising reach 
  SUM(impressions) AS total_impression,

  -- Total Engagement 
  SUM(clicks) AS total_clicks,
  -- Total advertising investment
    SUM(ad_spend) AS total_ad_spend,

    -- Total conversions generated
    SUM(conversions) AS total_conversions,

    -- Total revenue generated
    SUM(revenue) AS total_revenue,

    -- Click-through Rate
    -- Clicks divided by impressions
    CAST(SUM(clicks) * 1.0 / NULLIF(SUM(impressions), 0) AS DECIMAL(10,4)) AS CTR,

    -- Cost per Click
    -- Advertising spend divided by clicks
    CAST(SUM(ad_spend) / NULLIF(SUM(clicks), 0) AS DECIMAL(10,2)) AS CPC,

    -- Conversion Rate
    -- Conversions divided by clicks
    CAST(SUM(conversions) * 1.0 / NULLIF(SUM(clicks), 0) AS DECIMAL(10,4)) AS CVR,

    -- Cost per Acquisition
    -- Advertising spend divided by conversions
    CAST(SUM(ad_spend) / NULLIF(SUM(conversions), 0) AS DECIMAL(12,2)) AS CPA,

    -- Return on Advertising Spend
    -- Revenue divided by advertising spend
    CAST(SUM(revenue) / NULLIF(SUM(ad_spend), 0) AS DECIMAL(10,2)) AS ROAS
FROM global_ads_performance