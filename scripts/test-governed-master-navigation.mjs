/** Real browser workspace lifecycle; no production hosts, data, writes or credentials. */
import assert from 'node:assert/strict';
import {createServer} from 'node:http';
import {readFile} from 'node:fs/promises';
import {build} from 'esbuild';
import {chromium} from 'playwright';

const {screens}=JSON.parse(await readFile('cloudflare/workers/src/workspace-registry.json','utf8'));
const generic=screens.filter(p=>p.renderer==='dashboard'&&!['care_delivery','founder_growth_dashboard'].includes(p.code));
const businessDevelopment=process.env.PRIMECARE_WORKSPACE_BD_FIXTURE==='1';
const client=process.env.PRIMECARE_WORKSPACE_CLIENT_FIXTURE==='1';
const clientCohorts=client?JSON.parse(await readFile('websites/typescript/src/dashboard-activation.json','utf8')).cohorts:[];
const clientSecond=clientCohorts.some(c=>c.id==='client-02');
const clientFourth=clientCohorts.find(c=>c.id==='client-04');
const clientThird=clientCohorts.some(c=>c.id==='client-03');
const clinic=process.env.PRIMECARE_WORKSPACE_CLINIC_FIXTURE==='1';
const clinicCohort=clinic?JSON.parse(await readFile('websites/typescript/src/dashboard-activation.json','utf8')).cohorts.findLast(c=>['clinic-02','clinic-03'].includes(c.id)):undefined;
assert.ok([businessDevelopment,client,clinic].filter(Boolean).length<=1);
const project=businessDevelopment?'primecare-business-development':client?'primecare-client':clinic?'primecare-clinic':'primecare-corporate';
const appCode=businessDevelopment?'bd':client?'cl':clinic?'ci':'co';
const [first,second,held]=(
  businessDevelopment?['business_development_dashboard','head_of_bus_dev_dashboard','owner_dashboard']:
  clientFourth?['employee_dashboard','volunteer_dashboard','training_dashboard']:
  clientThird?['course_architect_dashboard','training_hub_dashboard','training_dashboard']:
  clientSecond?['general_manager_dashboard','operations_manager_dashboard','training_dashboard']:
  client?['customer_support_dashboard','dynamic_screen_dashboard','training_dashboard']:
  clinic?['chiropractor_dashboard','physiotherapist_dashboard','rmt_dashboard']:
  ['architecture_planning_dashboard','ceo_dashboard','owner_dashboard']
).map(code=>generic.find(p=>p.code===code));
const heldUsesMaster=Boolean(clientFourth)||(!businessDevelopment&&!client&&!clinic);
const mismatch={...generic.find(p=>p.code==='coo_dashboard'),appCode:'su'};
const record=screens.find(p=>businessDevelopment?p.code==='franchise_lead':p.renderer==='governed_page'&&p.route.startsWith('/management/')&&!p.route.startsWith('/management/tenant'));
const denied=generic.find(p=>p.code===(clientThird?'quality_assurance_dashboard':clientSecond?'regional_bdm_dashboard':client?'family_member_dashboard':clinic?'rn_dashboard':'cfo_dashboard'));
const extra=((clientFourth??clinicCohort)?.dashboards??[]).filter(row=>![first,second,held].some(p=>p.code===row.code))
  .map(row=>generic.find(p=>p.appCode===row.appCode&&p.code===row.code&&p.route===row.route));
const authorized=[first,second,held,mismatch,record,...extra].map(p=>({...p,sections:[],blockers:[]}));
assert.ok(denied&&authorized.every(p=>typeof p.route==='string'));
const token='fixture-authorized-token';
const projection={identity:{userId:'fixture-user',role:'rmt'},landing:first.route,screens:authorized,
  inventory:[...authorized,{...denied,sections:[],blockers:[]}],actions:[],resources:{},overview:{
    activeAccounts:1,activeSessions:1,accountRoles:[],activity:[],metrics:[],scope:'personal'}};
