-- Fictional seed data for learning only.
-- Execute after 01_schema.sql.

BEGIN;

INSERT INTO products
    (sku, product_name, product_category, min_temp_c, max_temp_c, shelf_life_days)
VALUES
    ('FROZ-001', 'Frozen Mixed Vegetables', 'frozen_food', -25.00, -18.00, 365),
    ('CHIL-001', 'Fresh Pasteurized Milk', 'dairy', 0.00, 4.00, 14),
    ('PROD-001', 'Fresh Strawberries', 'produce', 0.00, 4.00, 7),
    ('SEA-001', 'Frozen White Fish Fillet', 'seafood', -25.00, -18.00, 270);

INSERT INTO facilities
    (facility_code, facility_name, facility_type, city, country_code)
VALUES
    ('FAC-NB-01', 'Ningbo Learning Cold Store', 'cold_storage', 'Ningbo', 'CN'),
    ('FAC-SH-01', 'Shanghai Learning Distribution Hub', 'distribution_hub', 'Shanghai', 'CN');

INSERT INTO storage_zones
    (facility_id, zone_code, zone_name, target_min_c, target_max_c, capacity_pallets)
VALUES
    (1, 'FROZEN-A', 'Frozen Zone A', -25.00, -18.00, 500),
    (1, 'CHILLED-A', 'Chilled Zone A', 0.00, 4.00, 220),
    (2, 'FROZEN-B', 'Frozen Zone B', -25.00, -18.00, 350);

INSERT INTO inventory_lots
    (lot_code, product_id, zone_id, quantity_units, received_at, expiry_date, lot_status)
VALUES
    ('LOT-FR-1001', 1, 1, 1200, '2026-10-01 08:00:00+08', '2027-09-30', 'available'),
    ('LOT-DA-2001', 2, 2, 320,  '2026-10-05 09:00:00+08', '2026-10-18', 'available'),
    ('LOT-PR-3001', 3, 2, 180,  '2026-10-08 10:00:00+08', '2026-10-15', 'available'),
    ('LOT-SE-4001', 4, 3, 700,  '2026-10-02 07:30:00+08', '2027-06-29', 'available');

INSERT INTO temperature_readings
    (zone_id, recorded_at, temperature_c, sensor_code, reading_source)
VALUES
    (1, '2026-10-09 08:00:00+08', -20.40, 'SNS-FR-01', 'sensor'),
    (1, '2026-10-09 09:00:00+08', -19.80, 'SNS-FR-01', 'sensor'),
    (1, '2026-10-09 10:00:00+08', -16.50, 'SNS-FR-01', 'sensor'),
    (2, '2026-10-09 08:00:00+08', 2.10, 'SNS-CH-01', 'sensor'),
    (2, '2026-10-09 09:00:00+08', 3.20, 'SNS-CH-01', 'sensor'),
    (2, '2026-10-09 10:00:00+08', 5.30, 'SNS-CH-01', 'sensor'),
    (3, '2026-10-09 08:00:00+08', -21.20, 'SNS-FR-02', 'sensor'),
    (3, '2026-10-09 09:00:00+08', -20.70, 'SNS-FR-02', 'sensor');

INSERT INTO shipments
    (shipment_code, origin_facility_id, destination_name, destination_city,
     destination_country_code, planned_departure, planned_arrival, shipment_status)
VALUES
    ('SHP-2026-001', 1, 'Retail Distribution Center A', 'Shanghai', 'CN',
     '2026-10-10 08:00:00+08', '2026-10-10 14:00:00+08', 'planned'),
    ('SHP-2026-002', 2, 'Retail Distribution Center B', 'Suzhou', 'CN',
     '2026-10-09 07:00:00+08', '2026-10-09 12:00:00+08', 'in_transit'),
    ('SHP-2026-003', 1, 'Food Service Customer C', 'Hangzhou', 'CN',
     '2026-10-08 06:00:00+08', '2026-10-08 10:00:00+08',
     'delivered');

INSERT INTO shipment_items (shipment_id, product_id, quantity_units)
VALUES
    (1, 1, 250),
    (1, 4, 100),
    (2, 2, 80),
    (3, 3, 60);

INSERT INTO temperature_incidents
    (incident_code, zone_id, shipment_id, detected_at, incident_type,
     observed_temp_c, severity, incident_status, description)
VALUES
    ('INC-2026-001', 1, NULL, '2026-10-09 10:05:00+08', 'high_temperature',
     -16.50, 'high', 'investigating',
     'Illustrative reading above the frozen zone target range. Product impact has not been established.'),
    ('INC-2026-002', 2, NULL, '2026-10-09 10:05:00+08', 'high_temperature',
     5.30, 'medium', 'open',
     'Illustrative reading above the chilled zone target range. Requires review and documented disposition.');

COMMIT;
