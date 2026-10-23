import {test} from 'node:test';import assert from 'node:assert/strict';import {readFile} from 'node:fs/promises';import pg from 'pg';
import {PostgresRelaySessionClaims} from '../cloudflare/workers/src/business-tasks/relay-session-claims.ts';
const connection=process.env.TWILIO_SMS_TEST_DATABASE_URL;
test('native PostgreSQL claims permit one canonical call/session and never reopen on close',{skip:!connection},async()=>{
 const parsed=new URL(connection);assert.ok(['localhost','127.0.0.1','[::1]'].includes(parsed.hostname)&&parsed.pathname==='/twilio_sms_test','Disposable local Twilio database required');
 const schema='relay_fixture_'+crypto.randomUUID().replaceAll('-',''),admin=new pg.Pool({connectionString:connection});let first,second;
 try{await admin.query(`CREATE SCHEMA ${schema}`);first=new pg.Pool({connectionString:connection,options:`-c search_path=${schema}`});second=new pg.Pool({connectionString:connection,options:`-c search_path=${schema}`});await first.query(await readFile('packages/database/migrations/20261023_communication_relay_sessions.sql','utf8'));
  const a=new PostgresRelaySessionClaims(first),b=new PostgresRelaySessionClaims(second),callSid='CA'+'a'.repeat(32),providerSessionId='VX'+'b'.repeat(32),identity={actor:{id:'alice',tenantId:'tenant-a'},sessionId:'native-session',authentication:'otp',active:true,expiresAt:Date.now()+90000};
  const input={callSid,providerSessionId,identity,expiresAt:Date.now()+60000};const claims=await Promise.all([a.claim(input),b.claim(input)]);assert.equal(claims.filter(Boolean).length,1);const claimId=claims.find(Boolean);
  const row=(await first.query('SELECT * FROM communication_relay_sessions')).rows[0];assert.equal(row.user_id,'alice');assert.equal(row.tenant_id,'tenant-a');assert.equal(row.identity_session_id,'native-session');assert.equal(row.claim_id,claimId);
  assert.equal(await a.claim({...input,callSid:'CA'+'c'.repeat(32)}),null);assert.equal(await b.claim({...input,providerSessionId:'VX'+'d'.repeat(32)}),null);
  await a.finish(claimId);const ended=(await first.query('SELECT ended_at FROM communication_relay_sessions')).rows[0].ended_at;assert.ok(Number(ended)>0);await b.finish(claimId);assert.equal((await first.query('SELECT ended_at FROM communication_relay_sessions')).rows[0].ended_at,ended);assert.equal(await a.claim(input),null);
  await assert.rejects(a.claim({...input,expiresAt:Date.now()-1}));await assert.rejects(a.claim({...input,identity:{...identity,authentication:'voice-match'}}));assert.equal((await first.query('SELECT count(*)::int AS n FROM communication_relay_sessions')).rows[0].n,1);
 }finally{await first?.end();await second?.end();await admin.query(`DROP SCHEMA IF EXISTS ${schema} CASCADE`);await admin.end();}
});
