import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {Miniflare} from 'miniflare';
import {mkdtemp,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
const built=await build({stdin:{resolveDir:process.cwd(),contents:`
import {DurableObject} from 'cloudflare:workers';
import {DurableVapiBusinessJournal} from './packages/shared/src/communications/vapi-business-journal.mjs';
import {VapiBusinessFunctionAdapter} from './packages/shared/src/communications/vapi-business-function.mjs';
import {savedAgents} from './packages/shared/src/communications/vapi-agent-library.mjs';
export class FixtureJournal extends DurableObject {
 async fetch(request){try{
  const journal=new DurableVapiBusinessJournal(this.ctx.storage);
  if(new URL(request.url).pathname==='/protocol'){
   const adapter=new VapiBusinessFunctionAdapter({authenticate:async()=>true,authorize:async()=>true,journal,contexts:{current:async()=>({scopeKey:'fixture_native_scope',agentKey:'qualification',assistantId:savedAgents.qualification,expiresAt:Date.now()+60000,runner:{functionDefinitions:()=>[{function:{name:'fixture_write'}}],executeFunction:async()=>{const n=(await this.ctx.storage.get('fixture_mutations')??0)+1;await this.ctx.storage.put('fixture_mutations',n);return {saved:true,mutationCount:n};}}})}});
   return adapter.respond(request);
  }
  if(new URL(request.url).pathname==='/count')return Response.json(await this.ctx.storage.get('fixture_mutations'));
  const {action,entry}=await request.json();if(!['begin','complete'].includes(action))throw Error();const result=await journal[action](entry);return Response.json(result??{completed:true});
 }catch{return Response.json({error:'denied'},{status:409});}}
}
export default {fetch(request,env){return env.JOURNALS.get(env.JOURNALS.idFromName('isolated-business-test')).fetch(request);}};
`},bundle:true,write:false,format:'esm',platform:'neutral',external:['cloudflare:workers','node:*']});
const dir=await mkdtemp(join(tmpdir(),'vapi-business-journal-'));
const options={modules:true,script:built.outputFiles[0].text,compatibilityDate:process.env.LOCAL_WORKER_DATE||'2026-07-30',compatibilityFlags:['nodejs_compat'],durableObjects:{JOURNALS:{className:'FixtureJournal',useSQLite:true}},durableObjectsPersist:dir};
let runtime=new Miniflare(options);
const entry={callId:'11111111-1111-4111-8111-111111111111',scopeKey:'business_owned_scope',toolCallId:'tool_one',digest:'a'.repeat(64)};
const send=(action,value=entry)=>runtime.dispatchFetch('https://fixture.invalid',{method:'POST',body:JSON.stringify({action,entry:value})});
try{
 const claims=await Promise.all(Array.from({length:20},()=>send('begin').then(r=>r.json())));
 assert.equal(claims.filter(r=>r.status==='new').length,1);assert.equal(claims.filter(r=>r.status==='pending').length,19);
 await runtime.dispose();runtime=new Miniflare(options);
 assert.equal((await (await send('begin')).json()).status,'pending');
 assert.equal((await send('begin',{...entry,digest:'b'.repeat(64)})).status,409);
 assert.equal((await send('complete',{...entry,toolCallId:'missing',result:'{}'})).status,409);
 assert.equal((await send('complete',{...entry,result:'x'.repeat(8193)})).status,409);
 const completed={...entry,result:JSON.stringify({saved:true,requestId:'saved-request'})};
 assert.equal((await send('complete',completed)).status,200);
 assert.equal((await send('complete',completed)).status,200);
 assert.equal((await send('complete',{...completed,result:'changed'})).status,409);
 await runtime.dispose();runtime=new Miniflare(options);
 assert.deepEqual(await (await send('begin')).json(),{status:'complete',digest:entry.digest,result:completed.result});
 for(const patch of [{scopeKey:'other_scope'},{callId:'22222222-2222-4222-8222-222222222222'},{toolCallId:'other_tool'}])assert.equal((await (await send('begin',{...entry,...patch})).json()).status,'new');
 for(const patch of [{scopeKey:''},{toolCallId:'../bad'},{callId:'unknown'},{digest:'bad'}])assert.equal((await send('begin',{...entry,...patch})).status,409);
 const protocol=()=>runtime.dispatchFetch('https://fixture.invalid/protocol',{method:'POST',headers:{'content-type':'application/json'},body:JSON.stringify({message:{type:'tool-calls',call:{id:entry.callId},toolCallList:[{id:'protocol_one',type:'function',function:{name:'fixture_write',arguments:{}}}]}})});
 const responses=await Promise.all(Array.from({length:20},()=>protocol().then(r=>r.json())));
 assert.ok(responses.some(r=>r.results[0].result));
 assert.equal(await (await runtime.dispatchFetch('https://fixture.invalid/count')).json(),1);
 await runtime.dispose();runtime=new Miniflare(options);
 assert.deepEqual(JSON.parse((await (await protocol()).json()).results[0].result),{saved:true,mutationCount:1});
 assert.equal(await (await runtime.dispatchFetch('https://fixture.invalid/count')).json(),1);
 console.log('VAPI_BUSINESS_JOURNAL_PASS real durable storage: 20 concurrent claims, pending and completed restart survival, digest conflict, immutable completion, bounded result, call/scope/tool isolation; no provider or customer writes');
}finally{await runtime.dispose();await rm(dir,{recursive:true,force:true});}
