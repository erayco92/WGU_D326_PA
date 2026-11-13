-- WGU D326 Advanced Data Management
-- Database: dvdrental
-- Rubric: Part E - Trigger to Maintain Summary Table
--
-- Purpose:
-- Automatically update the rental_summary table whenever
-- a new payment record is inserted into rental_detail.
--
-- Prerequisite: Run 02_part_c_tables.sql first.


-- Part 1: Create the trigger function.

CREATE OR REPLACE FUNCTION pa_practice.update_rental_summary()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO pa_practice.rental_summary (
        rental_month,
        category_name,
        total_payments,
        total_revenue
    )
    VALUES (
        NEW.rental_month,
        NEW.category_name,
        1,
        NEW.payment_amount
    )
    ON CONFLICT (rental_month, category_name)
    DO UPDATE SET
        total_payments = rental_summary.total_payments + 1,
        total_revenue = rental_summary.total_revenue
                        + EXCLUDED.total_revenue;

    RETURN NEW;
END;
$$;


-- Part 2: Create the trigger on the detailed table.

DROP TRIGGER IF EXISTS trg_update_rental_summary
ON pa_practice.rental_detail;

CREATE TRIGGER trg_update_rental_summary
AFTER INSERT ON pa_practice.rental_detail
FOR EACH ROW
EXECUTE FUNCTION pa_practice.update_rental_summary();