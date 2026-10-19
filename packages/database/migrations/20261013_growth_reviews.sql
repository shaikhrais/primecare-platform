BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-growth-marketing'));
ALTER TABLE growth_campaign_briefs ADD COLUMN IF NOT EXISTS status TEXT NOT NULL DEFAULT 'draft' CHECK(status IN ('draft','pending_review','approved','changes_requested','rejected'));
-- No invented approvals for existing briefs: they remain drafts.
DO $migration$
DECLARE tenant_type TEXT; actor_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type NOT IN ('uuid','text','character varying') OR actor_type NOT IN ('uuid','text','character varying') OR tenant_type IS NULL OR actor_type IS NULL THEN RAISE EXCEPTION 'Unsupported growth identity schema'; END IF;
 EXECUTE format('CREATE TABLE IF NOT EXISTS growth_campaign_reviews(id UUID PRIMARY KEY,tenant_id %s NOT NULL,campaign_id UUID NOT NULL,actor_id %s NOT NULL REFERENCES users(id),actor_role TEXT NOT NULL,action TEXT NOT NULL CHECK(action IN (''submit'',''withdraw'',''approve'',''request_changes'',''reject'')),brief_version INTEGER NOT NULL CHECK(brief_version>0),result_version INTEGER NOT NULL CHECK(result_version=brief_version+1),evidence TEXT NOT NULL CHECK(length(evidence) BETWEEN 1 AND 1000),self_review BOOLEAN NOT NULL,snapshot JSONB NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),FOREIGN KEY(tenant_id,campaign_id) REFERENCES growth_campaign_briefs(tenant_id,campaign_id))',tenant_type,actor_type);
END $migration$;
CREATE INDEX IF NOT EXISTS growth_reviews_campaign ON growth_campaign_reviews(tenant_id,campaign_id,created_at);
-- Append-only evidence: application exposes no update/delete command.
CREATE OR REPLACE FUNCTION growth_reviews_immutable() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'Campaign review history is immutable'; END $$;
DROP TRIGGER IF EXISTS growth_reviews_no_mutation ON growth_campaign_reviews;
CREATE TRIGGER growth_reviews_no_mutation BEFORE UPDATE OR DELETE ON growth_campaign_reviews FOR EACH ROW EXECUTE FUNCTION growth_reviews_immutable();
COMMIT;
