import {build} from 'esbuild';import {test} from 'node:test';import assert from 'node:assert/strict';
const plugin={name:'fixture',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:'export class Client {async connect(){} async end(){} async query(s,v){return globalThis.__paymentQuery(s,v)}}',loader:'js'}));}};
async function bundle(path,plugins=[]){const r=await build({entryPoints:[path],bundle:true,write:false,platform:'node',format:'esm',plugins});return import('data:text/javascript;base64,'+Buffer.from(r.outputFiles[0].text).toString('base64'));}
const {clientSelf}=await bundle('cloudflare/workers/src/client-self.ts',[plugin]),{default:gateway}=await bundle('cloudflare/workers/src/gateway.ts'),{default:service}=await bundle('cloudflare/workers/src/service.ts',[plugin]);
let queries,actor,profiles,invoiceFound,paymentFound,payment,groups,total,fail;
function fixture(){queries=[];actor={id:'user',tenant_id:'tenant'};profiles=[{id:'profile'}];invoiceFound=true;paymentFound=true;payment={id:'payment',amount:'100.1000',status:'pending',created_at:'2026-01-01T12:00:00Z',updated_at:'2026-01-01T12:00:00Z',stripe_payment_intent_id:'private'};groups=[{status:'pending',count:2},{status:null,count:1}];total=2;fail=false;globalThis.__paymentQuery=async(sql,values)=>{
 queries.push({sql,values});if(fail)throw Error('private database password');
 if(sql.startsWith('SELECT u.id'))return {rows:actor?[actor]:[]};
 if(sql.startsWith('SELECT id,full_name')){assert.deepEqual(values,['user','tenant']);return {rows:profiles};}
 if(sql.startsWith('SELECT id FROM invoices')){assert.deepEqual(values,['profile','tenant','invoice']);assert.ok(sql.includes('client_id::text=$1 AND tenant_id::text=$2 AND id::text=$3'));return {rows:invoiceFound?[{id:'invoice'}]:[]};}
 if(sql.includes('FROM payments')){
  assert.ok(sql.includes('JOIN invoices i ON i.id=pay.invoice_id'));assert.ok(sql.includes('i.client_id::text=$1 AND i.tenant_id::text=$2'));
  const nested=sql.includes(' AND i.id::text=$3'),next=nested?3:2;assert.deepEqual(values.slice(0,next),nested?['profile','tenant','invoice']:['profile','tenant']);
  if(sql.startsWith('SELECT COUNT'))return {rows:[{count:total}]};
  if(sql.startsWith('SELECT pay.status'))return {rows:groups.slice(values[next+1],values[next+1]+values[next])};
  if(sql.includes('AND pay.id::text=$'+(next+1))){return {rows:paymentFound&&values[next]==='payment'?[payment]:[]};}
  assert.ok(sql.includes('ORDER BY pay.created_at DESC,pay.id DESC'));return {rows:paymentFound?(nested?[payment]:[payment,{...payment,id:'payment-2'}].slice(values[next+1],values[next+1]+values[next])):[]};
 }
 if(sql.includes('FROM booking_requests')){assert.ok(sql.includes('client_id::text=$1 AND tenant_id::text=$2'));assert.deepEqual(values.slice(0,2),['profile','tenant']);return {rows:sql.startsWith('SELECT COUNT')?[{count:total}]:groups.slice(values[3],values[3]+values[2])};}
 assert.ok(sql.startsWith('BEGIN')||sql==='ROLLBACK',sql);return {rows:[]};};}
