import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
const digest=value=>createHash('sha256').update(value).digest('hex');
const AsyncFunction=Object.getPrototypeOf(async()=>{}).constructor;
const read=path=>readFile(path,'utf8');
const session=await read('scripts/test-session-signout-workflow.mjs');
const workspace=await read('scripts/test-workspace-signout-workflow.mjs');
const password=await read('scripts/test-auth-password-workflow.mjs');
const fixturePath='tools/workflow-verification/specs/auth.logout.fixture.json';
const policyScript=session.slice(session.indexOf('const fixtureMode='),session.indexOf('\ntry{\n await db.query'));

test('session fixture is explicit, source-bound, synthetic, and leaves nonfixture policy selection intact',async()=>{
 assert.ok(policyScript.startsWith('const fixtureMode='),'Expected explicit fixture selection');
 const load=new AsyncFunction('process','readFile','out','receipt','digest','assert',policyScript+'\nreturn policy;');
 const bytes=await readFile(fixturePath),fixture=JSON.parse(bytes),reads=[],receipt={source_bindings:{},limitations:[]};
 const policy=await load({env:{LOGOUT_TEST_FIXTURE:'1'}},async path=>{reads.push(path);return bytes;},'fixture-output',receipt,digest,assert);
 assert.deepEqual(reads,[fixturePath]);assert.equal(policy.definition.flow_id,'auth.logout');assert.deepEqual(policy.theme,fixture.theme);
 assert.equal(receipt.source_bindings[fixturePath],digest(bytes));assert.equal(receipt.theme_evidence.fixture_only,true);
 assert.match(receipt.limitations.join(' '),/production authority is not accessed or substituted/);
 const live={definition:policy.definition,theme:{'--color-primary':'#123456'}},liveReceipt={source_bindings:{},limitations:[]};
 const livePolicy=await load({env:{}},async path=>{assert.equal(path,'fixture-output/governance.json');return Buffer.from(JSON.stringify(live));},'fixture-output',liveReceipt,digest,assert);
 assert.deepEqual(livePolicy,live);assert.deepEqual(liveReceipt.limitations,[]);
 await assert.rejects(load({env:{LOGOUT_TEST_FIXTURE:'1'}},async()=>Buffer.from(JSON.stringify({...fixture,fixture_only:false})),'fixture-output',{source_bindings:{},limitations:[]},digest,assert),/Explicit isolated logout fixture required/);
});

for(const [name,source]of [['session',session],['workspace',workspace],['password',password]])test(name+' retains production credential and loopback-only database rejection',()=>{
 const start=source.indexOf('if(process.env.PRODUCTION_DATABASE_URL'),end=source.indexOf('\nconst db=');
 assert.ok(start>=0&&end>start);const guard=new Function('process',source.slice(start,end));
 const safe='postgres://fixture:fixture-only@127.0.0.1:5432/login_browser';
 for(const key of ['PRODUCTION_DATABASE_URL','GOVERNANCE_DATABASE_URL'])assert.throws(()=>guard({env:{LOGIN_BROWSER_DATABASE_URL:safe,[key]:'forbidden-fixture-value'}}),/Production credentials forbidden/);
 for(const connection of ['postgres://example.invalid/login_browser','postgres://127.0.0.1/production'])assert.throws(()=>guard({env:{LOGIN_BROWSER_DATABASE_URL:connection}}),/Loopback login_browser database required/);
 assert.doesNotThrow(()=>guard({env:{LOGIN_BROWSER_DATABASE_URL:safe}}));
});

