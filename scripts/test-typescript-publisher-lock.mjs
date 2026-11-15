import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile,mkdtemp,mkdir,writeFile,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {spawnSync} from 'node:child_process';
test('auth live source verification is triggered by the Worker tree its source gate compares',async()=>{
 const account=await readFile('.github/workflows/verify-account-mutations.yml','utf8');
 const paths=account.split('\n  push:\n')[1]?.split('\n  workflow_run:')[0];
 assert.match(paths??'',/      - cloudflare\/workers\/\*\*/);
});
test('live account journeys retain one non-cancelling publisher lock across all locales',async()=>{
 const text=await readFile('.github/workflows/verify-account-mutations.yml','utf8');
 const proof=text.split('\n  proof:\n')[1];
 assert.ok(proof,'account journey proof job');
 assert.match(proof,/concurrency:\n\s+group: primecare-cloudflare-typescript-production\n\s+cancel-in-progress: false/);
 assert.doesNotMatch(proof,/\n\s+strategy:|\$\{\{ matrix\./,'a matrix releases the lock between locale proofs');
 assert.match(proof,/for journey in 'en 320' 'fr 768' 'es 1440'; do/);
 for(const pair of ['en-320','fr-768','es-1440'])assert.match(proof,new RegExp('name: current-account-journeys-'+pair));
 assert.match(proof,/--baseline "test-results\/account-mutations\/web-release-\$project.json"/,'retain exact pre/post release identity');
 assert.match(proof,/test-live-tenant-account-reads\.py/);assert.match(proof,/test-live-account-mutations\.py/);
 const parent=text.split('\njobs:\n')[0];
 assert.doesNotMatch(parent,/group: primecare-cloudflare-typescript-production/,'parent must not hold the reusable publisher lock');
 assert.match(proof,/needs: \[release_source, source_proof, shell_acceptance, deploy\]/,'publisher completes before proof acquires its lock');
});
test('the actual locked locale loop fails a broken case, retains its evidence and still runs later locales',async()=>{
 const text=await readFile('.github/workflows/verify-account-mutations.yml','utf8');
 const proof=text.split('\n  proof:\n')[1];
 const block=proof.split('      - name: Verify actual account UI API database audit reload and owned receiving-Worker mail\n')[1].split('        run: |\n')[1].split('\n      - uses:')[0];
 const script=block.split('\n').map(line=>line.slice(10)).join('\n');
 const syntax=spawnSync('bash',['-n'],{input:script,encoding:'utf8'});assert.equal(syntax.status,0,syntax.stderr);
 for(const failedLocale of ['', 'fr']){
  const dir=await mkdtemp(join(tmpdir(),'account-proof-lock-'));
  try{
   await mkdir(join(dir,'bin'));
   const fake=`#!/bin/bash\nset -euo pipefail\nprintf '%s:%s:%s\\n' "$TEST_LOCALE" "$TEST_WIDTH" "$*" >> "$PROOF_LOG"\nmkdir -p test-results/account-mutations test-results/tenant-account-reads\nprintf '%s' "$TEST_LOCALE" > test-results/account-mutations/locale.txt\nif [ "$TEST_LOCALE" = "$FAILED_LOCALE" ] && [ "$*" = tools/auth-verification/test-live-tenant-account-reads.py ]; then exit 23; fi\n`;
   for(const name of ['node','python3'])await writeFile(join(dir,'bin',name),fake,{mode:0o755});
   const run=spawnSync('bash',['-euo','pipefail','-c',script],{cwd:dir,encoding:'utf8',env:{...process.env,PATH:join(dir,'bin')+':'+process.env.PATH,PROOF_LOG:join(dir,'calls'),FAILED_LOCALE:failedLocale,EXPECTED_WEB_SOURCE:'a'.repeat(40)}});
   assert.equal(run.status,failedLocale?1:0,run.stderr);
   const calls=(await readFile(join(dir,'calls'),'utf8')).trim().split('\n');
   for(const [locale,width]of [['en',320],['fr',768],['es',1440]]){
    assert.ok(calls.includes(`${locale}:${width}:scripts/verify-auth-live-proof-source.mjs`));
    assert.equal(await readFile(join(dir,`test-results/current-account-journeys-${locale}-${width}/account-mutations/locale.txt`),'utf8'),locale);
    const lifecycle=calls.includes(`${locale}:${width}:tools/auth-verification/test-live-account-mutations.py`);
    assert.equal(lifecycle,locale!==failedLocale,'failed read proof must not be hidden by a subsequent successful command');
    assert.equal(calls.filter(line=>line.startsWith(locale+':')&&line.includes('--baseline')).length,locale===failedLocale?0:2);
   }
  }finally{await rm(dir,{recursive:true,force:true});}
 }
});
test('account evidence collector accepts only the exact locked job or complete immutable legacy matrix',async()=>{
 const text=await readFile('.github/workflows/record-account-lifecycle-evidence.yml','utf8');
 const code='const proofJobs='+text.split('            const proofJobs=')[1].split('            // Publisher job contract')[0];
 const verify=new Function('jobs',code);
 const locked=[{name:'proof (all locales, locked-v1)',conclusion:'success'}];
 const legacy=['en, 320','fr, 768','es, 1440'].map(value=>({name:'proof ('+value+')',conclusion:'success'}));
 verify(locked);verify(legacy);
 for(const jobs of [[],legacy.slice(0,2),[...locked,...legacy],[...locked,...locked],[{name:'proof (all locales)',conclusion:'success'}],[{...locked[0],conclusion:'failure'}],[...legacy.slice(0,2),{...legacy[2],conclusion:'skipped'}]])assert.throws(()=>verify(jobs),/Complete historical matrix/);
});
test('the actual receipt collector rejects a missing locale, missing auth receipt and mismatched producer',async()=>{
 const text=await readFile('.github/workflows/record-account-lifecycle-evidence.yml','utf8');
 const body=text.split('          receipts=[]\n')[1].split('          password_paths=')[0];
 const code='import json,pathlib,os\nroot=pathlib.Path.cwd()\nreceipts=[]\n'+body.split('\n').map(line=>line.slice(10)).join('\n');
 for(const fault of ['','locale','auth','producer']){
  const dir=await mkdtemp(join(tmpdir(),'account-receipt-lock-'));
  try{
   for(const [locale,width]of [['en',320],['fr',768],['es',1440]]){
    const folder=join(dir,'test-results/account-lifecycle-accepted',`current-account-journeys-${locale}-${width}`);await mkdir(folder,{recursive:true});
    const common={passed:true,wholeAuthVerified:false,locale,width};
    const reads={...common,scope:'deployed-ceo-account-reads',checks:Array(36).fill('fixture'),cleanup:'Exact synthetic account-read tenants, users, sessions, audits and login counters removed'};
    const mutations={...common,scope:'deployed-account-mutations-owned-inbox',checks:['Created-account browser password change succeeds with mandatory reauthentication','Created-account browser logout removes its database session and remains denied',...Array(46).fill('fixture')],received:true,cleanup:'Exact owned synthetic mutation tenants, accounts, sessions, reset codes, audits and counters removed',inboxCleanup:'Only the database-correlated, hash-matched synthetic message removed'};
    await writeFile(join(folder,'results-reads.json'),JSON.stringify(reads));
    if(!(fault==='locale'&&locale==='es'))await writeFile(join(folder,'results-mutations.json'),JSON.stringify(mutations));
    if(!(fault==='auth'&&locale==='es'))await writeFile(join(folder,'auth-release-approved.json'),JSON.stringify({workerSourceMatch:true,producer:fault==='producer'&&locale==='es'?'wrong':'fixture-sha'}));
   }
   const run=spawnSync('python3',['-c',code],{cwd:dir,encoding:'utf8',env:{...process.env,PRODUCER_SHA:'fixture-sha'}});
   assert.equal(run.status,fault?1:0,run.stderr);
   if(fault)assert.match(run.stderr,/AssertionError/);
  }finally{await rm(dir,{recursive:true,force:true});}
 }
});
test('direct TypeScript producers share a non-cancelling release lock',async()=>{
 for(const name of ['deploy-typescript-websites','psw-workspace','business-plan-cycles','code-admin-look']){
  const text=await readFile('.github/workflows/'+name+'.yml','utf8');
  assert.match(text,/group: primecare-cloudflare-typescript-production[,\n]/,name);
  assert.match(text,/cancel-in-progress: false/,name);
 }
});
test('production TypeScript bundles use the same repository dependency lockfile',async()=>{
 for(const name of ['deploy-typescript-websites','psw-workspace','business-plan-cycles','code-admin-look']){
  const text=await readFile('.github/workflows/'+name+'.yml','utf8');
  const section=name==='deploy-typescript-websites'?text.split('\n  build:\n')[1]?.split('\n  deploy:\n')[0]:text.split('\n  publish:\n')[1];
  assert.ok(section,name+' publication section');
  const install=section.indexOf('npm ci --ignore-scripts'),build=section.indexOf('node scripts/build-typescript-websites.mjs');
  assert.ok(install>=0&&build>install,name+' must install locked dependencies before bundling');
  assert.doesNotMatch(section,/npm install[^\n]*esbuild@/,name+' must not substitute an independent bundler version');
 }
});
test('account metadata stays inside the locked publisher and portal uploads verify current source',async()=>{
 const account=await readFile('.github/workflows/verify-account-mutations.yml','utf8');
 const bind=account.split('\n  bind:\n')[1]?.split('\n  deploy:\n')[0];
 assert.ok(bind&&!bind.includes('--apply')&&!bind.includes('concurrency:'));
 assert.match(account,/bind_account_metadata: true/);
 const deploy=await readFile('.github/workflows/deploy-typescript-websites.yml','utf8');
 assert.match(deploy,/bind_account_metadata:[\s\S]*?type: boolean\n\s+default: false/);
 const build=deploy.split('\n  build:\n')[1]?.split('\n  deploy:\n')[0];
 assert.match(build??'',/if \[ "\$\{\{ inputs.bind_account_metadata \}\}" = true \]; then\n\s+git fetch origin main\n\s+test "\$\(git rev-parse FETCH_HEAD\)" = "\$GITHUB_SHA"/);
 for(const script of ['account_mutations_registration','tenant_accounts_registration','recovery_registration']){assert.ok(!account.includes(script+'.py --apply'));assert.ok(build.includes(script+'.py --apply'));}
 assert.match(deploy,/name: Deploy \$\{\{ matrix\.project \}\}[\s\S]*?set -euo pipefail\n\s+git fetch origin main\n\s+test "\$\(git rev-parse FETCH_HEAD\)" = "\$GITHUB_SHA"[\s\S]*?wrangler@/);
 assert.match(deploy,/name: Verify current main before release verification/);
 const psw=await readFile('.github/workflows/psw-workspace.yml','utf8');assert.match(psw,/typescript_release verify-deploy "websites\/typescript\/dist\/\$project" "\$project"/);
});

