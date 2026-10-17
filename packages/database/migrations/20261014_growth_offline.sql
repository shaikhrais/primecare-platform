BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-growth-marketing'));
ALTER TABLE growth_intake_links ADD COLUMN IF NOT EXISTS source TEXT NOT NULL DEFAULT 'website' CHECK(source IN ('website','offline','referral'));
ALTER TABLE growth_intake_links ADD COLUMN IF NOT EXISTS attribution TEXT NOT NULL DEFAULT '' CHECK(length(attribution)<=200);
DO $constraint$
BEGIN
 IF NOT EXISTS(SELECT 1 FROM pg_constraint WHERE conrelid='growth_intake_links'::regclass AND conname='growth_intake_attribution_required') THEN
  ALTER TABLE growth_intake_links ADD CONSTRAINT growth_intake_attribution_required CHECK(source='website' OR length(btrim(attribution))>0);
 END IF;
END $constraint$;
-- Old receipts retain unknown acquisition classification; do not invent historical conversions.
ALTER TABLE growth_intake_receipts ADD COLUMN IF NOT EXISTS new_lead BOOLEAN;
COMMIT;
