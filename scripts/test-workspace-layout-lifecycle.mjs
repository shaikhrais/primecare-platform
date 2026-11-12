import test from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';
const bundle=await build({entryPoints:['packages/primecare_ui/web/layout-manager.ts'],bundle:true,write:false,format:'esm',platform:'node'});
const {BaseLayoutManager}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
// Match browser CSSStyleDeclaration: unset properties read as an empty string.
const stylePrototype=Object.getPrototypeOf(parseHTML('<html></html>').document.documentElement.style),readStyle=stylePrototype.getPropertyValue;
stylePrototype.getPropertyValue=function(name){return readStyle.call(this,name)??'';};
function fixture(){
 const {document,window}=parseHTML('<html><head></head><body><div id="app"><div class="app-shell"><input value="Unfinished draft"></div></div></body></html>');
 const values=new Map(),writes=[];globalThis.localStorage={getItem:key=>values.get(key)??null,setItem:(key,value)=>{values.set(key,value);writes.push([key,value]);}};globalThis.DOMParser=window.DOMParser;
 const root=document.getElementById('app'),first=new BaseLayoutManager(root,'actor-a');
 first.change({...first.current,theme:'dark'});first.change({...first.current,theme:'light'});first.undo();first.dispose();
 const replacement=new BaseLayoutManager(root,'actor-b');replacement.change({...replacement.current,theme:'dark',sidebar:'right',contentWidth:75});
 const snapshot=()=>({style:document.documentElement.getAttribute('style'),shell:root.querySelector('.app-shell').getAttribute('style'),attributes:[...root.querySelector('.app-shell').attributes].map(a=>[a.name,a.value]),profile:first.current,undo:first.canUndo,redo:first.canRedo,writes:[...writes]});
 return {root,first,replacement,snapshot,writes};
}
test('retired disposal cannot reset replacement theme or shell presentation',()=>{
 const f=fixture(),before=f.snapshot();try{f.first.dispose();assert.deepEqual(f.snapshot(),before);}finally{f.replacement.dispose();}
});
const mutations={
 attach:manager=>manager.attach(),
 defaults:manager=>manager.setDefaultTheme({'--color-primary':'#123456'}),
 change:manager=>manager.change({...manager.current,theme:'light'}),
 undo:manager=>manager.undo(),
 redo:manager=>manager.redo(),
 reset:manager=>manager.reset(),
 personal:manager=>manager.setPersonalTheme(null),
 import:manager=>manager.importXml('<invalid/>'),
 save:manager=>manager.save(),
};
for(const [name,mutate] of Object.entries(mutations))test(`retired ${name} cannot change replacement theme, history or saved account state`,()=>{
 const f=fixture(),before=f.snapshot();try{
  assert.throws(()=>mutate(f.first),/Layout disposed/);assert.deepEqual(f.snapshot(),before);
  assert.equal(f.root.querySelector('input').value,'Unfinished draft');
 }finally{f.replacement.dispose();}
});
test('live layout manager still changes, undoes, redoes and saves its own profile',()=>{
 const f=fixture();try{
  const view=f.replacement,base=view.current;view.change({...base,density:'compact'});assert.equal(view.current.density,'compact');
  view.undo();assert.deepEqual(view.current,base);view.redo();assert.equal(view.current.density,'compact');view.save();assert.equal(f.writes.length,1);assert.equal(f.writes[0][0],'actor-b');
 }finally{f.replacement.dispose();}
});
