-- Cold Chain Supply Chain Management — analysis queries v0.1
-- Run each query separately and explain the business meaning of the output.

-- Q1. List active products.
SELECT sku, product_name, product_category, min_temp_c, max_temp_c
FROM products
WHERE active = TRUE
ORDER BY product_category, product_name;


-- Q2. Find inventory lots expiring within the next 30 days.
-- CURRENT_DATE makes the query relative to the date it is executed.
SELECT
    l.lot_code,
    p.product_name,
    l.quantity_units,
    l.expiry_date,
    l.expiry_date - CURRENT_DATE AS days_until_expiry
FROM inventory_lots AS l
JOIN products AS p ON p.product_id = l.product_id
WHERE l.lot_status = 'available'
  AND l.expiry_date BETWEEN CURRENT_DATE AND CURRENT_DATE + 30
ORDER BY l.expiry_date;


-- Q3. Count shipments by status.
SELECT shipment_status, COUNT(*) AS shipment_count
FROM shipments
GROUP BY shipment_status
ORDER BY shipment_count DESC;


-- Q4. Summarize temperature readings by zone.
-- Important: averages do not show the duration or severity of excursions.
SELECT
    z.zone_code,
    z.zone_name,
    COUNT(tr.reading_id) AS reading_count,
    MIN(tr.temperature_c) AS minimum_temp_c,
    ROUND(AVG(tr.temperature_c), 2) AS average_temp_c,
    MAX(tr.temperature_c) AS maximum_temp_c
FROM storage_zones AS z
LEFT JOIN temperature_readings AS tr ON tr.zone_id = z.zone_id
GROUP BY z.zone_id, z.zone_code, z.zone_name
ORDER BY z.zone_code;


-- Q5. Find readings outside the zone's target range.
-- This checks the zone target, not a complete product-safety determination.
SELECT
    z.zone_code,
    tr.recorded_at,
    tr.temperature_c,
    z.target_min_c,
    z.target_max_c,
    CASE
        WHEN tr.temperature_c < z.target_min_c THEN 'below_target'
        WHEN tr.temperature_c > z.target_max_c THEN 'above_target'
        ELSE 'within_target'
    END AS target_check
FROM temperature_readings AS tr
JOIN storage_zones AS z ON z.zone_id = tr.zone_id
WHERE tr.temperature_c < z.target_min_c
   OR tr.temperature_c > z.target_max_c
ORDER BY tr.recorded_at;


-- Q6. Show shipment contents.
SELECT
    s.shipment_code,
    s.shipment_status,
    s.destination_city,
    p.sku,
    p.product_name,
    si.quantity_units
FROM shipments AS s
JOIN shipment_items AS si ON si.shipment_id = s.shipment_id
JOIN products AS p ON p.product_id = si.product_id
ORDER BY s.shipment_code, p.product_name;


-- Q7. List open or investigating incidents, highest severity first.
SELECT
    incident_code,
    detected_at,
    incident_type,
    observed_temp_c,
    severity,
    incident_status,
    description
FROM temperature_incidents
WHERE incident_status IN ('open', 'investigating')
ORDER BY
    CASE severity
        WHEN 'critical' THEN 1
        WHEN 'high' THEN 2
        WHEN 'medium' THEN 3
        WHEN 'low' THEN 4
    END,
    detected_at;


-- Q8. Inventory quantity by product and storage zone.
SELECT
    p.product_name,
    z.zone_code,
    SUM(l.quantity_units) AS total_quantity_units
FROM inventory_lots AS l
JOIN products AS p ON p.product_id = l.product_id
JOIN storage_zones AS z ON z.zone_id = l.zone_id
WHERE l.lot_status = 'available'
GROUP BY p.product_name, z.zone_code
ORDER BY p.product_name, z.zone_code;


-- Reflection challenge:
-- Which zones have no readings? Why might this be an important monitoring gap?
SELECT
    z.zone_code,
    z.zone_name
FROM storage_zones AS z
LEFT JOIN temperature_readings AS tr ON tr.zone_id = z.zone_id
WHERE tr.reading_id IS NULL;
