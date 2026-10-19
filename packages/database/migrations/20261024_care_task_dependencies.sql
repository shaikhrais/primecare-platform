BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-care-delivery'));
CREATE UNIQUE INDEX IF NOT EXISTS care_followups_case_identity ON care_followups(tenant_id,case_id,id);
DO $migration$
DECLARE tenant_type TEXT; actor_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type NOT IN ('uuid','text','character varying') OR actor_type NOT IN ('uuid','text','character varying') OR tenant_type IS NULL OR actor_type IS NULL THEN RAISE EXCEPTION 'Unsupported care identity schema'; END IF;
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_followup_dependencies(tenant_id %s NOT NULL,case_id UUID NOT NULL,followup_id UUID NOT NULL,prerequisite_id UUID NOT NULL,author_id %s NOT NULL REFERENCES users(id),created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),PRIMARY KEY(tenant_id,followup_id,prerequisite_id),CHECK(followup_id<>prerequisite_id),FOREIGN KEY(tenant_id,case_id,followup_id) REFERENCES care_followups(tenant_id,case_id,id),FOREIGN KEY(tenant_id,case_id,prerequisite_id) REFERENCES care_followups(tenant_id,case_id,id))',tenant_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS care_followup_dependency_releases(tenant_id %s NOT NULL,followup_id UUID NOT NULL,prerequisite_id UUID NOT NULL,reviewer_id %s NOT NULL REFERENCES users(id),note TEXT NOT NULL CHECK(char_length(note) BETWEEN 1 AND 1000),checked BOOLEAN NOT NULL CHECK(checked),created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),PRIMARY KEY(tenant_id,followup_id,prerequisite_id),FOREIGN KEY(tenant_id,followup_id,prerequisite_id) REFERENCES care_followup_dependencies(tenant_id,followup_id,prerequisite_id))',tenant_type,actor_type);
END $migration$;
CREATE INDEX IF NOT EXISTS care_followup_dependencies_parent ON care_followup_dependencies(tenant_id,prerequisite_id,followup_id);
DROP TRIGGER IF EXISTS care_followup_dependencies_immutable ON care_followup_dependencies;
CREATE TRIGGER care_followup_dependencies_immutable BEFORE UPDATE OR DELETE ON care_followup_dependencies FOR EACH ROW EXECUTE FUNCTION care_record_immutable();
DROP TRIGGER IF EXISTS care_followup_dependency_releases_immutable ON care_followup_dependency_releases;
CREATE TRIGGER care_followup_dependency_releases_immutable BEFORE UPDATE OR DELETE ON care_followup_dependency_releases FOR EACH ROW EXECUTE FUNCTION care_record_immutable();
COMMIT;
