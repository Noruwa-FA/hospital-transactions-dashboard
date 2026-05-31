-- ============================================================
-- Hospital Transactions - Patient Demographics & Location
-- Author: Success Noruwa
-- ============================================================

-- 1. Revenue by patient gender
SELECT 
    Patients_Gender,
    COUNT(DISTINCT PatientID) AS unique_patients,
    COUNT(TransactionID) AS total_visits,
    SUM(RevenueAmount) AS total_revenue,
    ROUND(AVG(RevenueAmount), 2) AS avg_revenue_per_visit
FROM hospital_transactions
GROUP BY Patients_Gender
ORDER BY total_revenue DESC;

-- 2. Revenue by location (state)
SELECT 
    Country,
    State,
    City,
    COUNT(TransactionID) AS total_transactions,
    SUM(RevenueAmount) AS total_revenue,
    ROUND(AVG(RevenueAmount), 2) AS avg_revenue
FROM hospital_transactions
GROUP BY Country, State, City
ORDER BY total_revenue DESC;

-- 3. Monthly revenue trend
SELECT 
    DATE_TRUNC('month', TO_DATE(Date, 'MM/DD/YYYY')) AS month,
    COUNT(TransactionID) AS total_transactions,
    SUM(RevenueAmount) AS monthly_revenue,
    SUM(ExpensesAmount) AS monthly_expenses,
    SUM(RevenueAmount) - SUM(ExpensesAmount) AS monthly_net_income
FROM hospital_transactions
GROUP BY DATE_TRUNC('month', TO_DATE(Date, 'MM/DD/YYYY'))
ORDER BY month;

-- 4. Yearly revenue summary
SELECT 
    EXTRACT(YEAR FROM TO_DATE(Date, 'MM/DD/YYYY')) AS year,
    COUNT(TransactionID) AS total_transactions,
    SUM(RevenueAmount) AS total_revenue,
    SUM(ExpensesAmount) AS total_expenses,
    SUM(RevenueAmount) - SUM(ExpensesAmount) AS net_income
FROM hospital_transactions
GROUP BY EXTRACT(YEAR FROM TO_DATE(Date, 'MM/DD/YYYY'))
ORDER BY year;
