CREATE TABLE IF NOT EXISTS auth_bootstrap_audit (
  user_id UUID PRIMARY KEY REFERENCES users(id),
  tenant_id UUID NOT NULL,
  source TEXT NOT NULL CHECK(source = 'protected_workflow'),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
