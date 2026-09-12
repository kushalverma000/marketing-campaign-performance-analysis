-- ============================================================
-- 11: MONTHLY PLATFORM PERFORMANCE
-- ============================================================
-- Evaluating each advertising platform month by month.
--
-- It helps understand whether changes in overall monthly
-- performance were associated with particular platforms.
-- ============================================================

SELECT
    -- Converting each date to the first day of its month
    DATEFROMPARTS(
        YEAR(date),
        MONTH(date),
        1
    ) AS month,

    -- Advertising platform
    platform,

    -- Total advertising spend
    SUM(ad_spend) AS total_ad_spend,

    -- Total conversions
    SUM(conversions) AS total_conversions,

    -- Total revenue
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

-- Grouping performance by month and platform
GROUP BY
    DATEFROMPARTS(
        YEAR(date),
        MONTH(date),
        1
    ),
    platform

-- Displaying months chronologically
-- and platforms within each month
ORDER BY
    month,
    platform;