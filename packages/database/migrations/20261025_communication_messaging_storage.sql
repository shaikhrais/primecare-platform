-- Generated additive messaging storage bundle. Do not edit; regenerate from reviewed sources.

-- Reviewed source: 20261022_business_communications.sql
-- Apply only after exact pinned production governance registration.
-- No grants, user records or communication content are changed by this DDL.
CREATE TABLE IF NOT EXISTS public.business_work_aggregates (
 tenant_id text NOT NULL,
 id text NOT NULL,
 state jsonb NOT NULL,
 PRIMARY KEY (tenant_id,id),
 CHECK (length(btrim(tenant_id)) BETWEEN 1 AND 200),
 CHECK (length(btrim(id)) BETWEEN 1 AND 200),
 CHECK (jsonb_typeof(state)='object' AND state ?& ARRAY['tenantId','id','kind','version']),
 CHECK (jsonb_typeof(state->'tenantId')='string' AND jsonb_typeof(state->'id')='string' AND state->>'tenantId'=tenant_id AND state->>'id'=id),
 CHECK (jsonb_typeof(state->'kind')='string' AND state->>'kind' IN ('workflow','conversation','outbound_mail','inbound_mail')),
 CHECK (jsonb_typeof(state->'version')='number' AND (state->>'version') ~ '^[1-9][0-9]*$' AND (state->>'version')::numeric <= 9007199254740991)
);
CREATE TABLE IF NOT EXISTS public.business_work_commands (
 tenant_id text NOT NULL,
 aggregate_id text NOT NULL,
 command_key text NOT NULL,
 actor_id text NOT NULL,
 fingerprint text NOT NULL,
 result jsonb NOT NULL,
 PRIMARY KEY (tenant_id,aggregate_id,command_key),
 FOREIGN KEY (tenant_id,aggregate_id) REFERENCES public.business_work_aggregates(tenant_id,id),
 CHECK (length(btrim(command_key)) BETWEEN 1 AND 200),
 CHECK (length(btrim(actor_id)) BETWEEN 1 AND 200),
 CHECK (fingerprint ~ '^[0-9a-f]{64}$'),
 CHECK (jsonb_typeof(result)='object')
);
CREATE TABLE IF NOT EXISTS public.business_work_events (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 tenant_id text NOT NULL,
 aggregate_id text NOT NULL,
 actor_id text NOT NULL,
 event_type text NOT NULL,
 version bigint NOT NULL,
 created_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE (tenant_id,aggregate_id,version),
 FOREIGN KEY (tenant_id,aggregate_id) REFERENCES public.business_work_aggregates(tenant_id,id),
 CHECK (length(btrim(actor_id)) BETWEEN 1 AND 200),
 CHECK (length(btrim(event_type)) BETWEEN 1 AND 200),
 CHECK (version BETWEEN 1 AND 9007199254740991)
);

