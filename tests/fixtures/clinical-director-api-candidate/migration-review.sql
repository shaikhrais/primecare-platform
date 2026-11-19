-- Review candidate, not an executable release. No provisioner, grants, or seed data.
-- Apply only in a separately approved transaction against the verified application schema.
-- Use a controlled search_path, with the target schema first, never a user-selected schema.
DO $$
BEGIN
    IF (SELECT count(*) FROM information_schema.columns
        WHERE table_schema=current_schema()
          AND (table_name,column_name) IN (('users','id'),('users','tenant_id'),('tenants','id'))
          AND data_type='text') <> 3
    THEN RAISE EXCEPTION 'Clinical access migration requires reviewed text identity columns';
    END IF;
END $$;

CREATE TABLE clinical_verified_branches (
    tenant_id text NOT NULL REFERENCES tenants(id),
    branch_id text NOT NULL CHECK (branch_id<>'' AND branch_id=btrim(branch_id)),
    verification_ref text NOT NULL CHECK (btrim(verification_ref)<>''),
    verified_at timestamptz NOT NULL,
    retired_at timestamptz CHECK (retired_at>=verified_at),
    PRIMARY KEY (tenant_id, branch_id)
);
CREATE TABLE clinical_branch_grant_admins (
    tenant_id text NOT NULL REFERENCES tenants(id),
    admin_user_id text NOT NULL REFERENCES users(id),
    approval_ref text NOT NULL CHECK (btrim(approval_ref)<>''),
    enabled boolean NOT NULL DEFAULT false,
    PRIMARY KEY (tenant_id, admin_user_id)
);
CREATE TABLE clinical_branch_director_grants (
    tenant_id text NOT NULL,
    branch_id text NOT NULL,
    director_user_id text NOT NULL REFERENCES users(id),
    granted_at timestamptz NOT NULL,
    expires_at timestamptz NOT NULL CHECK (expires_at>granted_at),
    revoked_at timestamptz CHECK (revoked_at>=granted_at),
    FOREIGN KEY (tenant_id,branch_id) REFERENCES clinical_verified_branches(tenant_id,branch_id),
    PRIMARY KEY (tenant_id,branch_id,director_user_id,granted_at)
);
CREATE UNIQUE INDEX clinical_branch_director_single_open_grant
  ON clinical_branch_director_grants(tenant_id,branch_id,director_user_id) WHERE revoked_at IS NULL;
CREATE TABLE clinical_branch_access_audit (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tenant_id text NOT NULL REFERENCES tenants(id),
    branch_id text NOT NULL,
    director_user_id text NOT NULL REFERENCES users(id),
    actor_user_id text NOT NULL REFERENCES users(id),
    action text NOT NULL CHECK (action IN ('grant','revoke')),
    occurred_at timestamptz NOT NULL,
    FOREIGN KEY (tenant_id,branch_id) REFERENCES clinical_verified_branches(tenant_id,branch_id)
);
CREATE VIEW clinical_branch_director_effective_scope AS
SELECT g.tenant_id,g.branch_id,g.director_user_id
FROM clinical_branch_director_grants g
JOIN clinical_verified_branches b USING (tenant_id,branch_id)
JOIN tenants t ON t.id=g.tenant_id AND t.status='active'
JOIN users d ON d.id=g.director_user_id AND d.tenant_id=g.tenant_id
 AND d.status='active' AND d.roles='clinical_director'
WHERE b.verified_at<=CURRENT_TIMESTAMP AND b.retired_at IS NULL
  AND g.granted_at<=CURRENT_TIMESTAMP AND g.expires_at>CURRENT_TIMESTAMP AND g.revoked_at IS NULL;

REVOKE ALL ON clinical_verified_branches, clinical_branch_grant_admins, clinical_branch_director_grants,
 clinical_branch_access_audit, clinical_branch_director_effective_scope FROM PUBLIC;
