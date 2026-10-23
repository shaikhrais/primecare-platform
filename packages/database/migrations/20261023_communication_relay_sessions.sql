-- Candidate only. Apply through approved production schema registration/migration.
-- One session per canonical Call; disconnect does not make a claim reusable.
CREATE TABLE communication_relay_sessions (
 call_sid text PRIMARY KEY CHECK (call_sid ~ '^CA[0-9a-fA-F]{32}$'),
 claim_id uuid NOT NULL UNIQUE,
 provider_session_id text NOT NULL UNIQUE CHECK (provider_session_id ~ '^VX[0-9a-fA-F]{32}$'),
 identity_session_id varchar(200) NOT NULL,
 user_id varchar(200) NOT NULL,
 tenant_id varchar(200) NOT NULL,
 started_at bigint NOT NULL,
 expires_at bigint NOT NULL CHECK (expires_at>started_at AND expires_at<=started_at+120000),
 ended_at bigint,
 CHECK (length(identity_session_id)>0 AND length(user_id)>0 AND length(tenant_id)>0)
);
