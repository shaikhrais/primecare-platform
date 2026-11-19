-- $1/$2 are the verified session's tenant/actor. $3/$4 identify the grant.
WITH allowed AS (
 SELECT t.id AS tenant_id
 FROM tenants t
 JOIN clinical_branch_grant_admins p ON p.tenant_id=t.id
 JOIN users a ON a.id=p.admin_user_id AND a.tenant_id=t.id
 WHERE t.id=$1 AND a.id=$2 AND a.status='active' AND a.roles='tenant_admin'
   AND p.enabled AND t.status='active'
 FOR SHARE OF t,p,a
), written AS (
 UPDATE clinical_branch_director_grants g SET revoked_at=CURRENT_TIMESTAMP
 FROM allowed a
 WHERE g.tenant_id=a.tenant_id AND g.branch_id=$4 AND g.director_user_id=$3
   AND g.revoked_at IS NULL
 RETURNING g.tenant_id,g.branch_id,g.director_user_id
)
INSERT INTO clinical_branch_access_audit(tenant_id,branch_id,director_user_id,actor_user_id,action,occurred_at)
SELECT tenant_id,branch_id,director_user_id,$2,'revoke',CURRENT_TIMESTAMP FROM written
RETURNING action;
