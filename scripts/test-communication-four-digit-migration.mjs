// Isolated PostgreSQL schema only; never a production migration runner.
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import pg from 'pg';
const {Pool}=pg;
const connectionString=process.env.TWILIO_SMS_TEST_DATABASE_URL;
test('four-digit migration preserves legacy records, sequence state and unknown constraints',{skip:!connectionString},async()=>{
 const u=new URL(connectionString);
 if(!['127.0.0.1','localhost'].includes(u.hostname)||u.username!=='twilio_fixture'||u.pathname!=='/twilio_sms_test'||process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL)throw Error('Disposable loopback voice fixture only');
 const schema='four_digit_'+crypto.randomUUID().replaceAll('-',''),admin=new Pool({connectionString,max:1});let pool;
 try{
  await admin.query('CREATE SCHEMA '+schema);pool=new Pool({connectionString,max:1,options:'-c search_path='+schema});
  const extension=(await readFile('packages/database/migrations/20261023_voice_extensions.sql','utf8')).replaceAll('public.','');
  const voicemail=await readFile('packages/database/migrations/20261023_communication_voicemails.sql','utf8');
  const migration=await readFile('packages/database/migrations/20261024_four_digit_voice_extensions.sql','utf8');
  async function reset(){await pool.query('DROP TABLE IF EXISTS communication_voicemails,communication_voice_extensions;DROP SEQUENCE IF EXISTS communication_voice_extension_seq');await pool.query(extension);await pool.query(voicemail);}
  async function rejected(){await assert.rejects(pool.query(migration));await pool.query('ROLLBACK');}
  await reset();await pool.query(migration);
  assert.equal((await pool.query("SELECT nextval('communication_voice_extension_seq')::text AS n")).rows[0].n,'1000');
  await pool.query(migration);assert.equal((await pool.query("SELECT nextval('communication_voice_extension_seq')::text AS n")).rows[0].n,'1001');
  await pool.query("INSERT INTO communication_voice_extensions(extension,tenant_id,user_id) VALUES('1000','tenant-a','alice')");
  for(const bad of ['0000','999','10000','100001'])await assert.rejects(pool.query('INSERT INTO communication_voice_extensions(extension,tenant_id,user_id) VALUES($1,$2,$3)',[bad,'tenant-a','bad-'+bad]));
  await assert.rejects(pool.query("INSERT INTO communication_voice_extensions(extension,tenant_id,user_id) VALUES('1000','tenant-b','bob')"));
  await pool.query('ALTER SEQUENCE communication_voice_extension_seq RESTART WITH 9999');assert.equal((await pool.query("SELECT nextval('communication_voice_extension_seq')::text AS n")).rows[0].n,'9999');await assert.rejects(pool.query("SELECT nextval('communication_voice_extension_seq')"));
  await pool.query(migration);await assert.rejects(pool.query("SELECT nextval('communication_voice_extension_seq')"));
  await reset();await pool.query("INSERT INTO communication_voice_extensions(extension,tenant_id,user_id) VALUES('100001','tenant-a','alice')");await rejected();
  assert.equal((await pool.query('SELECT extension FROM communication_voice_extensions')).rows[0].extension,'100001');assert.equal((await pool.query("SELECT seqmin::text AS n FROM pg_sequence WHERE seqrelid='communication_voice_extension_seq'::regclass")).rows[0].n,'100000');
  await reset();await pool.query("INSERT INTO communication_voicemails(account_sid,call_sid,extension,tenant_id,user_id) VALUES($1,$2,'100001','tenant-a','alice')",['AC'+'a'.repeat(32),'CA'+'b'.repeat(32)]);await rejected();assert.equal((await pool.query('SELECT extension FROM communication_voicemails')).rows[0].extension,'100001');
  await reset();await pool.query("ALTER TABLE communication_voice_extensions DROP CONSTRAINT communication_voice_extensions_extension_check;ALTER TABLE communication_voice_extensions ADD CONSTRAINT communication_voice_extensions_extension_check CHECK(extension <> 'blocked')");await rejected();assert.equal((await pool.query("SELECT seqmin::text AS n FROM pg_sequence WHERE seqrelid='communication_voice_extension_seq'::regclass")).rows[0].n,'100000');
 }finally{await pool?.end();try{await admin.query('DROP SCHEMA '+schema+' CASCADE');}finally{await admin.end();}}
});
