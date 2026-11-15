import test from 'node:test';import assert from 'node:assert/strict';
import {build} from 'esbuild';import {readFile} from 'node:fs/promises';import {createHash} from 'node:crypto';import {fileURLToPath} from 'node:url';
import pg from 'pg';import {postgresStoreFixture} from './help-postgres-store-fixture.mjs';
import {pin,contract,table,fixtureArtifactId} from './help-reader-service-fixture.mjs';

if(['PRODUCTION_DATABASE_URL','GOVERNANCE_DATABASE_URL','DB_URL'].some(key=>Object.hasOwn(process.env,key)))throw Error('Isolated composition fixtures only');
const root=fileURLToPath(new URL('../',import.meta.url)),slot='__primecare_help_composition_fixture__';
const entry='services/governance_api/worker/governance-help-service.ts',gatewayEntry='services/api_gateway/worker/help-gateway.ts';
const bindingPath='services/governance_api/worker/help-reader-runtime-binding.json',policyPath='packages/shared/src/help-reader/operational-policy.json';
const sourcePaths=[
 'services/governance_api/worker/help-reader.ts','services/governance_api/worker/help-reader-activation.ts',entry,gatewayEntry,
 'cloudflare/workers/src/service-application.ts','cloudflare/workers/src/gateway.ts',
 'packages/shared/src/help-reader/service.ts','packages/shared/src/help-reader/http.ts','packages/shared/src/help-reader/protocol.ts',
 'packages/shared/src/help-reader/postgres-store.ts','packages/shared/src/help-reader/operational-effects.ts',policyPath,
 'tools/governance-production/pc10-help-reader-contract.json','tools/governance-production/pc10-help-policy.definition.json',
];
const hash=value=>createHash('sha256').update(value).digest('hex');
const canonical=value=>Array.isArray(value)?'['+value.map(canonical).join(',')+']':value&&typeof value==='object'?'{'+Object.keys(value).sort().map(key=>JSON.stringify(key)+':'+canonical(value[key])).join(',')+'}':JSON.stringify(value);
const compiledOptions={absWorkingDir:root,bundle:true,write:false,platform:'node',format:'esm',target:'es2022',metafile:true,external:['pg','bcryptjs','node:*']};
function state(factory){const value={constructed:0,connected:0,ended:0,stores:0,effects:0,legacy:0,bcrypt:0,options:[],trace:[],factory};globalThis[slot]=value;return value;}
async function moduleFor({binding=null,bound=false,legacy=false}={}){
 const operational=JSON.parse(await readFile(new URL('../'+policyPath,import.meta.url)));
 const fixturePlugin={name:'isolated-help-composition-ports',setup(b){
  b.onResolve({filter:/^(?:pg|bcryptjs)$/},args=>({path:args.path,namespace:'help-fixture-port'}));
  b.onLoad({filter:/.*/,namespace:'help-fixture-port'},args=>({loader:'js',contents:args.path==='pg'?`
   export class Client {constructor(options){const s=globalThis[${JSON.stringify(slot)}];s.constructed++;if(!s.factory)throw Error('Unexpected fixture database allocation');this.port=s.factory(options);}
    connect(){return this.port.connect();}query(...args){return this.port.query(...args);}end(){return this.port.end();}}
   export default {Client};`:`const denied=()=>{globalThis[${JSON.stringify(slot)}].bcrypt++;throw Error('Unexpected fixture cryptographic effect');};export default {hash:denied,compare:denied};` }));
  b.onLoad({filter:/help-reader-runtime-binding\.json$/},()=>({loader:'json',contents:JSON.stringify(binding)}));
  b.onLoad({filter:/help-reader[\\/]operational-policy\.json$/},()=>({loader:'json',contents:JSON.stringify({...operational,runtimeBound:bound})}));
  if(legacy)b.onLoad({filter:/[\\/]legacy-domain\.ts$/},()=>({loader:'ts',contents:`export const legacyDomain=()=>{globalThis[${JSON.stringify(slot)}].legacy++;return new Response('legacy sentinel',{status:418});};`}));
  for(const [file,needle,key]of[
   ['postgres-store.ts','export function createHelpPostgresStore(reader:Database,autocommitQuota:Database):HelpOperationalStore{','stores'],
   ['operational-effects.ts','export function createHelpOperationalEffects(store:HelpOperationalStore,isCurrent:()=>boolean):HelpReadEffects{','effects'],
  ])b.onLoad({filter:new RegExp('help-reader[\\\\/]'+file.replace('.','\\.')+'$')},async args=>{const content=await readFile(args.path,'utf8');assert.ok(content.includes(needle));return {loader:'ts',contents:content.replace(needle,needle+`globalThis[${JSON.stringify(slot)}].${key}++;`)};});
 }};
 const built=await build({...compiledOptions,entryPoints:[entry],plugins:[fixturePlugin]});
 return import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].contents).toString('base64'));
}
async function gatewayModule(){const built=await build({...compiledOptions,entryPoints:[gatewayEntry]});return import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].contents).toString('base64'));}
const input={version:1,locale:'en',action:'list',query:'',offset:0,limit:25};
const env={SERVICE_NAME:'governance',DB_URL:'isolated-fixture-no-real-connection'};
const request=(path=contract.path,init={})=>new Request('https://help.test'+path,{method:'POST',headers:{'content-type':'application/json',authorization:'Bearer '+'t'.repeat(43)},body:JSON.stringify(input),...init});
async function syntheticBinding(){
 const files=Object.fromEntries(await Promise.all(sourcePaths.map(async path=>[path,hash(await readFile(new URL('../'+path,import.meta.url)))])));
 // All identities/status labels here are isolated fixtures, not production registration or provider receipts.
 const definition={apiId:794,roleId:51,screenId:685,permissionKey:contract.permissionKey,contractSha256:hash(canonical(contract)),manifestSha256:pin.manifestSha256,
  producer:{sourceCommit:'a'.repeat(40),worker:'primecare-governance-api',deploymentId:'11111111-1111-1111-1111-111111111111',versionId:'22222222-2222-2222-2222-222222222222',sourceFiles:files},
  artifact:{id:String(fixtureArtifactId),artifact_type:'fixture-file',artifact_code:'fixture-help-reader',artifact_name:'Isolated Help implementation fixture',physical_path:'services/governance_api/worker/help-reader.ts',status:'fixture-status',health_status:'fixture-health',deployment_status:'fixture-deployment',version:'22222222-2222-2222-2222-222222222222',checksum:files['services/governance_api/worker/help-reader.ts']},
  screenPermission:{id:'900795',role_id:51,screen_id:685,can_view:1,can_create:0,can_edit:0,can_delete:0,can_export:0},
  screenMap:{id:'900796',role_id:51,screen_id:685,can_view:1,can_edit:0},
  control:{id:'900797',screen_id:685,component_code:'fixture-help-reader',component_name:'Isolated reader fixture',component_type:'fixture-component',data_cy:'fixture-help-reader',file_path:'fixtures/help-reader.ts',implementation_status:'fixture-implementation'},
 };
 return {format:1,definitionSha256:hash(canonical(definition)),definition};
}
async function fixture(run){
 const f=await postgresStoreFixture();try{
  const binding=await syntheticBinding(),d=binding.definition;
  const fields=Object.keys(d.artifact).filter(field=>field!=='id');
  await f.db.exec('ALTER TABLE '+table('runtime_artifacts')+' '+fields.map(field=>'ADD COLUMN '+field+' jsonb').join(',')+';ALTER TABLE '+table('role_screen_permissions')+' ADD COLUMN id bigint,ADD COLUMN can_create bigint DEFAULT 0,ADD COLUMN can_edit bigint DEFAULT 0,ADD COLUMN can_delete bigint DEFAULT 0,ADD COLUMN can_export bigint DEFAULT 0;ALTER TABLE '+table('role_screen_map')+' ADD COLUMN id bigint,ADD COLUMN can_edit bigint DEFAULT 0;CREATE TABLE '+table('screen_components')+'(id bigint,screen_id bigint,component_code text,component_name text,component_type text,data_cy text,file_path text,implementation_status text)');
  for(const field of fields)await f.db.query('UPDATE '+table('runtime_artifacts')+' SET '+field+'=$1::jsonb',[JSON.stringify({t:'text',v:d.artifact[field]})]);
  await f.db.query('UPDATE '+table('role_screen_permissions')+' SET id=$1',[d.screenPermission.id]);await f.db.query('UPDATE '+table('role_screen_map')+' SET id=$1',[d.screenMap.id]);
  const controlKeys=Object.keys(d.control);await f.db.query('INSERT INTO '+table('screen_components')+'('+controlKeys.join(',')+') VALUES('+controlKeys.map((_,i)=>'$'+(i+1)).join(',')+')',controlKeys.map(key=>d.control[key]));
  const tokenHash=hash('t'.repeat(43));await f.db.query("UPDATE auth_sessions SET token_hash=$1 WHERE user_id='psw-a'",[tokenHash]);
  let index=0;const calls=state(options=>{calls.options.push({...options});const port=index++,raw=port===0?f.db:f.quota;return {connect:async()=>{calls.connected++;},query:async(sql,...args)=>{calls.trace.push({port,sql});await calls.beforeQuery?.(port,sql);return raw.query(sql,...args);},end:async()=>{calls.ended++;}};});
  const module=await moduleFor({binding,bound:true}),app=new module.GovernanceHelpServiceApplication();
  await run({...f,binding,d,calls,app});
 }finally{delete globalThis[slot];await f.close();}
}
const counts=async f=>({quota:Number((await f.db.query('SELECT count(*) n FROM public.help_reader_rate')).rows[0].n),audit:Number((await f.db.query('SELECT count(*) n FROM public.help_reader_audit')).rows[0].n)});

