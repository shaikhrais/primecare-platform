/** Actual tenant portal and service against a disposable PostgreSQL-compatible fixture; no production credentials. */
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {createServer} from 'node:http';
import {readFile} from 'node:fs/promises';
import {pathToFileURL} from 'node:url';
import {join} from 'node:path';
import {tenantFixture} from './tenant-dashboard-fixture.mjs';
const {chromium}=await import('playwright').catch(()=>import(pathToFileURL(join(process.env.CODEX_PRIMARY_RUNTIME_NODE_MODULES,'playwright/index.mjs')).href));
const f=await tenantFixture();const bundle=await build({stdin:{contents:`import {renderTenantDashboard} from './websites/typescript/src/tenant-dashboard';import {mountLayoutCustomizer} from './packages/primecare_ui/web/layout-customizer';window.localize=(locale)=>mountLayoutCustomizer(document.querySelector('#app'),'test-locale',locale,{}, {screenCode:'tenant_admin_command_center',panels:{'tenant-preference-form':document.querySelector('[data-cy=tenant-preference-form]').closest('section')}});window.render=()=>renderTenantDashboard(document.querySelector('#app'),location.origin);`,resolveDir:process.cwd()},bundle:true,write:false,format:'iife'});
let writes=0;const preferencePosts=[];
const server=createServer(async(req,res)=>{try{if(req.url.startsWith('/v1/')){let body='';for await(const part of req)body+=part;const headers=new Headers(req.headers);if(req.method==='POST'){writes++;const value=JSON.parse(body);if(value.action==='preferences')preferencePosts.push({key:req.headers['idempotency-key'],body:value});}const reply=await f.tenantDashboard(new Request('https://fixture'+req.url,{method:req.method,headers,...(body?{body}:{})}),f.env,'/tenant-dashboard',{});res.statusCode=reply.status;res.setHeader('content-type','application/json');res.end(await reply.text());}else if(req.url==='/app.js'){res.setHeader('content-type','text/javascript');res.end(bundle.outputFiles[0].text);}else if(req.url==='/style.css'){res.setHeader('content-type','text/css');res.end(await readFile('websites/typescript/src/styles.css'));}else{res.setHeader('content-type','text/html');res.end('<!doctype html><html><head><link rel="stylesheet" href="/style.css"></head><body><div id="app"></div><script src="/app.js"></script><script>window.render()</script></body></html>');}}catch(e){res.statusCode=500;res.end(String(e));}});
await new Promise(r=>server.listen(0,'127.0.0.1',r));const origin='http://127.0.0.1:'+server.address().port;
const browser=await chromium.launch({headless:true,...(process.env.PRIMECARE_CHROMIUM_EXECUTABLE?{executablePath:process.env.PRIMECARE_CHROMIUM_EXECUTABLE,args:['--no-sandbox','--disable-dev-shm-usage']}: {})});const context=await browser.newContext({viewport:{width:1500,height:960}});await context.addInitScript(token=>sessionStorage.setItem('primecare_session',token),f.actors.admin.token);const page=await context.newPage(),errors=[];page.on('pageerror',e=>errors.push(e.message));const el=id=>page.locator('[data-cy='+id+']');
try{
 await page.goto(origin+'/tenant-dashboard');await el('appearance-open').waitFor();
 await page.evaluate(()=>{window.input=document.querySelector('[data-cy=tenant-preference-view]');window.clicks=0;input.addEventListener('change',()=>window.clicks++);});
 await page.evaluate(()=>window.dispatchEvent(new PageTransitionEvent('pagehide',{persisted:true})));assert.equal(await page.locator('[data-pc-workspace]').count(),1);
 await el('appearance-open').click();
 for(const position of ['right','top','bottom','hidden','left']){await el('workspace-layout-navigation').selectOption(position);assert.equal(await page.locator('[data-pc-workspace]').getAttribute('data-navigation'),position);}
 await el('workspace-layout-container').selectOption('boxed');await el('workspace-layout-max-width').fill('960');await el('workspace-layout-max-width').dispatchEvent('change');assert.equal(await page.locator('[data-pc-workspace]').getAttribute('data-narrow'),'false');await el('workspace-layout-max-width').fill('1200');await el('workspace-layout-max-width').dispatchEvent('change');await el('workspace-layout-toolbar').selectOption('bottom');await el('workspace-layout-scroll').selectOption('content');
 await el('workspace-layout-dock').selectOption('floating');await el('workspace-layout-undo').click();assert.equal(await el('workspace-layout-dock').inputValue(),'bottom');await el('workspace-layout-redo').click();assert.equal(await el('workspace-layout-dock').inputValue(),'floating');
 const xmlDownload=page.waitForEvent('download');await el('appearance-export').click();assert.equal((await xmlDownload).suggestedFilename(),'PrimeCare_Layout.xml');
 await page.evaluate(()=>{window.originalSetItem=Storage.prototype.setItem;Storage.prototype.setItem=function(){throw Error('quota');};});await el('workspace-layout-save').click();assert.match(await el('appearance-status').textContent(),/could not be saved/);await page.evaluate(()=>Storage.prototype.setItem=window.originalSetItem);
 await el('workspace-layout-save').click();assert.match(await el('appearance-status').textContent(),/Saved/);
 await el('workspace-layout-import').setInputFiles({name:'bad.json',mimeType:'application/json',buffer:Buffer.from('{"role":"code_admin"}')});await page.waitForFunction(()=>document.querySelector('[data-cy=appearance-status]').textContent.includes('Unable'));
 await el('workspace-layout-close').click();
 assert.equal(await page.evaluate(()=>window.input===document.querySelector('[data-cy=tenant-preference-view]')),true);await el('tenant-preference-view').selectOption('tasks');assert.equal(await page.evaluate(()=>window.clicks),1);assert.equal(writes,0);
 // Failed saves must retain the exact default-view draft across redraw and browser restart.
 const beforePreference=(await (await f.call('admin')).json()).preference;
 await page.route('**/v1/governance/tenant-dashboard*',async route=>{if(route.request().method()==='POST'){await route.fulfill({status:503,contentType:'application/json',body:JSON.stringify({error:'Fixture unavailable; draft must survive.'})});}else await route.continue();});
 await el('tenant-preference-save').click();await page.waitForFunction(()=>document.querySelector('[data-cy=tenant-status]').textContent.includes('Fixture unavailable'));
 assert.equal(await el('tenant-preference-view').inputValue(),'tasks');assert.deepEqual((await (await f.call('admin')).json()).preference,beforePreference);
 await page.unroute('**/v1/governance/tenant-dashboard*');await page.reload();await el('appearance-open').waitFor();assert.equal(await el('tenant-preference-view').inputValue(),'tasks');
 // Reload intentionally starts a fresh undo history; seed a real edit before testing rerender retention.
 await el('appearance-open').click();await el('workspace-layout-dock').selectOption('bottom');await el('workspace-layout-dock').selectOption('floating');await el('workspace-layout-close').click();
 await page.evaluate(()=>window.input=document.querySelector('[data-cy=tenant-preference-view]'));
 // Real form handler and database readback survive moving the original node.
 await el('tenant-preference-save').click();await page.waitForFunction(()=>document.querySelector('[data-cy=tenant-preference-view]')!==window.input);assert.equal((await (await f.call('admin')).json()).preference.view,'tasks');assert.equal(await page.locator('[data-pc-panel]').count(),1);assert.equal(await el('workspace-layout-move').count(),1);assert.equal(await el('appearance-open').count(),1);
 await el('appearance-open').click();assert.equal(await el('workspace-layout-dock').inputValue(),'floating');await el('workspace-layout-undo').click();assert.equal(await el('workspace-layout-dock').inputValue(),'bottom');await el('workspace-layout-redo').click();await el('workspace-layout-close').click();
 await page.reload();await el('appearance-open').click();assert.equal(await el('workspace-layout-dock').inputValue(),'floating');await el('workspace-layout-reset').click();await el('workspace-layout-close').click();
 await page.setViewportSize({width:390,height:844});await el('sidebar-toggle').click();await el('sidebar-close').waitFor({state:'visible'});await page.keyboard.press('Escape');assert.equal(await el('sidebar-toggle').getAttribute('aria-expanded'),'false');assert.ok(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1));
 await el('appearance-open').click();assert.ok(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1));await el('workspace-layout-close').click();
 // A newer remote revision must not silently rebase an unsaved local choice.
 await el('tenant-preference-view').selectOption('audit');const currentPreference=(await (await f.call('admin')).json()).preference;
 const concurrent=await f.call('admin',{action:'preferences',version:currentPreference.version,value:{view:'overview'}});assert.equal(concurrent.status,200);
 await el('tenant-search-form').evaluate(form=>form.requestSubmit());await page.waitForFunction(()=>document.querySelector('[data-cy=tenant-preference-view]').value==='audit');
 await el('tenant-preference-save').click();await page.waitForFunction(()=>document.querySelector('[data-cy=tenant-status]').textContent.includes('Your unsaved choice is kept'));
 assert.equal(await el('tenant-preference-view').inputValue(),'audit');assert.equal((await (await f.call('admin')).json()).preference.view,'overview');
 page.once('dialog',dialog=>dialog.dismiss());await el('tenant-refresh').click();assert.equal(await el('tenant-preference-view').inputValue(),'audit');
 page.once('dialog',dialog=>dialog.accept());await el('tenant-refresh').click();await page.waitForFunction(()=>document.querySelector('[data-cy=tenant-preference-view]').value==='overview');
 // A choice edited during a save remains dirty on the acknowledged revision.
 await el('tenant-preference-view').selectOption('tasks');let releaseSave;const heldSave=new Promise(resolve=>releaseSave=resolve);let sawSave;const saveStarted=new Promise(resolve=>sawSave=resolve);
 await page.route('**/v1/governance/tenant-dashboard*',async route=>{if(route.request().method()==='POST'){sawSave();await heldSave;}await route.continue();});
 await el('tenant-preference-save').click();await saveStarted;await el('tenant-preference-view').selectOption('audit');releaseSave();
 await page.waitForFunction(()=>document.querySelector('[data-cy=tenant-status]').textContent.includes('newer default-view edit'));
 assert.equal(await el('tenant-preference-view').inputValue(),'audit');assert.equal((await (await f.call('admin')).json()).preference.view,'tasks');
 await page.unroute('**/v1/governance/tenant-dashboard*');await el('tenant-preference-save').click();await page.waitForFunction(()=>document.querySelector('[data-cy=tenant-status]').textContent.includes('Default view saved'));
 assert.equal((await (await f.call('admin')).json()).preference.view,'audit');await page.reload();await el('appearance-open').waitFor();assert.equal(await el('tenant-preference-view').inputValue(),'audit');
 // Lost acknowledgement: commit once, drop the response, reload, then replay the exact saved ID/body.
 const identity=await (await f.call('admin')).json();
 const storedPreference=async()=>{const rows=(await f.db.query('SELECT view,version FROM tenant_dashboard_preferences WHERE tenant_id=$1 AND user_id=$2',[identity.organization.id,identity.identity.userId])).rows;assert.equal(rows.length,1);return rows[0];};
 const beforeLost=await storedPreference(),postStart=preferencePosts.length;
 const beforeLostEvents=Number((await f.db.query("SELECT count(*) AS total FROM tenant_dashboard_events WHERE actor_id=$1 AND action='preferences'",[identity.identity.userId])).rows[0].total);
 await el('tenant-preference-view').selectOption('tasks');
 await page.route('**/v1/governance/tenant-dashboard*',async route=>{if(route.request().method()==='POST'){const response=await route.fetch();assert.equal(response.status(),200);await route.abort('failed');}else await route.continue();});
 await el('tenant-preference-save').click();await page.waitForFunction(()=>document.querySelector('[data-cy=tenant-status]').textContent.includes('awaiting confirmation'));
 assert.deepEqual(await storedPreference(),{view:'tasks',version:beforeLost.version+1});
 await el('tenant-preference-view').selectOption('audit');await page.unroute('**/v1/governance/tenant-dashboard*');await page.reload();await el('appearance-open').waitFor();
 assert.equal(await el('tenant-preference-view').inputValue(),'audit');assert.equal(preferencePosts.length,postStart+1,'load must never auto-retry a save');
 await el('tenant-refresh').click();assert.equal(preferencePosts.length,postStart+1,'refresh cannot issue an uncertain mutation');
 await el('tenant-preference-save').click();await page.waitForFunction(()=>document.querySelector('[data-cy=tenant-status]').textContent.includes('newer default-view edit'));
 assert.deepEqual(preferencePosts[postStart+1],preferencePosts[postStart]);assert.deepEqual(await storedPreference(),{view:'tasks',version:beforeLost.version+1});
 const auditCount=Number((await f.db.query("SELECT count(*) AS total FROM tenant_dashboard_events WHERE actor_id=$1 AND action='preferences'",[identity.identity.userId])).rows[0].total);assert.equal(auditCount,beforeLostEvents+1,'replaying a receipt cannot append a second preference event');
 await el('tenant-preference-save').click();await page.waitForFunction(()=>document.querySelector('[data-cy=tenant-status]').textContent.includes('Default view saved'));
 assert.deepEqual(await storedPreference(),{view:'audit',version:beforeLost.version+2});assert.notEqual(preferencePosts[postStart+2].key,preferencePosts[postStart].key);
 assert.equal(Number((await f.db.query("SELECT count(*) AS total FROM tenant_dashboard_events WHERE actor_id=$1 AND action='preferences'",[identity.identity.userId])).rows[0].total),auditCount+1);
 // Switching authenticated actor uses a different storage scope and never restores old panels.
 await page.evaluate(token=>{sessionStorage.setItem('primecare_session',token);document.querySelector('#app').innerHTML='';return window.render();},f.actors.psw.token);await el('appearance-open').click();assert.equal(await el('workspace-layout-dock').inputValue(),'bottom');assert.equal(await page.locator('[data-pc-panel]').count(),1);
 await el('workspace-layout-close').click();for(const [locale,label] of [['fr','Disposition de l’espace de travail'],['es','Diseño del espacio de trabajo'],['en','Workspace layout']]){await page.evaluate(locale=>window.localize(locale),locale);await el('appearance-open').click();assert.equal(await page.locator('[data-workspace-controls] legend').textContent(),label);await el('workspace-layout-close').click();assert.equal(await page.locator('[data-pc-panel]').count(),1);}
 assert.deepEqual(errors,[]);console.log(JSON.stringify({actualTenantPortal:true,disposableDatabase:f.native?'PostgreSQL':'PGlite',navigation:true,layoutControls:true,undoRedo:true,saveReload:true,invalidImport:true,originalNodeAndHandler:true,preferenceDatabaseReadback:true,rerenderHistory:true,mobileDrawer:true,actorIsolation:true,preferenceDraftRestart:true,failedPreferenceSaveRetained:true,preferenceConflictPreserved:true,explicitDraftDiscard:true,newerEditDuringSaveRetained:true,pendingRequestRestart:true,lostAcknowledgementReceiptReplay:true,independentPreferenceSqlReadback:true,noDuplicatePreferenceEvent:true,productionVerified:false}));
}finally{await context.close();await browser.close();await new Promise(r=>server.close(r));await f.close();}
