BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-care-delivery'));
DO $migration$
DECLARE tenant_type TEXT; actor_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type NOT IN ('uuid','text','character varying') OR actor_type NOT IN ('uuid','text','character varying') OR tenant_type IS NULL OR actor_type IS NULL THEN RAISE EXCEPTION 'Unsupported care staffing identity schema'; END IF;
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_staff_windows(id UUID PRIMARY KEY,tenant_id %s NOT NULL REFERENCES tenants(id),staff_id %s NOT NULL REFERENCES users(id),kind TEXT NOT NULL CHECK(kind IN (''availability'',''leave'')),starts_at TIMESTAMPTZ NOT NULL,ends_at TIMESTAMPTZ NOT NULL,status TEXT NOT NULL,version INTEGER NOT NULL CHECK(version BETWEEN 1 AND 3),created_by %s NOT NULL REFERENCES users(id),updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),UNIQUE(tenant_id,id),CHECK(ends_at>starts_at),CHECK(kind=''availability'' AND status IN (''active'',''withdrawn'') OR kind=''leave'' AND status IN (''pending'',''approved'',''rejected'',''withdrawn'',''revoked'')))',tenant_type,actor_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_staffing_events(id UUID PRIMARY KEY,tenant_id %s NOT NULL,window_id UUID NOT NULL,actor_id %s NOT NULL REFERENCES users(id),action TEXT NOT NULL,version INTEGER NOT NULL CHECK(version BETWEEN 1 AND 3),note TEXT NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),FOREIGN KEY(tenant_id,window_id) REFERENCES care_staff_windows(tenant_id,id),UNIQUE(tenant_id,window_id,version))',tenant_type,actor_type);
END $migration$;
CREATE INDEX IF NOT EXISTS care_staff_windows_scope ON care_staff_windows(tenant_id,staff_id,status,starts_at,ends_at);
CREATE INDEX IF NOT EXISTS care_staffing_events_scope ON care_staffing_events(tenant_id,window_id,version);
DROP TRIGGER IF EXISTS care_staffing_events_immutable ON care_staffing_events;
CREATE TRIGGER care_staffing_events_immutable BEFORE UPDATE OR DELETE ON care_staffing_events FOR EACH ROW EXECUTE FUNCTION care_record_immutable();
COMMIT;
