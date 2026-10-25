import assert from 'node:assert/strict';import pg from 'pg';import bcrypt from 'bcryptjs';import {chromium} from 'playwright';import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {createTenantRecord} from '../packages/shared/src/tenant-creation.mjs';import {totpAt} from '../cloudflare/workers/src/security/totp.mjs';import {nativePostgresOptions} from '../cloudflare/workers/src/business-tasks/native-postgres.ts';
const gateway='https://primecare-api-gateway.itpro-mohammed.workers.dev',site='https://primecare-clinic.pages.dev',source=process.env.GITHUB_SHA,role=JSON.parse(await readFile('test-results/internal-calls/live-role.json','utf8')).role;
const report={source,passed:false,synthetic:true,liveBrowsers:false,relayAudio:false,syntheticCleanup:false,stage:'configuration'},tenants=[crypto.randomUUID(),crypto.randomUUID()],users=[0,0,1].map((tenantIndex,i)=>({id:crypto.randomUUID(),tenant:tenants[tenantIndex],email:'calls-'+crypto.randomUUID()+'@example.invalid',password:'Synthetic-'+crypto.randomUUID()+'!',index:i})),contexts=[];
const db=new pg.Client(nativePostgresOptions(process.env.PRODUCTION_DATABASE_URL));let browser,connected=false;
const cy=(page,name)=>page.locator('[data-cy="'+name+'"]');
const request=async(user,path,body,status=200)=>{const r=await fetch(gateway+'/v1/calls/'+path,{method:'POST',headers:{authorization:'Bearer '+user.token,origin:site,'content-type':'application/json'},body:JSON.stringify(body),redirect:'error',signal:AbortSignal.timeout(30000)});if(r.status!==status)report.lastHttp={operation:path,actual:r.status,expected:status};assert.equal(r.status,status,'Native call HTTP status');return r.json();};
function decode32(value){let bits=0,n=0,bytes=[];for(const c of value){const v='ABCDEFGHIJKLMNOPQRSTUVWXYZ234567'.indexOf(c);assert.ok(v>=0);n=(n<<5)|v;bits+=5;if(bits>=8){bits-=8;bytes.push((n>>>bits)&255);}}return new Uint8Array(bytes);}
async function until(work,timeout=60000){const deadline=Date.now()+timeout;while(Date.now()<deadline){if(await work())return;await new Promise(r=>setTimeout(r,1000));}throw Error('Acceptance condition timed out');}
try{
 assert.match(role,/^[a-z][a-z0-9_]{0,79}$/);await db.connect();connected=true;
 report.stage='create-synthetic-identities';
 for(const tenant of tenants)await createTenantRecord(db,{id:tenant,slug:'internal-calls-'+tenant,name:'Synthetic calling acceptance'});
 for(const user of users)await db.query("INSERT INTO users(id,email,tenant_id,roles,status,password_hash,updated_at) VALUES($1,$2,$3,$4,'active',$5,NOW())",[user.id,user.email,user.tenant,role,await bcrypt.hash(user.password,12)]);
 browser=await chromium.launch({args:['--use-fake-ui-for-media-stream','--use-fake-device-for-media-stream']});
 report.stage='native-browser-login';
 for(const user of users){
  const context=await browser.newContext({permissions:['microphone'],viewport:{width:user.index===0?390:1280,height:900}});contexts.push(context);
  await context.addInitScript(()=>{
   window.__callPeers=[];window.__callTracks=[];
   const Original=window.RTCPeerConnection;
   window.RTCPeerConnection=class extends Original{constructor(...args){super(...args);window.__callPeers.push(this);}};
   const original=navigator.mediaDevices.getUserMedia.bind(navigator.mediaDevices);
   navigator.mediaDevices.getUserMedia=async options=>{const stream=await original(options);window.__callTracks.push(...stream.getTracks());return stream;};
  });
  const page=await context.newPage();user.page=page;await page.goto(site+'/login?enable-semantics=true');
  await cy(page,'login-email').fill(user.email);await cy(page,'login-password').fill(user.password);
  const responsePromise=page.waitForResponse(r=>r.url()===gateway+'/v1/auth/login'&&r.request().method()==='POST');await cy(page,'login-submit').click();const response=await responsePromise;assert.equal(response.status(),200);const auth=await response.json();
  if(auth.status==='mfa_required'){assert.equal(auth.purpose,'enroll');await cy(page,'mfa-form').waitFor();const key=await cy(page,'mfa-seed').textContent();assert.match(key,/^[A-Z2-7]{32}$/);await cy(page,'mfa-code').fill(await totpAt(decode32(key),Math.floor(Date.now()/1000)));await cy(page,'mfa-submit').click();}
  await page.waitForURL(url=>url.pathname!=='/login',{timeout:45000});
  await page.waitForFunction(()=>/^[A-Za-z0-9_-]{43}$/.test(sessionStorage.getItem('primecare_session')??''),{},{timeout:45000});
  user.token=await page.evaluate(()=>sessionStorage.getItem('primecare_session'));
  const workspace=await fetch(gateway+'/v1/governance/workspace',{headers:{authorization:'Bearer '+user.token},signal:AbortSignal.timeout(30000)});assert.equal(workspace.status,200);const data=await workspace.json();assert.equal(data.identity.userId,user.id);const screen=data.screens.find(s=>['psw_messages','patient_messages','communication','messaging'].includes(s.code));assert.ok(screen,'Existing communication screen required');
  const navigation=await page.goto(site+screen.route+'?view=calls&enable-semantics=true');assert.match(navigation.headers()['permissions-policy']??'',/microphone=\(self\)/);await cy(page,'internal-call-panel').waitFor({timeout:45000});
  assert.equal(await page.evaluate(()=>window.__callTracks.length),0);
  await cy(page,'internal-call-enable').click();
  await until(async()=>{const d=await request(user,'directory',{});if(d.self?.published){user.extension=d.self.extension;return true;}return false;});
 }
 const [alice,bob,foreign]=users;report.liveBrowsers=true;report.nativeLogin=true;report.explicitExtensionPublication=true;report.noPrematureMicrophone=true;
 await request(alice,'dial',{extension:foreign.extension,requestId:crypto.randomUUID()},404);
 report.stage='dial-and-answer';
 await cy(alice.page,'internal-call-extension').fill(bob.extension);
 const dialPromise=alice.page.waitForResponse(r=>r.url()===gateway+'/v1/calls/dial'&&r.request().method()==='POST');await cy(alice.page,'internal-call-dial').click();const dialResponse=await dialPromise;assert.equal(dialResponse.status(),200);const view=await dialResponse.json(),callId=view.calls.at(-1).id,dialBody=dialResponse.request().postDataJSON();
 const retry=await request(alice,'dial',dialBody);assert.equal(retry.calls.filter(c=>c.id===callId).length,1);
 await request(alice,'media',{id:view.id,callId},409);await request(foreign,'command',{action:'read',id:view.id},404);await request(foreign,'media',{id:view.id,callId},404);
 await until(async()=>await cy(bob.page,'internal-call-answer').isEnabled());await cy(bob.page,'internal-call-answer').click();
 report.stage='relay-audio';
 const stats=page=>page.evaluate(async()=>{
  const peer=window.__callPeers.at(-1);if(!peer)return {ready:false,peerCreated:false};
  const all=await peer.getStats(),audio=[...all.values()].filter(s=>s.type==='inbound-rtp'&&(s.kind==='audio'||s.mediaType==='audio'));
  const pair=[...all.values()].find(s=>s.type==='candidate-pair'&&s.state==='succeeded'&&(s.nominated||s.selected));
  const local=pair&&all.get(pair.localCandidateId),remote=pair&&all.get(pair.remoteCandidateId);
  return {connectionState:peer.connectionState,iceState:peer.iceConnectionState,signalingState:peer.signalingState,ready:peer.connectionState==='connected'&&audio.some(s=>s.packetsReceived>10)&&local?.candidateType==='relay'&&remote?.candidateType==='relay',packets:audio.reduce((sum,s)=>sum+(s.packetsReceived??0),0),relay:local?.candidateType==='relay'&&remote?.candidateType==='relay'};
 });
 await until(async()=>{const both=await Promise.all([stats(alice.page),stats(bob.page)]);report.mediaSummary=both;return both.every(s=>s.ready);},90000);
 const before=await Promise.all([stats(alice.page),stats(bob.page)]);await new Promise(r=>setTimeout(r,1500));const after=await Promise.all([stats(alice.page),stats(bob.page)]);assert.ok(after.every((s,i)=>s.packets>before[i].packets));report.relayAudio=true;report.bidirectionalPacketGrowth=true;
 const state=(await db.query('SELECT state FROM business_work_aggregates WHERE tenant_id=$1 AND id=$2',[alice.tenant,view.id])).rows[0].state;assert.equal(state.calls.find(c=>c.id===callId).status,'accepted');assert.ok(state.calls.find(c=>c.id===callId).signals.some(s=>s.signal.type==='offer'));assert.ok(state.calls.find(c=>c.id===callId).signals.some(s=>s.signal.type==='answer'));report.independentNativeReadback=true;
 await cy(alice.page,'internal-call-mute').click();assert.equal(await alice.page.evaluate(()=>window.__callTracks.filter(t=>t.readyState==='live').every(t=>!t.enabled)),true);await cy(alice.page,'internal-call-mute').click();report.muteVerified=true;
 report.stage='session-revocation';const logout=await fetch(gateway+'/v1/auth/logout',{method:'POST',headers:{authorization:'Bearer '+alice.token},signal:AbortSignal.timeout(20000)});assert.equal(logout.status,200);
 await until(()=>alice.page.evaluate(()=>window.__callPeers.every(p=>p.connectionState==='closed')&&window.__callTracks.every(t=>t.readyState==='ended')),30000);await request(alice,'directory',{},401);report.revokedSessionMediaReleased=true;
 // The still-authorized recipient ends the shared call through the actual UI.
 await cy(bob.page,'internal-call-end').click();await until(()=>bob.page.evaluate(()=>window.__callPeers.every(p=>p.connectionState==='closed')&&window.__callTracks.every(t=>t.readyState==='ended')),30000);
 await until(async()=>{const s=(await db.query('SELECT state FROM business_work_aggregates WHERE tenant_id=$1 AND id=$2',[alice.tenant,view.id])).rows[0].state;return s.calls.find(c=>c.id===callId).status==='ended';});
 report.endVerified=true;report.foreignTenantDenied=true;report.idempotentDial=true;report.passed=true;report.stage='complete';
}catch(e){report.failedStage=report.stage;report.passed=false;report.reason=e?.name==='AssertionError'?'acceptance_assertion_failed':'live_acceptance_failed';process.exitCode=1;}
finally{
 for(const context of contexts)await context.close().catch(()=>{});await browser?.close();
 if(connected){try{await db.query('BEGIN');for(const tenant of tenants){await db.query('DELETE FROM business_work_commands WHERE tenant_id=$1',[tenant]);await db.query('DELETE FROM business_work_events WHERE tenant_id=$1',[tenant]);await db.query('DELETE FROM business_work_aggregates WHERE tenant_id=$1',[tenant]);}
  for(const user of users){await db.query('DELETE FROM communication_voice_extensions WHERE user_id=$1 AND tenant_id=$2',[user.id,user.tenant]);await db.query('DELETE FROM auth_sessions WHERE user_id::text=$1',[user.id]);for(const table of ['auth_mfa_challenges','auth_mfa_credentials','auth_mfa_audit'])await db.query('DELETE FROM '+table+' WHERE user_id=$1',[user.id]);await db.query("DELETE FROM auth_rate_limits WHERE subject_hash=encode(sha256(convert_to($1,'UTF8')),'hex')",['login:'+user.email]);await db.query('DELETE FROM users WHERE id::text=$1 AND email=$2 AND tenant_id::text=$3',[user.id,user.email,user.tenant]);}
  for(const tenant of tenants)await db.query('DELETE FROM tenants WHERE id::text=$1 AND slug=$2',[tenant,'internal-calls-'+tenant]);await db.query('COMMIT');report.syntheticCleanup=true;
 }catch{await db.query('ROLLBACK').catch(()=>{});report.cleanupFailed=true;report.passed=false;process.exitCode=1;}await db.end();}
 await mkdir('test-results/internal-calls',{recursive:true});await writeFile('test-results/internal-calls/live-acceptance.json',JSON.stringify(report,null,2)+'\n');console.log('INTERNAL_CALL_LIVE '+JSON.stringify(report));
}
