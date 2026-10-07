import {build} from 'esbuild';import {test} from 'node:test';import assert from 'node:assert/strict';
const plugin={name:'fixture',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:'export class Client {async connect(){} async end(){} async query(s,v){return globalThis.__lifecycleQuery(s,v)}}',loader:'js'}));}};
async function bundle(path){const r=await build({entryPoints:[path],bundle:true,write:false,platform:'node',format:'esm',plugins:[plugin]});return import('data:text/javascript;base64,'+Buffer.from(r.outputFiles[0].text).toString('base64'));}
const {clientBookingLifecycle}=await bundle('cloudflare/workers/src/client-booking-lifecycle.ts');const {default:gateway}=await bundle('cloudflare/workers/src/gateway.ts');
let queries,actor,profiles,owned,prior,auditFail,sessionValid,count;
const row={id:'request',service_type:'massage',preferred_date:'2026-10-06T12:00:00.000Z',preferred_time:null,status:'pending',created_at:'2026-10-06T12:00:00.000Z',updated_at:'2026-10-06T12:00:00.000Z',notes:'private-note',client_id:'private'};
function fixture(){queries=[];actor={id:'user',tenant_id:'tenant'};profiles=[{id:'profile'}];owned={...row};prior=null;auditFail=false;sessionValid=true;count=1;globalThis.__lifecycleQuery=async(sql,values)=>{
 queries.push({sql,values});
 if(sql.startsWith('SELECT u.id'))return {rows:actor?[actor]:[]};
 if(sql.startsWith('SELECT id FROM client_profiles')){assert.deepEqual(values,['user','tenant']);return {rows:profiles};}
 if(sql.startsWith('SELECT 1 FROM auth_sessions'))return {rows:sessionValid?[{}]:[]};
 if(sql.startsWith('SELECT request_id,request_hash'))return {rows:prior?[prior]:[]};
 if(sql.startsWith('SELECT id FROM booking_requests'))return {rows:owned?[{id:values[2]}]:[]};
 if(sql.startsWith('SELECT id,service_type')){assert.deepEqual(values,['profile','tenant','request']);return {rows:owned?[owned]:[]};}
 if(sql.startsWith('INSERT INTO booking_requests')){assert.deepEqual(values.slice(1,3),['profile','tenant']);assert.ok(sql.includes("'pending'"));return {rows:[{...row,id:values[0]}]};}
 if(sql.startsWith('UPDATE booking_requests')){assert.deepEqual(values,['profile','tenant','request']);return {rows:[{...row,status:'cancelled'}]};}
 if(sql.startsWith('INSERT INTO booking_request_audit')){assert.equal(values[1],'user');assert.equal(values[2],'tenant');assert.ok(!values[8].includes('private'));if(auditFail)throw Error('private database error');return {rows:[{id:'1',request_id:values[0],actor_user_id:values[1],tenant_id:values[2],action:values[3],previous_status:values[4],new_status:values[5],idempotency_key:values[6],request_hash:values[7],response_json:JSON.parse(values[8]),created_at:row.created_at}]};}
 if(sql.startsWith('SELECT COUNT'))return {rows:[{count}]};
 if(sql.startsWith('SELECT id::text'))return {rows:[{id:'1',action:'created',previous_status:null,new_status:'pending',created_at:'2026-10-06T12:00:00.000Z',idempotency_key:'private',request_hash:'private'}]};
 assert.ok(sql==='BEGIN'||sql.startsWith('BEGIN ISOLATION')||sql==='COMMIT'||sql==='ROLLBACK'||sql.startsWith('SELECT pg_advisory'),sql);return {rows:[]};
 };}
