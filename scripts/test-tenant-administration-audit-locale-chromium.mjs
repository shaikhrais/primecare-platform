import {waitForFixtureStartup} from './fixtures/browser-startup.mjs';
import {cp} from 'node:fs/promises';
import {chromium} from 'playwright';import {createServer} from 'node:http';import {readFile,mkdir,writeFile} from 'node:fs/promises';import {join,resolve} from 'node:path';import {createRequire} from 'node:module';import {mkdtemp} from 'node:fs/promises';import {tmpdir} from 'node:os';import {build} from 'esbuild';import pg from 'pg';import bcrypt from 'bcryptjs';import assert from 'node:assert/strict';
// GitHub-only real credential sign-in. No seeded tokens, mocked API responses or production access.
assert.equal(process.env.GITHUB_ACTIONS,'true','GitHub Actions only');
assert.match(process.env.GITHUB_SHA??'',/^[a-f0-9]{40}$/);
if(process.env.PRODUCTION_DATABASE_URL||process.env.DATABASE_URL||process.env.DB_URL)throw Error('External database variables forbidden');
const connection=process.env.PLATFORM_TEST_DATABASE_URL,testDatabase=new URL(connection);
if(!['postgres:','postgresql:'].includes(testDatabase.protocol)||!['127.0.0.1','localhost'].includes(testDatabase.hostname)||testDatabase.pathname!=='/platform_audit_browser_test'||testDatabase.search||testDatabase.hash)throw Error('Disposable loopback fixture database only');
const governancePin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8'));
const governanceSchema='"'+governancePin.schema+'"',governanceRelation=name=>governanceSchema+'."'+governancePin.tablePrefix+name+'"';
const setup=new pg.Client({connectionString:connection});await setup.connect();const schema='platform_browser_'+Date.now();await setup.query(`CREATE SCHEMA ${schema};SET search_path TO ${schema}`);
await setup.query('CREATE TABLE tenants(id text PRIMARY KEY,name text,slug text UNIQUE,status text,created_at timestamptz DEFAULT NOW(),updated_at timestamptz NOT NULL DEFAULT NOW());ALTER TABLE tenants ADD COLUMN allowed_vpn_ranges text NOT NULL DEFAULT \'\',ADD COLUMN cors_allowed_origins jsonb NOT NULL DEFAULT \'[]\'::jsonb,ADD COLUMN cors_allowed_methods jsonb NOT NULL DEFAULT \'[]\'::jsonb,ADD COLUMN cors_allowed_headers jsonb NOT NULL DEFAULT \'[]\'::jsonb;CREATE TABLE users(id text PRIMARY KEY,email text UNIQUE,roles text,tenant_id text REFERENCES tenants(id),password_hash text,status text,updated_at timestamptz DEFAULT NOW());CREATE TABLE auth_sessions(user_id text REFERENCES users(id),token_hash text PRIMARY KEY,expires_at timestamptz,created_at timestamptz DEFAULT NOW());CREATE TABLE auth_password_audit(id uuid PRIMARY KEY DEFAULT gen_random_uuid(),user_id text REFERENCES users(id),action text,created_at timestamptz DEFAULT NOW());CREATE TABLE tenant_mail_configuration(tenant_id text,sender text,api_key_ciphertext text,templates jsonb)');
for(const migration of ['20261011_platform_administration.sql','20261011_admin_reports.sql','20260928_auth_rate_limits.sql','20261003_auth_password_resets.sql','20261025_auth_mfa.sql','20261031_tenant_dashboard.sql'])await setup.query(await readFile('packages/database/migrations/'+migration,'utf8'));
const scoped=new URL(connection);scoped.searchParams.set('options',`-c search_path=${schema}`);let ownsGovernanceSchema=false;const env={SERVICE_NAME:'governance',DB_URL:scoped.toString()};
const dir=await mkdtemp(join(tmpdir(),'platform-browser-handlers-'));await build({entryPoints:['cloudflare/workers/src/platform-administration.ts','cloudflare/workers/src/reporting.ts','cloudflare/workers/src/auth.ts','cloudflare/workers/src/workspace.ts','cloudflare/workers/src/tenant-dashboard/service.ts'],bundle:true,platform:'node',format:'cjs',outdir:dir,external:['pg']});
for(const f of ['platform-administration.js','reporting.js','auth.js','workspace.js','tenant-dashboard/service.js'])await writeFile(join(dir,f),(await readFile(join(dir,f),'utf8')).replaceAll('require("pg")',`require(${JSON.stringify(join(process.cwd(),'node_modules/pg'))})`));
const require=createRequire(import.meta.url);const {platformAdministration}=require(join(dir,'platform-administration.js'));const {reporting}=require(join(dir,'reporting.js'));const {auth}=require(join(dir,'auth.js'));const {workspace}=require(join(dir,'workspace.js'));const {tenantDashboard}=require(join(dir,'tenant-dashboard/service.js'));
const out=resolve('test-results/tenant-administration-audit-chromium');await mkdir(out,{recursive:true});const site=join(dir,'site');await mkdir(join(site,'assets'),{recursive:true});await cp('websites/typescript/public/assets',join(site,'assets'),{recursive:true});
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
let serverFailed=false;
const server=createServer(async(req,res)=>{try{const path=new URL(req.url,origin).pathname;if(path.startsWith('/test-api/')){let body='';for await(const chunk of req)body+=chunk;const url=origin+req.url.replace('/test-api','');requests.push({method:req.method,path:new URL(url).pathname});const r=new Request(url,{method:req.method,headers:req.headers,...(body?{body}:{})});const route=new URL(url).pathname.replace(/^\/v1\/(governance|auth)/,'').replace(/^\/v1\/user\/change-password$/,'/change-password');const response=(path.includes('/v1/auth/')||path.includes('/v1/user/'))?await auth(r,{...env,SERVICE_NAME:'auth'},route,{}):route.startsWith('/platform')?await platformAdministration(r,env,route,{}):route==='/tenant-dashboard'?await tenantDashboard(r,env,route,{}):route==='/workspace'?await workspace(r,env,route,{}):await reporting(r,env,route,{});if(!response){res.writeHead(404);res.end();return;}res.writeHead(response.status,Object.fromEntries(response.headers));res.end(Buffer.from(await response.arrayBuffer()));return;}const file=path==='/portal.json'?'portal.json':path.startsWith('/assets/')?path.slice(1):'index.html';res.setHeader('content-type',file.endsWith('.js')?'text/javascript':file.endsWith('.css')?'text/css':file.endsWith('.json')?'application/json':'text/html');res.end(await readFile(join(site,file)));}catch(e){serverFailed=true;res.writeHead(500);res.end('Test server failure');}});
const summary={sourceCommit:process.env.GITHUB_SHA,workflowId:'platform.review-administration-audit',syntheticOnly:true,productionAccess:false,workflowAccepted:false,remainingMissing:['actor_identity_contract_and_projection','independent_review'],results:[]};
let browser;
try{
 await prepareTenantDashboardFixture();
 const tenant='audit-own',foreign='audit-other',actor=crypto.randomUUID(),target='synthetic-audit-target',password='TestOnly-Audit-2026!',email='audit-admin@example.test';
 await setup.query("INSERT INTO tenants(id,name,slug,status) VALUES($1,'Synthetic audit tenant',$1,'active'),($2,'Synthetic other tenant',$2,'active')",[tenant,foreign]);
 await setup.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'tenant_admin',$3,$4,'active')",[actor,email,tenant,await bcrypt.hash(password,12)]);
 const eventA=crypto.randomUUID(),eventB=crypto.randomUUID();
 for(const [id,tid,stamp,label]of [[eventA,tenant,'2026-01-02T00:00:00.000Z','Synthetic prior'],[eventB,tenant,'2026-01-03T00:00:00.000Z','Synthetic revised'],[crypto.randomUUID(),foreign,'2026-01-04T00:00:00.000Z','FOREIGN_CANARY']])await setup.query("INSERT INTO platform_administration_audit(id,actor_id,tenant_id,target_id,action,previous_state,current_state,created_at) VALUES($1,$2,$3,$4,'master_updated',$5,$6,$7)",[id,actor,tid,target,JSON.stringify({label:'Synthetic before',status:'active',version:1}),JSON.stringify({label,status:'inactive',version:2,unregisteredAuditField:'UNAPPROVED_CANARY'}),stamp]);
 const before=JSON.stringify((await setup.query('SELECT * FROM platform_administration_audit ORDER BY id')).rows);
 await new Promise(r=>server.listen(4184,'127.0.0.1',r));browser=await chromium.launch();
 for(const locale of ['en','fr','es']){
  const context=await browser.newContext({viewport:{width:1440,height:1000}}),page=await context.newPage(),errors=[];
  page.on('pageerror',()=>errors.push(true));
  await context.route('**/*',async route=>{if(new URL(route.request().url()).origin!==origin){errors.push(true);await route.abort();return;}await route.continue();});
  try{
   const cy=id=>page.locator('[data-cy="'+id+'"]');
   await page.goto(origin+'/login?enable-semantics=true&locale='+locale);
   await cy('login-email').fill(email);await cy('login-password').fill(password);
   const [login,dashboard]=await Promise.all([
    page.waitForResponse(r=>new URL(r.url()).pathname==='/test-api/v1/auth/login'&&r.request().method()==='POST'),
    page.waitForResponse(r=>new URL(r.url()).pathname==='/test-api/v1/governance/tenant-dashboard'&&r.request().method()==='GET'),
    waitForFixtureStartup(page,()=>cy('login-submit').click(),{selector:'[data-cy=screen-tenant-admin-dashboard]',timeoutMs:30000}),
   ]);
   assert.equal(login.status(),200);assert.equal(dashboard.status(),200);
   const snapshot=await dashboard.json();assert.equal(snapshot.identity.role,'tenant_admin');assert.equal(snapshot.organization.id,tenant);
   assert.equal(new URL(page.url()).pathname,'/tenant-dashboard');assert.equal(await page.locator('html').getAttribute('lang'),locale,'Login landing language must match requested locale');
   assert.ok((await setup.query('SELECT COUNT(*)::int AS n FROM auth_sessions WHERE user_id=$1',[actor])).rows[0].n>0);
   if(!await cy('tenant-nav-people').isVisible())await cy('sidebar-toggle').click();await cy('tenant-nav-people').click();
   const shortcutUrl=new URL(await cy('tenant-shortcut-accounts').getAttribute('href'),origin);assert.equal(shortcutUrl.origin,origin);assert.equal(shortcutUrl.pathname,'/platform/administration');assert.equal(shortcutUrl.hash,'#accounts');assert.equal(shortcutUrl.searchParams.get('locale')||'en',locale,'Accounts shortcut must retain language');
   await waitForFixtureStartup(page,()=>cy('tenant-shortcut-accounts').click(),{selector:'[data-cy=platform-account-form]',timeoutMs:30000});
   assert.equal(new URL(page.url()).pathname,'/platform/administration');assert.equal(new URL(page.url()).searchParams.get('locale')||'en',locale);assert.equal(await page.locator('html').getAttribute('lang'),locale);assert.equal(await cy('platform-language').inputValue(),locale);assert.equal(await cy('platform-topbar-tenant').inputValue(),tenant);
   assert.deepEqual(await cy('platform-topbar-tenant').locator('option').evaluateAll(o=>o.map(x=>x.value)),['',tenant]);
   if(!await cy('platform-nav-audit').isVisible())await cy('sidebar-toggle').click();
   await cy('platform-nav-audit').click();await cy('platform-audit').waitFor();
   const auditPath='/test-api/v1/governance/platform/tenants/'+tenant+'/audit';
   async function checkAudit(){
    const value=await page.evaluate(async path=>{const r=await fetch(path,{headers:{authorization:'Bearer '+sessionStorage.getItem('primecare_session')}});return {status:r.status,data:await r.json()};},auditPath);
    assert.equal(value.status,200);assert.deepEqual(value.data.events.map(e=>e.id),[eventB,eventA]);
    assert.equal(value.data.events.every(e=>!Object.hasOwn(e,'actor_id')),true);
    assert.equal(JSON.stringify(value.data).includes('UNAPPROVED_CANARY'),false);assert.equal(JSON.stringify(value.data).includes('FOREIGN_CANARY'),false);
    const rendered=await cy('platform-audit').innerText();for(const text of [target,'master_updated','Synthetic before','Synthetic revised','Synthetic prior','2026-01-03'])assert.ok(rendered.includes(text),'Required safe detail missing');
    assert.ok(rendered.indexOf('Synthetic revised')<rendered.indexOf('Synthetic prior'),'Newest event first');
    assert.equal(rendered.includes('UNAPPROVED_CANARY'),false);assert.equal(rendered.includes('FOREIGN_CANARY'),false);assert.equal(rendered.includes(email),false);assert.equal(rendered.includes(actor),false);
    assert.equal(await cy('platform-audit').locator('script,img').count(),0);
    return JSON.stringify(value.data);
   }
   const first=await checkAudit();const address=page.url();assert.equal(new URL(address).hash,'#audit');
   await waitForFixtureStartup(page,()=>page.reload(),{selector:'[data-cy=platform-audit]',timeoutMs:30000});
   assert.equal(page.url(),address);assert.equal(await page.locator('html').getAttribute('lang'),locale);assert.equal(await cy('platform-language').inputValue(),locale);assert.equal(await cy('platform-topbar-tenant').inputValue(),tenant);assert.equal(await checkAudit(),first);
   const denials=await page.evaluate(async({own,foreign})=>{const token=sessionStorage.getItem('primecare_session');const run=(path,headers={})=>fetch(path,{headers}).then(r=>r.status);return {unauthenticated:await run(own),foreign:await run(foreign,{authorization:'Bearer '+token}),override:await run(own,{authorization:'Bearer '+token,'x-tenant-id':'audit-other'})};},{own:auditPath,foreign:'/test-api/v1/governance/platform/tenants/'+foreign+'/audit'});
   assert.deepEqual(denials,{unauthenticated:401,foreign:403,override:400});
   assert.equal(JSON.stringify((await setup.query('SELECT * FROM platform_administration_audit ORDER BY id')).rows),before);
   assert.equal(errors.length,0);assert.equal(serverFailed,false);
   summary.results.push({locale,localeVerifiedAtDashboardAndAdministration:true,shortcutLocalePreserved:true,reloadLocalePreserved:true,realCredentialSignIn:true,persistedSession:true,dashboardAndAccountsShortcut:true,ownTenantOnly:true,safeAuditDetails:true,newestFirst:true,reloadStable:true,actorNotDisclosed:true,scopeDenials:true,historyUnchanged:true});
  }finally{await context.close();}
 }
}finally{
 if(browser)await browser.close();if(server.listening)await new Promise(r=>server.close(r));
 await setup.query('SET search_path TO public');if(ownsGovernanceSchema)await setup.query('DROP SCHEMA '+governanceSchema+' CASCADE');await setup.query(`DROP SCHEMA ${schema} CASCADE`);
 summary.disposableSchemaRemoved=(await setup.query('SELECT COUNT(*)::int AS n FROM pg_namespace WHERE nspname=$1',[schema])).rows[0].n===0;await setup.end();
 await writeFile(join(out,'summary.json'),JSON.stringify(summary,null,2)+'\n');
}
