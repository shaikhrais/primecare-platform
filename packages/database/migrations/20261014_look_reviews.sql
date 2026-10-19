BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-look-manager'));
DO $migration$
DECLARE tenant_type TEXT; actor_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type NOT IN ('uuid','text','character varying') OR actor_type NOT IN ('uuid','text','character varying') OR tenant_type IS NULL OR actor_type IS NULL THEN RAISE EXCEPTION 'Unsupported look identity schema'; END IF;
 EXECUTE format('CREATE TABLE IF NOT EXISTS look_reviews(id UUID PRIMARY KEY,tenant_id %s NOT NULL REFERENCES tenants(id),actor_id %s NOT NULL REFERENCES users(id),screen TEXT NOT NULL,platform TEXT NOT NULL CHECK(platform IN (''web'',''android'',''ios'',''windows'',''macos'',''linux'')),width INTEGER NOT NULL,height INTEGER NOT NULL,scale NUMERIC NOT NULL,locale TEXT NOT NULL,build TEXT NOT NULL,theme TEXT NOT NULL,layout TEXT NOT NULL,rubric_key TEXT NOT NULL,slot_key TEXT NOT NULL,group_key TEXT NOT NULL,image TEXT NOT NULL CHECK(length(image)<=1398104),image_digest TEXT NOT NULL,state TEXT NOT NULL DEFAULT ''pending_ai'' CHECK(state IN (''pending_ai'',''ai_running'',''ai_failed'',''changes_requested'',''ready_human'',''approved'',''rejected'',''superseded'')),current BOOLEAN NOT NULL DEFAULT TRUE,version INTEGER NOT NULL DEFAULT 1,ai_report JSONB,human_actor_id %s REFERENCES users(id),human_evidence TEXT,claimed_at TIMESTAMPTZ,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW())',tenant_type,actor_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS look_audit(id BIGSERIAL PRIMARY KEY,tenant_id %s NOT NULL REFERENCES tenants(id),actor_id %s NOT NULL REFERENCES users(id),review_id UUID NOT NULL REFERENCES look_reviews(id),action TEXT NOT NULL,version INTEGER NOT NULL,evidence TEXT NOT NULL DEFAULT '''',created_at TIMESTAMPTZ NOT NULL DEFAULT NOW())',tenant_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS look_requests(actor_id %s NOT NULL REFERENCES users(id),idempotency_key TEXT NOT NULL,request_hash TEXT NOT NULL,response JSONB NOT NULL,status INTEGER NOT NULL,PRIMARY KEY(actor_id,idempotency_key))',actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS look_rate(actor_id %s PRIMARY KEY REFERENCES users(id),attempts INTEGER NOT NULL,window_start TIMESTAMPTZ NOT NULL)',actor_type);
END $migration$;
CREATE UNIQUE INDEX IF NOT EXISTS look_current_slot ON look_reviews(slot_key) WHERE current;
CREATE INDEX IF NOT EXISTS look_scope_queue ON look_reviews(tenant_id,current,updated_at);
COMMIT;