-- Reviewed source: 20261023_business_sms.sql
-- Apply only after exact pinned production governance registration.
-- No grants, user records or communication content are changed by this DDL.
CREATE TABLE IF NOT EXISTS public.business_sms_aggregates (
 tenant_id text NOT NULL,
 id text NOT NULL,
 state jsonb NOT NULL,
 PRIMARY KEY (tenant_id,id),
 CHECK (length(btrim(tenant_id)) BETWEEN 1 AND 200),
 CHECK (length(btrim(id)) BETWEEN 1 AND 200),
 CHECK (jsonb_typeof(state)='object' AND state ?& ARRAY['tenantId','id','kind','version']),
 CHECK (jsonb_typeof(state->'tenantId')='string' AND jsonb_typeof(state->'id')='string' AND state->>'tenantId'=tenant_id AND state->>'id'=id),
 CHECK (jsonb_typeof(state->'kind')='string' AND state->>'kind' IN ('outbound_sms')),
 CHECK (jsonb_typeof(state->'version')='number' AND (state->>'version') ~ '^[1-9][0-9]*$' AND (state->>'version')::numeric <= 9007199254740991)
);
CREATE TABLE IF NOT EXISTS public.business_sms_commands (
 tenant_id text NOT NULL,
 aggregate_id text NOT NULL,
 command_key text NOT NULL,
 actor_id text NOT NULL,
 fingerprint text NOT NULL,
 result jsonb NOT NULL,
 PRIMARY KEY (tenant_id,aggregate_id,command_key),
 FOREIGN KEY (tenant_id,aggregate_id) REFERENCES public.business_sms_aggregates(tenant_id,id),
 CHECK (length(btrim(command_key)) BETWEEN 1 AND 200),
 CHECK (length(btrim(actor_id)) BETWEEN 1 AND 200),
 CHECK (fingerprint ~ '^[0-9a-f]{64}$'),
 CHECK (jsonb_typeof(result)='object')
);
CREATE TABLE IF NOT EXISTS public.business_sms_events (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 tenant_id text NOT NULL,
 aggregate_id text NOT NULL,
 actor_id text NOT NULL,
 event_type text NOT NULL,
 version bigint NOT NULL,
 created_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE (tenant_id,aggregate_id,version),
 FOREIGN KEY (tenant_id,aggregate_id) REFERENCES public.business_sms_aggregates(tenant_id,id),
 CHECK (length(btrim(actor_id)) BETWEEN 1 AND 200),
 CHECK (length(btrim(event_type)) BETWEEN 1 AND 200),
 CHECK (version BETWEEN 1 AND 9007199254740991)
);
-- Shared-number callbacks resolve only through unique persisted provider receipts.
CREATE UNIQUE INDEX IF NOT EXISTS business_sms_provider_receipt
 ON public.business_sms_aggregates ((state->>'accountSid'),(state->>'providerMessageId'))
 WHERE state->>'providerMessageId' IS NOT NULL;
CREATE TABLE IF NOT EXISTS public.business_sms_callbacks (
 digest text PRIMARY KEY CHECK (digest ~ '^[0-9a-f]{64}$'),
 observation jsonb NOT NULL CHECK (jsonb_typeof(observation)='object'),
 processed boolean NOT NULL DEFAULT false,
 received_at timestamptz NOT NULL DEFAULT now()
);

-- Reviewed source: 20261024_communication_sms_inbox.sql
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

-- Reviewed source: 20261024_communication_ai_turns.sql
-- Apply only after exact pinned production governance registration.
-- No grants, user records or communication content are changed by this DDL.
CREATE TABLE IF NOT EXISTS public.business_chat_aggregates (
 tenant_id text NOT NULL,
 id text NOT NULL,
 state jsonb NOT NULL,
 PRIMARY KEY (tenant_id,id),
 CHECK (length(btrim(tenant_id)) BETWEEN 1 AND 200),
 CHECK (length(btrim(id)) BETWEEN 1 AND 200),
 CHECK (jsonb_typeof(state)='object' AND state ?& ARRAY['tenantId','id','kind','version']),
 CHECK (jsonb_typeof(state->'tenantId')='string' AND jsonb_typeof(state->'id')='string' AND state->>'tenantId'=tenant_id AND state->>'id'=id),
 CHECK (jsonb_typeof(state->'kind')='string' AND state->>'kind' IN ('messaging_ai_turn')),
 CHECK (jsonb_typeof(state->'version')='number' AND (state->>'version') ~ '^[1-9][0-9]*$' AND (state->>'version')::numeric <= 9007199254740991)
);
CREATE TABLE IF NOT EXISTS public.business_chat_commands (
 tenant_id text NOT NULL,
 aggregate_id text NOT NULL,
 command_key text NOT NULL,
 actor_id text NOT NULL,
 fingerprint text NOT NULL,
 result jsonb NOT NULL,
 PRIMARY KEY (tenant_id,aggregate_id,command_key),
 FOREIGN KEY (tenant_id,aggregate_id) REFERENCES public.business_chat_aggregates(tenant_id,id),
 CHECK (length(btrim(command_key)) BETWEEN 1 AND 200),
 CHECK (length(btrim(actor_id)) BETWEEN 1 AND 200),
 CHECK (fingerprint ~ '^[0-9a-f]{64}$'),
 CHECK (jsonb_typeof(result)='object')
);
CREATE TABLE IF NOT EXISTS public.business_chat_events (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 tenant_id text NOT NULL,
 aggregate_id text NOT NULL,
 actor_id text NOT NULL,
 event_type text NOT NULL,
 version bigint NOT NULL,
 created_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE (tenant_id,aggregate_id,version),
 FOREIGN KEY (tenant_id,aggregate_id) REFERENCES public.business_chat_aggregates(tenant_id,id),
 CHECK (length(btrim(actor_id)) BETWEEN 1 AND 200),
 CHECK (length(btrim(event_type)) BETWEEN 1 AND 200),
 CHECK (version BETWEEN 1 AND 9007199254740991)
);