test('registered feature plan is genuinely absent; current cloudflare entry remains separate',async()=>{
 assert.equal(JSON.parse(await readFile(new URL('../'+bindingPath,import.meta.url))),null);
 const auth=await readFile(new URL('../cloudflare/workers/src/service.ts',import.meta.url),'utf8');assert.doesNotMatch(auth,/help-reader|governance-help/);
});
test('actual governance child denies unregistered canonical Help before legacy, clients and effects',async()=>{
 const calls=state(),module=await moduleFor({legacy:true}),app=new module.GovernanceHelpServiceApplication();
 const response=await app.fetch(request(),env);assert.equal(response.status,503);assert.deepEqual(await response.json(),{version:1,error:{code:'unavailable'}});
 assert.deepEqual([calls.constructed,calls.stores,calls.effects,calls.legacy,calls.bcrypt],[0,0,0,0,0]);assert.equal(response.headers.get('cache-control'),'no-store');
});
test('environment flags, headers and request fields cannot supply a missing registered plan',async()=>{
 const calls=state(),module=await moduleFor({legacy:true}),app=new module.GovernanceHelpServiceApplication();
 for(const environment of [{...env,HELP_READER_ENABLED:'1'},{...env,HELP_READER_RUNTIME_BOUND:true}])assert.equal((await app.fetch(request(),environment)).status,503);
 assert.deepEqual([calls.constructed,calls.stores,calls.effects,calls.legacy],[0,0,0,0]);
});
test('wrong service and noncanonical paths retain inherited legacy precedence',async()=>{
 const calls=state(),module=await moduleFor({legacy:true}),app=new module.GovernanceHelpServiceApplication();
 for(const [path,environment]of[[contract.path,{...env,SERVICE_NAME:'auth'}],['/psw/help-support',env],[contract.path+'/',env],['/unrelated',env]]){
  const response=await app.fetch(request(path),environment);assert.equal(response.status,418);assert.equal(await response.text(),'legacy sentinel');
 }
 assert.equal(calls.legacy,4);assert.equal(calls.constructed,0);
});
test('method, tenant override and cancelled canonical request fail before allocation',async()=>{
 const calls=state(),module=await moduleFor({legacy:true}),app=new module.GovernanceHelpServiceApplication();
 const method=await app.fetch(request(contract.path,{method:'PATCH'}),env);assert.equal(method.status,405);assert.equal(method.headers.get('allow'),'POST');
 assert.equal((await app.fetch(request(contract.path,{headers:{'content-type':'application/json','x-tenant-id':'foreign'}}),env)).status,400);
 const abort=new AbortController();abort.abort();assert.equal((await app.fetch(request(contract.path,{signal:abort.signal}),env)).status,409);
 assert.deepEqual([calls.constructed,calls.stores,calls.effects,calls.legacy],[0,0,0,0]);
});
test('valid-looking staged plan alone cannot override current runtimeBound false',async()=>{
 const binding=await syntheticBinding(),calls=state(),module=await moduleFor({binding,bound:false}),app=new module.GovernanceHelpServiceApplication();
 assert.equal((await app.fetch(request(),{...env,HELP_READER_ENABLED:'1'})).status,503);assert.equal(calls.constructed,0);assert.equal(calls.effects,0);
});
test('immutable definition and contract digests reject tampering before clients',async()=>{
 for(const mutate of[b=>b.definition.control.component_name='changed',b=>{b.definition.contractSha256='f'.repeat(64);b.definitionSha256=hash(canonical(b.definition));}]){
  const binding=await syntheticBinding();mutate(binding);const calls=state(),module=await moduleFor({binding,bound:true}),app=new module.GovernanceHelpServiceApplication();
  assert.equal((await app.fetch(request(),env)).status,503);assert.equal(calls.constructed,0);assert.equal(calls.effects,0);
 }
});
test('owned Guest control and foreign artifact IDs cannot become a registered Help plan',async()=>{
 for(const mutate of[b=>b.definition.control.id='779',b=>b.definition.artifact.id='2',b=>b.definition.screenPermission.id='6157',b=>b.definition.screenMap.id='603']){
  const binding=await syntheticBinding();mutate(binding);binding.definitionSha256=hash(canonical(binding.definition));const calls=state(),module=await moduleFor({binding,bound:true}),app=new module.GovernanceHelpServiceApplication();
  assert.equal((await app.fetch(request(),env)).status,503);assert.equal(calls.constructed,0);
 }
});
test('actual shared reader, exact binding snapshots, quota and audit share captured ownership',()=>fixture(async f=>{
 const response=await f.app.fetch(request(),env);assert.equal(response.status,200);assert.equal((await response.json()).items[0].id,'a-en');
 assert.deepEqual([f.calls.constructed,f.calls.connected,f.calls.ended],[2,2,2]);assert.equal(f.calls.stores,1);assert.equal(f.calls.effects,1);assert.deepEqual(await counts(f),{quota:1,audit:1});
 const trace=f.calls.trace,control=trace.findIndex(value=>value.sql.startsWith('SELECT id,screen_id,component_code'));
 const quota=trace.findIndex(value=>value.sql.startsWith('INSERT INTO public.help_reader_rate')),content=trace.findIndex(value=>value.sql.includes('FROM public.faqs'));
 assert.ok(control>0&&quota>control&&content>quota);assert.equal(trace[control].port,0);assert.equal(trace[quota].port,1);
 assert.equal(trace.filter(value=>value.sql.startsWith('BEGIN')).length,1);assert.equal(trace.filter(value=>value.sql==='COMMIT').length,1);
 assert.equal(trace.findIndex(value=>value.sql==='COMMIT')>content,true);
}));
test('bearer hash await cannot replace the captured database identity for either client',()=>fixture(async f=>{
 const environment={...env},original=environment.DB_URL,before=crypto.subtle.digest;let digests=0;
 crypto.subtle.digest=async function(...args){const result=await before.apply(crypto.subtle,args);if(++digests===3)environment.DB_URL='changed-during-bearer-hash';return result;};
 try{
  const response=await f.app.fetch(request(),environment);assert.equal(response.status,200);assert.equal(digests,3);
  assert.equal(environment.DB_URL,'changed-during-bearer-hash');assert.deepEqual(f.calls.options.map(options=>options.connectionString),[original,original]);
 }finally{crypto.subtle.digest=before;}
}));
for(const [label,sql]of[
 ['artifact checksum',"UPDATE "+table('runtime_artifacts')+" SET checksum='{\"t\":\"text\",\"v\":\"changed\"}'::jsonb"],
 ['artifact version',"UPDATE "+table('runtime_artifacts')+" SET version='{\"t\":\"text\",\"v\":\"changed\"}'::jsonb"],
 ['artifact lifecycle value',"UPDATE "+table('runtime_artifacts')+" SET status='{\"t\":\"text\",\"v\":\"retired-fixture\"}'::jsonb"],
 ['control ownership','UPDATE '+table('screen_components')+' SET screen_id=2534'],
 ['read-only permission','UPDATE '+table('role_screen_permissions')+' SET can_edit=1'],
 ['read-only map','UPDATE '+table('role_screen_map')+' SET can_edit=1'],
])test('changed '+label+' denies before quota/content and rolls back reader transaction',()=>fixture(async f=>{
 await f.db.exec(sql);const response=await f.app.fetch(request(),env);assert.equal(response.status,503);assert.deepEqual(await counts(f),{quota:0,audit:0});
 assert.equal(f.calls.trace.some(value=>value.sql.includes('FROM public.faqs')),false);assert.equal(f.calls.trace.some(value=>value.sql==='ROLLBACK'),true);
 assert.deepEqual([f.calls.constructed,f.calls.connected,f.calls.ended],[2,2,2]);
}));

