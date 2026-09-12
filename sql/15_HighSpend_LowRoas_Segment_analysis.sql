-- ============================================================
-- 13: HIGH-SPEND, LOW-ROAS SEGMENTS
-- ============================================================
-- Identifying Platform × Campaign Type × Industry
-- combinations that:
--
--   1. Have ROAS below the overall marketing benchmark of 4.88
--   2. Have advertising spend above the average spend
--      across all 60 segments
--
-- These segments are potential optimization candidates.
-- ============================================================

WITH segment_performance AS
(
    SELECT
        platform,
        campaign_type,
        industry,

        -- Total advertising spend for the segment
        SUM(ad_spend) AS total_ad_spend,

        -- Total conversions
        SUM(conversions) AS total_conversions,

        -- Total revenue
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
        
        -- Calculating the average advertising spend
        -- across all 60 segments.
        AVG(total_ad_spend) OVER () AS avg_segment_spend

    FROM segment_performance
)

SELECT
    platform,
    campaign_type,
    industry,

    -- Segment advertising spend
    CAST(total_ad_spend AS DECIMAL(12,2)) AS total_ad_spend,

    -- Segment conversions
    total_conversions,

    -- Segment revenue
    CAST(total_revenue AS DECIMAL(14,2)) AS total_revenue,

    -- Segment ROAS
    CAST(ROAS AS DECIMAL(10,2)) AS ROAS,

    -- Average spend benchmark
    CAST(avg_segment_spend AS DECIMAL(12,2)) AS avg_segment_spend

FROM segment_benchmark

-- Identifying segments with below-benchmark ROAS
-- and above-average advertising spend
WHERE ROAS < 4.88
  AND total_ad_spend > avg_segment_spend

-- Show the least efficient segments first
ORDER BY
    ROAS ASC;