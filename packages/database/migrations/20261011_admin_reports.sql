-- Apply through the normal database migration process before enabling report delivery.
-- No clinical records, attachments, tokens or password data are stored here.
CREATE TABLE IF NOT EXISTS report_audit (
 id bigserial PRIMARY KEY, actor_id text NOT NULL, tenant_id text NOT NULL,
 report_id text NOT NULL, operation text NOT NULL CHECK(operation IN ('run','pdf')),
 created_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS report_delivery (
 id bigserial PRIMARY KEY, actor_id text NOT NULL, tenant_id text NOT NULL,
 idempotency_key text NOT NULL, request_hash text NOT NULL, report_id text NOT NULL,
 recipient text NOT NULL, state text NOT NULL CHECK(state IN ('sending','accepted','unknown')),
 message_id text, created_at timestamptz NOT NULL DEFAULT now(), updated_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE(actor_id,tenant_id,idempotency_key)
);
CREATE INDEX IF NOT EXISTS report_delivery_actor_time ON report_delivery(actor_id,tenant_id,created_at);
-- Operational retention must be configured before deployment; restricted access to recipient addresses.
