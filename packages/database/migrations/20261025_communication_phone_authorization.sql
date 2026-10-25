-- Candidate only: register exact schema/permissions before production activation.
-- Separate from app-paired OTP; never fabricate a native auth_sessions record.
CREATE TABLE communication_phone_authorizations (
 call_sid text PRIMARY KEY CHECK(call_sid ~ '^CA[a-fA-F0-9]{32}$'),
 state text NOT NULL CHECK(state IN ('sending','pending','checking','verified','unknown')),
 account_reference text NOT NULL CHECK(account_reference ~ '^[1-9][0-9]{3}$'),
 directory_version bigint NOT NULL CHECK(directory_version>0),
 tenant_id text NOT NULL,user_id text NOT NULL,phone text NOT NULL CHECK(phone ~ '^\+[1-9][0-9]{1,14}$'),
 contact_version bigint NOT NULL CHECK(contact_version>0),
 verification_sid text UNIQUE CHECK(verification_sid ~ '^VE[a-fA-F0-9]{32}$'),
 session_id text,expires_at bigint NOT NULL,
 check_attempts integer NOT NULL DEFAULT 0 CHECK(check_attempts BETWEEN 0 AND 5),
 created_at timestamptz NOT NULL DEFAULT now(),
 CHECK(state NOT IN ('pending','checking','verified') OR verification_sid IS NOT NULL),
 CHECK(state<>'verified' OR session_id IS NOT NULL)
);
CREATE TABLE communication_spoken_confirmations (
 call_sid text PRIMARY KEY CHECK(call_sid ~ '^CA[a-fA-F0-9]{32}$'),
 challenge_id uuid NOT NULL UNIQUE,
 intent_id text NOT NULL REFERENCES communication_voice_tasks(id),
 digest text NOT NULL CHECK(digest ~ '^[a-f0-9]{64}$'),
 session_id text NOT NULL,user_id text NOT NULL,tenant_id text NOT NULL,
 state text NOT NULL CHECK(state IN ('prepared','approved','declined','consumed')),
 method text CHECK(method IN ('signed-speech','dtmf')),
 created_at bigint NOT NULL,expires_at bigint NOT NULL,approved_at bigint,
 CHECK(expires_at>created_at AND expires_at<=created_at+60000),
 CHECK(state NOT IN ('approved','consumed') OR method IS NOT NULL AND approved_at IS NOT NULL AND approved_at>=created_at AND approved_at<expires_at)
);
