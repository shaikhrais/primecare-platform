-- Requires 20261011_platform_administration. Catalog seeded separately from governance.
BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-territory-allocation'));
CREATE TABLE IF NOT EXISTS platform_territory_catalog (
 id TEXT PRIMARY KEY,number INTEGER NOT NULL UNIQUE CHECK(number>0),code TEXT NOT NULL UNIQUE,name TEXT NOT NULL,
 fsas JSONB NOT NULL,seniors65 INTEGER NOT NULL CHECK(seniors65>=0),population INTEGER NOT NULL CHECK(population>=seniors65),
 is_reserve BOOLEAN NOT NULL, census_year INTEGER NOT NULL DEFAULT 2021 CHECK(census_year=2021)
);
DO $migration$
DECLARE tenant_type TEXT; actor_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type NOT IN ('uuid','text','character varying') OR actor_type NOT IN ('uuid','text','character varying') OR tenant_type IS NULL OR actor_type IS NULL THEN RAISE EXCEPTION 'Unsupported platform identity schema'; END IF;
 EXECUTE format('CREATE TABLE IF NOT EXISTS platform_territory_sales (
 territory_id TEXT PRIMARY KEY REFERENCES platform_territory_catalog(id),tenant_id %s NOT NULL REFERENCES tenants(id),
 actor_id %s NOT NULL REFERENCES users(id),services TEXT[] NOT NULL CHECK(cardinality(services) BETWEEN 1 AND 2 AND services <@ ARRAY[''psw'',''home_care'']::text[]),
 reference TEXT NOT NULL CHECK(length(reference) BETWEEN 3 AND 200),version INTEGER NOT NULL DEFAULT 1 CHECK(version=1),
 recorded_at TIMESTAMPTZ NOT NULL DEFAULT NOW())',tenant_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS platform_territory_audit (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(),actor_id %s NOT NULL REFERENCES users(id),tenant_id %s NOT NULL REFERENCES tenants(id),
 territory_id TEXT NOT NULL REFERENCES platform_territory_catalog(id),action TEXT NOT NULL CHECK(action=''territory_sold''),
 previous_state JSONB NOT NULL,current_state JSONB NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW())',actor_type,tenant_type);
END $migration$;
CREATE INDEX IF NOT EXISTS territory_sales_tenant ON platform_territory_sales(tenant_id);
COMMIT;
