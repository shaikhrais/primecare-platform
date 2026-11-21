-- Additive code-governance extension. Never touches business data or grants.
CREATE TABLE IF NOT EXISTS __SCHEMA__.govt_class_registry_meta (
  version integer PRIMARY KEY CHECK (version=1), migration_sha256 text NOT NULL,
  source_manifest_sha256 text NOT NULL, current_scan_id text
);
CREATE TABLE IF NOT EXISTS __SCHEMA__.govt_class_registry_managers (
  manager_id text PRIMARY KEY, parent_id text REFERENCES __SCHEMA__.govt_class_registry_managers(manager_id) DEFERRABLE INITIALLY DEFERRED,
  purpose text NOT NULL CHECK (length(purpose)>0), CHECK (manager_id<>parent_id)
);
CREATE UNIQUE INDEX IF NOT EXISTS govt_class_registry_one_master ON __SCHEMA__.govt_class_registry_managers ((parent_id IS NULL)) WHERE parent_id IS NULL;
CREATE TABLE IF NOT EXISTS __SCHEMA__.govt_class_registry_scans (
  scan_id text PRIMARY KEY CHECK (scan_id ~ '^[a-f0-9]{64}$'), source_commit text NOT NULL,
  complete boolean NOT NULL, registry_sha256 text NOT NULL, coverage jsonb NOT NULL,
  limitations jsonb NOT NULL, created_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS __SCHEMA__.govt_class_registry_classes (
  class_id text PRIMARY KEY, language text NOT NULL CHECK(language IN ('dart','typescript','python')),
  class_name text NOT NULL, source_path text NOT NULL,
  manager_id text REFERENCES __SCHEMA__.govt_class_registry_managers(manager_id),
  first_seen_scan text NOT NULL REFERENCES __SCHEMA__.govt_class_registry_scans(scan_id)
);
CREATE TABLE IF NOT EXISTS __SCHEMA__.govt_class_registry_bases (
  base_id text PRIMARY KEY, source_name text NOT NULL,
  manager_id text REFERENCES __SCHEMA__.govt_class_registry_managers(manager_id),
  source_class_id text REFERENCES __SCHEMA__.govt_class_registry_classes(class_id) DEFERRABLE INITIALLY DEFERRED,
  resolution text NOT NULL CHECK(resolution IN ('source_resolved','external_declared','needs_resolution')),
  candidates jsonb NOT NULL
);
CREATE TABLE IF NOT EXISTS __SCHEMA__.govt_class_registry_observations (
  scan_id text NOT NULL REFERENCES __SCHEMA__.govt_class_registry_scans(scan_id),
  class_id text NOT NULL REFERENCES __SCHEMA__.govt_class_registry_classes(class_id),
  source_sha256 text NOT NULL, metadata jsonb NOT NULL,
  PRIMARY KEY(scan_id,class_id)
);
CREATE TABLE IF NOT EXISTS __SCHEMA__.govt_class_registry_findings (
  scan_id text NOT NULL REFERENCES __SCHEMA__.govt_class_registry_scans(scan_id),
  finding_id text NOT NULL, finding_kind text NOT NULL, metadata jsonb NOT NULL,
  PRIMARY KEY(scan_id,finding_id)
);
CREATE TABLE IF NOT EXISTS __SCHEMA__.govt_class_registry_reviews (
  review_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  class_id text NOT NULL REFERENCES __SCHEMA__.govt_class_registry_classes(class_id),
  source_sha256 text NOT NULL, reviewer_identity text NOT NULL,
  purpose text NOT NULL CHECK(length(purpose)>0), rationale text NOT NULL CHECK(length(rationale)>0),
  disposition text NOT NULL CHECK(disposition IN ('approved','correction_required','retired')),
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS __SCHEMA__.govt_class_registry_events (
  scan_id text NOT NULL REFERENCES __SCHEMA__.govt_class_registry_scans(scan_id),
  source_commit text NOT NULL, event_kind text NOT NULL CHECK(event_kind='metadata_sync'),
  metadata jsonb NOT NULL, created_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY(scan_id,source_commit,event_kind)
);
CREATE INDEX IF NOT EXISTS govt_class_registry_name ON __SCHEMA__.govt_class_registry_classes(language,class_name);
CREATE INDEX IF NOT EXISTS govt_class_registry_owner ON __SCHEMA__.govt_class_registry_classes(manager_id);
CREATE OR REPLACE FUNCTION __SCHEMA__.govt_class_registry_check_manager_cycle() RETURNS trigger LANGUAGE plpgsql AS $body$
BEGIN
  IF EXISTS (
    WITH RECURSIVE chain(id,parent_id,path,cycle) AS (
      SELECT manager_id,parent_id,ARRAY[manager_id],false FROM __SCHEMA__.govt_class_registry_managers WHERE manager_id=NEW.manager_id
      UNION ALL
      SELECT p.manager_id,p.parent_id,chain.path||p.manager_id,p.manager_id=ANY(chain.path)
      FROM __SCHEMA__.govt_class_registry_managers p JOIN chain ON p.manager_id=chain.parent_id WHERE NOT chain.cycle
    ) SELECT 1 FROM chain WHERE cycle
  ) THEN RAISE EXCEPTION 'Class manager cycle'; END IF;
  RETURN NULL;
END;
$body$;
DO $body$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname='govt_class_registry_manager_cycle' AND tgrelid='__SCHEMA__.govt_class_registry_managers'::regclass) THEN
    CREATE CONSTRAINT TRIGGER govt_class_registry_manager_cycle AFTER INSERT OR UPDATE ON __SCHEMA__.govt_class_registry_managers
      DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION __SCHEMA__.govt_class_registry_check_manager_cycle();
  END IF;
END;
$body$;
