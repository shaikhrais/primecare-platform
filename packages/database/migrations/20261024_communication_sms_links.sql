-- Candidate only; apply after pinned storage/access registration. No accounts,
-- contacts, native sessions, links, consent records, grants or routing are seeded.
CREATE TABLE public.communication_sms_consent (
 account_sid text NOT NULL CHECK(account_sid ~ '^AC[0-9a-fA-F]{32}$'),
 shared_number text NOT NULL CHECK(shared_number ~ '^\+[1-9][0-9]{1,14}$'),
 phone text NOT NULL CHECK(phone ~ '^\+[1-9][0-9]{1,14}$'),
 blocked boolean NOT NULL,
 version bigint NOT NULL CHECK(version BETWEEN 1 AND 9007199254740990),
 updated_at timestamptz NOT NULL DEFAULT clock_timestamp(),
 PRIMARY KEY(account_sid,shared_number,phone)
);
CREATE TABLE public.communication_sms_links (
 id text PRIMARY KEY CHECK(id ~ '^[a-f0-9-]{36}$'),
 tenant_id text NOT NULL CHECK(length(btrim(tenant_id)) BETWEEN 1 AND 200),
 user_id text NOT NULL CHECK(length(btrim(user_id)) BETWEEN 1 AND 200),
 conversation_id text NOT NULL CHECK(length(btrim(conversation_id)) BETWEEN 1 AND 200),
 account_sid text NOT NULL CHECK(account_sid ~ '^AC[0-9a-fA-F]{32}$'),
 messaging_service_sid text NOT NULL CHECK(messaging_service_sid ~ '^MG[0-9a-fA-F]{32}$'),
 shared_number text NOT NULL CHECK(shared_number ~ '^\+[1-9][0-9]{1,14}$'),
 phone text NOT NULL CHECK(phone ~ '^\+[1-9][0-9]{1,14}$'),
 contact_version bigint NOT NULL CHECK(contact_version BETWEEN 1 AND 9007199254740990),
 consent_version bigint NOT NULL CHECK(consent_version BETWEEN 1 AND 9007199254740990),
 version bigint NOT NULL DEFAULT 1 CHECK(version BETWEEN 1 AND 9007199254740990),
 consented_at timestamptz NOT NULL DEFAULT clock_timestamp(),
 revoked_at timestamptz,
 FOREIGN KEY(account_sid,shared_number,phone)
  REFERENCES public.communication_sms_consent(account_sid,shared_number,phone),
 FOREIGN KEY(tenant_id,user_id)
  REFERENCES public.communication_voice_verified_contacts(tenant_id,user_id)
);
-- One active selected account/conversation per provider address pair, globally.
-- A shared phone cannot silently choose among multiple tenants or users.
CREATE UNIQUE INDEX communication_sms_unique_active_address
 ON public.communication_sms_links(account_sid,shared_number,phone) WHERE revoked_at IS NULL;
