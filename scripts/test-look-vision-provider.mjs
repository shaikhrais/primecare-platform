import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {execFileSync} from 'node:child_process';
import {mkdtempSync,readFileSync,rmSync} from 'node:fs';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
const result=await build({entryPoints:['cloudflare/workers/src/look/vision-provider.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {default:worker,VisionReviewJob,reviewImage}=await import('data:text/javascript;base64,'+Buffer.from(result.outputFiles[0].text).toString('base64'));
const registry=JSON.parse(readFileSync('packages/shared/src/look/registry.json','utf8'));
// Synthetic 1-pixel PNG, solely for testing private provider transport and replay behavior.
const image='iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+aM/8AAAAASUVORK5CYII=';
const imageDigest=Buffer.from(await crypto.subtle.digest('SHA-256',Buffer.from(image,'base64'))).toString('hex');
const job={reviewId:crypto.randomUUID(),imageDigest,image,context:{screen:'founder_growth_dashboard',platform:'web',width:320,height:800,locale:'en',build:'synthetic-build',theme:'daylight',layout:'standard'},rubric:{criteria:registry.criteria,minimumAverage:registry.minimumAverage,minimumCriterion:registry.minimumCriterion,instruction:'Synthetic caller instruction; must not override server policy'}};
const env={OPENAI_API_KEY:'synthetic-test-key',LOOK_AI_MODEL:'configured-vision-model'};
const request=(body=job,key=body.reviewId+'-'+body.imageDigest)=>new Request('https://look-ai/review',{method:'POST',headers:{'content-type':'application/json','idempotency-key':key},body:JSON.stringify(body)});
const assessment={scores:Object.fromEntries(registry.criteria.map(k=>[k,90])),summary:'Synthetic visual assessment',findings:[]};
const completion=(changes={})=>Response.json({status:'completed',model:'configured-vision-model-snapshot',output:[{type:'message',role:'assistant',content:[{type:'output_text',text:JSON.stringify(assessment)}]}],...changes});
function storage(initial){const records=new Map(initial?[['job',initial]]:[]);let queue=Promise.resolve();const s={get:async k=>structuredClone(records.get(k)),put:async(k,v)=>records.set(k,structuredClone(v)),transaction:fn=>{const next=queue.then(()=>fn(s));queue=next.catch(()=>{});return next;},records};return s;}

test('actual PNG transport uses server credentials, untrusted-data instructions and strict schema',async()=>{
 const report=await reviewImage(job,env,async(url,options)=>{
  assert.equal(url,'https://api.openai.com/v1/responses');assert.equal(options.redirect,'manual');assert.equal(options.headers.authorization,'Bearer synthetic-test-key');
  const payload=JSON.parse(options.body);assert.equal(payload.store,false);assert.equal(payload.model,env.LOOK_AI_MODEL);assert.equal(payload.text.format.strict,true);assert.equal(payload.text.format.schema.additionalProperties,false);assert.deepEqual(payload.text.format.schema.properties.scores.required,registry.criteria);
  assert.equal(payload.input[0].content[1].image_url,'data:image/png;base64,'+image);assert.equal(payload.input[0].content[1].detail,'high');assert.ok(payload.instructions.includes('untrusted'));assert.ok(!payload.instructions.includes(job.rubric.instruction));
  return completion();
 });assert.equal(report.imageDigest,imageDigest);assert.equal(report.model,'configured-vision-model-snapshot');assert.ok(!('passed' in report));assert.ok(!JSON.stringify(report).includes(env.OPENAI_API_KEY));
});

test('refusals, incomplete output, missing scores, extra fields and provider failures cannot pass',async()=>{
 const invalid=[new Response(null,{status:302,headers:{location:'https://unexpected.example'}}),completion({status:'incomplete'}),completion({output:[{type:'message',role:'assistant',content:[{type:'refusal',refusal:'Synthetic refusal'}]}]}),completion({output:[{type:'message',role:'assistant',content:[{type:'output_text',text:JSON.stringify({...assessment,scores:{layout:99}})}]}]}),completion({output:[{type:'message',role:'assistant',content:[{type:'output_text',text:JSON.stringify({...assessment,approved:true})}]}]}),Response.json({error:'synthetic provider key text'}, {status:401})];
 for(const response of invalid)await assert.rejects(reviewImage(job,env,async()=>response));
 await assert.rejects(reviewImage(job,env,async()=>new Response('x'.repeat(262145))),/./);
});

test('provider timeout includes transports that ignore cancellation',async()=>{
 let signal;await assert.rejects(reviewImage(job,env,async(_url,init)=>{signal=init.signal;return new Promise(()=>{});},5),/provider_timeout/);assert.equal(signal.aborted,true);
});

test('private entry validates exact digest/rubric/key and fails closed without configuration',async()=>{
 for(const [body,key] of [[{...job,imageDigest:'0'.repeat(64)},undefined],[{...job,rubric:{...job.rubric,minimumAverage:0}},undefined],[job,'wrong-key'],[{...job,actor:'spoofed'},undefined]])assert.equal((await worker.fetch(request(body,key),env)).status,400);
 assert.equal((await worker.fetch(request(),{})).status,503);
 assert.equal((await worker.fetch(new Request('https://look-ai/other'),env)).status,404);
 assert.equal((await worker.fetch(new Request('https://look-ai/review'),env)).status,405);
 assert.equal((await worker.fetch(new Request('https://look-ai/review',{method:'POST',headers:{'content-type':'application/json','content-length':'1500001'},body:'{}'}),env)).status,413);
});

test('durable completed replay survives job recreation and rejects changed context',async()=>{
 const s=storage(),oldFetch=globalThis.fetch;let calls=0;
 globalThis.fetch=async()=>{calls++;return completion();};
 try{const first=new VisionReviewJob({storage:s},env);assert.equal((await first.fetch(request())).status,200);const recreated=new VisionReviewJob({storage:s},env);assert.equal((await recreated.fetch(request())).status,200);assert.equal(calls,1);assert.equal((await recreated.fetch(request({...job,context:{...job.context,build:'changed'}}))).status,409);assert.equal(calls,1);const persisted=JSON.stringify([...s.records.values()]);assert.ok(!persisted.includes(image));assert.ok(!persisted.includes(env.OPENAI_API_KEY));}
 finally{globalThis.fetch=oldFetch;}
});

test('concurrent pending claim never sends a second provider request',async()=>{
 const s=storage(),oldFetch=globalThis.fetch;let calls=0,release,started;
 const begun=new Promise(r=>started=r);globalThis.fetch=async()=>{calls++;started();return new Promise(r=>release=()=>r(completion()));};
 try{const object=new VisionReviewJob({storage:s},env),first=object.fetch(request());await begun;assert.equal((await new VisionReviewJob({storage:s},env).fetch(request())).status,503);release();assert.equal((await first).status,200);assert.equal(calls,1);}
 finally{globalThis.fetch=oldFetch;}
});

test('terminal provider failure is replayed and storage failure cannot trigger provider I/O',async()=>{
 const s=storage(),oldFetch=globalThis.fetch;let calls=0;globalThis.fetch=async()=>{calls++;return Response.json({error:env.OPENAI_API_KEY},{status:500});};
 try{assert.equal((await new VisionReviewJob({storage:s},env).fetch(request())).status,502);const replay=await new VisionReviewJob({storage:s},env).fetch(request());assert.equal(replay.status,502);assert.ok(!(await replay.text()).includes(env.OPENAI_API_KEY));assert.equal(calls,1);const broken=storage();broken.put=async()=>{throw Error('Synthetic write failure');};assert.equal((await new VisionReviewJob({storage:broken},env).fetch(request())).status,503);assert.equal(calls,1);
 const uncertain=storage(),write=uncertain.put;let writes=0;uncertain.put=async(k,v)=>{if(++writes===2)throw Error('Synthetic receipt failure');return write(k,v);};assert.equal((await new VisionReviewJob({storage:uncertain},env).fetch(request())).status,503);assert.equal(calls,2);assert.equal((await new VisionReviewJob({storage:uncertain},env).fetch(request())).status,503);assert.equal(calls,2);}
 finally{globalThis.fetch=oldFetch;}
});

test('generated provider has no public routes, no embedded key and an explicit durable migration',()=>{
 const dir=mkdtempSync(join(tmpdir(),'vision-config-'));
 try{execFileSync(process.execPath,['scripts/generate-cloudflare-worker-config.mjs',dir],{env:{...process.env,LOOK_AI_SERVICE:'primecare-look-ai',LOOK_AI_MODEL:env.LOOK_AI_MODEL,OPENAI_API_KEY:env.OPENAI_API_KEY}});const raw=readFileSync(join(dir,'look-ai.jsonc'),'utf8'),config=JSON.parse(raw);assert.equal(config.workers_dev,false);assert.equal(config.preview_urls,false);assert.deepEqual(config.routes,[]);assert.equal(config.observability.enabled,false);assert.ok(!raw.includes(env.OPENAI_API_KEY));assert.deepEqual(config.migrations,[{tag:'vision-provider-v1',new_sqlite_classes:['VisionReviewJob']}]);const governance=JSON.parse(readFileSync(join(dir,'governance.jsonc'),'utf8'));assert.deepEqual(governance.services,[{binding:'LOOK_AI',service:'primecare-look-ai'}]);}
 finally{rmSync(dir,{recursive:true,force:true});}
});
