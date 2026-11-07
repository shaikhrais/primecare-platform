import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {readFile} from 'node:fs/promises';
const importCode = async options => {
  const result = await build({...options, bundle:true, write:false, platform:'node', format:'esm'});
  return import('data:text/javascript;base64,' + Buffer.from(result.outputFiles[0].text).toString('base64'));
};
const core = await importCode({entryPoints:['packages/primecare_ui/web/screen-manager.ts']});
const {ScreenManager, ScreenConfigurationError} = core;
const {resolveManagedRoute} = await importCode({entryPoints:['websites/typescript/src/managed-routes.ts']});
const connectionNames = ['layout','theme','language','responsive'];
const connections = () => Object.fromEntries(connectionNames.map(name=>[name,()=>{}]));
const registration = (id='one',route='/one') => ({id,route,kind:'governed',adapter:'workspace'});

test('required connections fail before content callbacks, including unregistered and mismatched routes',async()=>{
  for(const missing of connectionNames) {
    const services=connections(); delete services[missing]; const manager=new ScreenManager(services);
    manager.registerScope('routes',[registration()]);
    await assert.rejects(manager.present('one','/one',()=>assert.fail('content rendered')),new RegExp(missing));
  }
  const manager=new ScreenManager(connections());
  await assert.rejects(manager.present('one','/one',()=>assert.fail('content rendered')),/Missing registration/);
  manager.registerScope('routes',[registration()]);
  await assert.rejects(manager.present('one','/other',()=>assert.fail('content rendered')),/Missing registration/);
});
test('snapshot replacement is atomic, rejects duplicates and drops previous actor registrations',()=>{
  const manager=new ScreenManager(connections());
  manager.registerScope('authorized-screens',[registration()]);
  for(const duplicate of [[registration('two','/two'),registration('two','/three')],[registration('two','/two'),registration('three','/two')]]) {
    assert.throws(()=>manager.registerScope('authorized-screens',duplicate),/Duplicate/);
    assert.equal(manager.enter('one','/one').id,'one');
  }
  manager.registerScope('authorized-screens',[registration('two','/two')]);
  assert.throws(()=>manager.enter('one','/one'),/Missing registration/);
  assert.equal(manager.enter('two','/two').id,'two');
});
test('configuration is immutable and presentation never turns renderer errors into success',async()=>{
  const manager=new ScreenManager(connections()),config=registration();manager.registerScope('routes',[config]);config.route='/changed';
  assert.equal(manager.enter('one','/one').route,'/one');
  await assert.rejects(manager.present('one','/one',async()=>{throw Error('Forbidden');}),/Forbidden/);
  for(const route of ['//external','/one?tenant=other','/one#tab','/one path','/one\\two'])assert.throws(()=>manager.registerScope('bad',[registration('bad',route)]),ScreenConfigurationError);
});

const routeCases = [
  ['/forgot-password','forgot'],['/generated/forgot-password','forgot'],['/reset-password','reset'],['/generated/reset-password','reset'],
  ['/enquire/example','enquiry'],['/appearance-review','look'],['/tenant-dashboard','tenant'],['/coordinator-charge','coordinator'],
  ['/psw-requests','requests'],['/psw','psw'],['/care','psw'],['/business-plans','plans'],['/growth','growth'],
  ['/platform/administration','platform'],['/maintenance/configuration','maintenance'],['/login','login'],['/','workspace'],
  ['/dashboard','workspace'],['/success','workspace'],['/not-registered','workspace'],
];
test('all nine project entry routes retain the existing dispatch order and public-auth classification',async()=>{
  const projects=JSON.parse(await readFile('websites/typescript/projects.json','utf8'));assert.equal(Object.keys(projects).length,9);
  for(const code of Object.values(projects))for(const [path,adapter]of routeCases) {
    const route=resolveManagedRoute(path,code);assert.equal(route.adapter,adapter);assert.equal(route.route,path);
    assert.equal(route.kind==='public',['forgot','reset','login','enquiry'].includes(adapter));
  }
  assert.equal(resolveManagedRoute('/anything','au').adapter,'login');
  assert.equal(resolveManagedRoute('/growth','au').adapter,'growth');
});

