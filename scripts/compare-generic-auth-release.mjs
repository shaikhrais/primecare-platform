/** Read-only byte comparison of the live generic auth release with accepted source. */
import {execFileSync} from 'node:child_process';
import {createHash} from 'node:crypto';
import ts from 'typescript';
import {mkdir,readFile,readdir} from 'node:fs/promises';
const genericSource='85f00097c01729c86451ff2107e93136ef767e85',acceptedSource='a916cce32ab0ef4fd3e9b021b301acda1b49d428';
const expectedDeployment='41f6bd47-afa2-411b-9f08-6da3d81d012e',expectedVersion='8f4f184e-b704-4ede-b2a6-8208c08b1935';
const account=process.env.CLOUDFLARE_ACCOUNT_ID,token=process.env.CLOUDFLARE_API_TOKEN;
if(!/^[a-f0-9]{32}$/i.test(account??'')||!token||!process.env.RUNNER_TEMP||process.env.GITHUB_REF!=='refs/heads/main')throw Error('Scoped read-only main verification required');
for(const source of [genericSource,acceptedSource])execFileSync('git',['fetch','--no-tags','--depth=1','origin',source],{stdio:'ignore'});
const paths=['cloudflare/workers','packages/shared/src','packages/domain/src','package.json','package-lock.json','scripts/generate-cloudflare-worker-config.mjs','scripts/mfa-keyring-source.mjs'];
for(const [a,b] of [[acceptedSource,genericSource],[genericSource,'HEAD']]){
 const changed=execFileSync('git',['diff','--name-only',a,b,'--',...paths],{encoding:'utf8'}).trim().split('\n').filter(Boolean);
 if(changed.some(path=>path!=='packages/domain/src/advanced-theme-legacy-preview.ts'))throw Error('Worker source or build inputs changed');
}
try{execFileSync('git',['grep','-n','advanced-theme-legacy-preview','HEAD','--','cloudflare/workers','packages/shared/src'],{stdio:'ignore'});throw Error('Unexpected worker dependency');}catch(error){if(error.status!==1)throw error;}
const base='https://api.cloudflare.com/client/v4/accounts/'+account+'/workers/scripts/primecare-auth-api';
const get=async path=>{const response=await fetch(base+path,{headers:{authorization:'Bearer '+token},signal:AbortSignal.timeout(30000)});const body=await response.json();if(!response.ok||body.success!==true)throw Error('Provider metadata unavailable');return body.result;};
const before=(await get('/deployments?per_page=1')).deployments?.[0];
if(before?.id!==expectedDeployment||before.versions?.length!==1||before.versions[0].version_id!==expectedVersion||before.versions[0].percentage!==100)throw Error('Active auth deployment changed');
const settings=await get('/settings'),flags=settings.bindings?.filter(b=>b.name==='PREFERENCE_SYNC_ENABLED');
if(!Array.isArray(flags)||!(flags.length===0||flags.length===1&&flags[0].type==='plain_text'&&flags[0].text==='0')||!settings.bindings.some(b=>b.name==='DB_URL'&&b.type==='secret_text'))throw Error('Disabled flag or database binding differs');
execFileSync('node',['scripts/generate-cloudflare-worker-config.mjs'],{stdio:'ignore'});
const out=process.env.RUNNER_TEMP+'/generic-auth-compare';await mkdir(out,{recursive:true});
execFileSync('node_modules/.bin/wrangler',['deploy','--dry-run','--config','.cloudflare-workers/auth.jsonc','--outdir',out],{stdio:['ignore','pipe','pipe'],maxBuffer:8*1024*1024});
const files=(await readdir(out)).filter(name=>name.endsWith('.js'));if(files.length!==1)throw Error('Unexpected bundle shape');
const local=await readFile(out+'/'+files[0]);const response=await fetch(base+'/content/v2',{headers:{authorization:'Bearer '+token},signal:AbortSignal.timeout(30000)});
if(!response.ok)throw Error('Active script content unavailable');const body=Buffer.from(await response.arrayBuffer());if(body.length>25*1024*1024)throw Error('Active script too large');
let modules=[];const type=response.headers.get('content-type')??'';
if(type.startsWith('multipart/form-data')){const form=await new Response(body,{headers:{'content-type':type}}).formData();for(const value of form.values())if(typeof value!=='string')modules.push(Buffer.from(await value.arrayBuffer()));}else modules=[body];
const matching=modules.filter(value=>value.equals(local)).length;
const tokenHash=bytes=>{const scanner=ts.createScanner(ts.ScriptTarget.Latest,true,ts.LanguageVariant.Standard,bytes.toString('utf8'));const hash=createHash('sha256');let token;while((token=scanner.scan())!==ts.SyntaxKind.EndOfFileToken){hash.update(String(token));hash.update(':');hash.update(scanner.getTokenText());hash.update('\n');}return hash.digest('hex');};
const rebuiltTokens=tokenHash(local),providerTokens=modules.map(tokenHash);
let commonPrefix=0,commonSuffix=0;if(modules.length===1){const other=modules[0],limit=Math.min(local.length,other.length);while(commonPrefix<limit&&local[commonPrefix]===other[commonPrefix])commonPrefix++;while(commonSuffix<limit-commonPrefix&&local[local.length-1-commonSuffix]===other[other.length-1-commonSuffix])commonSuffix++;}
console.log('AUTH_GENERIC_COMPARISON_DIAGNOSTIC '+JSON.stringify({contentType:type.split(';')[0],moduleCount:modules.length,matchingModules:matching,rebuiltBytes:local.length,rebuiltSha256:createHash('sha256').update(local).digest('hex'),providerModules:modules.map(value=>({bytes:value.length,sha256:createHash('sha256').update(value).digest('hex')})),commonPrefix,commonSuffix,rebuiltTokens,providerTokens,tokensMatch:providerTokens.length===1&&providerTokens[0]===rebuiltTokens}));
if(modules.length!==1||matching!==1)throw Error('Active auth code differs from rebuilt accepted source');
const after=(await get('/deployments?per_page=1')).deployments?.[0];
if(after?.id!==before.id||after.versions?.length!==1||after.versions[0].version_id!==expectedVersion||after.versions[0].percentage!==100)throw Error('Deployment changed during comparison');
console.log('AUTH_GENERIC_CODE_COMPARISON '+JSON.stringify({acceptedSource,genericSource,activeDeployment:before.id,activeVersion:expectedVersion,moduleCount:modules.length,matchingModules:matching,bundleSha256:createHash('sha256').update(local).digest('hex'),preferenceFlag:flags.length===0?'absent':'0',preferenceRuntimeActivated:false,providerWrites:0,humanApproved:false}));