const token='a'.repeat(43),env={SERVICE_NAME:'client',DB_URL:'fixture'},base='/invoices/invoice/payments',paths=['/booking-requests/summary',base,base+'/payment',base+'/summary'];
const call=(path,query='',headers={},method='GET',extra={})=>clientSelf(new Request('https://fixture'+path+query,{method,headers:{authorization:'Bearer '+token,...headers}}),{...env,...extra},path,{});
test('batch 23 booking request groups reserve summary route and page status groups',async()=>{fixture();const r=await call(paths[0],'?limit=1&offset=1');assert.equal(r.status,200);assert.deepEqual(await r.json(),{groups:[{status:null,count:1}],pagination:{limit:1,offset:1,total:2,hasMore:false}});assert.equal(r.headers.get('cache-control'),'no-store');assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(queries.some(q=>q.sql.includes('ORDER BY status NULLS LAST')));});
test('batch 24 payment list/detail expose exact decimal metadata and exclude processor IDs',async()=>{for(const path of [base,base+'/payment']){fixture();const r=await call(path,path===base?'?limit=1':'');assert.equal(r.status,200);const b=await r.json(),p=b.payment??b.payments[0];assert.deepEqual(Object.keys(p),['id','amount','status','created_at','updated_at']);assert.equal(p.amount,'100.1000');assert.ok(!JSON.stringify(b).includes('private'));assert.equal(r.headers.get('cache-control'),'no-store');assert.equal(queries.at(-1).sql,'ROLLBACK');}});
test('batch 24 absent/foreign invoice denies list, detail and summary before payment queries',async()=>{for(const path of paths.slice(1)){fixture();invoiceFound=false;assert.equal((await call(path)).status,404);assert.ok(!queries.some(q=>q.sql.includes('FROM payments')));}});
test('batch 24 absent or differently owned payment detail returns 404',async()=>{fixture();paymentFound=false;assert.equal((await call(base+'/payment')).status,404);});
test('batch 25 invoice payment groups page statuses with null last and group totals',async()=>{fixture();const r=await call(base+'/summary','?limit=1&offset=1');assert.equal(r.status,200);assert.deepEqual(await r.json(),{groups:[{status:null,count:1}],pagination:{limit:1,offset:1,total:2,hasMore:false}});assert.ok(queries.some(q=>q.sql.includes('ORDER BY pay.status NULLS LAST')));});
test('booking and payment summaries return empty groups when no owned rows exist',async()=>{for(const path of [paths[0],base+'/summary']){fixture();groups=[];total=0;const b=await (await call(path)).json();assert.deepEqual(b.groups,[]);assert.equal(b.pagination.total,0);}});
for(const path of paths){
 test(path+' denies absent/expired bearer, tenant mismatch and nonunique profile',async()=>{fixture();assert.equal((await call(path,'',{authorization:''})).status,401);assert.equal(queries.length,0);fixture();actor=null;assert.equal((await call(path)).status,401);fixture();assert.equal((await call(path,'',{'x-tenant-id':'other'})).status,403);fixture();profiles=[];assert.equal((await call(path)).status,404);fixture();profiles.push(profiles[0]);assert.equal((await call(path)).status,503);});
 test(path+' rejects owner/status override, duplicate paging and unsupported methods',async()=>{for(const [query,method,status] of [['?clientId=other','GET',400],['?status=paid','GET',400],['?limit=1&limit=2','GET',400],['?offset=100001','GET',400],['','POST',405]]){fixture();assert.equal((await call(path,query,{},method)).status,status);assert.equal(queries.length,0);}});
 test(path+' source throttles and hides database failures',async()=>{fixture();assert.equal((await call(path,'',{},'GET',{WORKSPACE_SOURCE_LIMIT:{limit:async()=>({success:false})}})).status,429);assert.equal(queries.length,0);fixture();fail=true;const r=await call(path);assert.equal(r.status,503);assert.ok(!(await r.text()).includes('password'));});
 test(path+' gateway and service route preserve authorization and response',async()=>{fixture();let forwarded;const r=await gateway.fetch(new Request('https://gateway/v1/client'+path,{headers:{authorization:'Bearer '+token}}),{CLIENT:{fetch:async req=>{forwarded=req;return service.fetch(req,env);}}});assert.equal(r.status,200);assert.equal(new URL(forwarded.url).pathname,path);assert.equal(forwarded.headers.get('authorization'),'Bearer '+token);});
}
test('payment route rejects invalid invoice/payment IDs and detail pagination',async()=>{for(const path of ['/invoices/%2F/payments',base+'/%2F']){fixture();assert.equal((await call(path)).status,400);assert.equal(queries.length,0);}fixture();assert.equal((await call(base+'/payment','?limit=1')).status,400);assert.equal(queries.length,0);fixture();assert.equal(await call(base+'/payment/extra'),null);});
test('payment projection permits null stored amount/status and rejects malformed decimals/dates',async()=>{fixture();payment.amount=null;payment.status=null;assert.equal((await call(base+'/payment')).status,200);for(const [field,value] of [['amount','NaN'],['amount',10],['status',{}],['created_at','not-a-date'],['updated_at',null]]){fixture();payment[field]=value;assert.equal((await call(base+'/payment')).status,503);}});
test('summary projections reject missing/non-string statuses and invalid counts',async()=>{for(const path of [paths[0],base+'/summary'])for(const row of [{status:12,count:1},{count:1},{status:'pending',count:-1},{status:'pending',count:Infinity}]){fixture();groups=[row];assert.equal((await call(path)).status,503);}});
test('Batch 195 booking-request and payment totals reject coercible or invalid counts',async()=>{for(const path of [paths[0],base,base+'/summary'])for(const value of ['2',-1,1.5,Infinity,null]){fixture();total=value;const r=await call(path);assert.equal(r.status,503);assert.deepEqual(await r.json(),{error:'Client data unavailable'});assert.equal(queries.at(-1).sql,'ROLLBACK');}});


