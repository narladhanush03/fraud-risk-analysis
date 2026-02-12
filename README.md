# Financial Transaction Fraud Detection & Risk Assessment (Python + PostgreSQL)

## Project Overview

This project simulates a forensic investigation of financial transactions to identify fraud patterns, detect internal control weaknesses, and design a rule-based risk scoring framework.

Using Python for exploratory analysis and PostgreSQL for forensic SQL investigation, the project evaluates fraud concentration, transaction risk behavior, and model effectiveness through structured risk segmentation.

---

## Objectives

- Analyze fraud distribution across 6M+ transactions
- Identify high-risk transaction categories
- Test internal control weaknesses (balance validation, threshold behavior, rapid transfers)
- Design and validate a rule-based fraud risk scoring framework
- Evaluate fraud capture effectiveness

---

## Tools & Technologies

- Python (Pandas, NumPy, Matplotlib)
- PostgreSQL
- SQL (Aggregation, Window Functions, Risk Scoring Logic)
- Jupyter Notebook

---

## Dataset

- Source: Kaggle – PaySim Synthetic Financial Dataset
- Records: ~6.3 million transactions
- Key Fields:
  - Transaction Type
  - Transaction Amount
  - Origin & Destination Balances
  - Fraud Indicator (isFraud)
  - Time Step

---

## Key Business Insights

### 1. Fraud Concentration by Transaction Type
Fraud exposure is heavily concentrated in specific transaction categories (TRANSFER and CASH_OUT), indicating that risk is not uniformly distributed.

### 2. Low Overall Fraud Incidence
Overall fraud rate is below 1%, reflecting realistic financial systems where fraud is rare but high-impact.

### 3. Control Weakness Indicators
Balance reconciliation mismatches show elevated fraud probability, suggesting potential breakdown in transaction validation controls.

### 4. Behavioral Risk Signals
Rapid sequential transactions and threshold-based clustering were tested to simulate potential control circumvention patterns.

### 5. Risk Scoring Effectiveness
A rule-based risk scoring framework was developed to segment transactions into Low, Medium, and High-risk categories. Fraud concentration within higher-risk buckets validates structured risk-based monitoring.

---

## Risk Management Recommendations

### 1. Implement Risk-Based Monitoring
Deploy automated monitoring for High-risk transactions to prioritize investigation efforts.

### 2. Strengthen Balance Validation Controls
Enhance reconciliation logic to detect inconsistencies between pre- and post-transaction balances.

### 3. Increase Monitoring of High-Risk Transaction Types
Apply enhanced review mechanisms for TRANSFER and CASH_OUT transactions where fraud exposure is highest.

### 4. Deploy Threshold Alert Mechanisms
Introduce alerts for transactions clustering near approval limits to prevent potential control circumvention.

### 5. Operationalize Risk Scoring Framework
Integrate rule-based scoring into transaction monitoring systems to improve fraud detection efficiency.

---

## Risk Model Performance

- Total Transactions Analyzed: 6M+
- Overall Fraud Rate: <1%
- Risk Segmentation: Low / Medium / High
- Fraud Capture Rate (High-Risk Bucket): XX% (update with your result)

The model demonstrates measurable fraud concentration within higher-risk segments, supporting its effectiveness as a monitoring framework.

---



