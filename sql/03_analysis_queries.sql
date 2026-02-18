-- =========================================================
-- 03_analysis_queries.sql
-- REPORTING QUERIES (read-only): used to generate insights
-- =========================================================

-- A) Average return + volatility per ticker
SELECT
  ticker,
  AVG(daily_return) AS avg_daily_return,
  STDDEV_SAMP(daily_return) AS volatility
FROM alien-device-410108.finance.stock_returns
WHERE daily_return IS NOT NULL
GROUP BY ticker
ORDER BY avg_daily_return DESC;

-- B) Monthly performance
SELECT
  ticker,
  DATE_TRUNC(trade_date, MONTH) AS month,
  AVG(daily_return) AS avg_monthly_return,
  SUM(volume) AS total_monthly_volume
FROM alien-device-410108.finance.stock_returns
WHERE daily_return IS NOT NULL
GROUP BY ticker, month
ORDER BY month, ticker;

-- C) Big move days (>= 3% daily move)
SELECT
  ticker,
  trade_date,
  daily_return,
  volume
FROM alien-device-410108.finance.stock_returns
WHERE ABS(daily_return) >= 0.03
ORDER BY ABS(daily_return) DESC
LIMIT 50;

-- D) Correlation between returns (wide)
SELECT
  CORR(aapl_return, msft_return) AS corr_aapl_msft,
  CORR(aapl_return, jpm_return)  AS corr_aapl_jpm,
  CORR(msft_return, jpm_return)  AS corr_msft_jpm
FROM alien-device-410108.finance.daily_returns
WHERE aapl_return IS NOT NULL
  AND msft_return IS NOT NULL
  AND jpm_return IS NOT NULL;