test('native binding row locks remain held across quota await until the actual reader commits',{skip:!process.env.HELP_SERVICE_TEST_DATABASE_URL,timeout:30000},()=>fixture(async f=>{
 const other=new pg.Client({connectionString:process.env.HELP_SERVICE_TEST_DATABASE_URL});await other.connect();
 let reached,release,timer;const ready=new Promise(resolve=>reached=resolve),held=new Promise(resolve=>release=resolve);
 f.calls.beforeQuery=async(port,sql)=>{if(port===1&&sql.startsWith('INSERT INTO public.help_reader_rate')){reached();await held;}};
 const read=f.app.fetch(request(),env);
 try{
  await Promise.race([ready,new Promise((_,reject)=>timer=setTimeout(()=>reject(Error('Reader did not reach the real quota await')),10000))]);clearTimeout(timer);await other.query("SET lock_timeout='200ms'");
  await assert.rejects(other.query('UPDATE '+table('screen_components')+" SET component_name='concurrent-fixture' WHERE id=$1",[f.d.control.id]),error=>error.code==='55P03');
  release();assert.equal((await read).status,200);assert.deepEqual(await counts(f),{quota:1,audit:1});
  assert.equal((await other.query('UPDATE '+table('screen_components')+' SET component_name=component_name WHERE id=$1 RETURNING id',[f.d.control.id])).rows.length,1);
 }finally{clearTimeout(timer);release?.();await read.catch(()=>{});await other.end();}
}));

