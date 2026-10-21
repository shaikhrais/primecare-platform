import {createTenantRecord} from '../packages/shared/src/tenant-creation.mjs';
import pg from 'pg';
import {readFileSync} from 'node:fs';
import {createHash,randomUUID} from 'node:crypto';
import {pathToFileURL} from 'node:url';
import {verifyCodeAdminOwnerRegistration} from './code-admin-owner.mjs';
const definitionPath=new URL('../tools/governance-production/code-admin-root.json',import.meta.url);
export const rootPolicy=JSON.parse(readFileSync(definitionPath,'utf8'));
const pin=JSON.parse(readFileSync(new URL('../tools/governance-production/production-pin.json',import.meta.url),'utf8'));
const quote=value=>{if(!/^[a-z][a-z0-9_]*$/.test(value))throw Error('Invalid schema');return '"'+value+'"';};
const tables=(policySchema=pin.schema,tenantSchema='public')=>({policy:quote(policySchema)+'.govt_platform_hierarchy_policy',tenant:quote(tenantSchema)+'.tenants'});
function checkedPolicy(raw){
 const data=JSON.parse(raw);const {tenantId,provisioningReceipt,...fields}=data;
 const {tenantId:unused,...expected}=rootPolicy;
 if(Object.keys(fields).length!==Object.keys(expected).length||Object.keys(expected).some(k=>fields[k]!==expected[k])||tenantId!==null&&(typeof tenantId!=='string'||!tenantId))throw Error('Control-tenant policy drift');
 if(tenantId!==null&&(!provisioningReceipt||typeof provisioningReceipt.runId!=='string'||typeof provisioningReceipt.actor!=='string'))throw Error('Control-tenant receipt missing');
 return data;
}
async function checkedTenant(db,table,data){
 const result=await db.query('SELECT id,slug,name,status FROM '+table+' WHERE id::text=$1',[data.tenantId]);
 if(result.rows.length!==1||String(result.rows[0].id)!==data.tenantId||result.rows[0].slug!==data.slug||result.rows[0].name!==data.name||result.rows[0].status!=='active')throw Error('Registered control tenant is missing or changed');
 return data.tenantId;
}
export async function resolveCodeAdminControlTenant(db,options={}){
 const t=tables(options.policySchema,options.tenantSchema);
 const result=await db.query('SELECT definition FROM '+t.policy+' WHERE id=$1',[rootPolicy.id]);
 if(result.rows.length!==1)throw Error('Registered control-tenant policy required');
 const data=checkedPolicy(result.rows[0].definition);
 if(!data.tenantId)throw Error('Control tenant is not provisioned');
 return checkedTenant(db,t.tenant,data);
}
export async function bootstrapControlTenant(db,{policySchema,tenantSchema,receipt}={}){
 if(!receipt||typeof receipt.runId!=='string'||!receipt.runId||typeof receipt.actor!=='string'||!receipt.actor)throw Error('Protected provisioning attribution required');
 const t=tables(policySchema,tenantSchema);await db.query('BEGIN');
 try{
  await db.query("SELECT pg_advisory_xact_lock(hashtext('code-admin-control-tenant-v1'))");
  const result=await db.query('SELECT definition FROM '+t.policy+' WHERE id=$1 FOR UPDATE',[rootPolicy.id]);
  if(result.rows.length!==1)throw Error('Registered control-tenant policy required');
  const data=checkedPolicy(result.rows[0].definition);
  if(data.tenantId){await checkedTenant(db,t.tenant,data);await db.query('COMMIT');return {created:false,rootTenantBound:true,accountChanges:0};}
  if((await db.query('SELECT id FROM '+t.tenant+' WHERE slug=$1',[data.slug])).rows.length)throw Error('Unbound control-tenant slug collision; preserve existing tenant');
  const tenantId=randomUUID();
  await createTenantRecord(db,{id:tenantId,slug:data.slug,name:data.name},t.tenant);
  data.tenantId=tenantId;data.provisioningReceipt={runId:receipt.runId,actor:receipt.actor};
  const updated=await db.query('UPDATE '+t.policy+' SET definition=$1 WHERE id=$2 RETURNING definition',[JSON.stringify(data),rootPolicy.id]);
  if(updated.rows.length!==1||updated.rows[0].definition!==JSON.stringify(data))throw Error('Control-tenant binding did not persist');
  await checkedTenant(db,t.tenant,checkedPolicy(updated.rows[0].definition));
  await db.query('COMMIT');return {created:true,rootTenantBound:true,accountChanges:0};
 }catch(error){await db.query('ROLLBACK');throw error;}
}
async function main(){
 const expected={optInVariable:'CODE_ADMIN_ROOT_BOOTSTRAP',policyId:rootPolicy.id,definitionSha256:createHash('sha256').update(readFileSync(definitionPath)).digest('hex'),businessTables:['public.tenants'],governanceTables:['platform_hierarchy_policy'],schemaChanges:false,accountAssignments:false};
 if(JSON.stringify(pin.codeAdminRootBootstrap)!==JSON.stringify(expected)||process.env.CODE_ADMIN_ROOT_BOOTSTRAP!=='1')throw Error('Exact root provisioning scope required');
 const db=new pg.Client({connectionString:process.env.PRODUCTION_DATABASE_URL,ssl:{rejectUnauthorized:true}});await db.connect();
 try{await verifyCodeAdminOwnerRegistration(db);console.log('CODE_ADMIN_CONTROL_TENANT '+JSON.stringify(await bootstrapControlTenant(db,{receipt:{runId:process.env.GITHUB_RUN_ID,actor:process.env.GITHUB_ACTOR}})));}finally{await db.end();}
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)main().catch(error=>{
 const safeReasons=new Set(['Exact root provisioning scope required','Governance authority mismatch','Approved Code Admin owner is not registered','Approved Code Admin owner binding differs','Protected provisioning attribution required','Invalid schema','Control-tenant policy drift','Control-tenant receipt missing','Registered control tenant is missing or changed','Registered control-tenant policy required','Unbound control-tenant slug collision; preserve existing tenant','Control tenant did not persist','Control-tenant binding did not persist']);
 console.error('CODE_ADMIN_CONTROL_TENANT_FAILED '+JSON.stringify({reason:safeReasons.has(error?.message)?error.message:'database_operation_failed',code:/^[A-Z0-9]{5}$/.test(error?.code||'')?error.code:null,column:/^[a-z][a-z0-9_]*$/.test(error?.column||'')?error.column:null}));process.exitCode=1;
});
