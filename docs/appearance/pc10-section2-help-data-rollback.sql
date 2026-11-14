-- DRAFT FIXTURE-ONLY rollback; refuses to discard adopted publication data.
BEGIN;
DO $guard$
BEGIN
 IF current_setting('primecare.help_proposal_fixture', true) IS DISTINCT FROM 'draft-only' THEN
   RAISE EXCEPTION 'Help proposal rollback is restricted to an isolated fixture';
 END IF;
 IF EXISTS(SELECT 1 FROM faqs WHERE tenant_id IS NOT NULL OR locale IS NOT NULL
   OR summary<>'' OR publication_state<>'draft' OR published_at IS NOT NULL OR revision<>1) THEN
   RAISE EXCEPTION 'Help proposal rollback would discard adopted data; preserve and review';
 END IF;
END $guard$;
DROP TRIGGER pc10_help_proposal_revision_guard ON faqs;
DROP FUNCTION pc10_help_proposal_revision();
DROP INDEX pc10_help_proposal_read;
ALTER TABLE faqs DROP CONSTRAINT pc10_help_proposal_publication_content,
 DROP CONSTRAINT pc10_help_proposal_unpublished_timestamp,
 DROP COLUMN tenant_id, DROP COLUMN locale, DROP COLUMN publication_state,
 DROP COLUMN revision, DROP COLUMN summary, DROP COLUMN published_at;
DROP FUNCTION pc10_help_proposal_valid_text(TEXT,INTEGER,INTEGER);
COMMIT;
