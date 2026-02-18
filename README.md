## Dashboard Preview

### Full Dashboard
![Dashboard](images/dashboard.png)

# Stock-Market-Risk-and-Return-Analysis-AAPL-JPM-MSFT (SQL + BigQuery + Tableau)
## Overview
This project analyzes historical stock market trading data to understand how different stocks behave over time in terms of returns, volatility, and relationships with one another. The goal is to move beyond basic price charts and extract practical insights about risk and diversification.

Stocks analyzed:
- AAPL (Apple)
- MSFT (Microsoft)
- JPM (JPMorgan Chase)

## Data Source
The dataset was sourced from https://stooq.com/ and downloaded locally as:
- `aapl_us_d.csv`
- `msft_us_d.csv`
- `jpm_us_d.csv`

## Workflow
1. **SQL (BigQuery)**
   - Validation checks (missing dates, symbol consistency, ordering)
   - Standardization and cleaning
   - Combined time-series model across AAPL, MSFT, JPM
   - Derived metrics (Daily Returns, supporting aggregates)

2. **Tableau**
   - Pivot transformation for cross-asset comparison
   - Rolling 30-day volatility computed as a Tableau table calculation to remain dynamic under filters
   - Interactive time aggregation (Daily / Monthly / Yearly)
   - Dashboard design and interpretation

## Analytical Approach
Following data preparation, structured analysis was performed across:
- Price trend over time
- Rolling volatility behaviour
- Distribution of daily returns
- Correlation relationships (AAPL vs MSFT)
- Trading volume patterns

## Key Findings (Summary)
- All stocks show long-term upward movement, especially post-2020.
- Volatility increases during uncertain market periods; JPM shows sharper spikes.
- Daily returns cluster around zero with occasional extreme values.
- AAPL and MSFT show strong positive correlation (often move together).
- Trading activity for AAPL, MSFT, and JPM increases during volatile periods.

## Recommendations
- Limit overexposure to both AAPL and MSFT simultaneously due to high correlation.
- Include JPM alongside technology holdings to improve diversification.
- Monitor rolling volatility spikes as early risk signals.
- Focus on longer-term volatility trends rather than single-day moves.
- Account for occasional extreme return events when assessing risk.

## Repository Contents
- `/data/raw` — Original CSV datasets from Stooq
- `/sql` — BigQuery SQL scripts (raw checks → combined model → metrics → reporting queries)
- `/tableau/dashboard_screenshots` — Dashboard and supporting visuals
- `/docs` — Project report

## Dashboard
- Tableau Public link: **[![View on Tableau Public](https://public.tableau.com/views/StockRiskReturnAnalysisDashboard/StockRiskReturnAnalysisDashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)**

## How to Reproduce (High Level)
1. Upload the CSVs in `/data/raw` to BigQuery.
2. Run the SQL scripts in `/sql` in order:
   - `00_raw_checks.sql`
   - `01_combined_model.sql`
   - `02_analytical_metrics.sql`
   - `03_analysis_queries.sql`
3. Connect Tableau to the final analytical table/view.
4. Build visuals and dashboard using the screenshots as reference.

## Tools
- SQL
- Google BigQuery
- Tableau
