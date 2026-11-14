-- Accepted reader data model only. No legacy publication or editorial authority.
-- Executed only by the exact-schema, pinned-manifest migration wrapper.
ALTER TABLE public.faqs ADD COLUMN tenant_id TEXT REFERENCES public.tenants(id);
ALTER TABLE public.faqs
 ADD COLUMN locale TEXT CHECK(locale IN ('en','fr','es')),
 ADD COLUMN publication_state TEXT NOT NULL DEFAULT 'draft' CHECK(publication_state IN ('draft','published','withdrawn')),
 ADD COLUMN revision BIGINT NOT NULL DEFAULT 1 CHECK(revision BETWEEN 1 AND 9007199254740991),
 ADD COLUMN summary TEXT NOT NULL DEFAULT '',
 ADD COLUMN published_at TIMESTAMPTZ;

CREATE FUNCTION public.pc10_help_v1_valid_text(value TEXT, minimum INTEGER, maximum INTEGER)
RETURNS BOOLEAN LANGUAGE SQL IMMUTABLE STRICT AS $body$
 SELECT COALESCE(SUM(CASE WHEN ascii(ch)>65535 THEN 2 ELSE 1 END),0) BETWEEN minimum AND maximum
   AND (minimum=0 OR length(btrim(value))>0)
   AND NOT COALESCE(bool_or(ascii(ch) BETWEEN 1 AND 8 OR ascii(ch) IN (11,12,127) OR ascii(ch) BETWEEN 14 AND 31),FALSE)
 FROM regexp_split_to_table(value,'') AS chars(ch)
$body$;

ALTER TABLE public.faqs ADD CONSTRAINT pc10_help_v1_publication_content CHECK(
 publication_state <> 'published' OR
 (tenant_id IS NOT NULL AND locale IS NOT NULL AND published_at IS NOT NULL
  AND published_at <= CURRENT_TIMESTAMP
  AND id::TEXT ~ '^[A-Za-z0-9][A-Za-z0-9._:-]{0,199}$'
  AND public.pc10_help_v1_valid_text(question,1,500)
  AND public.pc10_help_v1_valid_text(answer,1,5000)
  AND public.pc10_help_v1_valid_text(category,1,100)
  AND public.pc10_help_v1_valid_text(summary,0,1000))
);
ALTER TABLE public.faqs ADD CONSTRAINT pc10_help_v1_unpublished_timestamp CHECK(
 publication_state='published' OR published_at IS NULL
);

CREATE FUNCTION public.pc10_help_v1_revision() RETURNS TRIGGER LANGUAGE plpgsql AS $body$
BEGIN
 IF NEW.revision IS DISTINCT FROM OLD.revision THEN
   RAISE EXCEPTION 'Help revision is managed by the database';
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
CREATE TRIGGER pc10_help_v1_revision_guard BEFORE UPDATE ON public.faqs
FOR EACH ROW EXECUTE FUNCTION public.pc10_help_v1_revision();
CREATE INDEX pc10_help_v1_read ON public.faqs(tenant_id,locale,id) WHERE publication_state='published';

