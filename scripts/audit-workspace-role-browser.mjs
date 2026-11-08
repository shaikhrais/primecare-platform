/** Disposable SQL schema; real provisioning/auth/workspace handlers; no production accounts. */
import assert from 'node:assert/strict';import pg from 'pg';import {build} from 'esbuild';import {chromium} from 'playwright';import {createServer} from 'node:http';import {createRequire} from 'node:module';import {execFileSync} from 'node:child_process';import {mkdtemp,readFile,writeFile,mkdir} from 'node:fs/promises';import {tmpdir} from 'node:os';import {join} from 'node:path';
const connection=process.env.GROWTH_TEST_DATABASE_URL;if(!connection)throw Error('GROWTH_TEST_DATABASE_URL required');
if(!['localhost','127.0.0.1','[::1]'].includes(new URL(connection).hostname)||process.env.PRODUCTION_DATABASE_URL)throw Error('Disposable loopback database required');
const registry=JSON.parse(await readFile('cloudflare/workers/src/workspace-registry.json','utf8')),hierarchy=JSON.parse(await readFile('cloudflare/workers/src/admin-hierarchy.json','utf8')),accountPolicy=JSON.parse(await readFile('cloudflare/workers/src/account-policy.json','utf8'));
const special=new Set(['/growth','/appearance-review','/platform/administration','/maintenance/configuration','/forgot-password','/reset-password']);
const screens=registry.screens.filter(s=>s.renderer!=='account'&&!special.has(s.route)&&s.grants.some(g=>g.view===1)),roles=[...new Set(registry.screens.flatMap(s=>s.grants.filter(g=>g.view===1).map(g=>g.role)))].sort();
const db=new pg.Client({connectionString:connection});await db.connect();const schema='visual_roles_'+Date.now();let server,browser,cleanup=false;const records=[],report={scope:'isolated shared-renderer structural audit through the authenticated account shell; not production route dispatch',catalogScreens:registry.screens.length,targetScreens:screens.length,roles:roles.length,apiCreatedAccounts:0,bootstrapFixtures:1,bootstrapAccounts:[{role:'central_admin',provenance:'Direct disposable SQL account/session; not API provisioning or sign-in evidence'}],checked:0,samples:[],records,cleanup:{verified:false},limitations:['Structural browser checks are not individual human approval or complete clinical workflow acceptance','Domain data/API dependencies remain as recorded in governance; no readiness flags changed','Account/MFA/consent and dedicated screens are separate surfaces, not generic workspace renderer passes','The /success account shell is the entry point; dedicated default landings are checked separately by test-workspace-browser.mjs','Every original target remains accounted for: dedicated routes including /care receive document-handoff checks only, never generic renderer passes; dedicated renderer acceptance remains not tested']};
const folder='test-results/workspace-review';await mkdir(folder,{recursive:true});
try{
 await db.query(`CREATE SCHEMA ${schema};SET search_path TO ${schema}`);
 await db.query('CREATE TABLE tenants(id text PRIMARY KEY,name text,slug text UNIQUE,status text,created_at timestamptz DEFAULT NOW(),updated_at timestamptz DEFAULT NOW(),allowed_vpn_ranges text NOT NULL DEFAULT \'\',cors_allowed_origins jsonb NOT NULL DEFAULT \'[]\'::jsonb,cors_allowed_methods jsonb NOT NULL DEFAULT \'[]\'::jsonb,cors_allowed_headers jsonb NOT NULL DEFAULT \'[]\'::jsonb);CREATE TABLE users(id text PRIMARY KEY,email text UNIQUE,roles text,tenant_id text REFERENCES tenants(id),password_hash text,status text,updated_at timestamptz DEFAULT NOW());CREATE TABLE auth_sessions(token_hash text PRIMARY KEY,user_id text REFERENCES users(id),expires_at timestamptz);CREATE TABLE auth_account_audit(id uuid DEFAULT gen_random_uuid(),tenant_id text,action text,created_at timestamptz DEFAULT NOW());CREATE TABLE tenant_configuration_audit(id uuid DEFAULT gen_random_uuid(),tenant_id text,action text,created_at timestamptz DEFAULT NOW())');
 for(const name of ['20260928_auth_rate_limits','20261011_platform_administration'])await db.query(await readFile('packages/database/migrations/'+name+'.sql','utf8'));
 const root=crypto.randomUUID(),rootToken=Buffer.from(crypto.getRandomValues(new Uint8Array(32))).toString("base64url"),rootTenant=crypto.randomUUID();
 await db.query("INSERT INTO tenants(id,name,slug,status) VALUES($1,'Disposable operator tenant','visual-root','active')",[rootTenant]);await db.query("INSERT INTO users(id,email,roles,tenant_id,status) VALUES($1,'bootstrap@example.invalid','central_admin',$2,'active')",[root,rootTenant]);await db.query("INSERT INTO auth_sessions VALUES($1,$2,NOW()+INTERVAL '2 hours')",[Buffer.from(await crypto.subtle.digest('SHA-256',new TextEncoder().encode(rootToken))).toString('hex'),root]);
 const url=new URL(connection);url.searchParams.set('options','-c search_path='+schema);const env={SERVICE_NAME:'governance',DB_URL:url.toString()},dir=await mkdtemp(join(tmpdir(),'workspace-review-'));
 async function module(name){const file=join(dir,name+'.cjs');await build({entryPoints:['cloudflare/workers/src/'+name+'.ts'],bundle:true,platform:'node',format:'cjs',outfile:file,external:['pg']});await writeFile(file,(await readFile(file,'utf8')).replaceAll('require("pg")',`require(${JSON.stringify(join(process.cwd(),'node_modules/pg'))})`));return createRequire(import.meta.url)(file);}
 const {platformAdministration}=await module('platform-administration'),{auth}=await module('auth'),{workspace}=await module('workspace');
 const call=(path,body)=>platformAdministration(new Request('https://fixture'+path,{method:'POST',headers:{authorization:'Bearer '+rootToken,'content-type':'application/json','idempotency-key':crypto.randomUUID()},body:JSON.stringify(body)}),env,path,{});
 const tenantResponse=await call('/platform/tenants',{name:'Disposable visual review tenant',slug:'visual-review-'+Date.now()});assert.equal(tenantResponse.status,201,await tenantResponse.clone().text());const tenant=(await tenantResponse.json()).tenant.id;
 const tokens=new Map([['central_admin',rootToken]]);
 // Technical superuser is bootstrap-only. Keep this separate from API-created/sign-in evidence.
 if(roles.includes('code_admin')){
  // Historical CI generators omit Code Admin from administration scope, while retaining its workspace grants.
  // An omitted scope does not authorize provisioning; enforce the actual account policies and API rejection below.
  const codePolicy=hierarchy.roles.code_admin;
  if(codePolicy)assert.equal(codePolicy.bootstrapOnly,true,'Exported Code Admin scope must remain bootstrap-only');
  else assert.equal(hierarchy.permissions.code_admin,undefined,'An omitted Code Admin scope must not receive administration permissions');
  assert.ok(!accountPolicy.ceo.includes('code_admin'),'Account API must not accept Code Admin as an assignable role');
  assert.ok(Object.values(hierarchy.roles).every(policy=>!policy.assignable.includes('code_admin')),'No administrator may provision Code Admin');
  const deniedEmail='forbidden-code-admin@example.invalid',beforeCount=(await db.query('SELECT COUNT(*)::int AS n FROM users')).rows[0].n;
  const denied=await call('/platform/tenants/'+tenant+'/accounts',{email:deniedEmail,password:'Synthetic-'+crypto.randomUUID(),role:'code_admin'});
  assert.equal(denied.status,400,await denied.clone().text());
  assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM users')).rows[0].n,beforeCount,'Rejected Code Admin creation must not add accounts');
  assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM users WHERE email=$1',[deniedEmail])).rows[0].n,0);
  report.provisioningBoundaries=[{actor:'central_admin',targetRole:'code_admin',status:denied.status,accountCreated:false}];
  const id=crypto.randomUUID(),token=Buffer.from(crypto.getRandomValues(new Uint8Array(32))).toString('base64url');
  await db.query("INSERT INTO users(id,email,roles,tenant_id,status) VALUES($1,'bootstrap-code-admin@example.invalid','code_admin',$2,'active')",[id,rootTenant]);
  await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '2 hours')",[Buffer.from(await crypto.subtle.digest('SHA-256',new TextEncoder().encode(token))).toString('hex'),id]);
  if(!codePolicy){const scoped=await platformAdministration(new Request('https://fixture/platform',{headers:{authorization:'Bearer '+token}}),env,'/platform',{});assert.equal(scoped.status,403,'An omitted Code Admin scope must remain denied by the real administration API');}
  report.codeAdminHierarchyScope=codePolicy?'registered_bootstrap_only':'omitted_and_api_denied';
  tokens.set('code_admin',token);report.bootstrapFixtures++;report.bootstrapAccounts.push({role:'code_admin',provenance:'Direct disposable SQL account/session; does not test Code Admin login, MFA, or production bootstrap'});
 }
 for(const role of roles){if(tokens.has(role))continue;assert.ok(hierarchy.roles.central_admin.assignable.includes(role),'role must be governably provisionable: '+role);await db.query('DELETE FROM platform_administration_rate');const email='visual-'+role+'@example.invalid',password='Synthetic-'+crypto.randomUUID();const response=await call('/platform/tenants/'+tenant+'/accounts',{email,password,role});assert.equal(response.status,201,await response.clone().text());report.apiCreatedAccounts++;
  const session=await auth(new Request('https://fixture/login',{method:'POST',headers:{'content-type':'application/json'},body:JSON.stringify({email,password})}),{...env,SERVICE_NAME:'auth'},'/login',{});assert.equal(session.status,200,await session.clone().text());tokens.set(role,(await session.json()).token);
 }
 assert.deepEqual([...tokens.keys()].sort(),roles,'Every governed role must retain a session and coverage');
 assert.equal(report.bootstrapFixtures,report.bootstrapAccounts.length);
 assert.equal(report.apiCreatedAccounts+report.bootstrapFixtures,roles.length);
 report.successfulSignIns=report.apiCreatedAccounts;
 report.accountsBeforeCleanup=(await db.query('SELECT COUNT(*)::int AS n FROM users')).rows[0].n;assert.equal(report.accountsBeforeCleanup,roles.length);
 report.workspaceRoleAccess=[];
 for(const [role,token] of tokens){const response=await workspace(new Request('https://fixture/workspace',{headers:{authorization:'Bearer '+token}}),env,'/workspace',{});assert.equal(response.status,200,'workspace API for '+role);const payload=await response.json();assert.equal(payload.identity.role,role);report.workspaceRoleAccess.push({role,authorizedScreens:payload.screens.length});}
 report.accountActivity=(await db.query("SELECT action,COUNT(*)::int AS n FROM platform_administration_audit GROUP BY action ORDER BY action")).rows;
 console.log(JSON.stringify({stage:'accounts-created',roles:roles.length,apiCreated:report.apiCreatedAccounts}));
 const bundle=await build({stdin:{contents:"import {renderWorkspace} from './websites/typescript/src/workspace';import {installPortalPresentation} from './websites/typescript/src/screen-presentation';import {resolveManagedRoute} from './websites/typescript/src/managed-routes';import portalTheme from './packages/shared/src/solid-theme.json';const root=document.getElementById('app');const manager=installPortalPresentation(root,portalTheme,location.origin);manager.registerScope('entry',[resolveManagedRoute(location.pathname,'')]);globalThis.auditManagedRoute=route=>resolveManagedRoute(route,'').adapter;renderWorkspace(root,location.origin);",resolveDir:process.cwd()},bundle:true,platform:'browser',format:'iife',write:false}),css=await readFile('websites/typescript/src/styles.css','utf8');
 const theme=JSON.parse(execFileSync('python3',['-c',"import sqlite3,json;d=sqlite3.connect('.agents/governance/governance.db');print(json.dumps(dict(d.execute('SELECT css_variable_name,token_value FROM theme_design_tokens WHERE theme_id=1 AND active=1'))))"]).toString());
 server=createServer(async(req,res)=>{try{if(req.url.startsWith('/v1/governance/workspace')){const r=await workspace(new Request('http://localhost'+req.url.replace('/v1/governance',''),{headers:req.headers}),env,'/workspace',{});res.writeHead(r.status,Object.fromEntries(r.headers));res.end(await r.text());}else if(req.url==='/app.js'){res.setHeader('content-type','text/javascript');res.end(bundle.outputFiles[0].text);}else if(req.url.startsWith('/v1/')){res.writeHead(404,{'content-type':'application/json'});res.end('{"error":"Unavailable isolated fixture dependency"}');}else{res.setHeader('content-type','text/html');res.end(`<html><head><meta name="viewport" content="width=device-width,initial-scale=1"><style>:root{${Object.entries(theme).map(([k,v])=>k+':'+v+';').join('')}}${css}</style></head><body><div id="app"></div><script src="/app.js"></script></body></html>`);}}catch{res.writeHead(500);res.end('{}');}});await new Promise(r=>server.listen(0,'127.0.0.1',r));const origin='http://127.0.0.1:'+server.address().port;
 browser=await chromium.launch({headless:true,executablePath:process.env.GROWTH_BROWSER_EXECUTABLE,args:['--no-sandbox']});
 const assigned=new Map();for(const s of screens){const role=s.grants.find(g=>g.view===1&&tokens.has(g.role))?.role;assert.ok(role,'role for '+s.code);const list=assigned.get(role)??[];list.push(s);assigned.set(role,list);}
 for(const [role,pages] of assigned)for(const width of [320,1440]){
  const errors=[];
  const openWorkspacePage=async()=>{
   const next=await browser.newPage({viewport:{width,height:1000}});
   try{next.on('pageerror',e=>errors.push(e.message));await next.route('**/*',route=>new URL(route.request().url()).origin===origin?route.continue():route.abort());await next.addInitScript(token=>sessionStorage.setItem('primecare_session',token),tokens.get(role));await next.goto(origin+'/success?enable-semantics=true');await next.locator('[data-cy=workspace-title]').waitFor();return next;}
   catch(error){await next.close();throw error;}
  };
  let page=await openWorkspacePage();
  let captured=new Set();for(const screen of pages){if(width===320){const close=page.locator('[data-cy=sidebar-close]');if(!(await close.isVisible()))await page.locator('[data-cy=sidebar-toggle]').click();}
   const adapter=await page.evaluate(route=>globalThis.auditManagedRoute(route),screen.route);
   if(adapter!=='workspace'){
    // Observe the actual workspace document handoff without serving the shared
    // renderer at a dedicated URL. This is not dedicated renderer acceptance.
    const match=url=>url.origin===origin&&url.pathname===screen.route;
    let finishAbort,failAbort,abortTimer;const aborted=new Promise((resolve,reject)=>{finishAbort=resolve;failAbort=reject;});
    const abortNavigation=async route=>{if(route.request().isNavigationRequest()){try{await route.abort();finishAbort();}catch(error){failAbort(error);}}else await route.continue();};
    await page.route(match,abortNavigation);
    try{
     abortTimer=setTimeout(()=>failAbort(Error('Dedicated document abort did not complete: '+screen.route)),10000);
     const [request]=await Promise.all([page.waitForRequest(request=>request.isNavigationRequest()&&match(new URL(request.url()))),aborted,Promise.resolve().then(()=>page.locator(`[data-cy=app-sidebar] [data-cy="sidebar-item-${screen.code}"]`).click({noWaitAfter:true}))]);
     const destination=new URL(request.url());
     assert.equal(destination.pathname,screen.route);assert.equal(destination.searchParams.get('enable-semantics'),'true');
     records.push({code:screen.code,route:screen.route,role,width,renderer:screen.renderer,adapter,coverage:'dedicated-route-handoff',handoffPass:true,structuralPass:null,dedicatedRendererAcceptance:'not_tested',domainReady:screen.productionReady});report.checked++;
    }finally{clearTimeout(abortTimer);await page.unroute(match,abortNavigation);}
    // route.abort() acknowledges interception, not completion of Chromium's
    // later error-document navigation. Retire that frame before opening the
    // next authenticated shell; never race, retry or mask a failed reset.
    await page.close();page=await openWorkspacePage();
    continue;
   }
   await page.locator(`[data-cy=app-sidebar] [data-cy="sidebar-item-${screen.code}"]`).click();await page.locator(`[data-cy="screen-${screen.code}"]`).waitFor();if(width===320&&await page.locator('[data-cy=sidebar-close]').isVisible())await page.locator('[data-cy=sidebar-close]').click();
   const result=await page.evaluate(()=>({overflow:document.documentElement.scrollWidth>innerWidth+1,heading:document.querySelector('[data-cy=workspace-title]')?.textContent,sections:document.querySelectorAll('main>section').length,overflowElements:[...document.querySelectorAll('main *')].filter(e=>e.getBoundingClientRect().right>innerWidth+1).slice(0,6).map(e=>({tag:e.tagName,testId:e.getAttribute('data-cy'),text:e.textContent?.slice(0,120)}))}));
   records.push({code:screen.code,route:screen.route,role,width,renderer:screen.renderer,coverage:'shared-renderer-structure',headingMatches:result.heading===screen.name,horizontalOverflow:result.overflow,...(result.overflow?{overflowElements:result.overflowElements}:{}),domainReady:screen.productionReady,structuralPass:result.heading===screen.name&&!result.overflow,visualReview:'shared layout sample; individual approval not recorded'});report.checked++;
   if(!captured.has(screen.renderer)&&['ceo','rmt','patient','marketing','central_admin','tenant_admin','caregiver','platform_admin'].includes(role)){captured.add(screen.renderer);const file=role+'-'+screen.renderer+'-'+width+'.png';await page.screenshot({path:folder+'/'+file,fullPage:false});report.samples.push({file,screen:screen.code,role,width,renderer:screen.renderer});}
   if(report.checked%100===0)console.log(JSON.stringify({stage:'targets-checked',checked:report.checked,total:screens.length*2}));
  }assert.deepEqual(errors,[],'No page errors for '+role);await page.close();
 }
 report.sharedRendererChecks=records.filter(r=>r.coverage==='shared-renderer-structure').length;report.dedicatedHandoffChecks=records.filter(r=>r.coverage==='dedicated-route-handoff').length;report.dedicatedRendererAcceptance='not_tested';assert.equal(report.sharedRendererChecks+report.dedicatedHandoffChecks,screens.length*2);report.structuralFailures=records.filter(r=>r.coverage==='shared-renderer-structure'&&!r.structuralPass);assert.equal(report.checked,screens.length*2);assert.equal(report.structuralFailures.length,0,JSON.stringify(report.structuralFailures.slice(0,8)));
}finally{
 if(browser)await browser.close();if(server)await new Promise(r=>server.close(r));await db.query('SET search_path TO public');await db.query(`DROP SCHEMA IF EXISTS ${schema} CASCADE`);cleanup=(await db.query('SELECT COUNT(*)::int AS n FROM pg_namespace WHERE nspname=$1',[schema])).rows[0].n===0;report.cleanup={verified:cleanup,accountScope:'Entire disposable schema removed; no production records touched'};await db.end();
 await writeFile(folder+'/results.json',JSON.stringify(report,null,2)+'\n');console.log(JSON.stringify({stage:'cleanup',verified:cleanup,checked:report.checked,apiCreatedAccounts:report.apiCreatedAccounts}));
}
assert.equal(cleanup,true);