const token='a'.repeat(43),env={SERVICE_NAME:'client',DB_URL:'fixture'},input={service_type:'massage',preferred_date:'2026-10-06T12:00:00Z'};
const call=(path='/booking-requests',body=path==='/booking-requests'?input:undefined,method='POST',headers={},extra={})=>clientBookingLifecycle(new Request('https://fixture'+path,{method,headers:{authorization:'Bearer '+token,'content-type':'application/json','idempotency-key':'request-key',...headers},body:body===undefined?undefined:JSON.stringify(body)}),{...env,...extra},path.split('?')[0],{});
test('creation derives client/tenant, projects safe fields and audits before commit',async()=>{fixture();const r=await call();assert.equal(r.status,201);assert.equal((await r.json()).request.status,'pending');assert.equal(r.headers.get('cache-control'),'no-store');assert.equal(queries.at(-1).sql,'COMMIT');assert.ok(queries.findIndex(q=>q.sql.startsWith('INSERT INTO booking_request_audit'))<queries.findIndex(q=>q.sql==='COMMIT'));assert.ok(queries.find(q=>q.sql.startsWith('SELECT u.id')).sql.includes('FOR SHARE OF u'));});
test('cancellation locks owned pending row and updates status plus audit atomically',async()=>{fixture();const r=await call('/booking-requests/request/cancel',undefined);assert.equal(r.status,200);assert.equal((await r.json()).request.status,'cancelled');assert.ok(queries.find(q=>q.sql.startsWith('SELECT id,service_type')).sql.includes('FOR UPDATE'));assert.equal(queries.at(-1).sql,'COMMIT');});
test('failed cancellation audit rolls back and does not leak database errors',async()=>{fixture();auditFail=true;const r=await call('/booking-requests/request/cancel',undefined);assert.equal(r.status,503);assert.ok(!(await r.text()).includes('private'));assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!queries.some(q=>q.sql==='COMMIT'));});
test('failed creation audit rolls back with no success',async()=>{fixture();auditFail=true;assert.equal((await call()).status,503);assert.equal(queries.at(-1).sql,'ROLLBACK');});
test('retries replay stored response without another insert and mismatches conflict',async()=>{fixture();await call();const values=queries.find(q=>q.sql.startsWith('INSERT INTO booking_request_audit')).values;fixture();prior={request_id:values[0],request_hash:values[7],response_json:JSON.parse(values[8])};const r=await call();assert.equal(r.status,201);assert.equal(r.headers.get('idempotency-replayed'),'true');assert.ok(!queries.some(q=>q.sql.startsWith('INSERT')));fixture();prior={request_id:'request',request_hash:'f'.repeat(64),response_json:{}};assert.equal((await call()).status,409);assert.equal(queries.at(-1).sql,'ROLLBACK');});
test('replay rechecks current request ownership',async()=>{fixture();owned=null;prior={request_id:'request',request_hash:'f'.repeat(64),response_json:{}};assert.equal((await call()).status,404);});
test('foreign request and processed request cannot be cancelled',async()=>{fixture();owned=null;assert.equal((await call('/booking-requests/request/cancel',undefined)).status,404);for(const status of ['approved','rejected','cancelled']){fixture();owned.status=status;assert.equal((await call('/booking-requests/request/cancel',undefined)).status,409);assert.ok(!queries.some(q=>q.sql.startsWith('UPDATE')));}});
test('mutation validates bounded input, impossible dates, owner overrides and idempotency key',async()=>{for(const b of [{...input,client_id:'other'},{...input,preferred_date:'2026-02-30T12:00:00Z'},{...input,preferred_date:'tomorrow'},{...input,preferred_time:'25:00'},{...input,service_type:''},{...input,notes:'x'.repeat(2001)},[],null]){fixture();assert.equal((await call('/booking-requests',b)).status,400);assert.equal(queries.length,0);}fixture();assert.equal((await call('/booking-requests',input,'POST',{'idempotency-key':''})).status,400);fixture();assert.equal((await call('/booking-requests',input,'POST',{'content-type':'text/plain'})).status,400);});
test('cancellation rejects bodies, query overrides and malformed IDs',async()=>{for(const path of ['/booking-requests/request/cancel?tenantId=other','/booking-requests/%2F/cancel']){fixture();assert.equal((await call(path,undefined)).status,400);assert.equal(queries.length,0);}fixture();assert.equal((await call('/booking-requests/request/cancel',{})).status,400);});
test('mutations require explicit session, correct tenant and unique owned profile',async()=>{fixture();assert.equal((await call('/booking-requests',input,'POST',{authorization:''})).status,401);fixture();actor=null;assert.equal((await call()).status,401);fixture();assert.equal((await call('/booking-requests',input,'POST',{'x-tenant-id':'other'})).status,403);fixture();profiles=[];assert.equal((await call()).status,404);fixture();profiles.push(profiles[0]);assert.equal((await call()).status,503);fixture();sessionValid=false;assert.equal((await call()).status,401);assert.ok(!queries.some(q=>q.sql.startsWith('INSERT')));});
test('source throttling avoids SQL and returns retry advice',async()=>{fixture();const r=await call('/booking-requests',input,'POST',{}, {WORKSPACE_SOURCE_LIMIT:{limit:async()=>({success:false})}});assert.equal(r.status,429);assert.equal(r.headers.get('retry-after'),'60');assert.equal(queries.length,0);});
test('history requires owned request and projects only lifecycle metadata',async()=>{fixture();const r=await call('/booking-requests/request/audit?limit=1',undefined,'GET');assert.equal(r.status,200);const b=await r.json();assert.equal(b.events[0].action,'created');assert.ok(!JSON.stringify(b).includes('private'));assert.equal(queries.at(-1).sql,'ROLLBACK');fixture();owned=null;assert.equal((await call('/booking-requests/request/audit',undefined,'GET')).status,404);});
test('history rejects coercible pagination totals with a sanitized rollback',async()=>{fixture();count='1';const r=await call('/booking-requests/request/audit',undefined,'GET');assert.equal(r.status,503);assert.deepEqual(await r.json(),{error:'Booking request service unavailable'});assert.equal(queries.at(-1).sql,'ROLLBACK');});
test('wrong methods return Allow and unrelated routes remain delegated',async()=>{fixture();const r=await call('/booking-requests/request/cancel',undefined,'DELETE');assert.equal(r.status,405);assert.equal(r.headers.get('allow'),'POST');assert.equal(queries.length,0);assert.equal(await call('/booking-requests/request',undefined,'GET'),null);});
test('gateway preserves idempotency headers, body and CORS for submission',async()=>{let forwarded;const response=await gateway.fetch(new Request('https://gateway/v1/client/booking-requests',{method:'POST',headers:{authorization:'Bearer '+token,'idempotency-key':'request-key','content-type':'application/json'},body:JSON.stringify(input)}),{CLIENT:{fetch:async r=>{forwarded=r;return Response.json({ok:true},{status:201});}}});assert.equal(response.status,201);assert.equal(forwarded.headers.get('idempotency-key'),'request-key');assert.deepEqual(await forwarded.json(),input);const preflight=await gateway.fetch(new Request('https://gateway/v1/client/booking-requests',{method:'OPTIONS',headers:{origin:'https://primecare-client.pages.dev'}}),{});assert.ok(preflight.headers.get('access-control-allow-headers').includes('Idempotency-Key'));});


