import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {createServer} from 'node:http';
import {chromium} from 'playwright';
import {tenantFixture} from './tenant-dashboard-fixture.mjs';
const f=await tenantFixture();let browser,server;
try {
 const scope={tenantId:f.tenants[0],userId:f.actors.admin.id,role:f.actors.admin.role,dataset:'live'};
 const bundle=await build({stdin:{contents:`
 import {DashboardPageSession} from './packages/shared/src/dashboard-pages/session.mjs';
 import {renderSupportingPage} from './packages/primecare_ui/web/supporting-pages';
 import {bindDashboardPage} from './packages/primecare_ui/web/dashboard-pages';
 import {dashboardPageTransport} from './websites/typescript/src/tenant-dashboard/dashboard-page-transport';
 const token=${JSON.stringify(f.actors.admin.token)},scope=${JSON.stringify(scope)};
 const labels={title:'Task <overview>',demo:'DEMO',live:'LIVE',denied:'Denied',unavailable:'Unavailable',loading:'Loading',error:'Read failed',idle:'Ready to load',disposed:'Closed',metrics:{open:'Open',review:'Review',blocked:'Blocked',overdue:'Overdue',completed:'Completed'}};
 window.support=kind=>renderSupportingPage(document.querySelector('main'),kind,{invoice:'Invoice <literal>',pricing:'Pricing',authentication:'Account access','coming-soon':'Coming soon',maintenance:'Maintenance',error:'Error',unavailable:'Unavailable','static-coming-soon':'Not activated','static-maintenance':'Presentation only','static-error':'Use approved workflow'});
 window.mount=()=>{window.cleanup?.();sessionStorage.setItem('test-token',token);window.session=new DashboardPageSession('project',scope,dashboardPageTransport(location.origin,token,'live',()=>sessionStorage.getItem('test-token')),()=>scope);window.cleanup=bindDashboardPage(document.querySelector('main'),window.session,labels);};
 `,resolveDir:process.cwd(),loader:'ts'},bundle:true,write:false,format:'iife',platform:'browser'});
 server=createServer(async(req,res)=>{try{
  if(req.url==='/bundle.js'){res.setHeader('content-type','text/javascript');res.end(bundle.outputFiles[0].text);return;}
  if(req.url.startsWith('/v1/governance/tenant-dashboard')){const response=await f.tenantDashboard(new Request('https://fixture'+req.url,{headers:{authorization:req.headers.authorization||''}}),f.env,'/tenant-dashboard',{});res.writeHead(response.status,{'content-type':'application/json'});res.end(await response.text());return;}
  res.setHeader('content-type','text/html');res.end('<!doctype html><html lang="en"><meta charset="utf-8"><main></main><script src="/bundle.js"></script></html>');
 }catch{res.statusCode=500;res.end('Fixture failed');}});
 await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
 browser=await chromium.launch({headless:true});const page=await browser.newPage(),errors=[];page.on('pageerror',e=>errors.push(String(e)));
 await page.goto('http://127.0.0.1:'+server.address().port);
 const mount=async()=>{await page.evaluate(()=>window.mount());await page.waitForFunction(()=>window.session.state.status==='ready');};
 await mount();assert.equal(await page.locator('h2').textContent(),'Task <overview>');assert.equal(await page.locator('overview').count(),0);assert.equal(await page.locator('dt').count(),5);assert.equal(await page.locator('[role=status]').textContent(),'LIVE');
 const count=Number((await f.db.query("SELECT COUNT(*) AS n FROM tenant_work_tasks WHERE tenant_id=$1 AND status NOT IN ('completed','cancelled')",[scope.tenantId])).rows[0].n);assert.equal(await page.locator('dd').first().textContent(),String(count));
 await page.reload();await mount();assert.equal(await page.locator('dd').first().textContent(),String(count));
 await page.setViewportSize({width:360,height:740});assert.equal(await page.locator('dt').count(),5);
 await page.evaluate(async()=>{sessionStorage.removeItem('test-token');await window.session.load();});assert.equal(await page.locator('dd').count(),0);assert.equal(await page.locator('[role=alert]').textContent(),'Denied');
 await page.evaluate(()=>window.cleanup());assert.equal(await page.locator('main').textContent(),'');for(const kind of ['invoice','pricing','authentication','coming-soon','maintenance','error']){await page.evaluate(k=>window.support(k),kind);assert.equal(await page.locator('button,input,a').count(),0);assert.equal(await page.locator('[role=status]').count(),1);}
 assert.equal(await page.locator('literal').count(),0);assert.deepEqual(errors,[]);
 console.log(`PASS dashboard browser: API/SQL/reload counts, literal labels, semantic metrics, small viewport, token denial and teardown (${f.native?'native PostgreSQL':'PGlite PostgreSQL'})`);
}finally{await browser?.close();if(server)await new Promise(resolve=>server.close(resolve));await f.close();}
