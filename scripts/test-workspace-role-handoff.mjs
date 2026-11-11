/** Exact role-audit loop with modeled browser protocol; not browser/DB acceptance. */
import {test} from 'node:test';import assert from 'node:assert/strict';import {readFile} from 'node:fs/promises';import {resolve} from 'node:path';
const source=await readFile(process.env.WORKSPACE_AUDIT_SOURCE??resolve('scripts/audit-workspace-role-browser.mjs'),'utf8');
const start=source.indexOf(' for(const [role,pages] of assigned)for(const width of [320,1440]){'),end=source.indexOf('\n report.sharedRendererChecks=',start);assert.ok(start>=0&&end>start);
const loop=source.slice(start,end),cleanupStart=source.indexOf('}finally{\n if(browser)',end);assert.ok(cleanupStart>end);const cleanupSource=source.slice(cleanupStart);
const AsyncFunction=Object.getPrototypeOf(async()=>{}).constructor;
const target={code:'care',route:'/care',renderer:'care',name:'Dedicated care',productionReady:false},shared={code:'structural',route:'/fixture-structure',renderer:'generic',name:'Fixture structure',productionReady:false};
async function probe(failure=null,{race=true}={}){
 const origin='https://fixture.invalid',pages=[],events=[],timers=new Set(),records=[],report={checked:0,samples:[],apiCreatedAccounts:0},queries=[];let persisted;
 const fail=stage=>{if(failure===stage)throw Error('synthetic '+stage);};
 const browser={newPage:async options=>{
  const id=pages.length;fail('new-page');const p={id,closed:false,pendingError:false,handlers:[],listeners:new Map(),width:options.viewport.width,requests:[],requestWaiters:[],sidebar:false,active:null};pages.push(p);events.push(['new',id,p.width]);
  p.on=(event,callback)=>{p.listeners.set(event,callback);return p;};
  p.route=async(match,handler)=>{fail(typeof match==='string'?'origin-route':'dedicated-route');p.handlers.push([match,handler]);events.push(['route',id,typeof match]);if(typeof match==='string')for(const [url,expected]of [[origin+'/asset','continue'],['https://external.invalid/asset','abort']]){let action;await handler({request:()=>({url:()=>url}),continue:async()=>{action='continue';},abort:async()=>{action='abort';}});assert.equal(action,expected);events.push(['origin-check',id,action]);}};
  p.unroute=async(match,handler)=>{const index=p.handlers.findIndex(([m,h])=>m===match&&h===handler);assert.ok(index>=0);p.handlers.splice(index,1);events.push(['unroute',id]);fail('unroute');};
  p.addInitScript=async(fn,token)=>{assert.equal(token,'authorized-fixture-session');assert.ok(fn.toString().includes("sessionStorage.setItem('primecare_session',token)"));p.token=token;events.push(['init',id]);fail('init');};
  p.goto=async url=>{assert.equal(p.closed,false);assert.equal(url,origin+'/success?enable-semantics=true');assert.equal(p.token,'authorized-fixture-session');assert.ok(p.listeners.has('pageerror'));assert.ok(p.handlers.some(([m])=>m==='**/*'));events.push(['goto',id]);if(p.pendingError&&race)throw Error('modeled reset interrupted by chrome-error://chromewebdata/');if(id>0)fail('replacement-goto');if(id>0&&failure==='pageerror')p.listeners.get('pageerror')(Error('synthetic replacement page error'));p.active=null;};
  p.waitForRequest=predicate=>new Promise((resolve,reject)=>{p.requestWaiters.push({predicate,resolve,reject});});
  p.evaluate=async(fn,arg)=>arg?(assert.ok([target.route,shared.route].includes(arg)),arg===target.route?'psw':'workspace'):{overflow:false,heading:shared.name,sections:1,overflowElements:[]};
  p.screenshot=async()=>{};
  p.locator=selector=>({
   isVisible:async()=>p.sidebar,
   waitFor:async()=>{assert.ok(selector==='[data-cy=workspace-title]'||selector==='[data-cy="screen-'+shared.code+'"]');events.push(['ready',id,selector]);if(id>0)fail('replacement-ready');},
   click:async options=>{
    if(selector==='[data-cy=sidebar-toggle]'){p.sidebar=true;return;}if(selector==='[data-cy=sidebar-close]'){p.sidebar=false;return;}
    const code=selector.match(/sidebar-item-([^"\]]+)/)?.[1];assert.ok(code);events.push(['click',id,code]);
    if(code===shared.code){assert.equal(options,undefined);p.active=shared;return;}
    assert.equal(code,target.code);assert.deepEqual(options,{noWaitAfter:true});fail('click');
    const destination=origin+target.route+(failure==='semantics'?'':'?enable-semantics=true'),request={url:()=>destination,isNavigationRequest:()=>true};p.requests.push(request);
    const handler=p.handlers.findLast(([match])=>typeof match==='function'&&match(new URL(destination)))?.[1];assert.ok(handler,'Dedicated request must be intercepted');
    for(const waiter of p.requestWaiters.splice(0)){if(waiter.predicate(request))waiter.resolve(request);else waiter.reject(Error('Unexpected request predicate'));}
    const task=handler({request:()=>request,abort:async()=>{events.push(['abort',id]);fail('abort');if(failure==='stalled-abort')return new Promise(()=>{});p.pendingError=true;},continue:async()=>{throw Error('Dedicated document must not be served');}});
    // Playwright owns the route callback; capture its outcome without making click await it.
    p.routeOutcome=Promise.resolve(task).then(()=>{},error=>{p.routeError=error;});
   },
  });
  p.close=async()=>{if(p.closed)return;p.closed=true;p.pendingError=false;events.push(['close',id]);for(const waiter of p.requestWaiters.splice(0))waiter.reject(Error('request wait cancelled by close'));};
  return p;
 },close:async()=>{events.push(['browser-close']);for(const p of pages)await p.close();}};
 const db={query:async(sql,args)=>{queries.push([sql,args]);return {rows:[{n:0}]};},end:async()=>events.push(['db-end'])};
 const context={browser,origin,assigned:new Map([['fixture_role',[target,shared]]]),tokens:new Map([['fixture_role','authorized-fixture-session']]),assert,records,report,folder:'fixture',db,schema:'fixture_only',writeFile:async(path,text)=>{assert.equal(path,'fixture/results.json');persisted=JSON.parse(text);},console:{log(){}},setTimeout:(fn,ms)=>{assert.equal(ms,10000);const timer=setTimeout(fn,20);timers.add(timer);return timer;},clearTimeout:timer=>{timers.delete(timer);clearTimeout(timer);}};
 let error;try{await new AsyncFunction(...Object.keys(context),'let server,cleanup=false;try{\n'+loop+'\n'+cleanupSource)(...Object.values(context));}catch(value){error=value;}
 await new Promise(resolve=>setImmediate(resolve));assert.equal(timers.size,0);assert.ok(pages.every(p=>p.closed));assert.equal(events.filter(e=>e[0]==='browser-close').length,1);assert.equal(events.filter(e=>e[0]==='db-end').length,1);assert.deepEqual(queries.map(([sql])=>sql),['SET search_path TO public','DROP SCHEMA IF EXISTS fixture_only CASCADE','SELECT COUNT(*)::int AS n FROM pg_namespace WHERE nspname=$1']);assert.equal(persisted.cleanup.verified,true);
 return {error,records,report,pages,events};
}
test('late error-document navigation cannot interrupt the next audit target',async()=>{
 const result=await probe();assert.equal(result.error,undefined);assert.equal(result.report.checked,4);
 assert.deepEqual(result.records.map(r=>[r.code,r.width,r.coverage]),[['care',320,'dedicated-route-handoff'],['structural',320,'shared-renderer-structure'],['care',1440,'dedicated-route-handoff'],['structural',1440,'shared-renderer-structure']]);
 assert.ok(result.records.filter(r=>r.coverage==='dedicated-route-handoff').every(r=>r.handoffPass===true&&r.structuralPass===null&&r.dedicatedRendererAcceptance==='not_tested'));
 assert.equal(result.pages.length,4);for(const p of result.pages){assert.equal(p.token,'authorized-fixture-session');assert.deepEqual(result.events.filter(e=>e[0]==='origin-check'&&e[1]===p.id).map(e=>e[2]),['continue','abort']);assert.equal(result.events.filter(e=>e[0]==='goto'&&e[1]===p.id).length,1);}
 for(const p of result.pages.filter(p=>p.requests.length)){const close=result.events.findIndex(e=>e[0]==='close'&&e[1]===p.id),next=result.events.findIndex(e=>e[0]==='new'&&e[1]===p.id+1);assert.ok(close<next);}
});
if(!process.env.WORKSPACE_HANDOFF_NEGATIVE_ONLY){
 test('non-racing handoff retains all targets without claiming dedicated acceptance',async()=>{const r=await probe(null,{race:false});assert.equal(r.error,undefined);assert.equal(r.records.length,4);});
 for(const failure of ['new-page','origin-route','init','dedicated-route','click','abort','stalled-abort','semantics','unroute','replacement-goto','replacement-ready'])test('role audit preserves failure and cleanup: '+failure,{timeout:1000},async()=>{
  const r=await probe(failure);assert.ok(r.error);if(failure==='stalled-abort')assert.match(r.error.message,/Dedicated document abort did not complete/);else if(failure==='semantics'){assert.equal(r.error.code,'ERR_ASSERTION');assert.equal(r.error.expected,'true');}else assert.match(r.error.message,new RegExp('synthetic '+failure));
  assert.ok(r.records.length<=1);if(!['unroute','replacement-goto','replacement-ready'].includes(failure))assert.equal(r.report.checked,0);
 });
 test('replacement pages retain the shared pageerror diagnostic gate',async()=>{const r=await probe('pageerror');assert.equal(r.error?.code,'ERR_ASSERTION');assert.match(r.error.message,/No page errors for fixture_role/);assert.deepEqual(r.error.actual,['synthetic replacement page error']);assert.equal(r.records.length,2);});
 test('real workflow runs the exact handoff contract and retains workspace path trigger',async()=>{const workflow=await readFile('.github/workflows/growth-marketing.yml','utf8');assert.match(workflow,/node --test scripts\/test-platform-browser-fixture\.mjs scripts\/test-growth-browser-contracts\.mjs scripts\/test-workspace-role-handoff\.mjs/);assert.ok(workflow.includes("'scripts/*workspace*'"));});
}
