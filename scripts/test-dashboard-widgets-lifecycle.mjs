import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';
const bundle=await build({entryPoints:['packages/primecare_ui/web/dashboard-widgets.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {PrimeDashboardWidgets,DashboardSession}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
const settle=()=>new Promise(resolve=>setImmediate(resolve));
for(const mode of ['dispose','remove','active','mutated-geometry'])test('queued widget source lifecycle: '+mode,async t=>{
 const {document,HTMLElement,HTMLSelectElement}=parseHTML('<html><head></head><body><main id="root"></main></body></html>');
 const previous=new Map(['HTMLElement','ResizeObserver'].map(key=>[key,Object.getOwnPropertyDescriptor(globalThis,key)]));
 Object.defineProperty(globalThis,'HTMLElement',{value:HTMLElement,configurable:true});
 Object.defineProperty(globalThis,'ResizeObserver',{value:class{observe(){}disconnect(){}},configurable:true});
 Object.defineProperty(HTMLSelectElement.prototype,'options',{get(){return this.querySelectorAll('option');},configurable:true});
 t.after(()=>{for(const [key,value]of previous){if(value)Object.defineProperty(globalThis,key,value);else delete globalThis[key];}});
 const root=document.getElementById('root');Object.defineProperty(root,'clientWidth',{value:800});
 const views=[{id:'wide',label:'Wide',minWidth:0,columns:4}],widgets=[{id:'trend',label:'Trend',registrationId:11,sourceId:21,workflowId:31,kind:'line',views:['wide'],minSpan:1,maxSpan:4,minRows:1,maxRows:4}],defaults={version:1,views:{wide:[{id:'trend',span:2,rows:2}]}};
 const session=new DashboardSession({tenantId:'fixture',userId:'fixture',role:'fixture',dataset:'demo'},'fixture',widgets,views,defaults);
 const kit=new PrimeDashboardWidgets(root,'queued-source');t.after(()=>{kit.dispose();session.dispose();});
 const geometry={rowHeight:100,gap:8,chart:{width:400,height:200,stroke:2}};let calls=0;kit.dashboard(session,geometry,async()=>{calls++;return {kind:'line',title:'Trend',categories:['A'],series:[{id:'one',label:'One',values:[1]}]};});
 if(mode==='mutated-geometry'){geometry.rowHeight=-100;geometry.gap=-8;geometry.chart.width=-400;session.edit(session.current.document);}
 if(mode==='dispose')kit.dispose();else if(mode==='remove')session.edit({version:1,views:{wide:[]}});
 await settle();assert.equal(calls,['active','mutated-geometry'].includes(mode)?1:0);assert.equal(root.querySelectorAll('[data-widget-card]').length,['active','mutated-geometry'].includes(mode)?1:0);if(['active','mutated-geometry'].includes(mode))assert.equal(root.querySelectorAll('figure').length,1);if(mode==='mutated-geometry'){assert.equal(root.querySelector('[data-cy=dashboard-widgets-dashboard-grid]').style.gridAutoRows,'100px');assert.equal(root.querySelector('[data-cy=dashboard-widgets-dashboard-grid]').style.gap,'8px');}
});
for(const kind of ['line','area'])test(kind+' retains series stroke identity when another series is hidden',async t=>{
 const {document,Event}=parseHTML('<html><head></head><body><main id="root"></main></body></html>');
 const root=document.getElementById('root'),kit=new PrimeDashboardWidgets(root,'series-identity');t.after(()=>kit.dispose());
 root.append(kit.chart({kind,title:'Trend',categories:['A','B'],series:[{id:'one',label:'One',values:[1,2]},{id:'two',label:'Two',values:[3,4]}]},{width:400,height:200,stroke:2}));
 const style=element=>({colour:element.getAttribute('stroke'),dash:element.getAttribute('stroke-dasharray')});
 const second=style(root.querySelectorAll('polyline')[1]);assert.notEqual(second.dash,'none');
 const toggle=root.querySelector('[data-cy="dashboard-widgets-toggle-one"]');
 toggle.dispatchEvent(new Event('click'));await settle();
 assert.equal(root.querySelectorAll('polyline').length,1);assert.deepEqual(style(root.querySelector('polyline')),second);
 toggle.dispatchEvent(new Event('click'));await settle();
 assert.equal(root.querySelectorAll('polyline').length,2);assert.deepEqual(style(root.querySelectorAll('polyline')[1]),second);
});
test('dashboard redraw retains layout draft, focus, selection and scroll',t=>{
 const {document,Event,HTMLSelectElement,HTMLTextAreaElement}=parseHTML('<html><head></head><body><main id="root"></main></body></html>');
 const old=Object.getOwnPropertyDescriptor(globalThis,'ResizeObserver');Object.defineProperty(globalThis,'ResizeObserver',{value:class{observe(){}disconnect(){}},configurable:true});
 t.after(()=>{if(old)Object.defineProperty(globalThis,'ResizeObserver',old);else delete globalThis.ResizeObserver;});
 Object.defineProperty(HTMLSelectElement.prototype,'options',{get(){return this.querySelectorAll('option');},configurable:true});
 const keys=['focus','setSelectionRange','selectionStart','selectionEnd','selectionDirection'],descriptors=new Map(keys.map(key=>[key,Object.getOwnPropertyDescriptor(HTMLTextAreaElement.prototype,key)]));t.after(()=>{for(const [key,value]of descriptors){if(value)Object.defineProperty(HTMLTextAreaElement.prototype,key,value);else delete HTMLTextAreaElement.prototype[key];}});
 let active=null;const selections=new WeakMap();Object.defineProperty(document,'activeElement',{get:()=>active});
 HTMLTextAreaElement.prototype.focus=function(){active=this;};HTMLTextAreaElement.prototype.setSelectionRange=function(start,end,direction){selections.set(this,{start,end,direction});};
 for(const [key,field]of [['selectionStart','start'],['selectionEnd','end'],['selectionDirection','direction']])Object.defineProperty(HTMLTextAreaElement.prototype,key,{get(){return selections.get(this)?.[field]??(field==='direction'?'none':0);},configurable:true});
 const root=document.getElementById('root');Object.defineProperty(root,'clientWidth',{value:800});
 const session=new DashboardSession({tenantId:'fixture',userId:'fixture',role:'fixture',dataset:'demo'},'fixture',[],[{id:'wide',label:'Wide',minWidth:0,columns:4}],{version:1,views:{wide:[]}}),kit=new PrimeDashboardWidgets(root,'layout-draft');t.after(()=>{kit.dispose();session.dispose();});
 kit.dashboard(session,{rowHeight:100,gap:8,chart:{width:400,height:200,stroke:2}});
 const input=root.querySelector('textarea');input.value='draft layout text';input.dispatchEvent(new Event('input'));input.focus();input.setSelectionRange(2,9,'backward');input.scrollTop=17;
 session.edit(session.current.document);const next=root.querySelector('textarea');
 assert.notEqual(next,input);assert.equal(next.value,'draft layout text');assert.equal(document.activeElement,next);assert.equal(next.selectionStart,2);assert.equal(next.selectionEnd,9);assert.equal(next.selectionDirection,'backward');assert.equal(next.scrollTop,17);
 const outside=document.createElement('textarea');outside.dataset.cy=next.dataset.cy;document.body.append(outside);outside.focus();session.edit(session.current.document);assert.equal(document.activeElement,outside,'redraw must not steal matching focus from another dashboard');
});

for(const kind of ['line','area'])test(kind+' redraw uses its validated chart size snapshot',async t=>{
 const {document,Event}=parseHTML('<html><head></head><body><main id="root"></main></body></html>');
 const root=document.getElementById('root'),kit=new PrimeDashboardWidgets(root,'chart-size');t.after(()=>kit.dispose());
 const size={width:400,height:200,stroke:2};root.append(kit.chart({kind,title:'Trend',categories:['A','B'],series:[{id:'one',label:'One',values:[1,2]},{id:'two',label:'Two',values:[3,4]}]},size));
 size.width=-1;size.height=NaN;size.stroke=Infinity;
 root.querySelector('[data-cy=dashboard-widgets-toggle-one]').dispatchEvent(new Event('click'));await settle();
 assert.equal(root.querySelector('svg').getAttribute('viewBox'),'0 0 400 200');assert.equal(root.querySelector('polyline').getAttribute('stroke-width'),'2');
 assert.doesNotMatch(root.querySelector('svg').outerHTML,/NaN|Infinity/);
});

for(const stage of ['unsubscribe','observer'])for(const failure of [Error('cleanup failed'),null,undefined])test('dashboard cleanup releases source and ownership after '+stage+' throws '+String(failure),async t=>{
 const {document,HTMLElement,HTMLSelectElement}=parseHTML('<html><head></head><body><main id="root"></main></body></html>');
 const previous=new Map(['HTMLElement','ResizeObserver'].map(key=>[key,Object.getOwnPropertyDescriptor(globalThis,key)]));
 Object.defineProperty(globalThis,'HTMLElement',{value:HTMLElement,configurable:true});Object.defineProperty(globalThis,'ResizeObserver',{value:class{observe(){}disconnect(){if(stage==='observer')throw failure;}},configurable:true});
 const options=Object.getOwnPropertyDescriptor(HTMLSelectElement.prototype,'options');Object.defineProperty(HTMLSelectElement.prototype,'options',{get(){return this.querySelectorAll('option');},configurable:true});
 t.after(()=>{for(const [key,value]of previous){if(value)Object.defineProperty(globalThis,key,value);else delete globalThis[key];}if(options)Object.defineProperty(HTMLSelectElement.prototype,'options',options);else delete HTMLSelectElement.prototype.options;});
 const root=document.getElementById('root');Object.defineProperty(root,'clientWidth',{value:800});const session=new DashboardSession({tenantId:'t',userId:'u',role:'fixture',dataset:'demo'},'fixture',[{id:'metric',label:'Metric',registrationId:11,sourceId:21,workflowId:31,kind:'metric',views:['wide'],minSpan:1,maxSpan:4,minRows:1,maxRows:4}],[{id:'wide',label:'Wide',minWidth:0,columns:4}],{version:1,views:{wide:[{id:'metric',span:2,rows:2}]}});
 const subscribe=session.subscribe.bind(session);session.subscribe=fn=>{const off=subscribe(fn);return()=>{off();if(stage==='unsubscribe')throw failure;};};let finish,signal;const kit=new PrimeDashboardWidgets(root,'cleanup-failure');kit.dashboard(session,{rowHeight:100,gap:8,chart:{width:400,height:200,stroke:2}},async(_id,_source,_flow,owned)=>{signal=owned;return new Promise(resolve=>finish=resolve);});await settle();let caught=false;try{kit.dispose();}catch(error){caught=true;assert.equal(error,failure);}assert.equal(caught,true);assert.equal(signal.aborted,true);assert.equal(root.childNodes.length,0);assert.equal(root.hasAttribute('data-pc-dashboard-widgets'),false);assert.notEqual(session.current.status,'disposed');finish({value:19,unit:''});await settle();assert.equal(root.childNodes.length,0);kit.dispose();const next=new PrimeDashboardWidgets(root,'replacement-owner');next.dispose();session.dispose();
});

for(const failure of [Error('style installation'),null,undefined])for(const existingMarker of [false,true])test('dashboard-widgets failed constructor releases marker/owner '+String(failure)+'/'+existingMarker,()=>{const {document}=parseHTML('<html><head></head><body><main><span>Caller draft</span></main></body></html>'),root=document.querySelector('main'),child=root.firstChild;if(existingMarker)root.setAttribute('data-pc-dashboard-widgets','caller-marker');const create=document.createElement.bind(document);document.createElement=(tag,...args)=>{if(tag==='style')throw failure;return create(tag,...args);};let caught=false;try{new PrimeDashboardWidgets(root,'constructor-failure');}catch(error){caught=true;assert.equal(error,failure);}finally{document.createElement=create;}assert.equal(caught,true);assert.equal(root.firstChild===child,true);assert.equal(root.getAttribute('data-pc-dashboard-widgets'),existingMarker?'caller-marker':null);assert.equal(document.querySelector('[data-pc-dashboard-style]'),null);const next=new PrimeDashboardWidgets(root,'replacement');next.dispose();});

for(const failure of [Error('observer mount'),null,undefined])test('failed dashboard mount restores caller content/session and preserves original error '+String(failure),()=>{const {document,HTMLElement,HTMLSelectElement}=parseHTML('<html><head></head><body><main><span>Caller draft</span></main></body></html>'),root=document.querySelector('main'),child=root.firstChild;const previous=new Map(['HTMLElement','ResizeObserver'].map(key=>[key,Object.getOwnPropertyDescriptor(globalThis,key)]));Object.defineProperty(globalThis,'HTMLElement',{value:HTMLElement,configurable:true});Object.defineProperty(globalThis,'ResizeObserver',{value:class{observe(){throw failure;}disconnect(){}},configurable:true});const options=Object.getOwnPropertyDescriptor(HTMLSelectElement.prototype,'options');Object.defineProperty(HTMLSelectElement.prototype,'options',{get(){return this.querySelectorAll('option');},configurable:true});Object.defineProperty(root,'clientWidth',{value:800});const session=new DashboardSession({tenantId:'t',userId:'u',role:'fixture',dataset:'demo'},'fixture',[],[{id:'wide',label:'Wide',minWidth:0,columns:4}],{version:1,views:{wide:[]}}),subscribe=session.subscribe.bind(session);let off=0;session.subscribe=fn=>{const stop=subscribe(fn);return()=>{off++;stop();throw Error('later unsubscribe');};};const kit=new PrimeDashboardWidgets(root,'failed-mount');let caught=false;try{kit.dashboard(session,{rowHeight:100,gap:8,chart:{width:400,height:200,stroke:2}});}catch(error){caught=true;assert.equal(error,failure);}finally{for(const [key,value]of previous){if(value)Object.defineProperty(globalThis,key,value);else delete globalThis[key];}if(options)Object.defineProperty(HTMLSelectElement.prototype,'options',options);else delete HTMLSelectElement.prototype.options;}assert.equal(caught,true);assert.equal(off,1);assert.equal(root.firstChild===child,true);assert.notEqual(session.current.status,'disposed');const next=new PrimeDashboardWidgets(root,'replacement');next.dispose();session.dispose();});
