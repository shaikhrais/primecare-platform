import test from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';
import {postgresStoreFixture} from './help-postgres-store-fixture.mjs';import {pin,table} from './help-reader-service-fixture.mjs';
const compiled=await build({entryPoints:['cloudflare/workers/src/help-reader.ts'],bundle:true,write:false,platform:'node',format:'esm',external:['pg']});
// Resolve the driver's package normally while loading the bundled adapter.
const temporary=new URL('../.help-worker-adapter-test.mjs',import.meta.url);
const {writeFile,unlink}=await import('node:fs/promises');await writeFile(temporary,compiled.outputFiles[0].text);
const {createHelpWorkerAdapter}=await import(temporary.href+'?source='+Date.now());await unlink(temporary);
const token='t'.repeat(43),hash=Array.from(new Uint8Array(await crypto.subtle.digest('SHA-256',new TextEncoder().encode(token)))).map(v=>v.toString(16).padStart(2,'0')).join('');
const input={version:1,locale:'en',action:'list',query:'',offset:0,limit:25},path='/v1/psw/help-support',env={SERVICE_NAME:'governance',DB_URL:'fixture-not-a-production-connection'};
const request=(init={})=>new Request('https://help.test'+path,{method:'POST',headers:{authorization:'Bearer '+token,'content-type':'application/json'},body:JSON.stringify(input),...init});
async function fixture(run){const f=await postgresStoreFixture();try{
 await f.db.query("UPDATE auth_sessions SET token_hash=$1 WHERE user_id='psw-a'",[hash]);
 const connections=[],sql=[],options=[];
 const factory=configuration=>{const index=connections.length,raw=index===0?f.db:f.quota;options.push(configuration);const connection={index,connected:0,ended:0,connect:async()=>{connection.connected++;},query:async(...args)=>{sql.push({index,sql:args[0]});return raw.query(...args);},end:async()=>{connection.ended++;}};connections.push(connection);return connection;};
 let verified=0;const verify=async reader=>{verified++;const rows=(await reader.query('SELECT manifest_sha256 FROM '+table('source_manifest')+' FOR SHARE')).rows;assert.equal(rows[0].manifest_sha256,pin.manifestSha256);};
 await run({...f,connections,sql,options,factory,verify,verified:()=>verified});
}finally{await f.close();}}
const auditCount=async f=>Number((await f.db.query('SELECT count(*) n FROM help_reader_audit')).rows[0].n);
const quotaCount=async f=>Number((await f.db.query('SELECT count(*) n FROM help_reader_rate')).rows[0].n);

