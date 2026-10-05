// Exact gateway aliases tested through the real owned handlers against disposable PostgreSQL.
import {Client} from 'pg';import {build} from 'esbuild';import assert from 'node:assert/strict';import {randomUUID,createHash} from 'node:crypto';import {readFile,mkdtemp,rm} from 'node:fs/promises';import {tmpdir} from 'node:os';import {join} from 'node:path';import {createRequire} from 'node:module';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL||'');if(!['127.0.0.1','localhost'].includes(url.hostname)||url.pathname!=='/auth_test')throw Error('Disposable loopback auth_test required');
const aliases=JSON.parse(await readFile('cloudflare/workers/src/governed-read-aliases.json','utf8')),spec=JSON.parse(await readFile('docs/api/governed-read-aliases-batches-106-110.openapi.json','utf8'));
const dir=await mkdtemp(join(tmpdir(),'read-alias-pg-'));await build({entryPoints:['cloudflare/workers/src/gateway.ts','cloudflare/workers/src/service.ts'],outdir:dir,bundle:true,platform:'node',format:'cjs'});const require=createRequire(import.meta.url),{default:gateway}=require(join(dir,'gateway.js')),{default:service}=require(join(dir,'service.js'));
const db=new Client({connectionString:url.href});await db.connect();const users=Array.from({length:3},()=>randomUUID()),profiles=Array.from({length:3},()=>randomUUID()),tenants=[randomUUID(),randomUUID()],tokens=['p'.repeat(43),'q'.repeat(43),'r'.repeat(43)],created=[];let checks=0;
const hash=value=>createHash('sha256').update(value).digest('hex');
const call=(alias,query='',token=tokens[0],headers={},method='GET')=>gateway.fetch(new Request('https://fixture'+alias.path+query,{method,headers:{authorization:'Bearer '+token,...headers}}),{[alias.service.toUpperCase()]:{fetch:request=>service.fetch(request,{DB_URL:url.href,SERVICE_NAME:alias.service})}});
try{
 for(let i=0;i<3;i++){await db.query("INSERT INTO users(id,email,roles,tenant_id,password_hash,status) VALUES($1,$2,'patient',$3,'unused','active')",[users[i],users[i]+'@example.invalid',tenants[i===2?1:0]]);await db.query("INSERT INTO auth_sessions(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '1 hour')",[hash(tokens[i]),users[i]]);}
 await db.query('CREATE TABLE client_profiles(id TEXT PRIMARY KEY,user_id TEXT,tenant_id TEXT,full_name TEXT,city TEXT,province TEXT,postal_code TEXT,updated_at TIMESTAMP)');created.push('client_profiles');
 await db.query('CREATE TABLE provider_profiles(id TEXT PRIMARY KEY,user_id TEXT,tenant_id TEXT,full_name TEXT,bio TEXT,languages TEXT,service_areas TEXT,provider_type TEXT,is_approved BOOLEAN,skills TEXT)');created.push('provider_profiles');
 for(let i=0;i<3;i++)for(const table of ['client_profiles','provider_profiles'])await db.query('INSERT INTO '+table+'(id,user_id,tenant_id) VALUES($1,$2,$3)',[profiles[i],users[i],tenants[i===2?1:0]]);
 for(const alias of aliases){
  const properties=spec.paths[alias.path].get.responses['200'].content['application/json'].schema.properties;
  const collection=Object.keys(properties).find(key=>key!=='pagination'),record=properties[collection].items,fields=Object.keys(record.properties);
  const table=alias.batch===106?'app_notifications':alias.batch===107?'staff_tasks':alias.batch===108?'bookings':alias.batch===109?'booking_requests':'provider_documents';
  const owner=alias.batch===106?'user_id':alias.batch===107?'assignee_id':alias.batch===110?'provider_id':'client_id';
  const quote=field=>'"'+field+'"';
  const columns=fields.map(field=>{const definition=record.properties[field],type=Array.isArray(definition.type)?definition.type[0]:definition.type;return quote(field)+' '+(definition.format==='date-time'?'TIMESTAMP':type==='boolean'?'BOOLEAN':type==='integer'?'INTEGER':'TEXT');});
  await db.query('CREATE TABLE '+table+'('+columns.join(',')+','+owner+' TEXT'+(alias.batch===110?'':',tenant_id TEXT')+',private_contents TEXT)');created.push(table);
  const ids=[];
  async function insert(i,userIndex,tenantIndex){const id=randomUUID();ids.push(id);const values=fields.map(field=>{const definition=record.properties[field],type=Array.isArray(definition.type)?definition.type[0]:definition.type;return field==='id'?id:definition.format==='date-time'?'2026-01-0'+(i+1)+'T12:00:00Z':Array.isArray(definition.type)?null:type==='boolean'?false:type==='integer'?1:'stored';});const names=[...fields,owner];values.push(alias.service==='auth'?users[userIndex]:profiles[userIndex]);if(alias.batch!==110){names.push('tenant_id');values.push(tenants[tenantIndex]);}names.push('private_contents');values.push('private-clinical-and-storage-data');await db.query('INSERT INTO '+table+'('+names.map(quote).join(',')+') VALUES('+values.map((_,index)=>'$'+(index+1)).join(',')+')',values);}
  await insert(0,0,0);await insert(1,0,0);await insert(2,1,0);await insert(3,2,1);if(alias.batch!==110)await insert(4,0,1);
  const response=await call(alias,'?limit=1');assert.equal(response.status,200,alias.path);assert.equal(response.headers.get('cache-control'),'no-store');const result=await response.json();assert.equal(result.pagination.total,2);assert.deepEqual(Object.keys(result[collection][0]),fields);assert.ok(!JSON.stringify(result).includes('private'));checks++;
  const other=await (await call(alias,'',tokens[1])).json();assert.equal(other.pagination.total,1);assert.equal(other[collection][0].id,ids[2]);checks++;
  const foreign=await (await call(alias,'',tokens[2])).json();assert.equal(foreign.pagination.total,1);assert.equal(foreign[collection][0].id,ids[3]);checks++;
  const page=await (await call(alias,'?limit=1&offset=1')).json();assert.equal(page[collection].length,1);assert.notEqual(page[collection][0].id,result[collection][0].id);assert.equal(page.pagination.hasMore,false);checks++;
  assert.equal((await call(alias,'',tokens[0],{'x-tenant-id':tenants[1]})).status,403);assert.equal((await call(alias,'?userId=other')).status,400);assert.equal((await call(alias,'',tokens[0],{},'POST')).status,405);checks++;
  await db.query('DELETE FROM '+table+' WHERE id=ANY($1)',[ids.slice(0,2)]);const empty=await (await call(alias)).json();assert.deepEqual(empty[collection],[]);assert.equal(empty.pagination.total,0);checks++;
 }
 // Changing a profile tenant revokes the historical document alias scope.
 await db.query('UPDATE provider_profiles SET tenant_id=$1 WHERE id=$2',[tenants[1],profiles[0]]);assert.equal((await call(aliases[4])).status,404);checks++;
 await db.query("UPDATE auth_sessions SET expires_at=NOW()-INTERVAL '1 second' WHERE user_id=$1",[users[0]]);for(const alias of aliases)assert.equal((await call(alias)).status,401);checks++;
 await db.query("UPDATE users SET status='inactive' WHERE id=$1",[users[1]]);for(const alias of aliases)assert.equal((await call(alias,'',tokens[1])).status,401);checks++;
 console.log(`Governed read alias batches 106–110 passed ${checks} PostgreSQL gateway checks (${process.env.AUTH_TEST_ID_TYPE} auth identities).`);
}finally{for(const table of created.reverse())await db.query('DROP TABLE '+table);await db.query('DELETE FROM auth_sessions WHERE user_id::text=ANY($1)',[users]);await db.query('DELETE FROM users WHERE id::text=ANY($1)',[users]);await db.end();await rm(dir,{recursive:true,force:true});}
