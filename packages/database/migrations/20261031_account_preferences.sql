-- New owned preference storage only. Existing account, permission and preference rows are preserved.
CREATE TABLE IF NOT EXISTS public.account_preference_documents (
 tenant_id text NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
 user_id text NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
 actor_role text NOT NULL CHECK(length(actor_role) BETWEEN 1 AND 200),
 dataset text NOT NULL CHECK(dataset IN ('live','demo')),
 kind text NOT NULL CHECK(kind IN ('theme','workspace','shortcuts')),
 resource text NOT NULL CHECK(length(resource) BETWEEN 1 AND 128),
 revision bigint NOT NULL CHECK(revision BETWEEN 1 AND 9007199254740991),
 document jsonb CHECK(document IS NULL OR jsonb_typeof(document)='object'),
 updated_at timestamptz NOT NULL DEFAULT clock_timestamp(),
 PRIMARY KEY(tenant_id,user_id,actor_role,dataset,kind,resource)
);
CREATE TABLE IF NOT EXISTS public.account_preference_requests (
 tenant_id text NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
 user_id text NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
 actor_role text NOT NULL,
 dataset text NOT NULL CHECK(dataset IN ('live','demo')),
 request_id uuid NOT NULL,
 fingerprint text NOT NULL CHECK(fingerprint ~ '^[0-9a-f]{64}$'),
 response jsonb NOT NULL CHECK(jsonb_typeof(response)='object'),
 created_at timestamptz NOT NULL DEFAULT clock_timestamp(),
 PRIMARY KEY(tenant_id,user_id,actor_role,dataset,request_id)
);
CREATE INDEX IF NOT EXISTS account_preference_requests_expiry ON public.account_preference_requests(created_at);
CREATE TABLE IF NOT EXISTS public.account_preference_audit (
 id uuid PRIMARY KEY,
 tenant_id text NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
 user_id text NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
 actor_role text NOT NULL,
 dataset text NOT NULL CHECK(dataset IN ('live','demo')),
 kind text NOT NULL CHECK(kind IN ('theme','workspace','shortcuts')),
 resource text NOT NULL,
 request_id uuid NOT NULL,
 action text NOT NULL CHECK(action IN ('write','reset','delete','conflict')),
 revision bigint NOT NULL CHECK(revision BETWEEN 0 AND 9007199254740991),
 document_digest text NOT NULL CHECK(document_digest ~ '^[0-9a-f]{64}$'),
 created_at timestamptz NOT NULL DEFAULT clock_timestamp()
);
CREATE INDEX IF NOT EXISTS account_preference_audit_owner ON public.account_preference_audit(tenant_id,user_id,created_at);
CREATE TABLE IF NOT EXISTS public.account_preference_rate (
 key text PRIMARY KEY CHECK(key ~ '^[0-9a-f]{64}$'),
 bucket timestamptz NOT NULL,
 reads integer NOT NULL DEFAULT 0 CHECK(reads>=0),
 writes integer NOT NULL DEFAULT 0 CHECK(writes>=0)
);
CREATE INDEX IF NOT EXISTS account_preference_rate_expiry ON public.account_preference_rate(bucket);
COMMENT ON TABLE public.account_preference_documents IS 'primecare.account-preferences.v1';
COMMENT ON TABLE public.account_preference_requests IS 'primecare.account-preferences.v1';
COMMENT ON TABLE public.account_preference_audit IS 'primecare.account-preferences.v1';
COMMENT ON TABLE public.account_preference_rate IS 'primecare.account-preferences.v1';
