BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-care-delivery'));
ALTER TABLE care_cases DROP CONSTRAINT IF EXISTS care_cases_state_check;
ALTER TABLE care_cases ADD CONSTRAINT care_cases_state_check CHECK(state IN (
 'awaiting_plan','draft','pending_review','ready','accepted','in_progress',
 'submitted','completed','cancelled','coverage_needed','correction_requested'
));
CREATE INDEX IF NOT EXISTS care_task_event_deadlines
 ON care_events(tenant_id,case_id,action,record_version DESC);
COMMIT;
