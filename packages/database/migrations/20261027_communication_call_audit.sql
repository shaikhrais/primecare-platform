-- Append-only through the application repository. No public SELECT grant.
CREATE TABLE IF NOT EXISTS public.communication_call_audit (
 call_id text NOT NULL CHECK(length(call_id) BETWEEN 1 AND 100),
 sequence bigint NOT NULL CHECK(sequence>0),
 event_key text NOT NULL CHECK(event_key ~ '^[a-f0-9]{64}$'),
 previous_hash text NOT NULL CHECK(previous_hash ~ '^[a-f0-9]{64}$'),
 event_hash text NOT NULL CHECK(event_hash ~ '^[a-f0-9]{64}$'),
 payload jsonb NOT NULL CHECK(jsonb_typeof(payload)='object'),
 received_at timestamptz NOT NULL DEFAULT clock_timestamp(),
 PRIMARY KEY(call_id,sequence),
 UNIQUE(event_key)
);
