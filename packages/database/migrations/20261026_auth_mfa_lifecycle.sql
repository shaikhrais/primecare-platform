-- User-authorized self-only MFA recovery/replacement. Existing factors remain
-- active until a replacement is confirmed. This migration changes no account.
CREATE TABLE IF NOT EXISTS auth_mfa_recovery_codes (
 code_hash text PRIMARY KEY CHECK (code_hash ~ '^[a-f0-9]{64}$'),
 user_id text NOT NULL,
 tenant_id text NOT NULL,
 generation text NOT NULL,
 consumed_at timestamptz,
 created_at timestamptz NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS auth_mfa_recovery_codes_user ON auth_mfa_recovery_codes(user_id,tenant_id);
CREATE TABLE IF NOT EXISTS auth_mfa_replacement_challenges (
 token_hash text PRIMARY KEY CHECK (token_hash ~ '^[a-f0-9]{64}$'),
 user_id text NOT NULL,
 tenant_id text NOT NULL,
 password_version text NOT NULL,
 original_envelope_hash text NOT NULL,
 pending_envelope jsonb NOT NULL,
 proof_kind text NOT NULL CHECK (proof_kind IN ('current_factor','recovery_code')),
 attempts integer NOT NULL DEFAULT 0 CHECK (attempts BETWEEN 0 AND 5),
 expires_at timestamptz NOT NULL,
 created_at timestamptz NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS auth_mfa_replacement_expiry ON auth_mfa_replacement_challenges(expires_at);
CREATE TABLE IF NOT EXISTS auth_mfa_lifecycle_audit (
 id text PRIMARY KEY,
 user_id text NOT NULL,
 tenant_id text NOT NULL,
 action text NOT NULL CHECK (action IN ('recovery_codes_issued','authenticator_replacement_started','authenticator_recovery_started','authenticator_replaced','server_key_rewrapped')),
 created_at timestamptz NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS auth_mfa_notification_outbox (
 id text PRIMARY KEY,
 user_id text NOT NULL,
 tenant_id text NOT NULL,
 recipient text NOT NULL,
 event text NOT NULL CHECK (event IN ('recovery_codes_issued','authenticator_recovery_started','authenticator_replaced')),
 locale text NOT NULL CHECK (locale IN ('en','fr','es')),
 state text NOT NULL DEFAULT 'pending' CHECK (state IN ('pending','sending','sent')),
 attempts integer NOT NULL DEFAULT 0 CHECK (attempts>=0),
 available_at timestamptz NOT NULL DEFAULT NOW(),
 lease_until timestamptz,
 created_at timestamptz NOT NULL DEFAULT NOW(),
 sent_at timestamptz
);
CREATE INDEX IF NOT EXISTS auth_mfa_notification_due ON auth_mfa_notification_outbox(state,available_at);
