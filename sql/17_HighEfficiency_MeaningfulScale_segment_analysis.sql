-- ============================================================
-- 15: HIGH-EFFICIENCY, MEANINGFUL-SCALE SEGMENTS
-- ============================================================
--  Identifying segments that:
--
--   1. Have ROAS above the overall benchmark of 4.88
--   2. Have advertising spend above the average spend
--      across all 60 segments
--
-- These segments represent potential areas for increased
-- attention or budget allocation.
-- ============================================================

WITH segment_performance AS
(
    SELECT
        platform,
        campaign_type,
        industry,

        -- Total advertising spend for the segment
        SUM(ad_spend) AS total_ad_spend,

        -- Total conversions generated
        SUM(conversions) AS total_conversions,

        -- Total revenue generated
        SUM(revenue) AS total_revenue,

        -- Calculating ROAS from underlying measures
        SUM(revenue) / NULLIF(SUM(ad_spend), 0) AS ROAS

    FROM dbo.global_ads_performance

    -- Creating one row for each platform × campaign type × industry
    GROUP BY
        platform,
        campaign_type,
        industry
),

segment_benchmark AS
(
    SELECT
        *,

        -- Calculating the average spend across all 60 segments
        AVG(total_ad_spend) OVER () AS avg_segment_spend

    FROM segment_performance
)

SELECT
    platform,
    campaign_type,
    industry,

    -- Segment advertising spend
    CAST(
        total_ad_spend
        AS DECIMAL(12,2)
    ) AS total_ad_spend,

    -- Segment conversions
    total_conversions,

    -- Segment revenue
    CAST(
        total_revenue
        AS DECIMAL(14,2)
    ) AS total_revenue,

    -- Segment ROAS
    CAST(
        ROAS
        AS DECIMAL(10,2)
    ) AS ROAS,

    -- Average spend benchmark
    CAST(
        avg_segment_spend
        AS DECIMAL(12,2)
    ) AS avg_segment_spend

FROM segment_benchmark

-- Keeping only segments with both:
-- above-benchmark ROAS and above-average spend
WHERE ROAS > 4.88
  AND total_ad_spend > avg_segment_spend

-- Ranking the strongest opportunities first
ORDER BY
    ROAS DESC;