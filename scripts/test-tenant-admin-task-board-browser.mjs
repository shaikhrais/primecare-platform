import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import {createServer} from 'node:http';
import {mkdtemp,readFile,rm,writeFile} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
import {build} from 'esbuild';
import bcrypt from 'bcryptjs';
import {chromium} from 'playwright';
import pg from 'pg';
import {waitForFixtureStartup} from './fixtures/browser-startup.mjs';

const dbUrl=new URL(process.env.TENANT_TASK_BOARD_TEST_DATABASE_URL??'');
if(!['localhost','127.0.0.1'].includes(dbUrl.hostname)||dbUrl.pathname!=='/tenant_task_board_test'||process.env.PRODUCTION_DATABASE_URL)
 throw Error('Disposable local tenant_task_board_test PostgreSQL only');
const db=new pg.Client({connectionString:dbUrl.href});
const schema='tenant_task_board_'+randomUUID().replaceAll('-','');
const pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8'));
assert.match(pin.schema,/^governance_[a-f0-9]+$/);
assert.equal(pin.tablePrefix,'govt_');
const relation=table=>'"'+pin.schema+'"."'+pin.tablePrefix+table+'"';
const dir=await mkdtemp(join(tmpdir(),'tenant-admin-task-board-'));
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
 for(const migration of ['20260928_auth_rate_limits.sql','20260928_auth_management_audit.sql','20261003_auth_password_resets.sql','20261025_auth_mfa.sql','20261031_tenant_dashboard.sql'])
  await db.query(await readFile('packages/database/migrations/'+migration,'utf8'));
 // The real dashboard worker must pass the pinned-manifest check even in this
 // fixture. Catalog data below is explicitly synthetic test-only work.
 await db.query('CREATE SCHEMA "'+pin.schema+'"');pinOwned=true;
 await db.query('CREATE TABLE '+relation('source_manifest')+'(manifest_sha256 text)');
 await db.query('INSERT INTO '+relation('source_manifest')+' VALUES($1)',[pin.manifestSha256]);
 await db.query('CREATE TABLE '+relation('virtual_workflow_definitions')+'(flow_id text primary key,title text,flow_kind text,actor_roles_json text,definition_status text,verification_status text,test_status text,blocker_json text)');
 await db.query('CREATE TABLE '+relation('virtual_workflow_steps')+'(flow_id text,step_order integer,action_text text,expected_text text,api_method text,api_path text)');
 const tenant=randomUUID(),admin=randomUUID(),worker=randomUUID();
 const email='board-admin@example.test',workerEmail='board-assignee@example.test',password='Synthetic-Task-Board-2026!';
 const flow='fixture.tenant-board.browser',workflowTitle='Synthetic workflow for task board';
 const taskTitle='Synthetic assignment from the workflow browser';
 const hash=await bcrypt.hash(password,12);
 await db.query("INSERT INTO tenants VALUES($1,'Task Board fixture agency','task-board-fixture','active')",[tenant]);
 await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'tenant_admin',$3,$4,'active'),($5,$6,'psw',$3,NULL,'active')",[admin,email,tenant,hash,worker,workerEmail]);
 await db.query('INSERT INTO '+relation('virtual_workflow_definitions')+' VALUES($1,$2,$3,$4,$5,$6,$7,$8)',[flow,workflowTitle,'screen_journey','["tenant_admin"]','source_mapped','implemented-unverified','fixture','[]']);
 await db.query('INSERT INTO '+relation('virtual_workflow_steps')+' VALUES($1,$2,$3,$4,$5,$6)',[flow,1,'Assign practice work','Wait for visible acknowledgement','POST','/v1/governance/tenant-dashboard']);
 dbUrl.searchParams.set('options','-c search_path='+schema);
 const workerEnv={DB_URL:dbUrl.href,MFA_ENCRYPTION_KEY:'a1'.repeat(32)};
 const entries={auth:'cloudflare/workers/src/auth.ts',tenant:'cloudflare/workers/src/tenant-dashboard/service.ts'};
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
  import {installPortalPresentation} from './websites/typescript/src/screen-presentation';
  import {resolveManagedRoute} from './websites/typescript/src/managed-routes';
  import theme from './packages/shared/src/solid-theme.json';
  const root=document.getElementById('app'), gateway=location.origin, path=location.pathname;
  const manager=installPortalPresentation(root,theme,gateway);
  const entry=resolveManagedRoute(path,'ci');
  manager.registerScope('entry',[entry]);
  void manager.present(entry.id,entry.route,()=>path==='/login'?renderAuth(root,gateway,'PrimeCare','en'):
   renderTenantDashboard(root,gateway));
 `},bundle:true,platform:'browser',write:false});
 const css=await readFile('websites/typescript/src/styles.css');
 server=createServer(async(req,res)=>{
  try{
   const url=new URL(req.url,'http://127.0.0.1');
   if(url.pathname==='/app.js'){res.writeHead(200,{'content-type':'text/javascript'});res.end(bundle.outputFiles[0].text);return;}
   if(url.pathname==='/app.css'){res.writeHead(200,{'content-type':'text/css'});res.end(css);return;}
   if(!url.pathname.startsWith('/v1/')){
    if(!['/login','/tenant-dashboard'].includes(url.pathname)){res.writeHead(404);res.end();return;}
    res.writeHead(200,{'content-type':'text/html'});res.end('<!doctype html><html lang="en"><meta name="viewport" content="width=device-width,initial-scale=1"><link rel="stylesheet" href="/app.css"><div id="app"></div><script src="/app.js"></script></html>');return;
   }
   const headers=new Headers(req.headers),chunks=[];
   for await(const chunk of req)chunks.push(chunk);
   const body=Buffer.concat(chunks),request=new Request(url,{method:req.method,headers,...(body.length?{body}:{})});
   const path=url.pathname,type=path==='/v1/governance/tenant-dashboard'?'tenant':'auth';
   const handlerPath=path.replace(/^\/v1\/(governance|auth)/,'');
   const result=await handlers[type](request,{...workerEnv,SERVICE_NAME:type==='auth'?'auth':'governance'},handlerPath,{});
   if(!result){res.writeHead(404);res.end();return;}
   res.writeHead(result.status,Object.fromEntries(result.headers));res.end(Buffer.from(await result.arrayBuffer()));
  }catch{res.writeHead(500);res.end('Fixture handler failed');}
 });
 await new Promise((resolve,reject)=>{server.once('error',reject);server.listen(0,'127.0.0.1',resolve);});
 const origin='http://127.0.0.1:'+server.address().port;
 browser=await chromium.launch();
 const context=await browser.newContext({viewport:{width:1440,height:1000}});
 const page=await context.newPage(),cy=id=>page.locator('[data-cy="'+id+'"]');
 await page.route('**/*',route=>new URL(route.request().url()).origin===origin?route.continue():route.abort());
 const match=(path,method)=>r=>new URL(r.url()).pathname===path&&r.request().method()===method;
 const boardApi='/v1/governance/tenant-dashboard';
 await page.goto(origin+'/login?enable-semantics=true');
 await cy('login-email').fill(email);await cy('login-password').fill(password);
 const [login]=await Promise.all([
  page.waitForResponse(match('/v1/auth/login','POST')),
  waitForFixtureStartup(page,()=>cy('login-submit').click(),{selector:'[data-cy=screen-tenant-admin-dashboard]',timeoutMs:30000}),
 ]);
 assert.equal(login.status(),200);
 assert.equal(new URL(page.url()).pathname,'/tenant-dashboard');
 async function go(tab){
  const nav=cy('tenant-nav-'+tab);
  if(!await nav.isVisible())await cy('sidebar-toggle').click();
  await nav.click();
  assert.equal(new URL(page.url()).hash,'#'+tab);
 }
 await go('tasks');
 const table=cy('tenant-task-table');
 await table.getByText(/No work has been assigned yet[.] Open Workflow library/).waitFor();
 assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM tenant_work_tasks')).rows[0].n,0);

 await go('workflows');
 const entry=cy('tenant-workflow-'+flow);
 const summary=entry.locator('summary');
 await summary.waitFor();
 assert.ok((await summary.textContent()).includes(workflowTitle));
 await summary.click();
 await cy('tenant-workflow-task-'+flow).click();
 assert.equal(await cy('tenant-task-workflow').inputValue(),flow);
 await cy('tenant-task-title').fill(taskTitle);
 await cy('tenant-task-owner').selectOption(worker);
 const [saved]=await Promise.all([
  page.waitForResponse(match(boardApi,'POST')),
  cy('tenant-task-save').click(),
 ]);
 assert.equal(saved.status(),200);
 const saveReceipt=await saved.json();
 assert.equal(saveReceipt.organization.id,tenant);
 const model=saveReceipt.tasks.find(task=>task.title===taskTitle);
 assert.ok(model?.id);
 await cy('tenant-task-form').waitFor({state:'detached'});
 await cy('tenant-status').filter({hasText:'Saved to PostgreSQL.'}).waitFor();

 await go('tasks');
 const row=table.getByRole('row').filter({hasText:taskTitle});
 await row.getByText(workerEmail,{exact:false}).waitFor();
 const persisted=(await db.query('SELECT tenant_id,owner_id,flow_id,status,created_by FROM tenant_work_tasks WHERE id=$1',[model.id])).rows;
 assert.deepEqual(persisted,[{tenant_id:tenant,owner_id:worker,flow_id:flow,status:'open',created_by:admin}]);
 const [filtered]=await Promise.all([
  page.waitForResponse(r=>match(boardApi,'GET')(r)&&new URL(r.url()).searchParams.get('status')==='completed'),
  cy('tenant-task-filter').selectOption('completed'),
 ]);
 assert.equal(filtered.status(),200);
 assert.equal((await filtered.json()).taskPage.total,0);
 await table.getByText(/No assigned tasks match these filters[.]/).waitFor();
 assert.equal(await row.count(),0);
 assert.equal(await table.getByText(/No work has been assigned yet/).count(),0);

 const [reloaded]=await Promise.all([
  page.waitForResponse(r=>match(boardApi,'GET')(r)&&new URL(r.url()).searchParams.get('status')==='all'),
  waitForFixtureStartup(page,()=>page.reload(),{selector:'[data-cy=tenant-task-table]',timeoutMs:30000}),
 ]);
 assert.equal(reloaded.status(),200);
 assert.equal((await reloaded.json()).taskPage.total,1);
 assert.equal(new URL(page.url()).hash,'#tasks');
 await row.getByText(workerEmail,{exact:false}).waitFor();
 console.log('TENANT_ADMIN_TASK_BOARD_BROWSER_SCOPED_PASS true-empty / registered workflow assignment / filtered no-match / reload / native readback');

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
