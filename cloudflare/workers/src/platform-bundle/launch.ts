import type {Client} from 'pg';
import {registry,type Launch} from '../../../../packages/shared/src/platform-bundle/contract';
import {canonical} from '../../../../packages/shared/src/growth/contract';
import {sha256} from '../auth';
import {optionalRow,requiredRow} from '../database-results';
export async function launchState(db:Client,tenantId:string,global:boolean):Promise<Launch & {fingerprint:string}>{
 const row=optionalRow((await db.query('SELECT * FROM platform_launch WHERE tenant_id::text=$1',[tenantId])).rows);
 const setup=requiredRow((await db.query(`SELECT
 EXISTS(SELECT 1 FROM users WHERE tenant_id=t.id AND roles='tenant_admin' AND LOWER(status)='active') AS admin,
 (EXISTS(SELECT 1 FROM platform_master_records WHERE tenant_id=t.id AND type='location' AND status='active') AND EXISTS(SELECT 1 FROM platform_master_records WHERE tenant_id=t.id AND type='service_category' AND status='active')) AS masters,
 EXISTS(SELECT 1 FROM platform_territory_sales WHERE tenant_id=t.id) AS territory,LOWER(t.status)='active' AS active
 FROM tenants t WHERE t.id::text=$1`,[tenantId])).rows);
 const docs=(await db.query(`SELECT DISTINCT ON(kind) id,kind,revision,status,expires_on::text,expires_on>=(NOW() AT TIME ZONE 'America/Toronto')::date AS valid FROM platform_documents WHERE tenant_id::text=$1 ORDER BY kind,revision DESC`,[tenantId])).rows;
 const validDocuments=registry.documentKinds.every(kind=>docs.some(d=>d.kind===kind&&d.status==='approved'&&d.valid===true));
 const values={admin:setup.admin===true,masters:setup.masters===true,territory:setup.territory===true,valid_documents:validDocuments,training_done:typeof row?.training_evidence==='string'&&row.training_evidence.trim().length>0};
 const checks=registry.checks.map(key=>({key,present:values[key as keyof typeof values]})),ready=setup.active===true&&checks.every(c=>c.present);
 const fingerprint=await sha256(canonical({checks,docs:docs.map(d=>({id:d.id,status:d.status,expires:d.expires_on})),training:row?.training_evidence??''}));
 // A return reason remains visible through corrective edits, until a new submission.
 const decision=row?.state==='draft'?optionalRow((await db.query("SELECT action,evidence,created_at FROM platform_bundle_audit WHERE tenant_id::text=$1 AND target_id=$1 AND action IN ('launch_request_changes','launch_submit','launch_approve') ORDER BY (state->>'version')::int DESC NULLS LAST,created_at DESC,id DESC LIMIT 1",[tenantId])).rows):null;
 const feedback=decision?.action==='launch_request_changes'?{evidence:String(decision.evidence),createdAt:decision.created_at instanceof Date?decision.created_at.toISOString():String(decision.created_at)}:null;
 const approved=row?.state==='approved'&&ready&&row.approved_fingerprint===fingerprint;
 return {state:row?.state==='approved'&&!approved?'approval_stale':String(row?.state??'draft'),version:Number(row?.version??0),trainingEvidence:String(row?.training_evidence??''),checks,ready,canSubmit:ready&&!approved&&row?.state!=='submitted',canApprove:global&&row?.state==='submitted'&&ready,canRequestChanges:global&&row?.state==='submitted',feedback,fingerprint};
}
