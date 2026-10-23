import {test,after} from 'node:test';
import assert from 'node:assert/strict';
import {mkdtemp,rm} from 'node:fs/promises';
import {readFileSync} from 'node:fs';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {pathToFileURL} from 'node:url';
import {build} from 'esbuild';
import Ajv from 'ajv';
import addFormats from 'ajv-formats';
import {CommunicationService} from '../cloudflare/workers/src/business-tasks/communication.ts';
import {BusinessMailService} from '../cloudflare/workers/src/business-tasks/mail.ts';
import {CommunicationCore} from '../cloudflare/workers/src/business-tasks/channels.ts';
import {PostgresAtomicStore} from '../cloudflare/workers/src/business-tasks/store.ts';
import {MemoryAtomicStore} from './fixtures/business-memory-store.mjs';
import {BrowserAudioSession} from '../packages/shared/src/communications/audio-session.mjs';
const temp=await mkdtemp(join(tmpdir(),'communication-http-'));
after(()=>rm(temp,{recursive:true,force:true}));
await build({entryPoints:['cloudflare/workers/src/business-tasks/http.ts'],outfile:join(temp,'http.mjs'),bundle:true,platform:'node',format:'esm'});
const {CommunicationHttpWorker,CommunicationHttpError}=await import(pathToFileURL(join(temp,'http.mjs')).href);
const ajv=new Ajv({strict:false});addFormats(ajv);ajv.addFormat('binary',()=>true);
const compiled=new Map();
const validate=(schema,value)=>{if(!compiled.has(schema))compiled.set(schema,ajv.compile(schema));return compiled.get(schema)(value);};
let pool,store;
if(process.env.BUSINESS_TEST_DATABASE_URL){
 const {Pool}=await import('pg');pool=new Pool({connectionString:process.env.BUSINESS_TEST_DATABASE_URL});
 const schema='communication_http_'+crypto.randomUUID().replaceAll('-','');await pool.query('CREATE SCHEMA '+schema);await pool.end();
 pool=new Pool({connectionString:process.env.BUSINESS_TEST_DATABASE_URL,options:'-c search_path='+schema});
 await pool.query(readFileSync('packages/database/migrations/20261022_business_communications.sql','utf8').replaceAll('public.',''));store=new PostgresAtomicStore(pool);
 after(async()=>{await pool.query('DROP SCHEMA '+schema+' CASCADE');await pool.end();});
}else{store=new MemoryAtomicStore();console.log('HTTP: isolated memory fixture; native persistence acceptance requires CI');}
const users=new Map(['a','b','c','denied','other'].map(id=>[id,{id,tenantId:id==='other'?'tenant-b':'tenant-a'}]));
const policy={async assert(actor,action){if(actor.id==='inbound-mail'&&actor.tenantId==='tenant-a'&&action==='mail.receive')return;if(!users.has(actor.id))throw Error('Forbidden');},async assignee(actor,id){if(users.get(id)?.tenantId!==actor.tenantId)throw Error('Forbidden');}};
const pictures=new Map();const png=Uint8Array.from([137,80,78,71,13,10,26,10]);
const pictureAdapter={async prepare(actor,threadId,bytes,mediaType){const record={id:crypto.randomUUID(),tenantId:actor.tenantId,threadId,size:bytes.length,mediaType,status:'clean'};pictures.set(record.id,{record,bytes});return record;},async get(actor,id){const item=pictures.get(id);if(!item||item.record.tenantId!==actor.tenantId)throw Error('Picture unavailable');return item.record;},async open(actor,id){const item=pictures.get(id);return {body:item.bytes,size:item.bytes.length,httpMetadata:{contentType:'image/png'}};}};
const limits={maxMembers:8,maxMessages:100,maxText:2000,maxPictureBytes:1024,maxPictures:3,ringMilliseconds:30000,maxSignalBytes:16384};
const conversations=new CommunicationService(store,policy,pictureAdapter,limits);
let nativeSends=0;
const mail=new BusinessMailService(store,policy,{async access(actor,id){if(actor.tenantId!=='tenant-a'||!['a','b'].includes(actor.id)||id!=='fixture')throw Error('Forbidden');},async recipient(){},async resolve(){return {tenantId:'tenant-a',mailboxId:'fixture'};}},{async send(){nativeSends++;return {messageId:'synthetic-receipt'};}},'sender@example.invalid',4096);
const core=new CommunicationCore(conversations,mail);
const worker=new CommunicationHttpWorker({core,validate,maxRequestBytes:4096,
 async authenticate(request){const actor=users.get(request.headers.get('authorization'));if(!actor)throw new CommunicationHttpError(401);return actor;},
 async authorizeEndpoint(actor){if(actor.id==='denied')throw new CommunicationHttpError(403);}});
