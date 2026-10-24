import {test} from 'node:test';
import assert from 'node:assert/strict';
import pg from 'pg';
import {readFile} from 'node:fs/promises';
import {snapshot,sources,createPrivateTables,privateAcl,names} from './migrate-voice-identity-schema.mjs';
const url=new URL(process.env.WORKFLOW_TEST_DATABASE_URL??'');
if(!['localhost','127.0.0.1'].includes(url.hostname)||url.pathname!=='/voice_identity_schema_test'||process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL)throw Error('Disposable loopback PostgreSQL required');
const pool=new pg.Pool({connectionString:url.href,max:1});
const reference=JSON.parse(await readFile('test-results/voice-identity-schema/reference.json','utf8'));
async function transaction(run){const db=await pool.connect();try{await db.query('BEGIN');await db.query('SET LOCAL search_path=pg_catalog,public');return await run(db);}finally{await db.query('ROLLBACK');db.release();}}
test('native schema fingerprint matches reviewed sources and only server owner has access',async()=>{await transaction(async db=>{assert.deepEqual(await snapshot(db),reference.shapes);await privateAcl(db);});});
test('native constraints reject unverified contact shape, premature OTP grants, forged task digest and orphan approval',async()=>{
 const cases=[['INSERT INTO public.communication_voice_verified_contacts(tenant_id,user_id,phone,version,verified_at) VALUES($1,$2,$3,1,now())',['tenant-fixture','user-fixture','not-a-phone'],'23514'],["INSERT INTO public.communication_voice_otp(call_sid,pairing_hash,state,expires_at) VALUES($1,$2,'verified',1)",['CA'+'a'.repeat(32),'b'.repeat(64)],'23514'],["INSERT INTO public.communication_voice_tasks(id,digest,status,intent) VALUES('fixture',$1,'proposed',$2)",['a'.repeat(64),JSON.stringify({id:'fixture',digest:'b'.repeat(64)})],'23514'],["INSERT INTO public.communication_voice_confirmations(intent_id,digest,call_sid,session_id,user_id,tenant_id,approved_at,expires_at) VALUES('missing',$1,$2,'session-fixture','user-fixture','tenant-fixture',1,2)",['a'.repeat(64),'CA'+'a'.repeat(32)],'23503']];
 for(const [sql,values,code] of cases)await transaction(async db=>{await assert.rejects(db.query(sql,values),error=>error.code===code);});
});
test('a mid-migration failure rolls back every DDL change and preserves existing schema',async()=>{
 const db=await pool.connect();try{
  await db.query('BEGIN');await db.query('SET LOCAL search_path=pg_catalog,public');
  for(const name of [...names].reverse())await db.query('DROP TABLE public.'+name);
  const input=await sources();input.at(-1).sql+='\nSELECT 1/0;';await assert.rejects(createPrivateTables(db,input),error=>error.code==='22012');await db.query('ROLLBACK');
  assert.deepEqual(await snapshot(db),reference.shapes);
 }finally{await db.query('ROLLBACK');db.release();}
});
test('unexpected PUBLIC access is detected and rollback restores private access',async()=>{
 await transaction(async db=>{await db.query('GRANT SELECT ON public.communication_voice_otp TO PUBLIC');await assert.rejects(privateAcl(db));});
 await transaction(async db=>{await privateAcl(db);});
});
test.after(async()=>{await pool.end();});
