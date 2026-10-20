import assert from 'node:assert/strict';
import pg from 'pg';import bcrypt from 'bcryptjs';import {build} from 'esbuild';import {chromium,firefox,webkit} from 'playwright';
import {readFile,writeFile,mkdir,mkdtemp} from 'node:fs/promises';import {createRequire} from 'node:module';import {createServer} from 'node:http';import {createHash,randomUUID} from 'node:crypto';import {tmpdir} from 'node:os';import {join} from 'node:path';
const browserName=process.env.AUTH_PASSWORD_BROWSER||'chromium';
const browserType={chromium,firefox,webkit}[browserName];
if(!browserType)throw Error('Unsupported auth password browser');
const out=process.env.AUTH_PASSWORD_BASELINE==='1'?'test-results/auth-password-baseline':'test-results/auth-password';await mkdir(out,{recursive:true});
if(process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL)throw Error('Production credentials forbidden in browser fixture');
const connection=process.env.LOGIN_BROWSER_DATABASE_URL,url=new URL(connection);if(!['localhost','127.0.0.1'].includes(url.hostname)||url.pathname!='/login_browser')throw Error('Loopback login_browser database required');
const db=new pg.Client({connectionString:connection});await db.connect();const schema='login_'+randomUUID().replaceAll('-','');await db.query('CREATE SCHEMA '+schema);await db.query('SET search_path TO '+schema);url.searchParams.set('options','-c search_path='+schema);
const dir=await mkdtemp(join(tmpdir(),'primecare-login-main-')),require=createRequire(import.meta.url),digest=v=>createHash('sha256').update(v).digest('hex');
const receipt={workflow_id:'auth.change-password',passed:false,wholeTaskVerified:false,scope:'scoped',browser:browserName,commit:process.env.VERIFICATION_SOURCE_SHA??process.env.GITHUB_SHA,workflow_run_sha:process.env.GITHUB_SHA,started_at:new Date().toISOString(),cases:[],recoveryCases:[],recoveryAccessibility:[],accessibility:[],apiChecks:[],trace:[],navigation:[],source_bindings:{},failures:[],limitations:['Isolated native PostgreSQL and actual main/gateway/service; not deployed edge execution.','Current production definition is bound; source/specification reconciliation and independent reviews remain required.','This receipt covers only the named desktop browser engine; native OS, mobile Safari and PWA acceptance remain unverified.']};
let server,browser,bridgeFailure;const password='Synthetic-only!Login-2026',actor=randomUUID(),tenant=randomUUID(),foreign=randomUUID(),admin=randomUUID(),denied=randomUUID();
const policy=JSON.parse(await readFile(out+'/governance.json','utf8'));const definition=policy.flows.find(r=>r.flow_id===receipt.workflow_id);assert.ok(definition);receipt.definition_sha256=definition.definition_sha256;receipt.theme_evidence=policy.theme_evidence;
assert.ok(Object.keys(policy.theme||{}).length>=10,'Representative governed theme required for browser layout and accessibility');
if(policy.fixture_only){assert.equal(process.env.AUTH_PASSWORD_TEST_FIXTURE,'1');receipt.limitations.push('Explicit isolated metadata fixture, not a live production authority read.');}
try{
 await db.query('CREATE TABLE tenants(id uuid PRIMARY KEY,name text,slug text UNIQUE,status text,created_at timestamptz DEFAULT NOW(),updated_at timestamptz DEFAULT NOW());CREATE TABLE users(id uuid PRIMARY KEY,tenant_id uuid REFERENCES tenants(id),email text UNIQUE,roles text,password_hash text,status text,updated_at timestamptz DEFAULT NOW())');
 for(const file of ['20260926_auth_sessions.sql','20260928_auth_rate_limits.sql','20260928_auth_password_audit.sql','20261003_auth_password_resets.sql','20261003_maintenance_configuration.sql','20261011_platform_administration.sql','20261013_screen_text.sql'])await db.query(await readFile('packages/database/migrations/'+file,'utf8'));
 await db.query("INSERT INTO tenants(id,name,slug,status) VALUES($1,'Synthetic Primary','synthetic-primary','active'),($2,'Synthetic Foreign','synthetic-foreign','active')",[tenant,foreign]);const hash=await bcrypt.hash(password,12);
 for(const [id,t,email,role]of [[actor,tenant,'platform@example.invalid','platform_admin'],[admin,foreign,'tenant-admin@example.invalid','tenant_admin'],[denied,tenant,'psw@example.invalid','psw']])await db.query("INSERT INTO users(id,tenant_id,email,roles,password_hash,status) VALUES($1,$2,$3,$4,$5,'active')",[id,t,email,role,hash]);
 const front=await build({entryPoints:['websites/typescript/src/main.ts'],bundle:true,write:false,metafile:true,platform:'browser',format:'iife'});
 const back=await build({stdin:{contents:"export {default as gateway} from './cloudflare/workers/src/gateway';export {default as service} from './cloudflare/workers/src/service';",resolveDir:process.cwd()},bundle:true,platform:'node',format:'cjs',write:false,metafile:true,external:['pg']});
 const backend=join(dir,'backend.cjs');await writeFile(backend,back.outputFiles[0].text.replaceAll('require("pg")',`require(${JSON.stringify(join(process.cwd(),'node_modules/pg'))})`));const {gateway,service}=require(backend);
 const paths=[...Object.keys(front.metafile.inputs),...Object.keys(back.metafile.inputs),'websites/typescript/src/styles.css',...['20260926_auth_sessions.sql','20260928_auth_rate_limits.sql','20260928_auth_password_audit.sql','20261003_auth_password_resets.sql','20261003_maintenance_configuration.sql','20261011_platform_administration.sql','20261013_screen_text.sql'].map(f=>'packages/database/migrations/'+f)];for(const path of paths)if(path!=='<stdin>'&&!path.includes('node_modules/'))receipt.source_bindings[path]=digest(await readFile(path));
 let rejectRecoveryDelivery=false;const recoveryDeliveries=[];
 const env={DB_URL:url.toString(),AUTH_SOURCE_LIMIT:{limit:async()=>({success:true})},EMAIL_FROM:'fixture@example.invalid',EMAIL:{send:async message=>{if(rejectRecoveryDelivery)throw Error('Isolated delivery outage');recoveryDeliveries.push(message);return {messageId:'isolated-'+randomUUID()};}}},css=await readFile('websites/typescript/src/styles.css','utf8');
 server=createServer(async(req,res)=>{try{const requestUrl=new URL(req.url,'http://fixture');
  if(requestUrl.pathname==='/app.js'){res.setHeader('content-type','text/javascript');res.end(front.outputFiles[0].text);return;}
  if(requestUrl.pathname==='/portal.json'){res.setHeader('content-type','application/json');res.end(JSON.stringify({project:'PrimeCare',appCode:'pc',name:'PrimeCare',apiGateway:origin,theme:policy.theme}));return;}
  if(['/login','/forgot-password','/reset-password','/platform/administration','/'].includes(requestUrl.pathname)){const locale=requestUrl.searchParams.get('locale')||'en';res.setHeader('content-type','text/html');res.end(`<!doctype html><html lang="${['en','fr','es'].includes(locale)?locale:'en'}"><head><meta name="viewport" content="width=device-width,initial-scale=1"><title>PrimeCare synthetic login</title><style>${css}</style></head><body><div id="app"></div><script src="/app.js"></script></body></html>`);return;}
  if(requestUrl.pathname.startsWith('/v1/')){let body='';for await(const part of req)body+=part;const headers=new Headers(req.headers);headers.delete('accept-encoding');headers.set('origin','https://primecare-clinic.pages.dev');headers.set('cf-connecting-ip','192.0.2.1');
   const request=new Request(origin+req.url,{method:req.method,headers,...(body?{body}:{})});const bindings={AUTH:{fetch:r=>service.fetch(r,{...env,SERVICE_NAME:'auth'})},GOVERNANCE:{fetch:r=>service.fetch(r,{...env,SERVICE_NAME:'governance'})}};
   const response=await gateway.fetch(request,bindings);receipt.trace.push({path:requestUrl.pathname,method:req.method,status:response.status});res.writeHead(response.status,Object.fromEntries(response.headers));res.end(await response.text());return;}
  res.writeHead(404);res.end();
 }catch(error){bridgeFailure=error;res.writeHead(500);res.end('Synthetic bridge failure');}});await new Promise(r=>server.listen(0,'127.0.0.1',r));const origin='http://127.0.0.1:'+server.address().port;
 browser=await browserType.launch({headless:true});receipt.browser_version=browser.version();
 const cy=(page,id)=>page.locator('[data-cy="'+id+'"]'),resources=JSON.parse(await readFile('cloudflare/workers/src/screen-text-defaults.json','utf8')).platform_administration;
 const baseline=process.env.AUTH_PASSWORD_BASELINE==='1';receipt.baseline=baseline;
 const snapshot=async()=>({users:(await db.query('SELECT * FROM users ORDER BY id')).rows,sessions:(await db.query('SELECT * FROM auth_sessions ORDER BY token_hash')).rows,resets:(await db.query('SELECT * FROM auth_password_resets ORDER BY token_hash')).rows,audit:(await db.query('SELECT * FROM auth_password_audit ORDER BY id')).rows});
 const login=async(email,pw=password)=>{const response=await fetch(origin+'/v1/auth/login',{method:'POST',headers:{'content-type':'application/json'},body:JSON.stringify({email,password:pw})});assert.equal(response.status,200);return(await response.json()).token;};
 const me=token=>fetch(origin+'/v1/auth/me',{headers:{authorization:'Bearer '+token}});
 const submit=async(page,current= password,next='Synthetic-new!Password-2026')=>{
  await cy(page,'current-password').fill(current);await page.keyboard.press('Tab');
  assert.equal(await cy(page,'new-password').evaluate(el=>el===document.activeElement),true,'Tab reaches new password');
  await cy(page,'new-password').fill(next);await page.keyboard.press('Tab');
  assert.equal(await cy(page,'change-password-submit').evaluate(el=>el===document.activeElement),true,'Tab reaches password submit');
  await page.keyboard.press('Shift+Tab');assert.equal(await cy(page,'new-password').evaluate(el=>el===document.activeElement),true,'Reverse tab reaches new password');
  await page.keyboard.press('Tab');await page.keyboard.press('Enter');
 };
 const checkForm=async(page,id,locale,bucket=receipt.accessibility,surface=id)=>{
  await page.addScriptTag({path:require.resolve('axe-core/axe.min.js')});
  const result=await cy(page,id).evaluate(async element=>window.axe.run(element,{runOnly:{type:'tag',values:['wcag2a','wcag2aa','wcag21a','wcag21aa','wcag22aa']}}));
  const summary={browser:browserName,locale,form:id,surface,passes:result.passes.length,violations:result.violations.map(v=>({id:v.id,impact:v.impact,nodes:v.nodes.map(n=>({target:n.target,failureSummary:n.failureSummary}))})),incomplete:result.incomplete.map(v=>({id:v.id,impact:v.impact,nodes:v.nodes.map(n=>n.target)}))};
  bucket.push(summary);assert.equal(summary.violations.length,0,'Automated form accessibility: '+JSON.stringify(summary.violations));
 };
 const ready=page=>page.waitForFunction(()=>!document.querySelector('[data-cy=change-password-submit]')?.disabled);
 for(const [locale,width]of [['en',320],['fr',768],['es',1440]]){
  await db.query('DELETE FROM auth_sessions;DELETE FROM auth_rate_limits;DELETE FROM auth_password_resets;DELETE FROM auth_password_audit');await db.query('UPDATE users SET password_hash=$1 WHERE id=$2',[hash,actor]);
  const context=await browser.newContext({viewport:{width,height:1000},recordVideo:{dir:out+'/raw'}}),page=await context.newPage();
  try{
   await page.goto(origin+'/login?locale='+locale+'&enable-semantics=true');await cy(page,'login-form').waitFor();await checkForm(page,'login-form',locale);const forgot=new URL(await cy(page,'login-forgot').getAttribute('href'),page.url());assert.equal(forgot.searchParams.get('enable-semantics'),'true');assert.equal(forgot.searchParams.get('locale'),locale==='en'?null:locale);await cy(page,'login-email').fill('platform@example.invalid');await page.keyboard.press('Tab');assert.equal(await cy(page,'login-password').evaluate(el=>el===document.activeElement),true,'Tab reaches login password');await cy(page,'login-password').fill(password);await page.keyboard.press('Tab');assert.equal(await cy(page,'login-submit').evaluate(el=>el===document.activeElement),true,'Tab reaches login submit');await page.keyboard.press('Enter');await cy(page,'platform-account-link').waitFor();if(!baseline)assert.equal(await cy(page,'platform-language').inputValue(),locale,'Login locale must survive entering the admin shell');await cy(page,'platform-language').selectOption(locale);await cy(page,'platform-account-link').click();await cy(page,'change-password-form').waitFor();
   await checkForm(page,'change-password-form',locale);
   const token=await page.evaluate(()=>sessionStorage.getItem('primecare_session')),before=await snapshot();
   await page.route('**/v1/user/change-password',route=>route.fulfill({status:200,contentType:'application/json',body:JSON.stringify({status:'not_changed'})}),{times:1});await submit(page);
   if(baseline){await cy(page,'login-submit').waitFor();assert.equal(await page.evaluate(()=>sessionStorage.getItem('primecare_session')),null);assert.equal((await me(token)).status,200);assert.deepEqual(await snapshot(),before);receipt.failures.push({criterion_id:'ui.password-change-confirmation',locale,reproduction:'Return HTTP 200 with status not_changed to the account password form.',expected:'Keep the existing browser/server session and show a localized retryable failure.',actual:'The browser clears its token and redirects although the password and server session are unchanged.',affected_sources:['websites/typescript/src/account.ts']});receipt.cases.push({locale,width,malformedSuccessReproduced:true});continue;}
   await ready(page);assert.equal(await page.evaluate(()=>sessionStorage.getItem('primecare_session')),token);assert.equal(await cy(page,'change-password-status').textContent(),resources[locale].unavailable);assert.deepEqual(await snapshot(),before);
   for(const value of [null,{},[],{status:'password_changed'},{status:'password_changed',reauthenticationRequired:false}]){await page.route('**/v1/user/change-password',route=>route.fulfill({status:200,contentType:'application/json',body:JSON.stringify(value)}),{times:1});await submit(page);await ready(page);assert.equal(await page.evaluate(()=>sessionStorage.getItem('primecare_session')),token);assert.deepEqual(await snapshot(),before);}
   await context.setOffline(true);await submit(page);await ready(page);await context.setOffline(false);assert.equal(await page.evaluate(()=>sessionStorage.getItem('primecare_session')),token);assert.deepEqual(await snapshot(),before);
   await submit(page,'Wrong-synthetic-password');await ready(page);assert.equal(await cy(page,'change-password-status').textContent(),resources[locale].request_failed);assert.deepEqual(await snapshot(),before);
   await db.query("CREATE FUNCTION fixture_password_audit_failure() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'Synthetic audit outage'; END $$;CREATE TRIGGER fixture_password_audit_failure BEFORE INSERT ON auth_password_audit FOR EACH ROW EXECUTE FUNCTION fixture_password_audit_failure()");
   try{await submit(page);await ready(page);assert.equal(await cy(page,'change-password-status').textContent(),resources[locale].unavailable);assert.deepEqual(await snapshot(),before);}finally{await db.query('DROP TRIGGER fixture_password_audit_failure ON auth_password_audit;DROP FUNCTION fixture_password_audit_failure()');}
   const second=await login('platform@example.invalid'),other=await login('tenant-admin@example.invalid');await db.query("INSERT INTO auth_password_resets(token_hash,user_id,expires_at) VALUES($1,$2,NOW()+INTERVAL '10 minutes'),($3,$4,NOW()+INTERVAL '10 minutes')",[digest('actor-reset'),actor,digest('foreign-reset'),admin]);
   const protectedOther=(await snapshot()).users.find(v=>v.id===admin);await submit(page);await cy(page,'login-submit').waitFor();assert.equal(await page.evaluate(()=>sessionStorage.getItem('primecare_session')),null);assert.equal(new URL(page.url()).searchParams.get('enable-semantics'),'true');if(locale!=='en')assert.equal(new URL(page.url()).searchParams.get('locale'),locale);
   const changed=(await db.query('SELECT password_hash FROM users WHERE id=$1',[actor])).rows[0].password_hash;assert.notEqual(changed,hash);assert.ok(await bcrypt.compare('Synthetic-new!Password-2026',changed));assert.equal((await db.query('SELECT * FROM auth_password_audit WHERE user_id=$1',[actor])).rowCount,1);assert.equal((await db.query('SELECT * FROM auth_password_resets WHERE user_id=$1',[actor])).rowCount,0);assert.equal((await me(token)).status,401);assert.equal((await me(second)).status,401);assert.equal((await me(other)).status,200);assert.deepEqual((await snapshot()).users.find(v=>v.id===admin),protectedOther);assert.equal((await db.query('SELECT * FROM auth_password_resets WHERE user_id=$1',[admin])).rowCount,1);
   const old=await fetch(origin+'/v1/auth/login',{method:'POST',headers:{'content-type':'application/json'},body:JSON.stringify({email:'platform@example.invalid',password})});assert.equal(old.status,401);
   await cy(page,'login-email').fill('platform@example.invalid');await cy(page,'login-password').fill('Synthetic-new!Password-2026');await cy(page,'login-submit').click();await cy(page,'platform-account-link').waitFor();await page.reload();await cy(page,'platform-account-link').waitFor();const current=await page.evaluate(()=>sessionStorage.getItem('primecare_session'));assert.equal((await me(current)).status,200);
   await cy(page,'platform-account-link').click();await cy(page,'change-password-form').waitFor();
   // The old account finishes a real mutation while another login replaces browser state.
   let release,reached;const held=new Promise(r=>release=r),started=new Promise(r=>reached=r);
   await page.route('**/v1/user/change-password',async route=>{const response=await route.fetch();assert.equal(response.status(),200);reached();await held;await route.fulfill({response});},{times:1});
   await submit(page,'Synthetic-new!Password-2026','Synthetic-final!Password-2026');await started;await page.evaluate(t=>sessionStorage.setItem('primecare_session',t),other);release();await ready(page);assert.equal(await page.evaluate(()=>sessionStorage.getItem('primecare_session')),other);assert.equal((await me(other)).status,200);assert.equal((await me(current)).status,401);assert.equal(await cy(page,'change-password-status').textContent(),resources[locale].request_failed);
   await page.screenshot({path:out+'/password-'+locale+'.png',fullPage:true});receipt.cases.push({locale,width,keyboardLogin:true,keyboardPasswordSubmit:true,automatedFormAccessibility:true,credentialLogin:true,actualMainUI:true,malformedSuccessRejected:true,offlineRetry:true,invalidCredentialsLocalized:true,auditFailureRollsBack:true,passwordHashConfirmed:true,oldCredentialsDenied:true,allPriorSessionsRevoked:true,resetTokensRevoked:true,foreignTenantPreserved:true,newCredentialLoginAndReload:true,replacementSessionPreserved:true});
  }finally{const video=page.video();await context.close();if(video)await video.saveAs(out+'/password-'+locale+'.webm');}
 }

 if(!baseline){
  receipt.limitations.push('Recovery email acceptance uses an explicit isolated EMAIL binding; this receipt does not prove Cloudflare inbox delivery. Deployed owned-inbox proof remains separate.');
  const recoveryText=JSON.parse(await readFile('packages/shared/src/auth-recovery.json','utf8')).locales;
  const authText=JSON.parse(await readFile('packages/primecare_ui/lib/src/localization/screens/auth.json','utf8')).locales;
  const email='platform@example.invalid',nextPassword='Synthetic-recovery!Password-2026';
  const recoveryReady=page=>page.waitForFunction(()=>document.querySelector('[data-cy=recovery-submit]')?.disabled===false);
  const recoverSubmit=async(page,values)=>{
   const ids=Object.keys(values);
   for(let i=0;i<ids.length;i++){
    await cy(page,ids[i]).fill(values[ids[i]]);await page.keyboard.press('Tab');
    assert.equal(await cy(page,ids[i+1]||'recovery-submit').evaluate(el=>el===document.activeElement),true,'Recovery keyboard tab order');
   }
   await page.keyboard.press('Enter');await recoveryReady(page);
  };
  for(const [locale,width] of [['en',320],['fr',768],['es',1440]]){
   await db.query('DELETE FROM auth_sessions;DELETE FROM auth_rate_limits;DELETE FROM auth_password_resets;DELETE FROM auth_password_audit');
   await db.query('UPDATE users SET password_hash=$1 WHERE id=$2',[hash,actor]);recoveryDeliveries.length=0;
   const oldToken=await login(email),otherToken=await login('tenant-admin@example.invalid');
   const context=await browser.newContext({viewport:{width,height:1000}}),page=await context.newPage();
   try{
    await page.goto(origin+'/forgot-password?locale='+locale+'&enable-semantics=true');await cy(page,'recovery-form').waitFor();
    await checkForm(page,'recovery-form',locale,receipt.recoveryAccessibility,'forgot');
    const before=await snapshot();
    rejectRecoveryDelivery=true;
    try{await recoverSubmit(page,{'recovery-email':email});}finally{rejectRecoveryDelivery=false;}
    assert.equal(await cy(page,'recovery-status').textContent(),recoveryText[locale].recovery_unavailable);assert.deepEqual(await snapshot(),before);assert.equal(recoveryDeliveries.length,0);
    await recoverSubmit(page,{'recovery-email':email});
    assert.equal(await cy(page,'recovery-status').textContent(),authText[locale].recovery_sent);assert.equal(recoveryDeliveries.length,1);
    const message=recoveryDeliveries[0];assert.equal(message.to,email);
    const code=/[A-F0-9]{12}/.exec(message.text)?.[0];assert.ok(code);
    const stored=(await db.query('SELECT token_hash,user_id FROM auth_password_resets')).rows;assert.equal(stored.length,1);assert.equal(stored[0].token_hash,digest(email+':'+code));assert.equal(stored[0].user_id,actor);assert(!JSON.stringify(stored).includes(code));
    const afterDelivery=await snapshot();
    await recoverSubmit(page,{'recovery-email':'absent@example.invalid'});
    assert.equal(await cy(page,'recovery-status').textContent(),authText[locale].recovery_sent);assert.equal(recoveryDeliveries.length,1);assert.deepEqual(await snapshot(),afterDelivery);
    await cy(page,'recovery-reset-link').focus();await page.keyboard.press('Enter');await cy(page,'recovery-code').waitFor();
    assert.equal(new URL(page.url()).searchParams.get('enable-semantics'),'true');if(locale!=='en')assert.equal(new URL(page.url()).searchParams.get('locale'),locale);
    await checkForm(page,'recovery-form',locale,receipt.recoveryAccessibility,'reset');
    const fields=(supplied=code,confirmation=nextPassword)=>({'recovery-email':email,'recovery-code':supplied,'recovery-password':nextPassword,'recovery-confirm':confirmation});
    const beforeMismatch=await snapshot(),requestsBefore=receipt.trace.length;
    await recoverSubmit(page,fields(code,'Synthetic-mismatch!Password-2026'));
    assert.equal(await cy(page,'recovery-status').textContent(),recoveryText[locale].password_mismatch);assert.equal(receipt.trace.length,requestsBefore);assert.deepEqual(await snapshot(),beforeMismatch);
    await context.setOffline(true);await recoverSubmit(page,fields());await context.setOffline(false);
    assert.equal(await cy(page,'recovery-status').textContent(),recoveryText[locale].recovery_error);assert.deepEqual(await snapshot(),beforeMismatch);
    for(const id of ['recovery-code','recovery-password','recovery-confirm'])assert.equal(await cy(page,id).inputValue(),'');
    await page.route('**/v1/auth/reset-password',route=>route.fulfill({status:200,contentType:'application/json',body:JSON.stringify({status:'not_reset'})}),{times:1});
    await recoverSubmit(page,fields());assert.equal(await cy(page,'recovery-status').textContent(),recoveryText[locale].recovery_error);assert.deepEqual(await snapshot(),beforeMismatch);
    const invalid=code==='000000000000'?'111111111111':'000000000000';
    await recoverSubmit(page,fields(invalid));assert.equal(await cy(page,'recovery-status').textContent(),recoveryText[locale].recovery_error);assert.deepEqual(await snapshot(),beforeMismatch);
    const expired=code==='DEADDEADDEAD'?'BEEFBEEFBEEF':'DEADDEADDEAD';
    await db.query("INSERT INTO auth_password_resets(token_hash,user_id,expires_at) VALUES($1,$2,NOW()-INTERVAL '1 minute')",[digest(email+':'+expired),actor]);const beforeExpired=await snapshot();
    await recoverSubmit(page,fields(expired));assert.equal(await cy(page,'recovery-status').textContent(),recoveryText[locale].recovery_error);assert.deepEqual(await snapshot(),beforeExpired);
    await db.query("CREATE FUNCTION fixture_recovery_audit_failure() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'Synthetic recovery audit outage'; END $$;CREATE TRIGGER fixture_recovery_audit_failure BEFORE INSERT ON auth_password_audit FOR EACH ROW EXECUTE FUNCTION fixture_recovery_audit_failure()");
    try{await recoverSubmit(page,fields());assert.equal(await cy(page,'recovery-status').textContent(),recoveryText[locale].recovery_unavailable);assert.deepEqual(await snapshot(),beforeExpired);}finally{await db.query('DROP TRIGGER fixture_recovery_audit_failure ON auth_password_audit;DROP FUNCTION fixture_recovery_audit_failure()');}
    await recoverSubmit(page,fields());assert.equal(await cy(page,'recovery-status').textContent(),recoveryText[locale].reset_success);
    const changed=(await db.query('SELECT password_hash FROM users WHERE id=$1',[actor])).rows[0].password_hash;assert.ok(await bcrypt.compare(nextPassword,changed));assert.notEqual(changed,hash);assert.equal(await bcrypt.compare(password,changed),false);
    assert.equal((await db.query('SELECT * FROM auth_password_audit WHERE user_id=$1',[actor])).rowCount,1);assert.equal((await db.query('SELECT * FROM auth_password_resets WHERE user_id=$1',[actor])).rowCount,0);
    assert.equal((await me(oldToken)).status,401);assert.equal((await me(otherToken)).status,200);
    const afterReset=await snapshot();assert.deepEqual(afterReset.users.find(v=>v.id===admin),beforeExpired.users.find(v=>v.id===admin));
    for(const id of ['recovery-email','recovery-code','recovery-password','recovery-confirm'])assert.equal(await cy(page,id).inputValue(),'');
    await recoverSubmit(page,fields());assert.equal(await cy(page,'recovery-status').textContent(),recoveryText[locale].recovery_error);assert.deepEqual(await snapshot(),afterReset);
    await cy(page,'recovery-back').focus();await page.keyboard.press('Enter');await cy(page,'login-email').waitFor();
    assert.equal(new URL(page.url()).searchParams.get('enable-semantics'),'true');if(locale!=='en')assert.equal(new URL(page.url()).searchParams.get('locale'),locale);
    await cy(page,'login-email').fill(email);await page.keyboard.press('Tab');await cy(page,'login-password').fill(nextPassword);await page.keyboard.press('Tab');await page.keyboard.press('Enter');await cy(page,'platform-account-link').waitFor();await page.reload();await cy(page,'platform-account-link').waitFor();
    assert.equal((await me(await page.evaluate(()=>sessionStorage.getItem('primecare_session')))).status,200);
    receipt.recoveryCases.push({locale,width,keyboardForgot:true,keyboardReset:true,automatedFormAccessibility:true,providerFailureRollback:true,providerRetry:true,isolatedEmailBinding:true,genericUnknownAccount:true,codeStoredOnlyHash:true,passwordMismatchNoMutation:true,offlineRetry:true,malformedSuccessRejected:true,invalidCodeDenied:true,expiredCodeDenied:true,auditFailureRollsBack:true,passwordHashConfirmed:true,oldSessionsDenied:true,foreignTenantPreserved:true,replayDenied:true,newLoginReload:true,secretsCleared:true});
    await page.screenshot({path:out+'/recovery-'+locale+'.png',fullPage:true});
   }finally{rejectRecoveryDelivery=false;await context.close();}
  }
 }
 if(bridgeFailure)throw bridgeFailure;for(const [path,sha]of Object.entries(receipt.source_bindings))assert.equal(digest(await readFile(path)),sha);
 receipt.passed=!baseline;receipt.probeCompleted=baseline;receipt.criterion_results=baseline?{}:{'ui.password-change-confirmation':'passed','ui.password-change-session-replacement':'passed','ui.password-change-localized-failure':'passed'};
}catch(error){receipt.error=error.message;console.error(error);process.exitCode=1;}
finally{if(browser)await browser.close();if(server)await new Promise(r=>server.close(r));await db.query('DROP SCHEMA '+schema+' CASCADE');await db.end();receipt.finished_at=new Date().toISOString();receipt.cleanup='Isolated synthetic schema dropped; production business data untouched';await writeFile(out+'/results.json',JSON.stringify(receipt,null,2));console.log('AUTH_PASSWORD_RESULT '+JSON.stringify({passed:receipt.passed,browser:receipt.browser,browser_version:receipt.browser_version,theme_evidence:receipt.theme_evidence,accessibility:receipt.accessibility,recoveryCases:receipt.recoveryCases,recoveryAccessibility:receipt.recoveryAccessibility,baseline:receipt.baseline,probeCompleted:receipt.probeCompleted,cases:receipt.cases,failures:receipt.failures,error:receipt.error,wholeTaskVerified:false}));}
