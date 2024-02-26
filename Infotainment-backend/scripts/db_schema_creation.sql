
-- delete existing tables
-- drop table vehicle_state cascade;

-- crete new tables
CREATE TABLE vehicle_state (
	vehicle_id VARCHAR(16) PRIMARY KEY NOT NULL,
    dpf_warning BOOLEAN NOT NULL,
    battery_level NUMERIC(5, 2) NOT NULL,
    rpm NUMERIC(6, 2) NOT NULL,
    velocity NUMERIC(6, 2) NOT NULL,
	created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  	updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- add fixtures
