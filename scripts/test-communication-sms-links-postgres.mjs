// Disposable native PostgreSQL only. No production credentials or provider calls.
import assert from 'node:assert/strict';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import pg from 'pg';
import {PostgresSmsMessagingRepository,PostgresSmsConsentInboxStore,linkBoundSmsRecipientPolicy,linkBoundSmsTransport} from '../cloudflare/workers/src/business-tasks/sms-links.ts';
import {PostgresAtomicStore} from '../cloudflare/workers/src/business-tasks/store.ts';
import {SmsNotificationService} from '../cloudflare/workers/src/business-tasks/sms.ts';
const connectionString=process.env.TWILIO_SMS_TEST_DATABASE_URL;
if(!connectionString)throw Error('Disposable TWILIO_SMS_TEST_DATABASE_URL required');
const url=new URL(connectionString);
if(!['localhost','127.0.0.1','[::1]'].includes(url.hostname)||url.username!=='twilio_fixture'||url.pathname!=='/twilio_sms_test')throw Error('Only named disposable local SMS link fixture permitted');
const schema='sms_links_fixture_'+crypto.randomUUID().replaceAll('-','');
const admin=new pg.Pool({connectionString,max:1});await admin.query('CREATE SCHEMA '+schema);
const pool=new pg.Pool({connectionString,max:4,connectionTimeoutMillis:5000,options:'-c search_path='+schema});
const actor={id:'alice',tenantId:'tenant-a'},bob={id:'bob',tenantId:'tenant-a'},foreign={id:'alice',tenantId:'tenant-b'};
const context={actor,sessionHash:'a'.repeat(64)},bobContext={actor:bob,sessionHash:'b'.repeat(64)};
const config={accountSid:'AC'+'a'.repeat(32),messagingServiceSid:'MG'+'b'.repeat(32),sharedNumber:'+15550001000'},phone='+15550002000';
let denied=false,sends=0,groups=0;
const policy={async assert(){if(denied)throw Error('Policy denied');},async assignee(){throw Error('No assignment grant');}};
const policyFor=()=>policy,repository=new PostgresSmsMessagingRepository(pool,config,policyFor),inbox=new PostgresSmsConsentInboxStore(pool);
const event=(digit,control)=>({provider:'twilio',channel:'sms',accountSid:config.accountSid,messageSid:'SM'+digit.repeat(32),messagingServiceSid:config.messagingServiceSid,from:phone,to:config.sharedNumber,text:control,mediaCount:0,control});
const makeService=expected=>new SmsNotificationService(new PostgresAtomicStore(pool,'business_sms'),policy,
 linkBoundSmsRecipientPolicy(repository,expected,{async recipient(a,to){assert.equal(a.tenantId,actor.tenantId);assert.equal(to,phone);}}),
 linkBoundSmsTransport(repository,expected,{async send(){sends++;return {messageSid:'SM'+String(sends).repeat(32),status:'queued'};}}),
 {sender:config.sharedNumber,accountSid:config.accountSid,messagingServiceSid:config.messagingServiceSid,maxTextBytes:6400});
