-- DRAFT FIXTURE-ONLY PROPOSAL. Not an operational migration or approval.
-- Does not register an API, publish legacy content or grant access.
BEGIN;
DO $guard$
DECLARE tenant_type TEXT;
BEGIN
 IF current_setting('primecare.help_proposal_fixture', true) IS DISTINCT FROM 'draft-only' THEN
   RAISE EXCEPTION 'Help proposal SQL is restricted to an explicitly isolated fixture';
 END IF;
 SELECT format_type(atttypid,atttypmod) INTO tenant_type
 FROM pg_attribute WHERE attrelid='tenants'::regclass AND attname='id' AND NOT attisdropped;
 IF tenant_type IS NULL OR tenant_type NOT IN ('text','uuid','character varying') THEN
   RAISE EXCEPTION 'Unsupported Help proposal tenant identity schema';
 END IF;
 EXECUTE format('ALTER TABLE faqs ADD COLUMN tenant_id %s REFERENCES tenants(id)',tenant_type);
END $guard$;
ALTER TABLE faqs
 ADD COLUMN locale TEXT CHECK(locale IN ('en','fr','es')),
 ADD COLUMN publication_state TEXT NOT NULL DEFAULT 'draft' CHECK(publication_state IN ('draft','published','withdrawn')),
 ADD COLUMN revision BIGINT NOT NULL DEFAULT 1 CHECK(revision BETWEEN 1 AND 9007199254740991),
 ADD COLUMN summary TEXT NOT NULL DEFAULT '',
 ADD COLUMN published_at TIMESTAMPTZ;

CREATE FUNCTION pc10_help_proposal_valid_text(value TEXT, minimum INTEGER, maximum INTEGER)
RETURNS BOOLEAN LANGUAGE SQL IMMUTABLE STRICT AS $body$
 SELECT COALESCE(SUM(CASE WHEN ascii(ch)>65535 THEN 2 ELSE 1 END),0) BETWEEN minimum AND maximum
   AND (minimum=0 OR length(btrim(value))>0)
   AND NOT COALESCE(bool_or(ascii(ch) BETWEEN 1 AND 8 OR ascii(ch) IN (11,12,127) OR ascii(ch) BETWEEN 14 AND 31),FALSE)
 FROM regexp_split_to_table(value,'') AS chars(ch)
$body$;

ALTER TABLE faqs ADD CONSTRAINT pc10_help_proposal_publication_content CHECK(
 publication_state <> 'published' OR
 (tenant_id IS NOT NULL AND locale IS NOT NULL AND published_at IS NOT NULL
  AND published_at <= CURRENT_TIMESTAMP
  AND id::TEXT ~ '^[A-Za-z0-9][A-Za-z0-9._:-]{0,199}$'
  AND pc10_help_proposal_valid_text(question,1,500)
  AND pc10_help_proposal_valid_text(answer,1,5000)
  AND pc10_help_proposal_valid_text(category,1,100)
  AND pc10_help_proposal_valid_text(summary,0,1000))
);
ALTER TABLE faqs ADD CONSTRAINT pc10_help_proposal_unpublished_timestamp CHECK(
 publication_state='published' OR published_at IS NULL
);

CREATE FUNCTION pc10_help_proposal_revision() RETURNS TRIGGER LANGUAGE plpgsql AS $body$
BEGIN
 IF NEW.revision IS DISTINCT FROM OLD.revision THEN
   RAISE EXCEPTION 'Help proposal revision is managed by the database';
 END IF;
 IF OLD.tenant_id IS NOT NULL AND NEW.tenant_id IS DISTINCT FROM OLD.tenant_id THEN
   RAISE EXCEPTION 'An assigned Help article cannot change tenants';
 END IF;
 IF OLD.locale IS NOT NULL AND NEW.locale IS DISTINCT FROM OLD.locale THEN
   RAISE EXCEPTION 'A localized Help article cannot change locale';
 END IF;
 IF ROW(NEW.question,NEW.answer,NEW.category,NEW.summary,NEW.tenant_id,NEW.locale)
    IS DISTINCT FROM ROW(OLD.question,OLD.answer,OLD.category,OLD.summary,OLD.tenant_id,OLD.locale) THEN
   -- Edits invalidate publication; a separate reviewed publication step is needed.
   NEW.publication_state := 'draft';
   NEW.published_at := NULL;
 END IF;
 IF ROW(NEW.question,NEW.answer,NEW.category,NEW.summary,NEW.tenant_id,NEW.locale,NEW.publication_state,NEW.published_at)
    IS DISTINCT FROM ROW(OLD.question,OLD.answer,OLD.category,OLD.summary,OLD.tenant_id,OLD.locale,OLD.publication_state,OLD.published_at) THEN
   NEW.revision := OLD.revision+1;
 END IF;
 RETURN NEW;
END $body$;
CREATE TRIGGER pc10_help_proposal_revision_guard BEFORE UPDATE ON faqs
FOR EACH ROW EXECUTE FUNCTION pc10_help_proposal_revision();
CREATE INDEX pc10_help_proposal_read ON faqs(tenant_id,locale,id) WHERE publication_state='published';
COMMIT;
