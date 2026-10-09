// Destructive fixture creation is allowed only in the disposable loopback CI database.
import {Client} from 'pg';
import {build} from 'esbuild';
import assert from 'node:assert/strict';
import {randomUUID,createHash} from 'node:crypto';
import {mkdtemp,readFile,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');
if(!['127.0.0.1','localhost'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Disposable loopback auth_test required');
const records=JSON.parse(await readFile('cloudflare/workers/src/self-records-registry.json','utf8')).filter(r=>r.summaryBatch>=91&&r.summaryBatch<=95);
assert.equal(records.length,5);
const dir=await mkdtemp(join(tmpdir(),'owned-status-summaries-pg-'));
await build({entryPoints:['cloudflare/workers/src/self-records.ts'],outfile:join(dir,'self.cjs'),bundle:true,platform:'node',format:'cjs'});
const {selfRecords}=createRequire(import.meta.url)(join(dir,'self.cjs'));
const db=new Client({connectionString:url.href});await db.connect();
const users=[randomUUID(),randomUUID()],tenants=[randomUUID(),randomUUID()],tokens=['x'.repeat(43),'y'.repeat(43)],created=[];
let checks=0;
const hash=value=>createHash('sha256').update(value).digest('hex');
const call=(record,query='',token=tokens[0],headers={})=>selfRecords(new Request('https://fixture'+record.path+'/summary'+query,{headers:{authorization:'Bearer '+token,...headers}}),{DB_URL:url.href,SERVICE_NAME:'auth'},record.path+'/summary',{});
async function body(record,query='',token=tokens[0]){const response=await call(record,query,token);assert.equal(response.status,200);assert.equal(response.headers.get('cache-control'),'no-store');return response.json();}
try{
 for(let i=0;i<users.length;i++){
  await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'patient',$3,'unused','active')",[users[i],users[i]+'@example.invalid',tenants[0]]);
  await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(tokens[i]),users[i]]);
 }
 for(const record of records){
  const nullable=Array.isArray(record.types.status);
  await db.query('CREATE TABLE '+record.table+'(id TEXT PRIMARY KEY,status TEXT'+(nullable?'':' NOT NULL')+','+record.ownerField+' TEXT,tenant_id TEXT,provider_id TEXT,acknowledged_by TEXT,private_contents TEXT)');created.push(record.table);
  const ids=[];
  async function insert(owner,tenant,status){const id=randomUUID();ids.push(id);await db.query('INSERT INTO '+record.table+'(id,status,'+record.ownerField+',tenant_id,provider_id,acknowledged_by,private_contents) VALUES($1,$2,$3,$4,$5,$5,$6)',[id,status,owner,tenant,users[0],'private-clinical-payroll-incident-data']);return id;}
  const first=await insert(users[0],tenants[0],'PENDING');await insert(users[0],tenants[0],'PENDING');await insert(users[0],tenants[0],'COMPLETED');if(nullable)await insert(users[0],tenants[0],null);
  // Same-tenant foreign owner, foreign/null tenant and unassigned records must not contribute.
  await insert(users[1],tenants[0],'FOREIGN_OWNER');await insert(users[0],tenants[1],'FOREIGN_TENANT');await insert(users[0],null,'NULL_TENANT');await insert(null,tenants[0],'UNASSIGNED');
  const expected=[{status:'COMPLETED',count:1},{status:'PENDING',count:2},...(nullable?[{status:null,count:1}]:[])];
  const result=await body(record);assert.deepEqual(result.groups,expected);assert.equal(result.pagination.total,expected.length);assert.ok(!JSON.stringify(result).includes('private'));checks++;
  const page=await body(record,'?limit=1&offset=1');assert.deepEqual(page.groups,[expected[1]]);assert.equal(page.pagination.hasMore,nullable);checks++;
  if(nullable){const last=await body(record,'?limit=1&offset=2');assert.deepEqual(last.groups,[{status:null,count:1}]);assert.equal(last.pagination.hasMore,false);checks++;}
  const other=await body(record,'',tokens[1]);assert.deepEqual(other.groups,[{status:'FOREIGN_OWNER',count:1}]);checks++;
  await db.query('UPDATE '+record.table+' SET '+record.ownerField+'=$1 WHERE id=$2',[users[1],first]);const changed=await body(record);assert.equal(changed.groups.find(g=>g.status==='PENDING').count,1);const recipient=await body(record,'',tokens[1]);assert.equal(recipient.groups.find(g=>g.status==='PENDING').count,1);checks++;
  assert.equal((await call(record,'',tokens[0],{'x-tenant-id':tenants[1]})).status,403);checks++;
  await db.query('DELETE FROM '+record.table+' WHERE '+record.ownerField+'=$1 AND tenant_id=$2',[users[0],tenants[0]]);const empty=await body(record);assert.deepEqual(empty.groups,[]);assert.equal(empty.pagination.total,0);checks++;
 }
 await db.query("UPDATE auth_sessions SET expires_at=NOW()-INTERVAL '1 second' WHERE user_id=$1",[users[0]]);for(const r of records)assert.equal((await call(r)).status,401);checks++;
 await db.query("UPDATE users SET status='inactive' WHERE id=$1",[users[1]]);for(const r of records)assert.equal((await call(r,'',tokens[1])).status,401);checks++;
 console.log(`Owned status summaries batches 91–95 passed ${checks} PostgreSQL checks (${process.env.AUTH_TEST_ID_TYPE} auth identities).`);
}finally{
 for(const table of created.reverse())await db.query('DROP TABLE '+table);
 await db.query('DELETE FROM auth_sessions WHERE user_id::text=ANY($1)',[users]);await db.query('DELETE FROM users WHERE id::text=ANY($1)',[users]);await db.end();await rm(dir,{recursive:true,force:true});
}
