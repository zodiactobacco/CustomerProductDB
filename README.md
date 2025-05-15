# CustomerProductDB

A Microsoft SQL Server database for managing customer accounts and their TV and DSL product subscriptions. Includes scripts to create the database, populate it with mock data, and query for specific business scenarios.

## Structure
- `Scripts/Setup/Setup_Query.sql`: Creates the database and tables with mock data.
- `Scripts/Queries`: Queries for analyzing customers and products:
  - Task1.1_Query: Find customers with only active TV products.
  - Task1.2_Query: Find customers with only active DSL products.
  - Task2_Query: Identify overlapping active TV products for the same customer.
  - Task3_Query: Detect duplicate customer accounts with different products.

## Setup
1. Run `Setup_Query.sql` in SQL Server Management Studio to set up the `CustomerProductDB` database.
2. Run queries from `Scripts/Queries` to test the scenarios.

## Requirements
- Microsoft SQL Server
- SQL Server Management Studio or compatible client