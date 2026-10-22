import {test,after} from 'node:test';
import assert from 'node:assert/strict';
import {mkdtemp,rm} from 'node:fs/promises';
import {readFileSync} from 'node:fs';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {pathToFileURL} from 'node:url';
import {build} from 'esbuild';
const temp=await mkdtemp(join(tmpdir(),'communication-runtime-'));after(()=>rm(temp,{recursive:true,force:true}));
await build({entryPoints:['cloudflare/workers/src/business-tasks/runtime.ts'],outfile:join(temp,'runtime.mjs'),bundle:true,platform:'node',format:'esm'});
const {PostgresCommunicationWorker}=await import(pathToFileURL(join(temp,'runtime.mjs')).href);
const pin=JSON.parse(readFileSync('tools/governance-production/production-pin.json'));
function fixture({rows=[{id:'fixture-user',tenant_id:'fixture-tenant'}],grants=[],databaseFailure=false}={}){
 const calls=[];
 const businessPool={async query(sql){calls.push(sql);if(databaseFailure)throw Error('private database detail');if(sql.includes('auth_sessions'))return {rows};assert.fail('unauthorized request reached business storage');},async connect(){assert.fail('unauthorized request acquired business storage');}};
 const governancePool={async connect(){return {async query(sql){calls.push(sql);return {rows:sql.startsWith('SELECT manifest')?[{manifest_sha256:pin.manifestSha256}]:sql.startsWith('SELECT DISTINCT')?grants:[]};},release(){calls.push('release');}};}};
 const dependencies={businessPool,governancePool,casePolicy:{async assert(){assert.fail('unauthorized case policy reached');},async assignee(){assert.fail('unauthorized assignee reached');}},mailboxes:{async resolve(){assert.fail('oversized email reached mailbox');},async recipient(){assert.fail('unauthorized recipient reached');},async access(){assert.fail('unauthorized mailbox reached');}},pictures:{async prepare(){assert.fail('unauthorized pictures reached');},async get(){assert.fail('unauthorized pictures reached');},async open(){assert.fail('unauthorized pictures reached');}},limits:{maxMembers:8,maxMessages:100,maxText:2000,maxPictureBytes:1024,maxPictures:3,ringMilliseconds:30000,maxSignalBytes:16384},nativeEmail:{async send(){assert.fail('unauthorized native send reached');}},sender:'sender@example.invalid',maxMailBytes:100,maxRenderedMailBytes:1000,maxRequestBytes:4096,validate(){return true;}};
 return {worker:new PostgresCommunicationWorker(dependencies),dependencies,calls};
}
const request=headers=>new Request('https://example.invalid/v1/messages',{method:'POST',headers,body:'invalid json'});
const bearer={authorization:'Bearer '+'a'.repeat(43)};
test('runtime denies missing and cookie-only identity before parsing or storage',async()=>{
 const f=fixture();for(const headers of [{},{cookie:'session_token='+'a'.repeat(43)}])assert.equal((await f.worker.fetch(request(headers),{})).status,401);assert.equal(f.calls.length,0);
});
test('runtime resolves native session and denies absent current endpoint grants before parsing',async()=>{
 const f=fixture();assert.equal((await f.worker.fetch(request(bearer),{})).status,403);assert.ok(f.calls.some(s=>s.includes('auth_sessions')));assert.ok(f.calls.some(s=>s.includes('api_permissions')));assert.equal(f.calls.at(-1),'release');
});
test('runtime rejects expired session and tenant override before permission query',async()=>{
 const expired=fixture({rows:[]});assert.equal((await expired.worker.fetch(request(bearer),{})).status,401);
 const f=fixture();assert.equal((await f.worker.fetch(request({...bearer,'x-tenant-id':'other'}),{})).status,403);assert.ok(!f.calls.some(s=>s.includes('api_permissions')));
});
test('runtime native database failure produces generic unavailable',async()=>{
 const f=fixture({databaseFailure:true});const response=await f.worker.fetch(request(bearer),{});assert.equal(response.status,503);assert.deepEqual(await response.json(),{error:'unavailable'});
});
test('trusted email entry bounds bytes independently from ordinary user HTTP identity',async()=>{
 const f=fixture();let reason;await f.worker.email({from:'outside@example.invalid',to:'owned@example.invalid',rawSize:101,raw:new ReadableStream(),setReject(value){reason=value;}},{});assert.equal(reason,'Message size not permitted');assert.equal(f.calls.length,0);
});
test('composition requires private pictures, case/mailbox policy and native binding',()=>{
 const {dependencies}=fixture();for(const change of [{pictures:{}},{casePolicy:null},{mailboxes:{}},{nativeEmail:{}},{businessPool:{}}])assert.throws(()=>new PostgresCommunicationWorker({...dependencies,...change}));
});
