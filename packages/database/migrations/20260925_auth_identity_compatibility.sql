-- Add auth tables using existing identity types. Never rewrite users or tenants.
BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-auth-schema'));
DO $migration$
DECLARE user_type TEXT; tenant_type TEXT;
BEGIN
  SELECT format_type(atttypid,atttypmod) INTO user_type
    FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
  SELECT format_type(atttypid,atttypmod) INTO tenant_type
    FROM pg_attribute WHERE attrelid='users'::regclass AND attname='tenant_id' AND NOT attisdropped;
  IF user_type NOT IN ('uuid','text','character varying') OR
     tenant_type NOT IN ('uuid','text','character varying') OR
     user_type IS NULL OR tenant_type IS NULL THEN
    RAISE EXCEPTION 'Unsupported existing auth identity types';
  END IF;
  EXECUTE format('CREATE TABLE IF NOT EXISTS auth_sessions (
    token_hash TEXT PRIMARY KEY, user_id %s NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    expires_at TIMESTAMPTZ NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT NOW())',user_type);
  EXECUTE format('CREATE TABLE IF NOT EXISTS auth_account_audit (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    actor_user_id %s NOT NULL REFERENCES users(id), target_user_id %s NOT NULL REFERENCES users(id),
    tenant_id %s NOT NULL, action TEXT NOT NULL CHECK(action=''account_created''),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW())',user_type,user_type,tenant_type);
  EXECUTE format('CREATE TABLE IF NOT EXISTS auth_bootstrap_audit (
    user_id %s PRIMARY KEY REFERENCES users(id), tenant_id %s NOT NULL,
    source TEXT NOT NULL CHECK(source=''protected_workflow''),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW())',user_type,tenant_type);
  EXECUTE format('CREATE TABLE IF NOT EXISTS auth_management_audit (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    actor_user_id %s NOT NULL REFERENCES users(id), target_user_id %s NOT NULL REFERENCES users(id),
    tenant_id %s NOT NULL, previous_state JSONB NOT NULL, new_state JSONB NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW())',user_type,user_type,tenant_type);
  EXECUTE format('CREATE TABLE IF NOT EXISTS auth_password_audit (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), user_id %s NOT NULL REFERENCES users(id),
    action TEXT NOT NULL CHECK(action=''password_changed''),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW())',user_type);
END $migration$;
COMMIT;
