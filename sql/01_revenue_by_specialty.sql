-- ============================================================
-- Hospital Transactions Revenue & Performance Analysis
-- Author: Success Noruwa
-- Tool: PostgreSQL
-- Dataset: hospital_transactions (flat denormalised table)
-- Columns: TransactionID, Date, RevenueAmount, ExpensesAmount,
--          Doctors_FirstName, Doctors_LastName, Doctor_Gender,
--          Specialty, DoctorID, PatientID, Patients_FirstName,
--          Patients_LastName, Patients_Gender, ProcedureID,
--          ProcedureName, Category, Country, City, State
-- ============================================================

-- ============================================================
-- SECTION 1: REVENUE BY SPECIALTY
-- ============================================================

-- 1. Total revenue, expenses and net income by specialty
SELECT 
    Specialty,
    SUM(RevenueAmount) AS total_revenue,
    SUM(ExpensesAmount) AS total_expenses,
    SUM(RevenueAmount) - SUM(ExpensesAmount) AS net_income,
    ROUND(
        (SUM(ExpensesAmount)::DECIMAL / NULLIF(SUM(RevenueAmount), 0)) * 100, 2
    ) AS cost_to_revenue_pct
FROM hospital_transactions
GROUP BY Specialty
ORDER BY total_revenue DESC;

-- 2. Average revenue per transaction by specialty
SELECT 
    Specialty,
    COUNT(TransactionID) AS total_transactions,
    ROUND(AVG(RevenueAmount), 2) AS avg_revenue,
    ROUND(AVG(ExpensesAmount), 2) AS avg_expenses,
    ROUND(AVG(RevenueAmount) - AVG(ExpensesAmount), 2) AS avg_net_income
FROM hospital_transactions
GROUP BY Specialty
ORDER BY avg_revenue DESC;
