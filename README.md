# Cold Chain Supply Chain Management

**Version:** 0.1 — SQL learning foundation  
**Status:** Learning project / prototype  
**Primary goal:** Learn cold chain operations and SQL together by building a small, realistic operational database.

## Project mission

Build an evidence-based learning and analysis system for cold chain management. This repository starts with a relational database for tracking products, facilities, inventory lots, temperature readings, shipments, and temperature incidents.

The project will grow through the sequence:

**Learn → Model → Query → Analyze → Validate → Improve**

This is a learning prototype, not a production food-safety or logistics system. Sample records are fictional. Temperature limits in the sample data are illustrative only; always use product-, process-, and jurisdiction-specific requirements in real operations.

## Why SQL first?

Cold chain operations generate connected records: what product was stored, in which facility, in which lot, at what time, and under what temperature conditions. SQL helps us connect those records and answer operational questions.

We will learn SQL by asking business questions—not by memorizing syntax alone.

## Initial scope (v0.1)

- Product master data
- Facilities and storage zones
- Inventory lots and expiry dates
- Temperature readings
- Shipments and shipment line items
- Temperature incidents
- Beginner-to-intermediate SQL analysis queries

## Repository map

```text
cold-chain-supply-chain-management/
├── README.md
├── docs/
│   ├── learning-roadmap.md
│   ├── data-dictionary.md
│   └── business-questions.md
└── sql/
    ├── 01_schema.sql
    ├── 02_seed_data.sql
    └── 03_analysis_queries.sql
```

## Database choice

This starter uses **PostgreSQL**. It is a good long-term choice for relational data, constraints, joins, aggregation, and analytical queries. SQL concepts transfer to other database engines, though some syntax differs.

## Getting started

1. Install PostgreSQL and a SQL client such as pgAdmin, or use another PostgreSQL-compatible environment.
2. Create a database named `cold_chain`.
3. Open `sql/01_schema.sql` and execute it against that database.
4. Execute `sql/02_seed_data.sql`.
5. Run queries from `sql/03_analysis_queries.sql` one at a time.
6. For every query, write down: **business question → SQL logic → result → operational implication**.

If you are using `psql`, a typical flow is:

```sql
CREATE DATABASE cold_chain;
```

Connect to `cold_chain`, then run the schema and seed scripts. Exact commands depend on how PostgreSQL is installed.

## First learning target

By the end of the first iteration, you should be able to explain and use:

- Tables, rows, columns, primary keys, and foreign keys
- `SELECT`, `WHERE`, `ORDER BY`, and `LIMIT`
- `JOIN`
- `GROUP BY` and aggregate functions
- `CASE WHEN`
- Date/time filtering
- Why database constraints and data quality matter

## Working rules

- Do not treat fictional sample data as real industry evidence.
- Record assumptions and sources when adding real-world claims.
- Do not hard-code a universal safe temperature for all products.
- Prefer explicit column names over `SELECT *` in analysis queries.
- Validate query outputs against the business question.
- Never store confidential company, customer, or personal data in this public repository.

## Roadmap

See [`docs/learning-roadmap.md`](docs/learning-roadmap.md) and [`docs/business-questions.md`](docs/business-questions.md).

## Version plan

- **v0.1:** Core schema, fictional data, first SQL queries
- **v0.2:** Data-quality checks, more realistic product-specific requirements, and incident workflow
- **v0.3:** Cost and unit-economics tables
- **v0.4:** Supplier, carrier, and service-level performance
- **v0.5:** Python analysis and repeatable reporting
- **v1.0:** Integrated cold-chain case study and documented business recommendations
