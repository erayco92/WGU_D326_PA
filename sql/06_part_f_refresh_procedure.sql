-- WGU D326 Advanced Data Management
-- Database: dvdrental
-- Rubric: Part F - Stored Procedure
--
-- Purpose:
-- Refresh the detailed and summary reporting tables
-- using the original DVD rental source data.
--
-- Prerequisites:
-- 1. Schema created
-- 2. Transformation function created
-- 3. Reporting tables created
-- 4. Summary trigger created


CREATE OR REPLACE PROCEDURE pa_practice.refresh_rental_report()
LANGUAGE plpgsql
AS $$
BEGIN

    -- Step 1: Clear both reporting tables.

    TRUNCATE TABLE
        pa_practice.rental_detail,
        pa_practice.rental_summary;


    -- Step 2: Extract source data and populate detail table.

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
        ON fc.category_id = c.category_id;

    -- Step 3:
    -- The AFTER INSERT trigger automatically populates
    -- rental_summary for each inserted detail record.

END;
$$;


-- Execute the stored procedure.
-- Run this separately after creating the procedure.

-- CALL pa_practice.refresh_rental_report();