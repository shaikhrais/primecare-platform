-- Native first-time phone enrollment only. No model, contact seeds or grants.
CREATE TABLE communication_voice_contact_challenges (
 id text PRIMARY KEY CHECK(id ~ '^[a-f0-9-]{36}$'),
 tenant_id text NOT NULL,user_id text NOT NULL,session_hash text NOT NULL CHECK(session_hash ~ '^[a-f0-9]{64}$'),
 request_id text NOT NULL CHECK(request_id ~ '^[a-fA-F0-9-]{36}$'),phone text NOT NULL CHECK(phone ~ '^\+[1-9][0-9]{6,14}$'),
 state text NOT NULL CHECK(state IN ('sending','pending','checking','verified','unknown')),
 verification_sid text UNIQUE CHECK(verification_sid ~ '^VE[a-fA-F0-9]{32}$'),
 check_attempts integer NOT NULL DEFAULT 0 CHECK(check_attempts BETWEEN 0 AND 5),
 expires_at bigint NOT NULL,created_at timestamptz NOT NULL DEFAULT now(),updated_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE(tenant_id,user_id,request_id),
 CHECK(state NOT IN ('pending','checking','verified') OR verification_sid IS NOT NULL)
);
