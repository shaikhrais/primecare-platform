-- Evidence-only design rehearsal. All records are synthetic, all tables are
-- temporary, and the script never commits. It is not a production migration.
BEGIN;
CREATE TEMP TABLE roles (id text PRIMARY KEY);
CREATE TEMP TABLE screens (id text PRIMARY KEY);
CREATE TEMP TABLE admin_training_courses (
  course_id text PRIMARY KEY, version text NOT NULL, modules_json text NOT NULL,
  progress_scope text NOT NULL, requirement text NOT NULL
);
-- Model the documented source key semantics, not a claim about the physical
-- constraints of the imported pinned PostgreSQL snapshot.
CREATE TEMP TABLE admin_training_learning_grants (
  role_id text PRIMARY KEY REFERENCES roles(id),
  course_id text NOT NULL REFERENCES admin_training_courses(course_id),
  can_read integer NOT NULL
);
CREATE TEMP TABLE proposed_course_versions (
  course_id text, version text, PRIMARY KEY (course_id, version)
);
CREATE TEMP TABLE proposed_tenant_admin_assignment (
  role_id text REFERENCES roles(id) CHECK (role_id = 'fixture-tenant-admin'),
  screen_id text REFERENCES screens(id) CHECK (screen_id = 'fixture-training-screen'),
  course_id text NOT NULL,
  version text NOT NULL,
  PRIMARY KEY (role_id, screen_id),
  FOREIGN KEY (course_id, version) REFERENCES proposed_course_versions(course_id, version)
);

INSERT INTO roles VALUES ('fixture-tenant-admin'), ('fixture-other-role');
INSERT INTO screens VALUES ('fixture-training-screen'), ('fixture-other-screen');
INSERT INTO admin_training_courses VALUES
  ('fixture-shared', 'fixture-v1', '[]', 'fixture-local', 'fixture shared training');
INSERT INTO admin_training_learning_grants VALUES
  ('fixture-tenant-admin', 'fixture-shared', 1), ('fixture-other-role', 'fixture-shared', 1);
CREATE TEMP TABLE shared_before AS TABLE admin_training_learning_grants;
CREATE TEMP TABLE catalog_before AS TABLE admin_training_courses;
INSERT INTO proposed_course_versions VALUES
  ('fixture-tenant-curriculum', 'fixture-v1'), ('fixture-tenant-curriculum', 'fixture-v2');

-- Reviewed contract behavior: idempotent only for exact matches, not silent
-- replacement or a second competing course for the existing route.
CREATE FUNCTION pg_temp.rehearse_assignment(c text, v text) RETURNS void LANGUAGE plpgsql AS $$
BEGIN
  INSERT INTO proposed_tenant_admin_assignment VALUES ('fixture-tenant-admin','fixture-training-screen',c,v)
  ON CONFLICT (role_id, screen_id) DO NOTHING;
  IF NOT EXISTS (
    SELECT 1 FROM proposed_tenant_admin_assignment
    WHERE role_id='fixture-tenant-admin' AND screen_id='fixture-training-screen'
    AND course_id=c AND version=v
  ) THEN
    RAISE EXCEPTION 'Conflicting fixture assignment' USING ERRCODE='23505';
  END IF;
END $$;

DO $$
BEGIN
  BEGIN
    PERFORM pg_temp.rehearse_assignment('fixture-tenant-curriculum','no-such-fixture-version');
    RAISE EXCEPTION 'Orphan assignment was accepted';
  EXCEPTION WHEN foreign_key_violation THEN NULL;
  END;
END $$;

SAVEPOINT interrupted_registration;
SELECT pg_temp.rehearse_assignment('fixture-tenant-curriculum','fixture-v1');
ROLLBACK TO SAVEPOINT interrupted_registration;
RELEASE SAVEPOINT interrupted_registration;
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM proposed_tenant_admin_assignment) THEN
    RAISE EXCEPTION 'Attempted assignment survived rollback';
  END IF;
END $$;

SELECT pg_temp.rehearse_assignment('fixture-tenant-curriculum','fixture-v1');
SELECT pg_temp.rehearse_assignment('fixture-tenant-curriculum','fixture-v1');
DO $$
BEGIN
  BEGIN
    PERFORM pg_temp.rehearse_assignment('fixture-tenant-curriculum','fixture-v2');
    RAISE EXCEPTION 'Conflicting re-registration was accepted';
  EXCEPTION WHEN unique_violation THEN NULL;
  END;
  BEGIN
    INSERT INTO proposed_tenant_admin_assignment VALUES
      ('fixture-other-role','fixture-training-screen','fixture-tenant-curriculum','fixture-v1');
    RAISE EXCEPTION 'Unrelated role assignment was accepted';
  EXCEPTION WHEN check_violation THEN NULL;
  END;
  BEGIN
    INSERT INTO proposed_tenant_admin_assignment VALUES
      ('fixture-tenant-admin','fixture-other-screen','fixture-tenant-curriculum','fixture-v1');
    RAISE EXCEPTION 'Unrelated screen assignment was accepted';
  EXCEPTION WHEN check_violation THEN NULL;
  END;
  BEGIN
    INSERT INTO admin_training_learning_grants SELECT * FROM shared_before WHERE role_id='fixture-tenant-admin';
    RAISE EXCEPTION 'Second legacy assignment was accepted';
  EXCEPTION WHEN unique_violation THEN NULL;
  END;

  IF (SELECT COUNT(*) FROM proposed_tenant_admin_assignment) <> 1
    OR NOT EXISTS (SELECT 1 FROM proposed_tenant_admin_assignment WHERE role_id='fixture-tenant-admin'
      AND screen_id='fixture-training-screen' AND course_id='fixture-tenant-curriculum' AND version='fixture-v1')
  THEN RAISE EXCEPTION 'Expected exact single assignment'; END IF;

  IF EXISTS (SELECT * FROM admin_training_learning_grants EXCEPT SELECT * FROM shared_before)
    OR EXISTS (SELECT * FROM shared_before EXCEPT SELECT * FROM admin_training_learning_grants)
    OR EXISTS (SELECT * FROM admin_training_courses EXCEPT SELECT * FROM catalog_before)
    OR EXISTS (SELECT * FROM catalog_before EXCEPT SELECT * FROM admin_training_courses)
  THEN RAISE EXCEPTION 'Legacy shared course or its role links changed'; END IF;
END $$;
ROLLBACK;
DO $$
BEGIN
  IF to_regclass('pg_temp.proposed_tenant_admin_assignment') IS NOT NULL
    OR to_regclass('pg_temp.admin_training_learning_grants') IS NOT NULL
  THEN RAISE EXCEPTION 'Temporary rehearsal rows or definitions escaped rollback'; END IF;
END $$;
SELECT 'Tenant Admin training assignment rehearsal passed (temporary PostgreSQL fixture only)' AS receipt;
