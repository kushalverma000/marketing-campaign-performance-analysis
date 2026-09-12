-- ============================================================
-- 10: MONTHLY MARKETING PERFORMANCE TREND
-- ============================================================
-- Aggregating advertising performance by month.
--
-- It helps identify changes in:
--   • Advertising spend
--   • Clicks and impressions
--   • Conversions
--   • Revenue
--   • Marketing efficiency
--
-- KPIs are calculated from aggregated underlying measures.
-- ============================================================

SELECT
    -- Converting each date to the first day of its month
    -- so all records from the same month are grouped together.
    DATEFROMPARTS(
        YEAR(date),
        MONTH(date),
        1
    ) AS month,

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
        SUM(clicks) * 1.0
        / NULLIF(SUM(impressions), 0)
        AS DECIMAL(10,4)
    ) AS CTR,

    -- Cost per Click
    CAST(
        SUM(ad_spend)
        / NULLIF(SUM(clicks), 0)
        AS DECIMAL(10,2)
    ) AS CPC,

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

-- Grouping all observations belonging to the same month
GROUP BY
    DATEFROMPARTS(
        YEAR(date),
        MONTH(date),
        1
    )

-- Displaying months in chronological order
ORDER BY
    month;