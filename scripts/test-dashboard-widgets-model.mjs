import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';import {readFile,writeFile} from 'node:fs/promises';
const b=await build({stdin:{contents:"export * from './packages/domain/src/dashboard_widgets';export * from './packages/shared/src/dashboard-widgets/session';",resolveDir:process.cwd()},bundle:true,format:'esm',platform:'node',write:false});export const api=await import('data:text/javascript;base64,'+Buffer.from(b.outputFiles[0].text).toString('base64'));
export const views=[{id:'small',label:'Small',minWidth:0,columns:1},{id:'wide',label:'Wide',minWidth:700,columns:4}];export const widgets=[{id:'trend',label:'Authorized trend',registrationId:11,sourceId:21,workflowId:31,kind:'line',views:['small','wide'],minSpan:1,maxSpan:4,minRows:2,maxRows:8},{id:'metric',label:'Authorized metric',registrationId:12,sourceId:22,workflowId:32,kind:'metric',views:['small','wide'],minSpan:1,maxSpan:2,minRows:2,maxRows:6}];export const defaults={version:1,views:{small:[{id:'trend',span:1,rows:3}],wide:[{id:'trend',span:2,rows:3},{id:'metric',span:2,rows:3}]}};
const charts=[{kind:'line',title:'Mixed and missing',categories:['A','B','C'],series:[{id:'one',label:'One',values:[-4,null,6]}]},{kind:'area',title:'Single',categories:['A'],series:[{id:'one',label:'One',values:[2]}]},{kind:'bar',title:'Grouped',categories:['A','B'],series:[{id:'one',label:'One',values:[-3,5]},{id:'two',label:'Two',values:[4,null]}]},{kind:'donut',title:'Shares',categories:['A','B'],series:[{id:'one',label:'One',values:[3,1]}]},{kind:'donut',title:'Zero',categories:['A'],series:[{id:'one',label:'One',values:[0]}]},{kind:'line',title:'Empty',categories:[],series:[{id:'one',label:'One',values:[]}]}];
const fixture={views,widgets,defaults,charts:charts.map(data=>({data,geometry:api.chartGeometry(data)})),packed:api.packDashboard(defaults.views.wide,4),breakpoints:[[0,'small'],[699,'small'],[700,'wide'],[1500,'wide']]};const file='packages/flutter_core/test/dashboard_widgets/model-fixtures.json';if(process.argv.includes('--write'))await writeFile(file,JSON.stringify(fixture,null,2)+'\n');else assert.deepEqual(JSON.parse(await readFile(file,'utf8')),fixture);
test('bounded chart geometry preserves gaps, negative values, singleton and zero cases',()=>{assert.equal(fixture.charts[0].geometry.series[0].points[1],null);assert.equal(fixture.charts[1].geometry.series[0].points[0].x,0.5);assert.equal(fixture.charts[3].geometry.slices[0].end,0.75);assert.equal(fixture.charts[4].geometry.empty,true);for(const data of [{...charts[0],title:''},{...charts[0],html:'bad'},{...charts[0],series:[{id:'one',label:'x',values:[NaN,null,1]}]},{...charts[3],series:[{id:'one',label:'x',values:[-1,2]}]}])assert.throws(()=>api.validateChart(data));});
test('breakpoints and deterministic pack preserve placement bounds',()=>{for(const [width,id]of fixture.breakpoints)assert.equal(api.activeViewport(width,views),id);assert.deepEqual(fixture.packed.map(p=>[p.x,p.y]),[[0,0],[2,0]]);assert.deepEqual(api.packDashboard([{id:'a',span:3,rows:2},{id:'b',span:2,rows:3}],4).map(p=>[p.x,p.y]),[[0,0],[0,2]]);});
test('add/remove/reorder/resize are view-specific and reject denied imports and stale defaults',()=>{let d=api.editDashboard(defaults,'small',{kind:'add',id:'metric'},widgets,views);d=api.editDashboard(d,'small',{kind:'earlier',id:'metric'},widgets,views);assert.equal(d.views.small[0].id,'metric');d=api.editDashboard(d,'small',{kind:'wider',id:'metric'},widgets,views);assert.equal(d.views.small[0].span,1);assert.deepEqual(d.views.wide,defaults.views.wide);d=api.editDashboard(d,'small',{kind:'remove',id:'metric'},widgets,views);assert.equal(d.views.small.length,1);assert.throws(()=>api.validateDashboard(defaults,[widgets[0]],views));assert.throws(()=>api.parseDashboard(JSON.stringify({...defaults,panels:{}}),widgets,views));assert.throws(()=>api.editDashboard(defaults,'small',{kind:'add',id:'denied'},widgets,views));});
const scope={tenantId:'fixture-tenant',userId:'fixture-user',role:'fixture-role',dataset:'demo'},uuid=()=> '00000000-0000-4000-8000-000000000001';
test('public defaults cannot alter validated reload and reset placements',async()=>{
 const input=structuredClone(defaults),port={read:async()=>({scope,resource:'fixture',revision:0,document:null}),write:async()=>{throw Error('unused');}};
 const s=new api.DashboardSession(scope,'fixture',widgets,views,input,port,uuid);
 input.views.wide[0].span=99;
 const exposed=s.defaults;exposed.views.wide[0].id='denied';exposed.views.small.splice(0);
 assert.deepEqual(s.defaults,defaults);
 await s.load();assert.equal(s.current.status,'ready');assert.deepEqual(s.current.document,defaults);
 s.edit(api.editDashboard(defaults,'wide',{kind:'remove',id:'metric'},widgets,views));
 s.edit(s.defaults);assert.deepEqual(s.current.document,defaults);
 await s.load();assert.deepEqual(s.current.document,defaults);s.dispose();
});
test('scoped save requires acknowledged revision and independent port readback; reload survives',async()=>{let state={scope,resource:'fixture',revision:0,document:null},reads=0;const port={read:async()=>{reads++;return structuredClone(state);},write:async request=>{assert.equal(request.revision,state.revision);state={scope,resource:'fixture',revision:state.revision+1,document:request.document};return structuredClone(state);}};const s=new api.DashboardSession(scope,'fixture',widgets,views,defaults,port,uuid);await s.load();s.edit(defaults);await s.save();assert.equal(s.current.status,'clean');assert.equal(reads,2);const reloaded=new api.DashboardSession(scope,'fixture',widgets,views,defaults,port,uuid);await reloaded.load();assert.deepEqual(reloaded.current.document,defaults);assert.equal(reloaded.current.revision,1);s.dispose();reloaded.dispose();});
test('denied or mismatched persistence never claims saved and keeps edits',async()=>{for(const mode of ['denied','wrong-scope','readback']){let calls=0;const port={read:async()=>({scope,resource:'fixture',revision:calls?2:0,document:calls?defaults:null}),write:async r=>{calls++;if(mode==='denied')throw Object.assign(Error('denied'),{code:'revision_conflict'});return {scope:mode==='wrong-scope'?{...scope,userId:'other'}:scope,resource:'fixture',revision:1,document:r.document};}};const s=new api.DashboardSession(scope,'fixture',widgets,views,defaults,port,uuid);await s.load();s.edit(defaults);await assert.rejects(()=>s.save());assert.notEqual(s.current.status,'clean');assert.deepEqual(s.current.document,defaults);s.dispose();}});
test('edits during save survive older acknowledgement and disposed completions are ignored',async()=>{let finish,state={scope,resource:'fixture',revision:0,document:null};const port={read:async()=>structuredClone(state),write:async r=>new Promise(resolve=>finish=()=>{state={scope,resource:'fixture',revision:1,document:r.document};resolve(structuredClone(state));})};const s=new api.DashboardSession(scope,'fixture',widgets,views,defaults,port,uuid);await s.load();const pending=s.save();const edited=api.editDashboard(defaults,'wide',{kind:'remove',id:'metric'},widgets,views);s.edit(edited);finish();await pending;assert.equal(s.current.status,'dirty');assert.deepEqual(s.current.document,edited);const t=new api.DashboardSession(scope,'fixture',widgets,views,defaults,{read:()=>new Promise(r=>finish=r),write:port.write},uuid);const load=t.load();t.dispose();finish(state);await load;assert.equal(t.current.status,'disposed');s.dispose();});
test('uncertain dashboard retries retain request identity and acknowledged saves only retry readback',async()=>{
 for(const mode of ['lost-ack','lost-read']){
  let state={scope,resource:'fixture',revision:0,document:null},writes=0,applied=0,reads=0,uuidCalls=0,failed=false;const keys=[],receipts=new Map();
  const port={read:async()=>{reads++;if(mode==='lost-read'&&writes&&!failed){failed=true;throw Error('verification offline');}return structuredClone(state);},write:async request=>{writes++;keys.push(request.requestId);if(receipts.has(request.requestId))return structuredClone(receipts.get(request.requestId));applied++;state={scope,resource:'fixture',revision:request.revision+1,document:request.document};receipts.set(request.requestId,structuredClone(state));if(mode==='lost-ack'&&!failed){failed=true;throw Error('ack offline');}return structuredClone(state);}};
  const s=new api.DashboardSession(scope,'fixture',widgets,views,defaults,port,()=>{uuidCalls++;return uuid();});await s.load();s.edit(defaults);await assert.rejects(()=>s.save());assert.equal(s.current.pending,true);await assert.rejects(()=>s.load());await assert.rejects(()=>s.save());await s.retryPending();assert.equal(s.current.status,'clean');assert.equal(s.current.pending,false);assert.equal(applied,1);assert.equal(uuidCalls,1);assert.equal(writes,mode==='lost-ack'?2:1);if(keys.length===2)assert.equal(keys[0],keys[1]);s.dispose();
 }
});
test('listener disposal before persistence dispatch prevents reads and writes',async()=>{
 for(const phase of ['load','save','retry']){
  let reads=0,writes=0;
  const port={read:async()=>{reads++;return {scope,resource:'fixture',revision:0,document:null};},write:async()=>{writes++;throw Error('offline');}};
  const s=new api.DashboardSession(scope,'fixture',widgets,views,defaults,port,uuid);
  if(phase!=='load')await s.load();
  if(phase==='retry')await assert.rejects(()=>s.save());
  const before={reads,writes};
  s.subscribe(()=>{if(s.current.status===(phase==='load'?'loading':'saving'))s.dispose();});
  if(phase==='load')await s.load();else if(phase==='save')await s.save();else await s.retryPending();
  assert.deepEqual({reads,writes},before,phase+' must not dispatch after disposal');
  assert.equal(s.current.status,'disposed');assert.equal(s.current.pending,false);
 }
});
test('chart and registry kinds reject coercible objects without invoking them',()=>{
 let coerced=0;const kind={toString(){coerced++;return 'line';}};
 assert.throws(()=>api.validateChart({...charts[0],kind}));
 assert.throws(()=>api.validateRegistry([{...widgets[0],kind}],views));
 assert.equal(coerced,0);
});
test('unknown layout actions cannot silently resize a widget or change input',()=>{
 const before=structuredClone(defaults);
 for(const kind of ['shrink','',null,undefined])assert.throws(()=>api.editDashboard(defaults,'wide',{kind,id:'trend'},widgets,views));
 assert.deepEqual(defaults,before);
});
for(const dirty of [false,true])test('stale dashboard reload preserves '+(dirty?'draft':'saved layout')+' and known revision',async()=>{
 let state={scope,resource:'fixture',revision:2,document:structuredClone(defaults)};
 const port={read:async()=>structuredClone(state),write:async()=>{throw Error('unused');}};
 const s=new api.DashboardSession(scope,'fixture',widgets,views,defaults,port,uuid);await s.load();
 if(dirty)s.edit(api.editDashboard(defaults,'wide',{kind:'remove',id:'metric'},widgets,views));
 const before=s.current;state={scope,resource:'fixture',revision:1,document:{version:1,views:{small:[],wide:[]}}};
 await s.load();assert.equal(s.current.status,'error');assert.equal(s.current.revision,2);assert.deepEqual(s.current.document,before.document);assert.equal(s.current.loaded,true);
 state={scope,resource:'fixture',revision:3,document:structuredClone(defaults)};await s.load();assert.equal(s.current.status,'clean');assert.equal(s.current.revision,3);assert.deepEqual(s.current.document,defaults);s.dispose();
});
for(const dirty of [false,true])test('same revision cannot replace known '+(dirty?'draft baseline':'saved content'),async()=>{
 let state={scope,resource:'fixture',revision:2,document:structuredClone(defaults)};
 const port={read:async()=>structuredClone(state),write:async r=>{state={scope,resource:'fixture',revision:r.revision+1,document:structuredClone(r.document)};return structuredClone(state);}};
 const s=new api.DashboardSession(scope,'fixture',widgets,views,defaults,port,uuid);await s.load();
 if(dirty)s.edit(api.editDashboard(defaults,'wide',{kind:'remove',id:'metric'},widgets,views));
 const before=s.current;state.document={version:1,views:{small:[],wide:[]}};await s.load();
 assert.equal(s.current.status,'error');assert.equal(s.current.revision,2);assert.deepEqual(s.current.document,before.document);
 state.document=structuredClone(defaults);await s.load();assert.equal(s.current.status,'clean');
 s.edit(api.editDashboard(defaults,'wide',{kind:'remove',id:'metric'},widgets,views));await s.save();assert.equal(s.current.revision,3);
 const saved=s.current.document;state.document=structuredClone(defaults);await s.load();assert.equal(s.current.status,'error');assert.deepEqual(s.current.document,saved);assert.equal(s.current.revision,3);s.dispose();
});
test('stale save readback retains acknowledged receipt and retries read-only',async()=>{
 let state={scope,resource:'fixture',revision:0,document:null},writes=0,stale=true;
 const port={read:async()=>writes&&stale?{scope,resource:'fixture',revision:0,document:null}:structuredClone(state),write:async r=>{writes++;state={scope,resource:'fixture',revision:1,document:structuredClone(r.document)};return structuredClone(state);}};
 const s=new api.DashboardSession(scope,'fixture',widgets,views,defaults,port,uuid);await s.load();await assert.rejects(()=>s.save());
 assert.equal(s.current.status,'error');assert.equal(s.current.pending,true);assert.deepEqual(s.current.document,defaults);
 const edited=api.editDashboard(defaults,'wide',{kind:'remove',id:'metric'},widgets,views);s.edit(edited);
 stale=false;await s.retryPending();assert.equal(writes,1);assert.equal(s.current.pending,false);assert.equal(s.current.status,'dirty');assert.equal(s.current.revision,1);assert.deepEqual(s.current.document,edited);s.dispose();
});
test('request ID callback disposal cannot revive a session or create pending work',async()=>{
 let writes=0,s;
 const port={read:async()=>({scope,resource:'fixture',revision:0,document:null}),write:async()=>{writes++;throw Error('must not dispatch');}};
 s=new api.DashboardSession(scope,'fixture',widgets,views,defaults,port,()=>{s.dispose();return uuid();});
 await s.load();await assert.rejects(()=>s.save());assert.equal(writes,0);assert.equal(s.current.status,'disposed');assert.equal(s.current.pending,false);
});
