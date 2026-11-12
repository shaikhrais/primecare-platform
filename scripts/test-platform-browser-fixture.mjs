import {test} from 'node:test';
import {writeThemeFixtureAction} from './fixtures/theme-write-action.mjs';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {createRequire} from 'node:module';
import {join, resolve} from 'node:path';
import {build} from 'esbuild';
import {EventEmitter} from 'node:events';
import {execFileSync} from 'node:child_process';
import {waitForFixtureStartup} from './fixtures/browser-startup.mjs';
import {waitForFixtureRequest} from './fixtures/browser-request-arrival.mjs';
import {profiles as qaProfiles,commandFor as qaCommandFor} from './qa-fast.mjs';
const qaInputs=['scripts/qa-fast.mjs','scripts/test-qa-fast.mjs','scripts/fixtures/qa-run-identity.mjs','scripts/test-look-browser-fixture.mjs','scripts/test-look-manager.mjs','scripts/fixtures/care-dom-base.mjs','scripts/fixtures/look-test-theme.json'];

// Real manager, presentation bridge, layout/theme owners, client and controller.
// DOM/CSS, transport and renderer probes below are synthetic, not browser/DB acceptance.
if(Object.keys(process.env).some(key=>/(?:DATABASE_URL|DB_URL|CLOUDFLARE|CF_API|PGPASSWORD)/i.test(key)))throw Error('Database/Cloudflare credentials forbidden in platform fixture contracts');
const read=path=>readFile(new URL('../'+path,import.meta.url),'utf8');
const helperPath='scripts/fixtures/platform-browser-bootstrap.ts';
const helper=await read(helperPath),theme=JSON.parse(await readFile('packages/shared/src/solid-theme.json','utf8'));
const runtime=await build({stdin:{contents:helper+`
export {BaseThemeManager,contrastRatio} from '../../packages/primecare_ui/web/theme-manager';
export {requireScreenManager,ScreenManager} from '../../packages/primecare_ui/web/screen-manager';
export {tenantPresentationTheme} from './tenant-presentation-theme';
export {resolveManagedRoute} from '../../websites/typescript/src/managed-routes';
export {renderPlatformAdmin} from '../../websites/typescript/src/platform-admin';
export {renderGrowth} from '../../websites/typescript/src/growth/dashboard';
export {BundleController} from '../../websites/typescript/src/platform-bundle/controller';
`,resolveDir:resolve('scripts/fixtures'),loader:'ts'},bundle:true,write:false,platform:'node',format:'cjs',metafile:true});
const module={exports:{}};
new Function('require','module','exports',runtime.outputFiles[0].text)(createRequire(import.meta.url),module,module.exports);
const api=module.exports,AsyncFunction=Object.getPrototypeOf(async()=>{}).constructor;
const restore=(name,descriptor)=>{if(descriptor)Object.defineProperty(globalThis,name,descriptor);else delete globalThis[name];};
function global(t,name,value){const descriptor=Object.getOwnPropertyDescriptor(globalThis,name);Object.defineProperty(globalThis,name,{configurable:true,writable:true,value});t.after(()=>restore(name,descriptor));}

test('tenant fixture palette passes real presentation bootstrap and retains strict theme validation',async t=>{
 const f=peripheral(t,'/tenant-dashboard');
 assert.ok(Object.isFrozen(api.tenantPresentationTheme));
 assert.equal(api.tenantPresentationTheme['--color-primary'],theme['--color-primary']);
 let rendered=0;
 await api.presentPlatformFixture(f.root,api.tenantPresentationTheme,location.origin,()=>{rendered++;});
 assert.equal(rendered,1);
 const entry=api.resolveManagedRoute('/tenant-dashboard','');
 assert.deepEqual(api.requireScreenManager(f.root).enter(entry.id,entry.route),entry);
});

