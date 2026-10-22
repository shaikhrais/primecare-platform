import test, {after} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import pg from 'pg';
import {deliverMfaNotifications} from '../cloudflare/workers/src/security/mfa-notifications.mjs';
if (!process.env.MFA_TEST_DATABASE_URL) throw Error('Disposable native PostgreSQL required');
const db = new pg.Client({connectionString:process.env.MFA_TEST_DATABASE_URL});await db.connect();
const schema='mfa_outbox_'+crypto.randomUUID().replaceAll('-','');
await db.query('CREATE SCHEMA '+schema);await db.query('SET search_path TO '+schema);
await db.query(readFileSync('packages/database/migrations/20261026_auth_mfa_lifecycle.sql','utf8'));
after(async()=>{await db.query('DROP SCHEMA '+schema+' CASCADE');await db.end();});
async function notice(locale='en'){
  const id=crypto.randomUUID();await db.query("INSERT INTO auth_mfa_notification_outbox(id,user_id,tenant_id,recipient,event,locale) VALUES($1,'synthetic-user','synthetic-tenant','synthetic@example.invalid','recovery_codes_issued',$2)",[id,locale]);return id;
}
test('successful delivery records acceptance once and emits no recipient or proof in its report',async()=>{
  await db.query('TRUNCATE auth_mfa_notification_outbox');const id=await notice('fr'),sent=[];
  const result=await deliverMfaNotifications(db,async n=>{sent.push(n);return 'synthetic-message-id';});
  assert.deepEqual(result,{claimed:1,sent:1,deferred:0,superseded:0});assert.equal(sent[0].locale,'fr');assert.equal(sent[0].id,id);
  assert.equal(JSON.stringify(result).includes('@'),false);assert.equal((await db.query('SELECT state FROM auth_mfa_notification_outbox')).rows[0].state,'sent');
  assert.equal((await deliverMfaNotifications(db,async()=>{throw Error('Must not resend');})).claimed,0);
});
test('transport failure and malformed acknowledgements remain queued with bounded backoff',async()=>{
  for(const ack of [null,{},'', 'bad\nack']){
    await db.query('TRUNCATE auth_mfa_notification_outbox');await notice();
    const result=await deliverMfaNotifications(db,async()=>ack);assert.equal(result.deferred,1);
    const record=(await db.query('SELECT state,available_at>NOW() AS delayed,lease_token,lease_until FROM auth_mfa_notification_outbox')).rows[0];
    assert.equal(record.state,'pending');assert.equal(record.delayed,true);assert.equal(record.lease_token,null);assert.equal(record.lease_until,null);
  }
  await db.query('UPDATE auth_mfa_notification_outbox SET available_at=NOW()');
  assert.equal((await deliverMfaNotifications(db,async()=>{throw Error('Synthetic unavailable');})).deferred,1);
  await db.query('UPDATE auth_mfa_notification_outbox SET available_at=NOW()');
  assert.equal((await deliverMfaNotifications(db,async()=>'retry-accepted')).sent,1);
});
test('an expired processing lease is reclaimed after a crashed worker',async()=>{
  await db.query('TRUNCATE auth_mfa_notification_outbox');const id=await notice();
  await db.query("UPDATE auth_mfa_notification_outbox SET state='sending',lease_token='abandoned',lease_until=NOW()-INTERVAL '1 second' WHERE id=$1",[id]);
  assert.equal((await deliverMfaNotifications(db,async()=>'recovered-send')).sent,1);
});
test('concurrent processors claim separate rows and each notice is sent once under live leases',async()=>{
  await db.query('TRUNCATE auth_mfa_notification_outbox');for(let i=0;i<6;i++)await notice();
  const clients=[new pg.Client({connectionString:process.env.MFA_TEST_DATABASE_URL}),new pg.Client({connectionString:process.env.MFA_TEST_DATABASE_URL})],sent=[];
  try{
    for(const c of clients){await c.connect();await c.query('SET search_path TO '+schema);}
    const results=await Promise.all(clients.map(c=>deliverMfaNotifications(c,async n=>{sent.push(n.id);return 'ack-'+n.id;},3)));
    assert.equal(results.reduce((n,r)=>n+r.sent,0),6);assert.equal(new Set(sent).size,6);
  }finally{await Promise.all(clients.map(c=>c.end()));}
});
test('a delayed worker cannot overwrite a newer lease owner',async()=>{
  await db.query('TRUNCATE auth_mfa_notification_outbox');const id=await notice();
  const result=await deliverMfaNotifications(db,async()=>{await db.query("UPDATE auth_mfa_notification_outbox SET lease_token='replacement-owner' WHERE id=$1",[id]);return 'old-worker-ack';});
  assert.equal(result.superseded,1);assert.equal((await db.query('SELECT state,lease_token FROM auth_mfa_notification_outbox')).rows[0].lease_token,'replacement-owner');
});
