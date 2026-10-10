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
const userEmail=`browser-user-${randomUUID()}@example.invalid`,updatedEmail=`updated-${randomUUID()}@example.invalid`;
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
 browser=await chromium.launch({headless:true});const page=await browser.newPage({ignoreHTTPSErrors:true,viewport:{width:1280,height:1000}});
 page.setDefaultTimeout(20000);
 phase='login';await page.goto('https://127.0.0.1:8443/',{waitUntil:'networkidle'});
 const placeholder=page.locator('flt-semantics-placeholder');if(await placeholder.count())await placeholder.evaluate(e=>e.click());
 await fillFlutterField(page,'Email',email);await fillFlutterField(page,'Password',password,true);
 await page.getByRole('button',{name:'Sign in',exact:true}).click();
 await page.getByRole('button',{name:'Open admin workspace',exact:true}).click();
 await page.getByText('Browser QA organization',{exact:true}).waitFor();
 phase='create user';await page.getByRole('button',{name:'Create user',exact:true}).click();
 await fillFlutterField(page,'User email',userEmail);await fillFlutterField(page,'Initial password','initial-password-1234',true);
 const creation=page.waitForResponse(r=>r.url().endsWith('/admin/workspace/users')&&r.request().method()==='POST');
 await page.getByRole('button',{name:'Save user',exact:true}).click();assert.equal((await creation).status(),201);
 await page.getByText(userEmail,{exact:true}).waitFor();
 const user=(await db.query('SELECT id,roles FROM users WHERE email=$1 AND tenant_id=$2',[userEmail,tenant])).rows[0];assert.equal(user.roles,'client');
 const login=await gateway.fetch(new Request('https://fixture/v1/auth/login',{method:'POST',headers:{'content-type':'application/json'},body:JSON.stringify({email:userEmail,password:'initial-password-1234'})}),env);assert.equal(login.status,200);const userToken=(await login.json()).token;
 phase='edit role and deactivate';await page.getByRole('button',{name:'Edit '+userEmail,exact:true}).click();
 await fillFlutterField(page,'User email',updatedEmail);
 await page.getByText('client',{exact:true}).click();await page.getByText('rmt',{exact:true}).click();
 await page.getByText('active',{exact:true}).click();await page.getByText('inactive',{exact:true}).click();
 const mutation=page.waitForResponse(r=>r.url().endsWith('/admin/workspace/users/'+user.id)&&r.request().method()==='PUT');
 await page.getByRole('button',{name:'Save user',exact:true}).click();assert.equal((await mutation).status(),200);
 await page.getByText(updatedEmail,{exact:true}).waitFor();
 const persisted=(await db.query('SELECT email,roles,status FROM users WHERE id=$1',[user.id])).rows[0];assert.deepEqual(persisted,{email:updatedEmail,roles:'rmt',status:'inactive'});
 const me=await gateway.fetch(new Request('https://fixture/v1/auth/me',{headers:{authorization:'Bearer '+userToken}}),env);assert.equal(me.status,401);
 phase='reload';await page.getByRole('button',{name:'Refresh users',exact:true}).click();await page.getByText(updatedEmail,{exact:true}).waitFor();
 phase='logout';await page.getByRole('button',{name:'Back',exact:true}).click();await page.getByRole('button',{name:'Sign out',exact:true}).click();await page.getByRole('button',{name:'Sign in',exact:true}).waitFor();
 assert.equal((await db.query('SELECT count(*)::int AS n FROM auth_sessions WHERE user_id=$1',[admin])).rows[0].n,0);
 console.log('PASS: Admin browser E2E login, inherited workspace, create, edit email/role, deactivate, persistence, session revocation and logout');
}catch(error){console.error('Admin browser E2E failed during '+phase);if(browser){const page=browser.contexts().flatMap(c=>c.pages())[0];if(page){await page.screenshot({path:'admin-rebuild-failure.png'});console.error((await page.locator('flt-semantics').allTextContents()).slice(-30));}}throw error;}
finally {
 if(browser)await browser.close();await new Promise(resolve=>server.close(resolve));
 await db.query('DELETE FROM auth_management_audit WHERE tenant_id=$1',[tenant]);await db.query('DELETE FROM auth_account_audit WHERE tenant_id=$1',[tenant]);
 await db.query('DELETE FROM auth_sessions WHERE user_id IN (SELECT id FROM users WHERE tenant_id=$1)',[tenant]);await db.query('DELETE FROM users WHERE tenant_id=$1',[tenant]);await db.query('DELETE FROM tenants WHERE id=$1',[tenant]);await db.end();
}