function peripheral(t,path='/platform/administration',locale='en'){
 const styles=()=>{const values=new Map();return {scrollbarColor:'',setProperty:(k,v)=>values.set(k,String(v)),getPropertyValue:k=>values.get(k)??'',removeProperty:k=>values.delete(k)};};
 const events=new Map(),requests=[],storageReads=[],writes=[],values=new Map([['primecare_session','synthetic-session']]);
 const doc={};
 const element=()=>({ownerDocument:doc,style:styles(),dataset:{},attrs:new Map(),children:[],isConnected:true,
  getAttribute(k){return this.attrs.get(k)??null;},setAttribute(k,v){this.attrs.set(k,String(v));},removeAttribute(k){this.attrs.delete(k);},
  querySelector(){return null;},querySelectorAll(){return [];},contains(el){return el===this;},scrollTo(){},
  replaceChildren(...children){this.children=children;},classList:{add(){},remove(){}}});
 doc.documentElement=element();doc.documentElement.lang=locale;doc.body=element();doc.createElement=element;
 const root=element();root.parentElement=doc.body;doc.querySelector=s=>s==='#app'?root:null;doc.getElementById=id=>id==='app'?root:null;
 const address=new URL('https://fixture.invalid'+path+'?enable-semantics=true'),assigned=[];
 const location={pathname:address.pathname,href:address.href,origin:address.origin,hash:'',search:address.search,assign:p=>assigned.push(p)};
 let responsive='1';
 const view={location,CSS:{supports:()=>true},scrollTo(){},addEventListener(name,fn){(events.get(name)??events.set(name,new Set()).get(name)).add(fn);},removeEventListener:(name,fn)=>events.get(name)?.delete(fn),getComputedStyle:host=>({getPropertyValue:k=>k==='--primecare-responsive-styles'?responsive:host.style.getPropertyValue(k)})};doc.defaultView=view;
 const storage={getItem:k=>values.get(k)??null,setItem:(k,v)=>{writes.push(k);values.set(k,String(v));},removeItem:k=>{writes.push(k);values.delete(k);}};
 for(const [name,value]of Object.entries({document:doc,window:view,location,sessionStorage:storage,localStorage:{getItem:k=>{storageReads.push(k);return null;},setItem:k=>writes.push(k)},getComputedStyle:view.getComputedStyle,fetch:async(...args)=>{requests.push(args);throw Error('Unexpected request from presentation bootstrap');}}))global(t,name,value);
 t.after(()=>{for(const fn of [...events.get('pagehide')??[]])fn({persisted:false});});
 return {root,doc,location,requests,storageReads,writes,values,assigned,setResponsive:v=>{responsive=v;}};
}

test('original direct renderer entry fails closed before any session or API authority',async t=>{
 const f=peripheral(t);f.root.children=[{textContent:'previous private screen'}];
 await assert.rejects(api.renderPlatformAdmin(f.root,location.origin),/Missing manager at route boundary/);
 assert.equal(f.root.children.length,1);assert.match(f.root.children[0].textContent,/Missing manager/);
 assert.deepEqual(f.requests,[]);assert.deepEqual(f.writes,[]);assert.equal(f.values.get('primecare_session'),'synthetic-session');
});

test('original controller setup without storage reproduces the pre-fetch failure',async t=>{
 const descriptor=Object.getOwnPropertyDescriptor(globalThis,'sessionStorage');delete globalThis.sessionStorage;t.after(()=>restore('sessionStorage',descriptor));
 const requests=[];global(t,'fetch',async(...args)=>{requests.push(args);return Response.json({});});
 await assert.rejects(new api.BundleController('https://fixture.invalid','synthetic-token').load('tenant-a'),error=>error instanceof ReferenceError&&/sessionStorage/.test(error.message));
 assert.deepEqual(requests,[]);
});

test('source reproduction: direct Growth entry fails before its expected API request',async t=>{
 const f=peripheral(t,'/growth');
 await assert.rejects(api.renderGrowth(f.root,location.origin),/Missing manager at route boundary/);
 assert.match(f.root.children[0].textContent,/Missing manager/);assert.deepEqual(f.requests,[]);
});

for(const path of ['/platform/administration','/growth','/enquire/fixture-key'])for(const locale of ['en','fr','es'])test(`real presentation bridge connects ${path} in ${locale} before rendering`,async t=>{
 const f=peripheral(t,path,locale),before=structuredClone(theme);let rendered=0;
 await api.presentPlatformFixture(f.root,theme,location.origin,()=>{
  rendered++;const entry=api.resolveManagedRoute(path,'');assert.deepEqual(api.requireScreenManager(f.root).enter(entry.id,entry.route),entry);
  assert.equal(f.root.dataset.layoutVersion,'1');assert.equal(f.doc.documentElement.dataset.surfaceStyle,'solid');
  assert.equal(f.doc.documentElement.lang,locale);assert.equal(f.root.dir,'ltr');assert.ok(f.doc.documentElement.style.getPropertyValue('--color-primary'));
  assert.ok(f.root.style.getPropertyValue('--layout-content-width'));assert.equal(f.root.getAttribute('data-pc-shell-environment'),'');
 });
 assert.equal(rendered,1);assert.deepEqual(theme,before);assert.deepEqual(f.requests,[]);assert.deepEqual(f.writes,[]);
 assert.ok(f.storageReads.every(k=>k.startsWith('primecare.screen-text.v1.')));assert.equal(f.values.get('primecare_session'),'synthetic-session');
});

