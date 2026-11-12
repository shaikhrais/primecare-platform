import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {createServer} from 'node:http';
import {chromium} from 'playwright';
import {tenantFixture} from './tenant-dashboard-fixture.mjs';
const f=await tenantFixture();let browser,server;let checks=0;
try{
 const created=await f.call('admin',{action:'create',value:{title:'Browser task <literal>',ownerId:f.actors.psw.id,dueOn:'2026-11-05',priority:'normal',flowId:'fixture.tenant.process',notes:'Original browser instructions'}});assert.equal(created.status,200);const item=(await created.json()).tasks.find(x=>x.title==='Browser task <literal>');assert.ok(item);
 const scope={tenantId:f.tenants[0],userId:f.actors.admin.id,role:f.actors.admin.role,dataset:'live'};
 const bundle=await build({stdin:{contents:`import {PrimeWorkModule} from './packages/primecare_ui/web/work-modules';import {WorkModuleSession} from './packages/shared/src/work-modules/session';import {TenantTaskModulePort} from './packages/shared/src/work-modules/tenant-task-adapter';import {tenantTaskModuleTransport} from './websites/typescript/src/tenant-dashboard/work-module-transport';window.mount=(module,locale='en',firstWeekday=1)=>{window.view?.dispose();window.session?.dispose();sessionStorage.setItem('primecare_session',${JSON.stringify(f.actors.admin.token)});window.session=new WorkModuleSession(${JSON.stringify(scope)},module,new TenantTaskModulePort(${JSON.stringify(scope)},module,tenantTaskModuleTransport(location.origin,${JSON.stringify(f.actors.admin.token)})));window.writes=0;const port=window.session.port,mutate=port.mutate.bind(port),readItem=port.readItem.bind(port);port.mutate=async(...args)=>{window.writes++;return mutate(...args);};port.readItem=async(...args)=>{if(window.loseVerification){window.loseVerification=false;throw Error('verification offline');}return readItem(...args);};window.view=new PrimeWorkModule(document.querySelector('main'),window.session,{locale,year:2026,month:11,firstWeekday});};`,resolveDir:process.cwd(),loader:'ts'},bundle:true,write:false,platform:'browser',format:'iife'});
 server=createServer(async(req,res)=>{try{if(req.url==='/bundle.js'){res.setHeader('content-type','text/javascript');res.end(bundle.outputFiles[0].text);return;}if(req.url.startsWith('/v1/governance/tenant-dashboard')){const chunks=[];for await(const c of req)chunks.push(c);const body=Buffer.concat(chunks).toString(),r=await f.tenantDashboard(new Request('https://fixture/tenant-dashboard'+new URL(req.url,'http://localhost').search,{method:req.method,headers:{authorization:req.headers.authorization||'',...(body?{'content-type':'application/json','idempotency-key':req.headers['idempotency-key']||''}:{})},...(body?{body}:{})}),f.env,'/tenant-dashboard',{});res.writeHead(r.status,{'content-type':'application/json'});res.end(await r.text());return;}res.setHeader('content-type','text/html');res.end('<!doctype html><html><head><meta charset="utf-8"><style>:root{--spacing-unit:8px;--spacing-sm:8px;--spacing-md:16px;--border-width:1px;--control-min-height:44px;--color-text:#172033;--color-surface:white;--color-border:#aaa;--radius-md:6px;--color-primary:#2457aa;--color-error:#a02020}body{font:16px sans-serif}</style></head><body><main></main><script src="/bundle.js"></script></body></html>');}catch(e){res.statusCode=500;res.end(String(e));}});await new Promise(r=>server.listen(0,'127.0.0.1',r));
 browser=await chromium.launch({headless:true,...(process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH?{executablePath:process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH,args:['--no-sandbox','--disable-dev-shm-usage','--use-gl=angle','--use-angle=swiftshader','--enable-unsafe-swiftshader']}: {})});
 const page=await browser.newPage({viewport:{width:1200,height:900}}),errors=[];page.on('pageerror',e=>errors.push(String(e)));await page.goto('http://127.0.0.1:'+server.address().port);
 async function mount(module){await page.evaluate(m=>window.mount(m),module);await page.waitForFunction(()=>window.session.status==='ready');assert.equal(await page.locator('[data-cy="work-modules-create"]').isDisabled(),true);checks++;}
 async function open(){await page.locator('[data-cy^="work-modules-open-"]').first().click();await page.locator('[data-cy="work-modules-detail"]').waitFor();}
 async function save(){await page.locator('[data-cy="work-modules-save"]').click();await page.waitForFunction(()=>window.session.status!=='saving');assert.equal(await page.evaluate(()=>window.session.status),'success',JSON.stringify(await page.evaluate(()=>window.session.current)));checks++;}
 await mount('tasks');await open();await page.locator('[data-cy="work-modules-action"]').selectOption('edit');await page.locator('[data-cy="work-modules-title"]').fill('x');await page.locator('[data-cy="work-modules-body"]').fill('Retained draft from browser');await page.locator('[data-cy="work-modules-save"]').click();await page.waitForFunction(()=>window.session.status==='invalid');assert.equal(await page.locator('[data-cy="work-modules-body"]').inputValue(),'Retained draft from browser');checks++;
 // Internal navigation must preserve unsaved editor input.
 const dirtyTitle=await page.locator('[data-cy="work-modules-title"]').inputValue();
 await page.locator('[data-cy="work-modules-reload"]').click();
 assert.equal(await page.locator('[data-cy="work-modules-title"]').inputValue(),dirtyTitle);checks++;
 await page.locator('[data-cy^="work-modules-open-"]').first().click();
 assert.equal(await page.locator('[data-cy="work-modules-body"]').inputValue(),'Retained draft from browser');checks++;
 await page.locator('[data-cy="work-modules-filter"]').fill('discard-risk');
 await page.locator('[data-cy="work-modules-filter"]').dispatchEvent('change');
 assert.equal(await page.locator('[data-cy="work-modules-body"]').inputValue(),'Retained draft from browser');
 assert.equal(await page.evaluate(()=>window.session.current.query.search),'');checks++;
 await page.locator('[data-cy="work-modules-title"]').fill('Browser renamed task <literal>');await save();assert.equal(await page.locator('literal').count(),0);checks++;
 // Keep the original pending action visible and retry verification without a second write.
 await open();await page.locator('[data-cy="work-modules-action"]').selectOption('edit');
 await page.locator('[data-cy="work-modules-title"]').fill('Verified browser recovery');
 const writesBefore=await page.evaluate(()=>window.writes);await page.evaluate(()=>window.loseVerification=true);
 await page.locator('[data-cy="work-modules-save"]').click();await page.waitForFunction(()=>window.session.status==='error');
 assert.equal(await page.locator('[data-cy="work-modules-reload"]').isDisabled(),true);
 assert.equal(await page.locator('[data-cy="work-modules-title"]').isDisabled(),true);
 assert.equal(await page.locator('[data-cy="work-modules-title"]').inputValue(),'Verified browser recovery');
 await page.locator('[data-cy="work-modules-save-pending"]').click();await page.waitForFunction(()=>window.session.status==='success');
 assert.equal(await page.evaluate(()=>window.writes),writesBefore+1);checks++;
 await mount('notes');await open();await page.locator('[data-cy="work-modules-body"]').fill('Saved browser task instructions');await save();
 for(const locale of ['en','fr','es'])for(const firstWeekday of [0,1]){
  await page.evaluate(({locale,firstWeekday})=>window.mount('calendar',locale,firstWeekday),{locale,firstWeekday});await page.waitForFunction(()=>window.session.status==='ready');
  const headings=page.locator('[data-work-weekday]');assert.equal(await headings.count(),7);
  const expected=new Intl.DateTimeFormat(locale,{weekday:'long',timeZone:'UTC'}).format(new Date(firstWeekday===0?'2026-11-01T00:00:00Z':'2026-10-26T00:00:00Z'));
  assert.equal(await headings.first().getAttribute('aria-label'),expected);
  assert.equal(await page.locator('[data-cy="work-modules-date-2026-11-05"]').getAttribute('aria-label'),new Intl.DateTimeFormat(locale,{dateStyle:'full',timeZone:'UTC'}).format(new Date('2026-11-05T00:00:00Z')));
  await page.setViewportSize({width:320,height:900});await page.evaluate(()=>document.querySelector('main').style.fontSize='200%');
  assert.equal(await headings.evaluateAll(nodes=>new Set(nodes.map(n=>Math.round(n.getBoundingClientRect().top))).size),1);
  assert.equal(await page.locator('[data-cy^="work-modules-date-2026-"]').count(),42);assert.equal(await page.evaluate(()=>window.writes),0);checks++;
 }
 await page.setViewportSize({width:1200,height:900});await page.evaluate(()=>document.querySelector('main').style.fontSize='');
 await mount('calendar');assert.equal(await page.locator('[data-cy^="work-modules-date-2026-"]').count(),42);checks++;await open();await page.locator('[data-cy="work-modules-date"]').fill('2026-11-09');await save();
 await mount('board');await open();await page.locator('[data-cy="work-modules-action"]').selectOption('start');await page.locator('[data-cy="work-modules-body"]').fill('Browser authorized start evidence');await save();
 await mount('contacts');await open();assert.equal(await page.locator('[data-cy="work-modules-save"]').count(),0);checks++;
 const row=(await f.db.query('SELECT title,notes,due_on::text,status,version FROM tenant_work_tasks WHERE id=$1',[item.id])).rows[0];assert.deepEqual(row,{title:'Verified browser recovery',notes:'Saved browser task instructions',due_on:'2026-11-09',status:'in_progress',version:6});checks++;
 await page.reload();await mount('tasks');assert.ok((await page.locator('main').innerText()).includes(row.title));checks++;
 // An expired/changed host session must clear the old authorized result.
 await page.evaluate(async()=>{sessionStorage.removeItem('primecare_session');await window.session.load();});assert.equal(await page.evaluate(()=>window.session.status),'denied');assert.equal(await page.locator('[data-work-card]').count(),0);checks++;assert.deepEqual(errors,[]);
 console.log(`PASS work modules browser: ${checks} checks; five templates, retained invalid draft, API writes, independent SQL, reload and session denial (${f.native?'native PostgreSQL':'PGlite PostgreSQL'})`);
}finally{await browser?.close();if(server)await new Promise(r=>server.close(r));await f.close();}
