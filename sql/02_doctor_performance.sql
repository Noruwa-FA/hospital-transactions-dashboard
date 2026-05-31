-- ============================================================
-- Hospital Transactions - Doctor Performance Analysis
-- Author: Success Noruwa
-- ============================================================

-- 1. Revenue by doctor
SELECT 
    DoctorID,
    Doctors_FirstName || ' ' || Doctors_LastName AS doctor_name,
    Doctor_Gender,
    Specialty,
    COUNT(TransactionID) AS total_transactions,
    SUM(RevenueAmount) AS total_revenue,
    SUM(ExpensesAmount) AS total_expenses,
    SUM(RevenueAmount) - SUM(ExpensesAmount) AS net_income
FROM hospital_transactions
GROUP BY DoctorID, Doctors_FirstName, Doctors_LastName, Doctor_Gender, Specialty
ORDER BY total_revenue DESC;

-- 2. Top 10 highest revenue generating doctors
SELECT 
    Doctors_FirstName || ' ' || Doctors_LastName AS doctor_name,
    Specialty,
    SUM(RevenueAmount) AS total_revenue,
    COUNT(TransactionID) AS patient_visits
FROM hospital_transactions
GROUP BY DoctorID, Doctors_FirstName, Doctors_LastName, Specialty
ORDER BY total_revenue DESC
LIMIT 10;

-- 3. Revenue by doctor gender
SELECT 
    Doctor_Gender,
    COUNT(DISTINCT DoctorID) AS total_doctors,
    COUNT(TransactionID) AS total_transactions,
    SUM(RevenueAmount) AS total_revenue,
    ROUND(AVG(RevenueAmount), 2) AS avg_revenue_per_transaction
FROM hospital_transactions
GROUP BY Doctor_Gender
ORDER BY total_revenue DESC;