const scripts=await build({stdin:{resolveDir:process.cwd(),contents:`
  import {installDashboardActivation} from './websites/typescript/src/dashboard-activation';
  import {renderWorkspace} from './websites/typescript/src/workspace';
  import {resolveManagedRoute} from './websites/typescript/src/managed-routes';
  import {installPortalPresentation} from './websites/typescript/src/screen-presentation';
  import {tenantPresentationTheme} from './scripts/fixtures/tenant-presentation-theme';
  import {assertMasterDashboardShell} from './packages/primecare_ui/web/dashboard-render-policy';
  const root=document.querySelector('#app');
  installDashboardActivation(root,${JSON.stringify(project)},${JSON.stringify(appCode)});
  const manager=installPortalPresentation(root,tenantPresentationTheme,location.origin);
  manager.registerScope('entry',[resolveManagedRoute(location.pathname,'')]);
  window.strictShell=()=>{try{assertMasterDashboardShell(root);return false;}catch(error){
    if(!String(error).includes('must extend MasterDashboard'))throw error;
    return true;
  }};
  window.begin=()=>renderWorkspace(root,location.origin);
`},bundle:true,write:false,format:'iife'});
const css=await readFile('websites/typescript/src/styles.css');
let workspaceReads=0;
const unexpected=[];
const server=createServer(async(req,res)=>{
  const path=new URL(req.url,'http://fixture.invalid').pathname;
  if(path.startsWith('/v1/')){
    res.setHeader('content-type','application/json');
    if(path==='/v1/governance/workspace'&&req.method==='GET'){
      workspaceReads++;
      if(req.headers.authorization==='Bearer '+token){res.end(JSON.stringify(projection));return;}
      res.statusCode=401;res.end(JSON.stringify({error:'Unauthorized'}));return;
    }
    // Optional copy/navigation/theme reads need no service in this fixture.
    // Writes to any other path are unexpected, not silently stubbed.
    if(req.method!=='GET'&&req.method!=='HEAD'){
      let body='';for await(const part of req)body+=part;
      let read=false;try{read=path==='/v1/user/preferences'&&JSON.parse(body).action==='read';}catch{}
      if(!read)unexpected.push({method:req.method,path});
    }
    res.statusCode=404;res.end('{}');return;
  }
  if(path==='/app.js'){res.setHeader('content-type','text/javascript');res.end(scripts.outputFiles[0].text);return;}
  if(path==='/style.css'){res.setHeader('content-type','text/css');res.end(css);return;}
  res.setHeader('content-type','text/html');
  res.end(path==='/login'?'<!doctype html><h1>Fixture sign-in</h1>':
    '<!doctype html><html lang="fr"><meta name="viewport" content="width=device-width, initial-scale=1"><link rel="stylesheet" href="/style.css"><div id="app"></div><script src="/app.js"></script><script>window.begin()</script></html>');
});
await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
let browser;
try{
  browser=await chromium.launch({headless:true,...(process.env.PRIMECARE_CHROMIUM_EXECUTABLE?{
    executablePath:process.env.PRIMECARE_CHROMIUM_EXECUTABLE,args:['--no-sandbox','--disable-dev-shm-usage']}: {})});
  const context=await browser.newContext();
  const page=await context.newPage(),errors=[];
  page.on('pageerror',error=>errors.push(error.message));
  const origin='http://127.0.0.1:'+server.address().port;
  await page.addInitScript(token=>{
    if(!sessionStorage.getItem('fixture-initialized')){
      sessionStorage.setItem('fixture-initialized','yes');
      sessionStorage.setItem('primecare_session',token);
    }
  },token);
  page.setDefaultTimeout(6500);
  const byId=id=>page.locator('[data-cy="'+id+'"]');
  const visit=async(target,strict)=>{
    await byId('screen-'+target.code).waitFor({state:'attached'});
    assert.equal(new URL(page.url()).pathname,target.route);
    assert.equal(await page.evaluate(()=>window.strictShell()),strict);
    assert.equal(await byId('appearance-open').count(),1);
    assert.equal(await page.locator('html').getAttribute('lang'),'fr');
  };
  await page.goto(origin+first.route+'?locale=fr&enable-semantics=true');
  await visit(first,true);
  const appearance=await byId('appearance-open').getAttribute('aria-label');
  const tokenBefore=await page.locator('html').evaluate(el=>getComputedStyle(el).getPropertyValue('--color-primary'));
  assert.ok(tokenBefore.trim(),'fixture should actually install a theme token');
  await page.evaluate(code=>{window.staleLink=document.querySelector('[data-cy="sidebar-item-'+code+'"]');},record.code);
  await page.evaluate(code=>document.querySelector('[data-cy="sidebar-item-'+code+'"]').click(),second.code);
  await visit(second,true);
  await page.evaluate(()=>window.staleLink.click());
  await visit(second,true);
  await page.evaluate(code=>document.querySelector('[data-cy="sidebar-item-'+code+'"]').click(),record.code);
  await visit(record,false);
  assert.equal(await byId('appearance-open').getAttribute('aria-label'),appearance);
  assert.equal(await page.locator('html').evaluate(el=>getComputedStyle(el).getPropertyValue('--color-primary')),tokenBefore);
  await page.goBack();await visit(second,true);
  await page.goBack();await visit(first,true);
  await page.goForward();await visit(second,true);
  await page.goForward();await visit(record,false);
  await page.evaluate(code=>document.querySelector('[data-cy="sidebar-item-'+code+'"]').click(),held.code);
  await visit(held,heldUsesMaster);
  await page.evaluate(code=>document.querySelector('[data-cy="sidebar-item-'+code+'"]').click(),mismatch.code);
  await visit(mismatch,false);
  await page.goBack();await visit(held,heldUsesMaster);
  await page.goBack();await visit(record,false);
  assert.equal(workspaceReads,1,'same-document navigation should not reload or replace the projection');

  await page.evaluate(route=>{history.pushState({},'',route);window.dispatchEvent(new PopStateEvent('popstate'));},denied.route);
  await byId('error-state').waitFor();
  assert.equal(await byId('screen-'+denied.code).count(),0);
  assert.equal(await page.evaluate(()=>window.strictShell()),false);
  await page.goBack();await visit(record,false);
  await page.goBack();await visit(second,true);
  for(const target of extra){
    await page.evaluate(code=>document.querySelector('[data-cy="sidebar-item-'+code+'"]').click(),target.code);
    await visit(target,true);
  }
  await page.evaluate(()=>{
    sessionStorage.setItem('primecare_session','expired-fixture-token');
    window.dispatchEvent(new PopStateEvent('popstate'));
  });
  await page.waitForURL(/\/login\?/);
  assert.match(await page.locator('h1').textContent(),/Fixture sign-in/);
  assert.equal(workspaceReads,2,'the reloaded document must recheck a replaced session with its API');
  assert.deepEqual(unexpected,[]);
  assert.deepEqual(errors,[]);
  console.log(JSON.stringify({project,dashboardRoutes:[first.route,second.route],ordinaryRoute:record.route,heldDashboard:held.code,heldUsesMaster,appCodeMismatchLegacy:true,inventoryOnlyDenied:true,
    retiredControl:true,backForward:true,themeAndLocaleParity:true,sessionRechecked:true,productionVerified:false}));
}finally{
  await browser?.close();
  await new Promise(resolve=>server.close(resolve));
}
