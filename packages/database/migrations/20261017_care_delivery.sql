BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-care-delivery'));
DO $migration$
DECLARE tenant_type TEXT; actor_type TEXT; visit_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO visit_type FROM pg_attribute WHERE attrelid='visits'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type NOT IN ('uuid','text','character varying') OR actor_type NOT IN ('uuid','text','character varying') OR visit_type NOT IN ('uuid','text','character varying') OR tenant_type IS NULL OR actor_type IS NULL OR visit_type IS NULL THEN RAISE EXCEPTION 'Unsupported care identity schema'; END IF;
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_staff_clearances(id UUID PRIMARY KEY,tenant_id %s NOT NULL REFERENCES tenants(id),staff_id %s NOT NULL REFERENCES users(id),version INTEGER NOT NULL CHECK(version>0),staff_role TEXT NOT NULL,status TEXT NOT NULL CHECK(status IN (''active'',''revoked'')),registration TEXT NOT NULL,expires_on DATE NOT NULL,reviewer_id %s NOT NULL REFERENCES users(id),evidence TEXT NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),UNIQUE(tenant_id,staff_id,version),CHECK(staff_id<>reviewer_id))',tenant_type,actor_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_cases(id UUID PRIMARY KEY,tenant_id %s NOT NULL REFERENCES tenants(id),visit_id %s NOT NULL REFERENCES visits(id),nurse_id %s NOT NULL REFERENCES users(id),supervisor_id %s NOT NULL REFERENCES users(id),worker_id %s NOT NULL REFERENCES users(id),state TEXT NOT NULL DEFAULT ''awaiting_plan'' CHECK(state IN (''awaiting_plan'',''draft'',''pending_review'',''ready'',''accepted'',''in_progress'',''submitted'',''completed'',''cancelled'')),version INTEGER NOT NULL DEFAULT 1 CHECK(version>0),plan JSONB,plan_author %s REFERENCES users(id),plan_reviewer %s REFERENCES users(id),started_at TIMESTAMPTZ,submitted_at TIMESTAMPTZ,completed_at TIMESTAMPTZ,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),UNIQUE(tenant_id,visit_id),UNIQUE(tenant_id,id),CHECK(nurse_id<>supervisor_id),CHECK(worker_id<>nurse_id AND worker_id<>supervisor_id))',tenant_type,visit_type,actor_type,actor_type,actor_type,actor_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_events(id UUID PRIMARY KEY,tenant_id %s NOT NULL,case_id UUID NOT NULL,actor_id %s NOT NULL REFERENCES users(id),actor_role TEXT NOT NULL,record_version INTEGER NOT NULL CHECK(record_version>0),action TEXT NOT NULL,payload JSONB NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),FOREIGN KEY(tenant_id,case_id) REFERENCES care_cases(tenant_id,id),UNIQUE(tenant_id,case_id,record_version))',tenant_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_requests(actor_id %s NOT NULL REFERENCES users(id),idempotency_key TEXT NOT NULL,fingerprint TEXT NOT NULL,response JSONB NOT NULL,status INTEGER NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),PRIMARY KEY(actor_id,idempotency_key))',actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_rate(actor_id %s PRIMARY KEY REFERENCES users(id),attempts INTEGER NOT NULL,window_start TIMESTAMPTZ NOT NULL)',actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_access_log(id UUID PRIMARY KEY,tenant_id %s NOT NULL REFERENCES tenants(id),actor_id %s NOT NULL REFERENCES users(id),case_id UUID,operation TEXT NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW())',tenant_type,actor_type);
END $migration$;
CREATE INDEX IF NOT EXISTS care_clearance_current ON care_staff_clearances(tenant_id,staff_id,version DESC);
CREATE INDEX IF NOT EXISTS care_cases_scope ON care_cases(tenant_id,state,created_at DESC);
CREATE INDEX IF NOT EXISTS care_events_scope ON care_events(tenant_id,case_id,created_at,id);
CREATE OR REPLACE FUNCTION care_record_immutable() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'Care history is immutable; append a signed correction'; END $$;
DROP TRIGGER IF EXISTS care_clearances_immutable ON care_staff_clearances;
CREATE TRIGGER care_clearances_immutable BEFORE UPDATE OR DELETE ON care_staff_clearances FOR EACH ROW EXECUTE FUNCTION care_record_immutable();
DROP TRIGGER IF EXISTS care_events_immutable ON care_events;
CREATE TRIGGER care_events_immutable BEFORE UPDATE OR DELETE ON care_events FOR EACH ROW EXECUTE FUNCTION care_record_immutable();
DROP TRIGGER IF EXISTS care_access_immutable ON care_access_log;
CREATE TRIGGER care_access_immutable BEFORE UPDATE OR DELETE ON care_access_log FOR EACH ROW EXECUTE FUNCTION care_record_immutable();
COMMIT;
