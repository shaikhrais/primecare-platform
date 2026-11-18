import {syntheticCareActivation} from './fixtures/care-dashboard-activation.mjs';
/** Real browser on both Care aliases and all three renderer branches. Synthetic HTTP only. */
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {createServer} from 'node:http';
import {readFile} from 'node:fs/promises';
import {launchCareBrowser} from './care-browser-launch.mjs';
import {seedPersonal} from '../packages/shared/src/psw-personal/core.mjs';
import {seedState} from '../packages/shared/src/psw-workspace/schedule-core.mjs';
import {projectState} from '../packages/shared/src/psw-workspace/actions.mjs';
const host=await build({stdin:{resolveDir:process.cwd(),contents:`
 import {installDashboardActivation} from './websites/typescript/src/dashboard-activation';
 import {renderPSW} from './websites/typescript/src/psw-workspace';
 import {resolveManagedRoute} from './websites/typescript/src/managed-routes';
 import {installPortalPresentation} from './websites/typescript/src/screen-presentation';
 import {assertMasterDashboardShell} from './packages/primecare_ui/web/dashboard-render-policy';
 import {tenantPresentationTheme} from './scripts/fixtures/tenant-presentation-theme';
 const root=document.querySelector('#app');
 if(!new URLSearchParams(location.search).has('fixture-held'))installDashboardActivation(root,'primecare-clinic','ci');
 const manager=installPortalPresentation(root,tenantPresentationTheme,location.origin);
 manager.registerScope('entry',[resolveManagedRoute(location.pathname,'')]);
 window.hasGuard=()=>{try{assertMasterDashboardShell(root);return false;}catch(e){if(!String(e).includes('must extend MasterDashboard'))throw e;return true;}};
 void renderPSW(root,location.origin);
`},bundle:true,plugins:[syntheticCareActivation],write:false,format:'iife'});
const css=await readFile('websites/typescript/src/styles.css');
const server=createServer((req,res)=>{
 const path=new URL(req.url,'http://fixture').pathname;
 if(path==='/fixture.js'){res.setHeader('content-type','text/javascript');res.end(host.outputFiles[0].text);return;}
 if(path==='/style.css'){res.setHeader('content-type','text/css');res.end(css);return;}
 if(path!=='/care'&&path!=='/psw'){res.statusCode=404;res.end('{}');return;}
 res.setHeader('content-type','text/html');res.end('<!doctype html><html lang="en"><meta name="viewport" content="width=device-width, initial-scale=1"><link rel="stylesheet" href="/style.css"><div id="app"></div><script src="/fixture.js"></script>');
});
const identity=role=>({role,userId:'fixture-worker',tenantId:'fixture-tenant',organization:'Fixture tenant'});
const emptyCare={identity:identity('scheduler'),capabilities:{operations:false,verifyClearance:false,qualified:true},
 cases:[],total:0,assignmentTotal:0,view:'all',reviewBacklog:0,concerns:0,overdue:0,offset:0,limit:20,people:[],visits:[],detail:null,
 staffing:{canCreate:false,canManage:false,total:0,records:[],offset:0,limit:20,staffOptions:[],createActions:[]},
 schedules:{canManage:false,series:[]},timesheets:{pending:0,returned:0,total:0,records:[],offset:0,limit:20},
 handovers:{total:0,records:[],offset:0,limit:20},followups:{open:0,late:0,review:0,extensions:0,waiting:0,view:'all',records:[],offset:0,limit:20},workload:null};
const token='c'.repeat(43);
await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
const origin='http://127.0.0.1:'+server.address().port;
let browser;
const cases=[];
try{
 browser=await launchCareBrowser();
 for(const [mode,selector] of [['live','[data-live-refresh]'],['personal','[data-cy=screen-psw-personal-today]'],['demo','#schedule-board']]){
  for(const [path,held] of [['/care',false],['/psw',false],['/care',true]]){
   const width=path==='/care'?390:1440,ctx=await browser.newContext({viewport:{width,height:900}}),page=await ctx.newPage();
   const actor=identity(mode==='personal'?'psw':'scheduler'),info={identity:actor,canManage:true,liveCareAvailable:true,scopes:[]};
   const personal={dataset:'live',personalWorkspace:true,workspaceKey:'fixture-personal',database:'PostgreSQL',synthetic:false,version:7,
    state:seedPersonal(),profile:{name:'Fixture Worker',role:'psw',qualified:true},team:[],windows:[],identity:actor,from:'2026-10-26',today:'2026-10-28'};
   const errors=[],requests=[];
   page.on('pageerror',e=>errors.push(e.message));
   await page.addInitScript(t=>sessionStorage.setItem('primecare_session',t),token);
   await page.route('**/*',route=>{
    const url=new URL(route.request().url());
    if(url.origin!==origin)return route.abort();
    if(!url.pathname.startsWith('/v1/'))return route.continue();
    if(url.pathname==='/v1/governance/care/workspace'||url.pathname==='/v1/governance/care/personal'||url.pathname==='/v1/governance/care'){
     requests.push({path:url.pathname,method:route.request().method(),bearer:route.request().headers().authorization});
     if(url.pathname.endsWith('/personal'))return route.fulfill({json:personal});
     if(url.pathname==='/v1/governance/care')return route.fulfill({json:emptyCare});
     const dataset=url.searchParams.get('dataset');
     if(dataset==='info')return route.fulfill({json:info});
     if(dataset==='demo')return route.fulfill({json:{...info,dataset:'demo',database:'PostgreSQL',synthetic:true,version:7,
      state:projectState(seedState(),{id:actor.userId,roles:actor.role})}});
     return route.fulfill({json:{visits:[],providers:[],from:'2026-11-07',to:'2026-11-07'}});
    }
    return route.fulfill({status:404,json:{}});
   });
   try{
    await page.goto(origin+path+'?dataset='+(mode==='demo'?'demo':'live')+'&enable-semantics=true'+(held?'&fixture-held=1':''));
    await page.locator(selector).waitFor({state:'attached',timeout:6000});
    const guarded=path==='/care'&&!held;
    assert.equal(await page.evaluate(()=>window.hasGuard()),guarded);
    const slot=page.locator('#app > [data-pc-dashboard-content=care_delivery]');
    assert.equal(await slot.count(),guarded?1:0);
    if(guarded){
     assert.equal(await slot.locator(selector).count(),1);
     assert.equal(await slot.evaluate(el=>getComputedStyle(el).display),'contents');
    }
    assert.ok(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1));
    assert.ok(requests.length>=2);assert.ok(requests.every(r=>r.method==='GET'&&r.bearer==='Bearer '+token));
    await page.evaluate(()=>{sessionStorage.setItem('primecare_session','replaced');window.dispatchEvent(new PopStateEvent('popstate'));});
    await page.locator(selector).waitFor({state:'detached'});
    assert.equal(await page.evaluate(()=>window.hasGuard()),false);
    assert.deepEqual(errors,[]);
    cases.push({path,mode,width,held,guarded,sessionReplacementCleared:true});
   }finally{await ctx.close();}
  }
 }
 console.log(JSON.stringify({cases,productionVerified:false}));
}finally{
 await browser?.close();
 await new Promise(resolve=>server.close(resolve));
}
