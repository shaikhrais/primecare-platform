-- Candidate only. No task definitions, permissions or AI tools enabled.
CREATE TABLE communication_voice_tasks (
 id text PRIMARY KEY,
 digest text NOT NULL CHECK(digest ~ '^[0-9a-f]{64}$'),
 status text NOT NULL CHECK(status IN ('proposed','executing','completed','unknown')),
 intent jsonb NOT NULL CHECK(jsonb_typeof(intent)='object' AND intent->>'id'=id AND intent->>'digest'=digest),
 created_at timestamptz NOT NULL DEFAULT now(),updated_at timestamptz NOT NULL DEFAULT now()
);
