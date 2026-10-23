// Actual Flutter widgets -> credential login -> gateway -> native policies -> PG.
// Loopback-only disposable acceptance; picture scanner/storage and mail are
// explicitly synthetic ports. Never production delivery or TURN acceptance.
import assert from 'node:assert/strict';
import {createServer} from 'node:http';
import {readFile,mkdir,mkdtemp,writeFile,rm} from 'node:fs/promises';
import {resolve,join,extname} from 'node:path';
import {tmpdir} from 'node:os';
import {createRequire} from 'node:module';
import {randomUUID,createHash} from 'node:crypto';
import {build} from 'esbuild';
import pg from 'pg';
import bcrypt from 'bcryptjs';
import sharp from 'sharp';
import {chromium} from 'playwright';
import {PrivatePictureRepository} from '../packages/shared/src/communications/pictures.mjs';

const connection=process.env.COMMUNICATION_STACK_DATABASE_URL;
if(!connection||process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL)throw Error('Disposable stack connection only; production credentials forbidden');
const url=new URL(connection);
if(!['localhost','127.0.0.1'].includes(url.hostname)||url.pathname!='/communication_stack_test')throw Error('Loopback communication_stack_test required');
const web=resolve(process.env.COMMUNICATION_STACK_WEB??'');
if(!process.env.COMMUNICATION_STACK_WEB)throw Error('Built real Flutter acceptance host required');
const pool=new pg.Pool({connectionString:connection}),out=resolve('test-results/communication-stack-browser');
await mkdir(out,{recursive:true});
const pin=JSON.parse(await readFile('tools/governance-production/production-pin.json'));
const access=JSON.parse(await readFile('tools/governance-production/communication-access-policy.json'));
const contracts=JSON.parse(await readFile('packages/shared/src/communications/registered-contracts.json'));
const ui=JSON.parse(await readFile('tools/governance-production/communication-ui-registration.json'));
const schema='"'+pin.schema+'"';const temp=await mkdtemp(join(tmpdir(),'communication-stack-'));
const tenant=randomUUID(),otherTenant=randomUUID(),alice=randomUUID(),bob=randomUUID(),outsider=randomUUID();
const password='Synthetic-'+randomUUID();const created=[],results={},requests=[];let ownsSchema=false,browser,server;
const q=(sql,values)=>pool.query(sql,values);
try {
 for(const name of ['users','tenants','auth_sessions','auth_rate_limits','business_work_aggregates','business_work_commands','business_work_events'])assert.equal((await q('SELECT to_regclass($1) AS relation',['public.'+name])).rows[0].relation,null,'Preserve existing data: '+name);
 await q('CREATE SCHEMA '+schema);ownsSchema=true;
 await q(`CREATE TABLE ${schema}.govt_source_manifest(manifest_sha256 text);CREATE TABLE ${schema}.govt_platform_hierarchy_policy(id text,definition jsonb,requirement text)`);
 await q(`INSERT INTO ${schema}.govt_source_manifest VALUES($1)`,[pin.manifestSha256]);
 const directory=structuredClone(access.directory);directory.mailboxes=[{id:'owned',tenantId:tenant,address:'owned@example.invalid',ownerId:alice,delegateIds:[bob],recipientAddresses:[],active:true,ownershipVerified:true}];
 for(const doc of [access.policy,directory])await q(`INSERT INTO ${schema}.govt_platform_hierarchy_policy VALUES($1,$2,$3)`,[doc.id,JSON.stringify({t:'text',v:JSON.stringify(doc)}),doc.requirement]);
 const tables={tenants:'id text PRIMARY KEY,status text',users:'id text PRIMARY KEY,email text UNIQUE,roles text,tenant_id text,status text,password_hash text,updated_at timestamptz DEFAULT NOW()',auth_sessions:'token_hash text PRIMARY KEY,user_id text,expires_at timestamptz,created_at timestamptz DEFAULT NOW()'};
 for(const [name,columns]of Object.entries(tables)){await q('CREATE TABLE public.'+name+'('+columns+')');created.push(name);}
 await q(await readFile('packages/database/migrations/20260928_auth_rate_limits.sql','utf8'));created.push('auth_rate_limits');
 await q(await readFile('packages/database/migrations/20261022_business_communications.sql','utf8'));created.push('business_work_aggregates','business_work_commands','business_work_events');
 await q('INSERT INTO tenants VALUES($1,\'active\'),($2,\'active\')',[tenant,otherTenant]);
 const hash=await bcrypt.hash(password,12);
 for(const [id,email,scope]of [[alice,'alice@example.invalid',tenant],[bob,'bob@example.invalid',tenant],[outsider,'outsider@example.invalid',otherTenant]])await q("INSERT INTO users(id,email,roles,tenant_id,status,password_hash) VALUES($1,$2,'fixture-role',$3,'active',$4)",[id,email,scope,hash]);
 const meta={roles:'id text,role_code text,active text',api_permissions:'api_id text,role_id text,can_access text,permission_key text',api_endpoints:'id text,http_method text,route_path text,service_name text,auth_required text,permission_key text',screen_api_links:'api_id text,screen_id text',screens:'id text,active text',role_screen_permissions:'role_id text,screen_id text,can_view text'};
 for(const [name,columns]of Object.entries(meta))await q(`CREATE TABLE ${schema}.govt_${name}(${columns})`);
 await q(`INSERT INTO ${schema}.govt_roles VALUES('7','fixture-role','1');INSERT INTO ${schema}.govt_screens VALUES('559','1');INSERT INTO ${schema}.govt_role_screen_permissions VALUES('7','559','1')`);
 for(const api of contracts.apis){await q(`INSERT INTO ${schema}.govt_api_endpoints VALUES($1,$2,$3,'governance','1','role_screen_permissions')`,[String(api.id),api.method,api.path]);await q(`INSERT INTO ${schema}.govt_api_permissions VALUES($1,'7','1','role_screen_permissions')`,[String(api.id)]);await q(`INSERT INTO ${schema}.govt_screen_api_links VALUES($1,'559')`,[String(api.id)]);}
 await build({entryPoints:{auth:'cloudflare/workers/src/auth.ts',gateway:'cloudflare/workers/src/gateway.ts',runtime:'cloudflare/workers/src/business-tasks/runtime.ts'},outdir:temp,bundle:true,platform:'node',format:'cjs',external:['pg']});
 const require=createRequire(import.meta.url);
 for(const file of ['auth.js','gateway.js','runtime.js'])await writeFile(join(temp,file),(await readFile(join(temp,file),'utf8')).replaceAll('require("pg")','require('+JSON.stringify(require.resolve('pg'))+')'));
 const {auth}=require(join(temp,'auth.js')),{default:gateway}=require(join(temp,'gateway.js')),{PostgresCommunicationWorker}=require(join(temp,'runtime.js'));
 const objects=new Map();const bucket={async put(key,body,meta){objects.set(key,{body:new Uint8Array(body),size:body.length,...meta});},async head(key){return objects.get(key);},async get(key){return objects.get(key);}};
 const pictures=new PrivatePictureRepository({sharp,bucket,scan:async()=>true,maxPixels:4096,maxBytes:ui.limits.maxPictureBytes});let sends=0;
 const {default:Ajv}=await import('ajv'),{default:addFormats}=await import('ajv-formats');const ajv=new Ajv({strict:false});addFormats(ajv);ajv.addFormat('binary',()=>true);const validators=new Map();
 const runtime=new PostgresCommunicationWorker({businessPool:pool,governancePool:pool,pictures,limits:{maxMembers:8,maxMessages:100,maxText:2000,maxPictureBytes:ui.limits.maxPictureBytes,maxPictures:3,ringMilliseconds:30000,maxSignalBytes:16384},nativeEmail:{async send(){sends++;return {messageId:'synthetic-provider-acceptance'};}},sender:'owned@example.invalid',maxMailBytes:65536,maxRenderedMailBytes:131072,maxRequestBytes:2*1024*1024,validate(schema,value){if(!validators.has(schema))validators.set(schema,ajv.compile(schema));return validators.get(schema)(value);}});
 const env={AUTH:{fetch:r=>auth(r,{DB_URL:connection,SERVICE_NAME:'auth'},new URL(r.url).pathname,{})},GOVERNANCE:{fetch:r=>runtime.fetch(r,{})}};
 server=createServer(async(req,res)=>{
  try {
   const path=new URL(req.url,'http://127.0.0.1').pathname;
   if(path.startsWith('/v1/')){
    const chunks=[];for await(const chunk of req)chunks.push(chunk);
    const body=Buffer.concat(chunks),headers=new Headers();for(const [key,value]of Object.entries(req.headers))if(typeof value==='string')headers.set(key,value);
    const response=await gateway.fetch(new Request('http://127.0.0.1'+req.url,{method:req.method,headers,...(body.length?{body}:{})}),env);
    requests.push({path,method:req.method,status:response.status});res.writeHead(response.status,Object.fromEntries(response.headers));res.end(Buffer.from(await response.arrayBuffer()));return;
   }
   const relative=decodeURIComponent(path).replace(/^\/+/,''),candidate=resolve(web,relative||'index.html');
   if(candidate!==web&&!candidate.startsWith(web+'/')){res.writeHead(404);res.end();return;}
   const mime={'.html':'text/html','.js':'text/javascript','.wasm':'application/wasm','.json':'application/json','.png':'image/png','.woff2':'font/woff2'};
   res.setHeader('content-type',mime[extname(candidate)]??'application/octet-stream');res.setHeader('cache-control','no-store');res.end(await readFile(candidate));
  }catch{res.writeHead(500);res.end('Isolated stack request failed');}
 });
 await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));const origin='http://127.0.0.1:'+server.address().port;
 browser=await chromium.launch({executablePath:process.env.BUSINESS_TEST_CHROMIUM_EXECUTABLE,args:['--no-sandbox','--disable-dev-shm-usage','--use-fake-device-for-media-stream','--use-fake-ui-for-media-stream','--autoplay-policy=no-user-gesture-required','--allow-loopback-in-peer-connection','--disable-features=WebRtcHideLocalIpsWithMdns']});
 // Flutter can merge the registered wrapper label with its child's spoken
 // label. Match the complete ID line, never an arbitrary prefix or UI text.
 const control=(page,id)=>page.locator('xpath=//*[@aria-label="'+id+'" or starts-with(@aria-label,"'+id+'\n")]').first();
 const id=key=>ui.controls[key].testId;
 const frame=page=>page.evaluate(()=>new Promise(resolve=>requestAnimationFrame(()=>requestAnimationFrame(resolve))));
 const fill=async(page,key,value)=>{
  const c=control(page,key);await c.waitFor();const tag=await c.evaluate(node=>node.tagName.toLowerCase());const input=['input','textarea'].includes(tag)?c:c.locator('input,textarea');
  // Focus the Flutter editor before typing. Mutating its semantics proxy with
  // fill() can race the focus transfer and leave controlled Dart state empty.
  await input.click();await frame(page);await page.keyboard.press('ControlOrMeta+A');await page.keyboard.type(value,{delay:10});await page.keyboard.press('Tab');await frame(page);
  assert.ok(await input.inputValue()===value,'Flutter input must retain the entered value: '+key);
 };
 const tap=async(page,key)=>{const c=control(page,key);await c.waitFor();const role=await c.getAttribute('role');await (role==='button'?c:c.getByRole('button')).click();};
 const call=async(token,path,body)=>{const r=await fetch(origin+path,{method:body?'POST':'GET',headers:{authorization:'Bearer '+token,'content-type':'application/json'},...(body?{body:JSON.stringify(body)}:{})});return r;};
 async function login(email){
  const context=await browser.newContext({viewport:{width:1440,height:1200},permissions:['microphone']});const page=await context.newPage();page.setDefaultTimeout(30000);
  await page.addInitScript(()=>{window.stackPeers=[];const Native=window.RTCPeerConnection;window.RTCPeerConnection=class extends Native{constructor(...args){super(...args);window.stackPeers.push(this);}};});
  await page.goto(origin+'/?enable-semantics=true');await fill(page,'login-email',email);await fill(page,'login-password',password);
  const response=page.waitForResponse(r=>r.url().endsWith('/v1/auth/login')&&r.request().method()==='POST');await tap(page,'login-submit');const r=await response;assert.equal(r.status(),200);const data=await r.json();assert.equal(data.tenantId,email==='outsider@example.invalid'?otherTenant:tenant);
  await control(page,id('root')).waitFor();return {context,page,token:data.token};
 }
 const a=await login('alice@example.invalid'),b=await login('bob@example.invalid');
 assert.equal((await q('SELECT COUNT(*)::int AS n FROM auth_sessions')).rows[0].n,2);assert.equal((await q('SELECT COUNT(*)::int AS n FROM auth_sessions WHERE token_hash=$1',[createHash('sha256').update(a.token).digest('hex')])).rows[0].n,1);results.realCredentialLogin=true;
 await fill(a.page,id('members'),bob);
 const createdResponse=a.page.waitForResponse(r=>r.url().endsWith('/v1/messages')&&r.request().postDataJSON()?.action==='create');await tap(a.page,id('create'));assert.equal((await createdResponse).status(),200);
 const thread=(await q("SELECT state FROM business_work_aggregates WHERE state->>'kind'='conversation'")).rows[0].state;assert.deepEqual(thread.members,[alice,bob]);
 await fill(a.page,id('composer'),'Browser to PostgreSQL message');const sent=a.page.waitForResponse(r=>r.url().endsWith('/v1/messages')&&r.request().postDataJSON()?.action==='send');await tap(a.page,id('send'));assert.equal((await sent).status(),200);
 let stored=(await q('SELECT state FROM business_work_aggregates WHERE id=$1',[thread.id])).rows[0].state;assert.equal(stored.messages[0].text,'Browser to PostgreSQL message');assert.equal(stored.messages[0].authorId,alice);results.uiMessageDatabaseReadback=true;
 await a.page.reload();await control(a.page,id('root')).waitFor();await tap(a.page,id('openThread')+'-0');await a.page.getByLabel('Browser to PostgreSQL message',{exact:false}).first().waitFor();results.sessionAndMessageReload=true;
 await tap(b.page,id('refresh'));await tap(b.page,id('openThread')+'-0');await b.page.getByLabel('Browser to PostgreSQL message',{exact:false}).first().waitFor();results.recipientRead=true;
 const image=await sharp({create:{width:16,height:16,channels:3,background:'#445566'}}).png().toBuffer();
 const uploadResponse=a.page.waitForResponse(r=>r.url().endsWith('/v1/messages/pictures')&&r.request().method()==='POST');
 const chooser=a.page.waitForEvent('filechooser');await tap(a.page,id('picturePick'));await (await chooser).setFiles({name:'synthetic.png',mimeType:'image/png',buffer:image});
 const uploaded=await uploadResponse;assert.equal(uploaded.status(),200);const picture=await uploaded.json();assert.equal(objects.size,1);
 await fill(a.page,id('composer'),'Picture from browser');const pictureSent=a.page.waitForResponse(r=>r.url().endsWith('/v1/messages')&&r.request().postDataJSON()?.action==='send');await tap(a.page,id('send'));assert.equal((await pictureSent).status(),200);
 stored=(await q('SELECT state FROM business_work_aggregates WHERE id=$1',[thread.id])).rows[0].state;assert.deepEqual(stored.messages.at(-1).pictureIds,[picture.id]);results.uiPicturePersisted=true;
 await tap(b.page,id('refresh'));await tap(b.page,id('openThread')+'-0');
 const pictureRead=b.page.waitForResponse(r=>new URL(r.url()).pathname==='/v1/messages/pictures'&&r.request().method()==='GET');await tap(b.page,id('pictureOpen')+'-1-0');
 const downloaded=await pictureRead;assert.equal(downloaded.status(),200);assert.equal((await sharp(await downloaded.body()).metadata()).width,16);await b.page.getByRole('img',{name:ui.locales.en.preview,exact:true}).waitFor();results.uiPrivatePictureRead=true;
 await fill(a.page,id('callRecipient'),bob);const invite=a.page.waitForResponse(r=>r.url().endsWith('/v1/messages/calls')&&r.request().postDataJSON()?.action==='invite');await tap(a.page,id('callInvite'));assert.equal((await invite).status(),200);
 await tap(b.page,id('callRefresh'));const accepted=b.page.waitForResponse(r=>r.url().endsWith('/v1/messages/calls')&&r.request().postDataJSON()?.action==='accept');await tap(b.page,id('callAccept')+'-0');assert.equal((await accepted).status(),200);
 await tap(a.page,id('callRefresh'));await tap(a.page,id('callConnect')+'-0');await tap(b.page,id('callConnect')+'-0');
 async function packets(page){return page.evaluate(async()=>{let n=0;for(const peer of window.stackPeers){const reports=await peer.getStats();for(const report of reports.values())if(report.type==='inbound-rtp'&&report.kind==='audio')n+=report.packetsReceived??0;}return n;});}
 const until=Date.now()+30000;let audio=[];do{audio=await Promise.all([packets(a.page),packets(b.page)]);if(audio.every(n=>n>0))break;await new Promise(resolve=>setTimeout(resolve,200));}while(Date.now()<until);
 assert.ok(audio.every(n=>n>0),'Positive packets through registered HTTP/PG signaling required');results.nativeSignalingAudioPackets=audio;
 const ended=a.page.waitForResponse(r=>r.url().endsWith('/v1/messages/calls')&&r.request().postDataJSON()?.action==='end');await tap(a.page,id('callEnd')+'-0');assert.equal((await ended).status(),200);await tap(b.page,id('callRefresh'));
 results.callClosed=await Promise.all([a.page,b.page].map(p=>p.evaluate(()=>window.stackPeers.every(peer=>peer.connectionState==='closed'))));assert.ok(results.callClosed.every(Boolean));
 await fill(a.page,id('mailTo'),'bob@example.invalid');await fill(a.page,id('mailSubject'),'Synthetic stack mail');await fill(a.page,id('mailBody'),'Mail through actual UI and database');
 const queued=a.page.waitForResponse(r=>r.url().endsWith('/v1/messages/email')&&r.request().postDataJSON()?.action==='queue');await tap(a.page,id('mailQueue'));assert.equal((await queued).status(),200);
 const delivered=a.page.waitForResponse(r=>r.url().endsWith('/v1/messages/email')&&r.request().postDataJSON()?.action==='deliver');await tap(a.page,id('mailDeliver'));assert.equal((await delivered).status(),200);assert.equal(sends,1);results.uiMailQueueAndProviderAcceptance=true;
 const raw=new TextEncoder().encode('Subject: Synthetic inbound\r\nContent-Type: text/html; charset=utf-8\r\n\r\n<p>Received through native event</p><script>HIDDEN</script>');await runtime.email({from:'outside@example.invalid',to:'owned@example.invalid',rawSize:raw.length,raw:new ReadableStream({start(c){c.enqueue(raw);c.close();}}),setReject(){assert.fail('Synthetic owned mail rejected');}},{});
 await fill(b.page,id('mailbox'),'owned');await tap(b.page,id('mailInbound'));await tap(b.page,id('mailOpen')+'-0');await b.page.getByLabel('Received through native event',{exact:false}).first().waitFor();results.uiReceivedMailPreview=true;
 const incoming=(await q("SELECT state FROM business_work_aggregates WHERE state->>'kind'='inbound_mail'")).rows[0].state;assert.equal(incoming.status,'quarantined');assert.equal(incoming.senderIdentityVerified,false);
 const outside=await (await fetch(origin+'/v1/auth/login',{method:'POST',headers:{'content-type':'application/json'},body:JSON.stringify({email:'outsider@example.invalid',password})})).json();
 assert.equal((await call(outside.token,'/v1/messages',{action:'read',id:thread.id})).status,404);results.crossTenantDenied=true;
 const forged=await fetch(origin+'/v1/messages/inbox',{headers:{authorization:'Bearer '+a.token,'x-tenant-id':otherTenant}});assert.equal(forged.status,403);results.forgedTenantDenied=true;
 await q(`UPDATE ${schema}.govt_api_permissions SET can_access='0'`);assert.equal((await call(a.token,'/v1/messages',{action:'read',id:thread.id})).status,403);await q(`UPDATE ${schema}.govt_api_permissions SET can_access='1'`);results.currentGrantRevocation=true;
 await a.page.screenshot({path:join(out,'alice-authenticated.png'),fullPage:true});await b.page.screenshot({path:join(out,'bob-received-mail.png'),fullPage:true});
 await q('DELETE FROM auth_sessions WHERE user_id=$1',[alice]);await a.page.reload();await control(a.page,'login-submit').waitFor();assert.equal((await call(a.token,'/v1/messages',{action:'read',id:thread.id})).status,401);results.sessionRevocationReload=true;
 assert.equal((await q("SELECT COUNT(*)::int AS n FROM business_work_events WHERE event_type='conversation.message'")).rows[0].n,2);
 results.databaseEventsReadback=true;
 console.log('COMMUNICATION_STACK_PASS '+JSON.stringify(results));
}catch(error){
 let index=0;for(const context of browser?.contexts()??[])for(const page of context.pages())try{
  await page.screenshot({path:join(out,'failure-'+index+'.png'),fullPage:true});
  const semantics=await page.locator('[aria-label]').evaluateAll(nodes=>nodes.map(node=>({tag:node.tagName,role:node.getAttribute('role'),label:node.getAttribute('aria-label')})));
  await writeFile(join(out,'semantics-'+index+++'.json'),JSON.stringify(semantics,null,2));
 }catch{}
 throw error;
}finally{
 await writeFile(join(out,'results.json'),JSON.stringify({sourceCommit:process.env.GITHUB_SHA,passed:results.databaseEventsReadback===true,scope:'Actual Flutter UI, auth, gateway, native policies and disposable PostgreSQL',production:false,syntheticPorts:['mail acceptance','picture scanner','private object bucket','microphone input'],liveProviderVerified:false,results,requests},null,2));
 await browser?.close();if(server)await new Promise(resolve=>server.close(resolve));
 for(const name of created.reverse())await q('DROP TABLE public.'+name+' CASCADE');if(ownsSchema)await q('DROP SCHEMA '+schema+' CASCADE');await pool.end();await rm(temp,{recursive:true,force:true});
}