const corruptResult=(prefix,change)=>{const base=globalThis.__lifecycleQuery;globalThis.__lifecycleQuery=async(sql,values)=>{const result=await base(sql,values);if(sql.startsWith(prefix))change(result);return result;};};
test('mutation result corruption prevents audit insertion and commit',async()=>{
 for(const path of ['/booking-requests','/booking-requests/request/cancel'])for(const [field,value] of [['id',null],['id','foreign'],['service_type',null],['service_type',''],['preferred_time','25:00'],['preferred_date','2026-02-30T12:00:00Z'],['created_at','now'],['updated_at',null],['status','approved']]){
  fixture();corruptResult(path==='/booking-requests'?'INSERT INTO booking_requests':'UPDATE booking_requests',result=>{result.rows[0][field]=value;});const response=await call(path);assert.equal(response.status,503,field);assert.deepEqual(await response.json(),{error:'Booking request service unavailable'});assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!queries.some(q=>q.sql==='COMMIT'||q.sql.startsWith('INSERT INTO booking_request_audit')));
 }
 for(const rows of [[],[row,row]]){fixture();corruptResult('INSERT INTO booking_requests',result=>{result.rows=rows;});assert.equal((await call()).status,503);assert.equal(queries.at(-1).sql,'ROLLBACK');}
});
test('stored retries validate identity, lifecycle state and timestamps and strip extra fields',async()=>{
 fixture();await call();const values=queries.find(q=>q.sql.startsWith('INSERT INTO booking_request_audit')).values;const saved=JSON.parse(values[8]);
 for(const value of [null,[],{},{request:{...saved.request,id:'foreign'}},{request:{...saved.request,status:'cancelled'}},{request:{...saved.request,created_at:'now'}},{request:{...saved.request,preferred_time:'25:00'}}]){
  fixture();prior={request_id:values[0],request_hash:values[7],response_json:value};const response=await call();assert.equal(response.status,503);assert.equal(response.headers.get('idempotency-replayed'),null);assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!queries.some(q=>q.sql.startsWith('INSERT')));
 }
 fixture();prior={request_id:values[0],request_hash:values[7],response_json:{request:{...saved.request,notes:'private-secret'},secret:'private-secret'}};const response=await call();assert.equal(response.status,201);assert.deepEqual(await response.json(),saved);
});
test('audit history rejects invalid event types, transitions and timestamps',async()=>{
 for(const [field,value] of [['id',1],['id','0'],['action','approved'],['previous_status','approved'],['new_status','cancelled'],['created_at','2026-02-30T12:00:00Z']]){fixture();corruptResult('SELECT id::text',result=>{result.rows[0][field]=value;});const response=await call('/booking-requests/request/audit',undefined,'GET');assert.equal(response.status,503,field);assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!(await response.text()).includes('private'));}
});


