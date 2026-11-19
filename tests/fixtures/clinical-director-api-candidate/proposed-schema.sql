-- Review candidate only. Do not add to automatic migrations or apply to production.
-- This fixture prototype assumes the existing Prisma text identifiers.
CREATE TABLE clinical_dashboard_branches (
    tenant_id text NOT NULL REFERENCES tenants(id),
    branch_id text NOT NULL CHECK (branch_id <> '' AND branch_id = btrim(branch_id)),
    PRIMARY KEY (tenant_id, branch_id)
);

CREATE TABLE clinical_director_branch_assignments (
    tenant_id text NOT NULL,
    branch_id text NOT NULL,
    director_user_id text NOT NULL REFERENCES users(id),
    starts_at timestamptz NOT NULL,
    expires_at timestamptz NOT NULL,
    revoked_at timestamptz,
    PRIMARY KEY (tenant_id, branch_id, director_user_id, starts_at),
    FOREIGN KEY (tenant_id, branch_id)
      REFERENCES clinical_dashboard_branches(tenant_id, branch_id),
    CHECK (expires_at > starts_at),
    CHECK (revoked_at IS NULL OR revoked_at >= starts_at)
);
CREATE INDEX clinical_director_branch_current
    ON clinical_director_branch_assignments(tenant_id, director_user_id, branch_id)
    WHERE revoked_at IS NULL;

REVOKE ALL ON clinical_dashboard_branches, clinical_director_branch_assignments FROM PUBLIC;

-- Defense in depth: a valid assignment plus an active Clinical Director identity
-- in the same active tenant are both required. A screen grant alone is insufficient.
CREATE VIEW clinical_director_effective_branch_scope AS
SELECT DISTINCT a.tenant_id, a.branch_id, a.director_user_id
FROM clinical_director_branch_assignments a
JOIN users u ON u.id = a.director_user_id AND u.tenant_id = a.tenant_id
JOIN tenants t ON t.id = a.tenant_id
WHERE u.status = 'active' AND u.roles = 'clinical_director' AND t.status = 'active'
  AND a.starts_at <= CURRENT_TIMESTAMP
  AND a.expires_at > CURRENT_TIMESTAMP AND a.revoked_at IS NULL;

REVOKE ALL ON clinical_director_effective_branch_scope FROM PUBLIC;
