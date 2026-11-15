-- Approved storage for the exact API794 legacy-grant retirement.
-- Only the pinned registration tool may execute this file in its transaction.
DO $$ BEGIN
 IF current_setting('primecare.help_legacy_archive_registration', true) IS DISTINCT FROM '1' THEN
  RAISE EXCEPTION 'Explicit registered Help legacy archive scope required';
 END IF;
END $$;

CREATE TABLE "governance_68b0b02dd1215f58630d2c1a"."govt_help_legacy_grant_archive" (
 source_ordinal bigint PRIMARY KEY,
 group_fingerprint text NOT NULL,
 original_row jsonb NOT NULL,
 operation_context jsonb NOT NULL,
 retired_at timestamptz NOT NULL DEFAULT clock_timestamp(),
 CONSTRAINT pc10_help_legacy_original_row CHECK (
  jsonb_typeof(original_row)='object'
  AND original_row ? '_primecare_import_row'
  AND original_row->>'_primecare_import_row'=source_ordinal::text
 ),
 CONSTRAINT pc10_help_legacy_context CHECK (jsonb_typeof(operation_context)='object'),
 CONSTRAINT pc10_help_legacy_fingerprint CHECK (group_fingerprint ~ '^[0-9a-f]{64}$')
);

REVOKE ALL ON TABLE "governance_68b0b02dd1215f58630d2c1a"."govt_help_legacy_grant_archive" FROM PUBLIC;
