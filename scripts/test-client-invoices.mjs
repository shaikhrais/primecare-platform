import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';
const out=await build({entryPoints:['packages/shared/src/client-invoices/client.ts'],bundle:true,write:false,format:'esm',platform:'node'});
const {ClientInvoices,validateInvoicePage}=await import('data:text/javascript;base64,'+Buffer.from(out.outputFiles[0].text).toString('base64'));
const invoice={id:'invoice-one',status:null,currency:null,subtotal:null,tax:'0.000000001',total:'12345678901234567890.123456789',created_at:'2026-11-13T00:00:00.000Z',updated_at:'2026-11-13T01:00:00.000Z'};
const page=(offset=0,total=1)=>({invoices:offset?[]:[{...invoice}],pagination:{limit:25,offset,total,hasMore:offset+25<total}});
function fixture(){let current=true,tenant='tenant',roles='guest',user='owner',deny=0,block;const calls=[];const response=v=>new Response(JSON.stringify(v),{headers:{'content-type':'application/json'}});const fetcher=async(url,init)=>{calls.push({url,init});if(deny)return new Response('',{status:deny});if(url.endsWith('/v1/auth/me'))return response({status:'authenticated',userId:user,tenantId:tenant,roles});if(block)await block;const offset=Number(new URL(url).searchParams.get('offset'));return response(page(offset));};const expected={userId:'owner',role:'guest'},client=new ClientInvoices('https://api.invalid','session',expected,()=>current,fetcher);return {client,expected,calls,setTenant:v=>tenant=v,setUser:v=>user=v,setRoles:v=>roles=v,setDeny:v=>deny=v,stale:()=>current=false,block:v=>block=v};}
test('nullable exact decimals and immutable server snapshots are preserved',()=>{const p=validateInvoicePage(page());assert.equal(p.invoices[0].total,invoice.total);assert.equal(p.invoices[0].subtotal,null);assert.ok(Object.isFrozen(p.invoices[0]));});
test('malformed amounts, extra fields, impossible dates, duplicates and inconsistent pagination fail closed',()=>{for(const change of [{total:1.23},{tax:'NaN'},{subtotal:'1e3'},{created_at:'2026-02-30T00:00:00.000Z'},{private_processor_id:'hidden'}]){const p=page();Object.assign(p.invoices[0],change);assert.throws(()=>validateInvoicePage(p));}for(const mutate of [p=>p.invoices.push({...invoice}),p=>p.pagination.hasMore=true,p=>p.pagination.limit=100,p=>p.pagination.total=-1,p=>p.owner='other']){const p=page();mutate(p);assert.throws(()=>validateInvoicePage(p));}});
test('owned reads use captured bearer and no mutation or owner selectors',async()=>{const f=fixture();await f.client.load();assert.equal(f.client.current.status,'ready');assert.deepEqual(f.calls.map(c=>new URL(c.url).pathname),['/v1/auth/me','/v1/client/invoices','/v1/auth/me']);for(const c of f.calls){assert.equal(c.init.method,'GET');assert.equal(c.init.headers.authorization,'Bearer session');assert.equal(c.init.cache,'no-store');assert.equal(c.init.credentials,'omit');assert.equal(c.init.redirect,'error');}assert.equal(new URL(f.calls[1].url).search,'?limit=25&offset=0');f.client.dispose();});
test('binding is captured rather than changed by a mutable caller object',async()=>{const f=fixture();f.expected.userId='other';await f.client.load();assert.equal(f.client.current.status,'ready');f.client.dispose();});
test('server tenant or role changes clear the previous private page',async()=>{for(const change of [f=>f.setTenant('other'),f=>f.setRoles('admin'),f=>f.setUser('other')]){const f=fixture();await f.client.load();change(f);await f.client.load();assert.equal(f.client.current.status,'error');assert.equal(f.client.current.page,null);assert.equal(f.client.current.error,'scope_changed');f.client.dispose();}});
test('changed roles between owned read and verification never publish a page',async()=>{const f=fixture();let release;f.block(new Promise(r=>release=r));const pending=f.client.load();await new Promise(r=>setImmediate(r));f.setRoles('guest,other');release();await pending;assert.equal(f.client.current.page,null);assert.equal(f.client.current.error,'scope_changed');f.client.dispose();});
test('denial removes existing data and reports only a safe typed error',async()=>{const f=fixture();await f.client.load();f.setDeny(401);await f.client.load();assert.equal(f.client.current.page,null);assert.equal(f.client.current.error,'unauthenticated');f.client.dispose();});
test('scope loss while a body is pending disposes and suppresses late data',async()=>{const f=fixture();let release;f.block(new Promise(r=>release=r));const p=f.client.load();await new Promise(r=>setImmediate(r));f.stale();release();await p;assert.equal(f.client.current.status,'disposed');assert.equal(f.client.current.page,null);});
test('explicit disposal aborts the owned request and late replies cannot revive it',async()=>{const f=fixture();let release;f.block(new Promise(r=>release=r));const p=f.client.load();await new Promise(r=>setImmediate(r));f.client.dispose();release();await p;assert.equal(f.client.current.status,'disposed');assert.ok(f.calls.some(c=>c.init.signal.aborted));});
test('overlapping refreshes accept only the latest owned operation',async()=>{const f=fixture();let release;f.block(new Promise(r=>release=r));const old=f.client.load();await new Promise(r=>setImmediate(r));f.block(null);await f.client.load(25);release();await old;assert.equal(f.client.current.page.pagination.offset,25);f.client.dispose();});
test('invalid offsets and insecure arbitrary origins never dispatch',async()=>{const f=fixture();for(const n of [-1,1,100025,NaN])await assert.rejects(f.client.load(n));assert.equal(f.calls.length,0);assert.throws(()=>new ClientInvoices('http://outside.invalid','s',{userId:'x',role:'guest'},()=>true));assert.throws(()=>new ClientInvoices('https://api.invalid/path','s',{userId:'x',role:'guest'},()=>true));f.client.dispose();});
test('oversized response bodies are cancelled and never retained',async()=>{const f=new ClientInvoices('https://api.invalid','s',{userId:'owner',role:'guest'},()=>true,async()=>new Response(' '.repeat(140000),{headers:{'content-type':'application/json'}}));await f.load();assert.equal(f.current.page,null);assert.equal(f.current.error,'invalid_response');f.dispose();});

