-- ============================================================
--  12: AD SPEND VS. BUSINESS OUTCOMES
-- ============================================================
--  comparing monthly advertising spend with:
--   • Total conversions
--   • Total revenue
--   • ROAS
--
-- The purpose is to understand whether higher spending
-- corresponds with stronger business outcomes and whether
-- efficiency changes as spending increases.
-- ============================================================

SELECT
    -- Representing each month using its first day
    DATEFROMPARTS(
        YEAR(date),
        MONTH(date),
        1
    ) AS month,

    -- Total advertising spend
    SUM(ad_spend) AS total_ad_spend,

    -- Total conversions generated
    SUM(conversions) AS total_conversions,

    -- Total revenue generated
    SUM(revenue) AS total_revenue,

    -- Revenue generated per unit of advertising spend
    CAST(
        SUM(revenue)
        / NULLIF(SUM(ad_spend), 0)
        AS DECIMAL(10,2)
    ) AS ROAS,

    -- Cost required to generate one conversion
    CAST(
        SUM(ad_spend)
        / NULLIF(SUM(conversions), 0)
        AS DECIMAL(12,2)
    ) AS CPA

FROM dbo.global_ads_performance

-- Aggregating the measures by month
GROUP BY
    DATEFROMPARTS(
        YEAR(date),
        MONTH(date),
        1
    )

-- Displaying months chronologically
ORDER BY
    month;