import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import {createServer} from 'node:http';
import {mkdir,mkdtemp,readFile,rm,writeFile} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
import {build} from 'esbuild';
import bcrypt from 'bcryptjs';
import {chromium} from 'playwright';
import pg from 'pg';
import {waitForFixtureStartup} from './fixtures/browser-startup.mjs';

const caseName=process.env.TENANT_ADMIN_BROWSER_CASE??'own-sessions';
assert.ok(['own-sessions','password-and-logout'].includes(caseName),'Recognized synthetic browser case only');
const passwordAndLogout=caseName==='password-and-logout';
const dbUrl=new URL(process.env.TENANT_OWN_SESSIONS_TEST_DATABASE_URL??'');
if(!['localhost','127.0.0.1'].includes(dbUrl.hostname)||dbUrl.pathname!=='/tenant_own_sessions_test'||process.env.PRODUCTION_DATABASE_URL)
 throw Error('Disposable local tenant_own_sessions_test PostgreSQL only');
const db=new pg.Client({connectionString:dbUrl.href});
const schema='tenant_sessions_'+randomUUID().replaceAll('-','');
const pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8'));
assert.match(pin.schema,/^governance_[a-f0-9]+$/);
assert.equal(pin.tablePrefix,'govt_');
const relation=table=>'"'+pin.schema+'"."'+pin.tablePrefix+table+'"';
const dir=await mkdtemp(join(tmpdir(),'tenant-admin-own-sessions-'));
let server,browser,schemaOwned=false,pinOwned=false;
await db.connect();
try{
 await db.query('CREATE SCHEMA '+schema);schemaOwned=true;
 await db.query('SET search_path TO '+schema);
 await db.query(`
  CREATE TABLE tenants(id uuid PRIMARY KEY,name text NOT NULL,slug text UNIQUE,status text NOT NULL);
  CREATE TABLE users(id uuid PRIMARY KEY,email text UNIQUE,roles text NOT NULL,tenant_id uuid REFERENCES tenants(id),password_hash text,status text NOT NULL,updated_at timestamptz DEFAULT NOW());
  CREATE TABLE auth_sessions(user_id uuid REFERENCES users(id),token_hash text PRIMARY KEY,expires_at timestamptz,created_at timestamptz DEFAULT NOW());
  CREATE TABLE provider_profiles(user_id uuid REFERENCES users(id),tenant_id uuid REFERENCES tenants(id),full_name text);
 `);
 for(const migration of ['20260928_auth_rate_limits.sql','20260928_auth_management_audit.sql',...(passwordAndLogout?['20260928_auth_password_audit.sql']:[]),'20261003_auth_password_resets.sql','20261025_auth_mfa.sql','20261031_tenant_dashboard.sql'])
  await db.query(await readFile('packages/database/migrations/'+migration,'utf8'));
 // The real dashboard worker must pass the pinned-manifest check even in this
 // fixture. Only empty synthetic catalog tables are created on the service DB.
 await db.query('CREATE SCHEMA "'+pin.schema+'"');pinOwned=true;
 await db.query('CREATE TABLE '+relation('source_manifest')+'(manifest_sha256 text)');
 await db.query('INSERT INTO '+relation('source_manifest')+' VALUES($1)',[pin.manifestSha256]);
 await db.query('CREATE TABLE '+relation('virtual_workflow_definitions')+'(flow_id text primary key,title text,flow_kind text,actor_roles_json text,definition_status text,verification_status text,test_status text,blocker_json text)');
 await db.query('CREATE TABLE '+relation('virtual_workflow_steps')+'(flow_id text,step_order integer,action_text text,expected_text text,api_method text,api_path text)');
 const tenant=randomUUID(),otherTenant=randomUUID(),own=randomUUID(),other=randomUUID(),staff=randomUUID();
 const staffEmail='staff@example.test';
 const ownEmail='own-admin@example.test',otherEmail='foreign-admin@example.test',password='Synthetic-Tenant-Own-Sessions-2026!';
 const hash=await bcrypt.hash(password,12);
 await db.query("INSERT INTO tenants VALUES($1,'Own fixture agency','own-fixture','active'),($2,'Other fixture agency','other-fixture','active')",[tenant,otherTenant]);
 await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'tenant_admin',$3,$5,'active'),($4,$6,'tenant_admin',$7,$5,'active')",[own,ownEmail,tenant,other,hash,otherEmail,otherTenant]);
 if(passwordAndLogout)await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'psw',$3,$4,'active')",[staff,staffEmail,tenant,hash]);
 dbUrl.searchParams.set('options','-c search_path='+schema);
 const workerEnv={DB_URL:dbUrl.href,MFA_ENCRYPTION_KEY:'a1'.repeat(32)};
 const entries={auth:'cloudflare/workers/src/auth.ts',workspace:'cloudflare/workers/src/workspace.ts',tenant:'cloudflare/workers/src/tenant-dashboard/service.ts'};
 await build({entryPoints:entries,outdir:dir,bundle:true,platform:'node',format:'cjs',outExtension:{'.js':'.cjs'},external:['pg']});
 const require=createRequire(import.meta.url),handlers={};
 for(const key of Object.keys(entries)){
  const file=join(dir,key+'.cjs');
  await writeFile(file,(await readFile(file,'utf8')).replaceAll('require("pg")','require('+JSON.stringify(require.resolve('pg'))+')'));
  handlers[key]=require(file)[key==='tenant'?'tenantDashboard':key];
 }
 const bundle=await build({stdin:{resolveDir:process.cwd(),contents:`
  import {renderAuth} from './websites/typescript/src/auth-screen';
  import {renderTenantDashboard} from './websites/typescript/src/tenant-dashboard';
  import {renderWorkspace} from './websites/typescript/src/workspace';
  import {installPortalPresentation} from './websites/typescript/src/screen-presentation';
  import {resolveManagedRoute} from './websites/typescript/src/managed-routes';
  import theme from './packages/shared/src/solid-theme.json';
  const root=document.getElementById('app'), gateway=location.origin, path=location.pathname;
  const manager=installPortalPresentation(root,theme,gateway);
  const entry=resolveManagedRoute(path,'ci');
  manager.registerScope('entry',[entry]);
  void manager.present(entry.id,entry.route,()=>path==='/login'?renderAuth(root,gateway,'PrimeCare','en'):
   path==='/tenant-dashboard'?renderTenantDashboard(root,gateway):renderWorkspace(root,gateway));
 `},bundle:true,platform:'browser',write:false});
 const css=await readFile('websites/typescript/src/styles.css');
 const ownSessionDeletes=[],proofResponses=[];
 server=createServer(async(req,res)=>{
  try{
   const url=new URL(req.url,'http://127.0.0.1');
   if(url.pathname==='/app.js'){res.writeHead(200,{'content-type':'text/javascript'});res.end(bundle.outputFiles[0].text);return;}
   if(url.pathname==='/app.css'){res.writeHead(200,{'content-type':'text/css'});res.end(css);return;}
   if(!url.pathname.startsWith('/v1/')){
    if(!['/login','/tenant-dashboard','/success'].includes(url.pathname)){res.writeHead(404);res.end();return;}
    res.writeHead(200,{'content-type':'text/html'});res.end('<!doctype html><html lang="en"><meta name="viewport" content="width=device-width,initial-scale=1"><link rel="stylesheet" href="/app.css"><div id="app"></div><script src="/app.js"></script></html>');return;
   }
   const headers=new Headers(req.headers),chunks=[];
   for await(const chunk of req)chunks.push(chunk);
   const body=Buffer.concat(chunks),request=new Request(url,{method:req.method,headers,...(body.length?{body}:{})});
   const path=url.pathname,type=path==='/v1/governance/tenant-dashboard'?'tenant':path==='/v1/governance/workspace'?'workspace':'auth';
   const handlerPath=path==='/v1/user/change-password'?'/change-password':path==='/v1/user/sessions'?'/user/sessions':path.replace(/^\/v1\/(governance|auth)/,'');
   const result=await handlers[type](request,{...workerEnv,SERVICE_NAME:type==='auth'?'auth':'governance'},handlerPath,{});
   if(!result){res.writeHead(404);res.end();return;}
   const payload=Buffer.from(await result.arrayBuffer());
   if(path==='/v1/user/sessions'&&req.method==='DELETE')ownSessionDeletes.push({status:result.status,body:JSON.parse(payload.toString('utf8'))});
   if(passwordAndLogout&&req.method==='POST'&&['/v1/user/change-password','/v1/auth/logout'].includes(path))
    proofResponses.push({path,status:result.status,body:JSON.parse(payload.toString('utf8'))});
   res.writeHead(result.status,Object.fromEntries(result.headers));res.end(payload);
  }catch{res.writeHead(500);res.end('Fixture handler failed');}
 });
 await new Promise((resolve,reject)=>{server.once('error',reject);server.listen(0,'127.0.0.1',resolve);});
 const origin='http://127.0.0.1:'+server.address().port;
 browser=await chromium.launch();
 const context=await browser.newContext({viewport:{width:1440,height:1000}});
 const page=await context.newPage(),cy=id=>page.locator('[data-cy="'+id+'"]');
 await page.route('**/*',route=>new URL(route.request().url()).origin===origin?route.continue():route.abort());
 const match=(path,method)=>r=>new URL(r.url()).pathname===path&&r.request().method()===method;
 const sessionCount=async user=>(await db.query('SELECT COUNT(*)::int AS n FROM auth_sessions WHERE user_id=$1',[user])).rows[0].n;
 const attemptLogin=(email,supplied)=>context.request.post(origin+'/v1/auth/login',{data:{email,password:supplied}});
 const extraLogin=async(email,supplied=password)=>{
  const result=await attemptLogin(email,supplied);
  assert.equal(result.status(),200);
  const {token}=await result.json();assert.ok(typeof token==='string'&&token.length>0);
  return token;
 };
 const readSessions=token=>context.request.get(origin+'/v1/user/sessions',{headers:{authorization:'Bearer '+token}});
 const otherToken=await extraLogin(otherEmail);
 await page.goto(origin+'/login?enable-semantics=true');
 await cy('login-email').fill(ownEmail);await cy('login-password').fill(password);
 const [browserLogin]=await Promise.all([
  page.waitForResponse(match('/v1/auth/login','POST')),
  waitForFixtureStartup(page,()=>cy('login-submit').click(),{selector:'[data-cy=screen-tenant-admin-dashboard]',timeoutMs:30000}),
 ]);
 assert.equal(browserLogin.status(),200);
 // The click navigates: read the session persisted by the real login UI, not a retired CDP response body.
 const first=await page.evaluate(()=>sessionStorage.getItem('primecare_session'));assert.ok(typeof first==='string'&&first.length>0);
 assert.equal(new URL(page.url()).pathname,'/tenant-dashboard');
 const second=await extraLogin(ownEmail);assert.ok(first!==second,'Two distinct own-device tokens needed');
 assert.equal(await sessionCount(own),2);assert.equal(await sessionCount(other),1);
 if(passwordAndLogout){
  const staffToken=await extraLogin(staffEmail);
  const unchanged=async()=>assert.deepEqual((await db.query('SELECT id,roles,password_hash FROM users WHERE id=ANY($1::uuid[]) ORDER BY id',[other,staff])).rows,
   [other,staff].sort().map(id=>({id,roles:id===other?'tenant_admin':'psw',password_hash:hash})));
  const ownPassword=async()=>(await db.query('SELECT password_hash FROM users WHERE id=$1',[own])).rows[0].password_hash;
  const passwordAudit=async()=>(await db.query('SELECT user_id,action FROM auth_password_audit ORDER BY created_at')).rows;
  const currentToken=()=>page.evaluate(()=>sessionStorage.getItem('primecare_session'));
  const openAccount=()=>waitForFixtureStartup(page,()=>cy('tenant-top-account').click(),{selector:'[data-cy=change-password-form]',timeoutMs:30000});
  await openAccount();
  await cy('own-sessions-table-row-1').waitFor();
  assert.equal(new URL(page.url()).pathname,'/success');
  const initial=await readSessions(first);assert.equal(initial.status(),200);
  const current=await initial.json();assert.equal(current.pagination.total,2);
  assert.equal(current.sessions.filter(row=>row.current).length,1);
  const changedPassword='Synthetic-Tenant-New-Password-2026!';
  const fill=(value)=>Promise.all([cy('current-password').fill(value),cy('new-password').fill(changedPassword)]);
  await fill('Wrong-synthetic-current-password!');
  const [bad]=await Promise.all([page.waitForResponse(match('/v1/user/change-password','POST')),cy('change-password-submit').click()]);
  assert.equal(bad.status(),401);
  await page.waitForFunction(()=>!document.querySelector('[data-cy=change-password-submit]').disabled);
  assert.equal(await currentToken(),first);assert.equal(await sessionCount(own),2);
  assert.equal(await ownPassword(),hash);assert.deepEqual(await passwordAudit(),[]);
  await unchanged();
  await fill(password);
  const [changed]=await Promise.all([
   page.waitForResponse(match('/v1/user/change-password','POST')),
   page.waitForURL(url=>url.pathname==='/login'),cy('change-password-submit').click(),
  ]);
  assert.equal(changed.status(),200);await cy('login-submit').waitFor();
  assert.equal(await currentToken(),null);
  assert.deepEqual(proofResponses.at(-1),{path:'/v1/user/change-password',status:200,body:{status:'password_changed',reauthenticationRequired:true}});
  assert.ok(await bcrypt.compare(changedPassword,await ownPassword()));
  assert.deepEqual(await passwordAudit(),[{user_id:own,action:'password_changed'}]);
  assert.equal(await sessionCount(own),0);
  for(const token of [first,second])assert.equal((await readSessions(token)).status(),401);
  for(const token of [otherToken,staffToken])assert.equal((await readSessions(token)).status(),200);
  await unchanged();
  assert.equal((await attemptLogin(ownEmail,password)).status(),401);
  await cy('login-email').fill(ownEmail);await cy('login-password').fill(changedPassword);
  await waitForFixtureStartup(page,()=>cy('login-submit').click(),{selector:'[data-cy=screen-tenant-admin-dashboard]',timeoutMs:30000});
  const currentDevice=await currentToken(),siblingDevice=await extraLogin(ownEmail,changedPassword);
  assert.ok(currentDevice&&currentDevice!==siblingDevice);
  await openAccount();
  if(!await cy('workspace-logout').isVisible())await page.locator('[data-cy=shell-utilities] summary').click();
  const [loggedOut]=await Promise.all([
   page.waitForResponse(match('/v1/auth/logout','POST')),
   page.waitForURL(url=>url.pathname==='/login'),cy('workspace-logout').click(),
  ]);
  assert.equal(loggedOut.status(),200);await cy('login-submit').waitFor();
  assert.deepEqual(proofResponses.at(-1),{path:'/v1/auth/logout',status:200,body:{status:'signed_out'}});
  assert.equal(await currentToken(),null);assert.equal(await sessionCount(own),1);
  assert.equal((await readSessions(currentDevice)).status(),401);
  for(const token of [siblingDevice,otherToken,staffToken])assert.equal((await readSessions(token)).status(),200);
  assert.equal(await sessionCount(other),1);assert.equal(await sessionCount(staff),1);
  assert.deepEqual(await passwordAudit(),[{user_id:own,action:'password_changed'}]);await unchanged();
  await page.goto(origin+'/success?enable-semantics=true');await page.waitForURL(url=>url.pathname==='/login');
  await page.reload();await cy('login-submit').waitFor();
  assert.equal(await cy('change-password-form').count(),0);
  assert.equal(await currentToken(),null);
 }else{
 const [listed]=await Promise.all([
  page.waitForResponse(match('/v1/user/sessions','GET')),
  waitForFixtureStartup(page,()=>cy('tenant-top-account').click(),{selector:'[data-cy=own-sessions-table-row-1]',timeoutMs:30000}),
 ]);
 assert.equal(new URL(page.url()).pathname,'/success');
 assert.equal(listed.status(),200);
 const payload=await listed.json();
 assert.equal(payload.pagination.total,2);assert.equal(payload.sessions.length,2);
 assert.equal(payload.sessions.filter(row=>row.current).length,1);
 for(const row of payload.sessions)assert.deepEqual(Object.keys(row).sort(),['created_at','current','expires_at']);
 const stored=(await db.query(
  'SELECT created_at,expires_at FROM auth_sessions WHERE user_id=$1 ORDER BY created_at DESC,expires_at DESC,token_hash',[own]
 )).rows;
 for(const [i,row] of payload.sessions.entries()){
  assert.equal(Date.parse(row.created_at),stored[i].created_at.getTime());
  assert.equal(Date.parse(row.expires_at),stored[i].expires_at.getTime());
  assert.deepEqual(await cy('own-sessions-table-row-'+i).locator('time').evaluateAll(times=>times.map(time=>time.dateTime)),[row.created_at,row.expires_at]);
 }
 const [listedAfterReload]=await Promise.all([
  page.waitForResponse(match('/v1/user/sessions','GET')),
  waitForFixtureStartup(page,()=>page.reload(),{selector:'[data-cy=own-sessions-table-row-1]',timeoutMs:30000}),
 ]);
 assert.equal(listedAfterReload.status(),200);
 assert.deepEqual(await listedAfterReload.json(),payload);
 await cy('own-sessions-revoke').click();await cy('own-sessions-cancel-revoke').click();
 assert.equal(await sessionCount(own),2);assert.equal(await sessionCount(other),1);
 await cy('own-sessions-revoke').click();
 const [revoked]=await Promise.all([
  page.waitForResponse(match('/v1/user/sessions','DELETE')),
  page.waitForURL(url=>url.pathname==='/login'),
  cy('own-sessions-confirm-revoke').click(),
 ]);
 assert.equal(revoked.status(),200);
 assert.deepEqual(ownSessionDeletes,[{status:200,body:{revokedSessions:2,status:'signed_out_all_devices'}}]);
 assert.equal(await sessionCount(own),0);assert.equal(await sessionCount(other),1);
 assert.equal((await readSessions(first)).status(),401);
 assert.equal((await readSessions(second)).status(),401);
 assert.equal((await readSessions(otherToken)).status(),200);
 const audit=(await db.query('SELECT actor_user_id,target_user_id,tenant_id,previous_state,new_state FROM auth_management_audit')).rows;
 assert.deepEqual(audit,[{actor_user_id:own,target_user_id:own,tenant_id:tenant,previous_state:{sessionCount:2},new_state:{sessionCount:0,action:'sessions_revoked',initiatedBy:'self'}}]);
 await page.goto(origin+'/success?enable-semantics=true');
 await page.waitForURL(url=>url.pathname==='/login');
 await page.reload();await cy('login-submit').waitFor();
 assert.equal(await cy('own-sessions-panel').count(),0);
 assert.equal(await page.evaluate(()=>sessionStorage.getItem('primecare_session')===null),true);
 console.log('TENANT_ADMIN_OWN_SESSIONS_SCOPED_PASS sign-in/dashboard/account/list/cancel/revoke/reload/other-tenant/audit; synthetic Chromium + native PostgreSQL only');
 }
}finally{
 try{
  await browser?.close();
  if(server?.listening)await new Promise(resolve=>server.close(resolve));
 }finally{
  try{
   await db.query('SET search_path TO public');
   if(pinOwned)await db.query('DROP SCHEMA "'+pin.schema+'" CASCADE');
   if(schemaOwned)await db.query('DROP SCHEMA '+schema+' CASCADE');
   if(pinOwned||schemaOwned){
    const owned=[...(pinOwned?[pin.schema]:[]),...(schemaOwned?[schema]:[])];
    assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM pg_namespace WHERE nspname=ANY($1::text[])',[owned])).rows[0].n,0);
   }
  }finally{await db.end();await rm(dir,{recursive:true,force:true});}
 }
}

if(passwordAndLogout){
 const sourceCommit=process.env.GITHUB_SHA;
 assert.match(sourceCommit??'',/^[a-f0-9]{40}$/);
 const out='test-results/tenant-admin-password-logout';await mkdir(out,{recursive:true});
 await writeFile(out+'/results.json',JSON.stringify({sourceCommit,scope:'synthetic Chromium and native PostgreSQL; no production',role:'tenant_admin',cleanupVerified:true,wholeTaskVerified:false,cases:[
  {workflowId:'auth.change-password',status:'scoped-pass',wrongCurrentPreservesSession:true,currentAndSiblingInvalidated:true,otherTenantAndStaffUnaffected:true,auditOwnActor:true,oldRejectedAndNewLoginAccepted:true},
  {workflowId:'auth.logout',status:'scoped-pass',explicitAccountSignout:true,currentSessionInvalidated:true,siblingAndOtherAccountsPreserved:true,anonymousReloadDenied:true},
 ]},null,2)+'\n');
 console.log('TENANT_ADMIN_PASSWORD_LOGOUT_SCOPED_PASS own password and current-session signout; synthetic Chromium + native PostgreSQL only');
}
