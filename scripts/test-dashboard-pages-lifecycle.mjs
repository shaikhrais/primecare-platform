import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';
const built=await build({stdin:{contents:"export * from './packages/primecare_ui/web/dashboard-pages';export * from './packages/primecare_ui/web/record-pages';",resolveDir:process.cwd()},bundle:true,write:false,format:'esm',platform:'node'});
const {bindReadPage,bindDashboardPage,bindRecordPage}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const labels={title:'Dashboard',demo:'Demo',live:'Live',ready:'Ready',empty:'Empty',activity:'Activity',bounded:'Bounded records',denied:'Denied',unavailable:'Unavailable',loading:'Loading',error:'Error',idle:'Idle',disposed:'Closed',metrics:{}};
function session(projection){const listeners=new Set(),captured=[];const value={state:{status:'ready',projection},loads:0,disposals:0,subscribe(fn){captured.push(fn);listeners.add(fn);return()=>listeners.delete(fn);},load(){value.loads++;return Promise.resolve();},dispose(){value.disposals++;value.onDispose?.();},emit(projection){value.state={status:'ready',projection};for(const fn of [...listeners])fn();},listeners,captured};return value;}
function fixture(){const {document}=parseHTML('<html><body><main></main></body></html>');const root=document.querySelector('main'),render=projection=>root.textContent=projection.title;return {document,root,render};}
test('repeated old cleanup and captured callbacks cannot clear or repaint a replacement read page',()=>{
 const f=fixture(),old=session({title:'Old'}),closeOld=bindReadPage(f.root,old,f.render,labels);closeOld();const current=session({title:'Current'}),closeCurrent=bindReadPage(f.root,current,f.render,labels);closeOld();old.state.projection={title:'Late old result'};old.captured[0]();assert.equal(f.root.textContent,'Current');assert.equal(old.disposals,1);assert.equal(current.disposals,0);closeCurrent();assert.equal(f.root.textContent,'');assert.equal(current.disposals,1);
});
test('new binding owns root even when old cleanup arrives after the new mount',()=>{
 const f=fixture(),old=session({title:'Old'}),closeOld=bindReadPage(f.root,old,f.render,labels),current=session({title:'Current'}),closeCurrent=bindReadPage(f.root,current,f.render,labels);old.emit({title:'Stale'});closeOld();assert.equal(f.root.textContent,'Current');current.emit({title:'Current update'});assert.equal(f.root.textContent,'Current update');closeCurrent();
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