const request=(actor,path,body,method='POST')=>worker.fetch(new Request('https://api.example.invalid'+path,{method,headers:{authorization:actor,'content-type':'application/json'},...(method==='GET'?{}:{body:JSON.stringify(body)})}),{});
const command=async(actor,path,body,expected=200)=>{const response=await request(actor,path,body);assert.equal(response.status,expected,await response.clone().text());return response.json();};
const thread='thread:'+crypto.randomUUID();

test('registered inbox cannot bypass the direct-read call-party privacy projection',async()=>{
 const id='private-inbox:'+crypto.randomUUID();
 await command('a','/v1/messages',{action:'create',id,key:'create',members:['a','b','c'],businessReference:'synthetic-general'});
 await command('a','/v1/messages/calls',{action:'invite',id,key:'invite',version:1,callId:'private-call',recipientId:'b'});
 await command('b','/v1/messages/calls',{action:'accept',id,key:'accept',version:2,callId:'private-call'});
 await command('a','/v1/messages/calls',{action:'signal',id,key:'offer',version:3,callId:'private-call',signal:{type:'offer',description:{type:'offer',sdp:'synthetic-private-offer'}}});
 const nonparty=await (await request('c','/v1/messages/inbox',null,'GET')).json();
 assert.deepEqual(nonparty.items.find(item=>item.id===id).calls[0].signals,[]);
 const party=await (await request('b','/v1/messages/inbox',null,'GET')).json();
 assert.equal(party.items.find(item=>item.id===id).calls[0].signals[0].signal.description.sdp,'synthetic-private-offer');
});

test('registered ICE wire signals persist and the unregistered candidate alias is denied',async()=>{
 const id='ice-wire:'+crypto.randomUUID(),callId='ice:'+crypto.randomUUID();
 await command('a','/v1/messages',{action:'create',id,key:'create',members:['a','b'],businessReference:'synthetic-general'});
 await command('a','/v1/messages/calls',{action:'invite',id,key:'invite',version:1,callId,recipientId:'b'});
 await command('b','/v1/messages/calls',{action:'accept',id,key:'accept',version:2,callId});
 const candidate={candidate:'candidate:1 1 UDP 2122260223 127.0.0.1 50000 typ host',sdpMid:'0',sdpMLineIndex:0,usernameFragment:'synthetic'};
 await command('a','/v1/messages/calls',{action:'signal',id,key:'ice',version:3,callId,signal:{type:'ice',candidate}});
 await command('a','/v1/messages/calls',{action:'signal',id,key:'bad-alias',version:4,callId,signal:{type:'candidate',candidate}},400);
 const record=await command('b','/v1/messages',{action:'read',id});assert.equal(record.version,4);assert.deepEqual(record.calls[0].signals[0].signal,{type:'ice',candidate});
});

