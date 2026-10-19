BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-growth-marketing'));
ALTER TABLE growth_tasks ADD COLUMN IF NOT EXISTS priority TEXT NOT NULL DEFAULT 'normal' CHECK(priority IN ('low','normal','high','urgent'));
ALTER TABLE growth_tasks ADD COLUMN IF NOT EXISTS escalated_at TIMESTAMPTZ;
ALTER TABLE growth_tasks ADD COLUMN IF NOT EXISTS escalation_reason TEXT NOT NULL DEFAULT '' CHECK(length(escalation_reason)<=500);
COMMIT;
