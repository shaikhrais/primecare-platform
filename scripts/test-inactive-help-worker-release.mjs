import test from 'node:test';
import assert from 'node:assert/strict';
import {mkdtemp,mkdir,writeFile,readFile,chmod,symlink,readlink,realpath,cp,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {SCOPE,WORKFLOW,PLAN_JOB,RELEASE_JOB,RELEASE_TOOLCHAIN,GATEWAY_REPRODUCTION,GATEWAY_REPRODUCTION_SOURCES,assertGatewayReproductionIdentity,assertGatewayReproductionSources,assertGatewayReproductionToolchain,assertGatewayReproductionGraph,assertGatewayReproductionBytes,GOVERNANCE_PREDECESSOR,classifyProducerCommand,producerFailureDiagnostics,fetchGithubJobLog,assertGovernancePredecessorIdentity,checkGovernanceHistoricalProducer,assertGovernanceSourceRecords,assertReleaseToolchain,acceptedAuthArchivePaths,authCompilerMetadataCandidates,assertAcceptedAuthSourceRecords,dependencyTreeIdentity,copyLockedDependencies,verifyAcceptedAuthBytes,providerReadOperation,readProviderResponse,verifyInactiveSourceGit,inactiveConfig,assertSupportedSettings,activeLineage,inspectWorkerPredecessor,moduleMismatchAttribution,boundedBody,moduleEvidence,assertBuildGraph,assertPriorPlan,produceInactiveHelp} from './release-inactive-help-workers.mjs';

const source='a'.repeat(40),id=n=>'00000000-0000-4000-8000-'+String(n).padStart(12,'0');
const clone=value=>structuredClone(value);
test('bounded GitHub plaintext log transport authenticates only the API request and strips credentials on signed redirects',async()=>{
 const calls=[],log='timestamp APPROVED_GOVERNANCE_DEPLOYED {"fixture":true}\n';
 const result=await fetchGithubJobLog({jobId:132678080810,token:'PRIVATE_FIXTURE_TOKEN',fetcher:async(url,options)=>{calls.push({url,options});return calls.length===1?new Response(null,{status:302,headers:{location:'https://productionresultssa1.blob.core.windows.net/actions-results/log.txt?sig=PRIVATE_SIGNED_QUERY'}}):new Response(log,{headers:{'content-type':'text/plain; charset=utf-8'}});}});
 assert.equal(result,log);assert.equal(calls.length,2);assert.equal(calls[0].options.headers.authorization,'Bearer PRIVATE_FIXTURE_TOKEN');assert.equal(calls[0].options.headers['x-github-api-version'],'2026-03-10');
 assert.equal(calls[1].options.headers.authorization,undefined);assert.ok(calls.every(call=>call.options.method==='GET'&&call.options.redirect==='manual'));
});
test('GitHub job log errors expose safe HTTP category and stage without response bodies, signed URLs or credentials',async()=>{
 for(const [status,category] of [[401,'authentication-required'],[403,'permission-denied'],[404,'not-found'],[410,'logs-expired'],[429,'rate-limited'],[503,'upstream-failure'],[206,'unexpected-status']])await assert.rejects(fetchGithubJobLog({jobId:1,token:'PRIVATE_TOKEN',fetcher:async()=>new Response('PRIVATE_PROVIDER_MESSAGE',{status,headers:{'content-type':'text/plain'}})}),error=>{
  assert.deepEqual(error.githubEvidence,{operation:'github-job-log-read',category,stage:'api',httpStatus:status});assert.equal((String(error)+JSON.stringify(error)).includes('PRIVATE'),false);return true;
 });
 await assert.rejects(fetchGithubJobLog({jobId:1,token:'PRIVATE_TOKEN',fetcher:async()=>new Response('PRIVATE_RATE_LIMIT_BODY',{status:403,headers:{'x-ratelimit-remaining':'0'}})}),error=>error.githubEvidence.category==='rate-limited');
 await assert.rejects(fetchGithubJobLog({jobId:1,token:'PRIVATE_TOKEN',fetcher:async()=>{throw Error('PRIVATE_TRANSPORT_URL_TOKEN');}}),error=>error.githubEvidence.category==='transport-unavailable'&&!JSON.stringify(error).includes('PRIVATE'));
});
test('GitHub job log transport rejects unsafe redirect hosts and URL credentials before any second request',async()=>{
 for(const location of ['http://pipelines.actions.githubusercontent.com/private','https://PRIVATE_TOKEN@pipelines.actions.githubusercontent.com/log','https://127.0.0.1/log','https://attacker.invalid/PRIVATE_SIGNED_QUERY','https://pipelines.actions.githubusercontent.com.attacker.invalid/log','https://productionresultssa1.blob.core.windows.net:444/log']){
  let calls=0;await assert.rejects(fetchGithubJobLog({jobId:1,token:'PRIVATE_TOKEN',fetcher:async()=>{calls++;return new Response(null,{status:302,headers:{location}});}}),error=>error.githubEvidence.category==='redirect-rejected'&&!JSON.stringify(error).includes('PRIVATE'));assert.equal(calls,1);
 }
 let requests=0;await assert.rejects(fetchGithubJobLog({jobId:1,token:'PRIVATE_TOKEN',fetcher:async()=>{requests++;return new Response(null,{status:302,headers:{location:'https://pipelines.actions.githubusercontent.com/log?sig=PRIVATE'}});}}),error=>error.githubEvidence.category==='redirect-limit');assert.equal(requests,3);
});
test('GitHub job log transport enforces plain text, byte bounds and strict UTF8 decoding',async()=>{
 for(const [response,category] of [[new Response('PRIVATE_HTML',{headers:{'content-type':'text/html'}}),'content-type-rejected'],[new Response('PRIVATE_LARGE_TEXT',{headers:{'content-type':'text/plain','content-length':'999'}}),'body-read-or-size-rejected'],[new Response(new Uint8Array([255]),{headers:{'content-type':'text/plain'}}),'text-decoding-rejected']])await assert.rejects(fetchGithubJobLog({jobId:1,token:'PRIVATE_TOKEN',maxBytes:8,fetcher:async()=>response}),error=>error.githubEvidence.category===category&&!JSON.stringify(error).includes('PRIVATE'));
});
test('safe producer failures disclose only fixed operation/class, own line/column frames and bounded command status',()=>{
 const error=new SyntaxError('PRIVATE_PROVIDER_MESSAGE_TOKEN_BODY');
 error.stack='SyntaxError: PRIVATE_PROVIDER_MESSAGE_TOKEN_BODY\n    at parse (file:///PRIVATE_WORKSPACE/scripts/release-inactive-help-workers.mjs:530:12)\n    at provider (/PRIVATE_SOURCE.js:1:2)';
 const result=producerFailureDiagnostics(error,{operation:'governance-history-receipt-parse',childCommand:{kind:'github-job-log-read',exitStatus:17,args:['PRIVATE_TOKEN'],stdout:'PRIVATE_PROVIDER_BODY',stderr:'PRIVATE_CREDENTIAL'},lastCompletedCommand:{kind:'github-job-read',exitStatus:0}});
 assert.deepEqual(result,{errorClass:'SyntaxError',operation:'governance-history-receipt-parse',producerFrames:[{line:530,column:12}],childCommand:{kind:'github-job-log-read',exitStatus:17},lastCompletedChildCommand:{kind:'github-job-read',exitStatus:0}});
 assert.equal(JSON.stringify(result).includes('PRIVATE'),false);
 const unknown=producerFailureDiagnostics({name:'PRIVATE_ERROR_CLASS',stack:'PRIVATE_STACK'},{operation:'PRIVATE_OPERATION',childCommand:{kind:'PRIVATE_COMMAND',exitStatus:'PRIVATE_STATUS'},lastCompletedCommand:null});
 assert.deepEqual(unknown,{errorClass:'Error',operation:'configuration',producerFrames:[],childCommand:{kind:'local-child-other',exitStatus:null}});
});
test('child command diagnostics classify known operation kinds without echoing programs, arguments or URLs',()=>{
 assert.equal(classifyProducerCommand('gh',['api','repos/shaikhrais/primecare-platform/actions/jobs/132678080810/logs']),'github-job-log-read');
 assert.equal(classifyProducerCommand('gh',['api','repos/shaikhrais/primecare-platform/actions/runs/43669947275']),'github-run-read');
 assert.equal(classifyProducerCommand('git',['archive','--format=tar','PRIVATE_SOURCE']),'git-archive');
 assert.equal(classifyProducerCommand('node_modules/.bin/wrangler',['deploy','--dry-run','PRIVATE_TOKEN']),'wrangler-dry-run');
 assert.equal(classifyProducerCommand('PRIVATE_PROGRAM',['PRIVATE_ARGUMENT']),'local-child-other');
});
function governanceProducerFixture(){
 const p=GOVERNANCE_PREDECESSOR;
 return {run:{id:p.runId,head_sha:p.source,head_branch:'main',path:p.workflow,event:'workflow_dispatch',status:'completed',conclusion:'failure'},
  job:{id:p.jobId,run_id:p.runId,name:'publish',status:'completed',conclusion:'failure',steps:[{name:'Verify current main before publication',conclusion:'success'},{name:'Publish governance API while preserving existing live bindings',conclusion:'success'},{name:'Build database-governed portals',conclusion:'success'},{name:'Verify current main before Pages publication',conclusion:'failure'},{name:'Publish the PSW route to every existing portal',conclusion:'skipped'},{name:'Run actions/upload-artifact@v4',conclusion:'success'}]},
  acceptance:{id:p.acceptanceJobId,run_id:p.runId,name:'acceptance',status:'completed',conclusion:'success'},
  receipt:{format:1,source:p.source,worker:'primecare-governance-api',service:'governance',deploymentId:p.deploymentId,versionId:p.versionId,trafficPercent:100,independentlyReadDeployment:true,sourceCheckoutVerified:true,existingBindingsPreserved:true,healthStatus:200,otherWorkersModified:0}};
}
test('historical governance association requires exact live IDs and preserves the actual failed parent status',()=>{
 const p=GOVERNANCE_PREDECESSOR,identity={service:'governance',worker:'primecare-governance-api',deploymentId:p.deploymentId,versionId:p.versionId,latestVersionId:p.versionId};
 assert.doesNotThrow(()=>assertGovernancePredecessorIdentity(identity));assert.throws(()=>assertGovernancePredecessorIdentity({...identity,versionId:id(800)}),/differs from recorded/);
 const proof=checkGovernanceHistoricalProducer(governanceProducerFixture());assert.equal(proof.source,p.source);assert.equal(proof.codeStepConclusion,'success');assert.equal(proof.parentJobConclusion,'failure');assert.equal(proof.wholePipelineAccepted,false);
 for(const mutate of [f=>{f.run.head_sha='f'.repeat(40);},f=>{f.run.conclusion='success';},f=>{f.job.steps[1].conclusion='skipped';},f=>{f.job.steps[3].name='Unrelated failure';},f=>{f.acceptance.conclusion='failure';},f=>{f.receipt.versionId=id(801);}]){const fixture=governanceProducerFixture();mutate(fixture);assert.throws(()=>checkGovernanceHistoricalProducer(fixture));}
});
test('governance historical pin rule is fixed and separate from the unchanged Auth pin rule',()=>{
 const pin={path:'tools/governance-production/production-pin.json',currentMode:'100644',acceptedMode:'100644',currentBlob:'8478c2892885e57109e898736b1f1995344cb70b',acceptedBlob:'05e7a153405ffa5210927c20357d92248023f358'};
 assert.equal(assertGovernanceSourceRecords([pin]).historicalSourceDifferences.length,1);
 assert.throws(()=>assertAcceptedAuthSourceRecords([pin]),/Unreviewed Auth/);
 assert.throws(()=>assertGovernanceSourceRecords([{...pin,acceptedBlob:'ab9d20ad4516a70063f77a9483856d2738f1a51e'}]),/Unreviewed governance/);
 assert.throws(()=>assertGovernanceSourceRecords([{...pin,path:'packages/shared/src/unrelated.ts'}]),/Unreviewed governance/);
 assert.throws(()=>assertGovernanceSourceRecords([{...pin,acceptedMode:'120000'}]),/Regular immutable governance/);
});
async function dependencyFixture(){
 const root=await mkdtemp(join(tmpdir(),'inactive-help-dependency-copy-')),source=join(root,'current/node_modules'),destination=join(root,'accepted/node_modules');
 await mkdir(join(source,'wrangler/bin'),{recursive:true});await mkdir(join(source,'.bin'));await mkdir(join(root,'accepted'));
 await writeFile(join(source,'wrangler/bin/wrangler.js'),'locked executable bytes');await chmod(join(source,'wrangler/bin/wrangler.js'),0o755);
 await writeFile(join(source,'.package-lock.json'),'locked dependency identity');await symlink('../wrangler/bin/wrangler.js',join(source,'.bin/wrangler'));
 return {root,source,destination};
}
test('physical locked dependency copy preserves full bytes, modes and relative executable links inside accepted source',async()=>{
 const f=await dependencyFixture();try{
  const result=await copyLockedDependencies(f);assert.equal(result.physicalCopyVerified,true);assert.equal(result.wranglerRelativePath,'wrangler/bin/wrangler.js');
  assert.equal(await readlink(join(f.destination,'.bin/wrangler')),'../wrangler/bin/wrangler.js');
  assert.ok((await realpath(join(f.destination,'.bin/wrangler'))).startsWith(f.destination+'/'));
  assert.equal(await readFile(join(f.destination,'.package-lock.json'),'utf8'),'locked dependency identity');
  assert.deepEqual(await dependencyTreeIdentity(f.source),await dependencyTreeIdentity(f.destination));
 }finally{await rm(f.root,{recursive:true,force:true});}
});
test('dependency copy rejects byte mutation, changed source during copy, escaped links and bounded-tree overflow',async()=>{
 for(const failure of ['destination','source','symlink','bound']){
  const f=await dependencyFixture();try{
   if(failure==='symlink'){await symlink('/outside/credential',join(f.source,'external'));await assert.rejects(dependencyTreeIdentity(f.source),/symlink escapes/);continue;}
   if(failure==='bound'){await assert.rejects(dependencyTreeIdentity(f.source,{maxBytes:1}),/exceeds verification bound/);continue;}
   await assert.rejects(copyLockedDependencies({...f,copyTree:async(source,destination,options)=>{assert.equal(options.verbatimSymlinks,true);await cp(source,destination,options);await writeFile(join(failure==='source'?source:destination,'.package-lock.json'),'mutated bytes');}}),/Physical locked dependency copy differs/);
  }finally{await rm(f.root,{recursive:true,force:true});}
 }
});
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
test('actual response-compression metadata input is archived without granting a broad docs path scope',()=>{
 // Run 43682002773 current-auth metafile: ../docs/transport/compression-policy.json.
 const paths=acceptedAuthArchivePaths([{path:'docs/transport/compression-policy.json'}]);
 assert.deepEqual(paths,['docs/transport/compression-policy.json','package-lock.json','package.json']);
 for(const path of ['docs/transport/other.json','docs/transport/../compression-policy.json','docs/private.json'])assert.throws(()=>acceptedAuthArchivePaths([{path}]),/archive input path invalid/);
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
test('standard usage metadata is observed without adding a config option and remains in the complete settings digest',async()=>{
 const f=fixture(),before=await produceInactiveHelp({...f,mode:'plan'});
 f.states.governance.settings.usage_model='standard';
 const plan=await produceInactiveHelp({...f,mode:'plan'});
 assert.equal(plan.targets[0].before.usageModel.settings.enum,'standard');
 assert.notEqual(before.targets[0].before.settingsSha256,plan.targets[0].before.settingsSha256);
 assert.equal(Object.hasOwn(inactiveConfig('governance',f.configs.governance,{enabled:true,previews_enabled:false}),'usage_model'),false);
 assert.equal(assertSupportedSettings(f.states.governance.settings,{version:{resources:{script_runtime:{usage_model:'standard'}}}}).versionRuntime.enum,'standard');
});
test('all unsupported settings are projected together with only allowlisted usage enums and no raw values',()=>{
 const settings={...fixture().states.governance.settings,usage_model:'unbound',placement:{mode:'smart'},future_setting:{credential:'PRIVATE_PROVIDER_VALUE'},tags:['PRIVATE_TAG']};
 assert.throws(()=>assertSupportedSettings(settings,{version:{resources:{script_runtime:{usage_model:'bundled'}}}}),error=>{
  assert.deepEqual(error.unsupportedSettings.map(s=>s.key),['usage_model','placement','future_setting','tags','version-runtime.usage_model']);
  assert.equal(error.usageModel.settings.enum,'unbound');assert.equal(error.usageModel.versionRuntime.enum,'bundled');
  const output=JSON.stringify(error);assert.equal(output.includes('PRIVATE_PROVIDER_VALUE'),false);assert.equal(output.includes('PRIVATE_TAG'),false);assert.equal(output.includes('smart'),false);return true;
 });
 for(const value of ['bundled','unbound','PRIVATE_ENUM_VALUE',null,42,true,{}])assert.throws(()=>assertSupportedSettings({...settings,usage_model:value}),error=>{
  assert.equal(JSON.stringify(error).includes('PRIVATE_ENUM_VALUE'),false);assert.equal(error.usageModel.settings.enum,['bundled','unbound'].includes(value)?value:'unrecognized');return true;
 });
});
test('successful Auth component proof is retained before later batched target setting rejection',async()=>{
 const f=fixture(),retained=[];f.states.governance.settings.usage_model='bundled';f.states.governance.settings.unknown_setting={private:'DO_NOT_PRINT'};
 await assert.rejects(produceInactiveHelp({...f,mode:'plan',recordAuthProof:async proof=>retained.push(clone(proof))}),error=>error.unsupportedSettings.length===2);
 assert.equal(retained.length,1);assert.deepEqual(retained[0],await f.authProof());assert.equal(f.events.some(e=>e.startsWith('PUBLISH')),false);
});
test('empty tags are supported without accepting nonempty tags or emitting a config field',async()=>{
 const f=fixture(),before=await produceInactiveHelp({...f,mode:'plan'});f.states.governance.settings.tags=[];
 const after=await produceInactiveHelp({...f,mode:'plan'});assert.notEqual(before.targets[0].before.settingsSha256,after.targets[0].before.settingsSha256);
 assert.equal(Object.hasOwn(inactiveConfig('governance',f.configs.governance,{enabled:true,previews_enabled:false}),'tags'),false);
 for(const tags of [['PRIVATE_TAG'],{},null,false])assert.throws(()=>assertSupportedSettings({...f.states.governance.settings,tags}),error=>error.unsupportedSettings.some(field=>field.key==='tags')&&!JSON.stringify(error).includes('PRIVATE_TAG'));
});
test('unsupported annotations remain closed while all nested keys/types/hashes and documented operation labels are projected safely',()=>{
 const settings={...fixture().states.governance.settings,tags:[],annotations:{'workers/triggered_by':'upload','workers/message':'PRIVATE_ANNOTATION_MESSAGE',unknown:{nested:'PRIVATE_UNKNOWN_STRING',more:{flag:true}}}};
 assert.throws(()=>assertSupportedSettings(settings),error=>{
  assert.deepEqual(error.unsupportedSettings.map(field=>field.key),['annotations']);
  const fields=error.annotationProjection.fields;
  for(const path of ['annotations.workers/triggered_by','annotations.workers/message','annotations.unknown.nested','annotations.unknown.more.flag'])assert.ok(fields.some(field=>field.path===path));
  assert.equal(fields.find(field=>field.path==='annotations.workers/triggered_by').operation,'upload');
  assert.ok(fields.every(field=>/^[a-f0-9]{64}$/.test(field.valueSha256)));assert.equal(error.annotationProjection.truncated,false);
  const output=JSON.stringify(error);assert.equal(output.includes('PRIVATE_ANNOTATION_MESSAGE'),false);assert.equal(output.includes('PRIVATE_UNKNOWN_STRING'),false);return true;
 });
 for(const operation of ['secret','rollback','promotion','PRIVATE_OPERATION'])assert.throws(()=>assertSupportedSettings({...settings,annotations:{'workers/triggered_by':operation}}),error=>{
  const field=error.annotationProjection.fields.find(field=>field.path==='annotations.workers/triggered_by');assert.equal(field.operation,operation==='PRIVATE_OPERATION'?undefined:operation);assert.equal(JSON.stringify(error).includes('PRIVATE_OPERATION'),false);return true;
 });
});
test('only the exact observed read-only version_upload annotation is supported and stays in full state hashes',async()=>{
 const f=fixture(),before=await produceInactiveHelp({...f,mode:'plan'});f.states.governance.settings.annotations={'workers/triggered_by':'version_upload'};
 const plan=await produceInactiveHelp({...f,mode:'plan'});assert.equal(plan.targets[0].before.serverOperation,'version_upload');assert.notEqual(before.targets[0].before.settingsSha256,plan.targets[0].before.settingsSha256);
 assert.equal(Object.hasOwn(inactiveConfig('governance',f.configs.governance,{enabled:true,previews_enabled:false}),'annotations'),false);
 for(const annotations of [{'workers/triggered_by':'upload'},{'workers/triggered_by':'version_upload','workers/message':''},{'workers/triggered_by':'version_upload','workers/tag':'PRIVATE_TAG'},{'workers/triggered_by':'PRIVATE_OPERATION'}])assert.throws(()=>assertSupportedSettings({...f.states.governance.settings,annotations}),error=>error.unsupportedSettings.some(field=>field.key==='annotations')&&!JSON.stringify(error).includes('PRIVATE_TAG')&&!JSON.stringify(error).includes('PRIVATE_OPERATION'));
});
test('read-only operation transitions are explicitly rejected and recorded before any second target publication',async()=>{
 for(const change of ['secret','absent']){
  const f=fixture();f.states.governance.settings.annotations={'workers/triggered_by':'version_upload'};
  const prior=await produceInactiveHelp({...f,mode:'plan'}),publish=f.publish,attempts=[];
  await assert.rejects(produceInactiveHelp({...f,mode:'deploy',producer:{...f.producer,job:RELEASE_JOB},prior,expectedPreState:prior.preStateDigest,expectedInputs:prior.inputsDigest,recordAttempt:async a=>attempts.push(a),publish:async(...args)=>{const output=await publish(...args);if(args[0]==='governance')f.states.governance.settings.annotations=change==='secret'?{'workers/triggered_by':'secret'}:{};return output;}}),error=>{
   assert.equal(error.serverOperationTransition.before,'version_upload');assert.equal(error.serverOperationTransition.permitted,false);assert.equal(change==='secret'?error.serverOperationTransition.after.operation:error.serverOperationTransition.after,change==='secret'?'secret':null);return true;
  });
  assert.equal(attempts[0].previousServerOperation,'version_upload');assert.deepEqual(f.events.filter(event=>event.startsWith('PUBLISH')),['PUBLISH governance']);
 }
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
test('code mismatch attributes byte ranges only to actual local build inputs and never prints provider code',()=>{
 const expected=Buffer.from('// tools/governance-production/production-pin.json\nconst marker = "PRIVATE_LOCAL_LITERAL_A";\n');
 Object.defineProperty(expected,'inputEvidence',{value:[{path:'tools/governance-production/production-pin.json'}]});
 const actual=Buffer.from(expected),position=expected.indexOf('LITERAL_A')+'LITERAL_'.length;actual[position]=66;
 const result=moduleMismatchAttribution(expected,actual);assert.equal(result.differingByteCount,1);assert.equal(result.changedRangeCount,1);
 assert.equal(result.ranges[0].start,position);assert.equal(result.ranges[0].localSection.path,'tools/governance-production/production-pin.json');
 assert.match(result.ranges[0].providerRangeSha256,/^[a-f0-9]{64}$/);assert.equal(JSON.stringify(result).includes('PRIVATE_LOCAL_LITERAL'),false);
 const noisy=Buffer.alloc(100,65),other=Buffer.from(noisy);for(let i=0;i<other.length;i+=2)other[i]=66;
 const bounded=moduleMismatchAttribution(noisy,other);assert.equal(bounded.changedRangeCount,50);assert.equal(bounded.ranges.length,16);assert.equal(bounded.rangesTruncated,true);
 const untrustedHeader=moduleMismatchAttribution(Buffer.from('// PRIVATE_PROVIDER_PATH\nLOCAL_PRIVATE'),Buffer.from('// OTHER_PROVIDER_PATH__\nREMOTE_PRIVATE'));
 assert.ok(untrustedHeader.ranges.every(range=>range.localSection===null));assert.equal(JSON.stringify(untrustedHeader).includes('PRIVATE_PROVIDER_PATH'),false);
});
test('predecessor identity records stable provider UUIDs and allowlisted provenance without authors or code-readiness claims',async()=>{
 const f=fixture(),api=f.api;
 const wrapped=async path=>{const response=await api(path);if(path.includes('/versions/')){response.metadata={created_on:'2026-11-15T03:00:12.010824Z',source:'wrangler',author_email:'PRIVATE_AUTHOR'};response.number=4;response.resources.script={last_deployed_from:'PRIVATE_PROVIDER_SOURCE'};}return response;};
 const identity=await inspectWorkerPredecessor({api:wrapped,service:'governance'});
 assert.equal(identity.worker,'primecare-governance-api');assert.equal(identity.versionCreatedOn,'2026-11-15T03:00:12.010824Z');assert.equal(identity.versionSource.enum,'wrangler');
 assert.equal(identity.baselineBytesVerified,false);assert.equal(identity.settingsPreservationVerified,false);assert.equal(identity.deploymentReadiness,false);
 assert.equal(identity.lastDeployedFrom.enum,'unrecognized');assert.equal(JSON.stringify(identity).includes('PRIVATE_AUTHOR'),false);assert.equal(JSON.stringify(identity).includes('PRIVATE_PROVIDER_SOURCE'),false);
});
test('both target predecessor receipts survive the first baseline byte rejection without claiming either baseline passed',async()=>{
 const f=fixture(),recorded=[];f.states.governance.module=Buffer.from('different actual provider module');
 await assert.rejects(produceInactiveHelp({...f,mode:'plan',recordPredecessor:async identity=>recorded.push(identity)}),/bytes differ/);
 assert.deepEqual(recorded.map(identity=>identity.service),['governance','gateway']);assert.ok(recorded.every(identity=>identity.baselineBytesVerified===false&&identity.deploymentReadiness===false));
 assert.equal(f.events.some(event=>event.startsWith('PUBLISH')),false);
});
test('historical governance baseline must match exact provider bytes and its component proof survives a later gateway rejection',async()=>{
 const f=fixture(),p=GOVERNANCE_PREDECESSOR,retained=[],historical=Buffer.from('exact historical governance module');
 Object.assign(f.states.governance,{deploymentId:p.deploymentId,versionId:p.versionId,latest:p.versionId,module:historical});f.states.gateway.module=Buffer.from('unexpected gateway baseline');
 await assert.rejects(produceInactiveHelp({...f,mode:'plan',recordBaselineProof:async proof=>retained.push(proof),baselineModule:async({service,currentModule,predecessor})=>{if(service!=='governance')return {module:currentModule,sourceProof:null};assertGovernancePredecessorIdentity(predecessor);return {module:historical,sourceProof:checkGovernanceHistoricalProducer(governanceProducerFixture())};}}),error=>error.moduleComparison.worker==='primecare-api-gateway');
 assert.equal(retained.length,1);assert.equal(retained[0].service,'governance');assert.equal(retained[0].exactProviderBytes,true);assert.equal(retained[0].sourceProof.parentJobConclusion,'failure');assert.equal(retained[0].sourceProof.wholePipelineAccepted,false);assert.equal(retained[0].deploymentReadiness,false);
 f.states.gateway.module=Buffer.from('old-gateway');f.states.governance.module=Buffer.from('different actual governance bytes');
 await assert.rejects(produceInactiveHelp({...f,mode:'plan',baselineModule:async({service,currentModule,predecessor})=>{if(service!=='governance')return {module:currentModule};assertGovernancePredecessorIdentity(predecessor);return {module:historical,sourceProof:null};}}),error=>error.moduleComparison.worker==='primecare-governance-api');
 assert.equal(f.events.some(event=>event.startsWith('PUBLISH')),false);
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

const gatewayReproductionIdentity=()=>({service:'gateway',worker:'primecare-api-gateway',deploymentId:GATEWAY_REPRODUCTION.deploymentId,versionId:GATEWAY_REPRODUCTION.versionId,latestVersionId:GATEWAY_REPRODUCTION.versionId});
const gatewayReproductionRecords=()=>Object.entries(GATEWAY_REPRODUCTION_SOURCES).map(([path,blob])=>({path,blob,mode:'100644',type:'blob'}));
const gatewayReproductionToolchain=()=>({nodeVersion:'24.22.1',wranglerVersion:'4.68.1',packageSha256:GATEWAY_REPRODUCTION.packageSha256,lockSha256:GATEWAY_REPRODUCTION.lockSha256,dependencyLabel:GATEWAY_REPRODUCTION.dependencyLabel});
test('Gateway byte reproduction requires the independently observed sole live version and deployment',()=>{
 assert.doesNotThrow(()=>assertGatewayReproductionIdentity(gatewayReproductionIdentity()));
 for(const key of ['service','worker','deploymentId','versionId','latestVersionId'])assert.throws(()=>assertGatewayReproductionIdentity({...gatewayReproductionIdentity(),[key]:'different'}),/Gateway identity/);
});
test('Gateway reproduction pins every source blob and rejects missing, duplicate, extra, executable or symlink source',()=>{
 const records=gatewayReproductionRecords();assert.doesNotThrow(()=>assertGatewayReproductionSources(records));
 for(const changed of [records.slice(1),[...records,records[0]],records.map((r,i)=>i? r:{...r,blob:'0'.repeat(40)}),records.map((r,i)=>i?r:{...r,mode:'100755'}),records.map((r,i)=>i?r:{...r,mode:'120000'}),records.map((r,i)=>i?r:{...r,type:'tree'}),records.map((r,i)=>i?r:{...r,path:'unreviewed.ts'})])assert.throws(()=>assertGatewayReproductionSources(changed),/Gateway reproduction/);
});
test('Gateway reproduction compiler and lock are separate from accepted Auth and candidate toolchains',()=>{
 const evidence=assertGatewayReproductionToolchain(gatewayReproductionToolchain());
 assert.equal(evidence.originalPublisherKnown,false);assert.equal(evidence.historicalSourceAssociationVerified,false);assert.equal(evidence.deploymentReadiness,false);assert.equal(RELEASE_TOOLCHAIN.wrangler,'4.86.0');
 for(const [key,value] of [['nodeVersion','22.0.0'],['wranglerVersion','4.86.0'],['packageSha256','0'.repeat(64)],['lockSha256','0'.repeat(64)],['dependencyLabel','../../../../../../tmp/gateway-cors/node_modules']])assert.throws(()=>assertGatewayReproductionToolchain({...gatewayReproductionToolchain(),[key]:value}),/Fixed Gateway/);
});
test('Gateway reproduction requires the complete actual 18-input compiler graph, including nonemitted polyfill inputs',()=>{
 const paths=[...Object.keys(GATEWAY_REPRODUCTION_SOURCES),'node_modules/unenv/dist/runtime/_internal/utils.mjs','node_modules/unenv/dist/runtime/node/internal/perf_hooks/performance.mjs','node_modules/unenv/dist/runtime/node/internal/perf_hooks/histogram.mjs','node_modules/unenv/dist/runtime/node/internal/perf_hooks/constants.mjs','node_modules/unenv/dist/runtime/node/perf_hooks.mjs','node_modules/@cloudflare/unenv-preset/dist/runtime/polyfill/performance.mjs'];
 const inputs=paths.map(path=>({path,sha256:'a'.repeat(64)}));assert.doesNotThrow(()=>assertGatewayReproductionGraph(inputs));
 for(const changed of [inputs.slice(1),[...inputs,inputs[0]],inputs.map((r,i)=>i?r:{...r,path:'node_modules/unknown.mjs'})])assert.throws(()=>assertGatewayReproductionGraph(changed),/emitted input graph/);
});
test('Gateway reproduction never accepts body size alone or comment-normalized bytes',()=>{
 assert.throws(()=>assertGatewayReproductionBytes(Buffer.alloc(GATEWAY_REPRODUCTION.moduleBytes)),/raw module bytes/);
 assert.throws(()=>assertGatewayReproductionBytes(Buffer.alloc(146913)),/raw module bytes/);
});
test('Gateway reproduction package and whole npm lock agree with their fixed audited identities',async()=>{
 const {createHash}=await import('node:crypto');
 const directory=new URL('../tools/inactive-help-gateway-reproduction/',import.meta.url);
 const pkg=await readFile(new URL('package.json',directory)),lock=await readFile(new URL('package-lock.json',directory));
 assert.equal(createHash('sha256').update(pkg).digest('hex'),GATEWAY_REPRODUCTION.packageSha256);assert.equal(createHash('sha256').update(lock).digest('hex'),GATEWAY_REPRODUCTION.lockSha256);
 const packageJson=JSON.parse(pkg),lockJson=JSON.parse(lock);assert.equal(packageJson.dependencies.wrangler,'4.68.1');assert.deepEqual(lockJson.packages[''].dependencies,packageJson.dependencies);assert.equal(lockJson.packages['node_modules/wrangler'].version,'4.68.1');assert.equal(lockJson.packages['node_modules/unenv'].version,'2.0.0-rc.24');assert.equal(lockJson.packages['node_modules/@cloudflare/unenv-preset'].version,'2.14.0');
});
