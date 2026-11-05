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
 const theme={version:1,name:'Tenant fixture theme',preset:'default',fontFamily:'serif',fontScale:1.125,radius:8,colors:{primary:'#125e70',sidebar:'#14283f',topbar:'#ffffff',muted:'#607184'}};
 const source=JSON.stringify({version:1,active:theme,items:[{id:'00000000-0000-4000-8000-000000000001',theme}]});
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
 assert.equal(row.document.version,2);
 assert.equal(row.document.items.length,1);
 assert.equal(row.document.active.name,theme.name);
 assert.equal(row.document.active.regions.main.primary,theme.colors.primary);
 assert.equal(row.document.active.regions.navigation.background,theme.colors.sidebar);
 assert.equal(row.document.active.tokens.fontFamily,theme.fontFamily);
 assert.equal(await page.evaluate(key=>localStorage.getItem(key),key),source);
 // A separate browser with no local library can review and restore the account theme.
 const fresh=await browser.newContext({viewport:{width:1440,height:960}});
 await fresh.addInitScript(token=>sessionStorage.setItem('primecare_session',token),actor.token);
 const freshPage=await fresh.newPage();freshPage.on('pageerror',error=>errors.push(error.message));
 await freshPage.goto('http://127.0.0.1:'+server.address().port+'/tenant-dashboard?enable-semantics=true');
 await freshPage.locator('[data-cy=appearance-open]').click();
 await freshPage.locator('[data-cy=theme-restore-review]').click();
 assert.equal(await freshPage.locator('[data-cy=theme-restore-status]').textContent(),'Review ready');
 assert.match(await freshPage.locator('[data-cy=theme-restore-preview]').textContent(),/layout/);
 const restoreLockTab=await fresh.newPage();restoreLockTab.on('pageerror',error=>errors.push(error.message));
 await restoreLockTab.goto('http://127.0.0.1:'+server.address().port+'/tenant-dashboard?enable-semantics=true');
 await restoreLockTab.evaluate(async key=>{await new Promise(resolve=>{navigator.locks.request('primecare-theme-library:'+key,{mode:'exclusive'},()=>new Promise(release=>{window.releaseRestoreLock=release;resolve();}));});},key);
 await freshPage.locator('[data-cy=theme-restore-confirm]').click();
 await freshPage.waitForFunction(async key=>(await navigator.locks.query()).pending.some(lock=>lock.name==='primecare-theme-library:'+key),key);
 assert.equal(await freshPage.evaluate(key=>Object.keys(localStorage).filter(k=>k.startsWith('primecare-theme-restored:v1:'+key.slice('primecare-themes:v1:'.length)+':')).length,key),0);
 await Promise.all([freshPage.waitForEvent('load'),restoreLockTab.evaluate(()=>window.releaseRestoreLock())]);
 await freshPage.waitForFunction(key=>Object.keys(localStorage).some(k=>k.startsWith('primecare-theme-restored:v1:'+key.slice('primecare-themes:v1:'.length)+':')),key);
 await freshPage.locator('[data-cy=appearance-open]').click();
 assert.equal(await freshPage.locator('[data-cy=theme-center-name]').inputValue(),theme.name);
 assert.equal(await freshPage.evaluate(()=>document.documentElement.style.getPropertyValue('--color-primary')),theme.colors.primary);
 assert.equal(await freshPage.evaluate(key=>localStorage.getItem(key),key),null);
 const savedCopy=await freshPage.evaluate(key=>localStorage.getItem(Object.keys(localStorage).find(k=>k.startsWith('primecare-theme-restored:v1:'+key.slice('primecare-themes:v1:'.length)+':'))),key);
 assert.equal(JSON.parse(savedCopy).items[0].id,'00000000-0000-4000-8000-000000000001');
 await fresh.close();
 // An unsaved local edit blocks restoration and remains visible.
 const draft=await browser.newContext({viewport:{width:1440,height:960}});
 await draft.addInitScript(token=>sessionStorage.setItem('primecare_session',token),actor.token);
 const draftPage=await draft.newPage();draftPage.on('pageerror',error=>errors.push(error.message));
 await draftPage.goto('http://127.0.0.1:'+server.address().port+'/tenant-dashboard?enable-semantics=true');
 await draftPage.locator('[data-cy=appearance-open]').click();
 await draftPage.locator('[data-cy=theme-center-name]').fill('Unsaved local draft');
 await draftPage.locator('[data-cy=theme-restore-review]').click();
 await draftPage.locator('[data-cy=theme-restore-confirm]').click();
 await draftPage.waitForFunction(()=>document.querySelector('[data-cy=theme-restore-status]')?.textContent?.startsWith('Could not restore'));
 assert.equal(await draftPage.locator('[data-cy=theme-center-name]').inputValue(),'Unsaved local draft');
 assert.equal(await draftPage.evaluate(key=>localStorage.getItem(key),key),null);
 await draft.close();
 // Another tab creating a library after review must block restoration without changing it.
 const conflict=await browser.newContext({viewport:{width:1440,height:960}});
 await conflict.addInitScript(token=>sessionStorage.setItem('primecare_session',token),actor.token);
 const conflictPage=await conflict.newPage();conflictPage.on('pageerror',error=>errors.push(error.message));
 await conflictPage.goto('http://127.0.0.1:'+server.address().port+'/tenant-dashboard?enable-semantics=true');
 await conflictPage.locator('[data-cy=appearance-open]').click();await conflictPage.locator('[data-cy=theme-restore-review]').click();
 await conflictPage.evaluate(({key,source})=>localStorage.setItem(key,source),{key,source});
 await conflictPage.locator('[data-cy=theme-restore-confirm]').click();
 await conflictPage.waitForFunction(()=>document.querySelector('[data-cy=theme-restore-status]')?.textContent?.startsWith('Could not restore'));
 assert.equal(await conflictPage.evaluate(key=>localStorage.getItem(key),key),source);
 assert.equal(await conflictPage.evaluate(key=>Object.keys(localStorage).filter(k=>k.startsWith('primecare-theme-restored:v1:'+key.slice('primecare-themes:v1:'.length)+':')).length,key),0);
 await conflict.close();
 // Two actual tabs share storage: an editor with an old snapshot cannot replace a newer save.
 const tabs=await browser.newContext({viewport:{width:1440,height:960}});
 await tabs.addInitScript(({token,key,source})=>{sessionStorage.setItem('primecare_session',token);if(localStorage.getItem(key)===null)localStorage.setItem(key,source);},{token:actor.token,key,source});
 const editor=await tabs.newPage();editor.on('pageerror',error=>errors.push(error.message));
 await editor.goto('http://127.0.0.1:'+server.address().port+'/tenant-dashboard?enable-semantics=true');
 await editor.locator('[data-cy=appearance-open]').click();
 await editor.locator('[data-cy=theme-center-name]').fill('Stale edit');
 const otherTab=await tabs.newPage();await otherTab.goto('http://127.0.0.1:'+server.address().port+'/tenant-dashboard?enable-semantics=true');
 const newer=JSON.stringify({version:1,active:{...theme,name:'Newer tab'},items:[]});
 // Hold the cross-tab lock so the pending save cannot enter its check/write section.
 await otherTab.evaluate(async key=>{await new Promise(resolve=>{navigator.locks.request('primecare-theme-library:'+key,{mode:'exclusive'},()=>new Promise(release=>{window.releaseThemeLock=release;resolve();}));});},key);
 await editor.locator('[data-cy=theme-center-new]').click();
 await editor.waitForFunction(()=>document.querySelector('[data-cy=theme-center-new]')?.disabled===true);
 assert.equal(await editor.evaluate(key=>localStorage.getItem(key),key),source);
 await otherTab.evaluate(({key,newer})=>{localStorage.setItem(key,newer);window.releaseThemeLock();},{key,newer});
 await editor.waitForFunction(()=>document.querySelector('[data-cy=theme-center-status]')?.textContent?.startsWith('Unable to save'));
 assert.equal(await editor.evaluate(key=>localStorage.getItem(key),key),newer);
 assert.equal(await editor.locator('[data-cy=theme-center-name]').inputValue(),'Stale edit');
 await tabs.close();
 await page.reload();
 await page.locator('[data-cy=appearance-open]').click();
 await page.locator('[data-cy=theme-migration-review]').click();
 await page.locator('[data-cy=theme-migration-save]').click();
 await page.waitForFunction(()=>document.querySelector('[data-cy=theme-migration-status]')?.textContent.startsWith('Could not save'));
 const afterReload=(await preference.db.query('SELECT revision,document FROM account_preference_documents WHERE user_id=$1',[actor.id])).rows[0];
 assert.equal(Number(afterReload.revision),1);assert.deepEqual(afterReload.document,row.document);
 const denied=await preference.fetch(new Request('https://fixture.test/v1/user/preferences',{method:'POST',headers:{authorization:'Bearer '+preference.tokens.user2,'content-type':'application/json'},body:JSON.stringify({version:1,action:'read',expectedScope:scope,dataset:'live',kind:'theme',resource:'advanced-v2'})}));
 assert.equal(denied.status,409);
 assert.equal(Number((await preference.db.query('SELECT count(*) n FROM account_preference_audit WHERE user_id=$1',[actor.id])).rows[0].n),1);
 assert.deepEqual(errors,[]);
 console.log('Actual Tenant Admin migration, separate-browser restore, draft protection, PostgreSQL, audit, isolation and reload passed.');
}finally{
 await browser?.close();if(server?.listening)await new Promise(resolve=>server.close(resolve));
 await preference?.close();await tenant?.close();
 if(created)await admin.query('DROP DATABASE preference_test');
 await admin.end();
}