test('two shared audio sessions negotiate through registered HTTP, reload state and release on remote hangup',async()=>{
 const id='call-session:'+crypto.randomUUID(),callId='audio:'+crypto.randomUUID();
 await command('a','/v1/messages',{action:'create',id,key:'create',members:['a','b'],businessReference:'synthetic-general'});
 await command('a','/v1/messages/calls',{action:'invite',id,key:'invite',version:1,callId,recipientId:'b'});
 await command('b','/v1/messages/calls',{action:'accept',id,key:'accept',version:2,callId});
 const sessions=[],stopped=[],remote=[],remoteIce=[];
 for(const userId of ['a','b']){
  const transport={async execute(channel,input){
   const response=await request(userId,channel==='message'?'/v1/messages':'/v1/messages/calls',input);
   const value=await response.json();if(!response.ok)throw Object.assign(Error(value.error),{status:response.status});return value;
  }};
  const peer={addTrack(){},close(){},remoteDescription:null,localDescription:null,
   async createOffer(){return {type:'offer',sdp:'synthetic-offer'};},async createAnswer(){return {type:'answer',sdp:'synthetic-answer'};},
   async setLocalDescription(value){this.localDescription={toJSON:()=>value};},
   async setRemoteDescription(value){this.remoteDescription=value;remote.push({userId,type:value.type});},async addIceCandidate(candidate){remoteIce.push({userId,candidate});}};
  sessions.push(new BrowserAudioSession({transport,userId,threadId:id,callId,intervalMilliseconds:10000,media:{configuration:{iceServers:[]},getUserMedia:async()=>({getTracks:()=>[{stop(){stopped.push(userId);}}]}),createPeer:()=>peer}}));
 }
 try{
  await sessions[0].start();await sessions[1].start();await sessions[0].refresh();
  assert.deepEqual(remote,[{userId:'b',type:'offer'},{userId:'a',type:'answer'}]);
  const persisted=await command('b','/v1/messages',{action:'read',id});
  assert.equal(persisted.calls[0].signals.length,2);assert.equal(persisted.calls[0].answered,true);
  const candidate={candidate:'candidate:2 1 UDP 2122260223 127.0.0.1 50001 typ host',sdpMid:'0',sdpMLineIndex:0};
  for(const session of sessions){session.audio.peer.onicecandidate({candidate:{toJSON:()=>candidate}});await Promise.resolve();await session.writes;}
  await sessions[0].refresh();await sessions[1].refresh();
  assert.deepEqual(remoteIce,[{userId:'a',candidate},{userId:'b',candidate}]);
  const iceRecord=await command('a','/v1/messages',{action:'read',id});assert.deepEqual(iceRecord.calls[0].signals.slice(2).map(entry=>entry.signal.type),['ice','ice']);
  await sessions[0].hangUp();await sessions[1].refresh();assert.equal(sessions[1].closed,true);assert.deepEqual(stopped.sort(),['a','b']);
  const reloaded=await command('b','/v1/messages',{action:'read',id});assert.equal(reloaded.calls[0].status,'ended');
  await command('c','/v1/messages',{action:'read',id},404);await command('other','/v1/messages',{action:'read',id},404);
 }finally{sessions.forEach(session=>session.close());}
});

