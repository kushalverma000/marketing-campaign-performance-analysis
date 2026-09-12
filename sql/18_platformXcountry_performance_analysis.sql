-- ============================================================
-- 16: PLATFORM × COUNTRY PERFORMANCE
-- ============================================================
-- Comparing advertising performance across each
-- combination of platform and country.
--
-- It helps identify geographically specific platform
-- opportunities and underperforming combinations.
-- ============================================================

SELECT
    platform,
    country,

    -- Total advertising spend
    SUM(ad_spend) AS total_ad_spend,

    -- Total conversions generated
    SUM(conversions) AS total_conversions,

    -- Total revenue generated
    SUM(revenue) AS total_revenue,

    -- Click-through Rate
    CAST(
        SUM(clicks) * 1.0
        / NULLIF(SUM(impressions), 0)
        AS DECIMAL(10,4)
    ) AS CTR,

    -- Conversion Rate
    CAST(
        SUM(conversions) * 1.0
        / NULLIF(SUM(clicks), 0)
        AS DECIMAL(10,4)
    ) AS CVR,

    -- Cost per Acquisition
    CAST(
        SUM(ad_spend)
        / NULLIF(SUM(conversions), 0)
        AS DECIMAL(12,2)
    ) AS CPA,

    -- Return on Advertising Spend
    CAST(
        SUM(revenue)
        / NULLIF(SUM(ad_spend), 0)
        AS DECIMAL(10,2)
    ) AS ROAS

FROM dbo.global_ads_performance

-- Creating one group for each platform × country combination
GROUP BY
    platform,
    country

-- Ranking combinations by ROAS
ORDER BY
    ROAS DESC;