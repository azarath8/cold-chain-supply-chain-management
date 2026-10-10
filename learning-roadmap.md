# Learning Roadmap

The roadmap combines cold chain management with SQL. Advance based on demonstrated competence, not just time spent.

## Stage 1 — Understand the operation

**Cold chain topics**
- What a cold chain is and why temperature control matters
- Chilled vs. frozen products
- Product-specific handling requirements
- Facility, storage zone, inventory lot, shipment, and temperature event

**SQL topics**
- Database, table, row, column
- Data types
- Primary keys and foreign keys
- `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`

**Evidence of learning**
- Explain the journey of a lot from receiving to dispatch.
- Write a query to list products and another to find lots approaching expiry.

## Stage 2 — Connect the records

**Cold chain topics**
- Inventory traceability
- Storage locations
- Shipment contents
- Temperature history

**SQL topics**
- `INNER JOIN` and `LEFT JOIN`
- Join keys and relationship cardinality
- `NULL` and missing records

**Evidence of learning**
- Trace a shipment to its products and lots.
- Find lots that have no recent temperature readings.

## Stage 3 — Measure operations

**Cold chain topics**
- Inventory ageing and expiry exposure
- Temperature excursions
- Shipment status
- Operational KPIs and their limitations

**SQL topics**
- `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- `GROUP BY` and `HAVING`
- `CASE WHEN`
- Date/time filters and grouping

**Evidence of learning**
- Summarize temperature readings by storage zone.
- Count incidents by type and severity.
- Explain why an average temperature alone can hide excursions.

## Stage 4 — Improve data reliability

**Cold chain topics**
- Traceability gaps
- Sensor coverage and calibration records
- Incident documentation and corrective actions

**SQL topics**
- `NOT NULL`, `UNIQUE`, `CHECK`, foreign keys
- Data-quality queries
- Views and common table expressions (CTEs)
- Transactions and safe updates

**Evidence of learning**
- Identify missing or suspicious data.
- Explain which data-quality rules are enforced by the schema and which require process controls.

## Stage 5 — Add economics and decisions

**Cold chain topics**
- Storage and transport cost drivers
- Capacity utilization
- Spoilage and service-level trade-offs
- CAPEX vs. OPEX

**SQL topics**
- Multi-table aggregation
- CTEs and window functions
- Reusable views
- Exporting query results for analysis

**Evidence of learning**
- Define each KPI precisely.
- Document assumptions before calculating cost or loss.
- Explain a decision and its risks using the evidence.

## Stage 6 — Integrate

- Add a documented, realistic case study.
- Validate sample data and query results.
- Add Python only when it solves a clear analytical problem.
- Publish a final report with assumptions, limitations, and recommendations.

## Definition of done for each topic

A topic is not complete merely because notes exist. Complete it when you can:
1. Explain it without copying a definition.
2. Apply it to a small example.
3. Write or interpret the relevant SQL.
4. Check whether the output makes sense.
5. State the business implication and limitations.
