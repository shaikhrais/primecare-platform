BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-care-delivery'));
ALTER TABLE care_followups ADD COLUMN IF NOT EXISTS requested_due_at TIMESTAMPTZ;
ALTER TABLE care_followups ADD COLUMN IF NOT EXISTS extension_requested_at TIMESTAMPTZ;
DO $migration$
DECLARE actor_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 IF actor_type NOT IN ('uuid','text','character varying') OR actor_type IS NULL THEN RAISE EXCEPTION 'Unsupported care identity schema'; END IF;
 EXECUTE format('ALTER TABLE care_followups ADD COLUMN IF NOT EXISTS extension_requested_by %s REFERENCES users(id)',actor_type);
 IF NOT EXISTS(SELECT 1 FROM pg_constraint WHERE conrelid='care_followups'::regclass AND conname='care_followup_extension_consistent') THEN
  ALTER TABLE care_followups ADD CONSTRAINT care_followup_extension_consistent CHECK(
   (requested_due_at IS NULL AND extension_requested_at IS NULL AND extension_requested_by IS NULL) OR
   (requested_due_at IS NOT NULL AND extension_requested_at IS NOT NULL AND extension_requested_by IS NOT NULL AND extension_requested_by=owner_id AND requested_due_at>due_at AND status NOT IN ('completed','cancelled'))
  );
 END IF;
END $migration$;
CREATE INDEX IF NOT EXISTS care_followups_extension_queue ON care_followups(tenant_id,extension_requested_at,id) WHERE requested_due_at IS NOT NULL;
COMMIT;
