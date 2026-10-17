BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-care-delivery'));
DO $migration$
DECLARE tenant_type TEXT; actor_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type NOT IN ('uuid','text','character varying') OR actor_type NOT IN ('uuid','text','character varying') OR tenant_type IS NULL OR actor_type IS NULL THEN RAISE EXCEPTION 'Unsupported care identity schema'; END IF;
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_handovers(id UUID PRIMARY KEY,tenant_id %s NOT NULL,source_case_id UUID NOT NULL,target_case_id UUID NOT NULL,author_id %s NOT NULL REFERENCES users(id),status TEXT NOT NULL CHECK(status IN (''pending'',''returned'',''approved'',''withdrawn'')),version INTEGER NOT NULL CHECK(version BETWEEN 1 AND 20),summary TEXT NOT NULL,outstanding TEXT NOT NULL,precautions TEXT NOT NULL,reviewer_id %s REFERENCES users(id),created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),UNIQUE(tenant_id,id),FOREIGN KEY(tenant_id,source_case_id) REFERENCES care_cases(tenant_id,id),FOREIGN KEY(tenant_id,target_case_id) REFERENCES care_cases(tenant_id,id),CHECK(source_case_id<>target_case_id),CHECK(reviewer_id IS NULL OR reviewer_id<>author_id))',tenant_type,actor_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_handover_events(id UUID PRIMARY KEY,tenant_id %s NOT NULL,handover_id UUID NOT NULL,actor_id %s NOT NULL REFERENCES users(id),action TEXT NOT NULL,version INTEGER NOT NULL CHECK(version BETWEEN 1 AND 20),payload JSONB NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),UNIQUE(tenant_id,handover_id,version),FOREIGN KEY(tenant_id,handover_id) REFERENCES care_handovers(tenant_id,id))',tenant_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_handover_receipts(id UUID PRIMARY KEY,tenant_id %s NOT NULL,handover_id UUID NOT NULL,approved_version INTEGER NOT NULL,target_signature TEXT NOT NULL,actor_id %s NOT NULL REFERENCES users(id),note TEXT NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),UNIQUE(tenant_id,handover_id,approved_version,target_signature,actor_id),FOREIGN KEY(tenant_id,handover_id) REFERENCES care_handovers(tenant_id,id))',tenant_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_followups(id UUID PRIMARY KEY,tenant_id %s NOT NULL,case_id UUID NOT NULL,category TEXT NOT NULL CHECK(category IN (''coverage'',''plan_review'',''visit_review'',''documentation'',''staff_clearance'',''time_review'',''handover_review'',''other_operations'')),owner_id %s NOT NULL REFERENCES users(id),created_by %s NOT NULL REFERENCES users(id),status TEXT NOT NULL CHECK(status IN (''open'',''in_progress'',''blocked'',''submitted'',''completed'',''cancelled'')),version INTEGER NOT NULL CHECK(version BETWEEN 1 AND 50),due_at TIMESTAMPTZ NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),UNIQUE(tenant_id,id),FOREIGN KEY(tenant_id,case_id) REFERENCES care_cases(tenant_id,id))',tenant_type,actor_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_followup_events(id UUID PRIMARY KEY,tenant_id %s NOT NULL,followup_id UUID NOT NULL,actor_id %s NOT NULL REFERENCES users(id),action TEXT NOT NULL,version INTEGER NOT NULL CHECK(version BETWEEN 1 AND 50),payload JSONB NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),UNIQUE(tenant_id,followup_id,version),FOREIGN KEY(tenant_id,followup_id) REFERENCES care_followups(tenant_id,id))',tenant_type,actor_type);
END $migration$;
CREATE INDEX IF NOT EXISTS care_handovers_source ON care_handovers(tenant_id,source_case_id,status);
CREATE INDEX IF NOT EXISTS care_handovers_target ON care_handovers(tenant_id,target_case_id,status);
CREATE INDEX IF NOT EXISTS care_followups_queue ON care_followups(tenant_id,owner_id,status,due_at);
DROP TRIGGER IF EXISTS care_handover_events_immutable ON care_handover_events;
CREATE TRIGGER care_handover_events_immutable BEFORE UPDATE OR DELETE ON care_handover_events FOR EACH ROW EXECUTE FUNCTION care_record_immutable();
DROP TRIGGER IF EXISTS care_handover_receipts_immutable ON care_handover_receipts;
CREATE TRIGGER care_handover_receipts_immutable BEFORE UPDATE OR DELETE ON care_handover_receipts FOR EACH ROW EXECUTE FUNCTION care_record_immutable();
DROP TRIGGER IF EXISTS care_followup_events_immutable ON care_followup_events;
CREATE TRIGGER care_followup_events_immutable BEFORE UPDATE OR DELETE ON care_followup_events FOR EACH ROW EXECUTE FUNCTION care_record_immutable();
COMMIT;
