-- Disposable acceptance schema only. Not an approved production migration.
CREATE TABLE business_work_aggregates (
 tenant_id text NOT NULL, id text NOT NULL, state jsonb NOT NULL,
 PRIMARY KEY(tenant_id,id),
 CHECK(state->>'tenantId'=tenant_id AND state->>'id'=id)
);
CREATE TABLE business_work_commands (
 tenant_id text NOT NULL, aggregate_id text NOT NULL, command_key text NOT NULL,
 actor_id text NOT NULL, fingerprint text NOT NULL, result jsonb NOT NULL,
 PRIMARY KEY(tenant_id,aggregate_id,command_key)
);
CREATE TABLE business_work_events (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 tenant_id text NOT NULL, aggregate_id text NOT NULL, actor_id text NOT NULL,
 event_type text NOT NULL, version integer NOT NULL,
 created_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE(tenant_id,aggregate_id,version)
);