test('injected fetch is called as a function without binding the client as receiver',async()=>{const f=new ClientInvoices('https://api.invalid','s',{userId:'owner',role:'guest'},()=>true,async function(url){assert.equal(this,undefined);return new Response(JSON.stringify(url.endsWith('/v1/auth/me')?{status:'authenticated',userId:'owner',tenantId:'tenant',roles:'guest'}:page()),{headers:{'content-type':'application/json'}});});await f.load();assert.equal(f.current.status,'ready');f.dispose();});

const selfReply=()=>new Response(JSON.stringify({status:'authenticated',userId:'owner',tenantId:'tenant',roles:'guest'}),{headers:{'content-type':'application/json'}});
function replyFixture(invoiceReply){const calls=[];let current=true;const client=new ClientInvoices('https://api.invalid','session',{userId:'owner',role:'guest'},()=>current,async(url,init)=>{calls.push({url,init});return url.endsWith('/v1/auth/me')?selfReply():invoiceReply();});return {client,calls,stale:()=>current=false};}
for(const length of ['999999','-1','1.5','not-a-length'])test('advertised invoice response length '+length+' is rejected before reading a small valid body',async()=>{
 let cancelled=0,pulls=0;const bytes=new TextEncoder().encode(JSON.stringify(page()));
 const f=replyFixture(()=>new Response(new ReadableStream({pull(controller){if(pulls++===0)controller.enqueue(bytes);else controller.close();},cancel(){cancelled++;}}),{headers:{'content-type':'application/json','content-length':length}}));
 await f.client.load();assert.equal(f.client.current.status,'error');assert.equal(f.client.current.error,'invalid_response');assert.equal(f.client.current.page,null);assert.equal(f.calls.length,2);assert.equal(cancelled,1);assert.ok(pulls<=1);f.client.dispose();
});
for(const [name,bytes] of [['malformed UTF8',new Uint8Array([0xc3,0x28])],['malformed JSON',new TextEncoder().encode('{')]])test(name+' invoice response maps to invalid_response and never retains a page',async()=>{
 const f=replyFixture(()=>new Response(bytes,{headers:{'content-type':'application/json'}}));await f.client.load();assert.equal(f.client.current.error,'invalid_response');assert.equal(f.client.current.page,null);assert.equal(f.calls.length,2);f.client.dispose();
});
test('a valid bounded advertised length retains the exact owned-read sequence and decimals',async()=>{
 const bytes=new TextEncoder().encode(JSON.stringify(page())),f=replyFixture(()=>new Response(bytes,{headers:{'content-type':'application/json','content-length':String(bytes.length)}}));await f.client.load();assert.equal(f.client.current.status,'ready');assert.equal(f.client.current.page.invoices[0].total,invoice.total);assert.equal(f.calls.length,3);f.client.dispose();
});
for(const [status,error] of [[401,'unauthenticated'],[403,'forbidden'],[404,'unavailable'],[500,'request_failed']])test('HTTP '+status+' mapping precedes body decoding and preserves safe error '+error,async()=>{
 const f=replyFixture(()=>new Response(new Uint8Array([0xc3]),{status,headers:{'content-type':'application/json','content-length':'not-a-length'}}));await f.client.load();assert.equal(f.client.current.error,error);assert.equal(f.client.current.page,null);assert.equal(f.calls.length,2);f.client.dispose();
});
test('scope loss during a streamed invoice read cancels the reader and suppresses late bytes',async()=>{
 let controller,cancelled=0;let started;const reading=new Promise(resolve=>started=resolve);
 const f=replyFixture(()=>new Response(new ReadableStream({pull(c){controller=c;started();return new Promise(()=>{});},cancel(){cancelled++;}}),{headers:{'content-type':'application/json'}}));
 const pending=f.client.load();await reading;f.stale();controller.enqueue(new TextEncoder().encode(JSON.stringify(page())));await pending;
 assert.equal(f.client.current.status,'disposed');assert.equal(f.client.current.page,null);assert.equal(f.calls.length,2);assert.equal(cancelled,1);
});

