import {test} from 'node:test';
import assert from 'node:assert/strict';
import {mkdtemp,writeFile,readFile,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {execFile} from 'node:child_process';
import {promisify} from 'node:util';
const run=promisify(execFile),source='a'.repeat(40);
const script=new URL('./deploy-approved-admin-governance.mjs',import.meta.url).pathname;
for(const stale of [true,false])test(`actual Governance deployment ${stale?'waits for':'rejects permanently wrong'} provider version`,async()=>{
 const dir=await mkdtemp(join(tmpdir(),'governance-propagation-'));
 try{
  const preload=join(dir,'provider.mjs');
  await writeFile(preload,`
import child from 'node:child_process';
import {syncBuiltinESMExports} from 'node:module';
const old='11111111-1111-4111-8111-111111111111',active='22222222-2222-4222-8222-222222222222',version='33333333-3333-4333-8333-333333333333',wrong='44444444-4444-4444-8444-444444444444';
let reads=0;
child.execFileSync=(program,args)=>{if(program==='git'&&args[0]==='rev-parse')return '${source}\\n';if(program==='git'&&args[0]==='diff')return Buffer.alloc(0);if(program.endsWith('/wrangler')&&args[0]==='deploy')return Buffer.from('Current Version ID: '+version);throw Error('Unexpected process');};
syncBuiltinESMExports();
globalThis.fetch=async input=>{
 const url=String(input);let result;
 if(url.endsWith('/health'))return new Response('ok',{status:200});
 if(url.includes('/deployments?')){reads++;result={deployments:[{id:reads===1||(${stale}&&reads===2)?old:active,created_on:'2026-11-14T20:00:00Z',versions:[{version_id:reads===1||(${stale}&&reads===2)?wrong:${stale}?version:wrong,percentage:100}]}]};}
 else if(url.includes('/versions/'))result={id:version};
 else if(url.endsWith('/settings'))result={bindings:[{name:'DB_URL',type:'secret_text'},{name:'SERVICE_NAME',type:'plain_text',text:'governance'}]};
 else if(url.endsWith('/workers/subdomain'))result={subdomain:'itpro-mohammed'};
 else throw Error('Unexpected fixture request');
 return Response.json({success:true,result});
};
`);
  const result=await run(process.execPath,['--import',preload,script],{cwd:dir,timeout:20000,env:{...process.env,CLOUDFLARE_ACCOUNT_ID:'a'.repeat(32),CLOUDFLARE_API_TOKEN:'isolated-provider-fixture',GITHUB_SHA:source,GITHUB_REF:'refs/heads/main',PRODUCTION_DATABASE_URL:'postgresql://fixture@localhost/fixture'}}).then(value=>({value}),error=>({error}));
  if(stale){
   assert.equal(result.error,undefined,result.error?.stderr);
   const receipt=JSON.parse(await readFile(join(dir,'test-results/approved-code-admin-release/worker.json'),'utf8'));
   assert.equal(receipt.source,source);assert.equal(receipt.versionId,'33333333-3333-4333-8333-333333333333');assert.equal(receipt.deploymentId,'22222222-2222-4222-8222-222222222222');assert.equal(receipt.independentlyReadDeployment,true);assert.equal(receipt.trafficPercent,100);assert.equal(receipt.existingBindingsPreserved,true);assert.equal(receipt.healthStatus,200);
  }else{
   assert.equal(result.error?.code,1);assert.match(result.error.stderr,/Uploaded version is not the sole active deployment/);
   await assert.rejects(readFile(join(dir,'test-results/approved-code-admin-release/worker.json')),{code:'ENOENT'});
  }
 }finally{await rm(dir,{recursive:true,force:true});}
});
