-- Apply after growth intake/offline and the first platform bundle migrations.
BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-territory-intake'));
ALTER TABLE growth_intake_links ADD COLUMN IF NOT EXISTS routing_mode TEXT NOT NULL DEFAULT 'direct' CHECK(routing_mode IN ('direct','territory'));
DO $migration$
DECLARE tenant_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type IS NULL OR tenant_type NOT IN ('uuid','text','character varying') THEN RAISE EXCEPTION 'Unsupported intake identity schema'; END IF;
 IF NOT EXISTS(SELECT 1 FROM pg_constraint WHERE conrelid='growth_intake_links'::regclass AND conname='territory_intake_client_only') THEN
  ALTER TABLE growth_intake_links ADD CONSTRAINT territory_intake_client_only CHECK(routing_mode='direct' OR pipeline='client');
 END IF;
 ALTER TABLE platform_routed_enquiries ALTER COLUMN created_by DROP NOT NULL;
 ALTER TABLE platform_routed_enquiries ADD COLUMN IF NOT EXISTS source TEXT NOT NULL DEFAULT 'referral' CHECK(source IN ('website','offline','referral'));
 ALTER TABLE platform_routed_enquiries ADD COLUMN IF NOT EXISTS origin_link_id UUID REFERENCES growth_intake_links(id);
 ALTER TABLE platform_routed_enquiries ADD COLUMN IF NOT EXISTS attribution TEXT NOT NULL DEFAULT '' CHECK(length(attribution)<=200);
 EXECUTE format('CREATE TABLE IF NOT EXISTS growth_territory_receipts(
 id UUID PRIMARY KEY,link_id UUID NOT NULL REFERENCES growth_intake_links(id),tenant_id %s NOT NULL REFERENCES tenants(id),
 enquiry_id UUID NOT NULL REFERENCES platform_routed_enquiries(id),request_key TEXT NOT NULL,request_hash TEXT NOT NULL,
 response_consent_version TEXT NOT NULL CHECK(response_consent_version=''contact-response-v1''),
 sharing_consent_version TEXT NOT NULL CHECK(sharing_consent_version=''territory-sharing-v1''),new_enquiry BOOLEAN NOT NULL,
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),UNIQUE(link_id,request_key))',tenant_type);
END $migration$;
CREATE INDEX IF NOT EXISTS growth_territory_receipts_link ON growth_territory_receipts(link_id,created_at);
CREATE OR REPLACE FUNCTION growth_territory_receipts_immutable() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'Territory enquiry receipt history is immutable'; END $$;
DROP TRIGGER IF EXISTS growth_territory_no_mutation ON growth_territory_receipts;
CREATE TRIGGER growth_territory_no_mutation BEFORE UPDATE OR DELETE ON growth_territory_receipts FOR EACH ROW EXECUTE FUNCTION growth_territory_receipts_immutable();
CREATE OR REPLACE FUNCTION growth_intake_delivery_immutable() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN IF NEW.routing_mode<>OLD.routing_mode THEN RAISE EXCEPTION 'Intake delivery mode is immutable'; END IF; RETURN NEW; END $$;
DROP TRIGGER IF EXISTS growth_intake_no_delivery_change ON growth_intake_links;
CREATE TRIGGER growth_intake_no_delivery_change BEFORE UPDATE OF routing_mode ON growth_intake_links FOR EACH ROW EXECUTE FUNCTION growth_intake_delivery_immutable();
COMMIT;
