import assert from 'node:assert/strict';
import {test} from 'node:test';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {build} from 'esbuild';
import {browser,settle} from './fixtures/platform-admin.mjs';
assert.equal(process.env.GITHUB_ACTIONS,'true');assert.match(process.env.GITHUB_SHA??'',/^[a-f0-9]{40}$/);
const built=await build({stdin:{contents:"export * from './packages/shared/src/platform-administration-audit';export * from './websites/typescript/src/platform-audit-history-prototype-text';",resolveDir:process.cwd()},bundle:true,write:false,format:'esm',platform:'node'});
const {projectAdministrationAudit:strict,projectAdministrationAuditHistory:partial,auditHistoryPrototypeText:copy}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const base={id:'synthetic-event',action:'account_updated',target_id:'synthetic-target',created_at:'2026-01-01T00:00:00.000Z',previous_state:{role:'psw',status:'active'},current_state:{role:'rmt',status:'active'}};
const marked={...base,previous_state:{role:'psw'},unavailable_details:['previous_state.status']};
await test('prototype preserves exact event and valid fields for only bounded legacy previous status',()=>{
 for(const status of [null,'failed','ACTIVE']){const raw={...base,previous_state:{...base.previous_state,status,hidden:'RAW_CANARY'},actor_id:'ACTOR_CANARY'},original=structuredClone(raw);assert.deepEqual(partial(raw),marked);assert.deepEqual(raw,original);assert.throws(()=>strict(raw));assert.deepEqual(partial(partial(raw)),marked);}
 assert.deepEqual(partial(base),base);assert.equal(Object.hasOwn(partial(base),'unavailable_details'),false);
 const sparse={...base,previous_state:{role:'psw'}};assert.deepEqual(partial(sparse),sparse,'Missing historic value is not falsely marked as observed corruption');
});
await test('prototype retains all other strict failures and rejects malformed or contradictory markers',()=>{
 for(const status of [{private:'RAW_CANARY'},[],0,true,'',' '.repeat(5),'x'.repeat(151),'bad\u0000status',undefined])assert.throws(()=>partial({...base,previous_state:{role:'psw',status}}));
 for(const raw of [null,[],{...base,id:'bad/id'},{...base,action:'unknown_action'},{...base,target_id:''},{...base,created_at:'2026-02-30T00:00:00.000Z'},{...base,previous_state:[]},{...base,previous_state:{role:null,status:null}},{...base,current_state:{role:'rmt',status:null}},{...base,action:'master_updated',previous_state:{status:null}},{...marked,unavailable_details:[]},{...marked,unavailable_details:['current_state.status']},{...marked,unavailable_details:['previous_state.status','previous_state.status']},{...marked,unavailable_details:'previous_state.status'},{...marked,previous_state:{role:'psw',status:'active'}},{...marked,action:'account_created'}])assert.throws(()=>partial(raw));
 assert.throws(()=>strict({...base,previous_state:{role:'psw',status:null}}),'The original strict projector remains unchanged for other consumers');
});
const resources=JSON.parse(await readFile('cloudflare/workers/src/screen-text-defaults.json','utf8')).platform_administration;
const summary={sourceCommit:process.env.GITHUB_SHA,prototypeOnly:true,workflowAccepted:false,syntheticOnly:true,productionAccess:false,newResponseField:'unavailable_details',newFieldApproved:false,localizationRegistered:false,remainingMissing:['actor_identity_contract_and_projection','partial_detail_response_contract_review','localization_registration_and_review'],results:[]};
for(const locale of ['en','fr','es'])await test(locale+' prototype renderer explicitly marks unavailable prior detail without dropping or inventing events',async()=>{
 const f=browser({role:'tenant_admin',hash:'#audit',locale}),good={...base,id:'synthetic-good-event',target_id:'synthetic-good-target'};
 f.respond=async url=>url.endsWith('/v1/governance/platform')?Response.json(f.data):url.endsWith('/tenants/tenant-a/audit')?Response.json({events:[marked,good]}):Response.json({users:[],records:[],events:[],partners:[]});
 await f.render();assert.equal(f.root.view,'audit');
 const verify=()=>{const all=f.root.innerHTML,start=all.indexOf('<ul data-cy="platform-audit">'),html=all.slice(start,all.indexOf('</ul>',start));assert.ok(start>=0);assert.equal((html.match(/<li>/g)||[]).length,2);assert.equal((html.match(/data-audit-detail-unavailable=/g)||[]).length,1);for(const value of [base.target_id,good.target_id,base.action,base.created_at,'psw','rmt',resources[locale].active,copy[locale].detail,copy[locale].notice])assert.ok(html.includes(value),'Required event/availability detail missing');assert.ok(html.indexOf(base.target_id)<html.indexOf(good.target_id));assert.equal(html.includes('RAW_CANARY')||html.includes('ACTOR_CANARY')||html.includes('failed'),false);};
 verify();f.root.querySelector('[data-cy=platform-refresh]').onclick();await settle();verify();assert.equal(f.requests.filter(r=>String(r.url).includes('/audit')).every(r=>String(r.url).endsWith('/tenants/tenant-a/audit')),true);
 summary.results.push({locale,eventCount:2,markedCount:1,explicitLegacyWarning:true,validDetailsRetained:true,noInventedState:true,noActorDisclosure:true,reloadStable:true});
});
await mkdir('test-results/tenant-administration-audit-partial-details',{recursive:true});await writeFile('test-results/tenant-administration-audit-partial-details/view-summary.json',JSON.stringify(summary,null,2)+'\n');