class Element {
  attrs=new Map();style={scrollbarColor:'',getPropertyValue:key=>this.attrs.get(key)||'',setProperty:(key,value)=>this.attrs.set(key,value),removeProperty:key=>this.attrs.delete(key)};
  dataset={};innerHTML='';children=[];lang='';dir='';
  constructor(doc){this.ownerDocument=doc;}
  getAttribute(key){return this.attrs.get(key)??null;} setAttribute(key,value){this.attrs.set(key,value);}removeAttribute(key){this.attrs.delete(key);}
  replaceChildren(...children){this.children=children;this.innerHTML='';}contains(el){return el===this||this.children.includes(el);}
  scrollTo(){}addEventListener(){}removeEventListener(){}querySelectorAll(){return [];}querySelector(){return null;}
}
function browser(path,styles=true) {
  const values=new Map(); const storage={getItem:key=>values.get(key)??null,setItem:(key,value)=>values.set(key,value),removeItem:key=>values.delete(key)};
  const doc={};doc.documentElement=new Element(doc);doc.body=new Element(doc);doc.createElement=()=>new Element(doc);
  const root=new Element(doc);doc.querySelector=selector=>selector==='#app'?root:null;
  const events=new Map();
  doc.defaultView={addEventListener(name,callback){if(!events.has(name))events.set(name,new Set());events.get(name).add(callback);},removeEventListener(name,callback){events.get(name)?.delete(callback);},dispatchEvent(event){for(const callback of [...events.get(event.type)??[]])callback(event);this['on'+event.type]?.(event);},getComputedStyle:()=>({getPropertyValue:key=>key==='--primecare-responsive-styles'?(styles?'1':''):doc.documentElement.style.getPropertyValue(key)})};
  Object.assign(globalThis,{document:doc,window:doc.defaultView,location:{pathname:path,search:'',assign(url){this.assigned=url;},reload(){}},sessionStorage:storage,localStorage:storage,getComputedStyle:doc.defaultView.getComputedStyle});
  return {root,doc,storage,events};
}
test('missing root manager clears previous protected content and reports a developer error',()=>{
  const {root}=browser('/one');root.innerHTML='private';assert.throws(()=>core.requireScreenManager(root),/Missing manager/);
  assert.equal(root.innerHTML,'');assert.match(root.children[0].textContent,/Missing manager/);
});

