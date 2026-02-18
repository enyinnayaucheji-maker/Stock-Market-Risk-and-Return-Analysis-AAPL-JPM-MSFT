-- =========================================================
-- 02_analytical_metrics.sql
-- ANALYTICAL LAYER:
-- 1) Returns table (per ticker)
-- 2) Joined-by-date wide table (for BI tools)
-- 3) Returns-from-joined table (wide returns)
-- =========================================================

-- 1) Returns table (long format): one row per ticker per date
CREATE TABLE alien-device-410108.finance.stock_returns AS
SELECT
  trade_date,
  ticker,
  close,
  volume,
  SAFE_DIVIDE(
    close - LAG(close) OVER (PARTITION BY ticker ORDER BY trade_date),
    LAG(close) OVER (PARTITION BY ticker ORDER BY trade_date)
  ) AS daily_return
FROM alien-device-410108.finance.all_stocks;

-- 2) Joined table by date (wide format): one row per date, 3 tickers as columns
-- Note: INNER JOIN keeps only dates that exist for all 3 stocks.

CREATE TABLE alien-device-410108.finance.stock_joined_by_date AS
SELECT
  a.trade_date,
  a.close  AS aapl_close,
  m.close  AS msft_close,
  j.close  AS jpm_close,
  a.volume AS aapl_volume,
  m.volume AS msft_volume,
  j.volume AS jpm_volume
FROM alien-device-410108.finance.aapl_clean a
JOIN alien-device-410108.finance.msft_clean m
  ON a.trade_date = m.trade_date
JOIN alien-device-410108.finance.jpm_clean j
  ON a.trade_date = j.trade_date;

-- 3) Daily returns from the joined (wide) table
-- Best for Tableau scatter plots & correlation comparisons.

CREATE TABLE alien-device-410108.finance.daily_returns AS
SELECT
  trade_date,
  SAFE_DIVIDE(aapl_close - LAG(aapl_close) OVER (ORDER BY trade_date),
              LAG(aapl_close) OVER (ORDER BY trade_date)) AS aapl_return,
  SAFE_DIVIDE(msft_close - LAG(msft_close) OVER (ORDER BY trade_date),
              LAG(msft_close) OVER (ORDER BY trade_date)) AS msft_return,
  SAFE_DIVIDE(jpm_close - LAG(jpm_close) OVER (ORDER BY trade_date),
              LAG(jpm_close) OVER (ORDER BY trade_date)) AS jpm_return
FROM alien-device-410108.finance.stock_joined_by_date;
