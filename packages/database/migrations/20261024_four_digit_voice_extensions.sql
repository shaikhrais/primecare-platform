-- Candidate business-schema cutover. Apply only through the governed migration
-- process after four-digit metadata registration. Never renumber existing users.
BEGIN;
SET LOCAL lock_timeout='10s';
LOCK TABLE communication_voice_extensions,communication_voicemails IN ACCESS EXCLUSIVE MODE;
DO $$
DECLARE
 r record;
 expression text;
 s record;
BEGIN
 IF EXISTS(SELECT 1 FROM communication_voice_extensions WHERE extension !~ '^[1-9][0-9]{3}$')
    OR EXISTS(SELECT 1 FROM communication_voicemails WHERE extension !~ '^[1-9][0-9]{3}$') THEN
  RAISE EXCEPTION 'Legacy voice records require explicit reconciliation; no automatic renumbering';
 END IF;
 SELECT * INTO STRICT s FROM pg_sequence WHERE seqrelid='communication_voice_extension_seq'::regclass;
 IF s.seqincrement<>1 OR s.seqcycle THEN RAISE EXCEPTION 'Unexpected voice sequence preserved'; END IF;
 IF s.seqmin=100000 AND s.seqmax=999999 THEN
  IF EXISTS(SELECT 1 FROM communication_voice_extensions) OR EXISTS(SELECT 1 FROM communication_voicemails) THEN
   RAISE EXCEPTION 'Existing assignments require explicit sequence reconciliation';
  END IF;
  -- ALTER ... RESTART is transactional, unlike setval(). Four-digit values
  -- cannot collide with historical six-digit values. No cycling or reuse.
  ALTER SEQUENCE communication_voice_extension_seq MINVALUE 1000 MAXVALUE 9999 START 1000 RESTART WITH 1000 NO CYCLE;
 ELSIF s.seqmin<>1000 OR s.seqmax<>9999 THEN
  RAISE EXCEPTION 'Unexpected voice sequence range preserved';
 END IF;
 FOR r IN SELECT * FROM (VALUES
  ('communication_voice_extensions','communication_voice_extensions_extension_check'),
  ('communication_voicemails','communication_voicemails_extension_check')
 ) AS checks(relation_name,constraint_name) LOOP
  SELECT pg_get_expr(c.conbin,c.conrelid) INTO expression FROM pg_constraint c
   WHERE c.conrelid=r.relation_name::regclass AND c.conname=r.constraint_name AND c.contype='c';
  IF expression IS NULL OR expression NOT IN (
   '(extension ~ ''^[1-9][0-9]{5}$''::text)',
   '(extension ~ ''^[1-9][0-9]{3}$''::text)'
  ) THEN RAISE EXCEPTION 'Unknown voice constraint preserved'; END IF;
  IF expression='(extension ~ ''^[1-9][0-9]{5}$''::text)' THEN
   EXECUTE format('ALTER TABLE %s DROP CONSTRAINT %I',r.relation_name::regclass,r.constraint_name);
   EXECUTE format('ALTER TABLE %s ADD CONSTRAINT %I CHECK(extension ~ ''^[1-9][0-9]{3}$'')',r.relation_name::regclass,r.constraint_name);
  END IF;
 END LOOP;
END $$;
COMMIT;
