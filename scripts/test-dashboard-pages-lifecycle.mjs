import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';
const built=await build({stdin:{contents:"export * from './packages/primecare_ui/web/dashboard-pages';export * from './packages/primecare_ui/web/record-pages';",resolveDir:process.cwd()},bundle:true,write:false,format:'esm',platform:'node'});
const {bindReadPage,bindDashboardPage,bindRecordPage}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const labels={title:'Dashboard',demo:'Demo',live:'Live',ready:'Ready',empty:'Empty',activity:'Activity',bounded:'Bounded records',denied:'Denied',unavailable:'Unavailable',loading:'Loading',error:'Error',idle:'Idle',disposed:'Closed',metrics:{}};
function session(projection){const listeners=new Set(),captured=[];const value={state:{status:'ready',projection},loads:0,disposals:0,subscribe(fn){captured.push(fn);listeners.add(fn);return()=>listeners.delete(fn);},load(){value.loads++;return Promise.resolve();},dispose(){value.disposals++;value.onDispose?.();},emit(projection){value.state={status:'ready',projection};for(const fn of [...listeners])fn();},listeners,captured};return value;}
function fixture(){const {document}=parseHTML('<html><body><main></main></body></html>');const root=document.querySelector('main'),render=projection=>root.textContent=projection.title;return {document,root,render};}
for(const partial of [false,true])test('failed live read-page rendering clears '+(partial?'partial':'previous')+' projection',()=>{
 const f=fixture(),s=session({title:'Initial'});let fail=false;
 const close=bindReadPage(f.root,s,projection=>{if(fail){if(partial)f.render({title:'Partial sensitive output'});throw Error('render failed');}f.render(projection);},labels);
 fail=true;assert.throws(()=>s.emit({title:'New result'}),/render failed/);
 assert.equal(f.root.textContent,'Error');assert.equal(f.root.firstChild.getAttribute('role'),'alert');assert.equal(s.disposals,0);
 fail=false;s.emit({title:'Recovered'});assert.equal(f.root.textContent,'Recovered');close();
});
test('failed live rendering does not clear a synchronously installed replacement owner',()=>{
 const f=fixture(),s=session({title:'Initial'});let replace=false,closeNext;
 const close=bindReadPage(f.root,s,projection=>{if(replace){replace=false;closeNext=bindReadPage(f.root,session({title:'Replacement'}),f.render,labels);throw Error('old render failed');}f.render(projection);},labels);
 replace=true;assert.throws(()=>s.emit({title:'Old result'}),/old render failed/);assert.equal(f.root.textContent,'Replacement');close();assert.equal(f.root.textContent,'Replacement');closeNext();
});
test('repeated old cleanup and captured callbacks cannot clear or repaint a replacement read page',()=>{
 const f=fixture(),old=session({title:'Old'}),closeOld=bindReadPage(f.root,old,f.render,labels);closeOld();const current=session({title:'Current'}),closeCurrent=bindReadPage(f.root,current,f.render,labels);closeOld();old.state.projection={title:'Late old result'};old.captured[0]();assert.equal(f.root.textContent,'Current');assert.equal(old.disposals,1);assert.equal(current.disposals,0);closeCurrent();assert.equal(f.root.textContent,'');assert.equal(current.disposals,1);
});
test('new binding owns root even when old cleanup arrives after the new mount',()=>{
 const f=fixture(),old=session({title:'Old'}),closeOld=bindReadPage(f.root,old,f.render,labels),current=session({title:'Current'}),closeCurrent=bindReadPage(f.root,current,f.render,labels);old.emit({title:'Stale'});closeOld();assert.equal(f.root.textContent,'Current');current.emit({title:'Current update'});assert.equal(f.root.textContent,'Current update');closeCurrent();
});
for(const mode of ['replacement','cleanup'])test('read-page state access cannot repaint after synchronous '+mode,()=>{
 const f=fixture(),old=session({title:'Old sensitive projection'});let retire=false,closeCurrent;
 const snapshot=old.state;
 Object.defineProperty(old,'state',{get(){if(retire){retire=false;if(mode==='replacement')closeCurrent=bindReadPage(f.root,session({title:'Current owner'}),f.render,labels);else closeOld();}return snapshot;}});
 const closeOld=bindReadPage(f.root,old,f.render,labels);retire=true;old.captured[0]();
 assert.equal(f.root.textContent,mode==='replacement'?'Current owner':'');closeOld();closeCurrent?.();
});
test('failed initial drawing restores the prior nodes and active binding without loading or disposing the failed session',()=>{
 const f=fixture(),old=session({title:'Old'}),closeOld=bindReadPage(f.root,old,f.render,labels),node=f.document.createElement('input');node.value='Retained draft';f.root.append(node);const failed=session({title:'Rejected'}),error=Error('render failed');assert.throws(()=>bindReadPage(f.root,failed,()=>{f.root.textContent='Partial failed output';throw error;},labels),e=>e===error);assert.equal(f.root.contains(node),true);assert.equal(node.value,'Retained draft');assert.equal(failed.loads,0);assert.equal(failed.disposals,0);assert.equal(failed.listeners.size,0);old.emit({title:'Recovered owner'});assert.equal(f.root.textContent,'Recovered owner');closeOld();
});
test('synchronous load failure unsubscribes and returns root ownership to the previous binding',()=>{
 const f=fixture(),old=session({title:'Old'}),closeOld=bindReadPage(f.root,old,f.render,labels),failed=session({title:'Failed'}),error=Error('load failed');failed.load=()=>{throw error;};assert.throws(()=>bindReadPage(f.root,failed,f.render,labels),e=>e===error);assert.equal(failed.listeners.size,0);assert.equal(failed.disposals,0);assert.equal(f.root.textContent,'Old');old.emit({title:'Still active'});assert.equal(f.root.textContent,'Still active');closeOld();
});
test('session disposal that mounts a new owner cannot have its replacement cleared',()=>{
 const f=fixture(),old=session({title:'Old'}),closeOld=bindReadPage(f.root,old,f.render,labels),current=session({title:'Reentrant replacement'});let closeCurrent;old.onDispose=()=>{closeCurrent=bindReadPage(f.root,current,f.render,labels);};closeOld();assert.equal(f.root.textContent,'Reentrant replacement');closeOld();assert.equal(old.disposals,1);closeCurrent();
});
test('failed replacement cannot revive a prior binding explicitly disposed during its construction',()=>{
 const f=fixture(),old=session({title:'Old sensitive projection'}),closeOld=bindReadPage(f.root,old,f.render,labels),failed=session({title:'Rejected'});assert.throws(()=>bindReadPage(f.root,failed,()=>{closeOld();f.root.textContent='Partial failed output';throw Error('rejected replacement');},labels),/rejected replacement/);old.captured[0]();assert.equal(f.root.textContent,'');assert.equal(old.disposals,1);assert.equal(failed.disposals,0);
});
for(const kind of ['dashboard','records'])test(kind+' public binding preserves replacement content after stale cleanup',()=>{
 const f=fixture(),projection=title=>kind==='dashboard'?{family:'project',dataset:'live',synthetic:false,status:'ready',metrics:[]}:{kind:'activity',synthetic:false,status:'ready',rows:[{title,detail:'Details'}]},bind=(s,title)=>kind==='dashboard'?bindDashboardPage(f.root,s,{...labels,title}):bindRecordPage(f.root,s,labels),old=session(projection('Old')),closeOld=bind(old,'Old');closeOld();const current=session(projection('Current')),closeCurrent=bind(current,'Current');const expected=f.root.textContent;closeOld();old.captured[0]();assert.equal(f.root.textContent,expected);assert.match(f.root.textContent,/Current/);closeCurrent();
});

