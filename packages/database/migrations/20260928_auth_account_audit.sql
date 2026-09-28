CREATE TABLE IF NOT EXISTS auth_account_audit (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  actor_user_id UUID NOT NULL REFERENCES users(id),
  target_user_id UUID NOT NULL REFERENCES users(id),
  tenant_id UUID NOT NULL,
  action TEXT NOT NULL CHECK (action = 'account_created'),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS auth_account_audit_tenant_created_idx
  ON auth_account_audit(tenant_id, created_at);