const historyPaths=['/payments','/payments/payment','/payments/summary'];
for(const path of historyPaths){
 test(path+' joins owned invoices and exposes only payment metadata through the gateway',async()=>{
  fixture();let forwarded;const response=await gateway.fetch(new Request('https://gateway/v1/client'+path,{headers:{authorization:'Bearer '+token}}),{CLIENT:{fetch:async request=>{forwarded=request;return service.fetch(request,env);}}});assert.equal(response.status,200);assert.equal(new URL(forwarded.url).pathname,path);assert.equal(forwarded.headers.get('authorization'),'Bearer '+token);
  const body=await response.json();assert.ok(!JSON.stringify(body).includes('private'));assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!queries.some(q=>q.sql.startsWith('SELECT id FROM invoices')));const joined=queries.filter(q=>q.sql.includes('FROM payments'));assert.ok(joined.length>0);assert.ok(joined.every(q=>q.sql.includes('i.client_id::text=$1 AND i.tenant_id::text=$2')&&!q.sql.includes('i.id::text=$3')));assert.ok(queries.every(q=>!/^INSERT|^UPDATE|^DELETE/.test(q.sql)));
  if(path!=='/payments/summary'){const item=body.payment??body.payments[0];assert.equal(item.amount,'100.1000');assert.deepEqual(Object.keys(item),['id','amount','status','created_at','updated_at']);}
 });
 test(path+' requires active bearer, matching tenant and unique owned profile',async()=>{
  fixture();assert.equal((await call(path,'',{authorization:''})).status,401);assert.equal(queries.length,0);fixture();actor=null;assert.equal((await call(path)).status,401);fixture();assert.equal((await call(path,'',{'x-tenant-id':'other'})).status,403);fixture();profiles=[];assert.equal((await call(path)).status,404);fixture();profiles.push(profiles[0]);assert.equal((await call(path)).status,503);
 });
 test(path+' rejects owner/invoice/status overrides, malformed paging and writes before SQL',async()=>{
  for(const [query,method,status] of [['?clientId=other','GET',400],['?invoiceId=invoice','GET',400],['?tenant=other','GET',400],['?status=paid','GET',400],['?limit=1&limit=2','GET',400],['?offset=100001','GET',400],['','POST',405]]){fixture();assert.equal((await call(path,query,{},method)).status,status);assert.equal(queries.length,0);}
 });
 test(path+' preserves throttling, sanitized database errors and no-store',async()=>{
  fixture();const limited=await call(path,'',{},'GET',{WORKSPACE_SOURCE_LIMIT:{limit:async()=>({success:false})}});assert.equal(limited.status,429);assert.equal(limited.headers.get('retry-after'),'60');assert.equal(queries.length,0);fixture();fail=true;const response=await call(path);assert.equal(response.status,503);assert.deepEqual(await response.json(),{error:'Client data unavailable'});assert.equal(response.headers.get('cache-control'),'no-store');
 });
}
test('owned payment history pages records and status groups independently with exact totals',async()=>{
 fixture();const first=await (await call('/payments','?limit=1')).json();assert.equal(first.payments.length,1);assert.equal(first.pagination.total,2);assert.equal(first.pagination.hasMore,true);
 fixture();const page=await (await call('/payments','?limit=1&offset=1')).json();assert.equal(page.payments[0].id,'payment-2');assert.equal(page.pagination.total,2);assert.equal(page.pagination.hasMore,false);
 fixture();const summary=await (await call('/payments/summary','?limit=1&offset=1')).json();assert.deepEqual(summary.groups,[{status:null,count:1}]);assert.equal(summary.pagination.total,2);assert.equal(summary.pagination.hasMore,false);
 fixture();paymentFound=false;total=0;groups=[];assert.deepEqual((await (await call('/payments')).json()).payments,[]);assert.deepEqual((await (await call('/payments/summary')).json()).groups,[]);assert.equal((await call('/payments/payment')).status,404);
});
test('owned payment history rejects bad identifiers, detail paging and malformed stored projections',async()=>{
 for(const path of ['/payments/%2F','/payments/payment?limit=1']){fixture();const parts=path.split('?');assert.equal((await call(parts[0],parts[1]?'?'+parts[1]:'')).status,400);assert.equal(queries.length,0);}fixture();assert.equal(await call('/payments/payment/extra'),null);assert.equal((await call('/payments/foreign')).status,404);
 for(const path of ['/payments','/payments/payment'])for(const [field,value] of [['amount','NaN'],['amount',10],['status',{}],['created_at','not-a-date'],['updated_at',null]]){fixture();payment[field]=value;assert.equal((await call(path)).status,503);assert.equal(queries.at(-1).sql,'ROLLBACK');}
 for(const path of ['/payments','/payments/summary'])for(const value of ['2',null,-1,1.5,Infinity]){fixture();total=value;assert.equal((await call(path)).status,503);assert.equal(queries.at(-1).sql,'ROLLBACK');}
 fixture();groups=[{status:'pending',count:'2'}];assert.equal((await call('/payments/summary')).status,503);
});
