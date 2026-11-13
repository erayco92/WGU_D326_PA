Initial schema creation reason:
I created a dedicated PostgreSQL schema named pa_practice to store my reporting tables, functions, triggers, and stored procedures separately from the original DVD rental database. This allows the reporting solution to access source data without modifying the original tables.

For Part B, I created a PostgreSQL user-defined function named format_rental_month. It accepts a rental timestamp and converts it into a year-month format. This transformed value is stored in the detailed reporting table and used to group revenue by month in the summary table.

For Part C, I created two reporting tables. The detailed table stores individual rental payment transactions, while the summary table aggregates payment counts and revenue by month and film category. The summary table uses a composite primary key to ensure each month and category combination is unique.

For Part D, I created an extraction query using six source tables from the DVD rental database. The query uses INNER JOIN operations to connect payments to rentals, inventory, films, and film categories. It also calls my user-defined function to transform each rental date into a reporting month. The resulting dataset contains the fields required for the detailed reporting table.

For Part E, I created a trigger function that automatically updates the summary table when new payment records are inserted into the detailed table. The function uses the reporting month and film category to determine whether to create a new summary record or update an existing one. This ensures the summary table reflects newly inserted payment transactions without requiring a separate aggregation query.

To validate my trigger, I first cleared the reporting tables and inserted one payment transaction into the detailed table. I then queried both reporting tables to confirm that PostgreSQL automatically created the corresponding summary record. Finally, I compared the payment counts and revenue totals to verify that the trigger produced accurate results.

For Part F, I created a stored procedure named refresh_rental_report. This procedure clears both reporting tables and extracts fresh rental payment data from the source database. As the detailed records are inserted, the trigger from Part E automatically updates the summary table. This allows the reporting data to be refreshed by executing a single CALL statement.


After executing my stored procedure, I validated the reporting tables by comparing payment counts and total revenue between the detailed and summary tables. I also used a GROUP BY and HAVING query to identify any inconsistencies between calculated and stored totals. Finally, I queried the summary table to display the highest-revenue film categories by month, demonstrating how the report answers the business question.