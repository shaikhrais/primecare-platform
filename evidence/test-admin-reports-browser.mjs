import {createRequire} from 'node:module';
import {chromium} from 'playwright';
import {createServer} from 'node:http';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {join,resolve} from 'node:path';
import assert from 'node:assert/strict';
const {PdfReportRenderer}=createRequire(import.meta.url)(resolve('artifacts/admin-website/reporting.cjs'));
const registry=JSON.parse(await readFile('cloudflare/workers/src/workspace-registry.json','utf8'));
const reportRegistry=JSON.parse(await readFile('cloudflare/workers/src/report-registry.json','utf8'));
const screens=registry.screens.filter(s=>s.grants.some(g=>g.role==='admin'&&g.view));
const site=resolve('artifacts/admin-website/site'), out=resolve('artifacts/admin-website');
await mkdir(site,{recursive:true});await mkdir(join(out,'screenshots'),{recursive:true});
const origin='http://127.0.0.1:4173';
const manifest=JSON.parse(await readFile('artifacts/admin-website/manifests/primecare-franchise/portal.json','utf8'));
await writeFile(join(site,'portal.json'),JSON.stringify({...manifest,name:'PrimeCare Admin - isolated test website',apiGateway:origin+'/test-api'}));
let emailOutcome='accepted',pdfValid=true;const emailKeys=[];
const fixture={reporting:{endpoint:reportRegistry.endpoint,screens:reportRegistry.surfaces.map(s=>s.screen)},identity:{userId:'synthetic-admin',role:'admin'},landing:registry.landings.admin,screens,inventory:registry.screens,actions:[],resources:registry.resources,overview:{activeAccounts:4,activeSessions:1,accountRoles:[{role:'admin',count:1},{role:'rmt',count:3}],activity:[{action:'Synthetic admin test session',created_at:'2026-10-11T22:40:00Z'}],metrics:[],scope:'test-organization'}};
let password='TestOnly-Admin-2026!',logged=false;const requests=[];
const server=createServer(async(req,res)=>{
 const url=new URL(req.url,origin);const path=url.pathname;
 if(path.startsWith('/test-api/')){
  let raw='';for await(const chunk of req)raw+=chunk;const body=raw?JSON.parse(raw):{};
  requests.push({method:req.method,path});res.setHeader('content-type','application/json');
  const send=(status,data)=>{res.writeHead(status);res.end(JSON.stringify(data));};
  if(path.endsWith('/auth/login')){if(body.email==='admin@example.test'&&body.password===password){logged=true;return send(200,{token:'synthetic-admin-token'});}return send(401,{error:'Invalid test credentials'});}
  if(req.headers.authorization!=='Bearer synthetic-admin-token'||!logged)return send(401,{error:'Unauthorized test session'});
  if(path.includes('/governance/reports')){
   const locale=url.searchParams.get('locale')||body.locale||'en',labels=reportRegistry.resources[locale];
   const id=path.split('/')[5];
   const rows=[{page:'Admin Reports',role:'admin',status:labels.created,blockers:'Fixture-only preview'}];
   const report={id:'page_readiness',title:labels.pages,classification:'internal',generatedAt:'2026-10-11T22:00:00Z',scope:'authorized_pages',source:'Synthetic browser fixture',locale,columns:[{key:'page',label:labels.page},{key:'role',label:labels.role}],rows};
   if(path.endsWith('/reports'))return send(200,{reports:[{id:'page_readiness',title:labels.pages,canExport:true,canEmail:true,supportsFilters:true}],resources:labels});
   if(path.endsWith('/pdf')){res.setHeader('content-type','application/pdf');res.end(pdfValid?new PdfReportRenderer().render(report):'{"error":true}');return;}
   if(path.endsWith('/email')){assert.equal(body.confirmed,true);assert.equal(body.to,'recipient@example.test');assert.ok(/^[A-Za-z0-9_-]{16,100}$/.test(req.headers['idempotency-key']));emailKeys.push(req.headers['idempotency-key']);return send(emailOutcome==='accepted'?202:503,{state:emailOutcome});}
   return send(200,report);
  }
  if(path.endsWith('/auth/me'))return send(200,{roles:'admin',email:'admin@example.test'});
  if(path.endsWith('/governance/workspace'))return send(200,fixture);
  if(path.endsWith('/user/change-password')){if(body.currentPassword!==password)return send(400,{error:'Current password is incorrect'});assert.ok(body.newPassword.length>=12);password=body.newPassword;logged=false;return send(200,{message:'Changed test password'});}
  if(path.endsWith('/auth/logout')){logged=false;return send(200,{message:'Signed out'});}
  return send(404,{error:'No test business implementation exists'});
 }
 try{const file=path==='/portal.json'?'portal.json':path.startsWith('/assets/')?path.slice(1):'index.html';res.setHeader('content-type',file.endsWith('.js')?'text/javascript':file.endsWith('.css')?'text/css':file.endsWith('.json')?'application/json':'text/html');res.end(await readFile(join(site,file)));}catch{res.writeHead(404);res.end();}
});
await new Promise(r=>server.listen(4173,'127.0.0.1',r));
const browser=await chromium.launch();const context=await browser.newContext({viewport:{width:1600,height:1000},recordVideo:{dir:join(out,'video'),size:{width:1600,height:1000}},acceptDownloads:true});
const page=await context.newPage();const results=[];let stepNumber=0;const errors=[];page.on('pageerror',e=>errors.push(e.message));
await context.route('**/*',async route=>{assert.equal(new URL(route.request().url()).origin,origin,'External network must never be used');await route.continue();});
await context.addInitScript(()=>{
 const install=()=>{if(document.getElementById('test-caption'))return;const b=document.createElement('div');b.id='test-caption';b.style.cssText='position:fixed;bottom:0;left:0;right:0;z-index:99999;padding:18px 26px;background:#102b46;color:white;font:18px Arial;box-shadow:0 -2px 6px #999';b.textContent=sessionStorage.getItem('test_caption')||'PrimeCare ADMIN | ISOLATED TEST WEBSITE | Synthetic data only';document.body.append(b);};new MutationObserver(install).observe(document,{childList:true,subtree:true});document.addEventListener('DOMContentLoaded',install);
});
async function caption(message){await page.evaluate(m=>{sessionStorage.setItem('test_caption',m);const b=document.getElementById('test-caption');if(b)b.textContent=m;},message);}
async function step(task,instruction,work,status='PASS'){
 const id=++stepNumber;await caption(`${id}. ${task} | ${instruction} | TEST DATA ONLY`);const start=new Date().toISOString();
 try{await work();results.push({step:id,task,instruction,status,time:start});await caption(`${id}. ${task} | ${status} | ${instruction}`);await page.waitForTimeout(2600);await page.screenshot({path:join(out,'screenshots',`${String(id).padStart(2,'0')}.png`),fullPage:false});}catch(e){results.push({step:id,task,instruction,status:'FAIL',error:e.message,time:start});throw e;}
}
try{
 await page.goto(origin+'/login');
 assert.ok((await page.evaluate(()=>getComputedStyle(document.body).fontFamily)).length>0);
 await step('Sign in as admin','Enter the test admin email and password; click Sign in.',async()=>{await page.locator('[data-cy=login-email]').fill('admin@example.test');await page.locator('[data-cy=login-password]').fill(password);await page.waitForTimeout(1500);await page.locator('[data-cy=login-submit]').click();await page.locator('[data-cy=screen-office_dashboard]').waitFor();assert.equal(await page.evaluate(()=>sessionStorage.getItem('primecare_session')),'synthetic-admin-token');});
 await step('Search authorized admin screens','Search Admin Reports and open it from the top bar; unknown records have no results.',async()=>{await page.evaluate(()=>{window.testTopbar=document.querySelector('[data-cy=app-topbar]');window.testSidebar=document.querySelector('[data-cy=app-sidebar]');});await page.locator('[data-cy=universal-search]').fill('Admin Reports');assert.equal(await page.locator('[data-cy=universal-search-result]').count(),1);await page.locator('[data-cy=universal-search-result]').click();await page.locator('[data-cy=screen-admin_reports]').waitFor();assert.ok(await page.evaluate(()=>window.testTopbar===document.querySelector('[data-cy=app-topbar]')&&window.testSidebar===document.querySelector('[data-cy=app-sidebar]')));await page.locator('[data-cy=universal-search]').fill('tenant-secret-not-authorized');assert.equal(await page.locator('[data-cy=universal-search-result]').count(),0);await page.locator('[data-cy=universal-search]').press('Escape');await page.locator('[data-cy=sidebar-item-office_dashboard]').first().click();});
 await step('Review monitoring','Review organization counts, role totals and recent activity.',async()=>{assert.match(await page.locator('[data-cy=workspace-overview]').innerText(),/4/);await page.locator('[data-cy=workspace-activity]').scrollIntoViewIfNeeded();assert.match(await page.locator('[data-cy=workspace-activity]').innerText(),/Synthetic admin test session/);});
 for(const screen of screens){await step(`Open ${screen.name}`,'Select the sidebar page; inspect delivery details and unfinished actions.',async()=>{await page.locator(`[data-cy=sidebar-item-${screen.code}]`).first().click();await page.locator(`[data-cy=screen-${screen.code}]`).waitFor();assert.equal(await page.locator('[data-cy=workspace-title]').innerText(),screen.name);const detail=page.locator(`[data-cy=workspace-delivery] [data-cy=delivery-${screen.code}]`);await detail.locator('summary').click();await detail.scrollIntoViewIfNeeded();assert.match(await detail.innerText(),/API connections/);},screen.productionReady?'PASS':'PAGE PASS / BUSINESS TASK BLOCKED');}
 await step('Search the task inventory','Type admin in Search pages; verify matching entries.',async()=>{await page.locator('[data-cy=workspace-search]').fill('admin');const matches=registry.screens.filter(s=>`${s.name} ${s.role} ${s.appCode} ${s.route}`.toLowerCase().includes('admin'));assert.match(await page.locator('[data-cy=inventory-count]').innerText(),new RegExp('^'+matches.length+' '));});
 await step('Show unfinished work','Select Unfinished work; verify pending records remain visible.',async()=>{await page.locator('[data-cy=workspace-pending]').check();assert.ok(await page.locator('[data-cy=workspace-pending]').isChecked());});
 await step('Download inventory','Click Download inventory; inspect the downloaded CSV.',async()=>{const downloaded=page.waitForEvent('download');await page.locator('[data-cy=workspace-export]').click();const d=await downloaded;assert.equal(d.suggestedFilename(),'PrimeCare-Page-Inventory.csv');await d.saveAs(join(out,d.suggestedFilename()));assert.match(await readFile(join(out,d.suggestedFilename()),'utf8'),/Production ready/);});
 for(const task of ['Create tenant','Create accounts and assign roles','Create master records']){await step(task,'Check the current admin website. No usable business action is wired here.',async()=>{await page.locator('[data-cy=workspace-title]').scrollIntoViewIfNeeded();assert.equal(await page.locator('[data-cy=create-tenant]').count(),0);},'BLOCKED / NOT AVAILABLE IN THIS WEBSITE');}

 await step('Generate an admin report','Open Admin Reports and click Generate; inspect the returned preview.',async()=>{await page.locator('[data-cy=sidebar-item-admin_reports]').first().click();await page.locator('[data-cy=report-generate]').waitFor();await page.locator('[data-cy=report-generate]').click();await page.locator('[data-cy=report-preview]').waitFor();assert.match(await page.locator('[data-cy=report-preview]').innerText(),/Admin Reports/);assert.ok(await page.locator('[data-cy=report-email]').isDisabled());});
 await step('Download report PDF','Click Download PDF and validate the response bytes.',async()=>{const promise=page.waitForEvent('download');await page.locator('[data-cy=report-pdf]').click();const file=await promise;assert.equal(file.suggestedFilename(),'page_readiness.pdf');await file.saveAs(join(out,'report-transport-fixture.pdf'));assert.ok((await readFile(join(out,'report-transport-fixture.pdf'),'utf8')).startsWith('%PDF-'));});
 await step('Reject invalid PDF responses','A non-PDF response must show an error without downloading.',async()=>{pdfValid=false;await page.locator('[data-cy=report-pdf]').click();await page.waitForFunction(()=>document.querySelector('[data-cy=report-status]')?.textContent.includes('failed'));pdfValid=true;});
 await step('Email with recipient consent','Enter test recipient, confirm authority, then submit once.',async()=>{await page.locator('[data-cy=report-recipient]').fill('recipient@example.test');await page.locator('[data-cy=report-subject]').fill('Test report');assert.ok(await page.locator('[data-cy=report-email]').isDisabled());await page.locator('[data-cy=report-confirm]').check();await page.locator('[data-cy=report-email]').click();await page.waitForFunction(()=>document.querySelector('[data-cy=report-status]')?.textContent.includes('accepted'));assert.equal(emailKeys.length,1);assert.ok(await page.locator('[data-cy=report-confirm]').isChecked()===false);});
 await step('Switch report language','Select French, then Spanish; regenerate after language changes.',async()=>{for(const language of ['fr','es','en']){await page.locator('[data-cy=report-language]').selectOption(language);await page.waitForFunction(l=>document.querySelector('[data-cy=report-select]')?.textContent.includes(l),reportRegistry.resources[language].pages);assert.equal(await page.locator('[data-cy=report-preview]').count(),0);await page.locator('[data-cy=report-generate]').click();await page.locator('[data-cy=report-preview]').waitFor();}});
 await step('Keep preview safe after filter changes','Typing a filter clears the old preview and disables export.',async()=>{await page.locator('[data-cy=report-search]').fill('admin');assert.equal(await page.locator('[data-cy=report-preview]').count(),0);assert.ok(await page.locator('[data-cy=report-pdf]').isDisabled());await page.locator('[data-cy=report-generate]').click();await page.locator('[data-cy=report-preview]').waitFor();});
 await step('Block uncertain email resends','Simulate an unknown provider outcome; refresh and confirm sending remains blocked.',async()=>{emailOutcome='unknown';await page.locator('[data-cy=report-confirm]').check();await page.locator('[data-cy=report-email]').click();await page.waitForFunction(()=>document.querySelector('[data-cy=report-status]')?.textContent.includes('unknown'));assert.equal(emailKeys.length,2);await page.reload();await page.locator('[data-cy=report-generate]').waitFor();await page.locator('[data-cy=report-generate]').click();await page.locator('[data-cy=report-preview]').waitFor();await page.locator('[data-cy=report-confirm]').check();assert.ok(await page.locator('[data-cy=report-email]').isDisabled());assert.equal(emailKeys.length,2);});
 await step('Verify mobile report controls','Resize browser to mobile; report controls remain usable without horizontal overflow.',async()=>{await page.setViewportSize({width:390,height:844});await page.locator('[data-cy=shared-reports]').scrollIntoViewIfNeeded();const width=await page.locator('[data-cy=shared-reports]').evaluate(e=>({scroll:e.scrollWidth,client:e.clientWidth}));assert.ok(width.scroll<=width.client+1);await page.setViewportSize({width:1600,height:1000});});
 await step('Change own password','Open Account, enter current and new test passwords, and submit.',async()=>{await page.locator('[data-cy=workspace-account]').click();await page.locator('[data-cy=current-password]').fill(password);await page.locator('[data-cy=new-password]').fill('NewTestOnly-Admin-2026!');await page.waitForTimeout(1500);await page.locator('[data-cy=change-password-submit]').click();await page.locator('[data-cy=login-submit]').waitFor();assert.equal(await page.evaluate(()=>sessionStorage.getItem('primecare_session')),null);});
 await step('Sign in with new password','Enter the new test password and sign in again.',async()=>{await page.locator('[data-cy=login-email]').fill('admin@example.test');await page.locator('[data-cy=login-password]').fill(password);await page.locator('[data-cy=login-submit]').click();await page.locator('[data-cy=screen-office_dashboard]').waitFor();});
 await step('Sign out','Click Sign out; confirm the test session clears.',async()=>{await page.locator('[data-cy=workspace-logout]').click();await page.locator('[data-cy=login-submit]').waitFor();assert.equal(await page.evaluate(()=>sessionStorage.getItem('primecare_session')),null);});
 assert.deepEqual(errors,[]);console.log(`Completed ${results.length} browser steps; ${screens.length} admin pages navigated. Business blockers remain explicit.`);
}finally{
 await writeFile(join(out,'admin-test-results.json'),JSON.stringify({role:'admin',source:'actual TypeScript website source; local fixture API only',screens:screens.map(s=>({code:s.code,name:s.name,route:s.route,productionReady:s.productionReady,blockers:s.blockers,pendingActions:s.pendingActions})),results,requests,errors,emailKeys},null,2));
 await writeFile(join(out,'Admin_Task_Test_Log.txt'),results.map(r=>`${r.step}. ${r.task}\nHow: ${r.instruction}\nResult: ${r.status}${r.error?' - '+r.error:''}\n`).join('\n'));
 await context.close();await browser.close();await new Promise(r=>server.close(r));
}
