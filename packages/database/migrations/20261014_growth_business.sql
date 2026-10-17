BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-growth-marketing'));
DO $migration$
DECLARE tenant_type TEXT; actor_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type NOT IN ('uuid','text','character varying') OR actor_type NOT IN ('uuid','text','character varying') OR tenant_type IS NULL OR actor_type IS NULL THEN RAISE EXCEPTION 'Unsupported growth identity schema'; END IF;
 EXECUTE format('CREATE TABLE IF NOT EXISTS growth_partner_onboarding(id UUID PRIMARY KEY,tenant_id %s NOT NULL REFERENCES tenants(id),lead_id UUID NOT NULL REFERENCES growth_leads(id),business_kind TEXT NOT NULL CHECK(business_kind IN (''nurse'',''retired_nurse'',''care_entrepreneur'')),state TEXT NOT NULL DEFAULT ''verified'' CHECK(state IN (''verified'',''revoked'',''provisioned'')),evidence TEXT NOT NULL,reviewed_contact_version INTEGER NOT NULL,verified_by %s NOT NULL REFERENCES users(id),version INTEGER NOT NULL DEFAULT 1,provisioned_tenant_id %s REFERENCES tenants(id),provisioned_user_id %s REFERENCES users(id),created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),UNIQUE(tenant_id,lead_id))',tenant_type,actor_type,tenant_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS growth_care_handoffs(id UUID PRIMARY KEY,tenant_id %s NOT NULL REFERENCES tenants(id),lead_id UUID NOT NULL REFERENCES growth_leads(id),visit_id TEXT NOT NULL,evidence TEXT NOT NULL,actor_id %s NOT NULL REFERENCES users(id),created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),UNIQUE(tenant_id,visit_id))',tenant_type,actor_type);
 EXECUTE format('CREATE TABLE IF NOT EXISTS growth_finance_entries(id UUID PRIMARY KEY,tenant_id %s NOT NULL REFERENCES tenants(id),actor_id %s NOT NULL REFERENCES users(id),kind TEXT NOT NULL CHECK(kind IN (''invoice'',''payment'',''refund'',''expense'')),reference TEXT NOT NULL,amount_cents BIGINT NOT NULL CHECK(amount_cents>0 AND amount_cents<=1000000000),record_date DATE NOT NULL,lead_id UUID REFERENCES growth_leads(id),invoice_id UUID REFERENCES growth_finance_entries(id),category TEXT,evidence TEXT NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),UNIQUE(tenant_id,reference),CHECK((kind=''invoice'' AND lead_id IS NOT NULL AND invoice_id IS NULL AND category IS NULL) OR (kind IN (''payment'',''refund'') AND lead_id IS NOT NULL AND invoice_id IS NOT NULL AND category IS NULL) OR (kind=''expense'' AND lead_id IS NULL AND invoice_id IS NULL AND category IN (''care_delivery'',''overhead''))))',tenant_type,actor_type);
END $migration$;
CREATE INDEX IF NOT EXISTS growth_onboarding_state ON growth_partner_onboarding(state,created_at);
CREATE INDEX IF NOT EXISTS growth_finance_scope ON growth_finance_entries(tenant_id,invoice_id,record_date);
COMMIT;
