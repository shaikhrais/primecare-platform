import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {createServer} from 'node:http';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {createRequire} from 'node:module';
import {chromium} from 'playwright';
import {tenantFixture} from './tenant-dashboard-fixture.mjs';
const f=await tenantFixture();let browser,server,lastPage,writes=0,checks=0;
try{
 await f.call('admin',{action:'create',value:{title:'Read host SQL task',ownerId:f.actors.psw.id,dueOn:'2026-11-13',priority:'normal',flowId:'fixture.tenant.process',notes:'Read-only host evidence'}});
 const bundle=await build({stdin:{contents:`import {renderTenantDashboard} from './websites/typescript/src/tenant-dashboard';import {installPortalPresentation} from './websites/typescript/src/screen-presentation';import {resolveManagedRoute} from './websites/typescript/src/managed-routes';import {tenantPresentationTheme} from './scripts/fixtures/tenant-presentation-theme';const root=document.querySelector('#app'),manager=installPortalPresentation(root,tenantPresentationTheme,location.origin);manager.registerScope('entry',[resolveManagedRoute('/tenant-dashboard','')]);window.render=()=>renderTenantDashboard(root,location.origin);`,resolveDir:process.cwd()},bundle:true,format:'iife',write:false});
 server=createServer(async(req,res)=>{try{
  if(req.url==='/style.css'){res.setHeader('content-type','text/css');res.end(await readFile('websites/typescript/src/styles.css'));return;}
  if(req.url==='/app.js'){res.setHeader('content-type','text/javascript');res.end(bundle.outputFiles[0].text);return;}
  if(req.url.startsWith('/v1/')){if(req.method!=='GET')writes++;const reply=await f.tenantDashboard(new Request('https://fixture'+req.url,{headers:new Headers(req.headers)}),f.env,'/tenant-dashboard',{});res.writeHead(reply.status,{'content-type':'application/json'});res.end(await reply.text());return;}
  res.setHeader('content-type','text/html');res.end('<!doctype html><html><head><link rel="stylesheet" href="/style.css"></head><body><div id="app"></div><script src="/app.js"></script><script>document.documentElement.lang=new URLSearchParams(location.search).get("locale")||"en";window.render()</script></body></html>');
 }catch(error){console.error(error);res.writeHead(500);res.end();}});await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
 const origin='http://127.0.0.1:'+server.address().port;browser=await chromium.launch(process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH?{executablePath:process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH,args:['--no-sandbox','--disable-dev-shm-usage']}: {});const context=await browser.newContext();await context.addInitScript(token=>sessionStorage.setItem('primecare_session',token),f.actors.admin.token);const page=await context.newPage(),errors=[];lastPage=page;page.on('pageerror',error=>errors.push(error.message));
 const eventActions=(await f.db.query('SELECT action FROM tenant_dashboard_events WHERE tenant_id=$1 ORDER BY created_at DESC,id',[f.tenants[0]])).rows.map(row=>row.action);
 const count=Number((await f.db.query("SELECT count(*) AS n FROM tenant_work_tasks WHERE tenant_id=$1 AND status NOT IN ('completed','cancelled')",[f.tenants[0]])).rows[0].n);
 const artifactDir='artifacts/tenant-read-accessibility';await mkdir(artifactDir,{recursive:true});
 for(const [locale,width] of [['en',320],['fr',768],['es',1440]]){
  await page.setViewportSize({width,height:900});
  for(const kind of ['project','analytics','activity','search']){
   await page.goto(origin+'/tenant-dashboard?readPage='+kind+'&locale='+locale+'#overview');
   const host=page.locator('[data-pc-tenant-read-host="'+kind+'"]');await host.waitFor();
   assert.equal(await host.locator('[data-cy="dashboard-pages-'+kind+'"]').count(),1);
   if(kind==='project')assert.equal(await host.locator('dd').first().innerText(),String(count));
   if(kind==='search')assert.match(await host.innerText(),/Read host SQL task/);
   if(kind==='activity')assert.deepEqual(await host.locator('li strong').allTextContents(),eventActions);
   assert.equal(await host.locator('button,input,textarea,select').count(),0,'read-only projection does not invent actions');
   assert.equal(await host.evaluate(el=>el.getBoundingClientRect().right<=innerWidth+1),true,'read view fits the viewport');
   await audit(locale,kind,host);checks++;
   // The existing refresh must remain reachable and operable without a pointer.
   const refresh=page.locator('[data-cy=tenant-refresh]');await refresh.focus();assert.equal(await refresh.evaluate(el=>el===document.activeElement),true);
   await host.evaluate(el=>window.__previousReadHost=el);
   await page.keyboard.press('Enter');await page.waitForFunction(()=>{const host=document.querySelector('[data-pc-tenant-read-host]');return host&&host!==window.__previousReadHost;});assert.equal(await host.count(),1);
   await page.reload();await host.waitFor();checks++;
  }
  await page.goto(origin+'/tenant-dashboard?readPage=search&readQuery=missing-record&locale='+locale+'#overview');
  const empty=page.locator('[data-pc-tenant-read-host=search]');await empty.waitFor();assert.equal(await empty.locator('li').count(),0);await audit(locale,'search-empty',empty);checks++;
 }
 async function audit(locale,state,host){
  await page.addScriptTag({path:createRequire(import.meta.url).resolve('axe-core/axe.min.js')});
  const result=await host.evaluate(async element=>window.axe.run(element,{runOnly:{type:'tag',values:['wcag2a','wcag2aa','wcag21a','wcag21aa','wcag22aa']}}));
  await writeFile(`${artifactDir}/${locale}-${state}.json`,JSON.stringify(result,null,2));
  await page.screenshot({path:`${artifactDir}/${locale}-${state}.png`,fullPage:true});
  console.log('TENANT_READ_A11Y '+JSON.stringify({locale,state,width:page.viewportSize().width,violations:result.violations.length,incomplete:result.incomplete.map(v=>v.id)}));
  assert.deepEqual(result.violations.map(v=>({id:v.id,targets:v.nodes.map(n=>n.target)})),[],`${locale} ${state} automated accessibility`);
 }
 await page.evaluate(()=>sessionStorage.setItem('primecare_session','changed'));await page.locator('[data-cy=tenant-refresh]').click();await page.locator('[data-cy=tenant-dashboard-error]').waitFor();assert.equal(await page.locator('[data-pc-tenant-read-host]').count(),0);checks++;
 assert.equal(writes,0);assert.deepEqual(errors,[]);console.log(`PASS tenant read accessibility: ${checks} browser groups, four projections, 15 scoped WCAG audits, SQL count, keyboard refresh, reload, empty search, EN/FR/ES widths and token teardown; zero writes (${f.native?'native PostgreSQL':'PGlite PostgreSQL'})`);
}catch(error){if(lastPage)console.error('READ_HOST_DIAGNOSTICS '+JSON.stringify(await lastPage.evaluate(()=>({url:location.href,text:document.body.innerText.slice(0,5000)})).catch(()=>({closed:true}))));throw error;}finally{await browser?.close();if(server)await new Promise(resolve=>server.close(resolve));await f.close();}
