BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-screen-text'));
CREATE TABLE IF NOT EXISTS screen_text_catalogs (
 screen_id TEXT PRIMARY KEY, version INTEGER NOT NULL CHECK(version>0),
 locales JSONB NOT NULL CHECK(jsonb_typeof(locales)='object'),
 updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS screen_text_history (
 screen_id TEXT NOT NULL, version INTEGER NOT NULL CHECK(version>0),
 actor_id TEXT NOT NULL, previous_locales JSONB NOT NULL, locales JSONB NOT NULL,
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), PRIMARY KEY(screen_id,version)
);
CREATE TABLE IF NOT EXISTS screen_text_write_rate (
 actor_id TEXT PRIMARY KEY, attempts INTEGER NOT NULL, window_start TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
COMMIT;
