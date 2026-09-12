-- ============================================================
-- 14: QUANTIFY HIGH-SPEND, LOW-ROAS SEGMENT IMPACT
-- ============================================================
-- Measuring the total business impact of the
-- high-spend, low-ROAS segments identified in Step 13.
--
-- It calculates:
--   • Total spend in qualifying segments
--   • Total conversions
--   • Total revenue
--   • Share of overall spend
--   • Share of overall conversions
--   • Share of overall revenue
-- ============================================================

WITH segment_performance AS
(
    SELECT
        platform,
        campaign_type,
        industry,

        -- Aggregating advertising spend
        SUM(ad_spend) AS total_ad_spend,

        -- Aggregating conversions
        SUM(conversions) AS total_conversions,

        -- Aggregating revenue
        SUM(revenue) AS total_revenue,

        -- Calculating segment-level ROAS
        SUM(revenue) / NULLIF(SUM(ad_spend), 0) AS ROAS

    FROM dbo.global_ads_performance

    -- Creating one row for each platform × campaign type × industry
    GROUP BY
        platform,
        campaign_type,
        industry
),

qualifying_segments AS
(
    SELECT
        *
    FROM segment_performance

    -- Identifying segments meeting both optimization conditions
    WHERE ROAS < 4.88
      AND total_ad_spend > (
          SELECT AVG(total_ad_spend)
          FROM segment_performance
      )
),

overall_totals AS
(
    SELECT
        -- Overall advertising spend
        SUM(ad_spend) AS overall_spend,

        -- Overall conversions
        SUM(conversions) AS overall_conversions,

        -- Overall revenue
        SUM(revenue) AS overall_revenue

    FROM dbo.global_ads_performance
)

SELECT
    -- Total spend in qualifying segments
    CAST(
        SUM(q.total_ad_spend)
        AS DECIMAL(14,2)
    ) AS qualifying_spend,

    -- Total conversions from qualifying segments
    SUM(q.total_conversions) AS qualifying_conversions,

    -- Total revenue from qualifying segments
    CAST(
        SUM(q.total_revenue)
        AS DECIMAL(14,2)
    ) AS qualifying_revenue,

    -- Percentage of overall advertising spend
    CAST(
        SUM(q.total_ad_spend) * 100.0
        / MAX(o.overall_spend)
        AS DECIMAL(10,2)
    ) AS spend_share_pct,

    -- Percentage of overall conversions
    CAST(
        SUM(q.total_conversions) * 100.0
        / MAX(o.overall_conversions)
        AS DECIMAL(10,2)
    ) AS conversion_share_pct,

    -- Percentage of overall revenue
    CAST(
        SUM(q.total_revenue) * 100.0
        / MAX(o.overall_revenue)
        AS DECIMAL(10,2)
    ) AS revenue_share_pct

FROM qualifying_segments AS q

-- Adding the single overall-total row to the calculation
CROSS JOIN overall_totals AS o;