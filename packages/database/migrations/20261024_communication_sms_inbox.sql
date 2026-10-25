-- Apply only after pinned production governance registration. No route, tenant
-- assignment, account linking, grants or AI processing is enabled by this DDL.
CREATE TABLE IF NOT EXISTS public.business_sms_inbox (
 account_sid text NOT NULL CHECK (account_sid ~ '^AC[0-9a-fA-F]{32}$'),
 message_sid text NOT NULL CHECK (message_sid ~ '^SM[0-9a-fA-F]{32}$'),
 fingerprint text NOT NULL CHECK (fingerprint ~ '^[0-9a-f]{64}$'),
 event jsonb NOT NULL CHECK (jsonb_typeof(event)='object'),
 disposition text NOT NULL CHECK (disposition IN ('pending','control','quarantined')),
 duplicate_count integer NOT NULL DEFAULT 0 CHECK (duplicate_count>=0),
 received_at timestamptz NOT NULL DEFAULT now(),
 PRIMARY KEY (account_sid,message_sid),
 CHECK (event->>'accountSid'=account_sid AND event->>'messageSid'=message_sid)
);
CREATE INDEX IF NOT EXISTS business_sms_inbox_pending
 ON public.business_sms_inbox(received_at,account_sid,message_sid) WHERE disposition='pending';
