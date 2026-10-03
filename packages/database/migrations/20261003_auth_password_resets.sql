-- Additive and rerunnable. Match the deployed users.id type (UUID or text).
DO $$
DECLARE id_type TEXT;
BEGIN
 SELECT format_type(a.atttypid,a.atttypmod) INTO id_type FROM pg_attribute a WHERE a.attrelid='users'::regclass AND a.attname='id';
 EXECUTE format('CREATE TABLE IF NOT EXISTS auth_password_resets (token_hash TEXT PRIMARY KEY, user_id %s NOT NULL REFERENCES users(id) ON DELETE CASCADE, expires_at TIMESTAMPTZ NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT NOW())',id_type);
END $$;
CREATE INDEX IF NOT EXISTS auth_password_resets_user ON auth_password_resets(user_id);
CREATE INDEX IF NOT EXISTS auth_password_resets_expiry ON auth_password_resets(expires_at);
