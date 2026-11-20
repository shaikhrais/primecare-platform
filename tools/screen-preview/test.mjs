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
 const html=await readFile('tools/screen-preview/shell.html','utf8');assert.match(html,/connect-src 'none'/);assert.match(html,/worker-src 'none'/);assert.match(html,/form-action 'none'/);assert.match(html,/REGISTERED TEMPLATE/);assert.match(html,/ACTUAL RENDERER/);assert.match(html,/Synthetic data only/);assert.match(html,/allow-forms/);
 const entry=await readFile('tools/screen-preview/entry.ts','utf8');assert.doesNotMatch(entry,/fetch\(.*apiOrigin/);assert.match(entry,/store\.missing/);assert.match(entry,/syntheticSession/);
 const registry=JSON.parse(await readFile('cloudflare/workers/src/workspace-registry.json','utf8'));assert.equal(new Set(registry.screens.map(s=>s.route)).size,registry.screens.length);
});

test('export preserves the embedded bundle without replacement-string corruption',async()=>{
 const {mkdtemp,rm}=await import('node:fs/promises');const {tmpdir}=await import('node:os');const {execFileSync}=await import('node:child_process');const {Script}=await import('node:vm');
 const dir=await mkdtemp(tmpdir()+'/primecare-preview-');
 try{execFileSync(process.execPath,['tools/screen-preview/build.mjs',dir]);const html=await readFile(dir+'/PrimeCare_Interactive_Preview.html','utf8');const start=html.indexOf('window.PREVIEW_DATA=')+'window.PREVIEW_DATA='.length;const end=html.indexOf(';\nconst data=',start);assert.ok(end>start);const payload=JSON.parse(html.slice(start,end));assert.doesNotMatch(payload.js,/__PREVIEW_PAYLOAD__/);assert.doesNotThrow(()=>new Script(payload.js));assert.equal(payload.screens.length,972);assert.equal(payload.manifest.productionConnections,false);
 }finally{await rm(dir,{recursive:true,force:true});}
});
