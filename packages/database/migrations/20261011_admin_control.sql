-- Platform administration: reference records and immutable provisioning history.
-- These reference definitions do not replace operational/clinical tables.
DO $$ DECLARE tenant_type text; BEGIN
 SELECT format_type(a.atttypid,a.atttypmod) INTO tenant_type FROM pg_attribute a WHERE a.attrelid='tenants'::regclass AND a.attname='id' AND NOT a.attisdropped;
 IF tenant_type NOT IN ('text','uuid','character varying') THEN RAISE EXCEPTION 'Unsupported tenant identity type'; END IF;
 EXECUTE format('CREATE TABLE IF NOT EXISTS admin_master_records(id UUID PRIMARY KEY,tenant_id %s REFERENCES tenants(id),category TEXT NOT NULL,code TEXT NOT NULL,labels JSONB NOT NULL,status TEXT NOT NULL CHECK(status IN (''active'',''inactive'')),created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW())',tenant_type);
END $$;
CREATE UNIQUE INDEX IF NOT EXISTS admin_master_global_code ON admin_master_records(category,code) WHERE tenant_id IS NULL;
CREATE UNIQUE INDEX IF NOT EXISTS admin_master_tenant_code ON admin_master_records(tenant_id,category,code) WHERE tenant_id IS NOT NULL;
CREATE TABLE IF NOT EXISTS admin_control_audit(id UUID PRIMARY KEY,actor_user_id TEXT NOT NULL,target_type TEXT NOT NULL,target_id TEXT NOT NULL,tenant_id TEXT,action TEXT NOT NULL CHECK(action IN ('tenant_created','account_created','master_created','master_updated')),created_at TIMESTAMPTZ NOT NULL DEFAULT NOW());
CREATE INDEX IF NOT EXISTS admin_control_audit_order ON admin_control_audit(created_at DESC,id DESC);
