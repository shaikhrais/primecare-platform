import {waitForFixtureStartup} from './fixtures/browser-startup.mjs';
import {openMfaSeed} from '../cloudflare/workers/src/security/mfa-secret.mjs';
import {totpAt} from '../cloudflare/workers/src/security/totp.mjs';
import {cp} from 'node:fs/promises';
import {setTimeout as pauseForMedia} from 'node:timers/promises';
import {chromium} from 'playwright';import {createServer} from 'node:http';import {readFile,mkdir,writeFile} from 'node:fs/promises';import {join,resolve} from 'node:path';import {createRequire} from 'node:module';import {mkdtemp} from 'node:fs/promises';import {tmpdir} from 'node:os';import {build} from 'esbuild';import pg from 'pg';import bcrypt from 'bcryptjs';import assert from 'node:assert/strict';
const connection=process.env.PLATFORM_TEST_DATABASE_URL;if(!connection)throw Error('Real PostgreSQL test connection required');
const testDatabase=new URL(connection);
if(!['localhost','127.0.0.1'].includes(testDatabase.hostname)||testDatabase.pathname!=='/platform'||process.env.PRODUCTION_DATABASE_URL)throw Error('Disposable loopback platform database only');
const governancePin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8'));
const governanceSchema='"'+governancePin.schema+'"',governanceRelation=name=>governanceSchema+'."'+governancePin.tablePrefix+name+'"';
const setup=new pg.Client({connectionString:connection});await setup.connect();const schema='platform_browser_'+Date.now();await setup.query(`CREATE SCHEMA ${schema};SET search_path TO ${schema}`);
await setup.query('CREATE TABLE tenants(id text PRIMARY KEY,name text,slug text UNIQUE,status text,created_at timestamptz DEFAULT NOW(),updated_at timestamptz NOT NULL DEFAULT NOW());ALTER TABLE tenants ADD COLUMN allowed_vpn_ranges text NOT NULL DEFAULT \'\',ADD COLUMN cors_allowed_origins jsonb NOT NULL DEFAULT \'[]\'::jsonb,ADD COLUMN cors_allowed_methods jsonb NOT NULL DEFAULT \'[]\'::jsonb,ADD COLUMN cors_allowed_headers jsonb NOT NULL DEFAULT \'[]\'::jsonb;CREATE TABLE users(id text PRIMARY KEY,email text UNIQUE,roles text,tenant_id text REFERENCES tenants(id),password_hash text,status text,updated_at timestamptz DEFAULT NOW());CREATE TABLE auth_sessions(user_id text REFERENCES users(id),token_hash text PRIMARY KEY,expires_at timestamptz,created_at timestamptz DEFAULT NOW());CREATE TABLE auth_password_audit(id uuid PRIMARY KEY DEFAULT gen_random_uuid(),user_id text REFERENCES users(id),action text,created_at timestamptz DEFAULT NOW());CREATE TABLE tenant_mail_configuration(tenant_id text,sender text,api_key_ciphertext text,templates jsonb)');
for(const migration of ['20261011_platform_administration.sql','20261011_admin_reports.sql','20260928_auth_rate_limits.sql','20261003_auth_password_resets.sql','20261025_auth_mfa.sql','20261031_tenant_dashboard.sql'])await setup.query(await readFile('packages/database/migrations/'+migration,'utf8'));
await setup.query("INSERT INTO tenants(id,name,slug,status) VALUES('platform-root','Platform Root','platform-root','active')");
const actor=crypto.randomUUID(),password='TestOnly-Platform-2026!';await setup.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,'platform@example.test','code_admin','platform-root',$2,'active')",[actor,await bcrypt.hash(password,12)]);
const scoped=new URL(connection);scoped.searchParams.set('options',`-c search_path=${schema}`);let emails=0,ownsGovernanceSchema=false;const env={MFA_ENCRYPTION_KEY:'a1'.repeat(32),SERVICE_NAME:'governance',DB_URL:scoped.toString(),EMAIL_FROM:'reports@example.com',EMAIL:{send:async()=>{emails++;return {messageId:'test-accepted'};}}};
const dir=await mkdtemp(join(tmpdir(),'platform-browser-handlers-'));await build({entryPoints:['cloudflare/workers/src/platform-administration.ts','cloudflare/workers/src/reporting.ts','cloudflare/workers/src/auth.ts','cloudflare/workers/src/workspace.ts','cloudflare/workers/src/tenant-dashboard/service.ts'],bundle:true,platform:'node',format:'cjs',outdir:dir,external:['pg']});
for(const f of ['platform-administration.js','reporting.js','auth.js','workspace.js','tenant-dashboard/service.js'])await writeFile(join(dir,f),(await readFile(join(dir,f),'utf8')).replaceAll('require("pg")',`require(${JSON.stringify(join(process.cwd(),'node_modules/pg'))})`));
const require=createRequire(import.meta.url);const {platformAdministration}=require(join(dir,'platform-administration.js'));const {reporting}=require(join(dir,'reporting.js'));const {auth}=require(join(dir,'auth.js'));const {workspace}=require(join(dir,'workspace.js'));const {tenantDashboard}=require(join(dir,'tenant-dashboard/service.js'));
const out=resolve('test-results/code-admin-browser');await mkdir(out,{recursive:true});const site=join(dir,'site');await mkdir(join(site,'assets'),{recursive:true});await cp('websites/typescript/public/assets',join(site,'assets'),{recursive:true});
await build({stdin:{contents:"import {renderAuth} from './websites/typescript/src/auth-screen';import {installPortalPresentation} from './websites/typescript/src/screen-presentation';import {resolveManagedRoute} from './websites/typescript/src/managed-routes';import theme from './packages/shared/src/solid-theme.json';import {renderPlatformAdmin} from './websites/typescript/src/platform-admin';import {renderTenantDashboard} from './websites/typescript/src/tenant-dashboard';const locale=new URLSearchParams(location.search).get('locale')||'en';document.documentElement.lang=locale;const root=document.getElementById('app');const gateway='http://127.0.0.1:4184/test-api';const manager=installPortalPresentation(root,theme,gateway);const entry=resolveManagedRoute(location.pathname,'au');manager.registerScope('entry',[entry]);void manager.present(entry.id,entry.route,()=>location.pathname==='/login'?renderAuth(root,gateway,'PrimeCare',locale):location.pathname==='/tenant-dashboard'?renderTenantDashboard(root,gateway):renderPlatformAdmin(root,gateway));",resolveDir:process.cwd()},bundle:true,outfile:join(site,'assets/app.js')});
await writeFile(join(site,'index.html'),'<!doctype html><html><head><meta charset="utf-8"><link rel="stylesheet" href="/assets/app.css"></head><body><div id="app"></div><script src="/assets/app.js"></script></body></html>');await writeFile(join(site,'assets/app.css'),await readFile('websites/typescript/src/styles.css'));
const origin='http://127.0.0.1:4184',requests=[];
async function prepareTenantDashboardFixture() {
 // The dashboard worker reads an exact pinned schema name. Create it only on
 // the disposable loopback database, and never take over an existing schema.
 await setup.query('CREATE SCHEMA '+governanceSchema);
 ownsGovernanceSchema=true;
 await setup.query('CREATE TABLE '+governanceRelation('source_manifest')+'(manifest_sha256 text)');
 await setup.query('INSERT INTO '+governanceRelation('source_manifest')+' VALUES($1)',[governancePin.manifestSha256]);
 await setup.query('CREATE TABLE '+governanceRelation('virtual_workflow_definitions')+'(flow_id text primary key,title text,flow_kind text,actor_roles_json text,definition_status text,verification_status text,test_status text,blocker_json text)');
 await setup.query('CREATE TABLE '+governanceRelation('virtual_workflow_steps')+'(flow_id text,step_order integer,action_text text,expected_text text,api_method text,api_path text)');
 await setup.query('CREATE TABLE provider_profiles(user_id text REFERENCES users(id),tenant_id text REFERENCES tenants(id),full_name text)');
}
async function verifyTenantAdminDashboardShortcut(browser) {
 const tenant='tenant-dashboard-fixture',email='dashboard-admin@example.test',password='TestOnly-TenantDashboard-2026!';
 await setup.query("INSERT INTO tenants(id,name,slug,status) VALUES($1,'Tenant Dashboard Fixture',$1,'active')",[tenant]);
 await setup.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'tenant_admin',$3,$4,'active')",[crypto.randomUUID(),email,tenant,await bcrypt.hash(password,12)]);
 const context=await browser.newContext({viewport:{width:1440,height:1000}});
 try {
  const page=await context.newPage(),cy=id=>page.locator('[data-cy="'+id+'"]');
  await page.goto(origin+'/login?enable-semantics=true');
  await cy('login-email').fill(email);
  await cy('login-password').fill(password);
  const [dashboard]=await Promise.all([
   page.waitForResponse(r=>new URL(r.url()).pathname==='/test-api/v1/governance/tenant-dashboard'&&r.request().method()==='GET'),
   waitForFixtureStartup(page,()=>cy('login-submit').click(),{selector:'[data-cy=screen-tenant-admin-dashboard]',timeoutMs:30000}),
  ]);
  assert.equal(dashboard.status(),200);
  const snapshot=await dashboard.json();
  assert.equal(snapshot.identity.role,'tenant_admin');
  assert.equal(snapshot.organization.id,tenant);
  assert.equal(snapshot.dataset,'live'); // The product's live data mode, backed only by this fixture DB.
  assert.equal(snapshot.synthetic,false);
  assert.equal(new URL(page.url()).pathname,'/tenant-dashboard');
  assert.equal(await cy('tenant-nav-overview').getAttribute('aria-current'),'page');
  if(!await cy('tenant-nav-people').isVisible())await cy('sidebar-toggle').click();
  await cy('tenant-nav-people').click();
  assert.equal(new URL(page.url()).hash,'#people');
  const shortcut=cy('tenant-shortcut-accounts');
  await shortcut.getByText('Accounts & roles',{exact:true}).waitFor();
  await waitForFixtureStartup(page,()=>shortcut.click(),{selector:'[data-cy=platform-account-form]',timeoutMs:30000});
  const target=new URL(page.url());
  assert.equal(target.origin,origin);
  assert.equal(target.pathname,'/platform/administration');
  assert.equal(target.hash,'#accounts');
  assert.equal(await cy('platform-topbar-tenant').inputValue(),tenant);
  assert.deepEqual(await cy('platform-topbar-tenant').locator('option').evaluateAll(options=>options.map(o=>o.value)),['',tenant]);
  return {browserSignIn:true,dashboardRendered:true,accountsShortcut:true,ownTenantSelected:true,scope:'Real Chromium sign-in, Tenant Dashboard and administration workers; isolated PostgreSQL; synthetic account'};
 }finally{await context.close();}
}
async function verifyTenantAdminTrainingRoute(browser) {
 const tenant='tenant-training-fixture',password='TestOnly-TenantTraining-2026!';
 const adminEmail='training-admin@example.test',pswEmail='training-psw@example.test';
 await setup.query("INSERT INTO tenants(id,name,slug,status) VALUES($1,'Tenant Training Fixture',$1,'active')",[tenant]);
 const hash=await bcrypt.hash(password,12);
 await setup.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'tenant_admin',$3,$4,'active'),($5,$6,'psw',$3,$4,'active')",[crypto.randomUUID(),adminEmail,tenant,hash,crypto.randomUUID(),pswEmail]);
 const url=origin+'/platform/administration?locale=fr&enable-semantics=true#training';
 async function signedIn(roleEmail,exercise){
  const context=await browser.newContext({viewport:{width:1280,height:900}});
  try{
   // Exercise real auth with synthetic rows without browser footage or secret output.
   const authResult=await context.request.post(origin+'/test-api/v1/auth/login',{data:{email:roleEmail,password}});
   assert.equal(authResult.status(),200);
   const {token}=await authResult.json();
   assert.ok(typeof token==='string'&&token.length>0,'Synthetic login must issue a session');
   const page=await context.newPage();
   await page.addInitScript(({origin,token})=>{
    if(location.origin===origin&&location.pathname==='/platform/administration')sessionStorage.setItem('primecare_session',token);
   },{origin,token});
   await exercise(page);
  }finally{await context.close();}
 }
 await signedIn(adminEmail,async page=>{
  const guide=page.locator('[data-cy=getting-started-guide]');
  await waitForFixtureStartup(page,()=>page.goto(url),{selector:'[data-cy=getting-started-guide]',timeoutMs:30000});
  assert.equal(new URL(page.url()).hash,'#training');
  assert.equal(await page.locator('[data-cy=platform-nav-training]').getAttribute('aria-current'),'page');
  await page.locator('.guide-detailed-lessons summary').click();
  const training=page.locator('[data-cy=screen-admin-training]');
  await training.getByRole('heading',{level:2}).waitFor();
  assert.equal(await training.getAttribute('lang'),'fr');
  await guide.locator('[data-step]').last().click();
  await waitForFixtureStartup(page,()=>guide.locator('[data-guide-dashboard]').click(),{selector:'[data-cy=screen-tenant-admin-dashboard]',timeoutMs:30000});
  const target=new URL(page.url());
  assert.equal(target.origin,origin);assert.equal(target.pathname,'/tenant-dashboard');assert.equal(target.hash,'#overview');
  await page.locator('[data-cy=screen-tenant-admin-dashboard]').getByText(/Tenant Training Fixture/).waitFor();
  assert.equal(target.searchParams.get('locale'),'fr');assert.equal(target.searchParams.get('enable-semantics'),'true');
 });
 await signedIn(pswEmail,async page=>{
  const denied=page.waitForResponse(r=>new URL(r.url()).pathname==='/test-api/v1/governance/platform'&&r.request().method()==='GET');
  await page.goto(url);
  assert.equal((await denied).status(),403);
  await page.getByRole('alert').waitFor();
  assert.equal(await page.locator('[data-cy=screen-admin-training], [data-cy=platform-nav-training]').count(),0);
 });
 return {tenantTrainingDirectEntry:true,trainingLanguage:'fr',dashboardNavigation:true,unauthorizedRoleDenied:true,dashboardRenderVerified:true,scope:'Real auth and administration worker against isolated native PostgreSQL; Chromium; destination rendered'};
}

