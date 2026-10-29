BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-psw-coordinator-charge'));
DO $migration$
DECLARE tenant_type TEXT;actor_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type IS NULL OR actor_type IS NULL OR tenant_type NOT IN ('uuid','text','character varying') OR actor_type NOT IN ('uuid','text','character varying') THEN RAISE EXCEPTION 'Unsupported coordinator identity schema'; END IF;
 EXECUTE format($ddl$CREATE TABLE IF NOT EXISTS psw_coordinator_charges (
 id UUID PRIMARY KEY, tenant_id %s NOT NULL REFERENCES tenants(id),user_id %s NOT NULL REFERENCES users(id),
 role_code TEXT NOT NULL DEFAULT 'scheduler' CHECK(role_code='scheduler'),
 starts_at TIMESTAMPTZ NOT NULL,ends_at TIMESTAMPTZ,reason TEXT NOT NULL CHECK(length(reason) BETWEEN 10 AND 1000),
 assigned_by %s NOT NULL REFERENCES users(id), revoked_at TIMESTAMPTZ,revoked_by %s REFERENCES users(id),revoke_reason TEXT,
 version INTEGER NOT NULL DEFAULT 1 CHECK(version>0),created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
 CHECK(ends_at IS NULL OR ends_at>starts_at),CHECK((revoked_at IS NULL)=(revoked_by IS NULL))
)$ddl$,tenant_type,actor_type,actor_type,actor_type);
END $migration$;
CREATE INDEX IF NOT EXISTS psw_coordinator_charge_scope ON psw_coordinator_charges(tenant_id,user_id,starts_at) WHERE revoked_at IS NULL;
DO $migration$
DECLARE tenant_type TEXT;actor_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 EXECUTE format($ddl$CREATE TABLE IF NOT EXISTS psw_coordinator_charge_events (
 id UUID PRIMARY KEY,tenant_id %s NOT NULL REFERENCES tenants(id),charge_id UUID REFERENCES psw_coordinator_charges(id),
 actor_id %s NOT NULL REFERENCES users(id),primary_role TEXT NOT NULL,effective_role TEXT NOT NULL,
 action TEXT NOT NULL,detail JSONB NOT NULL DEFAULT '{}',created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
)$ddl$,tenant_type,actor_type);
END $migration$;
CREATE INDEX IF NOT EXISTS psw_coordinator_charge_audit ON psw_coordinator_charge_events(tenant_id,created_at DESC);
CREATE OR REPLACE FUNCTION psw_coordinator_charge_immutable() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'Coordinator audit is immutable'; END $$;
DROP TRIGGER IF EXISTS psw_coordinator_charge_audit_immutable ON psw_coordinator_charge_events;
CREATE TRIGGER psw_coordinator_charge_audit_immutable BEFORE UPDATE OR DELETE ON psw_coordinator_charge_events FOR EACH ROW EXECUTE FUNCTION psw_coordinator_charge_immutable();
COMMIT;
