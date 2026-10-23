-- CANDIDATE ONLY: register storage, retention and scoped access in pinned governance
-- before applying. Isolated native acceptance fixtures may apply in a private schema.
-- No grants, recording changes, provider bindings or route activation.
CREATE TABLE IF NOT EXISTS public.business_sales_quality_aggregates (
 tenant_id text NOT NULL,
 id text NOT NULL,
 state jsonb NOT NULL,
 PRIMARY KEY (tenant_id,id),
 CHECK (length(btrim(tenant_id)) BETWEEN 1 AND 200),
 CHECK (length(btrim(id)) BETWEEN 1 AND 200),
 CHECK (jsonb_typeof(state)='object' AND state ?& ARRAY['tenantId','id','kind','version','ownerId','callId','rubricDigest','transcriptDigest','report']),
 CHECK (jsonb_typeof(state->'tenantId')='string' AND jsonb_typeof(state->'id')='string' AND state->>'tenantId'=tenant_id AND state->>'id'=id),
 CHECK (state->>'kind'='sales_call_quality'),
 CHECK (jsonb_typeof(state->'version')='number' AND (state->>'version') ~ '^[1-9][0-9]*$' AND (state->>'version')::numeric <= 9007199254740991),
 CHECK (state->>'rubricDigest' ~ '^[a-f0-9]{64}$' AND state->>'transcriptDigest' ~ '^[a-f0-9]{64}$')
);
CREATE TABLE IF NOT EXISTS public.business_sales_quality_commands (
 tenant_id text NOT NULL,
 aggregate_id text NOT NULL,
 command_key text NOT NULL,
 actor_id text NOT NULL,
 fingerprint text NOT NULL,
 result jsonb NOT NULL,
 PRIMARY KEY (tenant_id,aggregate_id,command_key),
 FOREIGN KEY (tenant_id,aggregate_id) REFERENCES public.business_sales_quality_aggregates(tenant_id,id),
 CHECK (length(btrim(command_key)) BETWEEN 1 AND 200),
 CHECK (length(btrim(actor_id)) BETWEEN 1 AND 200),
 CHECK (fingerprint ~ '^[a-f0-9]{64}$'),
 CHECK (jsonb_typeof(result)='object')
);
CREATE TABLE IF NOT EXISTS public.business_sales_quality_events (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 tenant_id text NOT NULL,
 aggregate_id text NOT NULL,
 actor_id text NOT NULL,
 event_type text NOT NULL,
 version bigint NOT NULL,
 created_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE (tenant_id,aggregate_id,version),
 FOREIGN KEY (tenant_id,aggregate_id) REFERENCES public.business_sales_quality_aggregates(tenant_id,id),
 CHECK (length(btrim(actor_id)) BETWEEN 1 AND 200),
 CHECK (length(btrim(event_type)) BETWEEN 1 AND 200),
 CHECK (version BETWEEN 1 AND 9007199254740991)
);
