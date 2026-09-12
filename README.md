# Marketing Campaign Performance Analysis

An end-to-end marketing analytics project analyzing digital advertising performance across platforms, campaign types, industries, countries, and time periods.

## Project Objective

The objective of this project is to analyze digital advertising campaign performance and identify opportunities to improve marketing efficiency, conversion performance, and return on advertising spend.

The analysis focuses on identifying high-performing segments, inefficient spending, meaningful performance patterns, and potential opportunities for better marketing budget allocation.

## Business Questions

- Which advertising platforms perform best?
- Which campaign types generate the strongest returns?
- Which industries and countries demonstrate stronger efficiency?
- Where is advertising spending potentially inefficient?
- Which platform, campaign type, and industry combinations perform best?
- How does campaign efficiency change over time?
- Which segments should be prioritized for optimization or controlled scaling?

## Dataset

The project uses the **Global Digital Advertising Performance Dataset**.

The prepared dataset contains:

- 1,800 observations
- 14 columns
- 3 advertising platforms
- 4 campaign types
- 5 industries
- 7 countries
- Advertising performance data covering 2024

The dataset contains impressions, clicks, advertising spend, conversions, revenue, and pre-existing KPI fields including CTR, CPC, CPA, and ROAS.

## Tools & Technologies

- **Python / Jupyter Notebook** — data inventory and data preparation
- **SQL Server** — analytical queries and KPI calculations
- **Power BI** — data modeling, interactive dashboards, and visualization

## Project Workflow

```text
Raw Dataset
     ↓
Data Inventory Audit
     ↓
Python Data Preparation
     ↓
SQL Server Analysis
     ↓
Power BI Data Modeling
     ↓
Interactive Dashboard
```

Data Preparation

The preparation process included:

Data type validation and transformation
Date conversion to datetime
Validation of existing KPI calculations
Business-rule validation
Categorical consistency checks
Statistical outlier assessment
Date continuity assessment
Final dataset validation

No valid business observations were removed because of statistical outlier status alone.

The final prepared dataset contains 1,800 records and 14 columns.

Key KPIs
KPI	Definition
CTR	Clicks ÷ Impressions
CPC	Ad Spend ÷ Clicks
CVR	Conversions ÷ Clicks
CPA	Ad Spend ÷ Conversions
ROAS	Revenue ÷ Ad Spend

The overall ROAS benchmark established by the analysis is 4.88.

Key Findings
Platform Performance
TikTok Ads is the strongest platform from an efficiency perspective, with 7.62 ROAS and 21.67 CPA.
Google Ads generates the greatest scale in conversions and revenue but has weaker efficiency, with 3.47 ROAS and 48.43 CPA.
Meta Ads falls between the two platforms with 5.66 ROAS.
Campaign Type
Search is the strongest campaign type overall with 5.31 ROAS.
Shopping records the lowest campaign-type ROAS at 4.58.
Video has the lowest campaign-type CVR at 4.38%.
Industry
SaaS is the strongest industry overall with 5.04 ROAS and the highest industry-level revenue.
Fintech records the weakest industry-level ROAS at 4.48.
Healthcare has the highest conversion rate, but higher acquisition costs limit its overall return.
Country
India has the strongest overall efficiency with 5.50 ROAS.
Australia demonstrates strong engagement and conversion performance.
The USA has the highest advertising spend but weaker overall ROAS.
Detailed Segment Performance

The strongest detailed segment is:

TikTok Ads + Search + E-commerce

ROAS: 10.70
CPA: 19.02
CVR: 5.01%
Revenue: 1.49M
Conversions: 7,320

Nine of the ten highest-ROAS detailed segments are TikTok combinations.

The weakest detailed segment is:

Google Ads + Shopping + Healthcare

ROAS: 2.66
CPA: 53.10

All ten bottom-ranked detailed segments are Google combinations.

Optimization Findings

A high-spend, low-ROAS exposure was identified using:

ROAS below the overall benchmark of 4.88
Segment spend above the average segment spend of 185,145.82

This group represents:

6.35M advertising spend
57.16% of total spend
40.11% of total conversions
40.67% of total revenue

This should be treated as an optimization exposure, not automatically as wasted spend.

Only one segment combined above-benchmark ROAS with above-average spend:

TikTok Ads + Shopping + SaaS

Spend: 202,750.89
Revenue: 1.66M
Conversions: 9,923
ROAS: 8.18
Strategic Recommendations
Prioritize efficient TikTok segments through controlled scaling tests.
Review Google Ads at the segment level rather than eliminating the platform broadly.
Maintain Search as an important component of the marketing mix.
Investigate the weaker conversion performance of Video campaigns.
Give greater attention to high-efficiency markets such as India and strong TikTok markets such as Australia.
Review high-spend, below-benchmark segments through optimization and testing rather than automatic budget cuts.
Use ROAS, CPA, CVR, revenue, conversions, and current spend together when making allocation decisions.
Power BI Dashboard

The Power BI dashboard contains four pages:

1. Executive Overview

Provides the overall marketing performance view, including KPI cards, monthly spend versus revenue, and platform performance.

2. Campaign & Segment Performance

Examines campaign-type efficiency, industry revenue contribution, platform × campaign type performance, and spend versus ROAS.

3. Trends & Geography

Shows monthly ROAS trends and country × platform efficiency, with interactive platform, campaign type, and date filters.

4. Optimization Opportunities

Highlights high-spend / low-ROAS exposure, the overall ROAS benchmark, priority optimization segments, and high-efficiency scaling opportunities.

Repository Structure
marketing-campaign-performance-analysis/
│
├── README.md
├── data/
│   └── global_ads_performance_prepared.csv
│
├── notebooks/
│   ├── 01_Data_Inventory.ipynb
│   └── 02_Data_Preparation.ipynb
│
├── sql/
│   └── SQL analysis scripts
│
├── powerbi/
│   └── Marketing_Campaign_Performance.pbix
│
├── documentation/
│   ├── 01_Business_Understanding.docx
│   ├── 02_Data_Inventory.docx
│   ├── 03_Data_Preparation.docx
│   └── 04_Analysis_and_Insights.docx
│
└── screenshots/
    ├── 01_Executive_Overview.png
    ├── 02_Campaign_Segment_Performance.png
    ├── 03_Trends_Geography.png
    └── 04_Optimization_Opportunities.png
Limitations

The analysis describes observed performance patterns and does not establish causal relationships.

The dataset cannot establish that:

TikTok caused higher ROAS
Google caused lower performance
Increasing advertising spend will necessarily improve efficiency
Historical performance will automatically continue at higher budgets

Major budget changes should therefore be validated using controlled experiments and additional business context.

Conclusion

The analysis shows a clear distinction between marketing scale and marketing efficiency.

TikTok Ads demonstrates the strongest and most persistent efficiency, while Google Ads provides greater scale with weaker efficiency. Search is the strongest campaign type overall, SaaS is the strongest industry, and India is the strongest country by overall return.

The analysis supports protecting high-performing segments, selectively testing scaling opportunities, reviewing high-spend/low-return segments, and allocating budget using both efficiency and business scale.