test('failed replay rollback removes the success replay marker',async()=>{
 fixture();await call();const values=queries.find(q=>q.sql.startsWith('INSERT INTO booking_request_audit')).values;fixture();prior={request_id:values[0],request_hash:values[7],response_json:JSON.parse(values[8])};const base=globalThis.__lifecycleQuery;globalThis.__lifecycleQuery=async(sql,values)=>{if(sql==='ROLLBACK')throw Error('private-rollback-error');return base(sql,values);};
 const response=await call();assert.equal(response.status,503);assert.equal(response.headers.get('idempotency-replayed'),null);assert.deepEqual(await response.json(),{error:'Booking request service unavailable'});
});

test('batch 294 booking creation and cancellation reject extended-year Date results before audit',async()=>{
 for(const path of ['/booking-requests','/booking-requests/request/cancel'])for(const value of [new Date('+010000-01-01T00:00:00Z'),new Date('-000001-01-01T00:00:00Z')]){
  fixture();const original=globalThis.__lifecycleQuery;
  globalThis.__lifecycleQuery=async(sql,values)=>{const result=await original(sql,values);if(sql.startsWith('INSERT INTO booking_requests')||sql.startsWith('UPDATE booking_requests'))result.rows[0].created_at=value;return result;};
  const response=await call(path,path==='/booking-requests'?input:undefined);
  assert.equal(response.status,503);assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!queries.some(q=>q.sql.startsWith('INSERT INTO booking_request_audit')||q.sql==='COMMIT'));
 }
});

