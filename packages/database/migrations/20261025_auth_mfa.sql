CREATE TABLE IF NOT EXISTS auth_mfa_credentials (
 user_id text PRIMARY KEY,
 tenant_id text NOT NULL,
 envelope jsonb NOT NULL,
 enabled boolean NOT NULL DEFAULT false,
 last_counter bigint NOT NULL DEFAULT -1 CHECK(last_counter>=-1),
 created_at timestamptz NOT NULL DEFAULT NOW(),
 enabled_at timestamptz
);
CREATE TABLE IF NOT EXISTS auth_mfa_challenges (
 token_hash text PRIMARY KEY,
 user_id text NOT NULL,
 tenant_id text NOT NULL,
 role text NOT NULL,
 password_version text NOT NULL,
 purpose text NOT NULL CHECK(purpose IN ('enroll','verify')),
 attempts integer NOT NULL DEFAULT 0 CHECK(attempts BETWEEN 0 AND 5),
 expires_at timestamptz NOT NULL,
 created_at timestamptz NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS auth_mfa_challenges_expiry ON auth_mfa_challenges(expires_at);
CREATE TABLE IF NOT EXISTS auth_mfa_audit (
 id text PRIMARY KEY,
 user_id text NOT NULL,
 tenant_id text NOT NULL,
 action text NOT NULL CHECK(action IN ('mfa_enrollment_started','mfa_enrolled','mfa_verification_failed','mfa_verified')),
 created_at timestamptz NOT NULL DEFAULT NOW()
);
