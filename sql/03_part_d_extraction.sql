-- WGU D326 Advanced Data Management
-- Database: dvdrental
-- Rubric: Part D - Raw Data Extraction
--
-- Business Report:
-- DVD Rental Revenue by Film Category and Month
--
-- Purpose:
-- Extract individual rental payment transactions from
-- six source tables using INNER JOIN operations.
--
-- The output matches the columns in rental_detail.
-- This query will later be reused in the Part F
-- stored procedure to populate the reporting table.


SELECT
    p.payment_id,
    r.rental_id,
    r.rental_date,
    pa_practice.format_rental_month(r.rental_date) AS rental_month,
    f.title AS film_title,
    c.name AS category_name,
    f.rental_rate,
    p.amount AS payment_amount
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
ORDER BY p.payment_id;