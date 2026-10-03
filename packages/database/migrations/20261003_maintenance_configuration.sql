BEGIN;
CREATE TABLE IF NOT EXISTS tenant_mail_configuration (
 tenant_id TEXT PRIMARY KEY,
 sender TEXT NOT NULL,
 api_key_ciphertext TEXT,
 templates JSONB NOT NULL DEFAULT '{}',
 revision INTEGER NOT NULL DEFAULT 1,
 updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS tenant_configuration_audit (
 id BIGSERIAL PRIMARY KEY,
 tenant_id TEXT NOT NULL,
 actor_user_id TEXT NOT NULL,
 action TEXT NOT NULL,
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS tenant_configuration_audit_recent ON tenant_configuration_audit(tenant_id,created_at DESC);
COMMIT;
