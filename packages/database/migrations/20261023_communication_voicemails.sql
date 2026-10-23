-- Candidate only. No provider configuration, permissions or production activation.
CREATE TABLE communication_voicemails (
 account_sid text NOT NULL CHECK(account_sid ~ '^AC[0-9a-fA-F]{32}$'),
 call_sid text NOT NULL CHECK(call_sid ~ '^CA[0-9a-fA-F]{32}$'),
 extension text NOT NULL CHECK(extension ~ '^[1-9][0-9]{5}$'),
 tenant_id text NOT NULL, user_id text NOT NULL,
 recording_sid text CHECK(recording_sid ~ '^RE[0-9a-fA-F]{32}$'),
 duration integer CHECK(duration BETWEEN 1 AND 120),
 notification_queued boolean NOT NULL DEFAULT false,
 created_at timestamptz NOT NULL DEFAULT now(),
 PRIMARY KEY(account_sid,call_sid),UNIQUE(account_sid,recording_sid),
 CHECK((recording_sid IS NULL)=(duration IS NULL)),
 CHECK(NOT notification_queued OR recording_sid IS NOT NULL)
);
