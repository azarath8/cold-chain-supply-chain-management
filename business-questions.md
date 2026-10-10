# Business Questions for SQL Practice

Start with the question, then write the query. Do not copy a query without being able to explain it.

## Beginner
1. What products are tracked?
2. Which inventory lots expire within the next 30 days?
3. Which shipments are still in transit?
4. What temperature readings were recorded for a given storage zone?

## Intermediate
5. What is the average, minimum, and maximum recorded temperature by storage zone?
6. Which readings fall outside the illustrative product range? Why is matching a zone reading to a product requirement not straightforward in the current schema?
7. How many shipments are there per status?
8. Which products appear most frequently in shipment items?
9. Which storage zones have no readings in the sample period?

## Analytical thinking
10. Why can an average temperature hide a serious excursion?
11. What additional fields would be required to estimate product loss after an excursion?
12. What is the difference between a recorded incident and a confirmed product-quality failure?
13. Which KPIs can be computed from the current schema, and which cannot?
14. What changes are needed to trace a specific lot through a specific shipment?

## Required answer format

For each question, document:
- **Business question**
- **Metric definition**
- **SQL query**
- **Result**
- **Interpretation**
- **Limitations / assumptions**
- **Potential operational action**
