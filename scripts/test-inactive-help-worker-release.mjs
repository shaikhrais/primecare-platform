import test from 'node:test';
import assert from 'node:assert/strict';
import {SCOPE,WORKFLOW,PLAN_JOB,RELEASE_JOB,RELEASE_TOOLCHAIN,assertReleaseToolchain,acceptedAuthArchivePaths,authCompilerMetadataCandidates,assertAcceptedAuthSourceRecords,verifyAcceptedAuthBytes,providerReadOperation,readProviderResponse,verifyInactiveSourceGit,inactiveConfig,assertSupportedSettings,activeLineage,boundedBody,moduleEvidence,assertBuildGraph,assertPriorPlan,produceInactiveHelp} from './release-inactive-help-workers.mjs';

const source='a'.repeat(40),id=n=>'00000000-0000-4000-8000-'+String(n).padStart(12,'0');
const clone=value=>structuredClone(value);
test('accepted Auth archive uses the actual tracked closure plus lockfiles and excludes installed dependencies',()=>{
 const paths=acceptedAuthArchivePaths([{path:'cloudflare/workers/src/service.ts'},{path:"packages/shared/src/auth-elevation.json with { type: 'json' }"},{path:'packages/shared/src/auth-elevation.json'},{path:'node_modules/pg/lib/index.js'},{path:'node-built-in-modules:events',virtual:true}]);
 assert.deepEqual(paths,['cloudflare/workers/src/service.ts','package-lock.json','package.json','packages/shared/src/auth-elevation.json']);
 for(const path of ['../production-pin.json','packages/../production-pin.json','packages/shared/./source.ts','/absolute/source.ts'])assert.throws(()=>acceptedAuthArchivePaths([{path}]),/archive input path invalid/);
});
test('accepted Auth archive discovers ancestor package/TS metadata omitted from esbuild input lists',()=>{
 const candidates=authCompilerMetadataCandidates(['packages/domain/src/theme_center.ts','cloudflare/workers/src/service.ts']);
 for(const path of ['package.json','packages/domain/package.json','packages/domain/tsconfig.json','packages/domain/src/tsconfig.json','cloudflare/workers/package.json','cloudflare/workers/src/tsconfig.json'])assert.ok(candidates.includes(path));
 assert.equal(candidates.some(path=>path.includes('node_modules')||path.startsWith('../')),false);assert.equal(new Set(candidates).size,candidates.length);
});
test('accepted/current Auth closure records permit only the exact historical pin identities while preserving all other sources',()=>{
 const ordinary={path:'cloudflare/workers/src/service.ts',currentMode:'100644',acceptedMode:'100644',currentBlob:'a'.repeat(40),acceptedBlob:'a'.repeat(40)};
 const pin={path:'tools/governance-production/production-pin.json',currentMode:'100644',acceptedMode:'100644',currentBlob:'8478c2892885e57109e898736b1f1995344cb70b',acceptedBlob:'ab9d20ad4516a70063f77a9483856d2738f1a51e'};
 assert.deepEqual(assertAcceptedAuthSourceRecords([ordinary,pin]),{comparedSourceFiles:2,historicalSourceDifferences:[pin]});
 assert.throws(()=>assertAcceptedAuthSourceRecords([{...ordinary,currentBlob:'b'.repeat(40)},pin]),/Unreviewed Auth transitive/);
 assert.throws(()=>assertAcceptedAuthSourceRecords([ordinary,{...pin,currentBlob:'b'.repeat(40)}]),/Unreviewed Auth transitive/);
 assert.throws(()=>assertAcceptedAuthSourceRecords([{...ordinary,acceptedMode:'120000'}]),/Regular immutable/);
 assert.throws(()=>assertAcceptedAuthSourceRecords([ordinary,ordinary]),/Unique Auth source/);
});
test('supplemental Auth byte proof rebuilds the immutable accepted source and retains before/after provider lineage guards',async()=>{
 const acceptedSource='15c1be77fde175c2f397b78a893c2bf985db21db',acceptedModule=Buffer.from('ACTUAL ACCEPTED HISTORICAL PIN MODULE');
 Object.defineProperty(acceptedModule,'inputEvidence',{value:[{path:'tools/governance-production/production-pin.json',sha256:'a'.repeat(64)}]});
 let reads=0,sourceUsed;
 const api=async()=>{reads++;return {deployments:[{id:id(1),versions:[{version_id:id(2),percentage:100}]}]};};
 const input={api,acceptedSource,content:async worker=>{assert.equal(worker,'primecare-auth-api');return new Response(acceptedModule,{headers:{'content-type':'application/javascript'}});},rebuildAccepted:async source=>{sourceUsed=source;return {module:acceptedModule,sourceComparison:{comparedSourceFiles:185}};}};
 const proof=await verifyAcceptedAuthBytes(input);assert.equal(sourceUsed,acceptedSource);assert.equal(proof.exactBytes,true);assert.equal(proof.acceptedSource,acceptedSource);assert.equal(reads,2);
 await assert.rejects(verifyAcceptedAuthBytes({...input,content:async()=>new Response('TODAYS DIFFERENT PIN MODULE',{headers:{'content-type':'application/javascript'}})}),/bytes differ/);
 let n=0;await assert.rejects(verifyAcceptedAuthBytes({...input,api:async()=>({deployments:[{id:id(++n===1?1:9),versions:[{version_id:id(2),percentage:100}]}]})}),/Auth changed during byte comparison/);
});
test('release toolchain matches accepted Node24 and locked Wrangler4.86.0 rather than a floating lower manifest range',()=>{
 const accepted={nodeVersion:'24.0.0',wranglerVersion:'4.86.0',lockBlob:'0a25c42592d30c27e41e4a643144909f532590eb'};
 assert.deepEqual(assertReleaseToolchain(accepted),RELEASE_TOOLCHAIN);
 for(const changed of [{wranglerVersion:'4.68.1'},{wranglerVersion:'4.86.1'},{nodeVersion:'22.0.0'},{lockBlob:'f'.repeat(40)}])assert.throws(()=>assertReleaseToolchain({...accepted,...changed}),/Accepted locked release toolchain/);
});
test('provider 403 diagnostic identifies fixed operation and HTTP status without credential-bearing body or URL',async()=>{
 const credential='DO_NOT_DISCLOSE_TOKEN_OR_PROVIDER_MESSAGE',account='a'.repeat(32),zone='b'.repeat(32);
 const cases=[['/zones?account.id='+account+'&secret='+credential,'zone-inventory'],['/zones/'+zone+'/workers/routes','zone-routes'],...['settings','schedules','subdomain','versions?per_page=1','deployments?per_page=2'].map(path=>['/accounts/'+account+'/workers/scripts/primecare-governance-api/'+path,path.startsWith('settings')?'worker-settings':path.split('?')[0]])];
 for(const [path,expected] of cases){
  const operation=providerReadOperation(path);assert.equal(operation,expected);
  await assert.rejects(readProviderResponse(operation,async()=>new Response(JSON.stringify({errors:[{code:10000,message:credential}],url:'https://provider.invalid?token='+credential}),{status:403})),error=>{
   assert.match(error.message,new RegExp(operation+' HTTP 403'));assert.deepEqual(error.providerRead,{operation,httpStatus:403});assert.equal((String(error)+JSON.stringify(error)).includes(credential),false);assert.equal(String(error).includes('provider.invalid'),false);return true;
  });
 }
 await assert.rejects(readProviderResponse('content',async()=>new Response(credential,{status:403})),/content HTTP 403/);
 await assert.rejects(readProviderResponse('content',async()=>{throw Error('https://provider.invalid?token='+credential);}),error=>error.message==='Provider read failed: content HTTP unavailable'&&!String(error).includes(credential));
 assert.throws(()=>providerReadOperation('/unreviewed/'+credential),/Unsupported provider read operation/);
});
test('CLI source guard distinguishes accepted Cloudflare subtree from commit and preserves root pin',()=>{
 const calls=[],accepted='88b9689f0efd5c892be0e57bed063131b0f9541c',guard='718eaff3e6b3d4c5b26d68ec0b7a6ceaca5da3ea';
 const run=(program,args)=>{calls.push([program,args]);if(args[0]==='rev-parse')return accepted+'\n';if(args[0]==='cat-file')return 'tree\n';return '';};
 assert.deepEqual(verifyInactiveSourceGit(run),{cloudflareTree:accepted,protectedSource:guard});
 assert.deepEqual(calls.filter(([,args])=>args[0]==='fetch').map(([,args])=>args.at(-1)),[guard]);
 assert.deepEqual(calls.find(([,args])=>args[0]==='rev-parse')[1],['rev-parse','HEAD:cloudflare']);
 const diff=calls.find(([,args])=>args[0]==='diff')[1];assert.equal(diff[2],guard);assert.ok(diff.includes('tools/governance-production/production-pin.json'));assert.ok(diff.includes('scripts/verify-auth-live-proof-source.mjs'));assert.ok(diff.includes('package-lock.json'));assert.ok(diff.includes('package.json'));
 assert.equal(calls.some(([,args])=>args[0]==='diff'&&args.includes(accepted)),false);
 assert.throws(()=>verifyInactiveSourceGit((program,args)=>args[0]==='rev-parse'?'0'.repeat(40):run(program,args)),/entire Cloudflare subtree/);
 assert.throws(()=>verifyInactiveSourceGit((program,args)=>args[0]==='cat-file'?'blob':run(program,args)),/entire Cloudflare subtree/);
 assert.throws(()=>verifyInactiveSourceGit((program,args)=>{if(args[0]==='diff')throw Error('protected pin changed');return run(program,args);}),/protected pin changed/);
});
function fixture(){
 const configs={},states={},events=[];
 for(const [index,service] of Object.keys(SCOPE).entries()){
  const name=service==='gateway'?'primecare-api-gateway':'primecare-governance-api';
  configs[service]={name,main:service==='gateway'?'../cloudflare/workers/src/gateway.ts':'../cloudflare/workers/src/service.ts',compatibility_date:'2026-09-27',compatibility_flags:['nodejs_compat'],workers_dev:true,observability:{enabled:true},vars:{SERVICE_NAME:service}};
  const retained=inactiveConfig(service,configs[service],{enabled:true,previews_enabled:false});
  states[service]={deploymentId:id(index*10+1),versionId:id(index*10+2),latest:id(index*10+2),predecessor:id(index*10+3),module:Buffer.from('old-'+service),
   settings:{bindings:[{type:'plain_text',name:'SERVICE_NAME',text:service},...(service==='governance'?[{type:'secret_text',name:'DB_URL'},{type:'secret_text',name:'EXISTING_PRIVATE_KEY'}]:[])],compatibility_date:retained.compatibility_date,compatibility_flags:retained.compatibility_flags,observability:retained.observability},schedules:{schedules:[]}};
 }
 const api=async path=>{
  events.push('GET '+path);
  const service=path.includes('primecare-api-gateway')?'gateway':'governance',s=states[service];
  if(path.includes('/deployments?'))return {deployments:[{id:s.deploymentId,versions:[{version_id:s.versionId,percentage:100}]},{id:s.predecessor}]};
  if(path.includes('/versions?'))return {items:[{id:s.latest}]};
  if(path.includes('/versions/'))return {id:s.versionId,resources:clone(s.settings)};
  if(path.endsWith('/settings'))return clone(s.settings);
  if(path.endsWith('/schedules'))return clone(s.schedules);
  if(path.endsWith('/subdomain'))return {enabled:true,previews_enabled:false};
  throw Error('Unexpected fixture read');
 };
 api.routes=async()=>[];
 const producer={runId:1,jobId:2,workflow:WORKFLOW,job:PLAN_JOB,runAttempt:1};
 const hooks={source,producer,configs,api,events,states,
  content:async worker=>new Response(states[worker==='primecare-api-gateway'?'gateway':'governance'].module,{headers:{'content-type':'application/javascript'}}),
  build:async(service,config,label)=>Buffer.from((label==='baseline'?'old-':'new-')+service),
  sourceProof:async()=>({sourceFilesVerified:true}),authProof:async()=>({versionId:id(90),moduleSha256:'b'.repeat(64)}),
  freshMain:async()=>events.push('fresh-main'),verifyPrior:async()=>events.push('prior-CI-verified'),
  writeConfig:async service=>events.push('write-local '+service),wait:async()=>{},
  publish:async service=>{
   events.push('PUBLISH '+service);const s=states[service];s.predecessor=s.deploymentId;s.deploymentId=id(service==='governance'?101:111);s.versionId=id(service==='governance'?102:112);s.latest=s.versionId;s.module=Buffer.from('new-'+service);
   return 'Current Version ID: '+s.versionId;
  }};
 return hooks;
}
async function ready(){const f=fixture();const prior=await produceInactiveHelp({...f,mode:'plan'});f.events.length=0;return {...f,mode:'deploy',producer:{...f.producer,job:RELEASE_JOB,jobId:3},prior,expectedPreState:prior.preStateDigest,expectedInputs:prior.inputsDigest};}

