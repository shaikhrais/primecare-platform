BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-care-delivery'));
CREATE INDEX IF NOT EXISTS care_followups_unfinished_workload
 ON care_followups(tenant_id,owner_id,due_at)
 WHERE status NOT IN ('completed','cancelled');
COMMIT;
