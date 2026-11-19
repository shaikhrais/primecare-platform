-- $1/$2 are the verified session's tenant/actor. $3/$4/$5: target user, branch, expiry.
-- Invoke only from a reviewed server handler and dedicated database identity.
WITH allowed AS (
 SELECT t.id AS tenant_id,b.branch_id,d.id AS director_user_id
 FROM tenants t
 JOIN clinical_verified_branches b ON b.tenant_id=t.id
 JOIN clinical_branch_grant_admins p ON p.tenant_id=t.id
 JOIN users a ON a.id=p.admin_user_id AND a.tenant_id=t.id
 JOIN users d ON d.tenant_id=t.id
 WHERE t.id=$1 AND t.status='active' AND a.id=$2 AND a.status='active'
   AND a.roles='tenant_admin' AND p.enabled AND d.id=$3 AND d.status='active'
   AND d.roles='clinical_director' AND d.id<>a.id AND b.branch_id=$4
   AND b.verified_at<=CURRENT_TIMESTAMP AND b.retired_at IS NULL
   AND $5::timestamptz>CURRENT_TIMESTAMP
 FOR SHARE OF t,b,p,a,d
), written AS (
 INSERT INTO clinical_branch_director_grants(tenant_id,branch_id,director_user_id,granted_at,expires_at)
 SELECT tenant_id,branch_id,director_user_id,CURRENT_TIMESTAMP,$5::timestamptz FROM allowed
 ON CONFLICT (tenant_id,branch_id,director_user_id) WHERE revoked_at IS NULL DO NOTHING
 RETURNING tenant_id,branch_id,director_user_id
)
INSERT INTO clinical_branch_access_audit(tenant_id,branch_id,director_user_id,actor_user_id,action,occurred_at)
SELECT tenant_id,branch_id,director_user_id,$2,'grant',CURRENT_TIMESTAMP FROM written
RETURNING action;