-- Reviewed source: 20261024_communication_sms_links.sql
-- Candidate only; apply after pinned storage/access registration. No accounts,
-- contacts, native sessions, links, consent records, grants or routing are seeded.
CREATE TABLE IF NOT EXISTS public.communication_sms_consent (
 account_sid text NOT NULL CHECK(account_sid ~ '^AC[0-9a-fA-F]{32}$'),
 shared_number text NOT NULL CHECK(shared_number ~ '^\+[1-9][0-9]{1,14}$'),
 phone text NOT NULL CHECK(phone ~ '^\+[1-9][0-9]{1,14}$'),
 blocked boolean NOT NULL,
 version bigint NOT NULL CHECK(version BETWEEN 1 AND 9007199254740990),
 updated_at timestamptz NOT NULL DEFAULT clock_timestamp(),
 PRIMARY KEY(account_sid,shared_number,phone)
);
CREATE TABLE IF NOT EXISTS public.communication_sms_links (
 id text PRIMARY KEY CHECK(id ~ '^[a-f0-9-]{36}$'),
 tenant_id text NOT NULL CHECK(length(btrim(tenant_id)) BETWEEN 1 AND 200),
 user_id text NOT NULL CHECK(length(btrim(user_id)) BETWEEN 1 AND 200),
 conversation_id text NOT NULL CHECK(length(btrim(conversation_id)) BETWEEN 1 AND 200),
 account_sid text NOT NULL CHECK(account_sid ~ '^AC[0-9a-fA-F]{32}$'),
 messaging_service_sid text NOT NULL CHECK(messaging_service_sid ~ '^MG[0-9a-fA-F]{32}$'),
 shared_number text NOT NULL CHECK(shared_number ~ '^\+[1-9][0-9]{1,14}$'),
 phone text NOT NULL CHECK(phone ~ '^\+[1-9][0-9]{1,14}$'),
 contact_version bigint NOT NULL CHECK(contact_version BETWEEN 1 AND 9007199254740990),
 consent_version bigint NOT NULL CHECK(consent_version BETWEEN 1 AND 9007199254740990),
 version bigint NOT NULL DEFAULT 1 CHECK(version BETWEEN 1 AND 9007199254740990),
 consented_at timestamptz NOT NULL DEFAULT clock_timestamp(),
 revoked_at timestamptz,
 FOREIGN KEY(account_sid,shared_number,phone)
  REFERENCES public.communication_sms_consent(account_sid,shared_number,phone),
 FOREIGN KEY(tenant_id,user_id)
  REFERENCES public.communication_voice_verified_contacts(tenant_id,user_id)
);
-- One active selected account/conversation per provider address pair, globally.
-- A shared phone cannot silently choose among multiple tenants or users.
CREATE UNIQUE INDEX IF NOT EXISTS communication_sms_unique_active_address
 ON public.communication_sms_links(account_sid,shared_number,phone) WHERE revoked_at IS NULL;
