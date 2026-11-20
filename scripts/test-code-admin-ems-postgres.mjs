/** Native SQL authority tests. Only a disposable loopback DB or explicit in-memory test engine. */
import {test,after} from 'node:test';import assert from 'node:assert/strict';import {createRequire} from 'node:module';import {createHash} from 'node:crypto';
import {build} from 'esbuild';import {readFile,mkdtemp} from 'node:fs/promises';import {tmpdir} from 'node:os';import {join} from 'node:path';
if(process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL)throw Error('Production credentials forbidden in EMS SQL tests');
const pin=JSON.parse(await readFile('tools/governance-production/production-pin.json','utf8')),definition=JSON.parse(await readFile('packages/shared/src/endpoint-management/contract.json','utf8'));
let db,embedded=false;
if(process.env.EMS_TEST_EMBEDDED==='1'){
 if(process.env.EMS_TEST_DATABASE_URL)throw Error('Do not combine test engines');
 const {PGlite}=await import('@electric-sql/pglite');db=new PGlite();embedded=true;
}else{
 const url=new URL(process.env.EMS_TEST_DATABASE_URL||'https://invalid');if(!['localhost','127.0.0.1'].includes(url.hostname)||url.pathname!=='/ems_test'||!['postgres:','postgresql:'].includes(url.protocol))throw Error('Disposable loopback ems_test database required');
 const {default:pg}=await import('pg');db=new pg.Client({connectionString:url.href,ssl:false});await db.connect();
}
const schema='"'+pin.schema+'"',table=name=>schema+'."govt_'+name+'"',manifestTable=schema+'."'+pin.manifestTable+'"';
let owns=false;
after(async()=>{try{if(owns&&!embedded){await db.query('DROP SCHEMA '+schema+' CASCADE');await db.query('DROP TABLE public.auth_sessions,public.users,public.tenants');}}finally{if(embedded)await db.close();else await db.end();}});
const existing=await db.query("SELECT to_regclass('public.users') AS users,to_regnamespace($1) AS metadata",[pin.schema]);if(existing.rows[0].users||existing.rows[0].metadata)throw Error('Preserve an existing test fixture database');
await db.query('CREATE SCHEMA '+schema);owns=true;
await db.query('CREATE TABLE public.tenants(id text PRIMARY KEY,status text)');await db.query('CREATE TABLE public.users(id text PRIMARY KEY,roles text,tenant_id text,status text)');await db.query('CREATE TABLE public.auth_sessions(user_id text,token_hash text,expires_at timestamptz)');
await db.query('CREATE TABLE '+manifestTable+'(manifest_sha256 text)');await db.query('INSERT INTO '+manifestTable+' VALUES($1)',[pin.manifestSha256]);
const specs={apps:['id','app_code'],roles:['id','role_code','active'],screens:['id','app_id','screen_code','route_path','active'],api_endpoints:['id','app_id','endpoint_code','route_path','http_method','service_name','auth_required','permission_key','implementation_status','request_schema','response_schema'],role_screen_permissions:['role_id','screen_id','can_view'],api_permissions:['role_id','api_id','can_access','permission_key'],screen_api_links:['screen_id','api_id']};
for(const [name,columns] of Object.entries(specs))await db.query('CREATE TABLE '+table(name)+'('+columns.map(c=>'"'+c+'" jsonb').join(',')+')');
async function insert(name,record){const keys=Object.keys(record);await db.query('INSERT INTO '+table(name)+'('+keys.map(k=>'"'+k+'"').join(',')+') VALUES('+keys.map((_,i)=>'$'+(i+1)+'::jsonb').join(',')+')',Object.values(record).map(v=>JSON.stringify(v)));}
await insert('apps',{id:20,app_code:'go'});await insert('apps',{id:21,app_code:'gv'});await insert('roles',{id:72,role_code:'code_admin',active:1});
await insert('screens',{id:2000,app_id:20,screen_code:definition.screenCode,route_path:definition.route,active:1});await insert('role_screen_permissions',{role_id:72,screen_id:2000,can_view:1});
for(const [i,op] of definition.operations.entries()){await insert('api_endpoints',{id:3000+i,app_id:21,endpoint_code:op.code,route_path:op.path,http_method:'GET',service_name:'governance',auth_required:1,permission_key:'role_screen_permissions',implementation_status:'implemented',request_schema:JSON.stringify({type:'object'}),response_schema:JSON.stringify({type:'object'})});await insert('api_permissions',{role_id:72,api_id:3000+i,can_access:1,permission_key:'role_screen_permissions'});await insert('screen_api_links',{screen_id:2000,api_id:3000+i});}
const token='a'.repeat(43),hash=createHash('sha256').update(token).digest('hex');
await db.query("INSERT INTO tenants VALUES('control','active'),('other','active')");await db.query("INSERT INTO users VALUES('admin','code_admin','control','active')");await db.query("INSERT INTO auth_sessions VALUES('admin',$1,NOW()+INTERVAL '1 hour')",[hash]);
globalThis.__emsNativeQuery=(sql,args)=>db.query(sql,args);
const dir=await mkdtemp(join(tmpdir(),'ems-sql-'));
await build({entryPoints:['cloudflare/workers/src/code-admin-ems.ts'],bundle:true,platform:'node',format:'cjs',outfile:join(dir,'ems.cjs'),plugins:[{name:'native-db',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:'export class Client {async connect(){} async end(){} async query(sql,args){return globalThis.__emsNativeQuery(sql,args)}}',loader:'js'}));}}]});
const {codeAdminEms}=createRequire(import.meta.url)(join(dir,'ems.cjs'));
const call=(name='summary',headers={})=>codeAdminEms(new Request('https://fixture/platform/ems/'+name,{headers:{authorization:'Bearer '+token,...headers}}),{SERVICE_NAME:'governance',DB_URL:'native-test'},'/platform/ems/'+name,{});
test('actual PostgreSQL grants allow all six EMS reads for the active Code Admin',async()=>{for(const op of definition.operations)assert.equal((await call(op.name)).status,200,op.name);});
test('revoked API and screen grants are enforced against live SQL joins',async()=>{
 await db.query('UPDATE '+table('api_permissions')+" SET can_access='0'::jsonb WHERE api_id='3000'::jsonb");assert.equal((await call()).status,403);await db.query('UPDATE '+table('api_permissions')+" SET can_access='1'::jsonb");
 await db.query('UPDATE '+table('role_screen_permissions')+" SET can_view='0'::jsonb");assert.equal((await call()).status,403);await db.query('UPDATE '+table('role_screen_permissions')+" SET can_view='1'::jsonb");
});
test('inactive tenants, changed roles and scope overrides cannot use EMS',async()=>{
 await db.query("UPDATE users SET roles='platform_admin'");assert.equal((await call()).status,403);await db.query("UPDATE users SET roles='code_admin'");
 await db.query("UPDATE tenants SET status='inactive' WHERE id='control'");assert.equal((await call()).status,401);await db.query("UPDATE tenants SET status='active'");assert.equal((await call('summary',{'x-tenant-id':'other'})).status,400);
});
test('duplicate registrations and malformed active metadata fail closed',async()=>{
 const op=definition.operations[0];await insert('api_endpoints',{id:9999,app_id:21,endpoint_code:op.code,route_path:op.path,http_method:'GET',service_name:'governance',auth_required:1,permission_key:'role_screen_permissions'});assert.equal((await call()).status,403);await db.query('DELETE FROM '+table('api_endpoints')+" WHERE id='9999'::jsonb");
 await db.query('UPDATE '+table('roles')+' SET active=$1::jsonb',[JSON.stringify({t:'unknown',v:'1'})]);assert.equal((await call()).status,403);await db.query('UPDATE '+table('roles')+' SET active=$1::jsonb',[JSON.stringify({t:'integer',v:'1'})]);assert.equal((await call()).status,200);
});
