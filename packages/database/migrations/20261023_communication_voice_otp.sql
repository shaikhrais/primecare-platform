-- Candidate only. Contact records may be written only by separately authorized
-- verified-account onboarding, never populated from a voice/model request.
CREATE TABLE communication_voice_verified_contacts (
 tenant_id text NOT NULL,user_id text NOT NULL,phone text NOT NULL CHECK(phone ~ '^\+[1-9][0-9]{1,14}$' AND phone !~ '[[:space:]]'),
 version bigint NOT NULL CHECK(version BETWEEN 1 AND 9007199254740990),verified_at timestamptz NOT NULL,revoked_at timestamptz,
 PRIMARY KEY(tenant_id,user_id)
);
CREATE TABLE communication_voice_otp (
 call_sid text PRIMARY KEY CHECK(call_sid ~ '^CA[0-9a-fA-F]{32}$'),
 pairing_hash text NOT NULL CHECK(pairing_hash ~ '^[a-f0-9]{64}$'),
 state text NOT NULL DEFAULT 'issued' CHECK(state IN ('issued','sending','pending','checking','verified','unknown')),
 pairing_attempts integer NOT NULL DEFAULT 0 CHECK(pairing_attempts BETWEEN 0 AND 5),
 check_attempts integer NOT NULL DEFAULT 0 CHECK(check_attempts BETWEEN 0 AND 5),
 native_session_hash text CHECK(native_session_hash ~ '^[a-f0-9]{64}$'),user_id text,tenant_id text,phone text,contact_version bigint,
 verification_sid text UNIQUE CHECK(verification_sid ~ '^VE[0-9a-fA-F]{32}$'),grant_id text,
 expires_at bigint NOT NULL,created_at timestamptz NOT NULL DEFAULT now(),
 CHECK(state='issued' OR native_session_hash IS NOT NULL AND user_id IS NOT NULL AND tenant_id IS NOT NULL AND phone IS NOT NULL AND contact_version IS NOT NULL AND contact_version>0),
 CHECK(state NOT IN ('pending','checking','verified') OR verification_sid IS NOT NULL),
 CHECK(state<>'verified' OR grant_id IS NOT NULL)
);
CREATE TABLE communication_voice_otp_limits (
 phone text PRIMARY KEY,window_start timestamptz NOT NULL,sends integer NOT NULL CHECK(sends>0)
);
