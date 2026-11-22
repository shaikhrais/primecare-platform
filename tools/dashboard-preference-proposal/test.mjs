import {test} from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import Ajv from 'ajv';
import {build} from 'esbuild';
const root=path.resolve(path.dirname(fileURLToPath(import.meta.url)),'../..');
const folder=path.join(root,'docs/architecture/proposals/dashboard-preferences-v1');
const schema=name=>JSON.parse(fs.readFileSync(path.join(folder,name+'.schema.json'),'utf8'));
const ajv=new Ajv({strict:true,allErrors:true});ajv.addSchema(schema('shared'));
const request=ajv.compile(schema('request')),response=ajv.compile(schema('response'));
const bundle=await build({stdin:{resolveDir:root,contents:"export {validateDashboard} from './packages/domain/src/dashboard_widgets';export {preferenceResource,samePreferenceScope} from './packages/domain/src/preference_sync';"},bundle:true,platform:'node',format:'esm',write:false});
const {validateDashboard,preferenceResource,samePreferenceScope}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
const scope={tenantId:'fixture-tenant',userId:'fixture-user',role:'fixture-role',dataset:'demo'};
const layout={version:1,views:{small:[{id:'trend',span:1,rows:2}],wide:[{id:'trend',span:2,rows:3}]}};
const widgets=[{id:'trend',label:'Fixture only',registrationId:11,sourceId:21,workflowId:31,kind:'line',views:['small','wide'],minSpan:1,maxSpan:4,minRows:1,maxRows:6}];
const views=[{id:'small',label:'Small',minWidth:0,columns:1},{id:'wide',label:'Wide',minWidth:700,columns:4}];
const packet=action=>({version:1,expectedScope:structuredClone(scope),dataset:'demo',kind:'dashboard',resource:'fixture-dashboard',action,...(action==='read'?{}:{revision:0,requestId:'00000000-0000-4000-8000-000000000001'}),...(action==='write'?{document:structuredClone(layout)}:{})});
test('draft request schemas accept the four bounded actions and unchanged layout shape',()=>{
 for(const action of ['read','write','reset','delete'])assert.equal(request(packet(action)),true,JSON.stringify(request.errors));
 assert.deepEqual(validateDashboard(layout,widgets,views),layout);
});
test('draft envelopes reject extra business data, client registries and malformed mutations',()=>{
 for(const mutate of [p=>p.registry=[],p=>p.document.values=[1000],p=>p.document.views.small[0].sourceId=21,p=>delete p.requestId,p=>p.revision=-1,p=>p.requestId='not-a-uuid']){const p=packet('write');mutate(p);assert.equal(request(p),false);}
 const read=packet('read');read.revision=0;assert.equal(request(read),false);
});
test('layout bounds reject excess views, placements, dimensions and reserved IDs',()=>{
 for(const mutate of [p=>p.document.views=Object.fromEntries(Array.from({length:9},(_,i)=>['view-'+i,[]])),p=>p.document.views.small=Array.from({length:61},()=>({id:'trend',span:1,rows:1})),p=>p.document.views.small[0].span=13,p=>p.document.views.small[0].rows=21,p=>p.document.views.small[0].id='constructor']){const p=packet('write');mutate(p);assert.equal(request(p),false);}
});
test('structure does not grant widget authority: current registry validator rejects unknown IDs',()=>{
 const p=packet('write');p.document.views.small[0].id='not-registered';assert.equal(request(p),true);assert.throws(()=>validateDashboard(p.document,widgets,views));
});
test('server registry semantics must reject duplicates, unauthorized views and per-view overflow',()=>{
 for(const mutate of [p=>p.document.views.small.push({id:'trend',span:1,rows:3}),p=>p.document.views.denied=[],p=>p.document.views.small[0].span=2,p=>p.document.views.small[0].rows=7]){const p=packet('write');mutate(p);assert.equal(request(p),true);assert.throws(()=>validateDashboard(p.document,widgets,views));}
});
test('scope comparison is a separate required gate and schema cannot establish identity',()=>{
 const p=packet('write');p.expectedScope.userId='another-user';assert.equal(request(p),true);assert.equal(samePreferenceScope(scope,p.expectedScope),false);
 p.expectedScope=structuredClone(scope);p.expectedScope.dataset='live';assert.equal(request(p),true);assert.notEqual(p.dataset,p.expectedScope.dataset);
});
test('draft snapshots enforce a null initial document and bounded revision',()=>{
 const p={version:1,scope:structuredClone(scope),kind:'dashboard',resource:'fixture-dashboard',revision:0,document:null};assert.equal(response(p),true);
 p.document=structuredClone(layout);assert.equal(response(p),false);p.revision=1;assert.equal(response(p),true);p.revision=9007199254740992;assert.equal(response(p),false);
});
test('current runtime still rejects the proposed unregistered kind and preserves existing resources',()=>{
 assert.throws(()=>preferenceResource('dashboard','fixture-dashboard'),/invalid_kind/);
 assert.deepEqual(preferenceResource('theme','advanced-v2'),{kind:'theme',resource:'advanced-v2'});
 assert.deepEqual(preferenceResource('workspace','fixture'),{kind:'workspace',resource:'fixture'});
 assert.deepEqual(preferenceResource('shortcuts','navigation'),{kind:'shortcuts',resource:'navigation'});
});
