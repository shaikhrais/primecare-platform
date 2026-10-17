BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-growth-marketing'));
DO $migration$
DECLARE tenant_type TEXT; actor_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type NOT IN ('uuid','text','character varying') OR actor_type NOT IN ('uuid','text','character varying') OR tenant_type IS NULL OR actor_type IS NULL THEN RAISE EXCEPTION 'Unsupported growth identity schema'; END IF;
 EXECUTE format('CREATE TABLE IF NOT EXISTS growth_intake_links(id UUID PRIMARY KEY,tenant_id %s NOT NULL REFERENCES tenants(id),owner_id %s NOT NULL REFERENCES users(id),campaign_id UUID,pipeline TEXT NOT NULL CHECK(pipeline IN (''client'',''tenant'')),name TEXT NOT NULL CHECK(length(name) BETWEEN 1 AND 100),public_key TEXT UNIQUE NOT NULL CHECK(public_key~''^[0-9a-f]{64}$''),active BOOLEAN NOT NULL DEFAULT TRUE,version INTEGER NOT NULL DEFAULT 1 CHECK(version>0),created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),FOREIGN KEY(tenant_id,campaign_id) REFERENCES growth_campaigns(tenant_id,id))',tenant_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS growth_intake_receipts(id UUID PRIMARY KEY,link_id UUID NOT NULL REFERENCES growth_intake_links(id),tenant_id %s NOT NULL,lead_id UUID NOT NULL,request_key TEXT NOT NULL,request_hash TEXT NOT NULL,consent_version TEXT NOT NULL CHECK(consent_version=''contact-response-v1''),created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),UNIQUE(link_id,request_key),FOREIGN KEY(tenant_id,lead_id) REFERENCES growth_leads(tenant_id,id))',tenant_type);
END $migration$;
CREATE INDEX IF NOT EXISTS growth_intake_links_tenant ON growth_intake_links(tenant_id,created_at);
CREATE TABLE IF NOT EXISTS growth_intake_rate(bucket TEXT PRIMARY KEY,attempts INTEGER NOT NULL,window_start TIMESTAMPTZ NOT NULL);
CREATE OR REPLACE FUNCTION growth_intake_receipts_immutable() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'Enquiry receipt history is immutable'; END $$;
DROP TRIGGER IF EXISTS growth_intake_no_mutation ON growth_intake_receipts;
CREATE TRIGGER growth_intake_no_mutation BEFORE UPDATE OR DELETE ON growth_intake_receipts FOR EACH ROW EXECUTE FUNCTION growth_intake_receipts_immutable();
COMMIT;
