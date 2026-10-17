BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-growth-marketing'));
DO $migration$
DECLARE tenant_type TEXT; actor_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type NOT IN ('uuid','text','character varying') OR actor_type NOT IN ('uuid','text','character varying') OR tenant_type IS NULL OR actor_type IS NULL THEN RAISE EXCEPTION 'Unsupported growth identity schema'; END IF;
 EXECUTE format('CREATE TABLE IF NOT EXISTS growth_campaign_capacity(id UUID PRIMARY KEY,tenant_id %s NOT NULL,campaign_id UUID NOT NULL,actor_id %s NOT NULL REFERENCES users(id),brief_version INTEGER NOT NULL CHECK(brief_version>0),version INTEGER NOT NULL CHECK(version>0),client_slots INTEGER NOT NULL CHECK(client_slots BETWEEN 0 AND 1000),expires_at TIMESTAMPTZ NOT NULL,evidence TEXT NOT NULL CHECK(length(evidence) BETWEEN 1 AND 500),created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),UNIQUE(tenant_id,campaign_id,version),FOREIGN KEY(tenant_id,campaign_id) REFERENCES growth_campaign_briefs(tenant_id,campaign_id))',tenant_type,actor_type);
END $migration$;
CREATE INDEX IF NOT EXISTS growth_capacity_latest ON growth_campaign_capacity(tenant_id,campaign_id,version DESC);
CREATE OR REPLACE FUNCTION growth_capacity_immutable() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'Capacity history is immutable'; END $$;
DROP TRIGGER IF EXISTS growth_capacity_no_mutation ON growth_campaign_capacity;
CREATE TRIGGER growth_capacity_no_mutation BEFORE UPDATE OR DELETE ON growth_campaign_capacity FOR EACH ROW EXECUTE FUNCTION growth_capacity_immutable();
COMMIT;
