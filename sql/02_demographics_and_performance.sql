-- ============================================================
-- Hospital Transactions - Patient & Doctor Demographics
-- Author: Success Noruwa
-- Description: Patient demographics, gender analysis,
-- and doctor performance metrics
-- ============================================================

-- 1. Revenue breakdown by patient gender
SELECT 
    pt.patients_gender,
    COUNT(t.transaction_id) AS total_transactions,
    SUM(t.revenue_amount) AS total_revenue,
    ROUND(AVG(t.revenue_amount), 2) AS avg_revenue_per_visit
FROM transactions t
JOIN patients pt ON t.patient_id = pt.patient_id
GROUP BY pt.patients_gender
ORDER BY total_revenue DESC;

-- 2. Top 10 highest-revenue doctors
SELECT 
    d.doctors_firstname || ' ' || d.doctors_lastname AS doctor_name,
    d.specialty,
    d.doctor_gender,
    SUM(t.revenue_amount) AS total_revenue,
    COUNT(t.transaction_id) AS patient_visits
FROM transactions t
JOIN doctors d ON t.doctor_id = d.doctor_id
GROUP BY d.doctor_id, d.doctors_firstname, d.doctors_lastname, d.specialty, d.doctor_gender
ORDER BY total_revenue DESC
LIMIT 10;

-- 3. Monthly revenue trend
SELECT 
    DATE_TRUNC('month', t.date) AS month,
    SUM(t.revenue_amount) AS monthly_revenue,
    SUM(t.expenses_amount) AS monthly_expenses,
    SUM(t.revenue_amount) - SUM(t.expenses_amount) AS monthly_net_income,
    COUNT(t.transaction_id) AS total_transactions
FROM transactions t
GROUP BY DATE_TRUNC('month', t.date)
ORDER BY month;

-- 4. High-cost procedures vs revenue (cost-to-revenue ratio)
SELECT 
    p.procedure_name,
    p.category,
    SUM(t.revenue_amount) AS total_revenue,
    SUM(t.expenses_amount) AS total_cost,
    ROUND(
        (SUM(t.expenses_amount) / NULLIF(SUM(t.revenue_amount), 0)) * 100, 2
    ) AS cost_ratio_pct,
    CASE
        WHEN (SUM(t.expenses_amount) / NULLIF(SUM(t.revenue_amount), 0)) > 0.8 THEN 'High Cost - Review Needed'
        WHEN (SUM(t.expenses_amount) / NULLIF(SUM(t.revenue_amount), 0)) > 0.6 THEN 'Moderate Cost'
        ELSE 'Efficient'
    END AS cost_efficiency
FROM transactions t
JOIN procedures p ON t.procedure_id = p.procedure_id
GROUP BY p.procedure_name, p.category
ORDER BY cost_ratio_pct DESC;
