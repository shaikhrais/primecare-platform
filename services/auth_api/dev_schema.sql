-- Local auth-only development schema. Do not apply to a full PrimeCare database.
CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT UNIQUE NOT NULL,
  roles TEXT NOT NULL DEFAULT 'client',
  password_hash TEXT,
  status TEXT NOT NULL DEFAULT 'active'
);
