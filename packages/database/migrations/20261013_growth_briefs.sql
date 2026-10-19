BEGIN;
SELECT pg_advisory_xact_lock(hashtext('primecare-growth-marketing'));
DO $migration$
DECLARE tenant_type TEXT; actor_type TEXT;
BEGIN
 SELECT format_type(atttypid,atttypmod) INTO tenant_type FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 SELECT format_type(atttypid,atttypmod) INTO actor_type FROM pg_attribute WHERE attrelid='users'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type NOT IN ('uuid','text','character varying') OR actor_type NOT IN ('uuid','text','character varying') OR tenant_type IS NULL OR actor_type IS NULL THEN RAISE EXCEPTION 'Unsupported growth identity schema'; END IF;
 EXECUTE format('CREATE TABLE IF NOT EXISTS growth_campaign_briefs(tenant_id %s NOT NULL,campaign_id UUID NOT NULL,owner_id %s NOT NULL REFERENCES users(id),audience TEXT NOT NULL CHECK(length(audience) BETWEEN 1 AND 1000),offer TEXT NOT NULL CHECK(length(offer) BETWEEN 1 AND 1000),creative TEXT NOT NULL CHECK(length(creative) BETWEEN 1 AND 3000),landing_url TEXT NOT NULL DEFAULT '''' CHECK(length(landing_url)<=2000),pipeline TEXT NOT NULL CHECK(pipeline IN (''tenant'',''client'')),target_leads INTEGER NOT NULL CHECK(target_leads BETWEEN 1 AND 1000000),start_date DATE NOT NULL,end_date DATE NOT NULL,version INTEGER NOT NULL DEFAULT 1 CHECK(version>0),updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),PRIMARY KEY(tenant_id,campaign_id),CHECK(end_date>=start_date AND end_date-start_date<366),FOREIGN KEY(tenant_id,campaign_id) REFERENCES growth_campaigns(tenant_id,id))',tenant_type,actor_type);
END $migration$;
CREATE INDEX IF NOT EXISTS growth_briefs_tenant_owner ON growth_campaign_briefs(tenant_id,owner_id);
COMMIT;
