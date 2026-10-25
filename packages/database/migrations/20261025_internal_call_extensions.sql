-- Additive internal calling directory; never auto-publish or renumber users.
CREATE SEQUENCE public.communication_voice_extension_seq
 MINVALUE 1000 MAXVALUE 9999 START 1000 NO CYCLE;
CREATE TABLE public.communication_voice_extensions (
 extension text PRIMARY KEY CHECK(extension ~ '^[1-9][0-9]{3}$'),
 tenant_id text NOT NULL CHECK(length(btrim(tenant_id)) BETWEEN 1 AND 200),
 user_id text NOT NULL CHECK(length(btrim(user_id)) BETWEEN 1 AND 200),
 published boolean NOT NULL DEFAULT false,
 active boolean NOT NULL DEFAULT true,
 version bigint NOT NULL DEFAULT 1 CHECK(version BETWEEN 1 AND 9007199254740991),
 UNIQUE(tenant_id,user_id)
);
