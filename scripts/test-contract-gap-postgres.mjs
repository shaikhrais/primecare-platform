// Real session/authority checks against a disposable loopback database; catalog data is static.
import {Client} from 'pg';import {build} from 'esbuild';import assert from 'node:assert/strict';import {randomUUID,createHash} from 'node:crypto';import {readFile,mkdtemp,rm} from 'node:fs/promises';import {tmpdir} from 'node:os';import {join} from 'node:path';import {createRequire} from 'node:module';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');if(!['127.0.0.1','localhost'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Disposable loopback auth_test required');
const dir=await mkdtemp(join(tmpdir(),'contract-gap-pg-'));await build({entryPoints:['cloudflare/workers/src/governance-api.ts'],outfile:join(dir,'governance.cjs'),bundle:true,platform:'node',format:'cjs'});const {governanceApi}=createRequire(import.meta.url)(join(dir,'governance.cjs'));
const inventory=JSON.parse(await readFile('cloudflare/workers/src/api-execution-inventory.json','utf8'));
const paths=[['/api-verification-summary',null],['/api-missing-permissions','permission'],['/api-missing-request-schemas','requestSchema'],['/api-missing-response-schemas','responseSchema'],['/api-unlinked-screens','screenLink']];
const db=new Client({connectionString:url.href});await db.connect();const ids=Array.from({length:4},()=>randomUUID()),tenants=[randomUUID(),randomUUID()],roles=['ceo','governance','rmt','ceo'],tokens=['j'.repeat(43),'k'.repeat(43),'l'.repeat(43),'m'.repeat(43)],hash=value=>createHash('sha256').update(value).digest('hex');let checks=0;
const call=(path,query='',token=tokens[0],headers={})=>governanceApi(new Request('https://fixture'+path+query,{headers:{authorization:'Bearer '+token,...headers}}),{DB_URL:url.href,SERVICE_NAME:'governance'},path,{});
try{
 for(let i=0;i<ids.length;i++){await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,$3,$4,'fixture-unused-hash',$5)",[ids[i],ids[i]+'@example.invalid',roles[i],tenants[i===1?1:0],i===3?'inactive':'active']);await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(tokens[i]),ids[i]]);}
 for(const [path,gap] of paths){
  const response=await call(path,'?limit=1');assert.equal(response.status,200);assert.equal(response.headers.get('cache-control'),'no-store');const body=await response.json();assert.equal(body.data.length,1);assert.ok(!JSON.stringify(body).includes(ids[0]));assert.ok(body.data.every(row=>row.postgresVerified===false&&row.productionVerified===false));if(gap)assert.equal(body.pagination.total,inventory.data.filter(row=>row.missingContractFields.includes(gap)).length);checks++;
  const other=await (await call(path,'?limit=1',tokens[1])).json();assert.deepEqual(other,body);checks++;
  assert.equal((await call(path,'',tokens[2])).status,403);assert.equal((await call(path,'',tokens[3])).status,401);assert.equal((await call(path,'',tokens[0],{'x-tenant-id':tenants[1]})).status,403);checks++;
  const empty=await (await call(path,'?search=nonexistent_unique_contract_abc123')).json();assert.deepEqual(empty.data,[]);assert.equal(empty.pagination.total,0);checks++;
 }
 const scoped=await (await call('/api-verification-summary','?search=%2Fapi%2Fclients&limit=1')).json();assert.equal(scoped.pagination.total,1);assert.equal(scoped.data[0].verificationState,'blocked');assert.equal(scoped.data[0].operations,2);checks++;
 await db.query("UPDATE auth_sessions SET expires_at=NOW()-INTERVAL '1 second' WHERE user_id=$1",[ids[0]]);for(const [path] of paths)assert.equal((await call(path)).status,401);checks++;
 console.log(`Contract-gap API batches 101–105 passed ${checks} PostgreSQL session checks (${process.env.AUTH_TEST_ID_TYPE} auth identities).`);
}finally{await db.query('DELETE FROM auth_sessions WHERE user_id::text=ANY($1)',[ids]);await db.query('DELETE FROM users WHERE id::text=ANY($1)',[ids]);await db.end();await rm(dir,{recursive:true,force:true});}