test('missing real activation verifier returns503 before creating any connection',async()=>{
 let opened=0;const handle=createHelpWorkerAdapter(undefined,()=>{opened++;throw Error('private connection');});const response=await handle(request(),env,path);
 assert.equal(response.status,503);assert.deepEqual(await response.json(),{version:1,error:{code:'unavailable'}});assert.equal(opened,0);
});
test('only registered service and exact path are candidates; no alias is introduced',async()=>{
 let opened=0;const handle=createHelpWorkerAdapter(async()=>{throw Error();},()=>{opened++;throw Error();});
 assert.equal(await handle(request(),{...env,SERVICE_NAME:'auth'},path),null);
 for(const other of ['/psw/help-support','/v1/help/articles','/help'])assert.equal(await handle(request(),env,other),null);
 assert.equal(opened,0);
});
test('wrong method and tenant override are rejected without database allocation',async()=>{
 let opened=0;const handle=createHelpWorkerAdapter(async()=>{},()=>{opened++;throw Error();});
 for(const req of [request({method:'PATCH'}),request({headers:{authorization:'Bearer '+token,'content-type':'application/json','x-tenant-id':'other'}})])assert.equal((await handle(req,env,path)).status,400);
 assert.equal(opened,0);
});
test('invalid explicit bearer cannot fall back to a valid session cookie',async()=>{
 let opened=0;const handle=createHelpWorkerAdapter(async()=>{},()=>{opened++;throw Error();});const response=await handle(request({headers:{authorization:'Bearer invalid',cookie:'session_token='+token,'content-type':'application/json'}}),env,path);
 assert.equal(response.status,401);assert.equal(opened,0);
});
test('composes real registered reader/store with separate bounded client ports and mandatory gate',()=>fixture(async f=>{
 const response=await createHelpWorkerAdapter(f.verify,f.factory)(request(),env,path,{'access-control-allow-origin':'https://primecare-clinic.pages.dev',vary:'Origin'});
 assert.equal(response.status,200);assert.equal((await response.json()).items[0].id,'a-en');assert.equal(f.verified(),1);
 assert.equal(response.headers.get('cache-control'),'no-store');assert.equal(response.headers.get('access-control-allow-origin'),'https://primecare-clinic.pages.dev');assert.match(response.headers.get('vary'),/Origin/);assert.match(response.headers.get('vary'),/Authorization/);
 assert.equal(f.connections.length,2);assert.notEqual(f.connections[0],f.connections[1]);assert.deepEqual(f.connections.map(c=>[c.connected,c.ended]),[[1,1],[1,1]]);
 for(const c of f.options)assert.deepEqual(c,{connectionString:env.DB_URL,connectionTimeoutMillis:10000,query_timeout:20000,statement_timeout:15000,lock_timeout:5000});
 assert.equal(f.sql.filter(q=>q.index===1).every(q=>q.sql.startsWith('INSERT INTO public.help_reader_rate')),true);assert.equal(await quotaCount(f),1);assert.equal(await auditCount(f),1);
}));
test('activation failure rolls back BEGIN even before shared reader records it; no data/effects',()=>fixture(async f=>{
 const response=await createHelpWorkerAdapter(async()=>{throw Error('private runtime provenance');},f.factory)(request(),env,path);
 assert.equal(response.status,503);assert.deepEqual(await response.json(),{version:1,error:{code:'unavailable'}});
 assert.equal(f.sql.some(q=>q.sql==='ROLLBACK'),true);assert.equal(f.sql.some(q=>q.sql.includes('FROM public.faqs')),false);assert.equal(await auditCount(f),0);assert.equal(await quotaCount(f),0);assert.deepEqual(f.connections.map(c=>c.ended),[1,1]);
}));
test('second connection failure closes both captured clients and sanitizes errors',()=>fixture(async f=>{
 const factory=options=>{const c=f.factory(options);if(c.index===1)c.connect=async()=>{throw Error('private quota connection');};return c;};
 const response=await createHelpWorkerAdapter(f.verify,factory)(request(),env,path);assert.equal(response.status,503);assert.equal((await response.text()).includes('private'),false);assert.deepEqual(f.connections.map(c=>c.ended),[1,1]);assert.equal(f.verified(),0);
}));
test('same client cannot serve both the transactional reader and autocommit quota',async()=>{
 let ended=0,connected=0;const client={connect:async()=>{connected++;},query:async()=>({rows:[]}),end:async()=>{ended++;}};
 const response=await createHelpWorkerAdapter(async()=>{},()=>client)(request(),env,path);assert.equal(response.status,503);assert.equal(connected,0);assert.equal(ended,1);
});
test('abort during activation rolls back and closes both clients before private reads',()=>fixture(async f=>{
 const abort=new AbortController();const response=await createHelpWorkerAdapter(async reader=>{await f.verify(reader);abort.abort();},f.factory)(request({signal:abort.signal}),env,path);
 assert.equal(response.status,409);assert.equal(f.sql.some(q=>q.sql==='ROLLBACK'),true);assert.equal(f.sql.some(q=>q.sql.includes('FROM public.faqs')),false);assert.deepEqual(f.connections.map(c=>c.ended),[1,1]);
}));
test('actual rollback failure after activation cancellation cannot remain a409 response',()=>fixture(async f=>{
 const abort=new AbortController();let rollbacks=0;const factory=options=>{const c=f.factory(options),query=c.query;if(c.index===0)c.query=async(sql,...args)=>{if(sql==='ROLLBACK'){rollbacks++;throw Error('private activation rollback outage');}return query(sql,...args);};return c;};
 const response=await createHelpWorkerAdapter(async reader=>{await f.verify(reader);abort.abort();},factory)(request({signal:abort.signal}),env,path);
 assert.equal(response.status,503);assert.deepEqual(await response.json(),{version:1,error:{code:'unavailable'}});assert.equal(rollbacks,1);assert.equal(f.sql.some(q=>q.sql.includes('FROM public.faqs')),false);assert.deepEqual(f.connections.map(c=>c.ended),[1,1]);await f.db.query('ROLLBACK');
}));
test('abort during a private query executes the reader rollback and returns409, not a false storage failure',()=>fixture(async f=>{
 const abort=new AbortController();const factory=options=>{const c=f.factory(options),query=c.query;if(c.index===0)c.query=async(sql,...args)=>{const result=await query(sql,...args);if(sql.startsWith('SELECT COUNT(*)::text AS total FROM public.faqs'))abort.abort();return result;};return c;};
 const response=await createHelpWorkerAdapter(f.verify,factory)(request({signal:abort.signal}),env,path);assert.equal(response.status,409);assert.deepEqual(await response.json(),{version:1,error:{code:'conflict'}});assert.equal(f.sql.some(q=>q.sql==='ROLLBACK'),true);assert.equal(await auditCount(f),0);assert.deepEqual(f.connections.map(c=>c.ended),[1,1]);
}));
test('abort with an actual rollback outage returns503 and still disposes both clients',()=>fixture(async f=>{
 const abort=new AbortController();let rollbacks=0;const factory=options=>{const c=f.factory(options),query=c.query;if(c.index===0)c.query=async(sql,...args)=>{if(sql==='ROLLBACK'){rollbacks++;throw Error('private rollback outage');}const result=await query(sql,...args);if(sql.startsWith('SELECT COUNT(*)::text AS total FROM public.faqs'))abort.abort();return result;};return c;};
 const response=await createHelpWorkerAdapter(f.verify,factory)(request({signal:abort.signal}),env,path);assert.equal(response.status,503);assert.deepEqual(await response.json(),{version:1,error:{code:'unavailable'}});assert.ok(rollbacks>=1);assert.deepEqual(f.connections.map(c=>c.ended),[1,1]);await f.db.query('ROLLBACK');
}));
test('captured client query/end methods cannot be replaced during connect',()=>fixture(async f=>{
 let replaced=0;const factory=options=>{const c=f.factory(options),connect=c.connect;c.connect=async()=>{await connect();c.query=c.end=async()=>{replaced++;throw Error('replacement');};};return c;};
 const response=await createHelpWorkerAdapter(f.verify,factory)(request(),env,path);assert.equal(response.status,200);assert.equal(replaced,0);assert.deepEqual(f.connections.map(c=>c.ended),[1,1]);
}));
test('missing registered policy denies before quota/audit writes and disposes both connections',()=>fixture(async f=>{
 await f.db.query('DELETE FROM '+table('audit_event_definitions'));const response=await createHelpWorkerAdapter(f.verify,f.factory)(request(),env,path);
 assert.equal(response.status,503);assert.equal(await quotaCount(f),0);assert.equal(await auditCount(f),0);assert.deepEqual(f.connections.map(c=>c.ended),[1,1]);
}));
test('quota database outage is not an empty successful Help response',()=>fixture(async f=>{
 const factory=options=>{const c=f.factory(options);if(c.index===1)c.query=async()=>{throw Error('private quota SQL');};return c;};const response=await createHelpWorkerAdapter(f.verify,factory)(request(),env,path);
 assert.equal(response.status,503);assert.equal((await response.text()).includes('private'),false);assert.equal(await auditCount(f),0);assert.deepEqual(f.connections.map(c=>c.ended),[1,1]);
}));
test('cleanup failure still closes the second client and suppresses a successful response',()=>fixture(async f=>{
 const factory=options=>{const c=f.factory(options);if(c.index===0)c.end=async()=>{c.ended++;throw Error('private close failure');};return c;};const response=await createHelpWorkerAdapter(f.verify,factory)(request(),env,path);
 assert.equal(response.status,503);assert.deepEqual(await response.json(),{version:1,error:{code:'unavailable'}});assert.deepEqual(f.connections.map(c=>c.ended),[1,1]);
}));
test('synchronous close failure cannot prevent closing the other client or escape safe errors',()=>fixture(async f=>{
 const factory=options=>{const c=f.factory(options);if(c.index===0)c.end=()=>{c.ended++;throw Error('private synchronous close');};return c;};
 const response=await createHelpWorkerAdapter(f.verify,factory)(request(),env,path);assert.equal(response.status,503);assert.deepEqual(await response.json(),{version:1,error:{code:'unavailable'}});assert.deepEqual(f.connections.map(c=>c.ended),[1,1]);
}));
test('synchronous rollback failure cannot prevent disposing either client',()=>fixture(async f=>{
 const factory=options=>{const c=f.factory(options),query=c.query;if(c.index===0)c.query=(sql,...args)=>{if(sql==='ROLLBACK')throw Error('private synchronous rollback');return query(sql,...args);};return c;};
 const response=await createHelpWorkerAdapter(async()=>{throw Error('fixture activation denial');},factory)(request(),env,path);assert.equal(response.status,503);assert.deepEqual(await response.json(),{version:1,error:{code:'unavailable'}});assert.deepEqual(f.connections.map(c=>c.ended),[1,1]);
 // The isolated fixture owns its engine connection after the adapter ports end.
 await f.db.query('ROLLBACK');
}));
test('native independent quota survives a reader/audit rollback through actual Worker composition',{skip:!process.env.HELP_SERVICE_TEST_DATABASE_URL},()=>fixture(async f=>{
 const factory=options=>{const c=f.factory(options),query=c.query;if(c.index===0)c.query=async(sql,...args)=>{if(sql.startsWith('INSERT INTO public.help_reader_audit'))throw Error('fixture audit outage');return query(sql,...args);};return c;};
 const response=await createHelpWorkerAdapter(f.verify,factory)(request(),env,path);assert.equal(response.status,503);assert.equal(await quotaCount(f),1);assert.equal(await auditCount(f),0);assert.deepEqual(f.connections.map(c=>c.ended),[1,1]);
}));
