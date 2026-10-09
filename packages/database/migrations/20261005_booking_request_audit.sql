-- Additive: text identifiers support the registered domain model and either
-- auth identity representation. Audit history survives business-row deletion.
CREATE TABLE IF NOT EXISTS booking_request_audit (
  id BIGSERIAL PRIMARY KEY,
  request_id TEXT NOT NULL,
  actor_user_id TEXT NOT NULL,
  tenant_id TEXT NOT NULL,
  action TEXT NOT NULL CHECK (action IN ('created','cancelled')),
  previous_status TEXT,
  new_status TEXT NOT NULL,
  idempotency_key TEXT NOT NULL,
  request_hash TEXT NOT NULL,
  response_json JSONB NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(actor_user_id,tenant_id,idempotency_key)
);
CREATE INDEX IF NOT EXISTS booking_request_audit_owner_request_idx
  ON booking_request_audit(tenant_id,actor_user_id,request_id,created_at,id);