test('fixture does not replace missing responsive CSS with a no-op connection',async t=>{
 const f=peripheral(t);f.setResponsive('');let rendered=0;
 await assert.rejects(api.presentPlatformFixture(f.root,theme,location.origin,()=>{rendered++;}),/Missing responsive stylesheet connection/);
 assert.equal(rendered,0);assert.deepEqual(f.requests,[]);assert.deepEqual(f.writes,[]);
});
test('fixture rejects missing theme before rendering',async t=>{
 const f=peripheral(t);let rendered=0;
 await assert.rejects(api.presentPlatformFixture(f.root,{},location.origin,()=>{rendered++;}),/Missing or invalid portal theme/);
 assert.equal(rendered,0);assert.deepEqual(f.requests,[]);
});
test('fixture propagates a renderer rejection without replacing it with success',async t=>{
 const f=peripheral(t),failure=Error('Synthetic renderer failure');
 await assert.rejects(api.presentPlatformFixture(f.root,theme,location.origin,async()=>{throw failure;}),error=>error===failure);
 assert.deepEqual(f.requests,[]);
});
test('installed fixture cannot overwrite an existing root manager',async t=>{
 const f=peripheral(t);await api.presentPlatformFixture(f.root,theme,location.origin,()=>{});const manager=api.requireScreenManager(f.root);let rendered=0;
 await assert.rejects(api.presentPlatformFixture(f.root,theme,location.origin,()=>{rendered++;}),/invalid_shell_environment|Root already has a manager/);
 assert.equal(api.requireScreenManager(f.root),manager);assert.equal(rendered,0);
});
test('registration failure prevents fixture renderer invocation',async t=>{
 const f=peripheral(t),failure=Error('Synthetic rejected entry registration');let rendered=0;
 t.mock.method(api.ScreenManager.prototype,'registerScope',()=>{throw failure;});
 await assert.rejects(api.presentPlatformFixture(f.root,theme,location.origin,()=>{rendered++;}),error=>error===failure);
 assert.equal(rendered,0);assert.deepEqual(f.requests,[]);
});

