CREATE TABLE IF NOT EXISTS auth_rate_limits (
  subject_hash TEXT PRIMARY KEY,
  attempts INTEGER NOT NULL CHECK(attempts>0),
  reset_at TIMESTAMPTZ NOT NULL
);
CREATE INDEX IF NOT EXISTS auth_rate_limits_reset_at_idx ON auth_rate_limits(reset_at);
