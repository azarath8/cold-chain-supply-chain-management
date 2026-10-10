# Data Dictionary — v0.1

All seed records are fictional and intended for learning.

| Table | Purpose | Important relationships |
|---|---|---|
| `products` | Product master and illustrative handling range | One product can appear in many inventory lots and shipment items |
| `facilities` | Cold storage or distribution locations | One facility has many storage zones |
| `storage_zones` | Zones inside a facility | One zone can contain many inventory lots |
| `inventory_lots` | Product batch/lot, quantity, receipt and expiry | References a product and storage zone |
| `temperature_readings` | Timestamped measurements from a zone | References a storage zone |
| `shipments` | Movement of goods between facilities or destinations | Has many shipment items |
| `shipment_items` | Products and quantities included in a shipment | References a shipment and product |
| `temperature_incidents` | Recorded deviations requiring review | May reference a storage zone, shipment, or both |

## Design notes

- Primary keys use generated identity values.
- Foreign keys preserve relationships between operational records.
- Product temperature ranges are illustrative fields, not a substitute for approved product specifications.
- The first version records temperature readings by storage zone. A later version may add sensor identity, calibration, and shipment-level sensor telemetry.
- Shipment items are linked to products rather than specific inventory lots in v0.1. A later traceability iteration should model the actual lot quantities allocated to each shipment.
- Costing, customers, suppliers, carriers, maintenance, and corrective actions are intentionally deferred until the first schema is understood.