test('gateway wrapper preserves canonical path and inherited CORS/preflight without other binding calls',async()=>{
 const module=await gatewayModule(),gateway=new module.HelpGatewayWorker(),calls=[];
 const binding={fetch:async req=>{calls.push({path:new URL(req.url).pathname,method:req.method,token:req.headers.get('authorization'),body:await req.text()});return new Response('closed',{status:503});}};
 const response=await gateway.fetch(request(contract.path,{headers:{origin:'https://primecare-clinic.pages.dev','content-type':'application/json',authorization:'Bearer fixture'}}),{GOVERNANCE:binding});
 assert.equal(response.status,503);assert.equal(calls.length,1);assert.equal(calls[0].path,contract.path);assert.equal(calls[0].method,'POST');assert.equal(calls[0].token,'Bearer fixture');assert.deepEqual(JSON.parse(calls[0].body),input);
 assert.equal(response.headers.get('access-control-allow-origin'),'https://primecare-clinic.pages.dev');assert.equal(response.headers.get('cache-control'),'no-store');
 const preflight=await gateway.fetch(new Request('https://help.test'+contract.path,{method:'OPTIONS',headers:{origin:'https://primecare-clinic.pages.dev'}}),{GOVERNANCE:binding});assert.equal(preflight.status,204);assert.equal(calls.length,1);
});
test('gateway aliases and unrelated routes retain original routing behavior',async()=>{
 const module=await gatewayModule(),gateway=new module.HelpGatewayWorker(),calls=[];
 const binding={fetch:async req=>{calls.push(new URL(req.url).pathname);return new Response('existing',{status:418});}};
 for(const path of[contract.path+'/',contract.path+'/other','/psw/help-support'])assert.equal((await gateway.fetch(request(path),{GOVERNANCE:binding})).status,404);
 assert.equal(calls.length,0);assert.equal((await gateway.fetch(request('/v1/governance/existing'),{GOVERNANCE:binding})).status,418);assert.deepEqual(calls,['/existing']);
});
test('actual gateway and governance child compose closed Help without database or legacy effects',async()=>{
 const calls=state(),childModule=await moduleFor({legacy:true}),child=new childModule.GovernanceHelpServiceApplication();
 const gatewaySource=await gatewayModule(),gateway=new gatewaySource.HelpGatewayWorker();
 const environment={GOVERNANCE:{fetch:req=>child.fetch(req,env)}};
 const denied=await gateway.fetch(request(),environment);assert.equal(denied.status,503);assert.deepEqual(await denied.json(),{version:1,error:{code:'unavailable'}});
 const method=await gateway.fetch(request(contract.path,{method:'PATCH'}),environment);assert.equal(method.status,405);assert.equal(method.headers.get('allow'),'POST');
 assert.deepEqual([calls.constructed,calls.stores,calls.effects,calls.legacy],[0,0,0,0]);assert.equal(denied.headers.get('x-primecare-gateway'),'cloudflare-worker-typescript');
});
test('actual new governance entry bundle contains executable Help modules; original Auth graph excludes them',async()=>{
 const governance=await build({...compiledOptions,entryPoints:[entry]});
 const inputs=Object.values(governance.metafile.outputs).flatMap(output=>Object.entries(output.inputs));
 for(const path of['packages/shared/src/help-reader/service.ts','packages/shared/src/help-reader/postgres-store.ts','packages/shared/src/help-reader/operational-effects.ts'])assert.ok(inputs.some(([name,info])=>name===path&&info.bytesInOutput>0),path+' must contribute executable bundle bytes');
 const auth=await build({...compiledOptions,entryPoints:['cloudflare/workers/src/service.ts']});
 assert.equal(Object.keys(auth.metafile.inputs).some(path=>path.includes('/help-reader')||path.includes('governance-help-service')),false);
 const footprint=await Promise.all(Object.keys(auth.metafile.inputs).sort().map(async path=>[path,hash(await readFile(new URL('../'+path.replace(/ with \{.*\}$/,''),import.meta.url)))]));
 assert.equal(hash(JSON.stringify(footprint)),AUTH_INPUTS_SHA256);assert.equal(hash(auth.outputFiles[0].contents),AUTH_BUNDLE_SHA256);
});
// Preparation-base identity only; this is NOT an active-provider/accepted-Auth receipt.
const AUTH_INPUTS_SHA256='a5ba908d444a43fb2b36ad00883a8165e21afc2a202858c8dae2d7b85c5327f7';
const AUTH_BUNDLE_SHA256='24e744b1b8988db647f64a8a83b026d634f504fddc7df0b08c2da7e0eb1c7e0a';