const platformFixturePaths=['scripts/test-platform-bundle.mjs','scripts/test-platform-history.mjs','scripts/test-platform-attention.mjs','scripts/test-public-territory-intake.mjs','scripts/test-tenant-operations.mjs','scripts/test-territory-allocation.mjs','scripts/test-admin-growth-accessibility.mjs'];
const fixturePaths=[...platformFixturePaths,'scripts/test-growth-browser.mjs','scripts/test-growth-admin-browser.mjs','scripts/review-admin-marketing-ui.mjs'];
const sources=new Map(await Promise.all(fixturePaths.map(async path=>[path,await read(path)]))),compiled=new Map();
async function entryFor(source){
 const line=source.split('\n').find(line=>line.includes('stdin:{contents:')&&line.includes("platform:'browser'"));assert.ok(line,'Expected actual browser bundle');
 let options;await new AsyncFunction('build','theme','assert',line)(async args=>{options=args;return {outputFiles:[],metafile:{inputs:{}}};},theme,assert);
 assert.equal(options.write,false);return options.stdin.contents;
}
for(const [path,source]of sources)test(path+' retains its theme, stylesheet and real browser dependency boundaries',async()=>{
 const entry=await entryFor(source);assert.match(entry,/presentPlatformFixture\(root,/);assert.ok(entry.includes(JSON.stringify(theme)));
 assert.ok(source.indexOf('theme=')<source.indexOf('contents:`'),'Read the existing fixture theme before serializing it');
 assert.match(source,/execFileSync\('python3',\['scripts\/browser_fixture_theme\.py'\]\)/);
 assert.doesNotMatch(source,/dict\(d\.execute\([^\n]*theme_design_tokens/i);
 assert.match(source,/readFile\('websites\/typescript\/src\/styles.css','utf8'\)/);
 assert.doesNotMatch(entry,/new ScreenManager|installScreenManager|sessionStorage\.setItem/);
 if(!compiled.has(entry)){
  const result=await build({stdin:{contents:entry,resolveDir:process.cwd()},bundle:true,write:false,format:'iife',platform:'browser',metafile:true,plugins:[{name:'read-exact-bootstrap-source',setup(builder){builder.onResolve({filter:/^\.\/scripts\/fixtures\/platform-browser-bootstrap$/},()=>({path:helperPath,namespace:'fixture-entry'}));builder.onLoad({filter:/.*/,namespace:'fixture-entry'},()=>({contents:helper,loader:'ts',resolveDir:resolve('scripts/fixtures')}));}}]});
  compiled.set(entry,Object.keys(result.metafile.inputs));
 }
 const inputs=compiled.get(entry);for(const required of ['websites/typescript/src/screen-presentation.ts','websites/typescript/src/managed-routes.ts','packages/primecare_ui/web/screen-manager.ts'])assert.ok(inputs.some(p=>p.endsWith(required)),required);
 assert.ok(!inputs.some(p=>p.includes('platform-bundle/service')||p.includes('platform-bundle/routing.ts')||p.includes('node_modules/pg/')));
});

for(const [path,source]of sources){
 const paths=path==='scripts/test-growth-browser.mjs'?['/growth','/enquire/fixture-key']:['scripts/test-growth-admin-browser.mjs','scripts/review-admin-marketing-ui.mjs'].includes(path)?['/platform/administration','/growth']:path.includes('public-territory')?['/platform/administration','/growth','/enquire/fixture-key']:path.includes('growth-accessibility')?['/platform/administration','/growth']:['/platform/administration'];
 for(const route of paths)test(path+' dispatches its existing renderer for '+route,async t=>{
  const f=peripheral(t,route),entry=await entryFor(source),starts=[],calls=[];
  const present=(...args)=>{assert.equal(args[0],f.root);assert.deepEqual(args[1],theme);assert.equal(args[2],location.origin);const task=api.presentPlatformFixture(...args);starts.push(task);return task;};
  const renderer=name=>(root,gateway)=>{assert.equal(root,f.root);assert.equal(gateway,location.origin);const routeEntry=api.resolveManagedRoute(route,'');api.requireScreenManager(root).enter(routeEntry.id,routeEntry.route);calls.push(name);};
  const execute=entry.replace(/import\s+\{[^}]+\}\s+from\s+['"][^'"]+['"];?/g,'');
  new Function('presentPlatformFixture','renderPlatformAdmin','renderGrowth','renderEnquiry',execute)(present,renderer('platform'),renderer('growth'),renderer('enquiry'));
  await Promise.all(starts);assert.equal(starts.length,1);assert.deepEqual(calls,[route.startsWith('/enquire/')?'enquiry':route==='/growth'?'growth':'platform']);assert.deepEqual(f.requests,[]);
 });
}

for(const existing of [false,true])test('the actual tenant race fixture restores '+(existing?'an existing':'an absent')+' storage global and keeps request assertions',async t=>{
 const source=sources.get('scripts/test-platform-bundle.mjs'),start=source.indexOf(" await test('a delayed tenant read cannot overwrite the newer tenant selection'"),end=source.indexOf('\n // Actual browser',start);assert.ok(start>=0&&end>start);
 const original=Object.getOwnPropertyDescriptor(globalThis,'sessionStorage');t.after(()=>restore('sessionStorage',original));
 if(existing)Object.defineProperty(globalThis,'sessionStorage',{configurable:true,enumerable:true,writable:false,value:{getItem:()=> 'prior session'}});else delete globalThis.sessionStorage;
 const before=Object.getOwnPropertyDescriptor(globalThis,'sessionStorage'),fetchBefore=globalThis.fetch,cleanups=[];let compilerCalls=0,testCalls=0;
 try{
  await new AsyncFunction('test','join','dir','build','require','assert','tenant','other',source.slice(start,end))(
   async(_name,work)=>{testCalls++;await work({after:fn=>cleanups.push(fn)});},join,'/in-memory-only',async options=>{compilerCalls++;assert.deepEqual(options.entryPoints,['websites/typescript/src/platform-bundle/controller.ts']);assert.equal(options.platform,'node');},()=>({BundleController:api.BundleController}),assert,'tenant-a','tenant-b');
 }finally{for(const cleanup of cleanups.reverse())await cleanup();}
 assert.equal(testCalls,1);assert.equal(compilerCalls,1);assert.equal(globalThis.fetch,fetchBefore);assert.deepEqual(Object.getOwnPropertyDescriptor(globalThis,'sessionStorage'),before);
 assert.match(source,/requests\.map/);assert.match(source,/authorization:'Bearer synthetic-token'/);assert.match(source,/cache:'no-store'/);
});

test('platform workflow selects the new fixture contracts and retains its real acceptance gates',async()=>{
 const workflow=await read('.github/workflows/platform-admin-acceptance.yml'),triggers=workflow.split('permissions:')[0];
 for(const path of [helperPath,'scripts/test-platform-browser-fixture.mjs',...qaInputs])assert.equal(triggers.split("'"+path+"'").length-1,2,path+' is covered by push and PR events');
 const selected=['scripts/test-platform-browser-fixture.mjs','scripts/test-platform-bundle-session.mjs','scripts/test-platform-admin-manager.mjs','scripts/test-typescript-screen-manager.mjs','scripts/test-enquiry-manager.mjs','scripts/test-admin-child-sessions.mjs'];
 assert.deepEqual(qaProfiles['quick-unit'].files,selected,'Every former selected suite remains in the complete quick profile');
 assert.deepEqual(qaCommandFor('quick-unit','node'),['node','--test','--test-reporter=tap','--test-concurrency=1','--test-timeout=60000',...selected]);
 const step=workflow.split('      - name: Validate platform fixture bootstrap and fail-closed session boundaries')[1]?.split('\n      - ')[0];assert.ok(step,'Existing fixture step remains');
 const commands=step.split('\n').map(line=>line.trim()).filter(line=>line&&!line.startsWith('run:'));
 const isolated='env -i PATH="$PATH" HOME="$HOME" ';
 assert.deepEqual(commands,[isolated+'node --test scripts/test-qa-fast.mjs',isolated+'node --test scripts/test-look-browser-fixture.mjs',isolated+'node scripts/qa-fast.mjs quick-unit',isolated+'node --test scripts/test-growth-manager.mjs',isolated+'PYTHONDONTWRITEBYTECODE=1 NODE_DISABLE_COMPILE_CACHE=1 node --test scripts/test-platform-admin-transport.mjs'],'Runner regressions, Look contracts, six selected suites, Growth and transport each execute exactly once in order');
 for(const path of platformFixturePaths)assert.ok(workflow.includes('node --test '+path),path+' actual acceptance remains required');
 assert.match(workflow,/test "\$\{\{ steps\.accessibility\.outcome \}\}" = success/);assert.match(workflow,/contents: read/);assert.doesNotMatch(workflow,/contents: write|write-all|id-token: write/);
 assert.ok(workflow.includes('node scripts/test-platform-admin-browser.mjs'));assert.ok(workflow.includes('PLATFORM_TEST_IDENTITY=text node --test scripts/test-public-territory-intake.mjs'));
});

const growth=await read('scripts/test-growth-loading-browser.mjs');
const growthEntryLine=growth.split('\n').find(line=>line.startsWith('const bundle=await build('));
let growthEntry;
await new AsyncFunction('build',growthEntryLine)(async options=>{growthEntry=options.stdin.contents;return {};});
test('Growth loading fixture bundles the actual bridge and existing explicit synthetic theme',async()=>{
 assert.match(growthEntry,/presentPlatformFixture\(root,fixtureTheme,gateway/);
 assert.match(growthEntry,/scripts\/fixtures\/look-test-theme\.json/);
 const built=await build({stdin:{contents:growthEntry,resolveDir:process.cwd()},bundle:true,write:false,format:'iife',platform:'browser',metafile:true,plugins:[{name:'read-exact-bootstrap-source',setup(builder){builder.onResolve({filter:/^\.\/scripts\/fixtures\/platform-browser-bootstrap$/},()=>({path:helperPath,namespace:'fixture-entry'}));builder.onLoad({filter:/.*/,namespace:'fixture-entry'},()=>({contents:helper,loader:'ts',resolveDir:resolve('scripts/fixtures')}));}}]});
 const inputs=Object.keys(built.metafile.inputs);
 for(const path of ['websites/typescript/src/growth/dashboard.ts','websites/typescript/src/screen-presentation.ts','packages/primecare_ui/web/screen-manager.ts','scripts/fixtures/look-test-theme.json'])assert.ok(inputs.some(p=>p.endsWith(path)),path);
 assert.ok(!inputs.some(p=>p.includes('node_modules/pg/')||p.includes('cloudflare/workers/')),'Only existing browser dependencies are bundled');
});
test('Growth wrapper starts its renderer only after real presentation and keeps synthetic session setup explicit',async t=>{
 const f=peripheral(t,'/growth'),fixtureTheme=JSON.parse(await readFile('scripts/fixtures/look-test-theme.json','utf8'));let calls=0;
 const code=growthEntry.replace(/import\s+(?:\{[^}]+\}|\w+)\s+from\s+['"][^'"]+['"];?/g,'').replace('export function start','function start');
 const start=new Function('presentPlatformFixture','renderGrowth','fixtureTheme',code+'\nreturn start;')(api.presentPlatformFixture,(root,gateway)=>{calls++;assert.equal(root,f.root);assert.equal(gateway,location.origin);const entry=api.resolveManagedRoute('/growth','');api.requireScreenManager(root).enter(entry.id,entry.route);},fixtureTheme);
 await start(f.root,location.origin);assert.equal(calls,1);assert.deepEqual(f.requests,[]);
 assert.match(growth,/sessionStorage\.setItem\("primecare_session","synthetic-renderer-session"\);void GrowthStateTest\.start/);
 assert.match(growth,/for\(const locale of \['en','fr','es'\]\)for\(const width of \[320,1440\]\)/);
 assert.match(growth,/assert\.deepEqual\(errors,\[\]\);assert\.equal\(requests,6\)/);
 assert.match(growth,/timeoutMs:10000/);assert.match(growth,/await waitForFixtureRequest\(page,requestArrived/);assert.doesNotMatch(growth,/;await requestArrived;/);
 assert.match(growth,/release\(\);const video=record\?page\.video\(\):null;await context\.close\(\)/);
 assert.match(growth,/scripts\/fixtures\/browser-request-arrival\.mjs/);
});

const deferred=()=>{let resolve;const promise=new Promise(r=>{resolve=r;});return {promise,resolve};};
function pageProbe(t){
 const page=new EventEmitter(),cleared=[],original=globalThis.clearTimeout;
 t.mock.method(globalThis,'clearTimeout',timer=>{cleared.push(timer);return original(timer);});
 return {page,check:()=>{for(const name of ['pageerror','crash','close'])assert.equal(page.listenerCount(name),0,name+' listener removed');assert.equal(cleared.length,1,'Deadline timer cleared');}};
}
test('request arrival guard observes a successful early request and removes its timer/listeners',async t=>{
 const {page,check}=pageProbe(t),request=deferred();
 await waitForFixtureRequest(page,request.promise,async()=>{request.resolve();},{label:'Synthetic initial read',timeoutMs:50});check();
});
for(const name of ['pageerror','close','crash'])test('request arrival guard rejects '+name+' before an unresolved navigation/request can hang',{timeout:1000},async t=>{
 const {page,check}=pageProbe(t),request=deferred();
 await assert.rejects(waitForFixtureRequest(page,request.promise,()=>{page.emit(name,Error('Missing manager at route boundary'));return new Promise(()=>{});},{label:'Synthetic initial read',timeoutMs:100}),name==='pageerror'?/bootstrap failed: Missing manager/:new RegExp('page '+(name==='close'?'closed':'crashed')));check();
});
test('request arrival guard times out rather than waiting forever and removes listeners',{timeout:1000},async t=>{
 const {page,check}=pageProbe(t);
 await assert.rejects(waitForFixtureRequest(page,new Promise(()=>{}),async()=>{},{label:'Synthetic initial read',timeoutMs:5}),/Synthetic initial read: no request arrived within 5 ms/);check();
});
test('request arrival guard preserves navigation rejection and removes listeners',async t=>{
 const {page,check}=pageProbe(t),failure=Error('Synthetic navigation rejected');
 await assert.rejects(waitForFixtureRequest(page,new Promise(()=>{}),async()=>{throw failure;},{timeoutMs:50}),error=>error===failure);check();
});
test('request arrival guard cannot be configured with an unbounded deadline',async()=>{
 for(const timeoutMs of [0,-1,Infinity,NaN])await assert.rejects(waitForFixtureRequest(new EventEmitter(),Promise.resolve(),async()=>{},{timeoutMs}),/finite positive/);
});
test('Founder Growth workflow enforces the same contract check and retains its original bounded browser job',async()=>{
 const workflow=await read('.github/workflows/growth-marketing.yml'),triggers=workflow.split('permissions:')[0];
 for(const path of [helperPath,'scripts/fixtures/browser-request-arrival.mjs','scripts/fixtures/look-test-theme.json','scripts/test-platform-browser-fixture.mjs',...qaInputs])assert.ok(triggers.includes("'"+path+"'"),path);
 assert.match(workflow,/env -i[^\n]+node --test scripts\/test-platform-browser-fixture\.mjs/);
 assert.match(workflow,/timeout-minutes: 20/);assert.match(workflow,/^\s+run: node scripts\/qa-fast\.mjs e2e-smoke$/m);
 assert.deepEqual(qaCommandFor('e2e-smoke','node'),['node','scripts/test-growth-loading-browser.mjs'],'Smoke invokes the complete existing browser fixture');
 for(const path of ['scripts/test-growth-browser.mjs','scripts/test-growth-admin-browser.mjs'])assert.ok(workflow.split('\n').some(line=>line.includes('node --test')&&line.includes(path)),path+' actual acceptance retained');
 assert.ok(workflow.includes('REVIEW_PHASE=after node scripts/review-admin-marketing-ui.mjs'));
 assert.match(workflow,/contents: read/);assert.doesNotMatch(workflow,/contents: write|write-all|id-token: write/);
});

// A NULL CSS name is a governed non-CSS dimension, not a permissive theme fallback.
test('legacy SQL-to-JSON theme fails closed in the actual bridge before rendering or requests',async t=>{
 const f=peripheral(t);let rendered=0;
 await assert.rejects(api.presentPlatformFixture(f.root,{...theme,null:'2'},location.origin,()=>{rendered++;}),/Missing or invalid portal theme/);
 assert.equal(rendered,0);assert.deepEqual(f.requests,[]);assert.deepEqual(f.writes,[]);
});
test('canonical governed CSS projection connects the actual bridge without changing approved values',async t=>{
 const rows=Object.entries(theme).map(([css_variable_name,token_value])=>({theme_id:1,active:1,css_variable_name,token_value}));
 rows.push({theme_id:1,active:1,css_variable_name:null,token_value:'2'});
 const projected=JSON.parse(execFileSync('python3',['-c',"import json,sys;sys.path.insert(0,'scripts');from theme_manifest import css_theme;print(json.dumps(css_theme(json.load(sys.stdin))))"],{input:JSON.stringify(rows)}).toString());
 assert.deepEqual(projected,theme);const f=peripheral(t);let rendered=0;
 await api.presentPlatformFixture(f.root,projected,location.origin,()=>{const entry=api.resolveManagedRoute(location.pathname,'');api.requireScreenManager(f.root).enter(entry.id,entry.route);rendered++;});
 assert.equal(rendered,1);assert.deepEqual(f.requests,[]);assert.deepEqual(f.writes,[]);
});

test('startup guard waits for the actual readiness locator and removes listeners',async t=>{
 const {page,check}=pageProbe(t),ready=deferred();let navigated=false,waited=false;
 page.locator=selector=>{assert.equal(selector,'[data-cy="platform-language"]');return {waitFor:async options=>{assert.equal(navigated,true);assert.deepEqual(options,{state:'attached',timeout:50});waited=true;await ready.promise;}};};
 let completed=false;const task=waitForFixtureStartup(page,async()=>{navigated=true;},{timeoutMs:50}).then(()=>{completed=true;});
 await new Promise(resolve=>setImmediate(resolve));assert.equal(waited,true);assert.equal(completed,false);ready.resolve();await task;check();
});
for(const name of ['pageerror','close','crash'])test('startup guard reports '+name+' while navigation never resolves',{timeout:1000},async t=>{
 const {page,check}=pageProbe(t);
 await assert.rejects(waitForFixtureStartup(page,()=>{page.emit(name,Error('Screen Manager: Missing or invalid portal theme'));return new Promise(()=>{});},{timeoutMs:100}),name==='pageerror'?/startup failed: Screen Manager: Missing or invalid portal theme/:new RegExp('page '+(name==='close'?'closed':'crashed')));check();
});
test('startup guard times out a missing control and cleans up',{timeout:1000},async t=>{
 const {page,check}=pageProbe(t);page.locator=()=>({waitFor:()=>new Promise(()=>{})});
 await assert.rejects(waitForFixtureStartup(page,async()=>{},{timeoutMs:5}),/platform-language.*not ready within 5 ms/);check();
});
for(const stage of ['navigation','readiness'])test('startup guard preserves '+stage+' rejection',async t=>{
 const {page,check}=pageProbe(t),failure=Error('Synthetic '+stage+' failed');
 page.locator=()=>({waitFor:async()=>{throw failure;}});
 await assert.rejects(waitForFixtureStartup(page,async()=>{if(stage==='navigation')throw failure;},{timeoutMs:50}),error=>error===failure);check();
});
test('startup guard cannot be configured with an unbounded deadline',async()=>{
 for(const timeoutMs of [0,-1,Infinity,NaN])await assert.rejects(waitForFixtureStartup(new EventEmitter(),async()=>{},{timeoutMs}),/finite positive/);
});
test('both failing Platform browser groups retain assertions and close pages after startup failure',()=>{
 const source=sources.get('scripts/test-platform-bundle.mjs');
 assert.equal(source.split("await waitForFixtureStartup(page,()=>page.goto(base+'/platform/administration?enable-semantics=true'))").length-1,2);
 assert.match(source,/t\.after\(\(\)=>page\.close\(\)\);page\.on\('pageerror'/);
 assert.match(source,/finally\{await page\.close\(\);\}/);
 assert.match(source,/assert\.deepEqual\(errors,\[\]\)/);
});
test('both acceptance workflows select and enforce canonical fixture theme and startup checks',async()=>{
 for(const path of ['.github/workflows/platform-admin-acceptance.yml','.github/workflows/growth-marketing.yml']){
  const source=await read(path),triggers=source.split('permissions:')[0];
  for(const input of ['scripts/browser_fixture_theme.py','scripts/theme_manifest.py','scripts/test-theme-manifest.py','scripts/test-browser-fixture-theme.py','scripts/fixtures/browser-startup.mjs'])assert.ok(triggers.includes("'"+input+"'"),path+': '+input);
  for(const script of ['scripts/test-theme-manifest.py','scripts/test-browser-fixture-theme.py'])assert.ok(source.includes('python3 '+script),path+': '+script);
 }
});

for (const [path, routes] of [
 ['scripts/review-code-admin-look.mjs', ['/platform/administration', '/dashboard']],
 ['scripts/test-code-admin-approved.mjs', ['/platform/administration']],
]) test(path+' uses the actual managed fixture entry before its existing renderer', async t=>{
 const source=await read(path);
 const literal=source.match(/stdin:\{contents:("(?:\\.|[^"\\])*")/);
 assert.ok(literal,'Actual browser entry must be inspected');
 const entry=JSON.parse(literal[1]);
 assert.match(entry,/presentPlatformFixture\(root,/);
 assert.doesNotMatch(entry,/installPortalPresentation|new ScreenManager|sessionStorage\.setItem/);
 assert.match(source,/waitForFixtureStartup\(page,/);
 const built=await build({stdin:{contents:entry,resolveDir:process.cwd()},bundle:true,write:false,format:'iife',metafile:true});
 for(const required of ['websites/typescript/src/screen-presentation.ts','packages/primecare_ui/web/screen-manager.ts','scripts/fixtures/platform-browser-bootstrap.ts'])assert.ok(Object.keys(built.metafile.inputs).includes(required),required);
 const execute=entry.replace(/import\s+\{[^}]+\}\s+from\s+['"][^'"]+['"];?/g,'').replace(/import\s+\w+\s+from\s+['"][^'"]+['"];?/g,'');
 for(const route of routes)await t.test(route,async t=>{
  const f=peripheral(t,route),starts=[],calls=[];
  const present=(root,tokens,gateway,render)=>{assert.equal(root,f.root);assert.deepEqual(tokens,theme);const work=api.presentPlatformFixture(root,tokens,gateway,render);starts.push(work);return work;};
  const renderer=name=>(root,gateway)=>{const registration=api.resolveManagedRoute(route,'');assert.deepEqual(api.requireScreenManager(root).enter(registration.id,registration.route),registration);assert.equal(gateway,location.origin);calls.push(name);};
  new Function('presentPlatformFixture','portalTheme','theme','initializePortalInstall','renderPlatformAdmin','renderWorkspace',execute)(present,theme,theme,()=>{},renderer('platform'),renderer('workspace'));
  await Promise.all(starts);assert.equal(starts.length,1);assert.deepEqual(calls,[route==='/dashboard'?'workspace':'platform']);assert.deepEqual(f.requests,[]);assert.deepEqual(f.writes,[]);
 });
});

test('admin security fixture keeps MFA, independent readback and startup failures visible',async()=>{
 const source=await read('scripts/test-code-admin-browser.mjs');
 assert.match(source,/waitForFixtureStartup\(page,\(\)=>cy\('mfa-submit'\)\.click\(\)/);
 for(const retained of ["COUNT(*)::int AS n FROM auth_sessions","SELECT u.roles,t.slug", "platform_admin", "sessionStorage.getItem('primecare_session')"])assert.ok(source.includes(retained),retained);
 assert.doesNotMatch(source,/timeoutMs:(?:60000|120000)|waitForTimeout/);
});


test('approved directory startup targets one row and retains the independent four-row assertion',async()=>{
 const source=await read('scripts/test-code-admin-approved.mjs');
 assert.match(source,/selector:'\.approved-directory tbody tr:first-child'/);
 assert.ok(source.includes("await page.locator('.approved-directory tbody tr').count(),4"));
});


test('security reload verifies retained accounts route and organization selection before training',async()=>{
 const source=await read('scripts/test-code-admin-browser.mjs');
 assert.match(source,/waitForFixtureStartup\(page,\(\)=>page\.reload\(\)\)/);
 assert.ok(source.includes("assert.equal(new URL(page.url()).hash,'#accounts')"));
 assert.ok(source.includes("cy('platform-nav-tenant-selection').getAttribute('aria-current'),'page'"));
 assert.ok(source.includes("cy('screen-admin-training').getAttribute('lang'),locale"));
});


for(const id of ['new','reset'])test('theme fixture '+id+' awaits completion before its caller reads state',async()=>{
 const lock=deferred(),calls=[];
 const page={locator:selector=>({click:async()=>calls.push(selector)}),waitForFunction:async check=>{calls.push('write pending');assert.match(String(check),/disabled===false/);await lock.promise;}};
 let completed=false;const task=writeThemeFixtureAction(page,id).then(()=>completed=true);
 await new Promise(resolve=>setImmediate(resolve));assert.equal(completed,false);assert.deepEqual(calls,['[data-cy=theme-center-'+id+']','write pending']);
 lock.resolve();await task;assert.equal(completed,true);
});
test('Theme Center write fixture rejects unknown actions without clicking',async()=>{
 await assert.rejects(writeThemeFixtureAction({locator:()=>{throw Error('Must not click');}},'export'),/Unknown Theme Center write action/);
});
test('both real Theme Center acceptance callers await the same write barrier',async()=>{
 const approved=await read('scripts/test-code-admin-approved.mjs'),center=await read('scripts/test-theme-center-browser.mjs');
 for(const source of [approved,center])assert.match(source,/import \{writeThemeFixtureAction\} from '\.\/fixtures\/theme-write-action\.mjs'/);
 assert.ok(approved.includes("await writeThemeFixtureAction(page,'new')"));assert.ok(approved.includes("await writeThemeFixtureAction(page,'reset')"));
 assert.ok(approved.includes("cy('theme-quick-forest').getAttribute('aria-pressed'),'false'"));
 assert.ok(center.includes("assert.equal(await el('status').textContent(),'Saved on this browser.')"));
});


test('approved dark Theme Center assertion follows the shared surface and readable foreground contract',async t=>{
 const f=peripheral(t);new api.BaseThemeManager(f.doc.documentElement).apply({theme:'dark'});
 assert.equal(f.doc.documentElement.style.getPropertyValue('--color-surface'),'#172033');
 assert.equal(f.doc.documentElement.style.getPropertyValue('--color-text'),'#f1f5f9');
 assert.ok(api.contrastRatio('#172033','#f1f5f9')>=4.5);
 const styles=await read('packages/primecare_ui/web/theme-center-styles.ts');
 assert.match(styles,/background:var\(--color-surface\);color:var\(--color-text\)/);
 const source=await read('scripts/test-code-admin-approved.mjs');
 assert.ok(source.includes("assert.equal(dialogPaint.background,'rgb(23, 32, 51)')"));
 assert.ok(source.includes("assert.equal(dialogPaint.foreground,'rgb(241, 245, 249)')"));
 assert.ok(source.includes(">=4.5,'Dark Theme Center foreground must remain readable'"));
 assert.ok(source.includes("cy('appearance-reset').click()"));
});
