import {spawn} from 'node:child_process';
import {createWriteStream} from 'node:fs';
import {mkdir,writeFile} from 'node:fs/promises';
const suites={
 tenant:[['tenant-authority','--test','scripts/test-tenant-authority-boundaries.mjs'],['tenant-operations','scripts/test-tenant-operations.mjs']],
 client:[['client-api-contracts','--test',...['self','records','care-events','care-metadata','family-notifications','booking-lifecycle'].map(name=>'scripts/test-client-'+name+'-api.mjs')]],
 care:[['care-contracts-and-database','--test','scripts/test-care-delivery.mjs','scripts/test-care-roster-search.mjs','scripts/test-care-visit-picker.mjs','scripts/test-care-form-drafts.mjs','scripts/test-care-migration-target.mjs'],['care-loading','scripts/test-care-loading-browser.mjs'],['care-availability-journey','scripts/test-care-availability-workflow.mjs']],
 growth:[['growth-contracts','--test','scripts/test-growth.mjs','scripts/test-workforce-foundation.mjs','scripts/test-growth-read-order.mjs'],['growth-database','--test','scripts/test-growth-postgres.mjs','scripts/test-growth-intake.mjs','scripts/test-growth-reporting.mjs','scripts/test-growth-business.mjs'],['growth-browser','scripts/test-growth-browser.mjs'],['growth-administration-browser','scripts/test-growth-admin-browser.mjs'],['growth-loading','scripts/test-growth-loading-browser.mjs']],
 account:[['account-clients-and-authority','--test','scripts/test-account-admin-api.mjs','scripts/test-account-list-api.mjs','scripts/test-account-mutations-client.mjs','scripts/test-tenant-account-reads.mjs','scripts/test-care-metadata-api.mjs','scripts/test-care-availability-api.mjs']],
 workspace:[['screen-text-and-training','--test','scripts/test-screen-text.mjs','scripts/test-screen-text-cache.mjs','scripts/test-screen-text-postgres.mjs','scripts/test-screen-text-browser.mjs','scripts/test-admin-training.mjs','scripts/test-admin-training-browser.mjs'],['workspace-clients','--test','scripts/test-workspace.mjs','scripts/test-workspace-browser.mjs','scripts/test-auth-client.mjs','scripts/test-session-client-inheritance.mjs'],['workspace-signout','scripts/test-workspace-signout-workflow.mjs']]
};
const domain=process.argv[2];if(!Object.hasOwn(suites,domain))throw Error('Unknown audit domain');
if(process.env.PRODUCTION_DATABASE_URL||process.env.GOVERNANCE_DATABASE_URL)throw Error('Production credentials forbidden in this isolated audit');
const dir='test-results/business-workflows/'+domain;await mkdir(dir,{recursive:true});const results=[];
async function run(name,args,extra={}){
 const startedAt=new Date().toISOString(),timeout=name==='care-contracts-and-database'?600000:300000;
 console.log('::group::'+name);const log=createWriteStream(dir+'/'+name+'.log');let timedOut=false,error=null;
 const child=spawn(process.execPath,args,{env:{...process.env,...extra},detached:process.platform!=='win32',stdio:['ignore','pipe','pipe']});
 const record=stream=>{let pending='';stream.on('data',chunk=>{pending+=chunk;const lines=pending.split('\n');pending=lines.pop();for(const line of lines){const safe=line.replace(/data:text\/javascript;base64,[A-Za-z0-9+/=]+/g,'[bundled JavaScript]')+'\n';log.write(safe);process.stdout.write(safe);}});stream.on('end',()=>{if(pending){log.write(pending);process.stdout.write(pending);}});};
 record(child.stdout);record(child.stderr);
 const timer=setTimeout(()=>{timedOut=true;try{if(process.platform==='win32')child.kill('SIGKILL');else process.kill(-child.pid,'SIGKILL');}catch{}},timeout);
 const result=await new Promise(resolve=>{child.once('error',e=>{error=e.message;resolve({code:null,signal:null});});child.once('close',(code,signal)=>resolve({code,signal}));});
 clearTimeout(timer);await new Promise(resolve=>log.end(resolve));console.log('::endgroup::');
 const passed=result.code===0&&!timedOut&&!error;results.push({name,args,startedAt,finishedAt:new Date().toISOString(),passed,timedOut,error,exitCode:result.code,signal:result.signal});
 await writeFile(dir+'/results.json',JSON.stringify({domain,source:process.env.GITHUB_SHA??null,scope:'isolated browser/handler/database evidence; no production approval or live provider delivery',passed:results.every(r=>r.passed),results},null,2));
 return passed;
}
for(const [name,...args] of suites[domain])await run(name,args);
if(['account','tenant','client'].includes(domain)){for(const [name,database] of [['WORKFLOW_TEST_DATABASE_URL','/login_browser'],['AUTH_TEST_DATABASE_URL','/auth_test']]){const target=new URL(process.env[name]??'');if(!['localhost','127.0.0.1'].includes(target.hostname)||target.pathname!==database)throw Error('Only named disposable loopback database allowed: '+name);}}
if(['account','tenant','client'].includes(domain))for(const identity of ['text','uuid']){
 await run('reset-auth-'+identity,['--input-type=module','-e',"import pg from 'pg';const db=new pg.Client({connectionString:process.env.WORKFLOW_TEST_DATABASE_URL});await db.connect();await db.query('DROP DATABASE IF EXISTS auth_test');await db.query('CREATE DATABASE auth_test');await db.end();"]);
 if(await run('auth-schema-'+identity,['scripts/test-auth-postgres.mjs'],{AUTH_TEST_ID_TYPE:identity}))for(const script of domain==='account'?['test-account-admin-postgres.mjs','test-care-metadata-postgres.mjs']:domain==='tenant'?['test-tenant-authority-postgres.mjs']:['self','booking-lifecycle','records','care-metadata','care-events','family-notifications'].map(name=>'test-client-'+name+'-postgres.mjs'))await run(script+'-'+identity,['scripts/'+script],{AUTH_TEST_ID_TYPE:identity});
}
if(results.some(r=>!r.passed))process.exitCode=1;
