// Full inherited UI -> Gateway -> Auth Worker -> disposable PostgreSQL workflow.
import {Client} from 'pg';
import bcrypt from 'bcryptjs';
import {build} from 'esbuild';
import {chromium} from 'playwright';
import {fillFlutterField} from './flutter-browser-input.mjs';
import {createServer} from 'node:https';
import {readFile,mkdtemp} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join,resolve,extname} from 'node:path';
import {createRequire} from 'node:module';
import {randomUUID} from 'node:crypto';
import assert from 'node:assert/strict';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');
if(!['localhost','127.0.0.1'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Disposable loopback auth_test only');
const dir=await mkdtemp(join(tmpdir(),'admin-browser-'));
for(const name of ['auth','gateway'])await build({entryPoints:[`cloudflare/workers/src/${name}.ts`],bundle:true,platform:'node',format:'cjs',outfile:join(dir,name+'.cjs')});
const require=createRequire(import.meta.url),{auth}=require(join(dir,'auth.cjs')),gateway=require(join(dir,'gateway.cjs')).default;
const env={AUTH:{fetch:r=>auth(r,{SERVICE_NAME:'auth',DB_URL:url.href},new URL(r.url).pathname,{})}};
const web=resolve('apps/primecare_support/build/web');
const db=new Client({connectionString:url.href});await db.connect();
const tenant=randomUUID(),admin=randomUUID(),email=`browser-admin-${admin}@example.invalid`,password='disposable-admin-password-123';
let userEmail=`browser-user-${randomUUID()}@example.invalid`;let updatedEmail=`updated-${randomUUID()}@example.invalid`;
const server=createServer({key:await readFile(process.env.ADMIN_TEST_TLS_KEY),cert:await readFile(process.env.ADMIN_TEST_TLS_CERT)},async(req,res)=>{
 try {
  const target=new URL(req.url,'https://127.0.0.1:8443');
  if(target.pathname.startsWith('/v1/')){
   const chunks=[];for await(const chunk of req)chunks.push(chunk);
   const response=await gateway.fetch(new Request(target,{method:req.method,headers:req.headers,...(['GET','HEAD'].includes(req.method)?{}:{body:Buffer.concat(chunks)})}),env);
   res.writeHead(response.status,Object.fromEntries(response.headers));res.end(Buffer.from(await response.arrayBuffer()));return;
  }
  const file=resolve(web,'.'+(target.pathname==='/'?'/index.html':decodeURIComponent(target.pathname)));
  if(!file.startsWith(web+'/')){res.writeHead(403);res.end();return;}
  const types={'.html':'text/html','.js':'text/javascript','.json':'application/json','.wasm':'application/wasm','.css':'text/css','.png':'image/png','.woff2':'font/woff2'};
  res.writeHead(200,{'content-type':types[extname(file)]||'application/octet-stream'});res.end(await readFile(file));
 }catch{if(!res.headersSent)res.writeHead(500);res.end();}
});
let browser;let phase='setup';
try {
 await db.query("INSERT INTO tenants(id,name,status) VALUES($1,'Browser QA organization','active')",[tenant]);
 await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'admin',$3,$4,'active')",[admin,email,tenant,await bcrypt.hash(password,12)]);
 await new Promise(resolve=>server.listen(8443,'127.0.0.1',resolve));
 browser=await chromium.launch({headless:true});
 const catalogs=JSON.parse(await readFile('packages/contracts/locales/admin.json','utf8'));
 for(const language of ['en','es','fr']) {
 const strings=catalogs[language];
 userEmail=`browser-user-${randomUUID()}@example.invalid`;updatedEmail=`updated-${randomUUID()}@example.invalid`;
 const page=await browser.newPage({ignoreHTTPSErrors:true,viewport:{width:1280,height:1000}});
 page.setDefaultTimeout(20000);
 phase='login';await page.goto('https://127.0.0.1:8443/',{waitUntil:'networkidle'});
 const placeholder=page.locator('flt-semantics-placeholder');if(await placeholder.count())await placeholder.evaluate(e=>e.click());
 if(language!=='en') { await page.getByRole('button',{name:'Language',exact:true}).click();await page.getByLabel(language==='es'?'Español':'Français',{exact:true}).click(); }
 await fillFlutterField(page,strings['auth.email'],email);await fillFlutterField(page,strings['auth.password'],password,true);
 await page.getByRole('button',{name:strings['auth.signIn'],exact:true}).click();
 await page.getByRole('button',{name:strings['admin.open'],exact:true}).click();
 await page.getByText('Browser QA organization',{exact:true}).waitFor();
 phase='task overview';await page.getByRole('button',{name:strings['admin.tasks'],exact:true}).click();
 await page.getByText(strings['admin.tasksIntro'],{exact:true}).waitFor();await page.getByText(strings['task.create.title'],{exact:true}).waitFor();await page.getByText(strings['task.create.description'],{exact:true}).waitFor();
 await page.getByRole('button',{name:strings['back'],exact:true}).click();
 phase='create user';await page.getByRole('button',{name:strings['admin.create'],exact:true}).click();
 await fillFlutterField(page,strings['admin.email'],userEmail);await fillFlutterField(page,strings['admin.password'],'initial-password-1234',true);
 const creation=page.waitForResponse(r=>r.url().endsWith('/admin/workspace/users')&&r.request().method()==='POST');
 await page.getByRole('button',{name:strings['admin.save'],exact:true}).click();assert.equal((await creation).status(),201);
 await page.getByText(userEmail,{exact:true}).waitFor();
 const user=(await db.query('SELECT id,roles FROM users WHERE email=$1 AND tenant_id=$2',[userEmail,tenant])).rows[0];assert.equal(user.roles,'client');
 const login=await gateway.fetch(new Request('https://fixture/v1/auth/login',{method:'POST',headers:{'content-type':'application/json'},body:JSON.stringify({email:userEmail,password:'initial-password-1234'})}),env);assert.equal(login.status,200);const userToken=(await login.json()).token;
 phase='edit role and deactivate';await page.getByRole('button',{name:strings['admin.editAccount'].replace('{email}',userEmail),exact:true}).click();
 await fillFlutterField(page,strings['admin.email'],updatedEmail);
 await page.getByText(strings['admin.role']+' '+strings['role.client'],{exact:true}).click();await page.getByLabel(strings['role.rmt'],{exact:true}).click();
 await page.getByText(strings['admin.status']+' '+strings['active'],{exact:true}).click();await page.getByLabel(strings['inactive'],{exact:true}).click();
 const mutation=page.waitForResponse(r=>r.url().endsWith('/admin/workspace/users/'+user.id)&&r.request().method()==='PUT');
 await page.getByRole('button',{name:strings['admin.save'],exact:true}).click();assert.equal((await mutation).status(),200);
 await page.getByText(updatedEmail,{exact:true}).waitFor();
 const persisted=(await db.query('SELECT email,roles,status FROM users WHERE id=$1',[user.id])).rows[0];assert.deepEqual(persisted,{email:updatedEmail,roles:'rmt',status:'inactive'});
 const me=await gateway.fetch(new Request('https://fixture/v1/auth/me',{headers:{authorization:'Bearer '+userToken}}),env);assert.equal(me.status,401);
 phase='reactivate account';await page.getByRole('button',{name:strings['admin.editAccount'].replace('{email}',updatedEmail),exact:true}).click();
 await page.getByText(strings['admin.status']+' '+strings['inactive'],{exact:true}).click();await page.getByLabel(strings['active'],{exact:true}).click();
 const reactivation=page.waitForResponse(r=>r.url().endsWith('/admin/workspace/users/'+user.id)&&r.request().method()==='PUT');
 await page.getByRole('button',{name:strings['admin.save'],exact:true}).click();assert.equal((await reactivation).status(),200);await page.getByText(updatedEmail,{exact:true}).waitFor();
 const resumed=await gateway.fetch(new Request('https://fixture/v1/auth/login',{method:'POST',headers:{'content-type':'application/json'},body:JSON.stringify({email:updatedEmail,password:'initial-password-1234'})}),env);assert.equal(resumed.status,200);const resumedToken=(await resumed.json()).token;
 phase='deactivate reactivated account';await page.getByRole('button',{name:strings['admin.editAccount'].replace('{email}',updatedEmail),exact:true}).click();
 await page.getByText(strings['admin.status']+' '+strings['active'],{exact:true}).click();await page.getByLabel(strings['inactive'],{exact:true}).click();
 const finalDeactivation=page.waitForResponse(r=>r.url().endsWith('/admin/workspace/users/'+user.id)&&r.request().method()==='PUT');
 await page.getByRole('button',{name:strings['admin.save'],exact:true}).click();assert.equal((await finalDeactivation).status(),200);await page.getByText(updatedEmail,{exact:true}).waitFor();
 assert.equal((await gateway.fetch(new Request('https://fixture/v1/auth/me',{headers:{authorization:'Bearer '+resumedToken}}),env)).status,401);
 phase='reload';await page.getByRole('button',{name:strings['admin.refresh'],exact:true}).click();await page.getByText(updatedEmail,{exact:true}).waitFor();
 phase='search account';await fillFlutterField(page,strings['admin.searchLabel'],updatedEmail.toUpperCase());
 await page.getByRole('button',{name:strings['admin.searchApply'],exact:true}).click();await page.getByText(strings['admin.matchingCounts'].replace('{total}','1').replace('{active}','0'),{exact:true}).waitFor();
 await page.getByText(updatedEmail,{exact:true}).waitFor();
 phase='filtered audit';const filteredResponse=page.waitForResponse(r=>r.request().method()==='GET'&&new URL(r.url()).pathname.endsWith('/admin/workspace/audit')&&new URL(r.url()).searchParams.get('userId')===user.id);await page.getByRole('button',{name:strings['audit.viewAccount'].replace('{email}',updatedEmail),exact:true}).click();
 await page.getByText(strings['audit.accountHistory'].replace('{email}',updatedEmail),{exact:true}).waitFor();await page.getByText(strings['audit.count'].replace('{total}','4'),{exact:true}).waitFor();
 const filteredData=await (await filteredResponse).json();assert.equal(filteredData.total,4);assert(filteredData.events.every(event=>event.target===user.id));
 await page.getByText(strings['audit.target'].replace('{id}',user.id),{exact:true}).first().waitFor();
 await page.getByRole('button',{name:strings['audit.clearFilter'],exact:true}).click();await page.getByText(strings['audit.count'].replace('{total}',String(4*(['en','es','fr'].indexOf(language)+1))),{exact:true}).waitFor();
 await page.getByRole('button',{name:strings['back'],exact:true}).click();
 await page.getByRole('button',{name:strings['admin.searchClear'],exact:true}).click();
 await page.getByText(strings['admin.counts'].replace('{total}',String(['en','es','fr'].indexOf(language)+2)).replace('{active}','1'),{exact:true}).waitFor();
 phase='audit history';await page.getByRole('button',{name:strings['audit.title'],exact:true}).click();await page.getByText(strings['audit.account_created'],{exact:true}).first().waitFor();await page.getByText(strings['audit.account_updated'],{exact:true}).first().waitFor();await page.getByRole('button',{name:strings['back'],exact:true}).click();
 phase='logout';await page.getByRole('button',{name:strings['back'],exact:true}).click();await page.getByRole('button',{name:strings['auth.signOut'],exact:true}).click();await page.getByRole('button',{name:strings['auth.signIn'],exact:true}).waitFor();
 assert.equal((await db.query('SELECT count(*)::int AS n FROM auth_sessions WHERE user_id=$1',[admin])).rows[0].n,0);
 await page.close();console.log('PASS '+language+': Admin browser E2E login, inherited workspace, create, edit email/role, deactivate/reactivate, persistence, task overview, search, filtered audit, session revocation and logout');
 }
}catch(error){console.error('Admin browser E2E failed during '+phase);if(browser){const page=browser.contexts().flatMap(c=>c.pages())[0];if(page){await page.screenshot({path:'admin-rebuild-failure.png'});console.error((await page.locator('flt-semantics').allTextContents()).slice(-30));console.error(await page.locator('[role],[aria-label]').evaluateAll(nodes=>nodes.map(n=>({role:n.getAttribute('role'),label:n.getAttribute('aria-label')})).slice(-35)));}}throw error;}
finally {
 if(browser)await browser.close();await new Promise(resolve=>server.close(resolve));
 await db.query('DELETE FROM auth_management_audit WHERE tenant_id=$1',[tenant]);await db.query('DELETE FROM auth_account_audit WHERE tenant_id=$1',[tenant]);
 await db.query('DELETE FROM auth_sessions WHERE user_id IN (SELECT id FROM users WHERE tenant_id=$1)',[tenant]);await db.query('DELETE FROM users WHERE tenant_id=$1',[tenant]);await db.query('DELETE FROM tenants WHERE id=$1',[tenant]);await db.end();
}
