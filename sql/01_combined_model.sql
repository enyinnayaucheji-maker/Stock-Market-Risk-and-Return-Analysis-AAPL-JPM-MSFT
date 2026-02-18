-- =========================================================
-- 01_combined_model.sql
-- CLEAN + COMBINED LAYER:
-- 1) Standardise each stock table into a consistent schema
-- 2) Union into a single combined fact table
-- =========================================================

-- AAPL clean
CREATE TABLE alien-device-410108.finance.aapl_clean AS
SELECT
  DATE(CAST(date AS TIMESTAMP)) AS trade_date,
  CAST(open AS FLOAT64)  AS open,
  CAST(high AS FLOAT64)  AS high,
  CAST(low  AS FLOAT64)  AS low,
  CAST(close AS FLOAT64) AS close,
  CAST(volume AS INT64)  AS volume,
  'AAPL' AS ticker
FROM alien-device-410108.finance.aapl
WHERE date IS NOT NULL;

-- MSFT clean
CREATE TABLE alien-device-410108.finance.msft_clean AS
SELECT
  DATE(CAST(date AS TIMESTAMP)) AS trade_date,
  CAST(open AS FLOAT64)  AS open,
  CAST(high AS FLOAT64)  AS high,
  CAST(low  AS FLOAT64)  AS low,
  CAST(close AS FLOAT64) AS close,
  CAST(volume AS INT64)  AS volume,
  'MSFT' AS ticker
FROM alien-device-410108.finance.msft
WHERE date IS NOT NULL;

-- JPM clean
CREATE TABLE alien-device-410108.finance.jpm_clean AS
SELECT
  DATE(CAST(date AS TIMESTAMP)) AS trade_date,
  CAST(open AS FLOAT64)  AS open,
  CAST(high AS FLOAT64)  AS high,
  CAST(low  AS FLOAT64)  AS low,
  CAST(close AS FLOAT64) AS close,
  CAST(volume AS INT64)  AS volume,
  'JPM' AS ticker
FROM alien-device-410108.finance.jpm
WHERE date IS NOT NULL;

-- Combined table (stack all tickers into one dataset)
CREATE TABLE alien-device-410108.finance.all_stocks AS
SELECT * FROM alien-device-410108.finance.aapl_clean
UNION ALL
SELECT * FROM alien-device-410108.finance.jpm_clean
UNION ALL
SELECT * FROM alien-device-410108.finance.msft_clean


-- =========================================================
-- Data-quality checks
-- =========================================================

-- Null checks on key fields
SELECT
  COUNT(*) AS total_rows,
  COUNTIF(trade_date IS NULL) AS null_trade_date,
  COUNTIF(close IS NULL) AS null_close,
  COUNTIF(volume IS NULL) AS null_volume
FROM alien-device-410108.finance.all_stocks;

-- Show any problematic rows (should return 0 rows ideally)
SELECT *
FROM alien-device-410108.finance.all_stocks
WHERE trade_date IS NULL
   OR close IS NULL
   OR volume IS NULL;

