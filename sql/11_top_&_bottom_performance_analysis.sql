-- ============================================================
-- 9: TOP AND BOTTOM PERFORMANCE SEGMENTS
-- ============================================================
-- Ranking all Platform × Campaign Type × Industry
-- combinations by ROAS using the ROW_NUMBER() window function.
--
-- Will use the ranking to identify the 10 strongest and
-- 10 weakest marketing segments.
-- ============================================================

WITH segment_performance AS
(
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

    -- Create one row for each 3-dimensional segment
    GROUP BY
        platform,
        campaign_type,
        industry
),

ranked_segments AS
(
    SELECT
        *,
        
        -- Rank segments from highest to lowest ROAS
        ROW_NUMBER() OVER (
            ORDER BY ROAS DESC
        ) AS roas_rank

    FROM segment_performance
)

-- Return the top 10 and bottom 10 segments
SELECT
    roas_rank,
    platform,
    campaign_type,
    industry,
    total_ad_spend,
    total_conversions,
    total_revenue,
    CVR,
    CPA,
    ROAS
FROM ranked_segments

WHERE roas_rank <= 10
   OR roas_rank > 50

ORDER BY roas_rank;