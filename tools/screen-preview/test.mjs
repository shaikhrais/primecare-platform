import {test} from 'node:test';import assert from 'node:assert/strict';import {readFile} from 'node:fs/promises';
import {createDemoStore,demoApi,traffic,endpoints} from './data.ts';
import {readTrafficReport,readEndpointSummary} from '../../packages/domain/src/endpoint_traffic.ts';
test('synthetic EMS reports reconcile and produce real chart inputs',()=>{
 const store=createDemoStore(),summary=demoApi(store,'/v1/governance/platform/ems/summary','GET',{},'populated').value;
 assert.equal(summary.declarations,120);assert.equal(Object.values(summary.readiness).reduce((a,b)=>a+b,0),120);
 assert.equal(readTrafficReport(traffic(0)).endpoints.size,120);
 assert.notEqual(readTrafficReport(traffic(0)).requestsPerSecond,readTrafficReport(traffic(1)).requestsPerSecond);
 const services=demoApi(store,'/v1/governance/platform/ems/services?limit=100','GET',{},'populated').value;assert.equal(readEndpointSummary(services).operations,120);
});
test('preview writes remain in memory and error denied empty states are explicit',()=>{
 const store=createDemoStore();const n=store.tenants.length;demoApi(store,'/v1/governance/platform/tenants','POST',{name:'Synthetic new organization',slug:'preview-new'},'populated');assert.equal(store.tenants.length,n+1);assert.equal(createDemoStore().tenants.length,n);
 assert.equal(demoApi(store,'/v1/governance/platform','GET',{},'denied').status,403);assert.equal(demoApi(store,'/v1/governance/platform','GET',{},'error').status,503);
 assert.equal(demoApi(store,'/v1/governance/platform/ems/endpoints','GET',{},'empty').value.pagination.total,0);
 assert.equal(demoApi(store,'/not-modeled','GET',{},'populated').status,503);assert.ok(store.missing.has('GET /not-modeled'));
});
test('offline shell blocks network and labels actual renderer versus metadata coverage',async()=>{
 const html=await readFile('tools/screen-preview/shell.html','utf8');assert.match(html,/connect-src 'none'/);assert.match(html,/worker-src 'none'/);assert.match(html,/form-action 'none'/);assert.match(html,/REGISTERED TEMPLATE/);assert.match(html,/ACTUAL RENDERER/);assert.match(html,/Synthetic data only/);
 const entry=await readFile('tools/screen-preview/entry.ts','utf8');assert.doesNotMatch(entry,/fetch\(.*apiOrigin/);assert.match(entry,/store\.missing/);assert.match(entry,/syntheticSession/);
 const registry=JSON.parse(await readFile('cloudflare/workers/src/workspace-registry.json','utf8'));assert.equal(new Set(registry.screens.map(s=>s.route)).size,registry.screens.length);
});
