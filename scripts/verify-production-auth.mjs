// Authorized production smoke test: unique synthetic tenant, no real user data.
import {Client} from 'pg';
import bcrypt from 'bcryptjs';
import {randomUUID,randomBytes,createHash} from 'node:crypto';
import assert from 'node:assert/strict';

const gateway=new URL(process.env.GATEWAY_URL||'');
if(gateway.origin!=='https://primecare-api-gateway.itpro-mohammed.workers.dev')
 throw new Error('Unexpected production gateway');
if(process.env.CONFIRM_AUTH_SMOKE!=='VERIFY_AUTH') throw new Error('Auth smoke confirmation required');
const db=new Client({connectionString:process.env.PRODUCTION_DATABASE_URL,connectionTimeoutMillis:10000});
const tenantId=randomUUID(),actorId=randomUUID(),suffix=randomUUID();
const email=`auth-smoke-${suffix}@example.invalid`;
const targetEmail=`auth-target-${suffix}@example.invalid`;
const password=randomBytes(24).toString('base64url');
let targetId,fixtureCreated=false,passed=0,phase='connect';
const check=(value,message)=>{assert.ok(value,message);passed++;console.log('PASS '+message);};
async function call(path,method='GET',body,token,extra={}) {
 const response=await fetch(new URL(path,gateway),{method,redirect:'error',
  headers:{'content-type':'application/json',...(token?{authorization:'Bearer '+token}:{}),...extra},
  ...(body===undefined?{}:{body:JSON.stringify(body)}),signal:AbortSignal.timeout(15000)});
 const data=await response.json();return {status:response.status,data};
}
try {
 await db.connect();
 await db.query('BEGIN');
  try {
  phase='create QA tenant';
  await db.query("INSERT INTO tenants(id,name,slug,status,updated_at,allowed_vpn_ranges,cors_allowed_origins,cors_allowed_methods,cors_allowed_headers) VALUES($1,'Temporary authentication QA tenant',$2,'active',NOW(),'','[]'::jsonb,'[]'::jsonb,'[]'::jsonb)",[tenantId,'auth-smoke-'+suffix]);
  phase='create QA actor';
  await db.query("INSERT INTO users(id,email,tenant_id,roles,password_hash,status,updated_at) VALUES($1,$2,$3,'ceo',$4,'active',NOW())",[actorId,email,tenantId,await bcrypt.hash(password,12)]);
  await db.query('COMMIT');fixtureCreated=true;phase='public API checks';
 } catch(error){await db.query('ROLLBACK');throw error;}
 check((await call('/v1/auth/login','POST',{email,password:'incorrect-fixture-password'})).status===401,'invalid login rejected');
 const login=await call('/v1/auth/login','POST',{email,password});
 check(login.status===200&&login.data.role==='ceo'&&login.data.userId===actorId,'login resolves fixture CEO');
 const token=login.data.token;
 if(process.env.VERIFY_CLIENT_BROWSER==='1') {
  const {verifyClientAuthBrowser}=await import('./verify-client-auth-browser.mjs');
  await verifyClientAuthBrowser(email,password);
  check(true,'published Client browser login and logout');
 }
 for(const method of ['GET','POST']) {
  const me=await call('/v1/auth/me',method,undefined,token);
  check(me.status===200&&me.data.userId===actorId&&me.data.roles==='ceo',method+' session identity');
 }
 check((await call('/v1/auth/register','POST',{email:targetEmail,password,role:'rmt'},token,{'x-tenant-id':randomUUID()})).status===403,'cross-tenant account creation rejected');
 const create=await call('/v1/auth/register','POST',{email:targetEmail,password,role:'rmt'},token);
 check(create.status===201&&create.data.user.tenant_id===tenantId,'authorized account creation');
 targetId=create.data.user.id;
 const stored=(await db.query('SELECT roles,tenant_id FROM users WHERE id=$1',[targetId])).rows[0];
 check(stored?.roles==='rmt'&&stored?.tenant_id===tenantId,'created account persisted in fixture tenant');
 const targetLogin=await call('/v1/auth/login','POST',{email:targetEmail,password});
 check(targetLogin.status===200&&targetLogin.data.role==='rmt','created account can authenticate');
 const workspace=await call('/v1/governance/workspace?screen=ceo_dashboard','GET',undefined,token);
 check(workspace.status===200&&workspace.data.identity?.role==='ceo','CEO dashboard loads through the production gateway');
 check(workspace.data.overview?.activeAccounts===2,'dashboard account totals are scoped to the isolated QA tenant');
 check(workspace.data.screens?.some(s=>s.code==='ceo_dashboard'),'CEO dashboard is present in governed navigation');
 check((await call('/v1/governance/workspace?screen=ceo_dashboard','GET',undefined,targetLogin.data.token)).status===403,'staff cannot read the CEO page');
 check((await call('/v1/governance/workspace','GET',undefined,token,{'x-tenant-id':randomUUID()})).status===403,'workspace rejects a cross-tenant header');
 check((await call('/v1/auth/register','POST',{email:'denied-'+suffix+'@example.invalid',password,role:'ceo'},targetLogin.data.token)).status===403,'ordinary role cannot create CEO');
 const deactivate=await call('/v1/admin/users','POST',{id:targetId,role:'rmt',status:'inactive'},token);
 check(deactivate.status===200,'CEO can deactivate fixture account');
 check((await call('/v1/auth/me','GET',undefined,targetLogin.data.token)).status===401,'deactivation revokes target session');
 const newPassword=randomBytes(24).toString('base64url');
 check((await call('/v1/user/change-password','POST',{currentPassword:password,newPassword},token)).status===200,'password change succeeds');
 check((await call('/v1/auth/me','GET',undefined,token)).status===401,'password change revokes old session');
 check((await call('/v1/auth/login','POST',{email,password})).status===401,'old password rejected');
 const relogin=await call('/v1/auth/login','POST',{email,password:newPassword});
 check(relogin.status===200,'new password authenticates');
 check((await call('/v1/auth/logout','POST',{},relogin.data.token)).status===200,'logout succeeds');
 check((await call('/v1/auth/me','GET',undefined,relogin.data.token)).status===401,'logged-out session rejected');
 console.log(`Production auth smoke passed ${passed} checks.`);
} catch(error) {
 console.error(`Production auth smoke failed after ${passed} checks. No credentials or response bodies logged.`);
 const codes={'23502':'required field missing','23503':'foreign key mismatch','23505':'unique constraint conflict','42703':'column missing','42P01':'table missing','42501':'permission denied','28P01':'database authentication rejected'};
 console.error('Phase: '+phase+'; reason: '+(codes[error?.code]??'request or assertion failed'));
 for(const key of ['table','column']) if(typeof error?.[key]==='string' && /^[a-z_]{1,64}$/.test(error[key])) console.error('Schema '+key+': '+error[key]);
 process.exitCode=1;
} finally {
 if(fixtureCreated) {
  try {
   await db.query('BEGIN');
   // Recover IDs even if the create response was lost; scope every cleanup to this tenant.
   const users=await db.query('SELECT id FROM users WHERE tenant_id=$1',[tenantId]);
   const ids=users.rows.map(row=>row.id);
   for(const id of ids) {
    for(const operation of ['changePassword','createAccount','manageAccount'])
     await db.query('DELETE FROM auth_rate_limits WHERE subject_hash=$1',[createHash('sha256').update(operation+':'+id).digest('hex')]);
    await db.query('DELETE FROM auth_sessions WHERE user_id=$1',[id]);
    await db.query('DELETE FROM auth_password_audit WHERE user_id=$1',[id]);
   }
   await db.query('DELETE FROM auth_account_audit WHERE tenant_id=$1',[tenantId]);
   await db.query('DELETE FROM auth_management_audit WHERE tenant_id=$1',[tenantId]);
   await db.query('DELETE FROM users WHERE tenant_id=$1',[tenantId]);
   await db.query('DELETE FROM tenants WHERE id=$1',[tenantId]);
   for(const fixtureEmail of [email,targetEmail])
    await db.query('DELETE FROM auth_rate_limits WHERE subject_hash=$1',[createHash('sha256').update('login:'+fixtureEmail).digest('hex')]);
   await db.query('COMMIT');console.log('Temporary QA tenant and accounts removed.');
  } catch {await db.query('ROLLBACK').catch(()=>{});console.error('QA cleanup failed; operator review required.');process.exitCode=1;}
 }
 await db.end().catch(()=>{});
}
