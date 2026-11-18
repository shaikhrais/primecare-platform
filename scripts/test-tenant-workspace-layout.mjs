/** Actual tenant portal and service against a disposable PostgreSQL-compatible fixture; no production credentials. */
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {createServer} from 'node:http';
import {readFile} from 'node:fs/promises';
import {pathToFileURL} from 'node:url';
import {join} from 'node:path';
import {tenantFixture} from './tenant-dashboard-fixture.mjs';
const {chromium,webkit,devices}=await import('playwright').catch(()=>import(pathToFileURL(join(process.env.CODEX_PRIMARY_RUNTIME_NODE_MODULES,'playwright/index.mjs')).href));
const f=await tenantFixture();const bundle=await build({stdin:{contents:`import {renderTenantDashboard} from './websites/typescript/src/tenant-dashboard';import {mountLayoutCustomizer} from './packages/primecare_ui/web/layout-customizer';import {installPortalPresentation} from './websites/typescript/src/screen-presentation';import {resolveManagedRoute} from './websites/typescript/src/managed-routes';import {tenantPresentationTheme} from './scripts/fixtures/tenant-presentation-theme';import {MasterDashboard} from './packages/primecare_ui/web/master-dashboard';import {connectGovernedMasterDashboard} from './websites/typescript/src/governed-master-dashboard';import {requireMasterDashboard} from './packages/primecare_ui/web/dashboard-render-policy';import {renderShell} from './packages/primecare_ui/web/shell';import {ScreenManager,installScreenManager} from './packages/primecare_ui/web/screen-manager';window.proveMaster=()=>{
 document.querySelector('#app').remove();
 const testRoot=document.body.appendChild(document.createElement('div'));
 const fixtureManager=new ScreenManager({layout:()=>{},theme:()=>{},language:()=>{},responsive:()=>{}});
 installScreenManager(testRoot,fixtureManager);
 const entry={id:'master-fixture',route:'/master-fixture',kind:'feature',adapter:'fixture'};
 const config={screenCode:'fixture_master',route:entry.route,title:'Reusable fixture',views:[{id:'work',label:'Work'},{id:'excluded',label:'Excluded'}]};
 const dialogOptions={className:'fixture-dialog',headingSelector:'h2',closeSelector:'[data-fixture-close]',statusKey:'fixture-status',current:()=>true,revision:()=>0,canDismiss:()=>false};
 class FixtureDashboard extends MasterDashboard{constructor(){super(testRoot,fixtureManager,entry,config,dialogOptions);}}
 const shell={home:entry.route,role:'Fixture',navigation:'',controls:'',content:'<h1>Fixture body</h1>'};
 const binding={locale:'en',profileScope:'fixture:master',allowedViews:['work'],view:'work',shell,current:()=>true,select:()=>{}};
 requireMasterDashboard(testRoot);
 let bypassBlocked=false;try{renderShell(testRoot,shell);}catch(error){bypassBlocked=String(error).includes('must extend MasterDashboard')&&!testRoot.firstChild;}
 fixtureManager.registerScope('fixture',[entry]);
 const dashboard=new FixtureDashboard();
 const screen=dashboard.mount(binding);
 let invalidSlot=false;try{dashboard.mount({...binding,panels:{missing:'[data-fixture-panel]'}});}catch(error){invalidSlot=String(error).includes('exactly once');}
 let wrongDockHost=false;try{dashboard.mount({...binding,panels:{known:'h1'}});}catch(error){wrongDockHost=String(error).includes('Unregistered workspace docking host');}
 const priorUnchanged=testRoot.querySelector('[data-cy=app-shell]')===screen;
 const modal=dashboard.dialogs.open('<h2>Fixture dialog</h2><form><select multiple><option selected>First</option><option>Second</option></select><button data-fixture-close>Cancel</button></form>');
 let submits=0;modal.querySelector('form').onsubmit=e=>{e.preventDefault();submits++;};
 modal.querySelector('select').options[1].selected=true;
 const multiDraft=dashboard.dialogs.isDirty(modal),oldClose=modal.querySelector('[data-fixture-close]');
 oldClose.click();
 const vetoPreserved=modal.open&&submits===0;
 dashboard.dialogs.replaceContent(modal,'<h2>Replacement</h2><button data-fixture-close>Close</button>');
 oldClose.click();
 const replacementPreserved=modal.open&&modal.querySelector('h2').textContent==='Replacement';
 fixtureManager.registerScope('fixture',[entry]);
 const retired=!modal.isConnected&&!screen.isConnected;
 let rejected=false;try{dashboard.mount(binding);}catch(error){rejected=String(error).includes('Inactive or unavailable');}
 const next=new FixtureDashboard(),nextScreen=next.mount(binding);
 dashboard.dispose();
 const newOwnerPreserved=nextScreen.isConnected;
 next.dispose();testRoot.remove();
 const workspaceRoot=document.body.appendChild(document.createElement('div'));
 const workspaceManager=new ScreenManager({layout:()=>{},theme:()=>{},language:()=>{},responsive:()=>{}});
 installScreenManager(workspaceRoot,workspaceManager);
 const first={code:'first_fixture',name:'First generic',route:'/first-fixture',renderer:'dashboard'};
 const second={code:'second_fixture',name:'Second generic',route:'/second-fixture',renderer:'dashboard'};
 workspaceManager.registerScope('workspace',[first,second].map(page=>({id:'governed:'+page.code,route:page.route,kind:'governed',adapter:'workspace'})));
 const firstOwner=connectGovernedMasterDashboard(workspaceRoot,workspaceManager,first,()=>true);
 const overview={...binding,allowedViews:['overview'],view:'overview'};
 firstOwner.master.mount(overview);
 firstOwner.master.dispose();
 const secondOwner=connectGovernedMasterDashboard(workspaceRoot,workspaceManager,second,()=>true);
 secondOwner.master.mount({...overview,shell:{...shell,content:'<h1>Second generic</h1>'}});
 const genericNavigation=workspaceRoot.querySelector('h1')?.textContent==='Second generic';
 secondOwner.master.dispose();
 renderShell(workspaceRoot,{...shell,content:'<h1>Ordinary record</h1>'});
 const ordinaryAfterDashboard=workspaceRoot.querySelector('h1')?.textContent==='Ordinary record';
 workspaceRoot.remove();
 return {bypassBlocked,invalidSlot,wrongDockHost,priorUnchanged,multiDraft,vetoPreserved,replacementPreserved,retired,rejected,newOwnerPreserved,genericNavigation,ordinaryAfterDashboard};
};const root=document.querySelector('#app'),manager=installPortalPresentation(root,tenantPresentationTheme,location.origin);manager.registerScope('entry',[resolveManagedRoute('/tenant-dashboard','')]);window.localize=(locale)=>mountLayoutCustomizer(document.querySelector('#app'),'test-locale',locale,{}, {screenCode:'tenant_admin_command_center',panels:{'tenant-preference-form':document.querySelector('[data-cy=tenant-preference-form]').closest('section')}});window.render=()=>renderTenantDashboard(document.querySelector('#app'),location.origin);`,resolveDir:process.cwd()},bundle:true,write:false,format:'iife'});
let writes=0;const preferencePosts=[];
const server=createServer(async(req,res)=>{try{if(req.url.startsWith('/v1/')){let body='';for await(const part of req)body+=part;const headers=new Headers(req.headers);if(req.method==='POST'){const value=JSON.parse(body);if(!(req.url==='/v1/user/preferences'&&value.action==='read'))writes++;if(value.action==='preferences')preferencePosts.push({key:req.headers['idempotency-key'],body:value});}const reply=await f.tenantDashboard(new Request('https://fixture'+req.url,{method:req.method,headers,...(body?{body}:{})}),f.env,'/tenant-dashboard',{});res.statusCode=reply.status;res.setHeader('content-type','application/json');res.end(await reply.text());}else if(req.url==='/app.js'){res.setHeader('content-type','text/javascript');res.end(bundle.outputFiles[0].text);}else if(req.url==='/style.css'){res.setHeader('content-type','text/css');res.end(await readFile('websites/typescript/src/styles.css'));}else{res.setHeader('content-type','text/html');res.end('<!doctype html><html><head><meta name="viewport" content="width=device-width, initial-scale=1"><link rel="stylesheet" href="/style.css"></head><body><div id="app"></div><script src="/app.js"></script><script>window.render()</script></body></html>');}}catch(e){res.statusCode=500;res.end(String(e));}});
await new Promise(r=>server.listen(0,'127.0.0.1',r));const origin='http://127.0.0.1:'+server.address().port;
const profile=process.env.PRIMECARE_DASHBOARD_DEVICE;
const mobileProfiles={
 'android-phone':{engine:chromium,device:devices['Pixel 7']},
 'iphone':{engine:webkit,device:devices['iPhone 13']},
 'ipad':{engine:webkit,device:devices['iPad (gen 7)']},
 'android-tablet':{engine:chromium,device:{viewport:{width:800,height:1100},deviceScaleFactor:2,isMobile:true,hasTouch:true}},
};
const target=profile?mobileProfiles[profile]:null;
if(profile&&!target?.device)throw Error('Unknown or unavailable browser device profile: '+profile);
const browser=await (target?.engine??chromium).launch({headless:true,...((!target||target.engine===chromium)&&process.env.PRIMECARE_CHROMIUM_EXECUTABLE?{executablePath:process.env.PRIMECARE_CHROMIUM_EXECUTABLE,args:['--no-sandbox','--disable-dev-shm-usage']}: {})});const context=await browser.newContext(target?.device??{viewport:{width:1500,height:960}});await context.addInitScript(token=>sessionStorage.setItem('primecare_session',token),f.actors.admin.token);const page=await context.newPage(),errors=[];page.on('pageerror',e=>errors.push(e.message));const el=id=>page.locator('[data-cy='+id+']');
try{
 if(target){
  page.setDefaultTimeout(8000);
  assert.equal(target.device.hasTouch,true,'device profile must request touch emulation');
  // Verify trusted touch on the actual controls. WebKit can report zero
  // maxTouchPoints in emulation even when it delivers genuine touch events.
  const observeTouch=()=>page.evaluate(()=>{
   window.__deviceInput=[];
   for(const type of ['pointerdown','touchstart','touchend','click']) document.addEventListener(type,event=>{
    const id=event.target instanceof Element?event.target.closest('[data-cy]')?.getAttribute('data-cy'):null;
    if(id)window.__deviceInput.push({type,id,trusted:event.isTrusted,pointer:event.pointerType??null});
   },true);
  });
  const touchFor=(events,id)=>events.some(event=>event.id===id&&event.trusted&&(event.type==='touchstart'||(event.type==='pointerdown'&&event.pointer==='touch')));
  await page.goto(origin+'/tenant-dashboard?enable-semantics=true');
  await el('tenant-create-task').waitFor();
  const measured=await page.evaluate(()=>({width:document.documentElement.clientWidth,scroll:document.documentElement.scrollWidth,maxTouchPoints:navigator.maxTouchPoints}));
  assert.equal(measured.width,target.device.viewport.width,'fixture renders at actual emulated viewport width');
  assert.ok(measured.scroll<=measured.width+1,'dashboard does not scroll horizontally');
  await observeTouch();
  await el('tenant-create-task').tap();
  const dialog=page.getByRole('dialog');
  await dialog.waitFor();
  assert.equal(await dialog.getAttribute('aria-labelledby'),await dialog.getByRole('heading',{level:2}).getAttribute('id'));
  const box=await dialog.boundingBox(),viewport=page.viewportSize();
  assert.ok(box&&viewport&&box.x>=-1&&box.x+box.width<=viewport.width+1&&box.height<=viewport.height+1,'task panel remains within viewport');
  await el('tenant-dialog-close').tap();
  await dialog.waitFor({state:'detached'});
  assert.equal(new URL(page.url()).hash,'#overview');
  assert.equal(writes,0,'opening and dismissing a panel issues no task write');
  assert.deepEqual(errors,[]);
  const panelEvents=await page.evaluate(()=>window.__deviceInput);
  const trustedTouch=touchFor(panelEvents,'tenant-create-task')&&touchFor(panelEvents,'tenant-dialog-close');
  console.log(JSON.stringify({profile,browser:target.engine.name(),emulated:true,realDevice:false,nativeApp:false,viewport:true,maxTouchPoints:measured.maxTouchPoints,emulatedTapOpenClose:true,trustedTouch,accessibleDialogName:true,noWrite:true,fixturePostgreSQL:f.native,productionVerified:false,version:browser.version(),panelEvents}));
  assert.ok(trustedTouch,'opening and closing the task panel must deliver trusted touch input');
 }else{
 await page.goto(origin+'/tenant-dashboard?enable-semantics=true');
 await page.waitForFunction(()=>document.querySelector('[data-cy=appearance-open]')||document.querySelector('[data-cy=error-state]'));
 assert.deepEqual(errors,[],'the real Screen Manager bootstrap must succeed before layout acceptance');
 assert.equal(await el('error-state').count(),0,'presentation configuration errors must fail acceptance');
 await el('appearance-open').waitFor();
 // Browser history must use the same authorization and pending-work guards as navigation.
 const changeHistory=async hash=>page.evaluate(hash=>{history.pushState(null,'',hash);dispatchEvent(new PopStateEvent('popstate'));},hash);
 assert.equal(await page.evaluate(()=>location.hash),'#overview');assert.equal(await page.locator('[data-pc-slot=main]').count(),1);
 await page.evaluate(()=>window.routePreference=document.querySelector('[data-cy=tenant-preference-view]'));
 await changeHistory('#unknown-view');assert.equal(await page.evaluate(()=>location.hash),'#overview');assert.equal(await page.evaluate(()=>window.routePreference===document.querySelector('[data-cy=tenant-preference-view]')),true);
 await el('tenant-create-task').click();await el('tenant-task-title').fill('Unsaved route draft');
 await changeHistory('#audit');assert.equal(await page.evaluate(()=>location.hash),'#overview');assert.equal(await el('tenant-task-title').inputValue(),'Unsaved route draft');assert.equal(await page.locator('dialog[open]').count(),1);assert.equal(await page.evaluate(()=>window.routePreference===document.querySelector('[data-cy=tenant-preference-view]')),true);
 const draftDialog=page.locator('dialog.td-dialog[open]');
 assert.equal(await draftDialog.getByRole('heading',{level:2}).getAttribute('id'),await draftDialog.getAttribute('aria-labelledby'));
 const statusAlert=draftDialog.locator('[data-cy=tenant-dialog-status]');
 await page.keyboard.press('Escape');
 await statusAlert.waitFor({state:'attached',timeout:5000});
 await draftDialog.evaluate(dialog=>dialog.dispatchEvent(new Event('cancel',{cancelable:true})));
 assert.equal(await statusAlert.count(),1,'repeated dismiss attempts reuse one status alert');
 assert.equal(await el('tenant-task-title').inputValue(),'Unsaved route draft','Escape cannot discard a dirty task form');
 assert.equal(writes,0,'guarded draft navigation must not write');
 const acceptDiscard=dialog=>dialog.accept();
 page.once('dialog',acceptDiscard);
 try{await el('tenant-dialog-close').click();await page.locator('dialog.td-dialog').waitFor({state:'detached'});}
 finally{page.off('dialog',acceptDiscard);}
 await page.waitForFunction(()=>document.activeElement?.getAttribute('data-cy')==='tenant-create-task');
 await changeHistory('#audit');assert.equal(await page.locator('[data-td-view=audit]').getAttribute('aria-current'),'page');
 await page.evaluate(()=>window.routePreference=document.querySelector('[data-cy=tenant-preference-view]'));await page.evaluate(()=>dispatchEvent(new PopStateEvent('popstate')));assert.equal(await page.evaluate(()=>window.routePreference===document.querySelector('[data-cy=tenant-preference-view]')),true);
 await changeHistory('#overview');await page.goBack();await page.waitForFunction(()=>document.querySelector('[data-td-view=audit]').getAttribute('aria-current')==='page');await page.goForward();await page.waitForFunction(()=>document.querySelector('[data-td-view=overview]').getAttribute('aria-current')==='page');assert.equal(writes,0);
 await page.evaluate(()=>{window.input=document.querySelector('[data-cy=tenant-preference-view]');window.clicks=0;input.addEventListener('change',()=>window.clicks++);});
 // A cached document cannot save until the browser restores its existing owner.
 await page.evaluate(()=>window.dispatchEvent(new PageTransitionEvent('pagehide',{persisted:true})));assert.equal(await page.locator('[data-pc-workspace]').count(),1);
 await el('tenant-preference-save').click();assert.equal(writes,0);assert.equal(preferencePosts.length,0);
 await page.evaluate(()=>window.dispatchEvent(new PageTransitionEvent('pageshow',{persisted:true})));
 assert.equal(await page.evaluate(()=>window.input===document.querySelector('[data-cy=tenant-preference-view]')),true);
 await el('appearance-open').click();
 assert.equal(await el('workspace-layout-footer').isEnabled(),true);assert.equal(await el('app-footer').count(),1);await el('workspace-layout-footer').selectOption('sticky');
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
 await page.unroute('**/v1/governance/tenant-dashboard*');await page.reload();await el('appearance-open').waitFor();assert.equal(await el('tenant-preference-view').inputValue(),'tasks');assert.equal(await page.locator('[data-pc-workspace]').getAttribute('data-footer'),'sticky');assert.equal(await el('app-footer').count(),1);
 // Reload intentionally starts a fresh undo history; seed a real edit before testing rerender retention.
 await el('appearance-open').click();await el('workspace-layout-dock').selectOption('bottom');await el('workspace-layout-dock').selectOption('floating');await el('workspace-layout-close').click();
 await page.evaluate(()=>{window.input=document.querySelector('[data-cy=tenant-preference-view]');window.originalFooter=document.querySelector('[data-cy=app-footer]');});
 // Real form handler and database readback survive moving the original node.
 await el('tenant-preference-save').click();await page.waitForFunction(()=>document.querySelector('[data-cy=tenant-preference-view]')!==window.input);assert.equal((await (await f.call('admin')).json()).preference.view,'tasks');assert.equal(await page.locator('[data-pc-panel]').count(),1);assert.equal(await el('workspace-layout-move').count(),1);assert.equal(await page.evaluate(()=>window.originalFooter===document.querySelector('[data-cy=app-footer]')),true);assert.equal(await el('appearance-open').count(),1);
 await el('appearance-open').click();assert.equal(await el('workspace-layout-dock').inputValue(),'floating');await el('workspace-layout-undo').click();assert.equal(await el('workspace-layout-dock').inputValue(),'bottom');await el('workspace-layout-redo').click();await el('workspace-layout-close').click();
 await page.reload();await el('appearance-open').click();assert.equal(await el('workspace-layout-dock').inputValue(),'floating');await el('workspace-layout-reset').click();await el('workspace-layout-close').click();
 await page.setViewportSize({width:390,height:844});await el('sidebar-toggle').click();await el('sidebar-close').waitFor({state:'visible'});await page.keyboard.press('Escape');assert.equal(await el('sidebar-toggle').getAttribute('aria-expanded'),'false');assert.ok(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1));
 await el('appearance-open').click();assert.ok(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1));await el('workspace-layout-close').click();
 // A newer remote revision must not silently rebase an unsaved local choice.
 await el('tenant-preference-view').selectOption('audit');const currentPreference=(await (await f.call('admin')).json()).preference;
 const concurrent=await f.call('admin',{action:'preferences',version:currentPreference.version,value:{view:'overview'}});assert.equal(concurrent.status,200);
 await page.evaluate(()=>{window.conflictPreference=document.querySelector('[data-cy=tenant-preference-view]');});
 await el('tenant-search-form').evaluate(form=>form.requestSubmit());await page.waitForFunction(()=>{const input=document.querySelector('[data-cy=tenant-preference-view]');return input!==window.conflictPreference&&input?.value==='audit';});
 await el('tenant-preference-save').click();await page.waitForFunction(()=>document.querySelector('[data-cy=tenant-status]').textContent.includes('Your unsaved choice is kept'));
 assert.equal(await el('tenant-preference-view').inputValue(),'audit');assert.equal((await (await f.call('admin')).json()).preference.view,'overview');
 page.once('dialog',dialog=>dialog.dismiss());await el('tenant-refresh').click();assert.equal(await el('tenant-preference-view').inputValue(),'audit');
 page.once('dialog',dialog=>dialog.accept());await el('tenant-refresh').click();await page.waitForFunction(()=>document.querySelector('[data-cy=tenant-preference-view]').value==='overview');
 // A choice edited during a save remains dirty on the acknowledged revision.
 await el('tenant-preference-view').selectOption('tasks');let releaseSave;const heldSave=new Promise(resolve=>releaseSave=resolve);let sawSave;const saveStarted=new Promise(resolve=>sawSave=resolve);
 await page.route('**/v1/governance/tenant-dashboard*',async route=>{if(route.request().method()==='POST'){sawSave();await heldSave;}await route.continue();});
 await el('tenant-preference-save').click();await saveStarted;await el('tenant-preference-view').selectOption('audit');
 const pendingHash=await page.evaluate(()=>{window.routePreference=document.querySelector('[data-cy=tenant-preference-view]');return location.hash;});await changeHistory('#workflows');assert.equal(await page.evaluate(()=>location.hash),pendingHash);assert.equal(await page.evaluate(()=>window.routePreference===document.querySelector('[data-cy=tenant-preference-view]')),true);assert.equal(await el('tenant-preference-view').inputValue(),'audit');releaseSave();
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
 // Default desktop layout and independent browser history for pilot acceptance.
 const boardContext=await browser.newContext({viewport:{width:1500,height:960}});
 try{
  await boardContext.addInitScript(token=>sessionStorage.setItem('primecare_session',token),f.actors.admin.token);
  const boardPage=await boardContext.newPage(),boardEl=id=>boardPage.locator('[data-cy='+id+']');
  boardPage.on('pageerror',e=>errors.push(e.message));
  await boardPage.goto(origin+'/tenant-dashboard?enable-semantics=true#overview');
  await boardEl('screen-tenant-admin-dashboard').waitFor();
  await boardEl('tenant-nav-tasks').click();
  await boardEl('tenant-task-table').waitFor();
  const boardApi='/v1/governance/tenant-dashboard';
  const isBoardResponse=(response,method)=>new URL(response.url()).pathname===boardApi&&response.request().method()===method;
  await boardPage.evaluate(()=>window.taskFilterBefore=document.querySelector('[data-cy=tenant-task-filter]'));
  await Promise.all([
   boardPage.waitForResponse(r=>isBoardResponse(r,'GET')&&new URL(r.url()).searchParams.get('status')==='open'),
   boardEl('tenant-task-filter').selectOption('open'),
  ]);
  await boardPage.waitForFunction(()=>{const current=document.querySelector('[data-cy=tenant-task-filter]');return current!==window.taskFilterBefore&&current?.value==='open';});
  const taskWrites=writes,taskTitle='Pilot assignment from the task dashboard';
  await boardEl('tenant-create-task').click();
  const sheet=boardPage.getByRole('dialog');
  await sheet.waitFor();
  assert.equal(await sheet.getAttribute('aria-labelledby'),await sheet.getByRole('heading',{level:2}).getAttribute('id'));
  await boardPage.waitForFunction(()=>document.activeElement?.tagName==='H2'&&Boolean(document.activeElement.closest('dialog[open]')));
  await boardEl('tenant-task-title').fill(taskTitle);
  await boardEl('tenant-task-owner').selectOption(f.actors.psw.id);
  await boardEl('tenant-task-workflow').selectOption('fixture.tenant.process');
  const [created]=await Promise.all([boardPage.waitForResponse(r=>isBoardResponse(r,'POST')),boardEl('tenant-task-save').click()]);
  assert.equal(created.status(),200);
  const taskReceipt=await created.json(),item=taskReceipt.tasks.find(row=>row.title===taskTitle);
  assert.ok(item?.id);
  assert.equal(taskReceipt.organization.id,identity.organization.id);
  assert.deepEqual((await f.db.query('SELECT tenant_id,owner_id,flow_id,status,created_by FROM tenant_work_tasks WHERE id=$1',[item.id])).rows,[
   {tenant_id:identity.organization.id,owner_id:f.actors.psw.id,flow_id:'fixture.tenant.process',status:'open',created_by:identity.identity.userId},
  ]);
  await sheet.waitFor({state:'hidden'});
  const opener='tenant-task-open-'+item.id;
  await boardEl(opener).click();
  await sheet.waitFor();
  assert.equal(await sheet.getByRole('heading',{level:2}).textContent(),taskTitle);
  const verifyTaskContext=async()=>{
   await sheet.waitFor({state:'hidden'});
   assert.equal(new URL(boardPage.url()).hash,'#tasks');
   assert.equal(await boardEl('tenant-task-filter').inputValue(),'open');
   await boardPage.waitForFunction(id=>document.activeElement?.getAttribute('data-cy')===id,opener);
  };
  await boardPage.keyboard.press('Escape');await verifyTaskContext();
  await boardEl(opener).press('Enter');await sheet.waitFor();
  await boardPage.goBack();await verifyTaskContext();
  assert.equal(writes,taskWrites+1,'opening and dismissing task detail must not issue a task write');
 }finally{await boardContext.close();}
 // Switching authenticated actor uses a different storage scope and never restores old panels.
 await page.evaluate(token=>{sessionStorage.setItem('primecare_session',token);history.replaceState(null,'','#clients');document.querySelector('#app').innerHTML='';return window.render();},f.actors.psw.token);
 const allowedHash=await page.evaluate(()=>{window.routePreference=document.querySelector('[data-cy=tenant-preference-view]');return location.hash;});assert.notEqual(allowedHash,'#clients');
 for(const hash of ['#clients','#staff','#overview','#unknown-view']){await changeHistory(hash);assert.equal(await page.evaluate(()=>location.hash),allowedHash);assert.equal(await page.evaluate(()=>window.routePreference===document.querySelector('[data-cy=tenant-preference-view]')),true);}
 await page.evaluate(()=>{location.hash='clients';});await page.waitForFunction(hash=>location.hash===hash,allowedHash);assert.equal(await page.evaluate(()=>window.routePreference===document.querySelector('[data-cy=tenant-preference-view]')),true);
 await el('appearance-open').click();assert.equal(await el('workspace-layout-dock').inputValue(),'bottom');assert.equal(await page.locator('[data-pc-panel]').count(),1);
 await el('workspace-layout-close').click();for(const [locale,label] of [['fr','Disposition de l’espace de travail'],['es','Diseño del espacio de trabajo'],['en','Workspace layout']]){await page.evaluate(locale=>window.localize(locale),locale);await el('appearance-open').click();assert.equal(await page.locator('[data-workspace-controls] legend').textContent(),label);await el('workspace-layout-close').click();assert.equal(await page.locator('[data-pc-panel]').count(),1);}
 assert.deepEqual(errors,[]);
 const core=await page.evaluate(()=>window.proveMaster());
 assert.deepEqual(core,{bypassBlocked:true,invalidSlot:true,wrongDockHost:true,priorUnchanged:true,multiDraft:true,vetoPreserved:true,replacementPreserved:true,retired:true,rejected:true,newOwnerPreserved:true,genericNavigation:true,ordinaryAfterDashboard:true});
 console.log(JSON.stringify({masterCore:core}));
 console.log(JSON.stringify({actualTenantPortal:true,disposableDatabase:f.native?'PostgreSQL':'PGlite',navigation:true,deniedDeepLinkNormalized:true,deniedHistoryAndHashBlocked:true,dialogDraftPreservedOnHistory:true,pendingSavePreservedOnHistory:true,sameViewHistoryPreservesNodes:true,taskBoardCreateReadback:true,taskBoardFilterAndFocusPreserved:true,taskBoardBackAndEscape:true,layoutControls:true,undoRedo:true,saveReload:true,invalidImport:true,originalNodeAndHandler:true,preferenceDatabaseReadback:true,rerenderHistory:true,mobileDrawer:true,actorIsolation:true,preferenceDraftRestart:true,failedPreferenceSaveRetained:true,preferenceConflictPreserved:true,explicitDraftDiscard:true,newerEditDuringSaveRetained:true,pendingRequestRestart:true,lostAcknowledgementReceiptReplay:true,independentPreferenceSqlReadback:true,noDuplicatePreferenceEvent:true,productionVerified:false}));
 }
}finally{await context.close();await browser.close();await new Promise(r=>server.close(r));await f.close();}
