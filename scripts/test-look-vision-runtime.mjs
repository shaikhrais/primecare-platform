import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {Miniflare,createFetchMock} from 'miniflare';
import {readFileSync,mkdtempSync,rmSync} from 'node:fs';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
const bundle=await build({entryPoints:['cloudflare/workers/src/look/vision-provider.ts'],bundle:true,platform:'neutral',external:['node:*'],format:'esm',write:false});
const registry=JSON.parse(readFileSync('packages/shared/src/look/registry.json','utf8'));
const image='iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+aM/8AAAAASUVORK5CYII=';
const imageDigest=Buffer.from(await crypto.subtle.digest('SHA-256',Buffer.from(image,'base64'))).toString('hex');
const job={reviewId:crypto.randomUUID(),imageDigest,image,context:{screen:'founder_growth_dashboard',platform:'web',width:320,height:800,locale:'en',build:'runtime-fixture',theme:'daylight',layout:'standard'},rubric:{criteria:registry.criteria,minimumAverage:registry.minimumAverage,minimumCriterion:registry.minimumCriterion,instruction:'Synthetic runtime fixture'}};
const init=(value=job)=>({method:'POST',headers:{'content-type':'application/json','idempotency-key':value.reviewId+'-'+value.imageDigest},body:JSON.stringify(value)});
test('workerd executes real durable storage and replays across a runtime restart without outbound AI',async()=>{
 const directory=mkdtempSync(join(tmpdir(),'vision-runtime-')),mock=createFetchMock();mock.disableNetConnect();
 let providerCalls=0;
 mock.get('https://api.openai.com').intercept({path:'/v1/responses',method:'POST'}).reply(200,request=>{
  providerCalls++;
  return JSON.stringify({status:'completed',model:'synthetic-vision-model',output:[{type:'message',role:'assistant',content:[{type:'output_text',text:JSON.stringify({scores:Object.fromEntries(registry.criteria.map(k=>[k,90])),summary:'Synthetic workerd assessment; not real AI',findings:[]})}]}]});
 }).persist();
 const options={modules:true,script:bundle.outputFiles[0].text,compatibilityDate:'2026-08-06',compatibilityFlags:['nodejs_compat'],durableObjects:{VISION_JOBS:{className:'VisionReviewJob',useSQLite:true}},durableObjectsPersist:directory,bindings:{LOOK_AI_MODEL:'synthetic-vision-model',OPENAI_API_KEY:'synthetic-runtime-key'},fetchMock:mock};
 let runtime=new Miniflare(options);
 try{
  const first=await runtime.dispatchFetch('https://look-ai/review',init());assert.equal(first.status,200,(await first.clone().text())+' calls='+providerCalls);assert.equal((await first.json()).imageDigest,imageDigest);assert.equal(providerCalls,1);
  const replay=await runtime.dispatchFetch('https://look-ai/review',init());assert.equal(replay.status,200);assert.equal(providerCalls,1);
  await runtime.dispose();runtime=new Miniflare(options);
  const persisted=await runtime.dispatchFetch('https://look-ai/review',init());assert.equal(persisted.status,200);assert.equal(providerCalls,1);
  assert.equal((await runtime.dispatchFetch('https://look-ai/review',init({...job,context:{...job.context,build:'changed-context'}}))).status,409);assert.equal(providerCalls,1);
 }finally{await runtime.dispose();await mock.close();rmSync(directory,{recursive:true,force:true});}
});
