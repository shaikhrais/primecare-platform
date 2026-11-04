/** Actual tenant page and preference gateway, each using an isolated PostgreSQL database. */
import assert from 'node:assert/strict';
import {createHash} from 'node:crypto';
import {createServer} from 'node:http';
import {readFile} from 'node:fs/promises';
import {build} from 'esbuild';
import {chromium} from 'playwright';
import pg from 'pg';
import {tenantFixture} from './tenant-dashboard-fixture.mjs';
import {preferenceFixture} from './preference-sync-fixture.mjs';

const url=new URL(process.env.PSW_TEST_DATABASE_URL);
if(url.hostname!=='127.0.0.1'||url.pathname!=='/psw_test'||process.env.PRODUCTION_DATABASE_URL)throw Error('Isolated PostgreSQL required');
const admin=new pg.Client({connectionString:url.href});await admin.connect();
let tenant,preference,browser,server,created=false;
try{
 await admin.query('CREATE DATABASE preference_test');created=true;
 const preferenceUrl=new URL(url.href);preferenceUrl.pathname='/preference_test';
 process.env.PREFERENCE_TEST_DATABASE_URL=preferenceUrl.href;
 tenant=await tenantFixture();preference=await preferenceFixture();
 const actor=tenant.actors.admin;
 await preference.db.query("INSERT INTO tenants VALUES($1,'active')",[actor.tenant]);
 await preference.db.query("INSERT INTO users VALUES($1,$2,'tenant_admin','active')",[actor.id,actor.tenant]);
 await preference.db.query("INSERT INTO auth_sessions VALUES($1,$2,NOW()+interval '1 hour')",[createHash('sha256').update(actor.token).digest('hex'),actor.id]);
 await preference.db.query('INSERT INTO '+preference.table('api_permissions')+" VALUES(80124,777,72,1,'authenticated_self_preferences')");
 const bundle=await build({stdin:{contents:"import {renderTenantDashboard} from './websites/typescript/src/tenant-dashboard';window.render=()=>renderTenantDashboard(document.querySelector('#app'),location.origin);",resolveDir:process.cwd()},bundle:true,write:false,format:'iife'});
 server=createServer(async(req,res)=>{
  try{
   if(req.url==='/app.js'){res.setHeader('content-type','text/javascript');return res.end(bundle.outputFiles[0].text);}
   if(req.url==='/style.css'){res.setHeader('content-type','text/css');return res.end(await readFile('websites/typescript/src/styles.css'));}
   if(req.url.startsWith('/v1/')){
    const chunks=[];for await(const chunk of req)chunks.push(chunk);
    const headers=new Headers(req.headers),body=Buffer.concat(chunks);
    let response;
    if(req.url==='/v1/user/preferences')response=await preference.fetch(new Request('http://127.0.0.1'+req.url,{method:req.method,headers,body}));
    else response=await tenant.tenantDashboard(new Request('https://fixture'+req.url,{method:req.method,headers,...(body.length?{body}:{})}),tenant.env,'/tenant-dashboard',{});
    res.writeHead(response.status,Object.fromEntries(response.headers));return res.end(Buffer.from(await response.arrayBuffer()));
   }
   res.setHeader('content-type','text/html');res.end('<!doctype html><html><head><link rel="stylesheet" href="/style.css"></head><body><div id="app"></div><script src="/app.js"></script><script>window.render()</script></body></html>');
  }catch{res.writeHead(500);res.end();}
 });
 await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
 browser=await chromium.launch({headless:true,args:['--no-sandbox']});
 const context=await browser.newContext({viewport:{width:1440,height:960}});
 const scope={tenantId:actor.tenant,userId:actor.id,role:'tenant_admin',dataset:'live'};
 const key='primecare-themes:v1:'+encodeURIComponent(JSON.stringify(['tenant-dashboard','live',actor.tenant,actor.id,'tenant_admin']));
 const source=JSON.stringify({version:1,active:null,items:[]});
 await context.addInitScript(({token,key,source})=>{sessionStorage.setItem('primecare_session',token);if(localStorage.getItem(key)===null)localStorage.setItem(key,source);},{token:actor.token,key,source});
 const page=await context.newPage(),errors=[];page.on('pageerror',error=>errors.push(error.message));
 await page.goto('http://127.0.0.1:'+server.address().port+'/tenant-dashboard');
 await page.locator('[data-cy=appearance-open]').click();
 await page.locator('[data-cy=theme-migration-review]').click();
 assert.equal(await page.locator('[data-cy=theme-migration-status]').textContent(),'Review ready');
 assert.equal(Number((await preference.db.query('SELECT count(*) n FROM account_preference_documents')).rows[0].n),0);
 await page.locator('[data-cy=theme-migration-save]').click();
 await page.waitForFunction(()=>document.querySelector('[data-cy=theme-migration-status]')?.textContent==='Saved');
 const row=(await preference.db.query('SELECT tenant_id,user_id,revision,document FROM account_preference_documents')).rows[0];
 assert.equal(row.tenant_id,actor.tenant);assert.equal(row.user_id,actor.id);assert.equal(Number(row.revision),1);
 assert.deepEqual(row.document,{version:2,active:null,items:[]});
 assert.equal(await page.evaluate(key=>localStorage.getItem(key),key),source);
 await page.reload();
 await page.locator('[data-cy=appearance-open]').click();
 await page.locator('[data-cy=theme-migration-review]').waitFor();
 const denied=await preference.fetch(new Request('https://fixture.test/v1/user/preferences',{method:'POST',headers:{authorization:'Bearer '+preference.tokens.user2,'content-type':'application/json'},body:JSON.stringify({version:1,action:'read',expectedScope:scope,dataset:'live',kind:'theme',resource:'advanced-v2'})}));
 assert.equal(denied.status,409);
 assert.equal(Number((await preference.db.query('SELECT count(*) n FROM account_preference_audit WHERE user_id=$1',[actor.id])).rows[0].n),1);
 assert.deepEqual(errors,[]);
 console.log('Actual Tenant Admin page, preference gateway, PostgreSQL, audit, isolation and reload passed.');
}finally{
 await browser?.close();if(server?.listening)await new Promise(resolve=>server.close(resolve));
 await preference?.close();await tenant?.close();
 if(created)await admin.query('DROP DATABASE preference_test');
 await admin.end();
}
