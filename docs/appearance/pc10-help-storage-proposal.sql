-- Candidate for reviewed migration. This copy is executable ONLY in an isolated fixture.
DO $$ BEGIN
 IF current_setting('primecare.help_storage_fixture',true) IS DISTINCT FROM '1' THEN
  RAISE EXCEPTION 'Help storage proposal requires an isolated fixture';
 END IF;
END $$;
CREATE TABLE public.help_reader_rate (
 tenant_id text NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
 user_id text NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
 attempts integer NOT NULL CHECK(attempts BETWEEN 1 AND 31),
 reset_at timestamptz NOT NULL,
 PRIMARY KEY(tenant_id,user_id)
);
CREATE TABLE public.help_reader_audit (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 tenant_id text NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
 user_id text NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
 action text NOT NULL CHECK(action IN ('list','read')),
 locale text NOT NULL CHECK(locale IN ('en','fr','es')),
 returned integer NOT NULL CHECK(returned BETWEEN 0 AND 100 AND (action<>'read' OR returned=1)),
 created_at timestamptz NOT NULL DEFAULT statement_timestamp(),
 expires_at timestamptz NOT NULL DEFAULT statement_timestamp()+interval '2592000 seconds',
 CHECK(expires_at=created_at+interval '2592000 seconds')
);
CREATE INDEX help_reader_audit_expiry ON public.help_reader_audit(expires_at);
COMMENT ON TABLE public.help_reader_rate IS 'primecare.help-reader.operational-policy.v1';
COMMENT ON TABLE public.help_reader_audit IS 'primecare.help-reader.operational-policy.v1';
