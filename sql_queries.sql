CREATE TABLE transactions (
    step INT,
    type TEXT,
    amount NUMERIC,
    nameOrig TEXT,
    oldbalanceOrg NUMERIC,
    newbalanceOrig NUMERIC,
    nameDest TEXT,
    oldbalanceDest NUMERIC,
    newbalanceDest NUMERIC,
    isFraud INT,
    isFlaggedFraud INT
);


select*from transactions
limit 5

--Fraud Distribution
SELECT 
    isFraud,
    COUNT(*) AS transaction_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 4) AS percentage
FROM transactions
GROUP BY isFraud
ORDER BY isFraud DESC;


--Fraud by Type
SELECT 
    type,
    COUNT(*) AS total_txns,
    SUM(isFraud) AS fraud_cases,
    ROUND(SUM(isFraud) * 100.0 / COUNT(*), 4) AS fraud_rate_percent
FROM transactions
GROUP BY type
ORDER BY fraud_rate_percent DESC;


--Control Weakness Test (Balance Check)
SELECT 
    COUNT(*) AS mismatch_transactions,
    SUM(isFraud) AS fraud_cases,
    ROUND(SUM(isFraud) * 100.0 / COUNT(*), 4) AS fraud_rate_percent
FROM transactions
WHERE oldbalanceorg - amount <> newbalanceorig;


--High-Risk Account Detection
SELECT 
    nameorig,
    COUNT(*) AS total_txns,
    SUM(isFraud) AS fraud_cases,
    ROUND(SUM(isFraud) * 100.0 / COUNT(*), 4) AS fraud_rate_percent
FROM transactions
GROUP BY nameorig
HAVING SUM(isFraud) > 0
ORDER BY fraud_cases DESC
LIMIT 10;


--Rapid Sequential Transactions (Window Function)
SELECT *
FROM (
    SELECT *,
           step - LAG(step) OVER (PARTITION BY nameorig ORDER BY step) AS time_diff
    FROM transactions
) t
WHERE time_diff <= 1;


--Risk Scoring Framework
CREATE OR REPLACE VIEW transactions_scored AS
SELECT *,
    (
        CASE 
            WHEN type IN ('TRANSFER','CASH_OUT') THEN 2 ELSE 0 
        END
        +
        CASE 
            WHEN amount > 200000 THEN 1 ELSE 0 
        END
        +
        CASE 
            WHEN oldbalanceorg - amount <> newbalanceorig THEN 2 ELSE 0 
        END
    ) AS risk_score
FROM transactions;


--Categorizing Risk Levels
CREATE OR REPLACE VIEW transactions_risk_bucket AS
SELECT *,
    CASE 
        WHEN risk_score <= 1 THEN 'Low'
        WHEN risk_score BETWEEN 2 AND 3 THEN 'Medium'
        ELSE 'High'
    END AS risk_level
FROM transactions_scored;


--Validating Model
SELECT 
    risk_level,
    COUNT(*) AS total_txns,
    SUM(isFraud) AS fraud_cases,
    ROUND(SUM(isFraud) * 100.0 / COUNT(*), 4) AS fraud_rate_percent
FROM transactions_risk_bucket
GROUP BY risk_level
ORDER BY fraud_rate_percent DESC;


--Fraud Capture Rate (KPI)
SELECT 
    ROUND(
        SUM(CASE WHEN risk_level = 'High' AND isFraud = 1 THEN 1 ELSE 0 END)
        * 100.0 /
        SUM(CASE WHEN isFraud = 1 THEN 1 ELSE 0 END),
    4) AS fraud_capture_rate_percent
FROM transactions_risk_bucket;




		