for(const path of ['/booking-requests','/booking-requests/request/cancel'])for(const field of ['request_id','actor_user_id','tenant_id','action','previous_status','new_status','idempotency_key','request_hash','response_json','created_at'])test('batch 347–348 audit confirmation '+path+' '+field,async()=>{fixture();corruptResult('INSERT INTO booking_request_audit',r=>{r.rows[0][field]=field==='previous_status'?'foreign':null;});const response=await call(path);assert.equal(response.status,503);assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!queries.some(q=>q.sql==='COMMIT'));});
for(const prefix of ['SELECT u.id','SELECT id FROM client_profiles','SELECT 1 FROM auth_sessions','SELECT request_id,request_hash','INSERT INTO booking_request_audit'])for(const rows of [null,[null],[{},{}]])test('batch 344–348 invalid cardinality '+prefix+' '+JSON.stringify(rows),async()=>{fixture();corruptResult(prefix,r=>{r.rows=rows;});assert.equal((await call()).status,503);assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!queries.some(q=>q.sql==='COMMIT'));});
for(const prefix of ['SELECT id FROM booking_requests','SELECT COUNT','SELECT id::text'])test('batch 346 audit read cardinality '+prefix,async()=>{fixture();corruptResult(prefix,r=>{r.rows=[...r.rows,...r.rows];});assert.equal((await call('/booking-requests/request/audit?limit=1',undefined,'GET')).status,503);assert.equal(queries.at(-1).sql,'ROLLBACK');});
test('batch 348 cancellation rejects a different locked target',async()=>{fixture();owned.id='foreign';assert.equal((await call('/booking-requests/request/cancel')).status,503);assert.ok(!queries.some(q=>q.sql.startsWith('UPDATE')));});
const {default:deliveryWorker}=await bundle('cloudflare/workers/src/service.ts');
const aliasCall=(body=input,headers={},method='POST',path='/v1/client/bookings/request')=>gateway.fetch(new Request('https://gateway'+path,{method,headers:{authorization:'Bearer '+token,'content-type':'application/json','idempotency-key':'request-key',...headers},body:method==='POST'?JSON.stringify(body):undefined}),{CLIENT:{fetch:r=>deliveryWorker.fetch(r,env)}});
test('legacy booking submission reaches canonical transaction and retries without another write',async()=>{
 fixture();const response=await aliasCall();assert.equal(response.status,201);assert.equal(response.headers.get('x-primecare-gateway'),'cloudflare-worker-typescript');assert.equal(response.headers.get('cache-control'),'no-store');const data=await response.json();assert.equal(data.request.status,'pending');assert.ok(!JSON.stringify(data).includes('private'));
 const values=queries.find(q=>q.sql.startsWith('INSERT INTO booking_request_audit')).values;
 fixture();prior={request_id:values[0],request_hash:values[7],response_json:JSON.parse(values[8])};const replay=await aliasCall();assert.equal(replay.status,201);assert.equal(replay.headers.get('idempotency-replayed'),'true');assert.ok(!queries.some(q=>q.sql.startsWith('INSERT')));
});
test('booking submission alias preserves negative authority, strict input and audit rollback',async()=>{
 fixture();assert.equal((await aliasCall(input,{authorization:''})).status,401);assert.equal(queries.length,0);
 fixture();assert.equal((await aliasCall(input,{'x-tenant-id':'other'})).status,403);assert.ok(!queries.some(q=>q.sql.startsWith('INSERT')));
 fixture();profiles=[];assert.equal((await aliasCall()).status,404);assert.ok(!queries.some(q=>q.sql.startsWith('INSERT')));
 fixture();auditFail=true;assert.equal((await aliasCall()).status,503);assert.equal(queries.at(-1).sql,'ROLLBACK');assert.ok(!queries.some(q=>q.sql==='COMMIT'));
 for(const body of [{...input,client_id:'other'},{...input,tenant_id:'other'},{serviceTypeId:'legacy',date:'2026-10-08',time:'12:00',duration:1}]){fixture();assert.equal((await aliasCall(body)).status,400);assert.equal(queries.length,0);}
 fixture();assert.equal((await aliasCall(input,{'idempotency-key':''})).status,400);assert.equal(queries.length,0);
 fixture();assert.equal((await aliasCall(input,{},'POST','/v1/client/bookings/request?tenant_id=other')).status,400);assert.equal(queries.length,0);
});
test('submission alias matches only its exact path and POST; collection writes remain denied',async()=>{
 for(const method of ['GET','PUT','PATCH','DELETE']){fixture();const response=await aliasCall(input,{},method);assert.equal(response.status,405);assert.equal(response.headers.get('allow'),'POST');assert.equal(queries.length,0);}

});
test('both booking form declarations use the exact submission contract and required retry header',async()=>{
 const {CLIENT_FORMS}=await bundle('packages/domain/src/registries/FormRegistry/client-forms.ts');
 const forms=CLIENT_FORMS.filter(f=>['client.booking-request','client.service-booking-modal'].includes(f.id));assert.equal(forms.length,2);
 for(const form of forms){assert.equal(form.apiEndpoint,'/v1/client/bookings/request');assert.equal(form.method,'POST');assert.deepEqual(form.requiredHeaders,['Idempotency-Key']);assert.deepEqual(form.fields.map(f=>f.name),['service_type','preferred_date','preferred_time','notes']);assert.deepEqual(form.fields.filter(f=>f.required).map(f=>f.name),['service_type','preferred_date']);assert.equal(form.fields[1].type,'text');assert.ok(form.description.includes('UTC'));}
});