try{
 for(const name of ['20261022_business_communications.sql','20261023_business_sms.sql','20261023_communication_voice_otp.sql','20261024_communication_sms_inbox.sql','20261024_communication_sms_links.sql'])await pool.query((await readFile('packages/database/migrations/'+name,'utf8')).replaceAll('public.',''));
 await pool.query(`CREATE TABLE tenants(id text PRIMARY KEY,status text NOT NULL);
  CREATE TABLE users(id text PRIMARY KEY,tenant_id text NOT NULL,status text NOT NULL);
  CREATE TABLE auth_sessions(token_hash text PRIMARY KEY,user_id text NOT NULL,created_at timestamptz NOT NULL,expires_at timestamptz NOT NULL);
  INSERT INTO tenants VALUES('tenant-a','active'),('tenant-b','active');
  INSERT INTO users VALUES('alice','tenant-a','active'),('bob','tenant-a','active');`);
 for(const [a,hash,thread]of [[actor,context.sessionHash,'thread-a'],[bob,bobContext.sessionHash,'thread-b']]){
  await pool.query("INSERT INTO auth_sessions VALUES($1,$2,clock_timestamp(),clock_timestamp()+INTERVAL '1 hour')",[hash,a.id]);
  await pool.query('INSERT INTO communication_voice_verified_contacts(tenant_id,user_id,phone,version,verified_at) VALUES($1,$2,$3,1,now())',[a.tenantId,a.id,phone]);
  await pool.query('INSERT INTO business_work_aggregates(tenant_id,id,state) VALUES($1,$2,$3)',[a.tenantId,thread,JSON.stringify({id:thread,tenantId:a.tenantId,version:1,kind:'conversation',members:[a.id,'reception']})]);
 }
 assert.equal(await repository.status(context,'thread-a'),null);
 await assert.rejects(repository.status(bobContext,'thread-a'));
 await assert.rejects(repository.status({...context,sessionHash:'c'.repeat(64)},'thread-a'));
 denied=true;await assert.rejects(repository.status(context,'thread-a'),/Policy denied/);denied=false;groups++;
 const id=crypto.randomUUID(),input={id,conversationId:'thread-a',consent:true};
 const [first,retry]=await Promise.all([repository.bind(context,input),repository.bind(context,input)]);assert.deepEqual(first,retry);assert.equal((await repository.status(context,'thread-a')).id,id);assert.equal(first.address,phone);assert.equal(first.actorId,actor.id);assert.equal((await repository.resolve(actor,'thread-a')).id,id);
 assert.equal((await pool.query('SELECT count(*)::int AS n FROM communication_sms_links WHERE revoked_at IS NULL')).rows[0].n,1);groups++;
 await assert.rejects(repository.bind(bobContext,{id:crypto.randomUUID(),conversationId:'thread-b',consent:true}));
 for(const args of [{...input,phone:'+15550009999'},{...input,consent:false},{...input,tenantId:'forged'}])await assert.rejects(repository.bind(context,args));
 await assert.rejects(repository.bind({...context,actor:foreign},{...input,id:crypto.randomUUID()}));await assert.rejects(repository.resolve(bob,'thread-a'));await assert.rejects(repository.resolve(foreign,'thread-a'));groups++;
 await pool.query("UPDATE auth_sessions SET created_at=clock_timestamp()-INTERVAL '6 minutes' WHERE token_hash=$1",[context.sessionHash]);
 await assert.rejects(repository.bind(context,{...input,id:crypto.randomUUID()}));
 assert.equal((await repository.status(context,'thread-a')).id,id);
 await pool.query('UPDATE auth_sessions SET created_at=clock_timestamp() WHERE token_hash=$1',[context.sessionHash]);
 denied=true;await assert.rejects(repository.bind(context,{...input,id:crypto.randomUUID()}),/Policy denied/);denied=false;
 assert.equal((await repository.resolve(actor,'thread-a')).id,id);groups++;
 for(const [change,restore]of [
  ["UPDATE users SET status='inactive' WHERE id='alice'","UPDATE users SET status='active' WHERE id='alice'"],
  ["UPDATE tenants SET status='inactive' WHERE id='tenant-a'","UPDATE tenants SET status='active' WHERE id='tenant-a'"],
  ["UPDATE communication_voice_verified_contacts SET version=2 WHERE user_id='alice'","UPDATE communication_voice_verified_contacts SET version=1 WHERE user_id='alice'"],
  ["UPDATE communication_voice_verified_contacts SET revoked_at=now() WHERE user_id='alice'","UPDATE communication_voice_verified_contacts SET revoked_at=NULL WHERE user_id='alice'"]]){
   await pool.query(change);await assert.rejects(repository.resolve(actor,'thread-a'));await pool.query(restore);
  }groups++;
 const oldService=makeService(first);await oldService.queue(actor,'queued-before-stop','queue',phone,'Pending reply');
 // Prove committed STOP is serialized with submissions already in progress.
 let entered,release;const started=new Promise(r=>entered=r),gate=new Promise(r=>release=r),order=[];
 const guarded=repository.guardSend(first,async()=>{order.push('submission-started');entered();await gate;order.push('submission-finished');return 'synthetic-submission';});await started;
 let stopSettled=false;const stopping=inbox.accept(event('c','STOP')).then(result=>{stopSettled=true;order.push('stop-committed');return result;});
 await new Promise(r=>setTimeout(r,25));assert.equal(stopSettled,false);release();assert.equal(await guarded,'synthetic-submission');assert.equal(await stopping,'quarantined');
 assert.deepEqual(order,['submission-started','submission-finished','stop-committed']);
 await assert.rejects(oldService.deliver(actor,'queued-before-stop','deliver',1));assert.equal(sends,0);
 const stopped=(await pool.query('SELECT blocked,version::float8 AS version FROM communication_sms_consent WHERE account_sid=$1',[config.accountSid])).rows[0];assert.equal(stopped.blocked,true);
 assert.ok((await pool.query('SELECT revoked_at FROM communication_sms_links WHERE id=$1',[id])).rows[0].revoked_at);assert.equal(await repository.status(context,'thread-a'),null);groups++;
 assert.equal(await inbox.accept(event('c','STOP')),'duplicate');assert.deepEqual((await pool.query('SELECT blocked,version::float8 AS version FROM communication_sms_consent WHERE account_sid=$1',[config.accountSid])).rows[0],stopped);
 await assert.rejects(repository.bind(context,{...input,id:crypto.randomUUID()}));
 assert.equal(await inbox.accept(event('d','START')),'quarantined');await assert.rejects(repository.resolve(actor,'thread-a'));
 assert.equal(await inbox.accept(event('c','STOP')),'duplicate');assert.equal((await pool.query('SELECT blocked FROM communication_sms_consent WHERE account_sid=$1',[config.accountSid])).rows[0].blocked,false);groups++;
 const newId=crypto.randomUUID(),linked=await repository.bind(context,{...input,id:newId});assert.notEqual(linked.id,first.id);
 assert.equal(await inbox.accept(event('f','START')),'quarantined');assert.deepEqual(await repository.resolve(actor,'thread-a'),linked);
 await assert.rejects(oldService.deliver(actor,'queued-before-stop','deliver-again',1));assert.equal(sends,0);
 const newService=makeService(linked);await newService.queue(actor,'new-reply','queue',phone,'Fresh explicit consent');
 await Promise.all([newService.deliver(actor,'new-reply','deliver',1),newService.deliver(actor,'new-reply','deliver',1)]);assert.equal(sends,1);
 assert.equal((await pool.query("SELECT state->>'status' AS status FROM business_sms_aggregates WHERE id='new-reply'")).rows[0].status,'accepted');groups++;
 const failedPool={query:pool.query.bind(pool),async connect(){const db=await pool.connect();return {async query(sql,values){if(sql.startsWith('UPDATE communication_sms_links'))throw Error('Injected control persistence failure');return db.query(sql,values);},release(){db.release();}};}};
 const before=(await pool.query('SELECT * FROM communication_sms_consent WHERE account_sid=$1',[config.accountSid])).rows[0];
 await assert.rejects(new PostgresSmsConsentInboxStore(failedPool).accept(event('e','STOP')),/Injected/);
 assert.deepEqual((await pool.query('SELECT * FROM communication_sms_consent WHERE account_sid=$1',[config.accountSid])).rows[0],before);
 assert.equal((await pool.query('SELECT count(*)::int AS n FROM business_sms_inbox WHERE message_sid=$1',[event('e','STOP').messageSid])).rows[0].n,0);
 assert.equal((await repository.resolve(actor,'thread-a')).id,newId);groups++;
 await repository.revoke(context,newId);await repository.revoke(context,newId);await assert.rejects(repository.resolve(actor,'thread-a'));await assert.rejects(repository.guardSend(linked,async()=>assert.fail('Revoked link submitted')));groups++;
 // Policies use the owned client, including with a single-slot pool.
 const one=new pg.Pool({connectionString,max:1,connectionTimeoutMillis:3000,options:'-c search_path='+schema});
 try{
  const single=new PostgresSmsMessagingRepository(one,config,db=>({async assert(){assert.equal((await db.query('SELECT 1 AS n')).rows[0].n,1);},async assignee(){throw Error('No grants');}}));
  const l=await single.bind(context,{...input,id:crypto.randomUUID()});assert.equal((await single.resolve(actor,'thread-a')).id,l.id);
  assert.equal(await single.guardSend(l,async()=> 'single-slot-send'),'single-slot-send');
 }finally{await one.end();}groups++;
 const report={groupsPassed:groups,independentDatabaseReadback:true,nativeStatusVerified:true,queuedReplyBlockedAfterStop:true,startDidNotReviveOldReply:true,concurrentProviderSubmissionSerialized:true,singleSlotPoolVerified:true,liveProviderTraffic:false};
 console.log('SMS_LINKS_NATIVE_POSTGRES '+JSON.stringify(report));await mkdir('test-results/messaging',{recursive:true});await writeFile('test-results/messaging/sms-links-native.json',JSON.stringify(report,null,2)+'\n');
}finally{await pool.end();await admin.query('DROP SCHEMA '+schema+' CASCADE');await admin.end();}
