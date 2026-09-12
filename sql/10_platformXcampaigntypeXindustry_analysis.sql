-- ============================================================
--  8: PLATFORM × CAMPAIGN TYPE × INDUSTRY ANALYSIS
-- ============================================================
-- Evaluating the performance of each combination
-- of platform, campaign type, and industry.
--
-- The results are ranked by ROAS to identify the most
-- efficient marketing segments.
-- ============================================================

SELECT
    platform,
    campaign_type,
    industry,

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

-- Create one group for every unique
-- Platform + Campaign Type + Industry combination
GROUP BY
    platform,
    campaign_type,
    industry

-- Rank the most efficient segments first
ORDER BY
    ROAS DESC;