const pluralPath='/v1/client/bookings/requests';
test('legacy plural submission reaches owner lifecycle and shares retry scope with singular submission',async()=>{
 fixture();const response=await aliasCall(input,{},'POST',pluralPath);assert.equal(response.status,201);const data=await response.json();assert.equal(data.request.status,'pending');assert.equal(response.headers.get('cache-control'),'no-store');assert.ok(!JSON.stringify(data).includes('private'));
 const values=queries.find(q=>q.sql.startsWith('INSERT INTO booking_request_audit')).values;
 for(const path of [pluralPath,'/v1/client/bookings/request']){fixture();prior={request_id:values[0],request_hash:values[7],response_json:JSON.parse(values[8])};const replay=await aliasCall(input,{},'POST',path);assert.equal(replay.status,201);assert.equal(replay.headers.get('idempotency-replayed'),'true');assert.deepEqual(await replay.json(),data);assert.ok(!queries.some(q=>q.sql.startsWith('INSERT')||q.sql==='COMMIT'));}
 fixture();prior={request_id:values[0],request_hash:values[7],response_json:JSON.parse(values[8])};assert.equal((await aliasCall({...input,service_type:'different'},{},'POST',pluralPath)).status,409);assert.ok(!queries.some(q=>q.sql.startsWith('INSERT')));
});
test('plural request submission enforces credentials, owner profile, tenant and atomic audit',async()=>{
 for(const [headers,setup,status] of [[{authorization:''},()=>{},401],[{},()=>{actor=null;},401],[{'x-tenant-id':'other'},()=>{},403],[{},()=>{profiles=[];},404],[{},()=>{profiles=[{id:'a'},{id:'b'}];},503],[{},()=>{sessionValid=false;},401],[{},()=>{auditFail=true;},503]]){
  fixture();setup();const response=await aliasCall(input,headers,'POST',pluralPath);assert.equal(response.status,status);assert.equal(response.headers.get('cache-control'),'no-store');assert.ok(!queries.some(q=>q.sql==='COMMIT'));if(auditFail)assert.equal(queries.at(-1).sql,'ROLLBACK');else assert.ok(!queries.some(q=>q.sql.startsWith('INSERT')));
 }
});
test('plural request submission rejects invalid input and owner overrides before SQL',async()=>{
 for(const body of [{...input,client_id:'other'},{...input,tenant_id:'other'},{...input,preferred_date:'2026-02-30T12:00:00Z'},{...input,preferred_time:'25:00'},{serviceTypeId:'legacy',date:'2026-10-08'}]){fixture();assert.equal((await aliasCall(body,{},'POST',pluralPath)).status,400);assert.equal(queries.length,0);}
 fixture();assert.equal((await aliasCall(input,{'idempotency-key':''},'POST',pluralPath)).status,400);assert.equal(queries.length,0);
 fixture();assert.equal((await aliasCall(input,{},'POST',pluralPath+'?tenant_id=other')).status,400);assert.equal(queries.length,0);
 for(const method of ['PUT','PATCH','DELETE']){fixture();const response=await aliasCall(input,{},method,pluralPath);assert.equal(response.status,405);assert.equal(queries.length,0);}
 fixture();assert.equal((await aliasCall(input,{},'POST',pluralPath+'/extra')).status,404);assert.equal(queries.length,0);
});
test('legacy submission actions and separate list registry resolve to their intended contracts',async()=>{
 const {TENANCY}=await bundle('packages/domain/src/registries/ApiRegistry/tenancy.ts');
 const {TENANCY_BUTTONS}=await bundle('packages/domain/src/registries/ButtonRegistry/tenancy-buttons.ts');
 const {BASE}=await bundle('packages/domain/src/registries/InteractionRegistry/base.ts');
 assert.equal(TENANCY.CLIENT.BOOKING_REQUESTS,pluralPath);assert.equal(TENANCY.CLIENT.BOOKING_REQUEST_LIST,'/v1/client/booking-requests');
 const actions=TENANCY_BUTTONS.filter(b=>b.id==='btn-client-booking-request');assert.equal(actions.length,1);assert.equal(actions[0].apiPath,pluralPath);assert.equal(actions[0].action,'API_TRIGGER');assert.equal(BASE.CLIENT.ENGAGEMENT.BOOKING_REQUEST.apiEndpoint,pluralPath);
});

