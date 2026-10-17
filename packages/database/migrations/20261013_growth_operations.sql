BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-growth-marketing'));
DO $migration$
DECLARE tenant_type TEXT; actor_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type NOT IN ('uuid','text','character varying') OR actor_type NOT IN ('uuid','text','character varying') OR tenant_type IS NULL OR actor_type IS NULL THEN RAISE EXCEPTION 'Unsupported growth identity schema'; END IF;
 ALTER TABLE growth_leads ADD COLUMN IF NOT EXISTS contact_blocked BOOLEAN NOT NULL DEFAULT FALSE;
 EXECUTE format('CREATE TABLE IF NOT EXISTS growth_team(tenant_id %s NOT NULL REFERENCES tenants(id),member_id %s NOT NULL REFERENCES users(id),specialty TEXT NOT NULL,version INTEGER NOT NULL DEFAULT 1 CHECK(version>0),PRIMARY KEY(tenant_id,member_id))',tenant_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS growth_calls(id UUID PRIMARY KEY,tenant_id %s NOT NULL,lead_id UUID NOT NULL,actor_id %s NOT NULL REFERENCES users(id),outcome TEXT NOT NULL CHECK(outcome IN (''no_answer'',''contacted'',''qualified'',''callback_requested'',''wrong_number'',''do_not_contact'')),notes TEXT NOT NULL CHECK(length(notes) BETWEEN 1 AND 500),recorded_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),FOREIGN KEY(tenant_id,lead_id) REFERENCES growth_leads(tenant_id,id))',tenant_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS growth_appointments(id UUID PRIMARY KEY,tenant_id %s NOT NULL,lead_id UUID NOT NULL,owner_id %s NOT NULL REFERENCES users(id),starts_at TIMESTAMPTZ NOT NULL,ends_at TIMESTAMPTZ NOT NULL,status TEXT NOT NULL DEFAULT ''scheduled'' CHECK(status IN (''scheduled'',''completed'',''cancelled'',''no_show'')),notes TEXT NOT NULL CHECK(length(notes) BETWEEN 1 AND 500),version INTEGER NOT NULL DEFAULT 1 CHECK(version>0),created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),CHECK(ends_at>starts_at AND ends_at-starts_at BETWEEN INTERVAL ''15 minutes'' AND INTERVAL ''180 minutes''),FOREIGN KEY(tenant_id,lead_id) REFERENCES growth_leads(tenant_id,id))',tenant_type,actor_type);
END $migration$;
CREATE INDEX IF NOT EXISTS growth_calls_tenant_time ON growth_calls(tenant_id,recorded_at,id);
CREATE INDEX IF NOT EXISTS growth_appointments_owner_time ON growth_appointments(tenant_id,owner_id,starts_at,ends_at);
COMMIT;
