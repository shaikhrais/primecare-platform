-- Requires platform administration, territory catalog/sales and growth migrations.
BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-first-platform-bundle'));
DO $migration$
DECLARE tenant_type TEXT; actor_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type NOT IN ('uuid','text','character varying') OR actor_type NOT IN ('uuid','text','character varying') OR tenant_type IS NULL OR actor_type IS NULL THEN RAISE EXCEPTION 'Unsupported platform identity schema'; END IF;
 EXECUTE format('CREATE TABLE IF NOT EXISTS platform_launch (
 tenant_id %s PRIMARY KEY REFERENCES tenants(id),training_evidence TEXT NOT NULL DEFAULT '''',
 state TEXT NOT NULL DEFAULT ''draft'' CHECK(state IN (''draft'',''submitted'',''approved'')),
 version INTEGER NOT NULL DEFAULT 1 CHECK(version>0),submitted_by %s REFERENCES users(id),approved_by %s REFERENCES users(id),
 approved_fingerprint TEXT,updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW())',tenant_type,actor_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS platform_documents (
 id UUID PRIMARY KEY,tenant_id %s NOT NULL REFERENCES tenants(id),kind TEXT NOT NULL CHECK(kind IN (''agreement'',''insurance'')),
 revision INTEGER NOT NULL CHECK(revision>0),filename TEXT NOT NULL,media_type TEXT NOT NULL CHECK(media_type IN (''application/pdf'',''image/png'',''image/jpeg'')),
 content BYTEA NOT NULL CHECK(octet_length(content) BETWEEN 1 AND 2097152),content_hash TEXT NOT NULL,expires_on DATE NOT NULL,
 status TEXT NOT NULL DEFAULT ''pending'' CHECK(status IN (''pending'',''approved'',''rejected'')),version INTEGER NOT NULL DEFAULT 1 CHECK(version>0),
 uploaded_by %s NOT NULL REFERENCES users(id),reviewed_by %s REFERENCES users(id),review_evidence TEXT NOT NULL DEFAULT '''',
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),UNIQUE(tenant_id,kind,revision))',tenant_type,actor_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS platform_support_tickets (
 id UUID PRIMARY KEY,tenant_id %s NOT NULL REFERENCES tenants(id),subject TEXT NOT NULL CHECK(length(subject) BETWEEN 1 AND 150),
 priority TEXT NOT NULL CHECK(priority IN (''normal'',''urgent'')),status TEXT NOT NULL DEFAULT ''open'' CHECK(status IN (''open'',''in_progress'',''resolved'')),
 owner_id %s REFERENCES users(id),created_by %s NOT NULL REFERENCES users(id),version INTEGER NOT NULL DEFAULT 1 CHECK(version>0),
 cycle_start TIMESTAMPTZ NOT NULL DEFAULT NOW(),response_due TIMESTAMPTZ NOT NULL,resolution_due TIMESTAMPTZ NOT NULL,
 first_response_at TIMESTAMPTZ,resolved_at TIMESTAMPTZ,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),UNIQUE(tenant_id,id))',tenant_type,actor_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS platform_support_messages (
 id UUID PRIMARY KEY,tenant_id %s NOT NULL,ticket_id UUID NOT NULL,actor_id %s NOT NULL REFERENCES users(id),
 message TEXT NOT NULL CHECK(length(message) BETWEEN 1 AND 2000),created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
 FOREIGN KEY(tenant_id,ticket_id) REFERENCES platform_support_tickets(tenant_id,id))',tenant_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS platform_routed_enquiries (
 id UUID PRIMARY KEY,name TEXT NOT NULL,email TEXT NOT NULL,phone TEXT NOT NULL,postal_code TEXT NOT NULL,fsa TEXT NOT NULL,
 service TEXT NOT NULL CHECK(service IN (''psw'',''home_care'')),consent TEXT NOT NULL CHECK(length(consent) BETWEEN 1 AND 500),
 contact_hash TEXT NOT NULL UNIQUE,territory_id TEXT REFERENCES platform_territory_catalog(id),tenant_id %s REFERENCES tenants(id),
 status TEXT NOT NULL CHECK(status IN (''unmatched'',''pending'',''accepted'',''declined'',''withdrawn'')),reason TEXT NOT NULL,
 offer_due TIMESTAMPTZ,accepted_by %s REFERENCES users(id),lead_id UUID REFERENCES growth_leads(id),
 version INTEGER NOT NULL DEFAULT 1 CHECK(version>0),created_by %s NOT NULL REFERENCES users(id),created_at TIMESTAMPTZ NOT NULL DEFAULT NOW())',tenant_type,actor_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS platform_bundle_audit (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(),actor_id %s NOT NULL REFERENCES users(id),tenant_id %s REFERENCES tenants(id),
 target_id TEXT NOT NULL,action TEXT NOT NULL,evidence TEXT NOT NULL DEFAULT '''',state JSONB NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW())',actor_type,tenant_type);
END $migration$;
CREATE TABLE IF NOT EXISTS platform_bundle_requests(actor_id TEXT NOT NULL,idempotency_key TEXT NOT NULL,request_hash TEXT NOT NULL,response JSONB NOT NULL,status INTEGER NOT NULL CHECK(status IN (200,201)),PRIMARY KEY(actor_id,idempotency_key));
CREATE TABLE IF NOT EXISTS platform_bundle_rate(bucket TEXT PRIMARY KEY,attempts INTEGER NOT NULL,window_start TIMESTAMPTZ NOT NULL DEFAULT NOW());
CREATE INDEX IF NOT EXISTS platform_documents_tenant ON platform_documents(tenant_id,kind,revision DESC);
CREATE INDEX IF NOT EXISTS platform_tickets_tenant_due ON platform_support_tickets(tenant_id,status,resolution_due,id);
CREATE INDEX IF NOT EXISTS platform_support_message_ticket ON platform_support_messages(ticket_id,created_at,id);
CREATE INDEX IF NOT EXISTS platform_routes_tenant_due ON platform_routed_enquiries(tenant_id,status,offer_due,id);
CREATE INDEX IF NOT EXISTS platform_bundle_audit_target ON platform_bundle_audit(target_id,created_at,id);
COMMIT;
