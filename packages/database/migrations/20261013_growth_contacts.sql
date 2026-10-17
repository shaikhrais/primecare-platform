BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-growth-marketing'));
DO $migration$
DECLARE tenant_type TEXT; actor_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type NOT IN ('uuid','text','character varying') OR actor_type NOT IN ('uuid','text','character varying') OR tenant_type IS NULL OR actor_type IS NULL THEN RAISE EXCEPTION 'Unsupported growth identity schema'; END IF;
 ALTER TABLE growth_leads ADD COLUMN IF NOT EXISTS duplicate_of UUID;
 ALTER TABLE growth_leads ADD COLUMN IF NOT EXISTS contact_version INTEGER NOT NULL DEFAULT 1 CHECK(contact_version>0);
 IF NOT EXISTS(SELECT 1 FROM pg_constraint WHERE conrelid='growth_leads'::regclass AND conname='growth_duplicate_parent') THEN
  ALTER TABLE growth_leads ADD CONSTRAINT growth_duplicate_parent FOREIGN KEY(tenant_id,duplicate_of) REFERENCES growth_leads(tenant_id,id);
  ALTER TABLE growth_leads ADD CONSTRAINT growth_duplicate_not_self CHECK(duplicate_of IS NULL OR duplicate_of<>id);
 END IF;
 EXECUTE format('CREATE TABLE IF NOT EXISTS growth_duplicate_reviews(tenant_id %s NOT NULL,lead_a UUID NOT NULL,lead_b UUID NOT NULL,a_version INTEGER NOT NULL,b_version INTEGER NOT NULL,decision TEXT NOT NULL CHECK(decision IN (''distinct_person'',''duplicate_confirmed'')),evidence TEXT NOT NULL CHECK(length(evidence) BETWEEN 1 AND 500),actor_id %s NOT NULL REFERENCES users(id),version INTEGER NOT NULL DEFAULT 1 CHECK(version>0),reviewed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),PRIMARY KEY(tenant_id,lead_a,lead_b),CHECK(lead_a<lead_b),FOREIGN KEY(tenant_id,lead_a) REFERENCES growth_leads(tenant_id,id),FOREIGN KEY(tenant_id,lead_b) REFERENCES growth_leads(tenant_id,id))',tenant_type,actor_type);
END $migration$;
CREATE INDEX IF NOT EXISTS growth_leads_duplicate_parent ON growth_leads(tenant_id,duplicate_of);
CREATE INDEX IF NOT EXISTS growth_leads_email_match ON growth_leads(tenant_id,pipeline,LOWER(email)) WHERE duplicate_of IS NULL;
CREATE INDEX IF NOT EXISTS growth_leads_phone_match ON growth_leads(tenant_id,pipeline,regexp_replace(phone,'[^0-9]','','g')) WHERE duplicate_of IS NULL;
COMMIT;
