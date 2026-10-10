-- Cold Chain Supply Chain Management — schema v0.1
-- PostgreSQL
-- Sample project only. Temperature ranges and records are illustrative.

BEGIN;

CREATE TABLE products (
    product_id       INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sku              VARCHAR(40) NOT NULL UNIQUE,
    product_name     VARCHAR(120) NOT NULL,
    product_category VARCHAR(60) NOT NULL,
    min_temp_c       NUMERIC(5,2),
    max_temp_c       NUMERIC(5,2),
    shelf_life_days  INTEGER CHECK (shelf_life_days IS NULL OR shelf_life_days > 0),
    active           BOOLEAN NOT NULL DEFAULT TRUE,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (
        min_temp_c IS NULL OR max_temp_c IS NULL OR min_temp_c <= max_temp_c
    )
);

CREATE TABLE facilities (
    facility_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    facility_code VARCHAR(30) NOT NULL UNIQUE,
    facility_name VARCHAR(120) NOT NULL,
    facility_type VARCHAR(40) NOT NULL,
    city          VARCHAR(80) NOT NULL,
    country_code  CHAR(2) NOT NULL,
    active        BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE storage_zones (
    zone_id       INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    facility_id   INTEGER NOT NULL REFERENCES facilities(facility_id),
    zone_code     VARCHAR(30) NOT NULL,
    zone_name     VARCHAR(100) NOT NULL,
    target_min_c  NUMERIC(5,2),
    target_max_c  NUMERIC(5,2),
    capacity_pallets INTEGER CHECK (capacity_pallets IS NULL OR capacity_pallets >= 0),
    UNIQUE (facility_id, zone_code),
    CHECK (
        target_min_c IS NULL OR target_max_c IS NULL OR target_min_c <= target_max_c
    )
);

CREATE TABLE inventory_lots (
    lot_id           INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lot_code         VARCHAR(50) NOT NULL UNIQUE,
    product_id       INTEGER NOT NULL REFERENCES products(product_id),
    zone_id          INTEGER NOT NULL REFERENCES storage_zones(zone_id),
    quantity_units   NUMERIC(12,2) NOT NULL CHECK (quantity_units >= 0),
    received_at      TIMESTAMPTZ NOT NULL,
    expiry_date      DATE,
    lot_status       VARCHAR(20) NOT NULL DEFAULT 'available'
                     CHECK (lot_status IN ('available', 'quarantined', 'depleted', 'expired')),
    CHECK (expiry_date IS NULL OR expiry_date >= received_at::date)
);

CREATE TABLE temperature_readings (
    reading_id      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    zone_id         INTEGER NOT NULL REFERENCES storage_zones(zone_id),
    recorded_at     TIMESTAMPTZ NOT NULL,
    temperature_c   NUMERIC(5,2) NOT NULL,
    sensor_code     VARCHAR(40),
    reading_source  VARCHAR(30) NOT NULL DEFAULT 'sensor'
                    CHECK (reading_source IN ('sensor', 'manual', 'imported')),
    UNIQUE (zone_id, recorded_at, sensor_code)
);

CREATE TABLE shipments (
    shipment_id       INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    shipment_code     VARCHAR(40) NOT NULL UNIQUE,
    origin_facility_id INTEGER REFERENCES facilities(facility_id),
    destination_name  VARCHAR(120) NOT NULL,
    destination_city  VARCHAR(80) NOT NULL,
    destination_country_code CHAR(2) NOT NULL,
    planned_departure TIMESTAMPTZ,
    actual_departure  TIMESTAMPTZ,
    planned_arrival   TIMESTAMPTZ,
    actual_arrival    TIMESTAMPTZ,
    shipment_status   VARCHAR(20) NOT NULL DEFAULT 'planned'
                      CHECK (shipment_status IN ('planned', 'in_transit', 'delivered', 'delayed', 'cancelled')),
    CHECK (
        actual_departure IS NULL OR planned_departure IS NULL
        OR actual_departure >= planned_departure - INTERVAL '7 days'
    )
);

CREATE TABLE shipment_items (
    shipment_item_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    shipment_id      INTEGER NOT NULL REFERENCES shipments(shipment_id) ON DELETE CASCADE,
    product_id       INTEGER NOT NULL REFERENCES products(product_id),
    quantity_units   NUMERIC(12,2) NOT NULL CHECK (quantity_units > 0),
    UNIQUE (shipment_id, product_id)
);

CREATE TABLE temperature_incidents (
    incident_id       INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    incident_code     VARCHAR(40) NOT NULL UNIQUE,
    zone_id           INTEGER REFERENCES storage_zones(zone_id),
    shipment_id       INTEGER REFERENCES shipments(shipment_id),
    detected_at       TIMESTAMPTZ NOT NULL,
    incident_type     VARCHAR(40) NOT NULL,
    observed_temp_c   NUMERIC(5,2),
    severity          VARCHAR(20) NOT NULL
                      CHECK (severity IN ('low', 'medium', 'high', 'critical')),
    incident_status   VARCHAR(20) NOT NULL DEFAULT 'open'
                      CHECK (incident_status IN ('open', 'investigating', 'resolved', 'closed')),
    description       TEXT NOT NULL,
    corrective_action TEXT,
    CHECK (zone_id IS NOT NULL OR shipment_id IS NOT NULL)
);

CREATE INDEX idx_inventory_lots_product ON inventory_lots(product_id);
CREATE INDEX idx_inventory_lots_expiry ON inventory_lots(expiry_date);
CREATE INDEX idx_temperature_readings_zone_time ON temperature_readings(zone_id, recorded_at DESC);
CREATE INDEX idx_shipments_status ON shipments(shipment_status);
CREATE INDEX idx_incidents_status_severity ON temperature_incidents(incident_status, severity);

COMMIT;
