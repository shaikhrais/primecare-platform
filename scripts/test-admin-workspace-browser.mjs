// Full inherited UI -> Gateway -> Auth Worker -> disposable PostgreSQL workflow.
import {Client} from 'pg';
import bcrypt from 'bcryptjs';
import {build} from 'esbuild';
import {chromium} from 'playwright';
import {runAdminBrowserScenario} from './admin-browser-scenario.mjs';
import {createServer} from 'node:https';
import {readFile,mkdtemp} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join,resolve,extname} from 'node:path';
import {createRequire} from 'node:module';
import {randomUUID,createHash} from 'node:crypto';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');
if(!['localhost','127.0.0.1'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Disposable loopback auth_test only');
const dir=await mkdtemp(join(tmpdir(),'admin-browser-'));
for(const name of ['auth','gateway'])await build({entryPoints:[`cloudflare/workers/src/${name}.ts`],bundle:true,platform:'node',format:'cjs',outfile:join(dir,name+'.cjs')});
const require=createRequire(import.meta.url),{auth}=require(join(dir,'auth.cjs')),gateway=require(join(dir,'gateway.cjs')).default;
const env={AUTH:{fetch:r=>auth(r,{SERVICE_NAME:'auth',DB_URL:url.href},new URL(r.url).pathname,{})}};
const web=resolve('apps/primecare_support/build/web');
const db=new Client({connectionString:url.href});await db.connect();
const tenant=randomUUID(),admin=randomUUID(),email=`browser-admin-${admin}@example.invalid`,password='disposable-admin-password-123';
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
 // Each language is an independent scenario in this disposable database.
 // Reset only the owned actor counters; production rate policy remains enforced.
 await db.query('DELETE FROM auth_rate_limits WHERE subject_hash=ANY($1::text[])', [['manageAccount','createAccount'].map(operation=>createHash('sha256').update(operation+':'+admin).digest('hex'))]);
 const strings=catalogs[language];
 await runAdminBrowserScenario({browser,db,language,strings,email,password,tenant,admin,organization:'Browser QA organization',uiUrl:'https://127.0.0.1:8443/',api:(path,options={})=>gateway.fetch(new Request('https://fixture/v1/auth'+path,options),env),accountsBefore:['en','es','fr'].indexOf(language)+1,auditBefore:4*['en','es','fr'].indexOf(language),ignoreHTTPSErrors:true,onPhase:value=>phase=value});
 }
}catch(error){console.error('Admin browser E2E failed during '+phase);if(browser){const page=browser.contexts().flatMap(c=>c.pages())[0];if(page){await page.screenshot({path:'admin-rebuild-failure.png'});console.error((await page.locator('flt-semantics').allTextContents()).slice(-30));console.error(await page.locator('[role],[aria-label]').evaluateAll(nodes=>nodes.map(n=>({role:n.getAttribute('role'),label:n.getAttribute('aria-label')})).slice(-35)));}}throw error;}
finally {
 if(browser)await browser.close();await new Promise(resolve=>server.close(resolve));
 await db.query('DELETE FROM auth_management_audit WHERE tenant_id=$1',[tenant]);await db.query('DELETE FROM auth_account_audit WHERE tenant_id=$1',[tenant]);
 await db.query('DELETE FROM auth_sessions WHERE user_id IN (SELECT id FROM users WHERE tenant_id=$1)',[tenant]);await db.query('DELETE FROM users WHERE tenant_id=$1',[tenant]);await db.query('DELETE FROM tenants WHERE id=$1',[tenant]);await db.end();
}
