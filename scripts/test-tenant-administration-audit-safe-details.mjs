import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {build} from 'esbuild';
import {browser,settle} from './fixtures/platform-admin.mjs';
if(process.env.GITHUB_ACTIONS!=='true')throw Error('GitHub-only synthetic preflight');
const sourceCommit=process.env.GITHUB_SHA;if(!/^[a-f0-9]{40}$/.test(sourceCommit??''))throw Error('Exact GitHub source required');
const built=await build({entryPoints:['packages/shared/src/platform-administration-audit.ts'],bundle:true,write:false,format:'esm',platform:'node'});
const {projectAdministrationAudit}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const base={id:'synthetic-event',target_id:'synthetic-target',action:'account_updated',previous_state:{role:'psw',status:'active'},current_state:{role:'rmt',status:'inactive'},created_at:'2026-01-01T00:00:00.000Z'};
await test('safe projection keeps only existing action-specific fields and never actor identity',()=>{
 const cases=[
  ['tenant_created',{}, {slug:'synthetic-care',name:'Synthetic care'},[]],
  ['account_created',{}, {role:'psw',status:'active'},[]],
  ['account_updated',{role:'psw',status:'active'},{role:'rmt',status:'inactive'},[]],
  ['master_created',{}, {type:'location',code:'synthetic',label:'Synthetic location',status:'active',version:1},[]],
  ['master_updated',{label:'Synthetic old',status:'active',version:1},{label:'Synthetic new',status:'inactive',version:2},[]],
 ];
 for(const [action,previous,current]of cases){const raw={...base,action,actor_id:'SYNTHETIC_ACTOR_HIDDEN',previous_state:{...previous,unregistered:'SYNTHETIC_RAW_HIDDEN'},current_state:{...current,unregistered:{private:'SYNTHETIC_RAW_HIDDEN'}}},original=structuredClone(raw),actual=projectAdministrationAudit(raw);assert.deepEqual(actual,{...base,action,previous_state:previous,current_state:current});assert.deepEqual(raw,original);assert.equal(Object.hasOwn(actual,'actor_id'),false);assert.equal(JSON.stringify(actual).includes('SYNTHETIC_RAW_HIDDEN'),false);}
 const historical=projectAdministrationAudit({...base,action:'account_created',previous_state:{sourceTenantId:'synthetic-source'},current_state:{role:'psw',tenantId:'synthetic-tenant',userId:'synthetic-target'}});assert.deepEqual(historical.previous_state,{});assert.deepEqual(historical.current_state,{role:'psw'});
});
await test('safe projection rejects malformed known data rather than coercing or exposing it',()=>{
 for(const raw of [null,[],{...base,id:'bad/id'},{...base,target_id:''},{...base,action:'constructor'},{...base,created_at:'2026-02-30T00:00:00.000Z'},{...base,previous_state:[]},{...base,current_state:{role:{nested:'private'}}},{...base,current_state:{status:'unknown'}},{...base,current_state:{role:'x'.repeat(201)}},{...base,current_state:{role:'bad\u0000role'}},{...base,action:'master_updated',current_state:{version:0}},{...base,action:'master_created',current_state:{type:'clinical_policy'}}])assert.throws(()=>projectAdministrationAudit(raw));
});
const resources=JSON.parse(await readFile('cloudflare/workers/src/screen-text-defaults.json','utf8')).platform_administration;
const summary={sourceCommit,workflowId:'platform.review-administration-audit',syntheticOnly:true,productionAccess:false,candidateScope:'safe_target_and_existing_state_only',workflowAccepted:false,remainingMissing:['actor_identity_policy','credential_login_real_browser_and_independent_review'],results:[]};
for(const locale of ['en','fr','es'])await test(locale+' actual audit renderer shows safe target/state, escapes content and preserves reload scope',async()=>{
 const f=browser({role:'tenant_admin',hash:'#audit',locale}),account={...base,actor_id:'SYNTHETIC_ACTOR_HIDDEN',current_state:{...base.current_state,unregistered:'SYNTHETIC_RAW_HIDDEN'}},master={...base,id:'synthetic-master-event',target_id:'synthetic-master-target',action:'master_updated',previous_state:{label:'Synthetic <em>before</em>',status:'active',version:1},current_state:{label:'Synthetic <em>after</em>',status:'inactive',version:2,unregistered:'SYNTHETIC_RAW_HIDDEN'}};
 f.respond=async url=>url.endsWith('/v1/governance/platform')?Response.json(f.data):url.endsWith('/tenants/tenant-a/audit')?Response.json({events:[account,master]}):Response.json({users:[],records:[],events:[],partners:[]});
 await f.render();assert.equal(f.root.view,'audit');
 const markup=()=>{const html=f.root.innerHTML,start=html.indexOf('<ul data-cy="platform-audit">');assert.ok(start>=0);return html.slice(start,html.indexOf('</ul>',start));};
 const verify=()=>{const html=markup();assert.equal(html.includes(account.action)&&html.includes(account.created_at),true);assert.equal(html.includes(account.target_id)&&html.includes(master.target_id),true);assert.equal(html.includes(resources[locale].assigned_role)&&html.includes(resources[locale].status),true);assert.equal(html.includes('psw')&&html.includes('rmt'),true);assert.equal(html.includes('Synthetic &lt;em&gt;before&lt;/em&gt;')&&html.includes('Synthetic &lt;em&gt;after&lt;/em&gt;'),true);assert.equal(html.includes('<em>'),false);assert.equal(html.includes('SYNTHETIC_RAW_HIDDEN')||html.includes('SYNTHETIC_ACTOR_HIDDEN'),false);assert.equal(html.indexOf(account.target_id)<html.indexOf(master.target_id),true);};
 verify();f.root.querySelector('[data-cy=platform-refresh]').onclick();await settle();verify();assert.equal(f.requests.filter(r=>String(r.url).includes('/audit')).every(r=>String(r.url).endsWith('/tenants/tenant-a/audit')),true);assert.equal(f.root.view,'audit');
 summary.results.push({locale,safeTargetAndState:true,arbitraryJsonHidden:true,actorStillHidden:true,reloadScopeRetained:true});
});
await mkdir('test-results/tenant-administration-audit',{recursive:true});await writeFile('test-results/tenant-administration-audit/safe-presentation-summary.json',JSON.stringify(summary,null,2)+'\n');
