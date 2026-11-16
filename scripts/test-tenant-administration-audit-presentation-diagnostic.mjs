import {test} from 'node:test';
import assert from 'node:assert/strict';
import {mkdir,writeFile} from 'node:fs/promises';
import {browser,settle} from './fixtures/platform-admin.mjs';
if(process.env.GITHUB_ACTIONS!=='true')throw Error('Run this diagnostic only in GitHub Actions');
const sourceCommit=process.env.GITHUB_SHA;if(!/^[a-f0-9]{40}$/.test(sourceCommit??''))throw Error('Exact GitHub source SHA required');
const summary={sourceCommit,workflowId:'platform.review-administration-audit',diagnosticOnly:true,workflowAccepted:false,workflowStatus:'missing',syntheticOnly:true,productionAccess:false,actualRenderer:true,realBrowser:false,results:[]};
for(const locale of ['en','fr','es'])await test('diagnostic '+locale+' existing tenant audit view renders documented historical context',async()=>{
 const f=browser({role:'tenant_admin',hash:'#audit',locale});
 const event={id:'synthetic-audit-id',actor_id:'synthetic-actor-id',target_id:'synthetic-target-id',action:'account_updated',created_at:'2026-01-01T00:00:00.000Z',previous_state:{role:'synthetic-old-role',status:'active'},current_state:{role:'synthetic-new-role',status:'inactive'}};
 f.respond=async url=>url.endsWith('/v1/governance/platform')?Response.json(f.data):url.endsWith('/tenants/tenant-a/audit')?Response.json({events:[event]}):Response.json({users:[],records:[],events:[],partners:[]});
 await f.render();assert.equal(f.root.view,'audit');assert.equal(f.requests.some(r=>String(r.url??r).includes('/tenants/tenant-a/audit')),true);
 const rendered=()=>f.root.innerHTML,observed={locale,actionVisible:rendered().includes(event.action),timeVisible:rendered().includes(event.created_at),actorVisible:rendered().includes(event.actor_id),targetVisible:rendered().includes(event.target_id),beforeVisible:rendered().includes('synthetic-old-role'),afterVisible:rendered().includes('synthetic-new-role')};
 const refresh=f.root.querySelector('[data-cy=platform-refresh]');assert.ok(refresh);refresh.onclick();await settle();assert.equal(f.root.view,'audit');assert.equal(rendered().includes(event.action),observed.actionVisible);
 summary.results.push(observed);assert.equal(observed.actionVisible&&observed.timeVisible,true);assert.equal(f.requests.filter(r=>String(r.url).includes('/audit')).every(r=>String(r.url).endsWith('/tenants/tenant-a/audit')),true,'all initial/reload audit reads must retain own tenant');
 observed.remainingMissing=Object.entries({actor:observed.actorVisible,target:observed.targetVisible,before:observed.beforeVisible,after:observed.afterVisible}).filter(([,visible])=>!visible).map(([field])=>field+'_presentation');
 // Observations remain missing; successful diagnostic execution does not accept this workflow.
});
await mkdir('test-results/tenant-administration-audit',{recursive:true});await writeFile('test-results/tenant-administration-audit/presentation-summary.json',JSON.stringify(summary,null,2)+'\n');
