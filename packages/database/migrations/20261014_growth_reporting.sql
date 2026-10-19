BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-growth-marketing'));
ALTER TABLE growth_tasks ADD COLUMN IF NOT EXISTS completed_at TIMESTAMPTZ;
DO $migration$
DECLARE tenant_type TEXT; actor_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type NOT IN ('uuid','text','character varying') OR actor_type NOT IN ('uuid','text','character varying') OR tenant_type IS NULL OR actor_type IS NULL THEN RAISE EXCEPTION 'Unsupported growth identity schema'; END IF;
 EXECUTE format('CREATE TABLE IF NOT EXISTS growth_report_deliveries(id UUID PRIMARY KEY,tenant_id %s NOT NULL REFERENCES tenants(id),actor_id %s NOT NULL REFERENCES users(id),idempotency_key TEXT NOT NULL,request_hash TEXT NOT NULL,recipient TEXT NOT NULL,state TEXT NOT NULL CHECK(state IN (''sending'',''accepted'',''unknown'',''not_sent'')),message_id TEXT,version INTEGER NOT NULL DEFAULT 1,review_evidence TEXT NOT NULL DEFAULT '''',created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),UNIQUE(actor_id,idempotency_key))',tenant_type,actor_type);
END $migration$;
CREATE INDEX IF NOT EXISTS growth_report_deliveries_actor ON growth_report_deliveries(tenant_id,actor_id,created_at);
COMMIT;
