# WGU D326: Panopto Recording Guide

**Course:** Advanced Data Management (D326)  
**Database:** PostgreSQL 13.3, `dvdrental`  
**Reporting Schema:** `pa_practice`  
**Business Report:** DVD Rental Revenue by Film Category and Month

---

## 1. Recording Objective

Demonstrate the SQL components developed for the D326 Performance Assessment, including:

- A user-defined transformation function
- Detailed and summary reporting tables
- A six-table data extraction query
- A trigger that automatically updates summary data
- A stored procedure that refreshes the reporting tables
- Validation queries confirming reporting accuracy

## 2. Pre-Recording Checklist

- [ ] Open WGU Labs on Demand.
- [ ] Launch pgAdmin and connect to `dvdrental`.
- [ ] Open the GitHub repository `WGU_D326_PA`.
- [ ] Verify the `pa_practice` schema exists.
- [ ] Confirm all SQL scripts are available.
- [ ] Test the trigger and stored procedure before recording.
- [ ] Confirm Panopto is recording the required screen, webcam, and microphone.

## 3. SQL Demonstration Order

| Order | SQL Script | Purpose |
|---|---|---|
| 1 | `00_create_schema.sql` | Create the reporting schema |
| 2 | `01_part_b_function.sql` | Create and test the transformation function |
| 3 | `02_part_c_tables.sql` | Create detailed and summary tables |
| 4 | `03_part_d_extraction.sql` | Demonstrate source data extraction |
| 5 | `04_part_e_trigger.sql` | Create the summary maintenance trigger |
| 6 | `05_part_e_trigger_test.sql` | Demonstrate automatic summary updates |
| 7 | `06_part_f_refresh_procedure.sql` | Create and execute the refresh procedure |
| 8 | `07_validation.sql` | Verify report accuracy |

## 4. Part B: User-Defined Function

**Script:** `sql/01_part_b_function.sql`

**Demonstration:** Execute the function creation statement, then run the validation query.

**Narration:**

"I created a PostgreSQL user-defined function named `format_rental_month`. It converts rental timestamps into a year-month format, allowing the reporting data to be grouped consistently by month."

**Expected result:** Rental timestamps are transformed into values such as `2005-07`.

## 5. Part C: Reporting Tables

**Script:** `sql/02_part_c_tables.sql`

**Demonstration:** Create the detailed and summary tables, then verify their existence.

**Narration:**

"The detailed reporting table stores individual payment transactions, including film titles, categories, rental dates, and payment amounts. The summary table aggregates payment counts and total revenue by reporting month and film category."

## 6. Part D: Raw Data Extraction

**Script:** `sql/03_part_d_extraction.sql`

**Demonstration:** Execute the extraction query and display the resulting payment records.

**Narration:**

"This query joins six source tables to retrieve the data required for the business report. It also calls the user-defined function to transform each rental date into a reporting month."

**Validation:** Confirm the query returns individual payment transactions with the correct film categories.

## 7. Part E: Trigger Demonstration

**Scripts:**
- `sql/04_part_e_trigger.sql`
- `sql/05_part_e_trigger_test.sql`

**Demonstration:**

1. Create the trigger function and trigger.
2. Clear the reporting tables.
3. Insert one payment into the detailed table.
4. Query the summary table.
5. Compare payment counts and revenue.

**Narration:**

"The trigger executes automatically whenever a payment is inserted into the detailed reporting table. It updates the corresponding month and category in the summary table without requiring a separate manual aggregation query."

**Expected results:**

| Detail Count | Summary Count | Revenue Comparison |
|---|---|---|
| 1 | 1 | Matching amounts |

## 8. Part F: Stored Procedure

**Script:** `sql/06_part_f_refresh_procedure.sql`

**Demonstration:** Create the stored procedure and execute:

```sql
CALL pa_practice.refresh_rental_report();
```

**Narration:**

"The stored procedure clears both reporting tables and reloads the detailed payment data from the original source tables. The trigger automatically rebuilds the summary table during the insertion process."

## 9. Reporting Validation

**Script:** `sql/07_validation.sql`

**Demonstration:**

- Compare detailed and summary payment counts.
- Compare total revenue across both tables.
- Identify discrepancies using `GROUP BY` and `HAVING`.
- Display the highest-revenue month and category combinations.

**Narration:**

"I validated the reporting data by comparing payment counts and total revenue between the detailed and summary tables. I also checked for inconsistencies between calculated and stored totals."

**Expected result:** Matching payment counts, matching revenue totals, and no discrepancies in the grouped comparison.

## 10. Part F1: Refresh Scheduling

**Recommended tool:** pgAgent

**Narration:**

"PostgreSQL's pgAgent scheduling tool could automate execution of the refresh procedure. For this report, a monthly refresh schedule would provide updated revenue data without requiring manual execution."

## 11. Final Recording Checklist

- [ ] Demonstrated the user-defined function.
- [ ] Demonstrated both reporting tables.
- [ ] Executed the extraction query.
- [ ] Demonstrated automatic trigger behavior.
- [ ] Executed the stored procedure.
- [ ] Validated payment counts and revenue totals.
- [ ] Explained the scheduling approach.
- [ ] Confirmed the Panopto recording meets WGU submission requirements.

---

**Recording status:** Draft. Complete database validation before recording the final demonstration.