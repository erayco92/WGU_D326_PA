-- WGU D326 Advanced Data Management
-- Database: dvdrental
-- Rubric: Part C - Create Detailed and Summary Tables
--
-- Purpose:
-- Create two reporting tables:
-- 1. rental_detail: Individual payment transactions.
-- 2. rental_summary: Monthly revenue aggregated by film category.
--
-- Prerequisite: Execute 00_create_schema.sql first.


-- Detailed Reporting Table
CREATE TABLE IF NOT EXISTS pa_practice.rental_detail (
    payment_id INTEGER PRIMARY KEY,
    rental_id INTEGER,
    rental_date TIMESTAMP,
    rental_month TEXT,
    film_title VARCHAR(255),
    category_name VARCHAR(25),
    rental_rate NUMERIC(4,2),
    payment_amount NUMERIC(5,2)
);


-- Summary Reporting Table
CREATE TABLE IF NOT EXISTS pa_practice.rental_summary (
    rental_month TEXT NOT NULL,
    category_name VARCHAR(25) NOT NULL,
    total_payments INTEGER NOT NULL DEFAULT 0,
    total_revenue NUMERIC(12,2) NOT NULL DEFAULT 0,
    PRIMARY KEY (rental_month, category_name)
);


-- Validation:
-- Confirm both tables exist in the reporting schema.

SELECT
    table_schema,
    table_name
FROM information_schema.tables
WHERE table_schema = 'pa_practice'
ORDER BY table_name;