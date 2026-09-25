# Agribusiness Data Modeling & SQL

A relational database project developed as part of the **SQL Data Analyst – Agribusiness Internship** under the **Henry Harvin Yuva Intern Program**.

## Project Overview

This project focuses on designing a relational database model for agribusiness operations and developing SQL queries to support common business and analytical needs.

The database represents different areas of an agribusiness operation, including:

* Farm management
* Crop production
* Agricultural inputs
* Production costs
* Sales
* Markets and buyers
* Seasons and production years
* Business performance analysis

The database was developed using **MySQL** with primary and foreign keys to establish relationships between the tables.

## Database Model

The database contains 11 related tables:

| Table         | Purpose                                        |
| ------------- | ---------------------------------------------- |
| `location`    | Stores state and district information          |
| `farm`        | Stores farm information                        |
| `crop`        | Stores crop details and crop types             |
| `season`      | Stores agricultural seasons                    |
| `production`  | Records crop production activities             |
| `input`       | Stores agricultural input information          |
| `input_usage` | Records inputs used for production             |
| `cost`        | Records production-related expenses            |
| `market`      | Stores selling market information              |
| `buyer`       | Stores buyer information                       |
| `sale`        | Records sales, quantities, prices, and revenue |

The `production` table acts as a central table for connecting farms, crops, seasons, inputs, costs, and sales.

## SQL Analysis

Six business-focused SQL queries were developed to analyze:

1. Total production by crop
2. Total production by farm
3. Total production by year
4. Total cost by production record
5. Total input usage cost
6. Total sales revenue by market

The queries use SQL joins, aggregate functions, grouping, and ordering to answer common agribusiness business questions.

## Testing and Optimization

The SQL queries were tested in **MySQL Workbench**.

The `explain` command was also used to examine the execution plan of a sample query and verify how the database accessed the related tables.

## Entity Relationship Diagram

The project includes an ER diagram showing the tables, primary keys, foreign keys, and relationships within the database.

## Project Files

```text
sql/
    week2_agribusiness.sql

er-diagram/
    agribusiness_er_diagram.png

report/
    Week_2_Project_Report.docx
```

## Tools Used

* MySQL
* MySQL Workbench
* SQL
* diagrams.net (draw.io)
* Google Docs

## Internship

**Program:** Yuva Intern Program
**Organization:** Henry Harvin
**Internship:** SQL Data Analyst – Agribusiness
**Project:** Week 2 – Data Modeling and SQL Query Development

**Prepared by:** Yashika
**September 2026**

