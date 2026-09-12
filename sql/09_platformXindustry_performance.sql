-- ============================================================
--  7: PLATFORM × INDUSTRY PERFORMANCE
-- ============================================================
-- Comparing advertising performance for each
-- platform and industry combination.
--
-- The analysis helps identify specific segments where a
-- platform performs particularly well or poorly.
-- ============================================================

SELECT
    platform,
    industry,

    -- Total advertising reach
    SUM(impressions) AS total_impressions,

    -- Total clicks generated
    SUM(clicks) AS total_clicks,

    -- Total advertising spend
    SUM(ad_spend) AS total_ad_spend,

    -- Total conversions generated
    SUM(conversions) AS total_conversions,

    -- Total revenue generated
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

-- Group observations by both platform and industry
GROUP BY
    platform,
    industry

-- Rank the combinations from highest to lowest ROAS
ORDER BY
    ROAS DESC;