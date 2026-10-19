BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-care-delivery'));
DO $migration$
DECLARE tenant_type TEXT; actor_type TEXT; visit_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO visit_type FROM pg_attribute WHERE attrelid='visits'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type NOT IN ('uuid','text','character varying') OR actor_type NOT IN ('uuid','text','character varying') OR visit_type NOT IN ('uuid','text','character varying') OR tenant_type IS NULL OR actor_type IS NULL OR visit_type IS NULL THEN RAISE EXCEPTION 'Unsupported care identity schema'; END IF;
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_visit_series(id UUID PRIMARY KEY,tenant_id %s NOT NULL REFERENCES tenants(id),source_visit_id %s NOT NULL REFERENCES visits(id),request_hash TEXT NOT NULL,definition JSONB NOT NULL,created_by %s NOT NULL REFERENCES users(id),created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),UNIQUE(tenant_id,request_hash),UNIQUE(tenant_id,id))',tenant_type,visit_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_schedule_previews(tenant_id %s NOT NULL REFERENCES tenants(id),actor_id %s NOT NULL REFERENCES users(id),request_hash TEXT NOT NULL,source_updated_at TIMESTAMPTZ NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),PRIMARY KEY(tenant_id,actor_id,request_hash))',tenant_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_series_visits(tenant_id %s NOT NULL,series_id UUID NOT NULL,visit_id %s NOT NULL REFERENCES visits(id),ordinal INTEGER NOT NULL CHECK(ordinal BETWEEN 1 AND 12),PRIMARY KEY(tenant_id,visit_id),UNIQUE(series_id,ordinal),FOREIGN KEY(tenant_id,series_id) REFERENCES care_visit_series(tenant_id,id))',tenant_type,visit_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_schedule_events(id UUID PRIMARY KEY,tenant_id %s NOT NULL REFERENCES tenants(id),visit_id %s NOT NULL REFERENCES visits(id),actor_id %s NOT NULL REFERENCES users(id),action TEXT NOT NULL,payload JSONB NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW())',tenant_type,visit_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_time_records(tenant_id %s NOT NULL,case_id UUID NOT NULL,worker_id %s NOT NULL REFERENCES users(id),status TEXT NOT NULL CHECK(status IN (''pending'',''returned'',''approved'')),version INTEGER NOT NULL CHECK(version BETWEEN 1 AND 50),actual_start TIMESTAMPTZ NOT NULL,actual_end TIMESTAMPTZ NOT NULL,break_minutes INTEGER NOT NULL CHECK(break_minutes>=0),net_minutes INTEGER NOT NULL CHECK(net_minutes>0),reviewer_id %s REFERENCES users(id),updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),PRIMARY KEY(tenant_id,case_id),FOREIGN KEY(tenant_id,case_id) REFERENCES care_cases(tenant_id,id),CHECK(actual_end>actual_start),CHECK(reviewer_id IS NULL OR reviewer_id<>worker_id))',tenant_type,actor_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_time_events(id UUID PRIMARY KEY,tenant_id %s NOT NULL,case_id UUID NOT NULL,actor_id %s NOT NULL REFERENCES users(id),action TEXT NOT NULL,version INTEGER NOT NULL CHECK(version BETWEEN 1 AND 50),payload JSONB NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),FOREIGN KEY(tenant_id,case_id) REFERENCES care_time_records(tenant_id,case_id),UNIQUE(tenant_id,case_id,version))',tenant_type,actor_type);
END $migration$;
CREATE INDEX IF NOT EXISTS care_series_scope ON care_visit_series(tenant_id,created_at DESC,id);
CREATE INDEX IF NOT EXISTS care_time_scope ON care_time_records(tenant_id,worker_id,status,updated_at DESC);
CREATE INDEX IF NOT EXISTS care_schedule_history ON care_schedule_events(tenant_id,visit_id,created_at);
DROP TRIGGER IF EXISTS care_series_immutable ON care_visit_series;
CREATE TRIGGER care_series_immutable BEFORE UPDATE OR DELETE ON care_visit_series FOR EACH ROW EXECUTE FUNCTION care_record_immutable();
DROP TRIGGER IF EXISTS care_series_visits_immutable ON care_series_visits;
CREATE TRIGGER care_series_visits_immutable BEFORE UPDATE OR DELETE ON care_series_visits FOR EACH ROW EXECUTE FUNCTION care_record_immutable();
DROP TRIGGER IF EXISTS care_schedule_events_immutable ON care_schedule_events;
CREATE TRIGGER care_schedule_events_immutable BEFORE UPDATE OR DELETE ON care_schedule_events FOR EACH ROW EXECUTE FUNCTION care_record_immutable();
DROP TRIGGER IF EXISTS care_time_events_immutable ON care_time_events;
CREATE TRIGGER care_time_events_immutable BEFORE UPDATE OR DELETE ON care_time_events FOR EACH ROW EXECUTE FUNCTION care_record_immutable();
COMMIT;
