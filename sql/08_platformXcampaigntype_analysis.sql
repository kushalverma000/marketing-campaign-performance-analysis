-- ============================================================
--  6: PLATFORM × CAMPAIGN TYPE PERFORMANCE
-- ============================================================
--  Evaluating the performance of each combination
-- of advertising platform and campaign type.
--
-- This helps identify specific combinations that may be
-- stronger or weaker than the overall platform averages.
-- ============================================================

SELECT
    platform,
    campaign_type,

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

-- Create a group for every platform + campaign type combination
GROUP BY
    platform,
    campaign_type

-- Rank the combinations by ROAS
ORDER BY
    ROAS DESC;