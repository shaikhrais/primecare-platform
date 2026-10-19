import {scanAccessibility} from './browser-accessibility.mjs';
import {test,beforeEach} from 'node:test';
import assert from 'node:assert/strict';
import {createRequire} from 'node:module';
import {readFile,writeFile,mkdtemp,mkdir} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join,resolve} from 'node:path';
import {build} from 'esbuild';
import {chromium} from 'playwright';
import {createServer} from 'node:http';
import {execFileSync} from 'node:child_process';
const require=createRequire(import.meta.url),adapter=process.env.PLATFORM_TEST_ADAPTER;
if(!adapter&&!process.env.PLATFORM_TEST_DATABASE_URL)throw Error('Set PLATFORM_TEST_DATABASE_URL or explicit PLATFORM_TEST_ADAPTER');
const pg=require(adapter||'pg'),connection=process.env.PLATFORM_TEST_DATABASE_URL||'postgres://local/test',db=new pg.Client({connectionString:connection});await db.connect();const schema='accessibility_'+Date.now();await db.query(`CREATE SCHEMA ${schema};SET search_path TO ${schema}`);
let browser,server;
const root=crypto.randomUUID(),tenant=crypto.randomUUID(),other=crypto.randomUUID(),admin=crypto.randomUUID(),local=crypto.randomUUID(),stranger=crypto.randomUUID(),staff=crypto.randomUUID();
const tokens=new Map(),pdf=Buffer.from('%PDF-1.4\n1 0 obj << /Type /Catalog >> endobj\n%%EOF\n').toString('base64');
try{
 await db.query('CREATE TABLE tenants(id uuid PRIMARY KEY,name text,slug text UNIQUE,status text,created_at timestamptz DEFAULT NOW(),updated_at timestamptz DEFAULT NOW());CREATE TABLE users(id uuid PRIMARY KEY,email text UNIQUE,roles text,tenant_id uuid REFERENCES tenants(id),password_hash text,status text,updated_at timestamptz DEFAULT NOW());CREATE TABLE auth_sessions(user_id uuid REFERENCES users(id),token_hash text,expires_at timestamptz)');
 const migrations=['20261011_platform_administration','20261013_growth_marketing','20261013_growth_operations','20261013_growth_contacts','20261015_territory_allocation','20261015_territory_catalog','20261016_platform_bundle','20261016_platform_bundle'];for(const file of migrations)await db.query(await readFile('packages/database/migrations/'+file+'.sql','utf8'));
 for(const [id,name] of [[root,'Synthetic platform'],[tenant,'Synthetic ready care'],[other,'Synthetic other care']])await db.query("INSERT INTO tenants(id,name,slug,status) VALUES($1,$2,$3,'active')",[id,name,id]);
 for(const [id,tid,role] of [[admin,root,'platform_admin'],[local,tenant,'tenant_admin'],[stranger,other,'tenant_admin'],[staff,tenant,'psw']]){await db.query("INSERT INTO users(id,email,roles,tenant_id,status) VALUES($1,$2,$3,$4,'active')",[id,id+'@example.test',role,tid]);const token=Buffer.from(crypto.getRandomValues(new Uint8Array(32))).toString('base64url');tokens.set(id,token);await db.query("INSERT INTO auth_sessions VALUES($1,$2,NOW()+INTERVAL '1 hour')",[id,createHash(token)]);}
 for(const type of ['location','service_category'])await db.query('INSERT INTO platform_master_records(tenant_id,type,code,label) VALUES($1,$2,$2,$2)',[tenant,type]);
 await db.query("INSERT INTO platform_territory_sales(territory_id,tenant_id,actor_id,services,reference) VALUES('PC-REG-T0001',$1,$2,ARRAY['psw','home_care'],'Synthetic territory approval')",[tenant,admin]);
 const dir=await mkdtemp(join(tmpdir(),'platform-bundle-')),handler=join(dir,'handler.cjs');
 await build({entryPoints:['cloudflare/workers/src/platform-administration.ts'],bundle:true,platform:'node',format:'cjs',outfile:handler,external:['pg']});await writeFile(handler,(await readFile(handler,'utf8')).replaceAll('require("pg")',`require(${JSON.stringify(adapter||resolve('node_modules/pg'))})`));const {platformAdministration}=require(handler);
 const u=new URL(connection);u.searchParams.set('options',`-c search_path=${schema}`);const env={SERVICE_NAME:'governance',DB_URL:u.toString()};
 const call=(actor,path='',body,extra={})=>platformAdministration(new Request('http://test/platform/bundle'+path,{method:body?'POST':'GET',headers:{authorization:'Bearer '+(tokens.get(actor)||'invalid'),...(body?{'content-type':'application/json','idempotency-key':crypto.randomUUID()}:{}),...extra},...(body?{body:JSON.stringify(body)}:{})}),env,('/platform/bundle'+path).split('?')[0],{});
 const read=async(actor=admin,tid=tenant,q='')=>{const r=await call(actor,tid?'/tenants/'+tid+q:q);assert.equal(r.status,200);return r.json();};
 const command=async(actor,path,body,status=200,extra={})=>{const r=await call(actor,path,body,extra);const data=await r.json();assert.equal(r.status,status,JSON.stringify(data));return data;};
 beforeEach(async()=>{await db.query('DELETE FROM platform_bundle_rate');});
 const tenantPath='/tenants/'+tenant;
 const document=kind=>({kind,expiresOn:'2099-01-01',filename:kind+'.pdf',mediaType:'application/pdf',contentBase64:pdf});

 for(const file of ['20261013_growth_briefs','20261013_growth_reviews','20261017_growth_capacity','20261014_growth_tasks','20261014_growth_intake','20261014_growth_offline','20261014_growth_reporting','20261014_growth_business'])await db.query(await readFile('packages/database/migrations/'+file+'.sql','utf8'));
 const roleActors=new Map([['platform_admin',admin],['tenant_admin',local]]);
 for(const role of ['central_admin','ceo','owner','growth_caller','growth_meta']){const id=crypto.randomUUID(),token=Buffer.from(crypto.getRandomValues(new Uint8Array(32))).toString('base64url');roleActors.set(role,id);tokens.set(id,token);await db.query("INSERT INTO users(id,email,roles,tenant_id,status) VALUES($1,$2,$3,$4,'active')",[id,role+'@example.test',role,role==='central_admin'?root:tenant]);await db.query("INSERT INTO auth_sessions VALUES($1,$2,NOW()+INTERVAL '1 hour')",[id,createHash(token)]);}
 const campaign=crypto.randomUUID();await db.query("INSERT INTO growth_campaigns(id,tenant_id,name,source,reference,budget_cents,spend_cents) VALUES($1,$2,'Synthetic accessible campaign','facebook','Synthetic accessibility fixture',10000,1000)",[campaign,tenant]);
 for(const pipeline of ['client','tenant']){const id=crypto.randomUUID();await db.query("INSERT INTO growth_leads(id,tenant_id,pipeline,name,email,source,reference,contact_basis,contact_hash,owner_id,campaign_id) VALUES($1,$2,$3,$4,$5,'facebook','Synthetic accessibility fixture','requested',$8,$6,$7)",[id,tenant,pipeline,'Synthetic '+pipeline,id+'@example.test',roleActors.get('growth_caller'),campaign,id]);}
 const growthFile=join(dir,'growth.cjs');await build({entryPoints:['cloudflare/workers/src/growth/service.ts'],bundle:true,platform:'node',format:'cjs',outfile:growthFile,external:['pg']});await writeFile(growthFile,(await readFile(growthFile,'utf8')).replaceAll('require("pg")',`require(${JSON.stringify(adapter||resolve('node_modules/pg'))})`));const {growth}=require(growthFile);

 const gc=(actor,path='',method='GET',body,key=crypto.randomUUID())=>growth(new Request('http://test/growth'+path,{method,headers:{authorization:'Bearer '+tokens.get(actor),...(body?{'content-type':'application/json','idempotency-key':key}:{})},...(body?{body:JSON.stringify(body)}:{})}),env,('/growth'+path).split('?')[0],{});
 const gw=async(actor,path,method,body,status=201,key)=>{const r=await gc(actor,path,method,body,key),data=await r.json();assert.equal(r.status,status,JSON.stringify(data));return data;};
 const own=roleActors.get('owner'),ceo=roleActors.get('ceo'),meta=roleActors.get('growth_meta');
 let capacityCampaign;
 const proposal={name:'Synthetic owner policy campaign',source:'facebook',reference:'Synthetic role boundary fixture',budgetCents:0,spendCents:0};
 await test('role boundaries: owner access and tenant-admin cannot acquire owner authority',async()=>{
  const data=await gw(own,'','GET',undefined,200);assert.equal(data.identity.tenantId,tenant);assert.equal(data.canEditPlan,true);assert.equal(data.capabilities.manageCampaignMoney,true);
  const localData=await gw(local,'','GET',undefined,200);assert.equal(localData.canEditPlan,false);assert.equal(localData.capabilities.manageTeam,true);assert.deepEqual(localData.business.financeKinds,['invoice','payment']);
  assert.equal((await platformAdministration(new Request('http://test/platform/tenants/'+tenant+'/accounts',{method:'POST',headers:{authorization:'Bearer '+tokens.get(local),'content-type':'application/json','idempotency-key':crypto.randomUUID()},body:JSON.stringify({email:'no-owner@example.test',password:'Synthetic-Only-2026!',role:'owner'})}),env,'/platform/tenants/'+tenant+'/accounts',{})).status,400);
  const protectedReply=await platformAdministration(new Request('http://test/platform/tenants/'+tenant+'/accounts/'+own,{method:'PATCH',headers:{authorization:'Bearer '+tokens.get(local),'content-type':'application/json','idempotency-key':crypto.randomUUID()},body:JSON.stringify({role:'psw',status:'inactive'})}),env,'/platform/tenants/'+tenant+'/accounts/'+own,{});assert.equal(protectedReply.status,403);
 });
 await test('role boundaries: protected tenant administrator API matches disabled UI',async()=>{
  const id=crypto.randomUUID();await db.query("INSERT INTO users(id,email,roles,tenant_id,status) VALUES($1,$2,'tenant_admin',$3,'active')",[id,id+'@example.test',tenant]);
  const update=actor=>platformAdministration(new Request('http://test/platform/tenants/'+tenant+'/accounts/'+id,{method:'PATCH',headers:{authorization:'Bearer '+tokens.get(actor),'content-type':'application/json','idempotency-key':crypto.randomUUID()},body:JSON.stringify({role:'tenant_admin',status:'active'})}),env,'/platform/tenants/'+tenant+'/accounts/'+id,{});
  assert.equal((await update(admin)).status,403);assert.equal((await update(roleActors.get('central_admin'))).status,200);
 });
 await test('role boundaries: only owners change plans/money; operational team access remains',async()=>{
  const plan={start:'2026-10-01',end:'2026-10-31',version:0,targets:JSON.parse(await readFile('packages/shared/src/growth/registry.json','utf8')).targets};
  for(const actor of [local,meta,roleActors.get('growth_caller')])await gw(actor,'/plan','PUT',plan,403);
  await gw(own,'/plan','PUT',plan,200);const created=await gw(local,'/campaigns','POST',proposal);
  for(const actor of [local,meta]){await gw(actor,'/campaigns','POST',{...proposal,budgetCents:100},403);await gw(actor,'/campaigns/'+created.id,'PATCH',{version:1,budgetCents:0,spendCents:0},403);}
  await gw(local,'/team/'+roleActors.get('growth_caller'),'PUT',{specialty:'telephone_caller',version:0},200);
  await gw(own,'/campaigns/'+created.id,'PATCH',{version:1,budgetCents:1000,spendCents:100},200);
 });
 await test('role boundaries: tenant submits campaign; owner alone records approval',async()=>{
  const created=await gw(local,'/campaigns','POST',proposal),brief={version:0,ownerId:local,pipeline:'client',audience:'Synthetic requested-contact audience',offer:'Synthetic home care information',creative:'Synthetic draft',landingUrl:'',targetLeads:5,start:'2026-10-01',end:'2026-10-31'};
  await gw(local,'/briefs/'+created.id,'PUT',brief,200);await gw(local,'/reviews/'+created.id,'POST',{version:1,action:'submit',evidence:'Synthetic operator submits for owner review'});
  for(const actor of [local,meta])await gw(actor,'/reviews/'+created.id,'POST',{version:2,action:'approve',evidence:'Attempt non-owner approval'},403);
  await gw(own,'/reviews/'+created.id,'POST',{version:2,action:'approve',evidence:'Synthetic owner administrative campaign decision'});
  assert.equal((await db.query('SELECT actor_role FROM growth_campaign_reviews WHERE campaign_id=$1 AND action=\'approve\'',[created.id])).rows[0].actor_role,'owner');
  const decision=(await db.query("SELECT snapshot FROM growth_campaign_reviews WHERE campaign_id=$1 AND action='approve'",[created.id])).rows[0];assert.deepEqual(decision.snapshot.campaignBudget,{budgetCents:'0',campaignVersion:1,currency:'CAD'});
  await gw(own,'/campaigns/'+created.id,'PATCH',{version:1,budgetCents:25000,spendCents:0},200);
  let changed=(await db.query('SELECT status,version FROM growth_campaign_briefs WHERE campaign_id=$1',[created.id])).rows[0];assert.equal(changed.status,'draft');assert.equal(changed.version,4);
  await gw(own,'/reviews/'+created.id,'POST',{version:3,action:'approve',evidence:'Attempt stale approval after changed budget'},409);
  await gw(local,'/reviews/'+created.id,'POST',{version:4,action:'submit',evidence:'Submit changed budget for fresh approval'});
  await gw(own,'/reviews/'+created.id,'POST',{version:5,action:'approve',evidence:'Approve new budget'});
  await gw(own,'/campaigns/'+created.id,'PATCH',{version:2,budgetCents:25000,spendCents:100},200);
  changed=(await db.query('SELECT status,version FROM growth_campaign_briefs WHERE campaign_id=$1',[created.id])).rows[0];assert.equal(changed.status,'approved');assert.equal(changed.version,6);

 });
 await test('role boundaries: owner administration stays inside its tenant and cannot approve launch/documents',async()=>{
  const get=path=>platformAdministration(new Request('http://test/platform'+path,{headers:{authorization:'Bearer '+tokens.get(own)}}),env,'/platform'+path,{});
  const r=await get('');assert.equal(r.status,200);const data=await r.json();assert.equal(data.scope,'tenant');assert.equal(data.canCreateTenant,false);assert.deepEqual(data.tenants.map(t=>t.id),[tenant]);assert.ok(!data.assignableRoles.includes('owner'));assert.ok(!data.assignableRoles.includes('ceo'));
  assert.equal((await get('/tenants/'+other+'/accounts')).status,403);
  const board=await get('/territories');assert.equal(board.status,200);const territoryData=await board.json();assert.equal(territoryData.canManage,false);assert.ok(territoryData.territories.every(t=>t.allocation.tenantId===tenant));
  assert.equal((await call(own,'/tenants/'+other)).status,404);assert.equal((await call(own,tenantPath+'/launch',{version:0,action:'approve',evidence:'Attempt self launch approval',confirmed:true})).status,403);
  const documentId=crypto.randomUUID();assert.equal((await call(own,tenantPath+'/documents/'+documentId+'/review',{version:1,decision:'approved',evidence:'Attempt owner document approval'})).status,403);
  await db.query("UPDATE users SET roles='owner' WHERE id=$1",[stranger]);try{assert.equal((await gc(stranger,'/campaigns/'+campaign,'PATCH',{version:1,budgetCents:50,spendCents:0})).status,404);const foreign=await gw(stranger,'','GET',undefined,200);assert.equal(foreign.identity.tenantId,other);assert.equal(foreign.leads.length,0);}finally{await db.query("UPDATE users SET roles='tenant_admin' WHERE id=$1",[stranger]);}
 });
 await test('role boundaries: finance restrictions and revoked owner replay fail closed',async()=>{
  const expense={kind:'expense',reference:'Synthetic owner expense',amountCents:100,date:'2026-10-01',leadId:null,invoiceId:null,category:'overhead',evidence:'Synthetic receipt reference'};
  await gw(local,'/finance','POST',expense,403);const key=crypto.randomUUID(),created=await gw(own,'/campaigns','POST',{...proposal,budgetCents:1000},201,key);
  await db.query("UPDATE users SET roles='tenant_admin' WHERE id=$1",[own]);try{await gw(own,'/campaigns','POST',{...proposal,budgetCents:1000},403,key);await gw(own,'/finance','POST',expense,403);await gw(own,'/campaigns/'+created.id,'PATCH',{version:1,budgetCents:2000,spendCents:0},403);}finally{await db.query("UPDATE users SET roles='owner' WHERE id=$1",[own]);}
  await gw(own,'/finance','POST',expense);assert.equal((await db.query('SELECT budget_cents::int AS budget FROM growth_campaigns WHERE id=$1',[created.id])).rows[0].budget,1000);
  assert.equal((await gc(stranger,'/campaigns/'+created.id,'PATCH',{version:1,budgetCents:2000,spendCents:0})).status,403);
 });
 await test('marketing statements: scoped monthly reports, validated options, PDF and access denials',async()=>{
  const month=new Date().toISOString().slice(0,7);
  const r=await gw(own,'/marketing-statement?month='+month+'&locale=fr','GET',undefined,200);assert.equal(r.locale,'fr');assert.equal(r.id,'growth_marketing_statement');assert.ok(r.scope.includes(tenant));assert.ok(!JSON.stringify(r).includes('@example.test'));
  for(const actor of [meta,roleActors.get('growth_caller'),roleActors.get('central_admin')]){await gw(actor,'/marketing-statement','GET',undefined,403);await gw(actor,'/marketing-statement/pdf','GET',undefined,403);}
  for(const query of ['month=2026-13','month=9999-01','month=1999-12','month=2026-01&month=2026-02','tenantId='+other,'locale=de'])await gw(own,'/marketing-statement?'+query,'GET',undefined,400);
  await gw(own,'/marketing-statement','POST',{},405);
  const pdf=await gc(own,'/marketing-statement/pdf?month='+month);assert.equal(pdf.status,200);assert.equal(pdf.headers.get('content-type'),'application/pdf');assert.equal(pdf.headers.get('cache-control'),'no-store');assert.ok(pdf.headers.get('content-disposition').includes(month));assert.ok((await pdf.text()).startsWith('%PDF-1.4'));
  const foreign=await gw(stranger,'/marketing-statement','GET',undefined,200);assert.ok(foreign.scope.includes(other));assert.ok(!foreign.scope.includes(tenant));assert.equal(foreign.rows.find(r=>r.item==='Proposed total contribution (5%)').value,'CAD 0.00');
 });
 await test('campaign capacity: owner-only confirmation, stale review and retries, revoked authority and immutable history',async()=>{
  const created=await gw(own,'/campaigns','POST',{...proposal,budgetCents:10000});capacityCampaign=created.id;
  const brief={version:0,ownerId:local,pipeline:'client',audience:'Synthetic local audience',offer:'Synthetic requested discussion',creative:'Synthetic local campaign',landingUrl:'',targetLeads:5,start:'2026-10-01',end:'2026-10-31'};
  await gw(local,'/briefs/'+created.id,'PUT',brief,200);
  const expiry=new Date(Date.now()+86400000).toISOString(),body={version:0,briefVersion:1,clientSlots:3,expiresAt:expiry,evidence:'Synthetic operations capacity reviewed'};
  await gw(own,'/capacity/'+created.id,'PUT',body,409);
  await gw(local,'/reviews/'+created.id,'POST',{version:1,action:'submit',evidence:'Submit'});await gw(own,'/reviews/'+created.id,'POST',{version:2,action:'approve',evidence:'Owner reviewed budget'});
  const v={...body,briefVersion:3};for(const actor of [local,meta,roleActors.get('growth_caller')])await gw(actor,'/capacity/'+created.id,'PUT',v,403);
  const key=crypto.randomUUID();await gw(own,'/capacity/'+created.id,'PUT',v,200,key);await gw(own,'/capacity/'+created.id,'PUT',v,200,key);await gw(own,'/capacity/'+created.id,'PUT',v,409);
  const status=async()=>(await gw(ceo,'','GET',undefined,200)).campaigns.find(c=>c.id===created.id).readiness;
  let state=await status();assert.equal(state.readyForProviderSetup,true);assert.equal(state.canLaunch,false);assert.equal(state.capacity.version,1);
  await db.query("UPDATE users SET roles='tenant_admin' WHERE id=$1",[own]);try{assert.equal((await status()).readyForProviderSetup,false);await gw(own,'/capacity/'+created.id,'PUT',v,403,key);}finally{await db.query("UPDATE users SET roles='owner' WHERE id=$1",[own]);}
  await assert.rejects(()=>db.query('UPDATE growth_campaign_capacity SET client_slots=99 WHERE campaign_id=$1',[created.id]),/immutable/);
  await gw(own,'/capacity/'+created.id,'PUT',{...v,version:1,clientSlots:0},200);assert.equal((await status()).readyForProviderSetup,false);
  await gw(own,'/campaigns/'+created.id,'PATCH',{version:1,budgetCents:20000,spendCents:0},200);assert.equal((await status()).gates.find(g=>g.key==='brief').ok,false);await gw(own,'/capacity/'+created.id,'PUT',{...v,version:2},409);
  await gw(local,'/reviews/'+created.id,'POST',{version:4,action:'submit',evidence:'Resubmit changed budget'});await gw(own,'/reviews/'+created.id,'POST',{version:5,action:'approve',evidence:'Owner reviewed changed budget'});assert.equal((await status()).gates.find(g=>g.key==='capacity').ok,false);
  await gw(own,'/capacity/'+created.id,'PUT',{...v,version:2,briefVersion:6},200);assert.equal((await status()).readyForProviderSetup,true);
  await db.query("UPDATE users SET roles='owner' WHERE id=$1",[stranger]);try{await gw(stranger,'/capacity/'+created.id,'PUT',v,404);}finally{await db.query("UPDATE users SET roles='tenant_admin' WHERE id=$1",[stranger]);}
  await db.query("CREATE FUNCTION fail_capacity_audit() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'synthetic audit failure'; END $$;CREATE TRIGGER fail_capacity_audit BEFORE INSERT ON growth_audit FOR EACH ROW EXECUTE FUNCTION fail_capacity_audit()");try{await gw(own,'/capacity/'+created.id,'PUT',{...v,version:3,briefVersion:6},503);}finally{await db.query('DROP TRIGGER fail_capacity_audit ON growth_audit');}
  await db.query('ALTER TABLE growth_campaign_capacity RENAME TO growth_campaign_capacity_held');try{const missing=await status();assert.equal(missing.schemaReady,false);assert.equal(missing.canConfirm,false);await gw(own,'/capacity/'+created.id,'PUT',{...v,version:3,briefVersion:6},503);}finally{await db.query('ALTER TABLE growth_campaign_capacity_held RENAME TO growth_campaign_capacity');}
  assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM growth_campaign_capacity WHERE campaign_id=$1',[created.id])).rows[0].n,3);
 });
 // Actual browser uses the platform shell and the API handler, not a mocked success response.
 const {outputFiles,metafile}=await build({stdin:{contents:"import {renderPlatformAdmin} from './websites/typescript/src/platform-admin';import {renderGrowth} from './websites/typescript/src/growth/dashboard';location.pathname.startsWith('/growth')?renderGrowth(document.getElementById('app'),location.origin):renderPlatformAdmin(document.getElementById('app'),location.origin);",resolveDir:process.cwd()},bundle:true,platform:'browser',format:'iife',write:false,metafile:true});assert.ok(!Object.keys(metafile.inputs).some(p=>p.includes('platform-bundle/service')||p.includes('node_modules/pg/')));
 const style=await readFile('websites/typescript/src/styles.css','utf8'),theme=JSON.parse(execFileSync('python3',['-c',"import sqlite3,json;d=sqlite3.connect('.agents/governance/governance.db');print(json.dumps(dict(d.execute('SELECT css_variable_name,token_value FROM theme_design_tokens WHERE theme_id=1 AND active=1'))))"]).toString());
 server=createServer(async(req,res)=>{try{if(req.url.startsWith('/v1/governance/platform')||req.url.startsWith('/v1/governance/growth')){const chunks=[];for await(const c of req)chunks.push(c);const body=Buffer.concat(chunks),path=req.url.replace('/v1/governance','');const handler=path.startsWith('/growth')?growth:platformAdministration;const r=await handler(new Request('http://localhost'+path,{method:req.method,headers:req.headers,...(body.length?{body}:{})}),env,path.split('?')[0],{});res.writeHead(r.status,Object.fromEntries(r.headers));res.end(Buffer.from(await r.arrayBuffer()));}else if(req.url==='/app.js'){res.setHeader('content-type','text/javascript');res.end(outputFiles[0].text);}else if(req.url.startsWith('/assets/')){try{const path=new URL(req.url,'http://test').pathname;res.setHeader('content-type',path.endsWith('.webp')?'image/webp':path.endsWith('.svg')?'image/svg+xml':'image/png');res.end(await readFile('websites/typescript/public'+path));}catch{res.writeHead(404);res.end();}}else if(req.url.startsWith('/v1/')){res.writeHead(404);res.end('{}');}else{res.setHeader('content-type','text/html');res.end(`<html lang="en"><head><title>PrimeCare</title><meta name="viewport" content="width=device-width,initial-scale=1"><style>:root{${Object.entries(theme).map(([k,v])=>k+':'+v+';').join('')}}${style}</style></head><body><div id="app"></div><script src="/app.js"></script></body></html>`);}}catch(e){console.error(e);res.writeHead(500);res.end('{}');}}).listen(0,'127.0.0.1');await new Promise(r=>server.once('listening',r));const base='http://127.0.0.1:'+server.address().port;
 browser=await chromium.launch({headless:true,...(process.env.GROWTH_BROWSER_EXECUTABLE?{executablePath:process.env.GROWTH_BROWSER_EXECUTABLE,args:['--no-sandbox','--disable-dev-shm-usage']}:{})});await mkdir('test-results/platform-bundle',{recursive:true});
 const labels=JSON.parse(await readFile('packages/shared/src/platform-bundle/registry.json','utf8')).locales;
 for(const role of ['central_admin','platform_admin','tenant_admin','owner'])for(const lang of role==='central_admin'?['en']:['en','fr','es'])for(const width of [320,1440])await test(`admin accessibility and keyboard navigation: ${role}, ${lang}, ${width}px`,async()=>{
  await db.query('DELETE FROM platform_bundle_rate');const page=await browser.newPage({viewport:{width,height:1000}}),el=id=>page.locator('[data-cy="'+id+'"]');
  const settle=()=>page.waitForFunction(()=>document.querySelector('[data-cy=platform-refresh]')?.disabled===false);
  page.setDefaultTimeout(10000);const scan=name=>scanAccessibility(page,role+'-'+lang+'-'+width+'-'+name);
  page.setDefaultTimeout(10000);try{
   await page.addInitScript(t=>sessionStorage.setItem('primecare_session',t),tokens.get(roleActors.get(role)));await page.goto(base+'/platform/administration?enable-semantics=true');await el('platform-language').selectOption(lang);if(role!=='tenant_admin')await el('platform-topbar-tenant').selectOption(tenant);await settle();assert.equal(await page.evaluate(()=>document.documentElement.lang),lang);const shellText=JSON.parse(await readFile('packages/shared/src/media/registry.json','utf8')).locales[lang];assert.equal(await el('sidebar-close').getAttribute('aria-label'),shellText.nav_close);assert.equal(await el('sidebar-toggle').getAttribute('aria-label'),shellText.nav_open);assert.equal(await el('universal-search').getAttribute('placeholder'),shellText.nav_placeholder);await scan('tenants');
   for(const section of ['accounts','masters','audit','operations','territories','bundle']){
    if(width===320){await el('sidebar-toggle').focus();await page.keyboard.press('Enter');assert.equal(await el('sidebar-toggle').getAttribute('aria-expanded'),'true');}
    await el('platform-nav-'+section).focus();await page.keyboard.press('Enter');await settle();
    if(section==='bundle'){
     await el('bundle-launch-state').waitFor();for(const tab of ['launch','documents','support','routing','attention']){await el('bundle-tab-'+tab).focus();await page.keyboard.press('Enter');await page.waitForFunction(()=>document.querySelector('[data-cy=bundle-refresh]')?.disabled===false);assert.equal(await page.evaluate(()=>document.activeElement?.getAttribute('data-cy')),'bundle-tab-'+tab);await scan('bundle-'+tab);}
    }else await scan(section);
   }
   if(width===320){await el('sidebar-toggle').focus();await page.keyboard.press('Enter');await page.keyboard.press('Escape');assert.equal(await el('sidebar-toggle').getAttribute('aria-expanded'),'false');assert.equal(await page.evaluate(()=>document.activeElement?.getAttribute('data-cy')),'sidebar-toggle');}
   await el('universal-search').fill('PrimeCare');if(lang==='en')await scan('search-open');await el('universal-search').press('Escape');assert.equal(await page.evaluate(()=>document.activeElement?.getAttribute('data-cy')),'universal-search');assert.ok(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1));
  }finally{await page.close();}
 });
 for(const lang of ['en','fr','es'])for(const width of [320,1440])await test(`territory label readability: ${lang}, ${width}px`,async()=>{
  const page=await browser.newPage({viewport:{width,height:1000}}),el=id=>page.locator('[data-cy="'+id+'"]');
  try{
   await page.addInitScript(t=>sessionStorage.setItem('primecare_session',t),tokens.get(admin));await page.goto(base+'/platform/administration?enable-semantics=true');await el('platform-language').selectOption(lang);
   if(width===320)await el('sidebar-toggle').click();await el('platform-nav-territories').click();await el('territory-map').waitFor();
   for(const mode of ['overview','zoom','resize']){
    if(mode==='zoom'){await el('territory-picker').selectOption('PC-REG-T0004');await el('territory-zoom').click();}
    if(mode==='resize'){await page.setViewportSize({width:width===320?1440:320,height:1000});await page.evaluate(()=>new Promise(resolve=>requestAnimationFrame(()=>requestAnimationFrame(resolve))));}
    await page.waitForFunction(()=>document.querySelector('[data-cy=territory-map]')?.getAttribute('data-labels-ready')==='true');
    await el('territory-map').scrollIntoViewIfNeeded();
    const labels=await el('territory-map').evaluate(map=>{
     const bounds=map.getBoundingClientRect(),scale=map.getScreenCTM().a;const visible=[...map.querySelectorAll('[data-cy^=territory-city-]')].filter(e=>getComputedStyle(e).visibility!=='hidden');
     const overlaps=(a,b)=>a.left<b.right&&a.right>b.left&&a.top<b.bottom&&a.bottom>b.top;
     return {count:visible.length,valid:visible.every(e=>{const r=e.getBoundingClientRect();return parseFloat(getComputedStyle(e).fontSize)*scale>=11.9&&r.left>=bounds.left&&r.right<=bounds.right&&r.top>=bounds.top&&r.bottom<=bounds.bottom&&![...map.querySelectorAll('[data-cy^=territory-number-]'),...visible.filter(other=>other!==e)].some(other=>overlaps(r,other.getBoundingClientRect()));})};
    });assert.ok(labels.count>0,'Show readable place names');assert.equal(labels.valid,true,'Place names stay legible, inside map, and clear of other labels and territory numbers');
    assert.ok(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1));
    await page.screenshot({path:`test-results/platform-bundle/map-${lang}-${width}-${mode}.png`});await scanAccessibility(page,'territory-map-'+lang+'-'+width+'-'+mode);
   }
   assert.equal(await el('territory-piece-PC-REG-T0001').getAttribute('aria-disabled'),'true');assert.equal(await el('territory-picker').inputValue(),'PC-REG-T0004');
   await el('territory-reference').fill('Synthetic map resize draft');await el('territory-refresh').click();await page.waitForFunction(()=>document.querySelector('[data-cy=territory-map]')?.getAttribute('data-labels-ready')==='true');
   assert.equal(await el('territory-label-metrics').count(),1,'Only the current map measurement probe remains');
  }finally{await page.close();}
 });
 for(const role of ['ceo','owner','tenant_admin','growth_caller','growth_meta'])for(const lang of ['en','fr','es'])for(const width of [320,1440])await test(`growth accessibility: ${role}, ${lang}, ${width}px`,async()=>{
  const page=await browser.newPage({viewport:{width,height:1000}}),el=id=>page.locator('[data-cy="'+id+'"]');
  page.setDefaultTimeout(10000);try{
   await page.addInitScript(t=>sessionStorage.setItem('primecare_session',t),tokens.get(roleActors.get(role)));await page.goto(base+'/growth?enable-semantics=true');await el('screen-founder-growth-dashboard').waitFor();await el('growth-language').selectOption(lang);assert.equal(await page.evaluate(()=>document.documentElement.lang),lang);const shellText=JSON.parse(await readFile('packages/shared/src/media/registry.json','utf8')).locales[lang];assert.equal(await el('sidebar-close').getAttribute('aria-label'),shellText.nav_close);assert.equal(await el('sidebar-toggle').getAttribute('aria-label'),shellText.nav_open);assert.equal(await el('universal-search').getAttribute('placeholder'),shellText.nav_placeholder);
   assert.equal(await el('growth-marketing-model').count(),['ceo','owner','tenant_admin'].includes(role)?1:0);if(['ceo','owner','tenant_admin'].includes(role)){assert.ok((await el('growth-marketing-allocation').innerText()).includes(new Date().toISOString().slice(0,7)));}
   if(['ceo','owner','tenant_admin'].includes(role)){assert.equal(await el('growth-admin-link').count(),role==='ceo'?0:1);assert.equal(await el('growth-plan-form').count(),role==='tenant_admin'?0:1);assert.equal(await el('growth-team-form').count(),1);assert.equal(await el('growth-campaign-budget').getAttribute('readonly')!==null,role==='tenant_admin');const kinds=await el('growth-business-finance-kind').evaluate(e=>[...e.options].map(o=>o.value));assert.deepEqual(kinds,role==='tenant_admin'?['invoice','payment']:['invoice','payment','refund','expense']);}
   if(role==='owner'&&lang==='en'&&width===1440){await el('growth-budget-'+campaign).fill('250');await el('growth-spend-'+campaign).fill('7');await el('growth-language').selectOption('fr');assert.equal(await el('growth-budget-'+campaign).inputValue(),'250');await el('growth-language').selectOption('en');assert.equal(await el('growth-spend-'+campaign).inputValue(),'7');await el('growth-campaign-update-'+campaign).click();await page.waitForFunction(()=>document.querySelector('[data-cy=growth-refresh]')?.disabled===false);const saved=(await db.query('SELECT budget_cents::int AS budget,spend_cents::int AS spend FROM growth_campaigns WHERE id=$1',[campaign])).rows[0];assert.deepEqual(saved,{budget:25000,spend:700});}
   if(role==='owner'){await el('growth-marketing-statement-run').click();await el('growth-marketing-statement-table').waitFor();assert.ok(await el('growth-marketing-statement-table').evaluate(e=>e.scrollWidth<=e.parentElement.clientWidth+1),'Statement amounts fit the viewport');assert.ok((await el('growth-marketing-statement-output').innerText()).includes(tenant));const downloadEvent=page.waitForEvent('download');await el('growth-marketing-statement-pdf').click();const download=await downloadEvent;assert.equal(download.suggestedFilename(),'marketing-statement-'+new Date().toISOString().slice(0,7)+'.pdf');await download.saveAs('test-results/platform-bundle/marketing-statement-'+lang+'-'+width+'.pdf');await page.waitForFunction(()=>document.querySelector('[data-cy=growth-refresh]')?.disabled===false);await el('growth-marketing-statement-output').screenshot({path:'test-results/platform-bundle/marketing-statement-'+lang+'-'+width+'.png'});}
   if(capacityCampaign&&['owner','tenant_admin','growth_meta'].includes(role)){await el('growth-brief-open-'+capacityCampaign).click();assert.equal(await el('growth-capacity-form-'+capacityCampaign).count(),role==='owner'?1:0);if(role==='owner'&&lang==='en'&&width===1440){await el('growth-capacity-slots-'+capacityCampaign).fill('4');await el('growth-capacity-expiry-'+capacityCampaign).fill(new Date(Date.now()+86400000).toISOString().slice(0,16));await el('growth-capacity-evidence-'+capacityCampaign).fill('Synthetic owner browser capacity confirmation');await el('growth-capacity-save-'+capacityCampaign).click();await page.waitForFunction(()=>document.querySelector('[data-cy=growth-refresh]')?.disabled===false);assert.equal((await db.query('SELECT client_slots FROM growth_campaign_capacity WHERE campaign_id=$1 ORDER BY version DESC LIMIT 1',[capacityCampaign])).rows[0].client_slots,4);await el('growth-brief-open-'+capacityCampaign).click();}}
   if(capacityCampaign&&role==='owner')await el('growth-readiness-'+capacityCampaign).screenshot({path:'test-results/platform-bundle/campaign-readiness-'+lang+'-'+width+'.png'});
   await scanAccessibility(page,'growth-'+role+'-'+lang+'-'+width);assert.ok(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1));
   for(const id of await page.locator('[data-cy^=growth-nav-]').evaluateAll(links=>links.map(link=>link.dataset.cy))){
    if(width===320){await el('sidebar-toggle').focus();await page.keyboard.press('Enter');}
    await el(id).focus();await page.keyboard.press('Enter');const section='growth-'+id.slice('growth-nav-'.length);assert.equal(await page.evaluate(()=>document.activeElement?.getAttribute('data-cy')),section);
    assert.ok(await el(section).evaluate(s=>{const bar=document.querySelector('[data-cy=app-topbar]');return s.getBoundingClientRect().top>=(getComputedStyle(bar).position==='sticky'?bar.getBoundingClientRect().bottom:0);}), 'Growth section focus stays below the top bar');
   }
   await el('universal-search').fill('Synthetic');if(lang==='en')await scanAccessibility(page,'growth-search-'+role+'-'+lang+'-'+width);await el('universal-search').press('Escape');assert.equal(await page.evaluate(()=>document.activeElement?.getAttribute('data-cy')),'universal-search');
  }finally{await page.close();}
 });
}finally{if(browser)await browser.close();if(server)await new Promise(r=>server.close(r));await db.query('SET search_path TO public');await db.query(`DROP SCHEMA ${schema} CASCADE`);assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM pg_namespace WHERE nspname=$1',[schema])).rows[0].n,0);await db.end();console.log('Synthetic accessibility schema removed and absence verified.');}
function createHash(token){return require('node:crypto').createHash('sha256').update(token).digest('hex');}