test('entry substitution preserves generic identity gate and limits exact two targets',()=>{
 const f=fixture();assert.equal(inactiveConfig('governance',f.configs.governance,{enabled:true,previews_enabled:false}).main,'../'+SCOPE.governance);
 assert.throws(()=>inactiveConfig('governance',f.configs.governance),/subdomain configuration/);
 assert.throws(()=>inactiveConfig('auth',f.configs.governance),/Only governance/);
 assert.throws(()=>inactiveConfig('governance',{...f.configs.governance,main:'../other.ts'}),/Unexpected generic/);
});
test('meaningful unsupported categories and unknown keys fail closed',()=>{
 const settings=fixture().states.governance.settings;
 for(const [key,value] of Object.entries({placement:{mode:'smart'},limits:{cpu_ms:30000},tail_consumers:[{service:'tail'}],logpush:true,routes:[{pattern:'example.com/*'}],workers_dev:true,unknown:false}))assert.throws(()=>assertSupportedSettings({...settings,[key]:value}),/Unsupported meaningful/);
 assert.doesNotThrow(()=>assertSupportedSettings({...settings,placement:{},limits:null,tail_consumers:[],logpush:false}));
});
test('stream bounds are enforced before complete provider body buffering',async()=>{
 let cancelled=false;
 const body=new ReadableStream({pull(controller){controller.enqueue(new Uint8Array(5));},cancel(){cancelled=true;}});
 await assert.rejects(boundedBody(new Response(body),8),/exceeds bound/);assert.equal(cancelled,true);
 await assert.rejects(boundedBody(new Response('x',{headers:{'content-length':'999'}}),8),/exceeds bound/);
});
test('byte comparison accepts exact raw or multipart single module and rejects changed or extra modules',async()=>{
 const expected=Buffer.from('export default {}');
 assert.equal((await moduleEvidence(new Response(expected,{headers:{'content-type':'application/javascript'}}),expected)).exactBytes,true);
 const form=new FormData();form.set('metadata','{}');form.set('worker',new Blob([expected],{type:'application/javascript'}),'worker.js');
 assert.equal((await moduleEvidence(new Response(form),expected)).moduleCount,1);
 form.set('other',new Blob(['extra']),'other.js');await assert.rejects(moduleEvidence(new Response(form),expected),/bytes differ/);
 await assert.rejects(moduleEvidence(new Response('changed',{headers:{'content-type':'application/javascript'}}),expected),/bytes differ/);
 await assert.rejects(moduleEvidence(new Response(expected,{headers:{'content-type':'text/plain'}}),expected),/content type/);
});
test('byte mismatch identifies exact known worker/build and bounded hashes without exposing module contents',async()=>{
 const expected=Buffer.from('EXPECTED_PRIVATE_SOURCE_DO_NOT_PRINT'),actual=Buffer.from('PROVIDER_PRIVATE_SOURCE_AND_TOKEN_DO_NOT_PRINT');
 for(const context of [{worker:'primecare-auth-api',buildLabel:'accepted-auth'},{worker:'primecare-governance-api',buildLabel:'baseline'}]){
  await assert.rejects(moduleEvidence(new Response(actual,{headers:{'content-type':'application/javascript'}}),expected,context),error=>{
   assert.equal(error.message,'Provider module bytes differ from exact rebuilt module');
   assert.equal(error.moduleComparison.worker,context.worker);assert.equal(error.moduleComparison.buildLabel,context.buildLabel);
   assert.equal(error.moduleComparison.expected.moduleBytes,expected.length);assert.equal(error.moduleComparison.providerModules[0].moduleBytes,actual.length);
   assert.match(error.moduleComparison.expected.moduleSha256,/^[a-f0-9]{64}$/);assert.match(error.moduleComparison.providerModules[0].moduleSha256,/^[a-f0-9]{64}$/);
   assert.notEqual(error.moduleComparison.expected.moduleSha256,error.moduleComparison.providerModules[0].moduleSha256);
   const diagnostic=String(error)+JSON.stringify(error);assert.equal(diagnostic.includes(expected.toString()),false);assert.equal(diagnostic.includes(actual.toString()),false);return true;
  });
 }
 await assert.rejects(moduleEvidence(new Response(actual),expected,{worker:'UNREVIEWED_PRIVATE_WORKER',buildLabel:'baseline'}),/Known module comparison context/);
});
test('Wrangler graph requires actual positive Help contributions and excludes Help from Auth',()=>{
 const paths=[SCOPE.governance,'packages/shared/src/help-reader/service.ts','packages/shared/src/help-reader/postgres-store.ts','packages/shared/src/help-reader/operational-effects.ts'];
 const graph={inputs:Object.fromEntries(paths.map(p=>[p,{}])),outputs:{'worker.js':{inputs:Object.fromEntries(paths.map(p=>[p,{bytesInOutput:10}]))}}};
 assert.equal(assertBuildGraph(graph,'governance','inactive').length,4);
 graph.outputs['worker.js'].inputs[paths[2]].bytesInOutput=0;assert.throws(()=>assertBuildGraph(graph,'governance','inactive'),/absent/);
 assert.throws(()=>assertBuildGraph(graph,'auth','accepted-auth'),/unexpectedly contains/);
});
test('split traffic or unknown deployment identity fails',()=>{
 assert.throws(()=>activeLineage({deployments:[{id:id(1),versions:[{version_id:id(2),percentage:99}]}]}),/Sole active/);
 assert.throws(()=>activeLineage({deployments:[{id:id(1),versions:[{version_id:id(2),percentage:100},{version_id:id(3),percentage:0}]}]}),/Sole active/);
});
test('plan reads both exact predecessors and provider bytes with zero publication hooks',async()=>{
 const f=fixture();const result=await produceInactiveHelp({...f,mode:'plan'});
 assert.equal(result.providerWrites,0);assert.equal(result.targets.length,2);assert.match(result.preStateDigest,/^[a-f0-9]{64}$/);assert.match(result.inputsDigest,/^[a-f0-9]{64}$/);
 assert.equal(f.events.some(x=>x.startsWith('PUBLISH')||x.startsWith('write-local')||x==='fresh-main'),false);
 assert.deepEqual(result.targets[0].before.secretBindingIdentities,[{name:'DB_URL',type:'secret_text'},{name:'EXISTING_PRIVATE_KEY',type:'secret_text'}]);
 assert.equal(JSON.stringify(result).includes('bindings"'),false);
});
test('both targets preflight before first write and fresh main is last hook before each publication',async()=>{
 const f=await ready();const result=await produceInactiveHelp(f);
 assert.equal(result.receipts.length,2);assert.equal(result.runtimeActivated,false);
 for(const service of Object.keys(SCOPE)){const index=f.events.indexOf('PUBLISH '+service);assert.equal(f.events[index-1],'fresh-main');}
 assert.ok(f.events.indexOf('GET /workers/scripts/primecare-api-gateway/settings')<f.events.indexOf('PUBLISH governance'));
 assert.equal(result.receipts[0].after.predecessorDeploymentId,result.receipts[0].before.deploymentId);
});
test('plan digest excludes producer provenance while preserving provider and candidate identities',async()=>{
 const f=fixture(),a=await produceInactiveHelp({...f,mode:'plan'}),b=await produceInactiveHelp({...f,mode:'plan',producer:{...f.producer,runId:99,jobId:100},source:'c'.repeat(40)});
 assert.equal(a.preStateDigest,b.preStateDigest);assert.equal(a.inputsDigest,b.inputsDigest);
 f.states.gateway.settings.bindings.push({type:'secret_key',name:'CHANGED'});
 const c=await produceInactiveHelp({...f,mode:'plan'});assert.notEqual(a.preStateDigest,c.preStateDigest);
});
test('reviewed digest mismatch prevents every write',async()=>{
 const f=await ready();await assert.rejects(produceInactiveHelp({...f,expectedPreState:'0'.repeat(64)}),/reviewed digest/);assert.equal(f.events.some(e=>e.startsWith('PUBLISH')),false);
});
test('prior plan CI and unambiguous source receipt are mandatory before publication',async()=>{
 const f=await ready();await assert.rejects(produceInactiveHelp({...f,verifyPrior:async()=>{throw Error('CI rejected');}}),/CI rejected/);assert.equal(f.events.some(e=>e.startsWith('PUBLISH')),false);
 const current=clone(f.prior),prior=clone(f.prior);prior.source='c'.repeat(40);assert.throws(()=>assertPriorPlan(prior,current),/Fresh plan differs/);
 prior.source=current.source;prior.producer.job=RELEASE_JOB;assert.throws(()=>assertPriorPlan(prior,current),/producer unavailable/);
});
test('newer inactive upload and provider byte mismatch block read-only preflight',async()=>{
 const f=fixture();f.states.gateway.latest=id(999);await assert.rejects(produceInactiveHelp({...f,mode:'plan'}),/Latest upload/);assert.equal(f.events.some(e=>e.startsWith('PUBLISH')),false);
 const g=fixture();g.states.governance.module=Buffer.from('wrong');await assert.rejects(produceInactiveHelp({...g,mode:'plan'}),error=>error.message.includes('bytes differ')&&error.moduleComparison.worker==='primecare-governance-api'&&error.moduleComparison.buildLabel==='baseline');
});
test('remote main advancement prevents provider-changing invocation',async()=>{
 const f=await ready();await assert.rejects(produceInactiveHelp({...f,freshMain:async()=>{throw Error('Remote main advanced');}}),/Remote main advanced/);assert.equal(f.events.some(e=>e.startsWith('PUBLISH')),false);
});
test('post-upload missing secret and incorrect predecessor prevent second publication',async()=>{
 for(const failure of ['secret','predecessor']){
  const f=await ready(),publish=f.publish;
  await assert.rejects(produceInactiveHelp({...f,publish:async(...args)=>{const out=await publish(...args);if(args[0]==='governance'){if(failure==='secret')f.states.governance.settings.bindings.pop();else f.states.governance.predecessor=id(998);}return out;}}));
  assert.equal(f.events.filter(e=>e.startsWith('PUBLISH')).length,1);
 }
});
test('changed first worker is rechecked before second publication',async()=>{
 const f=await ready(),proof=f.sourceProof;let count=0;
 await assert.rejects(produceInactiveHelp({...f,sourceProof:async()=>{count++;if(count===3)f.states.governance.deploymentId=id(997);return proof();}}),/Previously released/);
 assert.deepEqual(f.events.filter(e=>e.startsWith('PUBLISH')),['PUBLISH governance']);
});
test('prepared dependency/input mutation is checked before any publication',async()=>{
 const f=fixture(),build=f.build;let changed=false;
 f.build=async(...args)=>{const module=await build(...args);Object.defineProperty(module,'inputEvidence',{value:[{path:'dependency.js',sha256:'a'.repeat(64)}]});Object.defineProperty(module,'verifyInputs',{value:async()=>{if(changed)throw Error('Prepared build input changed');}});return module;};
 const prior=await produceInactiveHelp({...f,mode:'plan'});changed=true;
 await assert.rejects(produceInactiveHelp({...f,mode:'deploy',producer:{...f.producer,job:RELEASE_JOB},prior,expectedPreState:prior.preStateDigest,expectedInputs:prior.inputsDigest}),/Prepared build input changed/);
 assert.equal(f.events.some(e=>e.startsWith('PUBLISH')),false);
});
test('a verified first receipt survives a later second-target failure',async()=>{
 const f=await ready(),attempts=[],receipts=[];let writes=0;
 await assert.rejects(produceInactiveHelp({...f,recordAttempt:async a=>attempts.push(a),recordReceipt:async r=>receipts.push(r),freshMain:async()=>{writes++;if(writes===2)throw Error('Remote main advanced');}}),/Remote main advanced/);
 assert.equal(attempts.length,3);assert.equal(attempts[0].independentlyVerified,false);assert.equal(attempts[0].reportedVersionId,null);assert.equal(attempts[1].reportedVersionId,receipts[0].versionId);assert.equal(attempts[2].service,'gateway');assert.equal(attempts[2].reportedVersionId,null);
 assert.equal(receipts.length,1);assert.equal(receipts[0].service,'governance');assert.equal(receipts[0].independentlyReadDeployment,true);
});
test('unverified intent persists before a publisher that writes then throws or returns malformed version output',async()=>{
 for(const failure of ['throw','malformed']){
  const f=await ready(),publish=f.publish,attempts=[],receipts=[];
  await assert.rejects(produceInactiveHelp({...f,recordAttempt:async a=>attempts.push(clone(a)),recordReceipt:async r=>receipts.push(r),publish:async(...args)=>{
   assert.equal(attempts.length,1);assert.equal(attempts[0].publicationInvocationIntent,true);assert.equal(attempts[0].reportedVersionId,null);assert.equal(attempts[0].independentlyVerified,false);
   await publish(...args);if(failure==='throw')throw Error('Wrangler failed after upload');return 'Uploaded but no parseable version ID';
  }}));
  assert.equal(attempts.length,1);assert.equal(attempts[0].reportedVersionId,null);assert.equal(receipts.length,0);
  assert.deepEqual(f.events.filter(e=>e.startsWith('PUBLISH')),['PUBLISH governance']);
 }
});
test('final aggregate verification rejects first-target drift during the last upload',async()=>{
 const f=await ready(),publish=f.publish,receipts=[];
 await assert.rejects(produceInactiveHelp({...f,recordReceipt:async r=>receipts.push(r),publish:async(...args)=>{const output=await publish(...args);if(args[0]==='gateway')f.states.governance.deploymentId=id(995);return output;}}),/aggregate completion/);
 assert.equal(receipts.length,2);assert.deepEqual(f.events.filter(e=>e.startsWith('PUBLISH')),['PUBLISH governance','PUBLISH gateway']);
});
test('final aggregate verification rejects Auth drift during the last upload',async()=>{
 const f=await ready(),publish=f.publish,authProof=f.authProof;let changed=false;
 await assert.rejects(produceInactiveHelp({...f,authProof:async()=>({...await authProof(),...(changed?{versionId:id(994)}:{})}),publish:async(...args)=>{const output=await publish(...args);if(args[0]==='gateway')changed=true;return output;}}),/Auth changed before aggregate completion/);
 assert.deepEqual(f.events.filter(e=>e.startsWith('PUBLISH')),['PUBLISH governance','PUBLISH gateway']);
});
