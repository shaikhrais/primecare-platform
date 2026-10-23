-- Candidate only. Native app auth + explicit consent required before inserting.
-- Neither an AI model nor provider tool credentials may approve an action.
CREATE TABLE communication_voice_confirmations (
 intent_id text PRIMARY KEY REFERENCES communication_voice_tasks(id),
 digest text NOT NULL CHECK(digest ~ '^[a-f0-9]{64}$'),
 call_sid text NOT NULL CHECK(call_sid ~ '^CA[a-fA-F0-9]{32}$'),
 session_id text NOT NULL,user_id text NOT NULL,tenant_id text NOT NULL,
 approved_at bigint NOT NULL,expires_at bigint NOT NULL,consumed_at bigint,
 CHECK(expires_at>approved_at AND expires_at<=approved_at+60000),
 CHECK(consumed_at IS NULL OR consumed_at>=approved_at)
);
