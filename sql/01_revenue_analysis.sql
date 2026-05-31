-- ============================================================
-- Hospital Transactions - SQL Analysis
-- Author: Success Noruwa
-- Description: Revenue and performance extraction from
-- hospital transaction data using PostgreSQL
-- ============================================================

-- 1. Total revenue and expenses by specialty
SELECT 
    d.specialty,
    SUM(t.revenue_amount) AS total_revenue,
    SUM(t.expenses_amount) AS total_expenses,
    SUM(t.revenue_amount) - SUM(t.expenses_amount) AS net_income,
    ROUND(
        (SUM(t.expenses_amount) / NULLIF(SUM(t.revenue_amount), 0)) * 100, 2
    ) AS cost_to_revenue_pct
FROM transactions t
JOIN doctors d ON t.doctor_id = d.doctor_id
GROUP BY d.specialty
ORDER BY total_revenue DESC;

-- 2. Revenue by doctor with specialty
SELECT 
    d.doctors_firstname || ' ' || d.doctors_lastname AS doctor_name,
    d.specialty,
    COUNT(t.transaction_id) AS total_transactions,
    SUM(t.revenue_amount) AS total_revenue,
    SUM(t.expenses_amount) AS total_expenses,
    SUM(t.revenue_amount) - SUM(t.expenses_amount) AS net_income
FROM transactions t
JOIN doctors d ON t.doctor_id = d.doctor_id
GROUP BY d.doctor_id, d.doctors_firstname, d.doctors_lastname, d.specialty
ORDER BY total_revenue DESC;

-- 3. Revenue and expenses by procedure category
SELECT 
    p.category,
    p.procedure_name,
    COUNT(t.transaction_id) AS times_performed,
    SUM(t.revenue_amount) AS total_revenue,
    SUM(t.expenses_amount) AS total_expenses,
    ROUND(AVG(t.revenue_amount), 2) AS avg_revenue_per_procedure
FROM transactions t
JOIN procedures p ON t.procedure_id = p.procedure_id
GROUP BY p.category, p.procedure_name
ORDER BY total_revenue DESC;

-- 4. Revenue by location (country, state, city)
SELECT 
    l.country,
    l.state,
    l.city,
    SUM(t.revenue_amount) AS total_revenue,
    COUNT(t.transaction_id) AS total_transactions
FROM transactions t
JOIN locations l ON t.location_id = l.location_id
GROUP BY l.country, l.state, l.city
ORDER BY total_revenue DESC;
