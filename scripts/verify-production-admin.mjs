// Authorized live Admin verification: only unique, owned QA tenants are mutated.
import {Client} from 'pg';
import bcrypt from 'bcryptjs';
import {chromium} from 'playwright';
import {randomUUID,randomBytes,createHash} from 'node:crypto';
import {readFile} from 'node:fs/promises';
import assert from 'node:assert/strict';
import {runAdminBrowserScenario} from './admin-browser-scenario.mjs';

const gateway=new URL(process.env.GATEWAY_URL||'');
const ui=new URL(process.env.ADMIN_UI_URL||'');
if(process.env.CONFIRM_ADMIN_SMOKE!=='VERIFY_ADMIN'||gateway.origin!=='https://primecare-api-gateway.itpro-mohammed.workers.dev'||ui.href!=='https://primecare-support.pages.dev/')throw Error('Explicit Admin smoke configuration required');
const db=new Client({connectionString:process.env.PRODUCTION_DATABASE_URL,connectionTimeoutMillis:10000,query_timeout:10000});
const api=(path,options={})=>fetch(new URL('/v1/auth'+path,gateway),{...options,redirect:'error',signal:AbortSignal.timeout(15000)});
const hash=value=>createHash('sha256').update(value).digest('hex');
const catalogs=JSON.parse(await readFile('packages/contracts/locales/admin.json','utf8'));
let browser,phase='connect',passed=0;
async function cleanup(tenant,email) {
 await db.query('BEGIN');
 try {
  const users=(await db.query('SELECT id,email FROM users WHERE tenant_id=$1',[tenant])).rows;
  const prior=(await db.query("SELECT previous_state->>'email' AS email FROM auth_management_audit WHERE tenant_id=$1",[tenant])).rows;
  const emails=[...new Set([email,...users.map(user=>user.email),...prior.map(row=>row.email)].filter(Boolean))];
  const ids=users.map(user=>user.id);
  const counters=[...ids.flatMap(id=>['changePassword','createAccount','manageAccount'].map(operation=>hash(operation+':'+id))),...emails.flatMap(value=>['login','forgot','reset'].map(operation=>hash(operation+':'+value)))];
  await db.query('DELETE FROM auth_rate_limits WHERE subject_hash=ANY($1::text[])',[counters]);
  for(const table of ['auth_password_resets','auth_password_audit','auth_sessions'])await db.query(`DELETE FROM ${table} WHERE user_id::text=ANY($1::text[])`,[ids]);
  await db.query('DELETE FROM auth_account_audit WHERE tenant_id=$1',[tenant]);
  await db.query('DELETE FROM auth_management_audit WHERE tenant_id=$1',[tenant]);
  await db.query('DELETE FROM users WHERE tenant_id=$1',[tenant]);
  await db.query('DELETE FROM tenants WHERE id=$1',[tenant]);
  await db.query('COMMIT');
  assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM tenants WHERE id=$1',[tenant])).rows[0].n,0);
  assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM users WHERE tenant_id=$1',[tenant])).rows[0].n,0);
  assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM auth_sessions WHERE user_id::text=ANY($1::text[])',[ids])).rows[0].n,0);
  console.log('PASS: owned Admin QA tenant, accounts, sessions, audit and rate counters removed');
 } catch(error) {await db.query('ROLLBACK').catch(()=>{});throw error;}
}
try {
 await db.connect();browser=await chromium.launch({headless:true});
 for(const language of ['en','es','fr']) {
  const tenant=randomUUID(),admin=randomUUID(),email=`admin-live-${randomUUID()}@example.invalid`,password=randomBytes(24).toString('base64url');
  let created=false;
  try {
   phase='create owned '+language+' fixture';await db.query('BEGIN');
   try {
    await db.query("INSERT INTO tenants(id,name,slug,status,updated_at,allowed_vpn_ranges,cors_allowed_origins,cors_allowed_methods,cors_allowed_headers) VALUES($1,'Live Admin QA organization',$2,'active',NOW(),'','[]'::jsonb,'[]'::jsonb,'[]'::jsonb)",[tenant,'admin-live-'+tenant]);
    await db.query("INSERT INTO users(id,email,tenant_id,roles,password_hash,status,updated_at) VALUES($1,$2,$3,'admin',$4,'active',NOW())",[admin,email,tenant,await bcrypt.hash(password,12)]);
    await db.query('COMMIT');created=true;
   } catch(error) {await db.query('ROLLBACK');throw error;}
   phase='production access policy';
   const login=await api('/login',{method:'POST',headers:{'content-type':'application/json'},body:JSON.stringify({email,password})});assert.equal(login.status,200);const token=(await login.json()).token;
   const authorization='Bearer '+token;
   assert.equal((await api('/admin/workspace')).status,401);
   assert.equal((await api('/admin/workspace',{headers:{authorization,'x-tenant-id':randomUUID()}})).status,403);
   assert.equal((await api('/admin/workspace?status=paused',{headers:{authorization}})).status,400);
   assert.equal((await api('/admin/workspace/users',{method:'POST',headers:{authorization,'content-type':'application/json'},body:JSON.stringify({email:`blocked-${randomUUID()}@example.invalid`,role:'admin',password})})).status,400);
   assert.equal((await api('/admin/workspace/users/'+admin,{method:'PUT',headers:{authorization,'content-type':'application/json'},body:JSON.stringify({email,role:'client',status:'inactive'})})).status,403);
   assert.equal((await api('/logout',{method:'POST',headers:{authorization}})).status,200);
   console.log('PASS '+language+': public Admin authentication, tenant boundary, filter validation, role escalation and self-protection');passed+=5;
   await runAdminBrowserScenario({browser,db,language,strings:catalogs[language],email,password,tenant,admin,organization:'Live Admin QA organization',uiUrl:ui.href,api,onPhase:value=>phase=language+': '+value});
   passed++;
  } finally {
   if(created) {const previousPhase=phase;phase='cleanup owned '+language+' fixture';await cleanup(tenant,email);phase=previousPhase;}
  }
 }
 console.log(`PASS: production Admin browser workflow in EN/ES/FR; ${passed} policy/scenario assertions; owned fixtures cleaned`);
} catch(error) {
 // Do not print database URLs, response bodies, passwords or tokens.
 console.error('Production Admin verification failed during '+phase+'; reason: '+(error?.code==='ERR_ASSERTION'?'assertion failed':'request, browser or database operation failed'));process.exitCode=1;
 if(browser){const page=browser.contexts().flatMap(context=>context.pages())[0];if(page)await page.screenshot({path:'admin-production-failure.png'}).catch(()=>{});}
} finally {if(browser)await browser.close();await db.end().catch(()=>{});}
