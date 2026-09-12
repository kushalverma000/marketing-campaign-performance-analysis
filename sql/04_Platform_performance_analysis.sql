-- ============================================================
-- 2: PLATFORM PERFORMANCE ANALYSIS
-- ============================================================
-- Comparing advertising performance across platforms.
-- KPIs are calculated from aggregated underlying measures.
-- ============================================================

SELECT
    platform,

    -- Total advertising reach
    SUM(impressions) AS total_impressions,

    -- Total engagement
    SUM(clicks) AS total_clicks,

    -- Total advertising spend
    SUM(ad_spend) AS total_ad_spend,

    -- Total conversions
    SUM(conversions) AS total_conversions,

    -- Total revenue
    SUM(revenue) AS total_revenue,

    -- Click-through Rate
    CAST(
        SUM(clicks) * 1.0 / NULLIF(SUM(impressions), 0)
        AS DECIMAL(10,4)
    ) AS CTR,

    -- Cost per Click
    CAST(
        SUM(ad_spend) / NULLIF(SUM(clicks), 0)
        AS DECIMAL(10,2)
    ) AS CPC,

    -- Conversion Rate
    CAST(
        SUM(conversions) * 1.0 / NULLIF(SUM(clicks), 0)
        AS DECIMAL(10,4)
    ) AS CVR,

    -- Cost per Acquisition
    CAST(
        SUM(ad_spend) / NULLIF(SUM(conversions), 0)
        AS DECIMAL(12,2)
    ) AS CPA,

    -- Return on Advertising Spend
    CAST(
        SUM(revenue) / NULLIF(SUM(ad_spend), 0)
        AS DECIMAL(10,2)
    ) AS ROAS

FROM dbo.global_ads_performance

-- Group all observations by advertising platform
GROUP BY platform

-- Sort platforms by ROAS from highest to lowest
ORDER BY ROAS DESC;