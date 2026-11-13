-- WGU D326 Advanced Data Management
-- Database: dvdrental
-- Rubric: Part B - User-Defined Function
--
-- Purpose:
-- Convert a rental timestamp into a YYYY-MM reporting month.
-- This transformation allows rental revenue to be grouped
-- consistently by month in the summary report.

CREATE OR REPLACE FUNCTION pa_practice.format_rental_month(
    input_date TIMESTAMP
)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN TO_CHAR(input_date, 'YYYY-MM');
END;
$$;


-- Validation:
-- Test the function against existing rental records.

SELECT
    rental_date,
    pa_practice.format_rental_month(rental_date) AS rental_month
FROM public.rental
LIMIT 10;