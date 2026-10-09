import {test} from 'node:test';import assert from 'node:assert/strict';import {readFileSync} from 'node:fs';import {build} from 'esbuild';import bcrypt from 'bcryptjs';import {auditFixture} from './auth-audit-fixtures.mjs';
const packageData=JSON.parse(readFileSync('docs/api/api-delivery-work-package.json')),spec=JSON.parse(readFileSync('docs/api/auth-delivery-work-package.openapi.json'));
const plugin={name:'auth-delivery',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:'export class Client {async connect(){} async end(){} async query(sql,values){return globalThis.__deliveryAuthQuery(sql,values)}}',loader:'js'}));}};
async function bundle(path,plugins=[]){const b=await build({entryPoints:[path],bundle:true,write:false,platform:'node',format:'esm',plugins});return import('data:text/javascript;base64,'+Buffer.from(b.outputFiles[0].text).toString('base64'));}
const {default:gateway}=await bundle('cloudflare/workers/src/gateway.ts'),{default:service}=await bundle('cloudflare/workers/src/service.ts',[plugin]);const hash=await bcrypt.hash('fixture-password',4);let queries;
function fixture(){queries=[];globalThis.__deliveryAuthQuery=async(sql,values)=>{queries.push({sql,values});const audit=auditFixture(sql,values);if(audit)return audit;
 if(sql.startsWith('INSERT INTO auth_rate_limits'))return {rows:[{attempts:1,retry_after:60}]};
 if(sql==='BEGIN'||sql==='COMMIT'||sql==='ROLLBACK')return {rows:[]};
 if(sql.startsWith('SELECT id, roles, password_hash'))return {rows:[{id:'fixture-user',roles:'ceo',status:'active',password_hash:hash}]};
 if(sql.includes('INSERT INTO auth_sessions'))return {rows:[{token_hash:values[0],user_id:values[1]}]};
 if(sql.startsWith('SELECT tenant_id')||sql.startsWith('SELECT id,email'))return {rows:[]};
 if(sql.startsWith('SELECT id FROM users'))return {rows:[{id:'fixture-user'}]};
 if(sql.startsWith('DELETE FROM auth_password_resets WHERE token_hash'))return {rows:[{user_id:'fixture-user'}]};
 if(sql.startsWith('UPDATE users SET password_hash'))return {rows:[{id:values[1],password_hash:values[0]}]};
 if(sql.startsWith('DELETE FROM auth_sessions')||sql.startsWith('DELETE FROM auth_password_resets'))return {rows:[]};
 throw Error('Unexpected fixture SQL '+sql);};}
const env={SERVICE_NAME:'auth',DB_URL:'fixture',AUTH_SOURCE_LIMIT:{limit:async()=>({success:true})},EMAIL_FROM:'fixture@example.com',EMAIL:{send:async()=>{throw Error('Unknown-account recovery must not send');}}};
const call=(api,body,headers={})=>gateway.fetch(new Request('https://fixture'+api.slice(5),{method:'POST',headers:{'content-type':'application/json','cf-connecting-ip':'203.0.113.20',...headers},...(body===undefined?{}:{body:JSON.stringify(body)})}),{AUTH:{fetch:req=>service.fetch(req,env)}});
for(const api of packageData.operations)test(api+' has a reviewed, countable auth disposition',async()=>{fixture();const name=api.split('/').at(-1),review=packageData.reviews[api];assert.ok(review?.finding&&review.evidence.length);
 if(!spec.paths[api.slice(5)]){const r=await call(api,{owner:'other'});assert.equal(r.status,['POST /v1/auth','POST /v1/auth/'].includes(api)?200:404);assert.equal(queries.length,0);if(r.status===200){assert.equal(review.disposition,'retire_namespace_declaration');const retirement=packageData.retirements[api];assert.ok(retirement?.reason&&retirement.evidence.length&&retirement.declarationIds.length===1);assert.equal((await r.json()).status,'ok');}else assert.equal(review.disposition,'requires_workflow_contract');return;}
 assert.equal(review.disposition,'verify_existing');const op=spec.paths[api.slice(5)].post;assert.deepEqual(op.security,[]);assert.ok(op['x-governance-permission']);
 const payload=name==='login'?{email:'fixture@example.com',password:'fixture-password'}:name==='forgot-password'?{email:'missing@example.com'}:name==='reset-password'?{email:'fixture@example.com',code:'ABCDEF123456',newPassword:'replacement-password'}:undefined;
 const response=await call(api,payload,name==='logout'?{authorization:'Bearer '+'a'.repeat(43)}:{});assert.equal(response.status,200);assert.equal(response.headers.get('cache-control'),'no-store');const body=await response.json();const schema=op.responses['200'].content['application/json'].schema;for(const key of schema.required)assert.ok(Object.hasOwn(body,key));
 if(name==='login'){assert.equal(body.status,'authenticated');assert.match(body.token,/^[A-Za-z0-9_-]{43}$/);assert.ok(queries.some(q=>q.sql.includes('FOR SHARE')));}
 if(name==='logout'){assert.equal(body.status,'signed_out');assert.equal(queries.length,1);assert.match(queries[0].sql,/WHERE token_hash = \$1/);fixture();assert.equal((await call(api)).status,200);assert.equal(queries.length,0);}
 if(name==='forgot-password'){assert.match(body.message,/If an active account matches/);assert.ok(!queries.some(q=>q.sql.startsWith('INSERT INTO auth_password_resets')));}
 if(name==='reset-password'){assert.equal(body.status,'password_reset');assert.equal(body.reauthenticationRequired,true);assert.ok(queries.some(q=>q.sql.startsWith('DELETE FROM auth_sessions WHERE user_id')));assert.equal(queries.at(-1).sql,'COMMIT');}
 if(name!=='logout'){fixture();assert.equal((await call(api,{})).status,400);assert.equal(queries.length,0);}
});
