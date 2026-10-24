import pg from 'pg';
import assert from 'node:assert/strict';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {owner,verifyCodeAdminOwnerRegistration} from './code-admin-owner.mjs';
const plan=JSON.parse(await readFile('evidence/hr-department-plan.json','utf8'));
if(plan.version!==1||plan.tenantName!=='PrimeCare Admin HQ'||plan.type!=='department'||plan.records.length!==6||new Set(plan.records.map(r=>r.code)).size!==6)throw Error('Exact HR reference readback scope required');
const completed=plan.expectedCreatedCodes,pending=plan.pendingCodes;
if(!Array.isArray(completed)||!Array.isArray(pending)||completed.length<1||new Set([...completed,...pending]).size!==6||completed.length+pending.length!==6||plan.records.some(r=>![...completed,...pending].includes(r.code)))throw Error('Exact completed and pending HR scope required');
const count=completed.length;
const db=new pg.Client({connectionString:process.env.PRODUCTION_DATABASE_URL,ssl:{rejectUnauthorized:true}});await db.connect();
try{
 await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
 await verifyCodeAdminOwnerRegistration(db);
 const tenants=(await db.query("SELECT id::text AS id FROM public.tenants WHERE name=$1 AND LOWER(status)='active'",[plan.tenantName])).rows;
 if(tenants.length!==1)throw Error('Unique requested tenant required');const tenant=tenants[0].id;
 const records=(await db.query("SELECT id::text AS id,type,code,label,status,version FROM public.platform_master_records WHERE tenant_id::text=$1 AND type=$2 AND code=ANY($3::text[]) ORDER BY code",[tenant,plan.type,plan.records.map(r=>r.code)])).rows;
 const expected=plan.records.filter(r=>completed.includes(r.code)).map(r=>({...r,type:'department',status:'active',version:1})).sort((a,b)=>a.code.localeCompare(b.code));
 assert.deepEqual(records.map(({id,...record})=>record),expected);assert.equal(new Set(records.map(r=>r.id)).size,count);
 const audit=(await db.query("SELECT actor_id::text AS actor_id,target_id,previous_state,current_state FROM public.platform_administration_audit WHERE tenant_id::text=$1 AND target_id=ANY($2::text[]) AND action='master_created'",[tenant,records.map(r=>r.id)])).rows;
 assert.equal(audit.length,count);assert.equal(new Set(audit.map(a=>a.target_id)).size,count);
 for(const event of audit){const record=records.find(r=>r.id===event.target_id);assert.ok(record);const {id,...fields}=record;assert.deepEqual(event.previous_state,{});assert.deepEqual(event.current_state,fields);}
 const actors=[...new Set(audit.map(a=>a.actor_id))];assert.equal(actors.length,1);
 const actor=(await db.query("SELECT email,roles,status FROM public.users WHERE id::text=$1",[actors[0]])).rows;
 assert.equal(actor.length,1);assert.equal(actor[0].roles,'code_admin');assert.equal(actor[0].status,'active');
 assert.equal(createHash('sha256').update(actor[0].email.trim().toLowerCase()).digest('hex'),owner.emailSha256);
 const receipts=(await db.query("SELECT actor_id,response,status FROM public.platform_administration_requests WHERE actor_id=$1 AND response->'record'->>'id'=ANY($2::text[])",[actors[0],records.map(r=>r.id)])).rows;
 assert.equal(receipts.length,count);assert.equal(new Set(receipts.map(r=>r.response.record.id)).size,count);
 for(const receipt of receipts){assert.equal(receipt.status,201);assert.deepEqual(receipt.response.record,records.find(r=>r.id===receipt.response.record.id));}
 await db.query('ROLLBACK');
 const report={source:process.env.GITHUB_SHA,runId:process.env.GITHUB_RUN_ID,tenant:plan.tenantName,
  requestedRecords:plan.records.length,pendingCodes:pending,departmentCreationComplete:pending.length===0,verifiedRecords:records.length,codes:records.map(r=>r.code),auditedCreates:audit.length,idempotentReceipts:receipts.length,
  approvedActorMatched:true,writesAttempted:false,businessRecordsRead:true,readsRestrictedToRequestedDepartments:true,
  accountOrPermissionWrites:false,providerWrites:false,fullRecruitmentWorkflowVerified:false};
 await mkdir('test-results/live-hr-departments',{recursive:true});await writeFile('test-results/live-hr-departments/readback.json',JSON.stringify(report,null,2)+'\n');
 console.log('LIVE_HR_DEPARTMENTS_READBACK '+JSON.stringify(report));
}catch(error){await db.query('ROLLBACK');console.error('LIVE_HR_DEPARTMENTS_READBACK_FAILED '+JSON.stringify({code:/^[A-Z0-9]{5}$/.test(error?.code||'')?error.code:null,reason:'Requested reference records, audit, actor or receipts did not match; no writes attempted.'}));process.exitCode=1;}
finally{await db.end();}
