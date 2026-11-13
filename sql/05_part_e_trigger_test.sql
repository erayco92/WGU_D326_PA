-- WGU D326 Advanced Data Management
-- Database: dvdrental
-- Rubric: Part E - Trigger Validation
--
-- Purpose:
-- Insert one payment into the detailed reporting table
-- and verify that the trigger automatically updates
-- the summary reporting table.
--
-- Prerequisites:
-- 1. Reporting tables exist.
-- 2. Trigger function and trigger have been created.
--
-- Note:
-- Run this test before executing the Part F refresh procedure.
-- This script resets only the reporting tables, not source data.


-- Step 1: Clear existing reporting data.

TRUNCATE TABLE
    pa_practice.rental_detail,
    pa_practice.rental_summary;


-- Step 2: Insert one payment from the source database.

INSERT INTO pa_practice.rental_detail (
    payment_id,
    rental_id,
    rental_date,
    rental_month,
    film_title,
    category_name,
    rental_rate,
    payment_amount
)
SELECT
    p.payment_id,
    r.rental_id,
    r.rental_date,
    pa_practice.format_rental_month(r.rental_date),
    f.title,
    c.name,
    f.rental_rate,
    p.amount
FROM public.payment AS p
INNER JOIN public.rental AS r
    ON p.rental_id = r.rental_id
INNER JOIN public.inventory AS i
    ON r.inventory_id = i.inventory_id
INNER JOIN public.film AS f
    ON i.film_id = f.film_id
INNER JOIN public.film_category AS fc
    ON f.film_id = fc.film_id
INNER JOIN public.category AS c
    ON fc.category_id = c.category_id
ORDER BY p.payment_id
LIMIT 1;


-- Step 3: Verify the inserted detailed record.

SELECT *
FROM pa_practice.rental_detail;


-- Step 4: Verify the trigger updated the summary table.

SELECT *
FROM pa_practice.rental_summary;


-- Step 5: Compare payment counts and revenue totals.

SELECT
    (SELECT COUNT(*)
     FROM pa_practice.rental_detail) AS detail_count,

    (SELECT COUNT(*)
     FROM pa_practice.rental_summary) AS summary_count,

    (SELECT SUM(payment_amount)
     FROM pa_practice.rental_detail) AS detail_revenue,

    (SELECT SUM(total_revenue)
     FROM pa_practice.rental_summary) AS summary_revenue;