for(const phase of ['render','subscribe','load'])test('failed replacement restores latest denial rather than cached sensitive nodes during '+phase,()=>{
 const f=fixture(),old=session({title:'Sensitive account data'}),closeOld=bindReadPage(f.root,old,f.render,labels),failed=session({title:'Replacement'});
 const deny=()=>{old.state={status:'denied',projection:null};for(const fn of [...old.listeners])fn();throw Error('replacement failed');};
 const render=phase==='render'?deny:f.render;
 if(phase==='subscribe')failed.subscribe=deny;
 if(phase==='load')failed.load=deny;
 assert.throws(()=>bindReadPage(f.root,failed,render,labels),/replacement failed/);
 assert.equal(f.root.textContent,'Denied');assert.equal(f.root.firstChild.getAttribute('role'),'alert');assert.equal(old.disposals,0);
 old.emit({title:'Authorized reload'});assert.equal(f.root.textContent,'Authorized reload');closeOld();
});
test('failed replacement restores latest authorized projection after a suspended update',()=>{
 const f=fixture(),old=session({title:'Old'}),closeOld=bindReadPage(f.root,old,f.render,labels);
 assert.throws(()=>bindReadPage(f.root,session({title:'Replacement'}),()=>{old.emit({title:'Fresh projection'});throw Error('replacement failed');},labels),/replacement failed/);
 assert.equal(f.root.textContent,'Fresh projection');closeOld();
});
test('failed restoration renderer clears partial sensitive output and preserves original construction error',()=>{
 const f=fixture(),old=session({title:'Old'});let reject=false;
 const closeOld=bindReadPage(f.root,old,projection=>{f.render(projection);if(reject)throw Error('old renderer failed');},labels),error=Error('replacement failed');
 assert.throws(()=>bindReadPage(f.root,session({title:'Replacement'}),()=>{reject=true;old.emit({title:'Sensitive partial result'});throw error;},labels),e=>e===error);
 assert.equal(f.root.textContent,'');reject=false;old.emit({title:'Recovered'});assert.equal(f.root.textContent,'Recovered');closeOld();
});

function failingLoad(s){let reject;const promise=new Promise((_,r)=>{reject=r;});promise.catch(()=>{});s.load=()=>promise;return async()=>{reject(Error('offline'));await new Promise(r=>setImmediate(r));};}
test('rejected initial read clears retained projection and shows localized error',async()=>{
 const f=fixture(),s=session({title:'Sensitive old projection'}),fail=failingLoad(s),close=bindReadPage(f.root,s,f.render,labels);await fail();
 assert.equal(f.root.textContent,'Error');assert.equal(f.root.firstChild.getAttribute('role'),'alert');assert.equal(s.disposals,0);close();assert.equal(s.disposals,1);
});
for(const mode of ['replacement','cleanup'])test('late rejected read cannot repaint after '+mode,async()=>{
 const f=fixture(),s=session({title:'Old'}),fail=failingLoad(s),close=bindReadPage(f.root,s,f.render,labels);let nextClose;
 if(mode==='replacement')nextClose=bindReadPage(f.root,session({title:'Current'}),f.render,labels);else close();
 await fail();assert.equal(f.root.textContent,mode==='replacement'?'Current':'');close();nextClose?.();
});
test('late rejected load cannot override newer denial or authorized render',async()=>{
 for(const status of ['denied','ready']){const f=fixture(),s=session({title:'Old'}),fail=failingLoad(s),close=bindReadPage(f.root,s,f.render,labels);
 if(status==='denied'){s.state={status:'denied',projection:null};for(const fn of [...s.listeners])fn();}else s.emit({title:'New response'});
 await fail();assert.equal(f.root.textContent,status==='denied'?'Denied':'New response');close();}
});
