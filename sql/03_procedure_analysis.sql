-- ============================================================
-- Hospital Transactions - Procedure & Category Analysis
-- Author: Success Noruwa
-- ============================================================

-- 1. Revenue by procedure
SELECT 
    ProcedureID,
    ProcedureName,
    Category,
    COUNT(TransactionID) AS times_performed,
    SUM(RevenueAmount) AS total_revenue,
    SUM(ExpensesAmount) AS total_expenses,
    ROUND(AVG(RevenueAmount), 2) AS avg_revenue_per_procedure,
    ROUND(
        (SUM(ExpensesAmount)::DECIMAL / NULLIF(SUM(RevenueAmount), 0)) * 100, 2
    ) AS cost_ratio_pct
FROM hospital_transactions
GROUP BY ProcedureID, ProcedureName, Category
ORDER BY total_revenue DESC;

-- 2. Revenue by procedure category
SELECT 
    Category,
    COUNT(TransactionID) AS total_procedures,
    SUM(RevenueAmount) AS total_revenue,
    SUM(ExpensesAmount) AS total_expenses,
    SUM(RevenueAmount) - SUM(ExpensesAmount) AS net_income
FROM hospital_transactions
GROUP BY Category
ORDER BY total_revenue DESC;

-- 3. High cost procedures (cost ratio above 70%)
SELECT 
    ProcedureName,
    Category,
    SUM(RevenueAmount) AS total_revenue,
    SUM(ExpensesAmount) AS total_cost,
    ROUND(
        (SUM(ExpensesAmount)::DECIMAL / NULLIF(SUM(RevenueAmount), 0)) * 100, 2
    ) AS cost_ratio_pct,
    CASE
        WHEN (SUM(ExpensesAmount)::DECIMAL / NULLIF(SUM(RevenueAmount), 0)) > 0.75 THEN 'High Cost - Review Needed'
        WHEN (SUM(ExpensesAmount)::DECIMAL / NULLIF(SUM(RevenueAmount), 0)) > 0.60 THEN 'Moderate Cost'
        ELSE 'Efficient'
    END AS cost_efficiency
FROM hospital_transactions
GROUP BY ProcedureName, Category
ORDER BY cost_ratio_pct DESC;
