-- WGU D326 Advanced Data Management
-- Database: dvdrental
-- Script: 07_validation.sql
--
-- Purpose:
-- Validate the detailed and summary reporting tables
-- after executing the Part F refresh procedure.
--
-- Prerequisite:
-- CALL pa_practice.refresh_rental_report();


-- Validation 1:
-- Verify that both reporting tables contain data.

SELECT
    (SELECT COUNT(*)
     FROM pa_practice.rental_detail) AS detail_records,

    (SELECT COUNT(*)
     FROM pa_practice.rental_summary) AS summary_records;


-- Validation 2:
-- Compare payment counts and total revenue.

SELECT
    (SELECT COUNT(*)
     FROM pa_practice.rental_detail) AS detail_payment_count,

    (SELECT SUM(total_payments)
     FROM pa_practice.rental_summary) AS summary_payment_count,

    (SELECT SUM(payment_amount)
     FROM pa_practice.rental_detail) AS detail_revenue,

    (SELECT SUM(total_revenue)
     FROM pa_practice.rental_summary) AS summary_revenue;


-- Validation 3:
-- Compare detailed and summary totals by month and category.
-- Expected result: Zero rows.

SELECT
    d.rental_month,
    d.category_name,
    COUNT(*) AS calculated_payments,
    SUM(d.payment_amount) AS calculated_revenue,
    s.total_payments AS stored_payments,
    s.total_revenue AS stored_revenue
FROM pa_practice.rental_detail AS d
INNER JOIN pa_practice.rental_summary AS s
    ON d.rental_month = s.rental_month
    AND d.category_name = s.category_name
GROUP BY
    d.rental_month,
    d.category_name,
    s.total_payments,
    s.total_revenue
HAVING
    COUNT(*) <> s.total_payments
    OR SUM(d.payment_amount) <> s.total_revenue;


-- Validation 4:
-- Display the highest-revenue film categories by month.

SELECT
    rental_month,
    category_name,
    total_payments,
    total_revenue
FROM pa_practice.rental_summary
ORDER BY total_revenue DESC
LIMIT 10;