test('workspace still requires explicit fixture mode and keeps its policy theme',()=>{
 assert.match(workspace,/if\(policy.fixture_only\)\{assert.equal\(process.env.AUTH_WORKSPACE_TEST_FIXTURE,'1'\)/);
 assert.match(workspace,/theme:policy.theme/);
});

const admin=await read('evidence/test-admin-reports-browser.mjs');
const disclosureStart=admin.indexOf('const delivery=');
const disclosureEnd=admin.indexOf('await detail.scrollIntoViewIfNeeded()',disclosureStart);
const disclosureCode=admin.slice(disclosureStart,disclosureEnd);
for(const outerOpen of [false,true])for(const innerOpen of [false,true])test('admin opens only closed, correctly scoped disclosures '+outerOpen+'/'+innerOpen,async()=>{
 assert.ok(disclosureStart>=0&&disclosureEnd>disclosureStart);
 const clicks=[],outer={open:outerOpen},inner={open:innerOpen};
 const detail={evaluate:async fn=>fn(inner),locator:selector=>{assert.equal(selector,':scope > summary');return {click:async options=>{assert.equal(options,undefined);assert.equal(outer.open,true,'Inner summary must be visible through its open parent');inner.open=!inner.open;clicks.push('inner');}};}};
 const delivery={evaluate:async fn=>fn(outer),locator:selector=>selector==='[data-cy=delivery-admin_reports]'?detail:(assert.equal(selector,':scope > summary'),{click:async options=>{assert.equal(options,undefined);outer.open=!outer.open;clicks.push('outer');}})};
 const page={locator:selector=>{assert.equal(selector,'[data-cy=workspace-delivery]');return delivery;}};
 await new AsyncFunction('page','screen',disclosureCode)(page,{code:'admin_reports'});
 assert.equal(outer.open,true);assert.equal(inner.open,true);assert.deepEqual(clicks,[...(!outerOpen?['outer']:[]),...(!innerOpen?['inner']:[])]);
});
test('admin propagates an outer disclosure interaction failure without bypassing it',async()=>{
 const delivery={evaluate:async()=>false,locator:selector=>{assert.equal(selector,':scope > summary');return {click:async()=>{throw Error('Synthetic summary unavailable');}};}};
 await assert.rejects(new AsyncFunction('page','screen',disclosureCode)({locator:()=>delivery},{code:'admin_reports'}),/Synthetic summary unavailable/);
});

for(const path of ['.github/workflows/workspace-signout-acceptance.yml','.github/workflows/layout-manager.yml'])test(path+' uses supported runner with unchanged pinned browser version',async()=>{
 const workflow=await read(path);assert.match(workflow,/runs-on: ubuntu-24\.04/);assert.match(workflow,/playwright@1\.60\.0/);assert.match(workflow,/playwright install --with-deps chromium/);assert.match(workflow,/contents: read/);
});

test('recovery acceptance resolves per-key defaults while preserving strict negative assertions',async()=>{
 const fallback=JSON.parse(await read('packages/shared/src/auth-recovery.json')).locales;
 const catalogs=JSON.parse(await read('cloudflare/workers/src/screen-text-defaults.json'));
 const generated=JSON.parse(await read('packages/primecare_ui/lib/src/localization/screens/password_recovery.json')).locales;
 assert.deepEqual(catalogs.password_recovery,generated);
 for(const locale of ['en','fr','es']){
  assert.notEqual(fallback[locale].password_mismatch,generated[locale].password_mismatch);
  assert.notEqual(fallback[locale].reset_success,generated[locale].reset_success);
  assert.equal(Object.hasOwn(generated[locale],'recovery_error'),false);
 }
 assert.match(password,/\.\.\.recoveryFallback\[locale\],\.\.\.recoveryCatalog\[locale\]/);
 assert.match(password,/assert.equal\(receipt.trace.length,requestsBefore\);assert.deepEqual\(await snapshot\(\),beforeMismatch\)/);
 const start=password.indexOf('await page.waitForFunction(({gateway,screens,recovery})=>{');
 const end=password.indexOf('\n    },{gateway:origin',start);
 assert.ok(start>=0&&end>start);
 const predicate=eval('('+password.slice(start+'await page.waitForFunction('.length,end)+'\n})');
 const all=Object.entries(catalogs).map(([screen,locales])=>({screen,version:0,locales}));let cached;
 const original=globalThis.localStorage;globalThis.localStorage={getItem:()=>JSON.stringify({catalogs:cached})};
 const args={gateway:'http://127.0.0.1:1234',screens:Object.keys(catalogs),recovery:generated};
 try{
  cached=[];assert.equal(predicate(args),false);
  cached=all.filter(c=>c.screen!=='password_recovery');assert.equal(predicate(args),false);
  cached=all.map(c=>c.screen==='password_recovery'?{...c,locales:fallback}:c);assert.equal(predicate(args),false);
  cached=all.map(c=>c.screen==='password_recovery'?{...c,version:1}:c);assert.equal(predicate(args),false);
  cached=all;assert.equal(predicate(args),true);
 }finally{globalThis.localStorage=original;}
});

test('affected workflows enforce exact new regression files without privileged permissions',async()=>{
 for(const path of ['.github/workflows/account-password-acceptance.yml','.github/workflows/session-signout-verification.yml','.github/workflows/workspace-signout-acceptance.yml','.github/workflows/layout-manager.yml']){
  const workflow=await read(path);
  assert.match(workflow,/node --test[^\n]+scripts\/test-browser-ci-fixture-contracts\.mjs/);
  assert.match(workflow.split('permissions:')[0],/scripts\/test-browser-ci-fixture-contracts\.mjs/);
  assert.match(workflow,/contents: read/);assert.doesNotMatch(workflow,/write-all|contents: write|id-token: write/);
 }
 const passwordWorkflow=await read('.github/workflows/account-password-acceptance.yml');
 for(const name of ['test-auth-recovery-lifecycle.mjs','test-typescript-screen-manager.mjs']){
  assert.ok(passwordWorkflow.split('permissions:')[0].includes(name));
  assert.ok(passwordWorkflow.split('\n').some(line=>line.includes('node --test')&&line.includes(name)));
 }
});