test('registered HTTP message create, send, participant read and inbox persist',async()=>{
 await command('a','/v1/messages',{action:'create',id:thread,key:'create',members:['a','b'],businessReference:'synthetic-general'});
 const send={action:'send',id:thread,key:'send',version:1,text:'Synthetic message'};
 await command('a','/v1/messages',send);await command('a','/v1/messages',send);
 const record=await command('b','/v1/messages',{action:'read',id:thread});assert.equal(record.messages.length,1);assert.equal(record.messages[0].text,send.text);
 const inbox=await request('b','/v1/messages/inbox?limit=10',null,'GET');assert.equal(inbox.status,200);assert.ok((await inbox.json()).items.some(item=>item.id===thread));
 const outsider=await request('other','/v1/messages/inbox',null,'GET');assert.deepEqual((await outsider.json()).items,[]);
 await command('c','/v1/messages',{action:'read',id:thread},404);
 await command('other','/v1/messages',{action:'read',id:thread},404);
});
test('HTTP rejects forged identity, extra fields and duplicate GET fields',async()=>{
 for(const extra of [{tenantId:'tenant-b'},{actorId:'b'},{roles:['admin']},{unexpected:'value'}])await command('a','/v1/messages',{action:'read',id:thread,...extra},400);
 assert.equal((await request('a','/v1/messages/inbox?limit=1&limit=100',null,'GET')).status,400);
 assert.equal((await request('a','/v1/messages/inbox?limit=NaN',null,'GET')).status,400);
 assert.equal((await request('a','/v1/messages/inbox?limit=101',null,'GET')).status,400);
 assert.equal((await request('a','/v1/messages/inbox?__proto__=value',null,'GET')).status,400);
});
test('authentication and endpoint denial precede parsing or dispatch',async()=>{
 assert.equal((await request('missing','/v1/messages',{not:'a command'})).status,401);
 assert.equal((await request('denied','/v1/messages',{not:'a command'})).status,403);
});
test('HTTP enforces exact routes, verbs, media type and actual body bound',async()=>{
 assert.equal((await request('a','/v1/messages/not-registered',{})).status,404);
 assert.equal((await request('a','/v1/messages',{},'PUT')).status,405);
 assert.equal((await worker.fetch(new Request('https://api.example.invalid/v1/messages',{method:'POST',headers:{authorization:'a','content-type':'text/plain'},body:'{}'}),{})).status,415);
 assert.equal((await request('a','/v1/messages',{text:'x'.repeat(5000)})).status,413);
});
test('oversized body stream is canceled before any command can run',async()=>{
 let canceled=false;
 const body=new ReadableStream({start(controller){controller.enqueue(new Uint8Array(4097));},cancel(){canceled=true;}});
 const response=await worker.fetch(new Request('https://api.example.invalid/v1/messages',{method:'POST',headers:{authorization:'a','content-type':'application/json'},body,duplex:'half'}),{});
 assert.equal(response.status,413);assert.equal(canceled,true);
});
test('multipart picture upload, attachment and private download retain authorization',async()=>{
 const form=new FormData();form.set('action','upload');form.set('threadId',thread);form.set('mediaType','image/png');form.set('file',new Blob([png],{type:'image/png'}),'picture.png');
 const response=await worker.fetch(new Request('https://api.example.invalid/v1/messages/pictures',{method:'POST',headers:{authorization:'a'},body:form}),{});
 assert.equal(response.status,200,await response.clone().text());const picture=await response.json();
 await command('a','/v1/messages',{action:'send',id:thread,key:'picture',version:2,text:'Synthetic picture',pictureIds:[picture.id]});
 const path='/v1/messages/pictures?action=open&threadId='+encodeURIComponent(thread)+'&pictureId='+picture.id;
 const download=await request('b',path,null,'GET');assert.equal(download.status,200);assert.equal(download.headers.get('content-type'),'image/png');assert.equal(download.headers.get('cache-control'),'private, no-store');assert.deepEqual(new Uint8Array(await download.arrayBuffer()),png);
 assert.equal((await request('c',path,null,'GET')).status,404);
});
test('registered call actions and signaling use the same HTTP/core state machine',async()=>{
 let version=3;
 for(const [actor,action,extra] of [['a','invite',{recipientId:'b'}],['b','accept',{}],['a','signal',{signal:{type:'offer',description:{type:'offer',sdp:'synthetic-offer'}}}],['b','signal',{signal:{type:'answer',description:{type:'answer',sdp:'synthetic-answer'}}}],['a','end',{}]]){
  const result=await command(actor,'/v1/messages/calls',{action,id:thread,key:'call-'+action+'-'+actor,version,callId:'fixture-call',...extra});version=result.version;
 }
 assert.equal((await command('b','/v1/messages',{action:'read',id:thread})).calls[0].status,'ended');
});
test('email queue/deliver/read preserve native acceptance and duplicate-send guard',async()=>{
 const id='email:'+crypto.randomUUID();
 await command('a','/v1/messages/email',{action:'queue',id,key:'queue',to:'receiver@example.invalid',subject:'Synthetic',text:'Fixture only'});
 const deliver={action:'deliver',id,key:'deliver',version:1};const first=await command('a','/v1/messages/email',deliver);assert.equal(first.status,'accepted');
 await command('a','/v1/messages/email',deliver);assert.equal(nativeSends,1);
 await command('b','/v1/messages/email',{action:'read',id},404);
 const read=await command('a','/v1/messages/email',{action:'read',id});assert.equal(read.providerMessageId,'synthetic-receipt');
 await command('a','/v1/messages/email',{action:'receive',raw:'forged'},400);
});
test('registered received-mail inbox discovers IDs for authorized read and paginates without raw data',async()=>{
 const received=[];
 for(let i=0;i<3;i++)received.push((await mail.receive({from:'outside@example.invalid',to:'owned@example.invalid',raw:new TextEncoder().encode('From: forged@example.invalid\r\nSubject: Synthetic unverified\r\nContent-Type: text/html; charset=utf-8\r\n\r\n<p>Private inbound fixture '+crypto.randomUUID()+'</p><img src="https://example.invalid/tracker">')})).id);
 const first=await request('b','/v1/messages/email/inbox?direction=inbound&mailboxId=fixture&limit=2',null,'GET');
 assert.equal(first.status,200,await first.clone().text());assert.equal(first.headers.get('cache-control'),'private, no-store');
 const page=await first.json();assert.deepEqual(page.items.map(item=>item.id),received.sort().slice(0,2));assert.ok(page.nextAfter);
 assert.ok(page.items.every(item=>item.kind==='inbound_mail'&&item.status==='quarantined'));
 for(const field of ['rawBase64','text','html','digest','mailboxId','tenantId'])assert.ok(!JSON.stringify(page).includes('"'+field+'"'));
 const next=await request('b','/v1/messages/email/inbox?direction=inbound&mailboxId=fixture&limit=2&after='+encodeURIComponent(page.nextAfter),null,'GET');const last=await next.json();assert.equal(last.items.length,1);assert.equal(last.nextAfter,null);
 const content=await command('b','/v1/messages/email',{action:'read',id:page.items[0].id});assert.ok(content.contentPreview.text.startsWith('Private inbound fixture '));assert.equal(content.contentPreview.status,'available');assert.equal(content.from,'outside@example.invalid');assert.equal(content.senderIdentityVerified,false);for(const field of ['rawBase64','html','attachments','digest','headers'])assert.equal(Object.hasOwn(content,field),false);
 for(const actor of ['c','other','denied'])assert.equal((await request(actor,'/v1/messages/email/inbox?direction=inbound&mailboxId=fixture',null,'GET')).status,403);
});
test('registered sent-mail inbox never takes an owner override and validates query variants',async()=>{
 const sent=await request('a','/v1/messages/email/inbox?direction=outbound',null,'GET');assert.equal(sent.status,200);
 const page=await sent.json();assert.equal(page.items.length,1);assert.equal(page.items[0].kind,'outbound_mail');assert.equal(Object.hasOwn(page.items[0],'text'),false);assert.equal(Object.hasOwn(page.items[0],'providerMessageId'),false);
 const other=await request('b','/v1/messages/email/inbox?direction=outbound',null,'GET');assert.deepEqual(await other.json(),{items:[],nextAfter:null});
 for(const query of ['direction=inbound','direction=outbound&mailboxId=fixture','direction=outbound&actorId=a','direction=outbound&tenantId=tenant-a','direction=outbound&limit=101','direction=outbound&limit=2&limit=3','direction=all','direction=outbound&action=read'])assert.equal((await request('a','/v1/messages/email/inbox?'+query,null,'GET')).status,400,query);
});
test('invalid response schema returns unavailable without exposing provider details',async()=>{
 const invalid=new CommunicationHttpWorker({core,validate(schema,value){return schema.required?.includes('version')?false:validate(schema,value);},maxRequestBytes:4096,async authenticate(){return users.get('a');},async authorizeEndpoint(){}});
 const response=await invalid.fetch(new Request('https://api.example.invalid/v1/messages',{method:'POST',headers:{'content-type':'application/json'},body:JSON.stringify({action:'read',id:thread})}),{});
 assert.equal(response.status,503);assert.deepEqual(await response.json(),{error:'unavailable'});
});
