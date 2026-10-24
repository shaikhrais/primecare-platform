import {assertReadDateRejections} from './read-date-postgres-fixtures.mjs';
import {Client} from 'pg';
import {build} from 'esbuild';
import bcrypt from 'bcryptjs';
import assert from 'node:assert/strict';
import {randomUUID,createHash} from 'node:crypto';
import {mkdtemp,readFile} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {createRequire} from 'node:module';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');
if(!['127.0.0.1','localhost'].includes(url.hostname)||url.pathname!=='/auth_test')throw new Error('Only disposable loopback auth_test is permitted');
const directory=await mkdtemp(join(tmpdir(),'workspace-pg-'));const file=join(directory,'workspace.cjs');
await build({entryPoints:['cloudflare/workers/src/workspace.ts'],bundle:true,platform:'node',format:'cjs',outfile:file});
const {workspace}=createRequire(import.meta.url)(file);
const db=new Client({connectionString:url.href});await db.connect();
const tenant=randomUUID(),otherTenant=randomUUID();const ids=[randomUUID(),randomUUID(),randomUUID()];
const tokens=['a'.repeat(43),'b'.repeat(43)];const hash=value=>createHash('sha256').update(value).digest('hex');
const env={SERVICE_NAME:'governance',DB_URL:url.href};let passed=0;
const registry=JSON.parse(await readFile('cloudflare/workers/src/workspace-registry.json','utf8'));
const call=(query='',token=tokens[0],headers={},method='GET')=>workspace(new Request('https://test/workspace'+query,{method,headers:{authorization:'Bearer '+token,...headers}}),env,'/workspace',{});
try {
 const password=await bcrypt.hash(randomUUID(),4);
 for(let i=0;i<ids.length;i++)await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,$3,$4,$5,'active')",[ids[i],`workspace-${ids[i]}@example.invalid`,i===0?'ceo':'rmt',i===2?otherTenant:tenant,password]);
 for(let i=0;i<tokens.length;i++)await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(tokens[i]),ids[i]]);
 await db.query('CREATE TABLE IF NOT EXISTS clients(id TEXT PRIMARY KEY,tenant_id TEXT)');
 await db.query('CREATE TABLE IF NOT EXISTS providers(id TEXT PRIMARY KEY)');
 await db.query('INSERT INTO clients(id,tenant_id) VALUES($1,$2),($3,$4)',[ids[0],tenant,ids[2],otherTenant]);
 const activityId=(await db.query("INSERT INTO tenant_configuration_audit(tenant_id,actor_user_id,action) VALUES($1,$2,'email_configuration_changed') RETURNING id",[tenant,String(ids[0])])).rows[0].id;
 try {
  passed+=await assertReadDateRejections(db,()=>call(),{table:'tenant_configuration_audit',field:'created_at',id:activityId});
  await db.query('UPDATE tenant_configuration_audit SET action=$2 WHERE id=$1',[activityId,'private-unknown-action']);
  const badActivity=await call();assert.equal(badActivity.status,503);assert.equal(badActivity.headers.get('cache-control'),'no-store');passed++;
 }finally {await db.query('DELETE FROM tenant_configuration_audit WHERE id=$1',[activityId]);}

 await db.query("UPDATE users SET roles='' WHERE id=$1",[ids[0]]);
 try {
  const before=(await db.query('SELECT * FROM users WHERE id=$1',[ids[0]])).rows;
  const rejected=await call();assert.equal(rejected.status,503);assert.equal(rejected.headers.get('cache-control'),'no-store');
  assert.deepEqual(await rejected.json(),{error:'Workspace unavailable'});
  assert.deepEqual((await db.query('SELECT * FROM users WHERE id=$1',[ids[0]])).rows,before);passed++;
 }finally {await db.query("UPDATE users SET roles='ceo' WHERE id=$1",[ids[0]]);}
 const response=await call('?screen=ceo_dashboard');assert.equal(response.status,200);passed++;
 const data=await response.json();assert.equal(data.overview.activeAccounts,2);assert.equal(typeof data.overview.activeSessions,'number');assert.ok(data.overview.accountRoles.every(r=>typeof r.count==='number'));assert.ok(data.overview.metrics.filter(m=>m.available).every(m=>typeof m.count==='number'));assert.equal(data.overview.activeSessions,2);passed++;
 assert.equal(data.overview.metrics.find(m=>m.code==='clients').count,1);assert.equal(data.overview.metrics.find(m=>m.code==='providers').available,false);passed++;
 assert.ok(data.screens.some(s=>s.code==='ceo_dashboard'));assert.ok(data.screens.every(s=>s.grants.some(g=>g.role==='ceo'&&g.view)));passed++;
 assert.equal((await call('',tokens[0],{'x-tenant-id':otherTenant})).status,403);passed++;
 assert.equal((await call('?screen=ceo_dashboard',tokens[1])).status,403);passed++;
 const staff=await (await call('',tokens[1])).json();assert.equal(staff.overview.activeAccounts,1);assert.deepEqual(staff.inventory.map(p=>p.code),staff.screens.map(p=>p.code));passed++;
 // Resolve every catalog role from the native user row, never a caller-supplied
 // role/tenant. This fixture changes one synthetic account between read checks.
 const roles=[...new Set([...Object.keys(registry.permissions),...registry.screens.flatMap(screen=>screen.grants.filter(grant=>grant.view===1).map(grant=>grant.role))])].sort(),counts=async()=>Object.fromEntries(await Promise.all(
  ['users','auth_sessions','auth_account_audit','tenant_configuration_audit'].map(async table=>[table,(await db.query(`SELECT COUNT(*)::int AS n FROM ${table}`)).rows[0].n])));
 const beforeRoleReads=await counts();
 try{
  for(const role of roles){
   await db.query('UPDATE users SET roles=$1 WHERE id=$2',[role,ids[0]]);
   const read=await call();assert.equal(read.status,200,role);const current=await read.json();
   const expected=registry.screens.filter(s=>s.renderer!=='account'&&s.grants.some(g=>g.role===role&&g.view===1)).map(s=>s.code).sort();
   assert.equal(current.identity.role,role);assert.deepEqual(current.screens.map(s=>s.code).sort(),expected,role);
   const organization=registry.permissions[role]?.organization===true;
   assert.equal(current.overview.scope,organization?'organization':'personal');
   assert.equal(current.overview.activeAccounts,organization?2:1);
   const forbidden=registry.screens.find(s=>s.renderer!=='account'&&!expected.includes(s.code));
   if(forbidden)assert.equal((await call('?screen='+encodeURIComponent(forbidden.code))).status,403,role+' foreign page');
   assert.equal((await call('',tokens[0],{'x-tenant-id':otherTenant})).status,403,role+' forged tenant');
   passed++;
  }
  assert.deepEqual(await counts(),beforeRoleReads,'workspace reads must not add accounts, sessions or mutation audits');
 }finally{await db.query("UPDATE users SET roles='ceo' WHERE id=$1",[ids[0]]);}
 console.log(JSON.stringify({workspaceCatalogRolesChecked:roles.length,source:'native-postgresql-fixture',production:false}));
 await db.query("UPDATE users SET status='inactive' WHERE id=$1",[ids[1]]);
 assert.equal((await call('',tokens[1])).status,401);passed++;
 await db.query("UPDATE auth_sessions SET expires_at=NOW()-INTERVAL '1 second' WHERE user_id=$1",[ids[0]]);
 assert.equal((await call()).status,401);passed++;
 assert.equal((await call('',tokens[0],{},'POST')).status,405);passed++;
 console.log(`Real PostgreSQL workspace passed ${passed} checks (${process.env.AUTH_TEST_ID_TYPE||'uuid'} identities).`);
}finally {
 await db.query('DELETE FROM auth_sessions WHERE token_hash=ANY($1)',[tokens.map(hash)]);
 await db.query('DELETE FROM clients WHERE id=ANY($1)',[ids]);
 await db.query('DELETE FROM users WHERE id::text=ANY($1)',[ids]);await db.end();
}
