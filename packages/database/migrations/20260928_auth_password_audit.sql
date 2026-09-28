CREATE TABLE IF NOT EXISTS auth_password_audit (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id),
  action TEXT NOT NULL CHECK(action='password_changed'),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
