import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {PostgresCommunicationAccessPolicy,PostgresCommunicationMailboxPolicy,PostgresCommunicationPolicyBase} from '../cloudflare/workers/src/business-tasks/access-policy.ts';
const definition=JSON.parse(readFileSync('tools/governance-production/communication-access-policy.json'));
const pin=JSON.parse(readFileSync('tools/governance-production/production-pin.json'));
const actor={id:'alice',tenantId:'tenant-a'};
function source({manifest=pin.manifestSha256,documents=Object.values(definition),failure=false}={}){
 const calls=[];let released=false;
 const pool={async connect(){return {async query(sql,values){
  calls.push({sql,values});
  if(sql.startsWith('SELECT manifest'))return {rows:[{manifest_sha256:manifest}]};
  if(sql.includes('govt_platform_hierarchy_policy')){if(failure)throw Error('Synthetic database failure');return {rows:documents.map(d=>({id:d.id,definition:JSON.stringify(d),requirement:d.requirement}))};}
  if(['BEGIN','SET LOCAL','ROLLBACK'].some(prefix=>sql.startsWith(prefix)))return {rows:[]};
  assert.fail('Unexpected native query');
 },release(){released=true;}};}};
 return {pool,calls,released:()=>released};
}
test('native policy ports inherit shared source checks and require a database',()=>{
 for(const Policy of [PostgresCommunicationAccessPolicy,PostgresCommunicationMailboxPolicy]){
  assert.throws(()=>new Policy({}),/database/);assert.ok(new Policy(source().pool) instanceof PostgresCommunicationPolicyBase);
 }
});
test('unregistered actions and malformed identity never acquire a native connection',async()=>{
 const f=source(),policy=new PostgresCommunicationAccessPolicy(f.pool);
 await assert.rejects(policy.assert(actor,'workflow.read',null),/Forbidden/);
 await assert.rejects(policy.assert({id:'',tenantId:'tenant-a'},'conversation.inbox',null),/Invalid actor|Invalid input/);
 await assert.rejects(policy.assignee(actor,'bob','review'),/Forbidden/);assert.equal(f.calls.length,0);
});
test('empty governed directory does not invent an inbound mailbox',async()=>{
 const f=source(),policy=new PostgresCommunicationMailboxPolicy(f.pool);
 assert.equal(await policy.resolve('unknown@example.invalid'),null);
 assert.equal(f.calls[0].sql,'BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(f.released());
 assert.deepEqual(f.calls.find(c=>c.sql.includes('govt_platform_hierarchy_policy')).values,[definition.policy.id,definition.directory.id]);
});
test('missing, duplicate, changed or ambiguous native policy metadata fails closed',async()=>{
 const changed=structuredClone(definition.policy);changed.rules.sameTenantEveryAction=false;
 const duplicate=structuredClone(definition.directory);duplicate.mailboxes=[{id:'one',tenantId:'tenant-a',address:'owned@example.invalid',ownerId:'alice',delegateIds:[],recipientAddresses:[],active:true,ownershipVerified:true}];duplicate.mailboxes.push({...duplicate.mailboxes[0],id:'two'});
 const extra=structuredClone(definition.directory);extra.unregisteredFallback=true;
 for(const documents of [[],[definition.policy,definition.policy],[changed,definition.directory],[definition.policy,duplicate],[definition.policy,extra]]){
  const f=source({documents});await assert.rejects(new PostgresCommunicationMailboxPolicy(f.pool).resolve('unknown@example.invalid'),/policy unavailable/);assert.ok(f.released());
 }
});
test('manifest mismatch and database errors always roll back and release',async()=>{
 for(const options of [{manifest:'changed'},{failure:true}]){
  const f=source(options);await assert.rejects(new PostgresCommunicationMailboxPolicy(f.pool).resolve('unknown@example.invalid'),/policy unavailable|Synthetic database failure/);assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(f.released());
 }
});

test('native current account, task, mailbox and registered HTTP integration',{skip:!process.env.BUSINESS_TEST_DATABASE_URL},async t=>{
 assert.ok(!process.env.PRODUCTION_DATABASE_URL&&!process.env.GOVERNANCE_DATABASE_URL,'Production credentials forbidden');
 const url=new URL(process.env.BUSINESS_TEST_DATABASE_URL);assert.ok(['localhost','127.0.0.1'].includes(url.hostname));assert.equal(url.pathname,'/communications_test');
 const {Pool}=await import('pg');const pool=new Pool({connectionString:url.href});
 const schema='"'+pin.schema+'"',created=[];let ownsSchema=false;
 const q=(sql,values)=>pool.query(sql,values);
 const put=async doc=>q(`UPDATE ${schema}.govt_platform_hierarchy_policy SET definition=$2::jsonb WHERE id=$1`,[doc.id,JSON.stringify({t:'text',v:JSON.stringify(doc)})]);
 const directory=structuredClone(definition.directory);
 directory.mailboxes=[
  {id:'owned',tenantId:'tenant-a',address:'owned@business.invalid',ownerId:'alice',delegateIds:['bob'],recipientAddresses:['approved@external.invalid'],active:true,ownershipVerified:true},
  {id:'foreign',tenantId:'tenant-b',address:'foreign@business.invalid',ownerId:'outsider',delegateIds:[],recipientAddresses:[],active:true,ownershipVerified:true},
  {id:'unverified',tenantId:'tenant-a',address:'unverified@business.invalid',ownerId:'alice',delegateIds:[],recipientAddresses:[],active:true,ownershipVerified:false}
 ];
 try{
  await q('CREATE SCHEMA '+schema);ownsSchema=true;
  await q(`CREATE TABLE ${schema}.govt_source_manifest(manifest_sha256 text)`);await q(`INSERT INTO ${schema}.govt_source_manifest VALUES($1)`,[pin.manifestSha256]);
  await q(`CREATE TABLE ${schema}.govt_platform_hierarchy_policy(id text,definition jsonb,requirement text)`);
  for(const doc of [definition.policy,directory])await q(`INSERT INTO ${schema}.govt_platform_hierarchy_policy VALUES($1,$2::jsonb,$3)`,[doc.id,JSON.stringify({t:'text',v:JSON.stringify(doc)}),doc.requirement]);
  for(const [name,columns] of Object.entries({tenants:'id text PRIMARY KEY,status text',users:'id text PRIMARY KEY,tenant_id text,roles text,status text,email text',auth_sessions:'user_id text,token_hash text,expires_at timestamptz'})){
   await q('CREATE TABLE public.'+name+'('+columns+')');created.push(name);
  }
  await q("INSERT INTO public.tenants VALUES('tenant-a','active'),('tenant-b','active'),('disabled-tenant','inactive')");
  for(const [id,tenant,status] of [['alice','tenant-a','active'],['bob','tenant-a','active'],['carol','tenant-a','active'],['outsider','tenant-b','active'],['paused','tenant-a','inactive'],['disabled','disabled-tenant','active']])await q('INSERT INTO public.users VALUES($1,$2,$3,$4,$5)',[id,tenant,'fixture-role',status,id+'@example.invalid']);
  for(const name of ['business_work_aggregates','business_work_commands','business_work_events'])assert.equal((await q('SELECT to_regclass($1) AS relation',['public.'+name])).rows[0].relation,null,'Preserve existing tables');
  await q(readFileSync('packages/database/migrations/20261022_business_communications.sql','utf8'));created.push('business_work_aggregates','business_work_commands','business_work_events');
  const task={id:'restricted-task',tenantId:'tenant-a',kind:'workflow',version:1,originatorId:'alice',ownerId:'bob',reviewerId:'carol'};
  const saveTask=()=>q('INSERT INTO public.business_work_aggregates VALUES($1,$2,$3::jsonb) ON CONFLICT(tenant_id,id) DO UPDATE SET state=EXCLUDED.state',['tenant-a',task.id,JSON.stringify(task)]);
  await saveTask();
  const policy=new PostgresCommunicationAccessPolicy(pool),mailboxes=new PostgresCommunicationMailboxPolicy(pool);
  const conversation={id:'proposal',tenantId:'tenant-a',kind:'conversation',version:0,members:['alice','bob'],businessReference:'general'};
  await t.test('general conversations permit active same-tenant members without copying roles',async()=>{
   await policy.assert(actor,'conversation.create',null);await policy.assert(actor,'conversation.create',conversation);await policy.assert(actor,'conversation.inbox',null);await policy.assignee(actor,'bob','communication');
  });
  await t.test('inactive accounts, disabled tenants and cross-tenant members are denied',async()=>{
   for(const other of [{id:'paused',tenantId:'tenant-a'},{id:'disabled',tenantId:'disabled-tenant'},{id:'alice',tenantId:'tenant-b'}])await assert.rejects(policy.assert(other,'conversation.inbox',null),/Forbidden/);
   await assert.rejects(policy.assert(actor,'conversation.create',{...conversation,members:['alice','outsider']}),/Forbidden/);await assert.rejects(policy.assignee(actor,'outsider','communication'),/Forbidden/);
  });
  await t.test('unknown clinical or HR references cannot bypass linked task participants',async()=>{
   await policy.assert(actor,'conversation.read',{...conversation,businessReference:task.id});
   for(const ref of ['missing-clinical-case','missing-hr-case'])await assert.rejects(policy.assert(actor,'conversation.create',{...conversation,businessReference:ref}),/Forbidden/);
   await assert.rejects(policy.assert(actor,'conversation.read',{...conversation,businessReference:task.id,members:['alice','paused']}),/Forbidden/);
  });
  await t.test('task handoff revokes former participants on the next action',async()=>{
   task.ownerId='carol';await saveTask();await assert.rejects(policy.assert(actor,'conversation.read',{...conversation,businessReference:task.id}),/Forbidden/);task.ownerId='bob';await saveTask();
  });
  await t.test('owned routing and current owner/delegate access exclude other tenants and unverified addresses',async()=>{
   assert.deepEqual(await mailboxes.resolve('OWNED@BUSINESS.INVALID'),{tenantId:'tenant-a',mailboxId:'owned'});assert.equal(await mailboxes.resolve('unknown@business.invalid'),null);assert.equal(await mailboxes.resolve('unverified@business.invalid'),null);
   await mailboxes.access(actor,'owned');await mailboxes.access({id:'bob',tenantId:'tenant-a'},'owned');
   await assert.rejects(mailboxes.access({id:'carol',tenantId:'tenant-a'},'owned'),/Forbidden/);await assert.rejects(mailboxes.access(actor,'foreign'),/Forbidden/);
  });
  await t.test('recipients need an active same-tenant account or an explicit accessible mailbox contact',async()=>{
   await mailboxes.recipient(actor,'BOB@EXAMPLE.INVALID');await mailboxes.recipient(actor,'approved@external.invalid');
   await mailboxes.recipient({id:'bob',tenantId:'tenant-a'},'approved@external.invalid');
   for(const address of ['outsider@example.invalid','paused@example.invalid','unapproved@external.invalid'])await assert.rejects(mailboxes.recipient(actor,address),/Forbidden/);
   await assert.rejects(mailboxes.recipient({id:'carol',tenantId:'tenant-a'},'approved@external.invalid'),/Forbidden/);
   await q("INSERT INTO public.users VALUES('external-account','tenant-b','fixture-role','active','approved@external.invalid')");await assert.rejects(mailboxes.recipient(actor,'approved@external.invalid'),/Forbidden/);await q("DELETE FROM public.users WHERE id='external-account'");
  });
  await t.test('delegation and owner-account revocations apply immediately',async()=>{
   const revoked=structuredClone(directory);revoked.mailboxes[0].delegateIds=[];await put(revoked);await assert.rejects(mailboxes.access({id:'bob',tenantId:'tenant-a'},'owned'),/Forbidden/);await mailboxes.access(actor,'owned');await put(directory);
   await q("UPDATE public.users SET status='inactive' WHERE id='alice'");await assert.rejects(mailboxes.resolve('owned@business.invalid'),/Forbidden/);await assert.rejects(mailboxes.access({id:'bob',tenantId:'tenant-a'},'owned'),/Forbidden/);await q("UPDATE public.users SET status='active' WHERE id='alice'");
  });
  await t.test('ambiguous native mailbox records and changed rules never become permissive defaults',async()=>{
   const duplicate=structuredClone(directory);duplicate.mailboxes.push({...duplicate.mailboxes[0],id:'collision'});await put(duplicate);await assert.rejects(policy.assert(actor,'conversation.inbox',null),/policy unavailable/);await put(directory);
   const changed=structuredClone(definition.policy);changed.rules.sameTenantEveryAction=false;await put(changed);await assert.rejects(policy.assert(actor,'conversation.inbox',null),/policy unavailable/);await put(definition.policy);
  });
  await t.test('internal receive identity still requires the exact owned tenant and mailbox',async()=>{
   const inbound={id:'incoming',tenantId:'tenant-a',kind:'inbound_mail',version:0,mailboxId:'owned',to:'owned@business.invalid',status:'quarantined',senderIdentityVerified:false};
   await policy.assert({id:'inbound-mail',tenantId:'tenant-a'},'mail.receive',inbound);
   await assert.rejects(policy.assert(actor,'mail.receive',inbound),/Forbidden/);await assert.rejects(policy.assert({id:'inbound-mail',tenantId:'tenant-b'},'mail.receive',inbound),/Forbidden/);
   await assert.rejects(policy.assert({id:'inbound-mail',tenantId:'tenant-a'},'mail.receive',{...inbound,to:'other@business.invalid'}),/Forbidden/);
   await assert.rejects(policy.assert({id:'bob',tenantId:'tenant-a'},'mail.read',{id:'sent',kind:'outbound_mail',version:1,tenantId:'tenant-a',ownerId:'alice'}),/Forbidden/);
  });
  await t.test('default runtime crosses native session, endpoint grants, policies and storage for messages, calls and mail',async()=>{
   const {mkdtemp,rm}=await import('node:fs/promises'),{tmpdir}=await import('node:os'),{join}=await import('node:path'),{pathToFileURL}=await import('node:url'),{build}=await import('esbuild');
   const temp=await mkdtemp(join(tmpdir(),'communication-native-policy-'));
   try{
    await build({entryPoints:['cloudflare/workers/src/business-tasks/runtime.ts'],outfile:join(temp,'runtime.mjs'),bundle:true,platform:'node',format:'esm'});
    const {PostgresCommunicationWorker}=await import(pathToFileURL(join(temp,'runtime.mjs')).href);
    const {default:Ajv}=await import('ajv'),{default:addFormats}=await import('ajv-formats');const ajv=new Ajv({strict:false});addFormats(ajv);ajv.addFormat('binary',()=>true);const compiled=new Map();
    const tables={roles:'id text,role_code text,active text',api_permissions:'api_id text,role_id text,can_access text,permission_key text',api_endpoints:'id text,http_method text,route_path text,service_name text,auth_required text,permission_key text',screen_api_links:'api_id text,screen_id text',screens:'id text,active text',role_screen_permissions:'role_id text,screen_id text,can_view text'};
    for(const [name,columns]of Object.entries(tables))await q(`CREATE TABLE ${schema}.govt_${name}(${columns})`);
    await q(`INSERT INTO ${schema}.govt_roles VALUES('7','fixture-role','1');INSERT INTO ${schema}.govt_screens VALUES('234','1');INSERT INTO ${schema}.govt_role_screen_permissions VALUES('7','234','1')`);
    const catalog=JSON.parse(readFileSync('packages/shared/src/communications/registered-contracts.json'));
    for(const api of catalog.apis){await q(`INSERT INTO ${schema}.govt_api_endpoints VALUES($1,$2,$3,'governance','1','role_screen_permissions')`,[String(api.id),api.method,api.path]);await q(`INSERT INTO ${schema}.govt_api_permissions VALUES($1,'7','1','role_screen_permissions')`,[String(api.id)]);await q(`INSERT INTO ${schema}.govt_screen_api_links VALUES($1,'234')`,[String(api.id)]);}
    const tokens={alice:'a'.repeat(43),bob:'b'.repeat(43),carol:'c'.repeat(43)};
    for(const [id,token]of Object.entries(tokens)){const hash=Buffer.from(await crypto.subtle.digest('SHA-256',new TextEncoder().encode(token))).toString('hex');await q("INSERT INTO public.auth_sessions VALUES($1,$2,NOW()+INTERVAL '1 hour')",[id,hash]);}
    let sends=0;const pictures=new Map(),png=new Uint8Array([137,80,78,71,13,10,26,10]);
    const worker=new PostgresCommunicationWorker({businessPool:pool,governancePool:pool,pictures:{async prepare(actor,threadId,bytes,mediaType){const record={id:'picture',tenantId:actor.tenantId,threadId,mediaType,size:bytes.length,status:'clean'};pictures.set('picture',record);return record;},async get(actor,id){return pictures.get(id);},async open(){return {body:png,size:png.length,httpMetadata:{contentType:'image/png'}};}},limits:{maxMembers:8,maxMessages:100,maxText:2000,maxPictureBytes:1024,maxPictures:3,ringMilliseconds:30000,maxSignalBytes:16384},nativeEmail:{async send(){sends++;return {messageId:'synthetic-native-acceptance'};}},sender:'sender@business.invalid',maxMailBytes:4096,maxRenderedMailBytes:8192,maxRequestBytes:8192,validate(schema,value){if(!compiled.has(schema))compiled.set(schema,ajv.compile(schema));return compiled.get(schema)(value);}});
    const request=(user,path,input,method='POST')=>worker.fetch(new Request('https://fixture.invalid'+path,{method,headers:{authorization:'Bearer '+tokens[user],'content-type':'application/json'},...(method==='GET'?{}:{body:JSON.stringify(input)})}),{});
    const command=async(user,path,input,status=200,method='POST')=>{const response=await request(user,path,input,method);assert.equal(response.status,status,await response.clone().text());return response.json();};
    await command('alice','/v1/messages',{action:'create',id:'native-thread',key:'create',members:['alice','bob'],businessReference:'general'});
    const form=new FormData();form.set('action','upload');form.set('threadId','native-thread');form.set('mediaType','image/png');form.set('file',new Blob([png],{type:'image/png'}),'synthetic.png');
    const uploaded=await worker.fetch(new Request('https://fixture.invalid/v1/messages/pictures',{method:'POST',headers:{authorization:'Bearer '+tokens.alice},body:form}),{});assert.equal(uploaded.status,200,await uploaded.clone().text());
    const opened=await request('bob','/v1/messages/pictures?action=open&threadId=native-thread&pictureId=picture',null,'GET');assert.equal(opened.status,200);assert.deepEqual(new Uint8Array(await opened.arrayBuffer()),png);
    assert.equal((await request('carol','/v1/messages/pictures?action=open&threadId=native-thread&pictureId=picture',null,'GET')).status,404);
    await command('alice','/v1/messages',{action:'send',id:'native-thread',key:'message',version:1,text:'Native shared core',pictureIds:['picture']});
    assert.equal((await command('bob','/v1/messages',{action:'read',id:'native-thread'})).messages[0].text,'Native shared core');
    await command('carol','/v1/messages',{action:'read',id:'native-thread'},404);
    await command('alice','/v1/messages/calls',{action:'invite',id:'native-thread',key:'invite',version:2,callId:'call',recipientId:'bob'});
    await command('bob','/v1/messages/calls',{action:'accept',id:'native-thread',key:'accept',version:3,callId:'call'});
    await command('alice','/v1/messages/calls',{action:'signal',id:'native-thread',key:'offer',version:4,callId:'call',signal:{type:'offer',description:{type:'offer',sdp:'synthetic-offer'}}});
    await command('bob','/v1/messages/calls',{action:'end',id:'native-thread',key:'end',version:5,callId:'call'});
    await command('alice','/v1/messages/email',{action:'queue',id:'native-mail',key:'queue',to:'bob@example.invalid',subject:'Synthetic native policy',text:'Test fixture only'});
    const deliver={action:'deliver',id:'native-mail',key:'deliver',version:1};await command('alice','/v1/messages/email',deliver);await command('alice','/v1/messages/email',deliver);assert.equal(sends,1);
    await command('bob','/v1/messages/email',{action:'read',id:'native-mail'},404);
    const raw=new TextEncoder().encode('From: forged@external.invalid\r\nSubject: Unverified synthetic\r\nContent-Type: text/html\r\n\r\n<p>Synthetic inbound native policy</p><script>PRIVATE SCRIPT</script><img src="https://example.invalid/tracker">');await worker.email({from:'outside@external.invalid',to:'owned@business.invalid',rawSize:raw.length,raw:new ReadableStream({start(controller){controller.enqueue(raw);controller.close();}}),setReject(){assert.fail('Valid synthetic inbound rejected');}},{});
    const inbox=await command('bob','/v1/messages/email/inbox?direction=inbound&mailboxId=owned',null,200,'GET');assert.equal(inbox.items.length,1);assert.equal(inbox.items[0].rawBase64,undefined);
    const read=await command('bob','/v1/messages/email',{action:'read',id:inbox.items[0].id});assert.equal(read.contentPreview.text.trim(),'Synthetic inbound native policy');assert.equal(read.contentPreview.status,'available');assert.equal(read.status,'quarantined');assert.equal(read.senderIdentityVerified,false);assert.equal(read.from,'outside@external.invalid');for(const field of ['rawBase64','html','attachments','headers','digest'])assert.equal(Object.hasOwn(read,field),false);
    const revoked=structuredClone(directory);revoked.mailboxes[0].delegateIds=[];await put(revoked);await command('bob','/v1/messages/email/inbox?direction=inbound&mailboxId=owned',null,403,'GET');await put(directory);
    await q(`UPDATE ${schema}.govt_api_permissions SET can_access='0'`);await command('alice','/v1/messages',{action:'read',id:'native-thread'},403);await q(`UPDATE ${schema}.govt_api_permissions SET can_access='1'`);
    await q("UPDATE public.users SET status='inactive' WHERE id='bob'");await command('bob','/v1/messages',{action:'read',id:'native-thread'},401);await q("UPDATE public.users SET status='active' WHERE id='bob'");
    console.log('Native policies: real disposable PostgreSQL and registered HTTP; provider mail/media ports are synthetic, not live delivery acceptance');
   }finally{await rm(temp,{recursive:true,force:true});}
  });
 }finally{
  for(const name of created.reverse())await q('DROP TABLE public.'+name);
  if(ownsSchema)await q('DROP SCHEMA '+schema+' CASCADE');await pool.end();
 }
});
