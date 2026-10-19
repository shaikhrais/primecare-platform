BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-platform-administration'));
DO $migration$
DECLARE tenant_type TEXT; actor_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type NOT IN ('uuid','text','character varying') OR actor_type NOT IN ('uuid','text','character varying') OR tenant_type IS NULL OR actor_type IS NULL THEN RAISE EXCEPTION 'Unsupported platform identity schema'; END IF;
 EXECUTE format('CREATE TABLE IF NOT EXISTS platform_master_records (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(), tenant_id %s NOT NULL REFERENCES tenants(id),
  type TEXT NOT NULL CHECK(type IN (''location'',''department'',''service_category'')),
  code TEXT NOT NULL CHECK(code ~ ''^[a-z][a-z0-9_-]{1,63}$''), label TEXT NOT NULL CHECK(length(label) BETWEEN 1 AND 150),
  status TEXT NOT NULL DEFAULT ''active'' CHECK(status IN (''active'',''inactive'')),
  version INTEGER NOT NULL DEFAULT 1 CHECK(version>0), updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), UNIQUE(tenant_id,type,code))',tenant_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS platform_administration_audit (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(), actor_id %s NOT NULL REFERENCES users(id), tenant_id %s NOT NULL REFERENCES tenants(id),
  target_id TEXT NOT NULL, action TEXT NOT NULL CHECK(action IN (''tenant_created'',''account_created'',''account_updated'',''master_created'',''master_updated'')),
  previous_state JSONB NOT NULL, current_state JSONB NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT NOW())',actor_type,tenant_type);
END $migration$;
CREATE TABLE IF NOT EXISTS platform_administration_requests (
 actor_id TEXT NOT NULL, idempotency_key TEXT NOT NULL, request_hash TEXT NOT NULL, response JSONB NOT NULL,
 status INTEGER NOT NULL CHECK(status IN (200,201)), created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), PRIMARY KEY(actor_id,idempotency_key)
);
CREATE TABLE IF NOT EXISTS platform_administration_rate (
 actor_id TEXT PRIMARY KEY, attempts INTEGER NOT NULL, window_start TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS platform_audit_tenant_time ON platform_administration_audit(tenant_id,created_at DESC);
COMMIT;
