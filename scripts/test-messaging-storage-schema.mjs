import {test,after} from 'node:test';
import assert from 'node:assert/strict';
import pg from 'pg';
import {readFile} from 'node:fs/promises';
import {sources,snapshot,privateAcl,validateMetadataShape,createPrivateTables,assertExisting} from './migrate-messaging-storage.mjs';
const url=new URL(process.env.WORKFLOW_TEST_DATABASE_URL??'');
if(!['localhost','127.0.0.1'].includes(url.hostname)||url.username!=='twilio_fixture'||url.pathname!=='/twilio_sms_test'||process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL)throw Error('Named disposable PostgreSQL required');
const pool=new pg.Pool({connectionString:url.href,max:1}),input=await sources();
const reference=JSON.parse(await readFile('test-results/messaging-storage-schema/reference.json','utf8'));
assert.equal(Object.keys(reference.shapes??{}).length,13,'The immutable tested reference must contain all 13 schema fingerprints');
async function rollback(run){const db=await pool.connect();try{await db.query('BEGIN');await db.query('SET LOCAL search_path=pg_catalog,public');return await run(db);}finally{await db.query('ROLLBACK');db.release();}}
test('all 13 native table fingerprints, 78 columns and private access match the registered design',async()=>{
 await rollback(async db=>{assert.deepEqual(await snapshot(db,input.names),reference.shapes);await validateMetadataShape(db,input.definition);await privateAcl(db,input.names);});
});
test('schema drift is rejected before creation without silently repairing data',async()=>{
 await rollback(async db=>{await db.query('ALTER TABLE public.business_sms_inbox ADD COLUMN unexpected text');await assert.rejects(assertExisting(await snapshot(db,input.names),reference));});
 await rollback(async db=>assert.deepEqual(await snapshot(db,input.names),reference.shapes));
});
test('mid-bundle failure rolls back every new table and restores the previous schema',async()=>{
 const db=await pool.connect();try{
  await db.query('BEGIN');await db.query('SET LOCAL search_path=pg_catalog,public');for(const name of [...input.names].reverse())await db.query('DROP TABLE public.'+name);
  await assert.rejects(createPrivateTables(db,{...input,sql:input.sql+'\nSELECT 1/0;'}),e=>e.code==='22012');await db.query('ROLLBACK');assert.deepEqual(await snapshot(db,input.names),reference.shapes);
 }finally{await db.query('ROLLBACK');db.release();}
});
test('PUBLIC access is detected and rollback restores owner-only access',async()=>{
 await rollback(async db=>{await db.query('GRANT SELECT ON public.business_sms_inbox TO PUBLIC');await assert.rejects(privateAcl(db,input.names));});
 await rollback(async db=>{await privateAcl(db,input.names);});
});
test('cross-tenant commands, malformed phones and orphan consent bindings fail native constraints',async()=>{
 for(const [sql,values]of [
  ['INSERT INTO public.communication_sms_consent(account_sid,shared_number,phone,blocked,version) VALUES($1,$2,$3,false,1)',['AC'+'a'.repeat(32),'+15550001000','bad']],
  ['INSERT INTO public.business_chat_commands(tenant_id,aggregate_id,command_key,actor_id,fingerprint,result) VALUES($1,$2,$3,$4,$5,$6)',['foreign','missing','key','actor','a'.repeat(64),'{}']],
  ['INSERT INTO public.communication_sms_links(id,tenant_id,user_id,conversation_id,account_sid,messaging_service_sid,shared_number,phone,contact_version,consent_version) VALUES($1,$2,$3,$4,$5,$6,$7,$8,1,1)',[crypto.randomUUID(),'fixture','user','thread','AC'+'a'.repeat(32),'MG'+'b'.repeat(32),'+15550001000','+15550002000']]
 ])await rollback(async db=>{await assert.rejects(db.query(sql,values),e=>['23503','23514'].includes(e.code));});
});
test('idempotent bundle execution leaves the same complete fingerprint',async()=>{
 await rollback(async db=>{await createPrivateTables(db,input);assert.deepEqual(await snapshot(db,input.names),reference.shapes);});
});
after(async()=>{await pool.end();});
