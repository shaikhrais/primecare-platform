import test from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';
const bundle=await build({entryPoints:['packages/primecare_ui/web/workspace-layout.ts'],bundle:true,write:false,format:'esm',platform:'node'});
const {WorkspaceLayoutManager}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
function fixture(){
 const {document,window}=parseHTML('<html><head></head><body><div id="root"><nav id="nav"></nav><header id="toolbar"></header><main id="main"><input value="Unfinished draft"><section id="note">Authorized note</section></main><footer id="footer"></footer></div><section id="foreign">External owner</section></body></html>');
 const events=new EventTarget();Object.defineProperty(document,'defaultView',{configurable:true,value:{innerWidth:1500,innerHeight:900,addEventListener:(...args)=>events.addEventListener(...args)}});
 globalThis.CustomEvent=window.CustomEvent;globalThis.ResizeObserver=class{observe(){}disconnect(){}};
 for(const element of document.querySelectorAll('*'))element.getBoundingClientRect=()=>({width:1400,height:56,x:0,y:0});
 const root=document.getElementById('root'),foreign=document.getElementById('foreign');
 const slots={navigation:document.getElementById('nav'),toolbar:document.getElementById('toolbar'),main:document.getElementById('main'),footer:document.getElementById('footer'),panels:{note:document.getElementById('note')}};
 const original={...slots,panels:{...slots.panels}},writes=[];
 const view=new WorkspaceLayoutManager(root,slots,'tenant:actor:role',{getItem:()=>null,setItem:(...args)=>writes.push(args)});
 return {root,foreign,slots,original,view,writes};
}
for(const key of ['navigation','toolbar','main','footer'])test(`caller replacement of ${key} cannot move an external node into the workspace`,()=>{
 const f=fixture(),parent=f.foreign.parentElement;
 try{
  f.slots[key]=f.foreign;f.view.change({...f.view.current,toolbar:'bottom'});
  assert.equal(f.foreign.parentElement===parent,true,'validated slot membership must remain fixed');
  assert.equal(f.root.contains(f.foreign),false);assert.equal(f.root.contains(f.original[key]),true);
  assert.equal(f.root.querySelector('input').value,'Unfinished draft');
 }finally{f.view.dispose();}
});
for(const mutation of ['replace','add','replace-map'])test(`caller panel map ${mutation} cannot replace validated panel membership`,()=>{
 const f=fixture(),parent=f.foreign.parentElement;
 try{
  if(mutation==='replace')f.slots.panels.note=f.foreign;
  if(mutation==='add')f.slots.panels.extra=f.foreign;
  if(mutation==='replace-map')f.slots.panels={extra:f.foreign};
  f.view.change({...f.view.current,toolbar:'bottom'});
  assert.equal(f.foreign.parentElement===parent,true);assert.equal(f.root.contains(f.foreign),false);
  assert.equal(f.root.contains(f.original.panels.note),true);assert.deepEqual(Object.keys(f.view.current.panels),['note']);
 }finally{f.view.dispose();}
});
test('owned nodes remain live and restore their original membership after disposal',()=>{
 const f=fixture();f.original.panels.note.textContent='Current authorized note';f.view.dockPanel('note','right');assert.equal(f.original.panels.note.textContent,'Current authorized note');
 f.view.dispose();assert.equal(f.original.panels.note.parentElement===f.original.main,true);assert.equal(f.original.main.querySelector('input').value,'Unfinished draft');
});
for(const operation of ['undo','redo','save'])test(`retired ${operation} cannot mutate saved account state or cached history`,()=>{
 const f=fixture();f.view.change({...f.view.current,navigation:'right'});f.view.change({...f.view.current,toolbar:'bottom'});f.view.undo();f.view.dispose();
 const replacement=new WorkspaceLayoutManager(f.root,f.slots,'replacement-actor',{getItem:()=>null,setItem:()=>{}});
 const history=f.view.history,html=f.root.outerHTML;
 try{
  let failure;try{f.view[operation]();}catch(error){failure=error;}
  assert.deepEqual(f.view.history,history,'retired history must remain unchanged');assert.deepEqual(f.writes,[],'retired account must not persist');
  assert.equal(failure?.message,'Workspace disposed');assert.equal(f.root.outerHTML,html,'replacement presentation must remain unchanged');
 }finally{replacement.dispose();}
});
test('live workspace history and persistence remain available',()=>{
 const f=fixture();try{
  const original=f.view.current;f.view.change({...original,navigation:'right'});f.view.undo();assert.deepEqual(f.view.current,original);
  f.view.redo();assert.equal(f.view.current.navigation,'right');f.view.save();assert.equal(f.writes.length,1);assert.equal(f.writes[0][0],'tenant:actor:role');assert.equal(JSON.parse(f.writes[0][1]).navigation,'right');
 }finally{f.view.dispose();}
});