test('collection request submission enforces credentials, owner profile, tenant and atomic audit',async()=>{
 for(const [headers,setup,status] of [[{authorization:''},()=>{},401],[{},()=>{actor=null;},401],[{'x-tenant-id':'other'},()=>{},403],[{},()=>{profiles=[];},404],[{},()=>{profiles=[{id:'a'},{id:'b'}];},503],[{},()=>{sessionValid=false;},401],[{},()=>{auditFail=true;},503]]){
  fixture();setup();const response=await aliasCall(input,headers,'POST','/v1/client/bookings');assert.equal(response.status,status);assert.equal(response.headers.get('cache-control'),'no-store');assert.ok(!queries.some(q=>q.sql==='COMMIT'));if(auditFail)assert.equal(queries.at(-1).sql,'ROLLBACK');else assert.ok(!queries.some(q=>q.sql.startsWith('INSERT')));
 }
});
test('collection request submission rejects invalid input and owner overrides before SQL',async()=>{
 for(const body of [{...input,client_id:'other'},{...input,tenant_id:'other'},{...input,preferred_date:'2026-02-30T12:00:00Z'},{...input,preferred_time:'25:00'},{serviceTypeId:'legacy',date:'2026-10-08'}]){fixture();assert.equal((await aliasCall(body,{},'POST','/v1/client/bookings')).status,400);assert.equal(queries.length,0);}
 fixture();assert.equal((await aliasCall(input,{'idempotency-key':''},'POST','/v1/client/bookings')).status,400);assert.equal(queries.length,0);
 fixture();assert.equal((await aliasCall(input,{},'POST','/v1/client/bookings'+'?tenant_id=other')).status,400);assert.equal(queries.length,0);
 for(const method of ['PUT','PATCH','DELETE']){fixture();const response=await aliasCall(input,{},method,'/v1/client/bookings');assert.equal(response.status,405);assert.equal(queries.length,0);}
 fixture();assert.equal((await aliasCall(input,{},'POST','/v1/client/bookings'+'/extra')).status,405);assert.equal(queries.length,0);
});

test('collection submission shares idempotency with both request aliases and preserves GET list routing',async()=>{
 fixture();const response=await aliasCall(input,{},'POST','/v1/client/bookings');assert.equal(response.status,201);const data=await response.json();const values=queries.find(q=>q.sql.startsWith('INSERT INTO booking_request_audit')).values;
 for(const path of ['/v1/client/bookings/request','/v1/client/bookings/requests']){fixture();prior={request_id:values[0],request_hash:values[7],response_json:JSON.parse(values[8])};const replay=await aliasCall(input,{},'POST',path);assert.equal(replay.status,201);assert.deepEqual(await replay.json(),data);assert.ok(!queries.some(q=>q.sql.startsWith('INSERT')));}
 let forwarded;const list=await gateway.fetch(new Request('https://fixture/v1/client/bookings'),{CLIENT:{fetch:async r=>{forwarded=r;return Response.json({bookings:[]});}}});assert.equal(list.status,200);assert.equal(new URL(forwarded.url).pathname,'/bookings');assert.equal(forwarded.method,'GET');
 const {readFileSync}=await import('node:fs');const caller=readFileSync('packages/domain/src/registries/button_registry.ts','utf8').split('\n').find(s=>s.includes("id: 'client-book-req'"));assert.ok(caller.includes("path: '/v1/client/bookings'"));assert.ok(caller.includes('client-booking-form'));assert.ok(caller.includes('Idempotency-Key'));
});
