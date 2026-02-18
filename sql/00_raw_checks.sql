-- =========================================================
-- 00_raw_checks.sql
-- RAW LAYER: Inspect imported CSV tables
-- Dataset: alien-device-410108.finance
-- Tables: aapl, msft, jpm
-- =========================================================

-- Sample AAPL
SELECT *
FROM alien-device-410108.finance.aapl
LIMIT 1000;

-- Sample MSFT
SELECT *
FROM alien-device-410108.finance.msft
LIMIT 1000;

-- Sample JPM
SELECT *
FROM alien-device-410108.finance.jpm
LIMIT 1000;
