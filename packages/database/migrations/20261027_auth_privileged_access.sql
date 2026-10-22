-- Short-lived, session-bound capability records. No role or clinical permission grants.
CREATE TABLE IF NOT EXISTS auth_privilege_elevations (
 id text PRIMARY KEY,
 user_id text NOT NULL,
 tenant_id text NOT NULL,
 session_hash text NOT NULL CHECK (session_hash ~ '^[a-f0-9]{64}$'),
 reason text NOT NULL CHECK (length(reason) BETWEEN 10 AND 500),
 scopes jsonb NOT NULL CHECK (scopes='["tenant_security_summary"]'::jsonb),
 created_at timestamptz NOT NULL DEFAULT NOW(),
 expires_at timestamptz NOT NULL,
 revoked_at timestamptz,
 CHECK (expires_at>created_at AND expires_at<=created_at+INTERVAL '15 minutes')
);
CREATE INDEX IF NOT EXISTS auth_privilege_elevations_session ON auth_privilege_elevations(user_id,session_hash,expires_at);
CREATE TABLE IF NOT EXISTS auth_tenant_support_requests (
 id text PRIMARY KEY,
 elevation_id text NOT NULL REFERENCES auth_privilege_elevations(id),
 requester_user_id text NOT NULL,
 requester_tenant_id text NOT NULL,
 requester_session_hash text NOT NULL CHECK (requester_session_hash ~ '^[a-f0-9]{64}$'),
 target_tenant_id text NOT NULL,
 ticket text NOT NULL CHECK (length(ticket) BETWEEN 1 AND 100),
 reason text NOT NULL CHECK (length(reason) BETWEEN 10 AND 500),
 scopes jsonb NOT NULL CHECK (scopes='["tenant_security_summary"]'::jsonb),
 state text NOT NULL DEFAULT 'pending' CHECK (state IN ('pending','approved','revoked')),
 approved_by text,
 approved_at timestamptz,
 revoked_by text,
 revoked_at timestamptz,
 created_at timestamptz NOT NULL DEFAULT NOW(),
 expires_at timestamptz NOT NULL,
 CHECK (expires_at>created_at AND expires_at<=created_at+INTERVAL '15 minutes'),
 CHECK ((state='pending' AND approved_by IS NULL AND approved_at IS NULL AND revoked_by IS NULL AND revoked_at IS NULL) OR
        (state='approved' AND approved_by IS NOT NULL AND approved_at IS NOT NULL AND revoked_by IS NULL AND revoked_at IS NULL) OR
        (state='revoked' AND revoked_by IS NOT NULL AND revoked_at IS NOT NULL))
);
CREATE INDEX IF NOT EXISTS auth_tenant_support_tenant ON auth_tenant_support_requests(target_tenant_id,state,expires_at);
CREATE TABLE IF NOT EXISTS auth_privileged_access_audit (
 id text PRIMARY KEY,
 actor_user_id text NOT NULL,
 actor_tenant_id text NOT NULL,
 target_tenant_id text,
 elevation_id text,
 support_request_id text,
 action text NOT NULL CHECK (action IN ('elevation_issued','elevation_revoked','support_requested','support_approved','support_revoked','security_summary_read','proof_failed')),
 created_at timestamptz NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS auth_privileged_audit_actor ON auth_privileged_access_audit(actor_user_id,created_at);