async function verifyTenantAdminOnboarding(browser) {
 const tenant='tenant-onboarding-fixture',actorId=crypto.randomUUID();
 const adminEmail='tenant-admin-onboarding@example.test',staffEmail='tenant-admin-psw@example.test';
 const adminPassword='TestOnly-TenantAdmin-Onboarding-2026!',staffPassword='TestOnly-Staff-Onboarding-2026!';
 await setup.query("INSERT INTO tenants(id,name,slug,status) VALUES($1,'Tenant Onboarding Fixture',$1,'active')",[tenant]);
 await setup.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'tenant_admin',$3,$4,'active')",[actorId,adminEmail,tenant,await bcrypt.hash(adminPassword,12)]);
 const context=await browser.newContext({viewport:{width:1440,height:1000}});
 try {
  const page=await context.newPage(),cy=id=>page.locator('[data-cy="'+id+'"]');
  // Real login API plus direct console view. This does not cover dashboard shortcut wiring.
  const login=await context.request.post(origin+'/test-api/v1/auth/login',{data:{email:adminEmail,password:adminPassword}});
  assert.equal(login.status(),200);
  const {token:session}=await login.json();
  assert.ok(typeof session==='string'&&session.length>0,'Tenant Admin test session not issued');
  await page.addInitScript(({origin,value})=>{
   if(location.origin===origin&&location.pathname==='/platform/administration'&&!sessionStorage.getItem('primecare_session'))sessionStorage.setItem('primecare_session',value);
  },{origin,value:session});
  const landing=origin+'/platform/administration?enable-semantics=true';
  await waitForFixtureStartup(page,()=>page.goto(landing),{selector:'[data-cy=admin-organizations]',timeoutMs:30000});
  assert.equal(new URL(page.url()).hash,'');
  assert.equal(await cy('platform-topbar-tenant').inputValue(),tenant);
  assert.deepEqual(await cy('platform-topbar-tenant').locator('option').evaluateAll(options=>options.map(o=>o.value)),['',tenant]);
  assert.equal(await cy('platform-tenant-form').count(),0);
  if(!await cy('platform-nav-accounts').isVisible())await cy('sidebar-toggle').click();
  await cy('platform-nav-accounts').click();
  const account=cy('platform-account-form');await account.waitFor();
  assert.equal(new URL(page.url()).hash,'#accounts');
  const offered=await account.locator('[name=role] option').evaluateAll(options=>options.map(o=>o.value));
  assert.ok(offered.includes('psw'));
  assert.ok(['tenant_admin','platform_admin','code_admin'].every(role=>!offered.includes(role)));
  await account.locator('[name=email]').fill(staffEmail);
  await account.locator('[name=password]').fill(staffPassword);
  await account.locator('[name=role]').selectOption('psw');
  await account.locator('button').click();
  const staffRow=cy('platform-users').getByText(staffEmail,{exact:true});await staffRow.waitFor();
  const stored=(await setup.query("SELECT id,tenant_id,roles,status FROM users WHERE email=$1",[staffEmail])).rows;
  assert.equal(stored.length,1);
  assert.deepEqual({tenant:stored[0].tenant_id,role:stored[0].roles,status:stored[0].status},{tenant,role:'psw',status:'active'});
  await waitForFixtureStartup(page,()=>page.reload(),{selector:'[data-cy=platform-account-form]',timeoutMs:30000});
  await staffRow.waitFor();assert.equal(await cy('platform-topbar-tenant').inputValue(),tenant);
  if(!await cy('platform-nav-audit').isVisible())await cy('sidebar-toggle').click();
  await cy('platform-nav-audit').click();await cy('platform-audit').getByText(/account_created/).waitFor();
  const audit=(await setup.query("SELECT actor_id,tenant_id,target_id,current_state FROM platform_administration_audit WHERE action='account_created' AND target_id=$1",[stored[0].id])).rows;
  assert.deepEqual(audit,[{actor_id:actorId,tenant_id:tenant,target_id:stored[0].id,current_state:{role:'psw',status:'active'}}]);
  const foreign=await context.request.get(origin+'/test-api/v1/governance/platform/tenants/platform-root/accounts',{headers:{authorization:'Bearer '+session}});
  assert.equal(foreign.status(),403);
  return {existingTenantAutoSelected:true,staffAccount:true,accountReload:true,audit:true,foreignReadDenied:true,scope:'Direct Tenant Admin console with real auth/API and isolated PostgreSQL; dashboard shortcut not exercised'};
 }finally{await context.close();}
}
const trainingDevices=[['desktop',1440,900],['tablet',820,900],['mobile',390,844]];
async function recordTrainingLesson(browser,session,device,width,height) {
 assert.ok(typeof session==='string'&&session.length>0,'Synthetic browser session required for media');
 const context=await browser.newContext({viewport:{width,height},recordVideo:{dir:join(dir,'training-video'),size:{width,height}}});
 let page;
 try{
  // Use the active isolated-fixture session in memory. Never open sign-in or record MFA.
  await context.addInitScript(({origin,value})=>{
   if(location.origin===origin&&location.pathname==='/platform/administration')sessionStorage.setItem('primecare_session',value);
  },{origin,value:session});
  page=await context.newPage();
  const cy=id=>page.locator('[data-cy="'+id+'"]');
  const url=origin+'/platform/administration?locale=en&enable-semantics=true#training';
  await waitForFixtureStartup(page,()=>page.goto(url),{selector:'[data-cy=screen-admin-training]',timeoutMs:30000});
  assert.equal(new URL(page.url()).hash,'#training');
  await cy('screen-admin-training').waitFor();
  await cy('training-lessons').scrollIntoViewIfNeeded();
  // Pauses pace the tutorial footage; readiness always uses explicit assertions.
  await pauseForMedia(1200);
  await cy('training-lesson-authority').click();
  await cy('training-answer-1').click();
  await pauseForMedia(900);
  await cy('training-submit').click();
  assert.match(await cy('training-progress').textContent(),/1\/8/);
  await cy('training-status').scrollIntoViewIfNeeded();
  await pauseForMedia(1400);
  await cy('training-lesson-routine').click();
  await pauseForMedia(1400);
  assert.equal(await cy('training-lesson-routine').getAttribute('aria-current'),'step');
  assert.ok(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1),'Training must not overflow the viewport');
  const screenshot=`training-${device}-${width}.png`,video=`training-${device}-${width}.webm`;
  await page.screenshot({path:join(out,screenshot),fullPage:true});
  const recording=page.video();
  await context.close();
  assert.ok(recording,'Training recording is missing');
  await recording.saveAs(join(out,video));
  return {device,width,height,screenshot,video,scope:'English Code Admin training route; isolated synthetic account'};
 }finally{await context.close();}
}
const server=createServer(async(req,res)=>{try{const path=new URL(req.url,origin).pathname;if(path.startsWith('/test-api/')){let body='';for await(const chunk of req)body+=chunk;const url=origin+req.url.replace('/test-api','');requests.push({method:req.method,path:new URL(url).pathname});const r=new Request(url,{method:req.method,headers:req.headers,...(body?{body}:{})});const route=new URL(url).pathname.replace(/^\/v1\/(governance|auth)/,'').replace(/^\/v1\/user\/change-password$/,'/change-password');const response=(path.includes('/v1/auth/')||path.includes('/v1/user/'))?await auth(r,{...env,SERVICE_NAME:'auth'},route,{}):route.startsWith('/platform')?await platformAdministration(r,env,route,{}):route==='/tenant-dashboard'?await tenantDashboard(r,env,route,{}):route==='/workspace'?await workspace(r,env,route,{}):await reporting(r,env,route,{});if(!response){res.writeHead(404);res.end();return;}res.writeHead(response.status,Object.fromEntries(response.headers));res.end(Buffer.from(await response.arrayBuffer()));return;}const file=path==='/portal.json'?'portal.json':path.startsWith('/assets/')?path.slice(1):'index.html';res.setHeader('content-type',file.endsWith('.js')?'text/javascript':file.endsWith('.css')?'text/css':file.endsWith('.json')?'application/json':'text/html');res.end(await readFile(join(site,file)));}catch(e){console.error(e);res.writeHead(500);res.end('Test server failure');}});
await new Promise(r=>server.listen(4184,'127.0.0.1',r));const browser=await chromium.launch();const results=[],trainingMedia=[];let tenantAdminTraining=null,tenantAdminOnboarding=null,tenantAdminDashboard=null;
try{
 for(const [locale,width] of [['en',1440],['fr',1024],['es',768]]){
  const context=await browser.newContext({viewport:{width,height:1000}});const page=await context.newPage();const cy=id=>page.locator('[data-cy="'+id+'"]');
  try{
   await setup.query('DELETE FROM auth_mfa_challenges WHERE user_id=$1',[actor]);await setup.query('DELETE FROM auth_mfa_credentials WHERE user_id=$1',[actor]);
   await page.goto(origin+'/login?locale='+locale+'&enable-semantics=true');await cy('login-email').fill('platform@example.test');await cy('login-password').fill(password);await cy('login-submit').click();await cy('mfa-form').waitFor();assert.equal(await page.evaluate(()=>sessionStorage.getItem('primecare_session')),null);assert.equal((await setup.query('SELECT COUNT(*)::int AS n FROM auth_sessions WHERE user_id=$1',[actor])).rows[0].n,0);await cy('mfa-seed').waitFor();const credential=(await setup.query('SELECT envelope FROM auth_mfa_credentials WHERE user_id=$1',[actor])).rows[0];const seed=await openMfaSeed(credential.envelope,Uint8Array.from(env.MFA_ENCRYPTION_KEY.match(/../g),x=>parseInt(x,16)),{tenantId:'platform-root',userId:actor,keyId:'mfa-v1'});await cy('mfa-code').fill(await totpAt(seed,Math.floor(Date.now()/1000)));await waitForFixtureStartup(page,()=>cy('mfa-submit').click(),{selector:'[data-cy=platform-tenant-form]',timeoutMs:30000});await cy('platform-tenant-form').waitFor();assert.equal(await cy('mfa-seed').count(),0);assert.equal(new URL(page.url()).pathname,'/platform/administration');
   const form=cy('platform-tenant-form');await form.locator('[name=name]').fill('Code Admin '+locale);await form.locator('[name=slug]').fill('code-admin-'+locale);await form.locator('button').click();await cy('platform-account-form').waitFor();
   const account=cy('platform-account-form');assert.equal(await account.locator('[name=role] option[value=code_admin]').count(),0);await account.locator('[name=email]').fill('appointed-'+locale+'@example.test');await account.locator('[name=password]').fill('TestOnly-Appointed-2026!');await account.locator('[name=role]').selectOption('platform_admin');await account.locator('button').click();
   await page.waitForFunction(()=>document.querySelector('[data-cy=platform-users]')?.textContent.includes('appointed-'));
   const stored=(await setup.query('SELECT u.roles,t.slug FROM users u JOIN tenants t ON t.id=u.tenant_id WHERE u.email=$1',['appointed-'+locale+'@example.test'])).rows;assert.deepEqual(stored,[{roles:'platform_admin',slug:'code-admin-'+locale}]);
   await waitForFixtureStartup(page,()=>page.reload());assert.equal(new URL(page.url()).hash,'#accounts');assert.equal(await cy('platform-nav-tenant-selection').getAttribute('aria-current'),'page');if(!await cy('platform-nav-training').isVisible())await cy('sidebar-toggle').click();await cy('platform-nav-training').click();
   assert.equal(new URL(page.url()).pathname,'/platform/administration');
   assert.equal(new URL(page.url()).hash,'#training');
   const training=cy('screen-admin-training');await training.waitFor();
   assert.equal(await cy('screen-admin-training').getAttribute('lang'),locale);
   assert.equal(await cy('platform-nav-training').getAttribute('aria-current'),'page');
   assert.equal(await cy('training-lesson-authority').getAttribute('aria-current'),'step');
   await cy('training-answer-1').click();await cy('training-submit').click();
   assert.match(await cy('training-progress').textContent(),/1\/8/);
   await waitForFixtureStartup(page,()=>page.reload(),{selector:'[data-cy=screen-admin-training]',timeoutMs:30000});
   await training.waitFor();
   assert.equal(new URL(page.url()).hash,'#training');
   assert.equal(await cy('training-lesson-routine').getAttribute('aria-current'),'step');
   assert.match(await cy('training-progress').textContent(),/1\/8/);
   await page.screenshot({path:join(out,locale+'-training.png'),fullPage:true});
   if(locale==='en'){
    const session=await page.evaluate(()=>sessionStorage.getItem('primecare_session'));
    for(const device of trainingDevices)trainingMedia.push(await recordTrainingLesson(browser,session,...device));
   }
   if(!await cy('platform-logout').isVisible())await page.locator('[data-cy=shell-utilities] summary').click();await cy('platform-logout').click();await cy('login-submit').waitFor();assert.equal(await page.evaluate(()=>sessionStorage.getItem('primecare_session')),null);
   results.push({locale,width,loginRedirect:true,platformAdminAppointment:true,persistence:true,trainingMenuRoute:true,trainingDeepLinkReload:true,trainingResume:true,localTrainingProgress:true,logout:true});
  }finally{await context.close();}
 }
 assert.equal((await setup.query("SELECT COUNT(*)::int AS n FROM platform_administration_audit WHERE action='account_created'")).rows[0].n,3);
 console.log('CODE_ADMIN_BROWSER_PASS '+JSON.stringify(results));
 await prepareTenantDashboardFixture();
 tenantAdminDashboard=await verifyTenantAdminDashboardShortcut(browser);
 console.log('TENANT_ADMIN_DASHBOARD_SHORTCUT_PASS '+JSON.stringify(tenantAdminDashboard));
 tenantAdminTraining=await verifyTenantAdminTrainingRoute(browser);
 console.log('TENANT_ADMIN_TRAINING_ROUTE_PASS '+JSON.stringify(tenantAdminTraining));
 tenantAdminOnboarding=await verifyTenantAdminOnboarding(browser);
 console.log('TENANT_ADMIN_ONBOARDING_PASS '+JSON.stringify(tenantAdminOnboarding));
}finally{await writeFile(join(out,'results.json'),JSON.stringify({source:'Actual UI and handlers; isolated native PostgreSQL; synthetic accounts',commit:process.env.GITHUB_SHA??null,run:process.env.GITHUB_RUN_ID??null,results,trainingMedia,tenantAdminTraining,tenantAdminOnboarding,tenantAdminDashboard},null,2));await browser.close();await new Promise(r=>server.close(r));await setup.query('SET search_path TO public');if(ownsGovernanceSchema)await setup.query('DROP SCHEMA '+governanceSchema+' CASCADE');await setup.query(`DROP SCHEMA ${schema} CASCADE`);await setup.end();}
