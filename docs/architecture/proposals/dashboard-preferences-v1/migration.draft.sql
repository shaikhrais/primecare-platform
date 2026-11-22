-- DRAFT ONLY: not part of the migration runner and not approved for execution.
-- Requires pinned migration authority, a fresh physical-schema preflight and
-- coordinated API contract/worker compatibility. Preserve all existing kinds.
-- Names below are PostgreSQL's default names for the checked-in base migration;
-- fail and review if the live constraint names or definitions differ.
BEGIN;
ALTER TABLE public.account_preference_documents
  DROP CONSTRAINT account_preference_documents_kind_check,
  ADD CONSTRAINT account_preference_documents_kind_check
    CHECK (kind IN ('theme','workspace','shortcuts','dashboard')) NOT VALID;
ALTER TABLE public.account_preference_documents
  VALIDATE CONSTRAINT account_preference_documents_kind_check;
ALTER TABLE public.account_preference_audit
  DROP CONSTRAINT account_preference_audit_kind_check,
  ADD CONSTRAINT account_preference_audit_kind_check
    CHECK (kind IN ('theme','workspace','shortcuts','dashboard')) NOT VALID;
ALTER TABLE public.account_preference_audit
  VALIDATE CONSTRAINT account_preference_audit_kind_check;
COMMIT;
-- Rollback cannot simply drop support after dashboard rows exist. Retire clients
-- and explicitly resolve those rows/receipts under an approved recovery plan;
-- never delete personal preferences automatically to restore an old constraint.
