import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {PostgresCommunicationEndpointPolicy} from '../cloudflare/workers/src/business-tasks/endpoint-policy.ts';
const pin=JSON.parse(readFileSync('tools/governance-production/production-pin.json'));
const actor={id:'fixture-user',tenantId:'fixture-tenant'};
const request=new Request('https://example.invalid/v1/messages',{method:'POST'});
function fixture({grants=[{role_id:'7',screen_id:'234'}],manifest=[{manifest_sha256:pin.manifestSha256}],failure=false}={}){
 const calls=[];let released=false;
 const policy=new PostgresCommunicationEndpointPolicy({async connect(){return {async query(sql,values){calls.push({sql,values});if(sql.startsWith('SELECT manifest'))return {rows:manifest};if(sql.startsWith('SELECT DISTINCT')){if(failure)throw Error('database unavailable');return {rows:grants};}return {rows:[]};},release(){released=true;}};}});
 return {policy,calls,released:()=>released};
}
test('current endpoint policy requires both explicit grants and server identity',async()=>{
 const f=fixture();await f.policy.authorize(actor,710,request);
 const query=f.calls.find(c=>c.sql.startsWith('SELECT DISTINCT'));
 assert.deepEqual(query.values,['fixture-user','fixture-tenant','710','POST','/v1/messages']);
 for(const required of ['api_permissions','role_screen_permissions','screen_api_links',"LOWER(u.status)='active'","permission_key","can_access","can_view"])assert.ok(query.sql.includes(required));
 assert.equal(f.calls[0].sql,'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(f.released());
});
test('absent or malformed grants never authorize',async()=>{
 for(const grants of [[],[{role_id:null,screen_id:'234'}],[{role_id:'7',screen_id:234}]]){const f=fixture({grants});await assert.rejects(f.policy.authorize(actor,710,request),/Forbidden/);assert.ok(f.released());}
});
test('wrong manifest fails before permission query',async()=>{
 for(const manifest of [[],[{manifest_sha256:'wrong'}],[{manifest_sha256:pin.manifestSha256},{manifest_sha256:pin.manifestSha256}]]){const f=fixture({manifest});await assert.rejects(f.policy.authorize(actor,710,request),/manifest/);assert.ok(!f.calls.some(c=>c.sql.startsWith('SELECT DISTINCT')));assert.ok(f.released());}
});
test('unregistered endpoint or mismatched request fails before database access',async()=>{
 const f=fixture();for(const [id,req] of [[999,request],[710,new Request(request.url)],[710,new Request('https://example.invalid/v1/messages/email',{method:'POST'})]])await assert.rejects(f.policy.authorize(actor,id,req),/Forbidden/);assert.equal(f.calls.length,0);
});
test('database failures roll back and release without turning into grants',async()=>{
 const f=fixture({failure:true});await assert.rejects(f.policy.authorize(actor,710,request),/database unavailable/);assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(f.released());
});
test('native PostgreSQL evaluates tagged and native current grants',{skip:!process.env.BUSINESS_TEST_DATABASE_URL},async()=>{
 assert.ok(!process.env.PRODUCTION_DATABASE_URL&&!process.env.GOVERNANCE_DATABASE_URL,'production credentials forbidden');
 const target=new URL(process.env.BUSINESS_TEST_DATABASE_URL);assert.ok(['localhost','127.0.0.1'].includes(target.hostname),'loopback fixture required');
 const {Pool}=await import('pg');const pool=new Pool({connectionString:process.env.BUSINESS_TEST_DATABASE_URL});
 let ownsSchema=false,ownsUsers=false;
 const q=sql=>pool.query(sql);const schema='"'+pin.schema+'"';
 try{
  await q('CREATE SCHEMA '+schema);ownsSchema=true;
  await q(`CREATE TABLE ${schema}.govt_source_manifest(manifest_sha256 text); INSERT INTO ${schema}.govt_source_manifest VALUES('${pin.manifestSha256}')`);
  await q("CREATE TABLE public.users(id text,tenant_id text,roles text,status text)");ownsUsers=true;await q("INSERT INTO public.users VALUES('fixture-user','fixture-tenant','fixture-role','active')");
  const definitions={roles:'id text,role_code text,active text',api_permissions:'api_id text,role_id text,can_access text,permission_key text',api_endpoints:'id text,http_method text,route_path text,service_name text,auth_required text,permission_key jsonb',screen_api_links:'api_id text,screen_id text',screens:'id text,active text',role_screen_permissions:'role_id text,screen_id text,can_view text'};
  for(const [name,columns]of Object.entries(definitions))await q(`CREATE TABLE ${schema}.govt_${name}(${columns})`);
  const inserts={roles:"'7','fixture-role','1'",api_permissions:"'710','7','1','role_screen_permissions'",api_endpoints:`'710','POST','/v1/messages','governance','1','{"t":"text","v":"role_screen_permissions"}'::jsonb`,screen_api_links:"'710','234'",screens:"'234','1'",role_screen_permissions:"'7','234','1'"};
  for(const [name,values]of Object.entries(inserts))await q(`INSERT INTO ${schema}.govt_${name} VALUES(${values})`);
  const policy=new PostgresCommunicationEndpointPolicy(pool);await policy.authorize(actor,710,request);
  await assert.rejects(policy.authorize({...actor,tenantId:'other'},710,request),/Forbidden/);
  await q(`UPDATE ${schema}.govt_api_permissions SET permission_key='api_permission_collision'`);await assert.rejects(policy.authorize(actor,710,request),/Forbidden/);
  await q(`UPDATE ${schema}.govt_api_permissions SET permission_key='role_screen_permissions'`);
  await q(`UPDATE ${schema}.govt_api_permissions SET can_access='0'`);await assert.rejects(policy.authorize(actor,710,request),/Forbidden/);
  await q(`UPDATE ${schema}.govt_api_permissions SET can_access='1'; UPDATE ${schema}.govt_role_screen_permissions SET can_view='0'`);await assert.rejects(policy.authorize(actor,710,request),/Forbidden/);
  await q(`UPDATE ${schema}.govt_role_screen_permissions SET can_view='1'; UPDATE ${schema}.govt_api_endpoints SET permission_key='{"t":"unknown","v":"role_screen_permissions"}'::jsonb`);await assert.rejects(policy.authorize(actor,710,request),/Forbidden/);
 }finally{if(ownsSchema)await q('DROP SCHEMA '+schema+' CASCADE');if(ownsUsers)await q('DROP TABLE public.users');await pool.end();}
});