for(const stage of [1,2,3])for(const retirement of ['dispose','replacement'])test('stalled invoice read phase '+stage+' settles on '+retirement+' before another byte',async()=>{
 let started,source,cancelled=0;const ready=new Promise(r=>started=r),calls=[];
 const client=new ClientInvoices('https://api.invalid','session',{userId:'owner',role:'guest'},()=>true,async(url,init)=>{
  calls.push({url,init});if(calls.length===stage){started();return new Response(new ReadableStream({start(c){source=c;},cancel(){cancelled++;}}),{headers:{'content-type':'application/json'}});}
  return url.endsWith('/v1/auth/me')?selfReply():Response.json(page());
 });
 const pending=client.load();await ready;await new Promise(r=>setImmediate(r));
 if(retirement==='dispose')client.dispose();else await client.load();
 let timer;const observed=await Promise.race([pending.then(()=>true),new Promise(r=>timer=setTimeout(()=>r(false),100))]);clearTimeout(timer);
 try{
  assert.equal(observed,true,'owned retirement must settle without a further response byte');assert.equal(cancelled,1);assert.equal(calls[stage-1].init.signal.aborted,true);
  if(retirement==='dispose'){assert.equal(client.current.status,'disposed');assert.equal(client.current.page,null);assert.equal(calls.length,stage);}
  else{assert.equal(client.current.status,'ready');assert.equal(client.current.page.invoices[0].total,invoice.total);assert.equal(calls.length,stage+3);assert.equal(calls.at(-1).init.signal.aborted,false);}
  for(const call of calls){assert.equal(call.init.method,'GET');assert.equal(call.init.cache,'no-store');assert.equal(call.init.headers.authorization,'Bearer session');}
 }finally{if(!observed){source.enqueue(new TextEncoder().encode('{}'));await pending;}client.dispose();}
});
