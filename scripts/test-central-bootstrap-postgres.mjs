/** Scoped first-central-admin checks. Uses only a disposable native PostgreSQL schema. */
import {test,after} from 'node:test';
import assert from 'node:assert/strict';
import pg from 'pg';
import bcrypt from 'bcryptjs';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {randomUUID,createHash} from 'node:crypto';
import {bootstrapCentral} from './bootstrap-first-central-admin.mjs';
const url=process.env.CENTRAL_BOOTSTRAP_TEST_DATABASE_URL;
if(!url)throw Error('CENTRAL_BOOTSTRAP_TEST_DATABASE_URL required');
const target=new URL(url);
if(!['localhost','127.0.0.1'].includes(target.hostname)||target.pathname!=='/bootstrap')throw Error('Only loopback PostgreSQL database bootstrap is permitted');
if(process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL)throw Error('Production credentials forbidden in bootstrap tests');
const results=[];
async function fixture(run){
 const schema='central_bootstrap_'+randomUUID().replaceAll('-',''),owner=new pg.Client({connectionString:url});await owner.connect();
 const clients=[];
 try{
  await owner.query(`CREATE SCHEMA ${schema};SET search_path TO ${schema}`);
  await owner.query('CREATE TABLE tenants(id uuid PRIMARY KEY,status text);CREATE TABLE users(id uuid PRIMARY KEY,email text UNIQUE,tenant_id uuid REFERENCES tenants(id),roles text,password_hash text,status text,updated_at timestamptz)');
  await owner.query(await readFile('packages/database/migrations/20260928_auth_bootstrap_audit.sql','utf8'));
  const tenant=randomUUID();await owner.query("INSERT INTO tenants VALUES($1,'active')",[tenant]);
  const client=async()=>{const db=new pg.Client({connectionString:url});await db.connect();clients.push(db);await db.query(`SET search_path TO ${schema}`);return db;};
  await run({db:owner,tenant,client,input:{email:'first@example.test',tenant,password:'Synthetic-Central-2026!'}});
 }finally{
  await Promise.all(clients.map(db=>db.end()));await owner.query('SET search_path TO public');await owner.query(`DROP SCHEMA ${schema} CASCADE`);await owner.end();
 }
}
async function check(name,run){test(name,async()=>{await fixture(run);results.push({name,status:'passed'});});}
await check('creation persists canonical role, hashed credential and one matching audit',async({db,input})=>{
 assert.deepEqual(await bootstrapCentral(db,{...input,email:' FIRST@EXAMPLE.TEST '}),{created:true});
 const rows=(await db.query('SELECT u.*,a.user_id,a.tenant_id AS audit_tenant,a.source FROM users u JOIN auth_bootstrap_audit a ON a.user_id=u.id')).rows;
 assert.equal(rows.length,1);const user=rows[0];assert.equal(user.email,input.email);assert.equal(user.roles,'central_admin');assert.equal(user.status,'active');assert.equal(user.tenant_id,input.tenant);assert.equal(user.audit_tenant,input.tenant);assert.equal(user.source,'protected_workflow');assert.notEqual(user.password_hash,input.password);assert.equal(await bcrypt.compare(input.password,user.password_hash),true);
 await assert.rejects(bootstrapCentral(db,input),/already exists/);assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM users')).rows[0].n,1);
});
await check('inactive and missing tenants reject without user or audit writes',async({db,input})=>{
 await db.query("UPDATE tenants SET status='inactive'");
 for(const tenant of [input.tenant,randomUUID()])await assert.rejects(bootstrapCentral(db,{...input,tenant}),/Active root tenant required/);
 for(const table of ['users','auth_bootstrap_audit'])assert.equal((await db.query(`SELECT COUNT(*)::int AS n FROM ${table}`)).rows[0].n,0);
});
await check('existing mixed-case account in a foreign tenant is never promoted or overwritten',async({db,input})=>{
 const tenant=randomUUID(),id=randomUUID();await db.query("INSERT INTO tenants VALUES($1,'active')",[tenant]);await db.query("INSERT INTO users VALUES($1,'FIRST@EXAMPLE.TEST',$2,'tenant_admin','original','inactive',NOW())",[id,tenant]);
 const before=(await db.query('SELECT * FROM users')).rows;
 await assert.rejects(bootstrapCentral(db,input),/cannot be overwritten/);assert.deepEqual((await db.query('SELECT * FROM users')).rows,before);assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM auth_bootstrap_audit')).rows[0].n,0);
});
await check('invalid email, tenant and UTF-8 password limits fail before opening a transaction',async({db,input})=>{
 let queries=0;const guarded={query(...args){queries++;return db.query(...args);}};
 for(const change of [{email:'bad'},{tenant:'../foreign'},{password:'short'},{password:'é'.repeat(37)}])await assert.rejects(bootstrapCentral(guarded,{...input,...change}));
 assert.equal(queries,0);
 assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM users')).rows[0].n,0);
});
await check('audit failure rolls back account and retry succeeds after dependency recovery',async({db,input})=>{
 await db.query("CREATE FUNCTION reject_bootstrap_audit() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'synthetic audit failure'; END $$;CREATE TRIGGER reject_audit BEFORE INSERT ON auth_bootstrap_audit FOR EACH ROW EXECUTE FUNCTION reject_bootstrap_audit()");
 await assert.rejects(bootstrapCentral(db,input),/synthetic audit failure/);assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM users')).rows[0].n,0);assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM auth_bootstrap_audit')).rows[0].n,0);
 await db.query('DROP TRIGGER reject_audit ON auth_bootstrap_audit');assert.deepEqual(await bootstrapCentral(db,input),{created:true});
});
await check('two native connections racing for different tenants create exactly one protected account',async({db,input,client})=>{
 const tenant=randomUUID();await db.query("INSERT INTO tenants VALUES($1,'active')",[tenant]);const a=await client(),b=await client();
 const outcomes=await Promise.allSettled([bootstrapCentral(a,input),bootstrapCentral(b,{...input,tenant,email:'second@example.test'})]);
 assert.equal(outcomes.filter(r=>r.status==='fulfilled').length,1);assert.equal(outcomes.filter(r=>r.status==='rejected').length,1);assert.match(outcomes.find(r=>r.status==='rejected').reason.message,/already exists/);
 assert.equal((await db.query("SELECT COUNT(*)::int AS n FROM users WHERE roles='central_admin'")).rows[0].n,1);assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM auth_bootstrap_audit')).rows[0].n,1);
});
after(async()=>{
 const out='test-results/central-bootstrap';await mkdir(out,{recursive:true});const sources={};for(const path of ['scripts/bootstrap-first-central-admin.mjs','scripts/bootstrap-validation.mjs','scripts/test-central-bootstrap-postgres.mjs','packages/database/migrations/20260928_auth_bootstrap_audit.sql'])sources[path]=createHash('sha256').update(await readFile(path)).digest('hex');
 await writeFile(out+'/postgres.json',JSON.stringify({workflow_id:'auth.bootstrap-first-central-admin',scope:'scoped',wholeTaskVerified:false,results,source_bindings:sources,cleanup:'All synthetic schemas dropped; no production credentials supplied.'},null,2));
});