const rendererExports={
 './tenant-dashboard':'renderTenantDashboard','./coordinator-charge':'renderCoordinatorCharge','./psw-personal':'renderPSWRequests',
 './psw-workspace':'renderPSW','./business-plans/dashboard':'renderBusinessPlans','./external-calls':'mountExternalDialer',
 './portal-install':'initializePortalInstall','./look-review':'renderLookReview','./auth-recovery':'renderAuthRecovery',
 './growth/enquiry':'renderEnquiry','./growth/dashboard':'renderGrowth','./platform-admin':'renderPlatformAdmin',
 './auth-screen':'renderAuth','./maintenance':'renderMaintenance','./workspace':'renderWorkspace',
};
const entryBundle=await build({entryPoints:['websites/typescript/src/main.ts'],bundle:true,write:false,format:'esm',platform:'node',plugins:[{name:'renderer-fixtures',setup(builder){
  builder.onResolve({filter:/^\.\//},args=>args.importer.replaceAll('\\', '/').endsWith('/main.ts')&&rendererExports[args.path]?{path:args.path,namespace:'renderer-fixture'}:null);
  builder.onLoad({filter:/.*/,namespace:'renderer-fixture'},args=>({contents:`export async function ${rendererExports[args.path]}(...args){ globalThis.__rendered.push(${JSON.stringify(args.path)}); if(globalThis.__rendererWait && !${JSON.stringify(['./portal-install','./external-calls'].includes(args.path))})await globalThis.__rendererWait; if(globalThis.__rejectRenderer && !${JSON.stringify(['./portal-install','./external-calls'].includes(args.path))})throw Error('fixture failure'); }`,loader:'js'}));
}}]});
let moduleSequence=0;
async function runEntry(path,styles=true,theme={'--color-primary':'#006b68'},reject=false){
  const {root}=browser(path,styles);globalThis.__rendered=[];globalThis.__rejectRenderer=reject;
  globalThis.fetch=async()=>Response.json({theme,apiGateway:'https://gateway.invalid',name:'Fixture',appCode:'co'});
  const code=entryBundle.outputFiles[0].text+`\n// ${++moduleSequence}`;
  await import('data:text/javascript;base64,'+Buffer.from(code).toString('base64'));
  await new Promise(resolve=>setImmediate(resolve));return root;
}
test('actual main.ts calls every renderer only through installed presentation services',async()=>{
  const expected={forgot:'./auth-recovery',reset:'./auth-recovery',enquiry:'./growth/enquiry',look:'./look-review',tenant:'./tenant-dashboard',coordinator:'./coordinator-charge',requests:'./psw-personal',psw:'./psw-workspace',plans:'./business-plans/dashboard',growth:'./growth/dashboard',platform:'./platform-admin',maintenance:'./maintenance',login:'./auth-screen',workspace:'./workspace'};
  for(const [path,adapter]of routeCases){await runEntry(path);assert.deepEqual(globalThis.__rendered,['./portal-install',expected[adapter]],path);}
});
test('actual main.ts fails closed for missing theme/CSS and catches asynchronous renderer failures',async()=>{
  for(const [styles,theme]of [[false,{'--color-primary':'#006b68'}],[true,{}]]){
    const root=await runEntry('/login',styles,theme);assert.deepEqual(globalThis.__rendered,['./portal-install']);assert.match(root.innerHTML,/Screen Manager/);
  }
  const root=await runEntry('/growth',true,{'--color-primary':'#006b68'},true);assert.match(root.innerHTML,/fixture failure/);
});

const workspaceFixtures={
 './account-mutations-panel':`export const mutationActorForScreen=()=>false;export const accountCreationMarkup=()=>'';export const bindAccountCreation=()=>()=>{};`,
 './tenant-accounts-panel':`export const tenantAccountsScreen='fixture-disabled';export const tenantAccountsMarkup=()=>'';export const bindTenantAccounts=()=>()=>{};`,
 './admin-training':`export const openAdminTraining=()=>{};export const trainingText=()=>'';`,
 './media-look':`export class DashboardMediaLook {roleLabel(v){return v;}sectionIcon(){return '';}heading(v){return v;}}`,
 './screen-text':`export const liveScreenText=()=>({text:(screen,locale,key,fallback)=>fallback,subscribe:()=>()=>{}});`,
 './account':`export const accountMarkup=()=>'';export const bindAccount=()=>()=>{};`,
 './auth-client':`export const signOut=async()=>{};`,
 './shell':`export const renderShell=(root,options)=>{root.innerHTML=options.mainAttributes+options.content;};export const bindShell=()=>{};`,
 './reports':`export const reportPanel=()=>{};`,
 './internal-calls':`export const renderInternalCalls=async(root)=>{root.innerHTML='calls fixture';};`,
};
const workspaceModule=await importCode({stdin:{contents:`export * from './websites/typescript/src/workspace';export * from './packages/primecare_ui/web/screen-manager';`,resolveDir:process.cwd()},plugins:[{name:'workspace-dependencies',setup(builder){
 builder.onResolve({filter:/^\.\//},args=>args.importer.replaceAll('\\', '/').endsWith('/workspace.ts')&&workspaceFixtures[args.path]?{path:args.path,namespace:'workspace-fixture'}:null);
 builder.onLoad({filter:/.*/,namespace:'workspace-fixture'},args=>({contents:workspaceFixtures[args.path],loader:'js'}));
}}]});
function workspaceBrowser(path='/one') {
 const result=browser(path);const {root,storage}=result;storage.setItem('primecare_session','fixture-token');
 const control={addEventListener(){},focus(){},open:false};root.querySelector=()=>control;
 globalThis.history={pushState(_a,_b,url){location.pathname=new URL(url,'https://fixture.invalid').pathname;},replaceState(_a,_b,url){location.pathname=new URL(url,'https://fixture.invalid').pathname;}};
 document.baseURI='https://fixture.invalid';
 const config=connections();const manager=new workspaceModule.ScreenManager(config);workspaceModule.installScreenManager(root,manager);
 // Renderer fixtures consume the same document entry installed by main.ts.
 manager.registerScope('entry',[resolveManagedRoute(path,'')]);
 const page={code:'one',name:'One',route:'/one',role:'rmt',appCode:'ci',renderer:'dashboard',lifecycle:'created',productionReady:false,blockers:[],sections:[]};
 const data={identity:{userId:'fixture-user',role:'rmt'},landing:'/one',screens:[page],inventory:[page,{...page,code:'forbidden',route:'/forbidden'}],actions:[],resources:{},overview:{activeAccounts:1,activeSessions:1,accountRoles:[],activity:[],metrics:[],scope:'personal'}};
 globalThis.fetch=async()=>Response.json(data);return {...result,manager,config,data};
}
test('actual workspace registers only authorized screens, rechecks navigation, and does not trust inventory',async()=>{
 const {root,manager}=workspaceBrowser('/');await workspaceModule.renderWorkspace(root,'https://gateway.invalid');
 assert.equal(location.pathname,'/one');assert.match(root.innerHTML,/screen-one/);
 assert.throws(()=>manager.enter('governed:forbidden','/forbidden'),/Missing registration/);
 history.pushState({},'','/forbidden');window.dispatchEvent({type:'popstate'});assert.match(root.innerHTML,/error-state/);assert.doesNotMatch(root.innerHTML,/workspace-overview/);
 history.pushState({},'','/one');window.dispatchEvent({type:'popstate'});assert.match(root.innerHTML,/screen-one/);
 manager.registerScope('workspace',[]);window.dispatchEvent({type:'popstate'});assert.equal(root.innerHTML,'');assert.match(root.children[0].textContent,/Missing registration/);
});
test('actual workspace blocks lost connections on repeated draws and requires a manager even on direct entry',async()=>{
 const {root,config}=workspaceBrowser();await workspaceModule.renderWorkspace(root,'https://gateway.invalid');
 config.layout=undefined;window.dispatchEvent({type:'popstate'});assert.equal(root.innerHTML,'');assert.match(root.children[0].textContent,/Missing layout/);
 const unbound=browser('/one').root;await assert.rejects(workspaceModule.renderWorkspace(unbound,'https://gateway.invalid'),/Missing manager/);
});
test('workspace keeps no-session, 401, 403 and changed-account handling outside presentation registration',async()=>{
 let fixture=workspaceBrowser();fixture.storage.removeItem('primecare_session');await workspaceModule.renderWorkspace(fixture.root,'https://gateway.invalid');assert.match(location.assigned,/login/);
 for(const status of [401,403]) {
  fixture=workspaceBrowser();globalThis.fetch=async()=>Response.json({error:'Forbidden'},{status});await workspaceModule.renderWorkspace(fixture.root,'https://gateway.invalid');
  assert.throws(()=>fixture.manager.enter('governed:one','/one'),/Missing registration/);
  if(status===401){assert.equal(fixture.storage.getItem('primecare_session'),null);assert.match(location.assigned,/login/);}
  else{assert.equal(fixture.storage.getItem('primecare_session'),'fixture-token');assert.match(fixture.root.innerHTML,/Forbidden/);}
 }
 fixture=workspaceBrowser();let reloaded=false;location.reload=()=>{reloaded=true;};globalThis.fetch=async()=>{fixture.storage.setItem('primecare_session','other-account');return Response.json(fixture.data);};
 await workspaceModule.renderWorkspace(fixture.root,'https://gateway.invalid');assert.equal(reloaded,true);assert.throws(()=>fixture.manager.enter('governed:one','/one'),/Missing registration/);
});
test('workspace public success and calls adapters remain explicit and calls still require a permitted screen',async()=>{
 let fixture=workspaceBrowser('/success');await workspaceModule.renderWorkspace(fixture.root,'https://gateway.invalid');assert.match(fixture.root.innerHTML,/screen-account/);assert.equal(fixture.manager.enter('typescript:account','/success').adapter,'workspace-account');
 fixture=workspaceBrowser('/one');fixture.data.screens[0].code='communication';location.search='?view=calls';await workspaceModule.renderWorkspace(fixture.root,'https://gateway.invalid');assert.equal(fixture.root.innerHTML,'calls fixture');
 fixture=workspaceBrowser('/forbidden');fixture.data.screens[0].code='communication';location.search='?view=calls';await workspaceModule.renderWorkspace(fixture.root,'https://gateway.invalid');assert.match(fixture.root.innerHTML,/error-state/);
});
test('failed refresh and account changes revoke old workspace presentation snapshots',async()=>{
 let fixture=workspaceBrowser();await workspaceModule.renderWorkspace(fixture.root,'https://gateway.invalid');
 globalThis.fetch=async()=>Response.json({error:'Unavailable'},{status:503});await workspaceModule.renderWorkspace(fixture.root,'https://gateway.invalid');
 assert.throws(()=>fixture.manager.enter('governed:one','/one'),/Missing registration/);window.dispatchEvent({type:'popstate'});assert.match(fixture.root.innerHTML,/Unavailable/);
 fixture=workspaceBrowser();await workspaceModule.renderWorkspace(fixture.root,'https://gateway.invalid');fixture.storage.setItem('primecare_session','other');
 let reload=false;location.reload=()=>{reload=true;};window.dispatchEvent({type:'popstate'});assert.equal(reload,true);assert.equal(fixture.root.innerHTML,'');assert.throws(()=>fixture.manager.enter('governed:one','/one'),/Missing registration/);
});

test('asynchronous connections cannot silently let content render before they settle',async()=>{
 for(const failure of [false,true]){
  const services=connections();services.language=async()=>{if(failure)throw Error('unavailable');};
  const manager=new ScreenManager(services);manager.registerScope('routes',[registration()]);
  await assert.rejects(manager.present('one','/one',()=>assert.fail('content rendered')),/Asynchronous language/);
 }
});

// Independent review probes. These assert required behavior, not observed defects.
test('review: nonempty malformed theme is not a valid manager connection', async()=>{
  const root=await runEntry('/login',true,{'bogus-property':'nonsense'});
  assert.deepEqual(globalThis.__rendered,['./portal-install']);
});
test('review: stale same-session load cannot replace newer authorization snapshot', async()=>{
 const fixture=workspaceBrowser('/one');const pending=[];
 globalThis.fetch=()=>new Promise(resolve=>pending.push(resolve));
 const old=workspaceModule.renderWorkspace(fixture.root,'https://gateway.invalid');
 const current=workspaceModule.renderWorkspace(fixture.root,'https://gateway.invalid');
 const fresh={...fixture.data,screens:[],inventory:[]};
 pending[1](Response.json(fresh));await current;
 assert.throws(()=>fixture.manager.enter('governed:one','/one'),/Missing registration/);
 pending[0](Response.json(fixture.data));await old;
 assert.throws(()=>fixture.manager.enter('governed:one','/one'),/Missing registration/);
});
test('review: stale response cannot clear a newer workspace error', async()=>{
 const fixture=workspaceBrowser('/one');const pending=[];
 globalThis.fetch=()=>new Promise(resolve=>pending.push(resolve));
 const old=workspaceModule.renderWorkspace(fixture.root,'https://gateway.invalid');
 const current=workspaceModule.renderWorkspace(fixture.root,'https://gateway.invalid');
 pending[1](Response.json({error:'Forbidden'},{status:403}));await current;
 assert.match(fixture.root.innerHTML,/Forbidden/);
 pending[0](Response.json(fixture.data));await old;
 assert.match(fixture.root.innerHTML,/Forbidden/);
 assert.throws(()=>fixture.manager.enter('governed:one','/one'),/Missing registration/);
});

test('governed exporter theme key grammar remains backward compatible',async()=>{
 const theme={'--color-primary':'#006b68','--Spacing_md':'16px','--9-token':'1','--_token':'2','---token':'3'};
 const root=await runEntry('/login',true,theme);
 assert.deepEqual(globalThis.__rendered,['./portal-install','./auth-screen']);
 assert.doesNotMatch(root.innerHTML,/Screen Manager/);
 for(const [key,value]of Object.entries(theme))if(key!=='--color-primary')assert.equal(document.documentElement.style.getPropertyValue(key),value);
 for(const key of ['color-primary','--bad token','--bad.token','--']){
  const failure=await runEntry('/login',true,{'--color-primary':'#006b68',[key]:'bad'});
  assert.deepEqual(globalThis.__rendered,['./portal-install']);assert.match(failure.innerHTML,/invalid portal theme/);
 }
});

// Actual production entry with controlled transport/body/renderer settlements. This
// models lifecycle ordering; it is not genuine browser BFCache evidence.
const startupTick=()=>new Promise(resolve=>setImmediate(resolve));
const startupDeferred=()=>{let resolve,reject;const promise=new Promise((a,b)=>{resolve=a;reject=b;});return {promise,resolve,reject};};
async function startupFixture(stage='fetch',outcome='success'){
 const f=browser(stage==='renderer'?'/growth':'/login');f.root.isConnected=true;f.root.innerHTML='initial';
 globalThis.__rendered=[];globalThis.__rejectRenderer=false;globalThis.__rendererWait=undefined;
 const pending=startupDeferred();const manifest={theme:{'--color-primary':'#006b68'},apiGateway:'https://fixture.invalid',name:'Fixture',appCode:'co'};
 if(stage==='renderer')globalThis.__rendererWait=pending.promise;
 let initial;globalThis.fetch=()=>{initial=new Map([...f.events].map(([name,listeners])=>[name,new Set(listeners)]));return stage==='fetch'?pending.promise:Promise.resolve({ok:true,json:()=>stage==='body'?pending.promise:Promise.resolve(manifest)});};
 await import('data:text/javascript;base64,'+Buffer.from(entryBundle.outputFiles[0].text+'\n// startup '+(++moduleSequence)).toString('base64'));
 // Capture only startup listeners, before the body promise or renderer can settle.
 const event=(type,persisted=true)=>f.doc.defaultView.dispatchEvent({type,persisted});
 const complete=()=>{
  if(outcome==='network'||outcome==='parse'||outcome==='renderer')pending.reject(Error('fixture delayed failure'));
  else if(stage==='fetch')pending.resolve(outcome==='http'?new Response('',{status:503}):outcome==='install'?Response.json({...manifest,theme:{}}):outcome==='presentation'?Response.json({...manifest,theme:{'--color-primary':'#006b68'}}):Response.json(manifest));
  else pending.resolve(stage==='body'?manifest:undefined);
 };
 if(outcome==='presentation')f.doc.defaultView.getComputedStyle=()=>({getPropertyValue:()=>''});
 const cleaned=()=>{for(const name of ['pagehide','pageshow'])for(const listener of initial.get(name)??[])assert.equal(f.events.get(name)?.has(listener)??false,false,`startup ${name} released`);};
 return {...f,event,complete,initial,cleaned};
}
for(const [stage,outcome] of [['fetch','success'],['body','success'],['fetch','http'],['fetch','network'],['body','parse'],['fetch','install'],['fetch','presentation']]){
 for(const ending of ['active','retired','suspended','resume','repeat','replacement','detached'])test(`main bootstrap ${stage}/${outcome}/${ending}`,async()=>{
  const f=await startupFixture(stage,outcome);const success=outcome==='success';
  if(['retired','suspended','resume','repeat'].includes(ending))f.event('pagehide',ending!=='retired');
  if(ending==='replacement'){const replacement=new Element(f.doc);f.doc.querySelector=selector=>selector==='#app'?replacement:null;}
  if(ending==='detached')f.root.isConnected=false;
  f.complete();await startupTick();
  if(['suspended','resume','repeat'].includes(ending)){
   assert.deepEqual(__rendered,['./portal-install']);assert.equal(f.root.innerHTML,'initial');
   for(const name of ['pagehide','pageshow'])assert.ok((f.events.get(name)?.size??0)>0,'Pending startup retains lifecycle listener');
   if(ending==='suspended'){f.event('pagehide',false);await startupTick();}
   else{
    f.event('pageshow');
    if(ending==='repeat'){f.event('pagehide');await startupTick();assert.deepEqual(__rendered,['./portal-install']);assert.equal(f.root.innerHTML,'initial');f.event('pageshow');}
    await startupTick();
   }
  }
  const allowed=['active','resume','repeat'].includes(ending);
  assert.deepEqual(__rendered,allowed&&success?['./portal-install','./auth-screen']:['./portal-install']);
  if(allowed&&!success)assert.match(f.root.innerHTML,/fatal/);else assert.equal(f.root.innerHTML,'initial');
  f.cleaned();globalThis.__rendererWait=undefined;
 });
}
for(const ending of ['active','retired','suspended','resume','repeat','replacement','detached','route','query','hash'])test('main late renderer rejection '+ending,async()=>{
 const f=await startupFixture('renderer','renderer');await startupTick();assert.deepEqual(__rendered,['./portal-install','./growth/dashboard']);
 if(['retired','suspended','resume','repeat'].includes(ending))f.event('pagehide',ending!=='retired');
 if(ending==='replacement'){const replacement=new Element(f.doc);f.doc.querySelector=selector=>selector==='#app'?replacement:null;}
 if(ending==='detached')f.root.isConnected=false;
 if(ending==='route')location.pathname='/forgot-password';if(ending==='query')location.search='?locale=fr';if(ending==='hash')location.hash='#replacement';
 f.root.innerHTML='newer-view';f.complete();await startupTick();
 if(['suspended','resume','repeat'].includes(ending)){
  assert.equal(f.root.innerHTML,'newer-view');
  if(ending==='suspended')f.event('pagehide',false);
  else{f.event('pageshow');if(ending==='repeat'){f.event('pagehide');await startupTick();assert.equal(f.root.innerHTML,'newer-view');f.event('pageshow');}}
  await startupTick();
 }
 if(['active','resume','repeat'].includes(ending))assert.match(f.root.innerHTML,/fatal/);else assert.equal(f.root.innerHTML,'newer-view');
 f.cleaned();f.event('pagehide',false);globalThis.__rendererWait=undefined;
});
test('main resolves current route after delayed manifest and dispatches once',async()=>{
 const f=await startupFixture();location.pathname='/forgot-password';location.search='?locale=fr&enable-semantics=true';f.complete();await startupTick();
 assert.deepEqual(__rendered,['./portal-install','./auth-recovery']);f.cleaned();f.event('pageshow');await startupTick();assert.equal(__rendered.length,2);
});

for(const ending of ['active','retired','suspended','replacement','detached'])test('main successful delayed renderer '+ending,async()=>{
 const f=await startupFixture('renderer','success');await startupTick();assert.deepEqual(__rendered,['./portal-install','./growth/dashboard']);
 if(ending==='retired'||ending==='suspended')f.event('pagehide',ending==='suspended');
 if(ending==='replacement')f.doc.querySelector=()=>new Element(f.doc);if(ending==='detached')f.root.isConnected=false;
 f.root.innerHTML='renderer-output';f.complete();await startupTick();assert.equal(f.root.innerHTML,'renderer-output');f.cleaned();globalThis.__rendererWait=undefined;
});
