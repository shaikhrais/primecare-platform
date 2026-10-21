import pg from 'pg';
import bcrypt from 'bcryptjs';
import {chromium} from 'playwright';
import {mkdir,writeFile} from 'node:fs/promises';
import assert from 'node:assert/strict';
import {createTenantRecord} from '../packages/shared/src/tenant-creation.mjs';
import {totpAt} from '../cloudflare/workers/src/security/totp.mjs';
const db=new pg.Client({connectionString:process.env.PRODUCTION_DATABASE_URL,ssl:{rejectUnauthorized:true}});await db.connect();
const browser=await chromium.launch(),gateway='https://primecare-api-gateway.itpro-mohammed.workers.dev',site='https://primecare-clinic.pages.dev';const results=[];
function decode32(value){let bits=0,n=0,bytes=[];for(const c of value){const v='ABCDEFGHIJKLMNOPQRSTUVWXYZ234567'.indexOf(c);assert.ok(v>=0);n=(n<<5)|v;bits+=5;if(bits>=8){bits-=8;bytes.push((n>>>bits)&255);}}return new Uint8Array(bytes);}
await mkdir('test-results/live-mfa',{recursive:true});
try{for(const [locale,width]of [['en',320],['fr',768],['es',1440]]){
 const tenant=crypto.randomUUID(),user=crypto.randomUUID(),email='mfa-'+user+'@example.invalid',password='Synthetic-'+crypto.randomUUID()+'!';const context=await browser.newContext({viewport:{width,height:1000}}),page=await context.newPage(),cy=name=>page.locator('[data-cy="'+name+'"]');let loginToken;
 try{
  await createTenantRecord(db,{id:tenant,slug:'mfa-test-'+tenant,name:'Synthetic MFA verification'});
  await db.query("INSERT INTO users(id,email,tenant_id,roles,status,password_hash,updated_at) VALUES($1,$2,$3,'code_admin','mfa_pending',$4,NOW())",[user,email,tenant,await bcrypt.hash(password,12)]);
  await page.goto(site+'/login?locale='+locale+'&enable-semantics=true');await cy('login-email').fill(email);await cy('login-password').fill(password);await cy('login-submit').click();await cy('mfa-form').waitFor({timeout:30000});
  assert.equal(await page.evaluate(()=>sessionStorage.getItem('primecare_session')),null);assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM auth_sessions WHERE user_id=$1',[user])).rows[0].n,0);
  const setupKey=await cy('mfa-seed').textContent();assert.match(setupKey,/^[A-Z2-7]{32}$/);const seed=decode32(setupKey);const code=await totpAt(seed,Math.floor(Date.now()/1000));await cy('mfa-code').fill(code==='000000'?'000001':'000000');await cy('mfa-submit').click();await page.waitForFunction(()=>document.querySelector('[data-cy=mfa-code]')?.value==='');
  assert.equal((await db.query('SELECT COUNT(*)::int AS n FROM auth_sessions WHERE user_id=$1',[user])).rows[0].n,0);
  await cy('mfa-code').fill(await totpAt(seed,Math.floor(Date.now()/1000)));await cy('mfa-submit').click();await cy('platform-tenant-form').waitFor({timeout:30000});loginToken=await page.evaluate(()=>sessionStorage.getItem('primecare_session'));assert.match(loginToken,/^[A-Za-z0-9_-]{43}$/);
  const record=(await db.query('SELECT u.status,c.enabled,c.envelope FROM users u JOIN auth_mfa_credentials c ON c.user_id=u.id::text WHERE u.id::text=$1',[user])).rows[0];assert.equal(record.status,'active');assert.equal(record.enabled,true);assert.equal(JSON.stringify(record.envelope).includes(setupKey),false);assert.equal(await cy('mfa-seed').count(),0);
  const me=await fetch(gateway+'/v1/auth/me',{headers:{authorization:'Bearer '+loginToken}});assert.equal(me.status,200);assert.equal((await me.json()).userId,user);
  await page.reload();await cy('platform-tenant-form').waitFor({timeout:30000});await cy('platform-logout').click();await cy('login-submit').waitFor();assert.equal((await fetch(gateway+'/v1/auth/me',{headers:{authorization:'Bearer '+loginToken}})).status,401);
  // A subsequent password exchange is verification-only; never re-display seed.
  const next=await fetch(gateway+'/v1/auth/login',{method:'POST',headers:{'content-type':'application/json'},body:JSON.stringify({email,password})});assert.equal(next.status,200);const challenge=await next.json();assert.equal(challenge.status,'mfa_required');assert.equal(challenge.purpose,'verify');assert.equal(challenge.setupKey,undefined);assert.equal(challenge.token,undefined);
  const lastCounter=Number((await db.query('SELECT last_counter FROM auth_mfa_credentials WHERE user_id=$1',[user])).rows[0].last_counter);
  const replay=await fetch(gateway+'/v1/auth/mfa',{method:'POST',headers:{'content-type':'application/json'},body:JSON.stringify({challenge:challenge.challenge,code:await totpAt(seed,lastCounter*30)})});assert.equal(replay.status,401);
  results.push({locale,width,liveBrowser:true,realGateway:true,nativeDatabase:true,noPrematureSession:true,wrongCodeDenied:true,enrolled:true,replayDenied:true,seedHiddenAfterEnrollment:true,reload:true,logout:true,syntheticCleanup:false});
 }finally{
  await context.close();await db.query('BEGIN');try{
   await db.query('DELETE FROM auth_sessions WHERE user_id::text=$1',[user]);await db.query('DELETE FROM auth_mfa_challenges WHERE user_id=$1',[user]);await db.query('DELETE FROM auth_mfa_credentials WHERE user_id=$1',[user]);await db.query('DELETE FROM auth_mfa_audit WHERE user_id=$1',[user]);
   await db.query("DELETE FROM auth_rate_limits WHERE subject_hash=encode(sha256(convert_to($1,'UTF8')),'hex')",['login:'+email]);await db.query('DELETE FROM users WHERE id::text=$1 AND email=$2 AND tenant_id::text=$3',[user,email,tenant]);await db.query('DELETE FROM tenants WHERE id::text=$1 AND slug=$2',[tenant,'mfa-test-'+tenant]);await db.query('COMMIT');if(results.at(-1)?.locale===locale)results.at(-1).syntheticCleanup=true;
  }catch(e){await db.query('ROLLBACK');throw e;}
 }
}await writeFile('test-results/live-mfa/receipt.json',JSON.stringify({passed:true,source:process.env.GITHUB_SHA,synthetic:true,results},null,2));console.log('LIVE_MFA_VERIFIED '+JSON.stringify(results));}
finally{await browser.close();await db.end();}
