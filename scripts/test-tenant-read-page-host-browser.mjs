import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {createServer} from 'node:http';
import {chromium} from 'playwright';
import {tenantFixture} from './tenant-dashboard-fixture.mjs';
const f=await tenantFixture();let browser,server,writes=0,checks=0;
try{
 await f.call('admin',{action:'create',value:{title:'Read host SQL task',ownerId:f.actors.psw.id,dueOn:'2026-11-13',priority:'normal',flowId:'fixture.tenant.process',notes:'Read-only host evidence'}});
 const bundle=await build({stdin:{contents:`import {renderTenantDashboard} from './websites/typescript/src/tenant-dashboard';import {installPortalPresentation} from './websites/typescript/src/screen-presentation';import {resolveManagedRoute} from './websites/typescript/src/managed-routes';import {tenantPresentationTheme} from './scripts/fixtures/tenant-presentation-theme';const root=document.querySelector('#app'),manager=installPortalPresentation(root,tenantPresentationTheme,location.origin);manager.registerScope('entry',[resolveManagedRoute('/tenant-dashboard','')]);window.render=()=>renderTenantDashboard(root,location.origin);`,resolveDir:process.cwd()},bundle:true,format:'iife',write:false});
 server=createServer(async(req,res)=>{try{
  if(req.url==='/app.js'){res.setHeader('content-type','text/javascript');res.end(bundle.outputFiles[0].text);return;}
  if(req.url.startsWith('/v1/')){if(req.method!=='GET')writes++;const reply=await f.tenantDashboard(new Request('https://fixture'+req.url,{headers:new Headers(req.headers)}),f.env,'/tenant-dashboard',{});res.writeHead(reply.status,{'content-type':'application/json'});res.end(await reply.text());return;}
  res.setHeader('content-type','text/html');res.end('<!doctype html><html><body><div id="app"></div><script src="/app.js"></script><script>document.documentElement.lang=new URLSearchParams(location.search).get("locale")||"en";window.render()</script></body></html>');
 }catch(error){console.error(error);res.writeHead(500);res.end();}});await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
 const origin='http://127.0.0.1:'+server.address().port;browser=await chromium.launch(process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH?{executablePath:process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH,args:['--no-sandbox','--disable-dev-shm-usage']}: {});const context=await browser.newContext();await context.addInitScript(token=>sessionStorage.setItem('primecare_session',token),f.actors.admin.token);const page=await context.newPage(),errors=[];page.on('pageerror',error=>errors.push(error.message));
 const count=Number((await f.db.query("SELECT count(*) AS n FROM tenant_work_tasks WHERE tenant_id=$1 AND status NOT IN ('completed','cancelled')",[f.tenants[0]])).rows[0].n);
 for(const kind of ['project','analytics','activity','search']){
  await page.goto(origin+'/tenant-dashboard?readPage='+kind+'#overview');const host=page.locator('[data-pc-tenant-read-host="'+kind+'"]');await host.waitFor();assert.equal(await host.locator('[data-cy="dashboard-pages-'+kind+'"]').count(),1);assert.equal(await page.locator('[data-cy=tenant-refresh]').isVisible(),true);
  if(kind==='project')assert.equal(await host.locator('dd').first().innerText(),String(count));
  if(kind==='search')assert.match(await host.innerText(),/Read host SQL task/);
  if(kind==='activity')assert.match(await host.innerText(),/task_created/);
  await page.reload();await host.waitFor();checks++;
 }
 await page.goto(origin+'/tenant-dashboard?readPage=search&readQuery=missing-record#overview');await page.locator('[data-cy=dashboard-pages-search]').waitFor();assert.equal(await page.locator('[data-cy=dashboard-pages-search] li').count(),0);checks++;
 await page.goto(origin+'/tenant-dashboard?readPage=activity&locale=fr#overview');await page.locator('[data-cy=dashboard-pages-activity]').waitFor();assert.match(await page.locator('[data-cy=dashboard-pages-activity]').innerText(),/Donn/);checks++;
 await page.evaluate(()=>sessionStorage.setItem('primecare_session','changed'));await page.locator('[data-cy=tenant-refresh]').click();await page.locator('[data-cy=tenant-dashboard-error]').waitFor();assert.equal(await page.locator('[data-pc-tenant-read-host]').count(),0);checks++;
 assert.equal(writes,0);assert.deepEqual(errors,[]);console.log(`PASS tenant read host: ${checks} browser groups, four projections, SQL count, reload, bounded search, localization and token teardown; zero writes (${f.native?'native PostgreSQL':'PGlite PostgreSQL'})`);
}finally{await browser?.close();if(server)await new Promise(resolve=>server.close(resolve));await f.close();}
