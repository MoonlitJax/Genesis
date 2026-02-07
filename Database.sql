CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE IF NOT EXISTS vehicle_tracks (
    id SERIAL PRIMARY KEY,
    license_plate VARCHAR(20),
    latitude DECIMAL,
    longitude DECIMAL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    geom geometry(Point, 4326)
);

-- Index for God's Eye speed
CREATE INDEX IF NOT EXISTS idx_vehicle_geom ON vehicle_tracks USING GIST(geom);
