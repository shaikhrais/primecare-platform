import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';
const built=await build({entryPoints:['packages/primecare_ui/web/data-controls.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {PrimeDataControls}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const settle=()=>new Promise(resolve=>setImmediate(resolve));
function fixture(t){
 const {document,Event}=parseHTML('<html><head></head><body><main id="root"></main></body></html>');
 const previous=Object.getOwnPropertyDescriptor(globalThis,'Event');Object.defineProperty(globalThis,'Event',{value:Event,writable:true,configurable:true});
 t.after(()=>{if(previous)Object.defineProperty(globalThis,'Event',previous);else delete globalThis.Event;});
 const root=document.getElementById('root'),kit=new PrimeDataControls(root,'data-state-regression');t.after(()=>kit.dispose());
 return {root,kit,Event};
}
test('actual table retains first/last page disabled state after each completed action',async t=>{
 const {root,kit,Event}=fixture(t);
 const table=kit.table([{key:'name',label:'Name',width:100,visible:true,pinned:false}],Array.from({length:3},(_,i)=>({id:'r'+i,values:{name:'Row '+i}})),{rowHeight:48,height:240,minWidth:100,maxWidth:200,actionWidth:100,pageSize:2});root.append(table.element);
 const previous=root.querySelector('[data-cy=data-controls-previous]'),next=root.querySelector('[data-cy=data-controls-next]');
 assert.equal(previous.disabled,true);assert.equal(next.disabled,false);
 next.dispatchEvent(new Event('click'));await settle();assert.equal(table.model.page,1);assert.equal(next.disabled,true);assert.equal(previous.disabled,false);
 next.dispatchEvent(new Event('click'));await settle();assert.equal(table.model.page,1,'disabled end-page control cannot advance');
 previous.dispatchEvent(new Event('click'));await settle();assert.equal(table.model.page,0);assert.equal(previous.disabled,true);assert.equal(next.disabled,false);
 previous.dispatchEvent(new Event('click'));await settle();assert.equal(table.model.page,0,'disabled start-page control cannot retreat');
});
test('actual form retry clears stale alert role and retains error/loading/success states',async t=>{
 const {root,kit,Event}=fixture(t);let calls=0,finish;
 const form=kit.form([],async()=>{if(++calls===1)throw Error('denied');await new Promise(resolve=>finish=resolve);});root.append(form);
 const button=root.querySelector('[data-cy=data-controls-submit]');button.dispatchEvent(new Event('click'));await settle();
 const status=root.querySelector('[data-cy=data-controls-submit-status]');assert.equal(status.getAttribute('role'),'alert');assert.equal(status.textContent,kit.text('error'));
 button.dispatchEvent(new Event('click'));assert.equal(status.textContent,kit.text('loading'));assert.equal(status.getAttribute('role'),'status');assert.equal(button.disabled,true);assert.equal(button.getAttribute('aria-busy'),'true');
 button.dispatchEvent(new Event('click'));assert.equal(calls,2,'retry is serialized');finish();await settle();
 assert.equal(status.textContent,kit.text('success'));assert.equal(status.getAttribute('role'),'status');assert.equal(button.disabled,false);assert.equal(button.getAttribute('aria-busy'),null);
});
test('field keeps displayed numeric constraints after caller policy mutation',t=>{
 const {root,kit}=fixture(t),constraint={required:true,min:1,max:5,step:1},field=kit.field('number',constraint);root.append(field.element);
 Object.assign(constraint,{required:false,min:-10,max:100,step:.5});
 assert.deepEqual([field.input.required,field.input.min,field.input.max,field.input.step],[true,'1','5','1']);
 for(const value of ['', '0','1.5','6']){field.input.value=value;assert.equal(field.validate(),false,'original displayed constraint must reject '+value);}
 field.input.value='3';assert.equal(field.validate(),true);assert.equal(field.input.getAttribute('aria-invalid'),'false');
});
test('mask keeps original pattern, validation and selection after caller policy mutation',t=>{
 const {root,kit,Event}=fixture(t),constraint={required:true,pattern:'###-###'},field=kit.field('mask',constraint);root.append(field.element);
 constraint.pattern='## ##';constraint.required=false;field.input.value='123456';field.input.selectionStart=3;field.input.selectionEnd=6;field.input.setSelectionRange=(start,end)=>{field.input.selectionStart=start;field.input.selectionEnd=end;};
 field.input.dispatchEvent(new Event('input'));assert.equal(field.input.value,'123-456');assert.deepEqual([field.input.selectionStart,field.input.selectionEnd],[3,7]);assert.equal(field.validate(),true);
 field.input.value='';assert.equal(field.validate(),false);
});
for(const change of ['array','descriptor'])test('form retains rendered validation and input ownership after caller '+change+' mutation',async t=>{
 const {root,kit,Event}=fixture(t),field=kit.field('number',{required:true,min:1}),fields=[field];let calls=0,saved;
 root.append(kit.form(fields,async value=>{calls++;saved=value;}));
 const input=field.input;
 if(change==='array')fields.length=0;
 else{field.validate=()=>true;field.input=root.ownerDocument.createElement('input');field.input.name='foreign';field.input.value='foreign value';}
 const submit=root.querySelector('[data-cy=data-controls-submit]');submit.dispatchEvent(new Event('click'));await settle();assert.equal(calls,0,'rendered required field must still block dispatch');
 input.value='2';submit.dispatchEvent(new Event('click'));await settle();assert.equal(calls,1);assert.deepEqual(saved,{number:'2'});
});

test('autocomplete rejects detached old-result clicks and preserves current pointer selection',async t=>{
 const {root,kit,Event}=fixture(t),selected=[];
 const box=kit.autocomplete(async query=>[{value:query,label:query+' label'}],value=>selected.push(value));root.append(box);
 const input=root.querySelector('[role=combobox]');input.value='first';input.dispatchEvent(new Event('input'));await settle();
 const old=root.querySelector('[role=option]');input.value='second';input.dispatchEvent(new Event('input'));await settle();
 old.dispatchEvent(new Event('pointerdown',{cancelable:true}));assert.deepEqual(selected,[]);assert.equal(input.value,'second');
 root.querySelector('[role=option]').dispatchEvent(new Event('pointerdown',{cancelable:true}));assert.deepEqual(selected,['second']);assert.equal(input.value,'second label');
});
test('autocomplete hidden options cannot select after Escape or blur',async t=>{
 const {root,kit,Event}=fixture(t),selected=[];root.append(kit.autocomplete(async()=>[{value:'a',label:'A'}],value=>selected.push(value)));
 const input=root.querySelector('[role=combobox]');
 for(const mode of ['Escape','blur']){input.dispatchEvent(new Event('input'));await settle();const option=root.querySelector('[role=option]');
  if(mode==='blur')input.dispatchEvent(new Event('blur'));else{const key=new Event('keydown');key.key=mode;input.dispatchEvent(key);}
  option.dispatchEvent(new Event('pointerdown'));assert.deepEqual(selected,[]);
 }
});

for(const mode of ['Escape','blur'])test('autocomplete keeps reopened '+mode+' results selectable by pointer',async t=>{
 const {root,kit,Event}=fixture(t),selected=[];root.append(kit.autocomplete(async query=>[{value:query,label:query+' label'}],value=>selected.push(value)));
 const input=root.querySelector('[role=combobox]'),list=root.querySelector('[role=listbox]');
 const key=value=>{const e=new Event('keydown',{cancelable:true});e.key=value;input.dispatchEvent(e);};
 input.value='retained';input.dispatchEvent(new Event('input'));await settle();const option=list.firstElementChild;
 if(mode==='blur')input.dispatchEvent(new Event('blur'));else key('Escape');
 option.dispatchEvent(new Event('pointerdown',{cancelable:true}));assert.deepEqual(selected,[],'dismissed options stay inactive');
 key('ArrowDown');assert.equal(list.hidden,false);assert.equal(input.getAttribute('aria-activedescendant'),option.id);
 option.dispatchEvent(new Event('pointerdown',{cancelable:true}));assert.deepEqual(selected,['retained']);assert.equal(input.value,'retained label');assert.equal(list.hidden,true);
 input.value='next';input.dispatchEvent(new Event('input'));await settle();key('ArrowDown');key('Enter');assert.deepEqual(selected,['retained','next'],'fresh keyboard selection remains valid');
});
for(const mode of ['Escape','blur'])for(const fail of [false,true])test('autocomplete clears '+mode+' pending status and suppresses late '+(fail?'errors':'results'),async t=>{
 const {root,kit,Event}=fixture(t);let finish,signal;
 root.append(kit.autocomplete((query,requestSignal)=>{signal=requestSignal;return new Promise((resolve,reject)=>finish=fail?reject:resolve);}));
 const input=root.querySelector('[role=combobox]'),status=root.querySelector('[data-cy=data-controls-autocomplete-status]'),list=root.querySelector('[role=listbox]');
 input.value='retained query';input.dispatchEvent(new Event('input'));assert.equal(status.textContent,kit.text('loading'));
 if(mode==='blur')input.dispatchEvent(new Event('blur'));else{const e=new Event('keydown');e.key=mode;input.dispatchEvent(e);}
 assert.equal(signal.aborted,true);assert.equal(status.textContent,'','cancelled request must stop announcing loading');
 finish(fail?Error('late failure'):[{value:'late',label:'Late result'}]);await settle();
 assert.equal(status.textContent,'');assert.equal(list.hidden,true);assert.equal(list.childElementCount,0);assert.equal(input.value,'retained query');assert.equal(input.getAttribute('aria-expanded'),'false');assert.equal(input.hasAttribute('aria-activedescendant'),false);
});

for(const change of ['filter','replace'])test('table retires old sort controls after '+change+' while current controls still work',async t=>{
 const {root,kit,Event}=fixture(t),rows=[{id:'a',values:{name:'Alpha'}},{id:'b',values:{name:'Beta'}}];
 const table=kit.table([{key:'name',label:'Name',width:100,visible:true,pinned:false}],rows,{rowHeight:48,height:240,minWidth:100,maxWidth:200,actionWidth:100});root.append(table.element);
 const old=root.querySelector('[data-cy=data-controls-sort-name]');
 if(change==='replace')table.replace(rows);else{const filter=root.querySelector('[data-cy=data-controls-filter]');filter.value='Alpha';filter.dispatchEvent(new Event('input'));}
 const prior={key:table.model.sortKey,descending:table.model.descending};old.dispatchEvent(new Event('click'));
 assert.deepEqual({key:table.model.sortKey,descending:table.model.descending},prior,'detached header must not change current sorting');
 root.querySelector('[data-cy=data-controls-sort-name]').dispatchEvent(new Event('click'));assert.equal(table.model.sortKey,'name');
});

function editorSelection(input,Event,start,end){input.selectionStart=start;input.selectionEnd=end;input.dispatchEvent(new Event('select'));}
function formatStates(root){return ['bold','italic','list'].map(key=>root.querySelector('[data-cy="data-controls-'+key+'"]').getAttribute('aria-pressed'));}
for(const inlineRanges of [false,true])test('editor snapshots '+(inlineRanges?'range':'plain')+' capability before caller options mutate',async t=>{
 const {root,kit,Event}=fixture(t),options={inlineRanges};let saved;
 const editor=kit.editor({version:1,blocks:[{text:'Hello world',bold:false,italic:false,kind:'paragraph'}]},async value=>{saved=value;},undefined,options);root.append(editor.element);
 const input=root.querySelector('[data-cy=data-controls-editor]');input.focus=()=>{};input.setSelectionRange=(start,end)=>{input.selectionStart=start;input.selectionEnd=end;};
 options.inlineRanges=!inlineRanges;
 editorSelection(input,Event,0,5);root.querySelector('[data-cy=data-controls-bold]').dispatchEvent(new Event('click'));await settle();
 const expected={version:inlineRanges?2:1,blocks:[{text:'Hello world',bold:!inlineRanges,italic:false,kind:'paragraph',...(inlineRanges?{marks:[{start:0,end:5,bold:true,italic:false}]}:{})}]};
 assert.deepEqual(editor.document(),expected,'caller mutation must not change the document capability or selected range');
 root.querySelector('[data-cy=data-controls-save]').dispatchEvent(new Event('click'));await settle();assert.deepEqual(saved,expected,'save retains the validated construction policy');
});
test('editor exposes the current block format and updates all toggles on block navigation',t=>{
 const {root,kit,Event}=fixture(t);const editor=kit.editor({version:1,blocks:[{text:'first',bold:true,italic:false,kind:'bullet'},{text:'second',bold:false,italic:true,kind:'paragraph'}]});root.append(editor.element);
 assert.deepEqual(formatStates(root),['true','false','true']);root.querySelector('[data-cy=data-controls-editor-block-1]').dispatchEvent(new Event('click'));
 assert.deepEqual(formatStates(root),['false','true','false']);assert.equal(root.querySelector('[data-cy=data-controls-editor]').value,'second');
 assert.deepEqual(editor.document().blocks.map(b=>({bold:b.bold,italic:b.italic,kind:b.kind})),[{bold:true,italic:false,kind:'bullet'},{bold:false,italic:true,kind:'paragraph'}]);
});
test('editor reports selected range mixed/all/none states and reflects applied formatting',async t=>{
 const {root,kit,Event}=fixture(t);const editor=kit.editor({version:2,blocks:[{text:'Hello world',bold:false,italic:false,kind:'paragraph',marks:[{start:0,end:5,bold:true,italic:false}]}]},undefined,undefined,{inlineRanges:true});root.append(editor.element);
 const input=root.querySelector('[data-cy=data-controls-editor]');input.focus=()=>{};input.setSelectionRange=(start,end)=>{input.selectionStart=start;input.selectionEnd=end;};
 editorSelection(input,Event,0,5);assert.deepEqual(formatStates(root),['true','false','false']);
 editorSelection(input,Event,0,8);assert.deepEqual(formatStates(root),['mixed','false','false']);
 editorSelection(input,Event,6,11);assert.deepEqual(formatStates(root),['false','false','false']);
 editorSelection(input,Event,2,2);assert.deepEqual(formatStates(root),['false','false','false'],'collapsed selection reflects existing whole-block toggle semantics');
 editorSelection(input,Event,0,8);root.querySelector('[data-cy=data-controls-italic]').dispatchEvent(new Event('click'));await settle();assert.deepEqual(formatStates(root),['mixed','true','false']);
 assert.equal(input.selectionStart,0);assert.equal(input.selectionEnd,8);assert.equal(editor.document().blocks[0].text,'Hello world');
 root.querySelector('[data-cy=data-controls-list]').dispatchEvent(new Event('click'));await settle();assert.deepEqual(formatStates(root),['mixed','true','true']);
 input.selectionStart=0;input.selectionEnd=0;input.dispatchEvent(new Event('input'));assert.deepEqual(formatStates(root),['false','false','true']);assert.equal(editor.document().blocks[0].text,'Hello world');
});

for(const change of ['navigate','add-block'])test('editor retires detached block controls after '+change,async t=>{
 const {root,kit,Event}=fixture(t);const editor=kit.editor({version:1,blocks:[{text:'first',bold:false,italic:false,kind:'paragraph'},{text:'second',bold:false,italic:true,kind:'paragraph'}]});root.append(editor.element);
 const old=root.querySelector('[data-cy=data-controls-editor-block-0]'),input=root.querySelector('[data-cy=data-controls-editor]');
 if(change==='navigate')root.querySelector('[data-cy=data-controls-editor-block-1]').dispatchEvent(new Event('click'));
 else{root.querySelector('[data-cy=data-controls-add-block]').dispatchEvent(new Event('click'));await settle();}
 input.value='current retained draft';input.dispatchEvent(new Event('input'));const before=editor.document();
 old.dispatchEvent(new Event('click'));assert.equal(input.value,'current retained draft','stale button must not switch the current editing block');assert.deepEqual(editor.document(),before);
 root.querySelector('[data-cy=data-controls-editor-block-0]').dispatchEvent(new Event('click'));assert.equal(input.value,'first','current generation remains navigable');
 root.querySelector('[data-cy=data-controls-editor-block-'+(change==='navigate'?1:2)+']').dispatchEvent(new Event('click'));assert.equal(input.value,'current retained draft');
});

function detailedTable(root,kit){
 const rows=[{id:'a',values:{name:'Alpha'}},{id:'b',values:{name:'Beta'}}];
 const table=kit.table([{key:'name',label:'Name',width:100,visible:true,pinned:false}],rows,{rowHeight:48,height:240,minWidth:100,maxWidth:200,actionWidth:100},row=>{const detail=root.ownerDocument.createElement('p');detail.textContent='Detail '+row.values.name;return detail;});root.append(table.element);return table;
}
for(const transition of ['expand-other','expand-newest','replace'])test('table detail renderer cannot commit retired output after '+transition,t=>{
 const {root,kit,Event}=fixture(t),rows=[{id:'a',values:{name:'Alpha'}},{id:'b',values:{name:'Beta'}}];let table,reentered=false;const visits={};
 table=kit.table([{key:'name',label:'Name',width:100,visible:true,pinned:false}],rows,{rowHeight:48,height:240,minWidth:100,maxWidth:200,actionWidth:100},row=>{
  const draft=root.ownerDocument.createElement('input');draft.value='draft '+row.id+' '+(visits[row.id]=(visits[row.id]??0)+1);
  if(row.id==='a'&&!reentered){
   reentered=true;
   if(transition==='replace')table.replace([rows[1]]);
   else{root.querySelector('[data-cy=data-controls-expand-b]').dispatchEvent(new Event('click'));if(transition==='expand-newest')root.querySelector('[data-cy=data-controls-expand-a]').dispatchEvent(new Event('click'));}
  }
  return draft;
 });root.append(table.element);
 root.querySelector('[data-cy=data-controls-expand-a]').dispatchEvent(new Event('click'));
 const details=root.querySelector('[data-cy=data-controls-table-detail]');
 assert.equal(table.model.expanded,transition==='expand-other'?'b':transition==='expand-newest'?'a':null);
 assert.equal(details.firstElementChild?.value,transition==='expand-other'?'draft b 1':transition==='expand-newest'?'draft a 2':undefined,'retired renderer must not replace current or removed-row detail');
 assert.equal(root.querySelector('[data-cy=data-controls-expand-b]').getAttribute('aria-expanded'),String(transition==='expand-other'));
});
test('table refresh preserves expanded detail drafts and selection while refreshing grid values',t=>{
 const {root,kit,Event}=fixture(t),table=detailedTable(root,kit);
 root.querySelector('[data-cy=data-controls-expand-a]').dispatchEvent(new Event('click'));table.model.toggle('a');
 const details=root.querySelector('[data-cy=data-controls-table-detail]'),retained=details.firstElementChild,draft=root.ownerDocument.createElement('input');draft.value='unsaved detail draft';retained.append(draft);
 table.replace([{id:'a',values:{name:'Updated Alpha'}},{id:'b',values:{name:'Updated Beta'}}]);
 assert.equal(table.model.expanded,'a');assert.deepEqual([...table.model.selected],['a']);
 assert.equal(root.querySelector('[data-cy=data-controls-expand-a]').getAttribute('aria-expanded'),'true');
 assert.ok(details.firstElementChild===retained,'expanded detail subtree must retain identity');assert.equal(draft.value,'unsaved detail draft');assert.equal(root.querySelector('[data-cy=data-controls-table-cell-a-name]').textContent,'Updated Alpha');
 assert.equal(root.querySelector('[data-cy=data-controls-select-row-a]').checked,true);
 root.querySelector('[data-cy=data-controls-expand-a]').dispatchEvent(new Event('click'));root.querySelector('[data-cy=data-controls-expand-a]').dispatchEvent(new Event('click'));assert.equal(details.textContent,'Detail Updated Alpha','explicit reopening uses replacement row data');
});
test('table refresh clears removed detail identity and rejected refresh preserves current detail',t=>{
 const {root,kit,Event}=fixture(t),table=detailedTable(root,kit);
 root.querySelector('[data-cy=data-controls-expand-a]').dispatchEvent(new Event('click'));table.model.toggle('a');
 assert.throws(()=>table.replace([{id:'dup',values:{}},{id:'dup',values:{}}]));
 assert.equal(table.model.expanded,'a');assert.deepEqual([...table.model.selected],['a']);assert.equal(root.querySelector('[data-cy=data-controls-table-detail]').textContent,'Detail Alpha');
 table.replace([{id:'b',values:{name:'Retained Beta'}}]);assert.equal(table.model.expanded,null);assert.equal(table.model.selected.size,0);assert.equal(root.querySelector('[data-cy=data-controls-table-detail]').textContent,'');assert.equal(root.querySelector('[data-cy=data-controls-expand-b]').getAttribute('aria-expanded'),'false');
});

for(const mode of ['pointer','keyboard'])test('autocomplete owns accepted option identity after provider mutation via '+mode,async t=>{
 const {root,kit,Event}=fixture(t),selected=[],options=[{value:'original',label:'Original label'}];
 root.append(kit.autocomplete(async()=>options,value=>selected.push(value)));const input=root.querySelector('[role=combobox]');input.value='Original';input.dispatchEvent(new Event('input'));await settle();
 options[0].value='changed-after-render';options[0].label='Changed after render';options.push({value:'unrendered',label:'Unrendered option'});
 assert.equal(root.querySelector('[role=option]').textContent,'Original label');
 if(mode==='pointer')root.querySelector('[role=option]').dispatchEvent(new Event('pointerdown',{cancelable:true}));
 else{for(const value of ['ArrowDown','Enter']){const event=new Event('keydown',{cancelable:true});event.key=value;input.dispatchEvent(event);}}
 assert.deepEqual(selected,['original']);assert.equal(input.value,'Original label');
});
test('autocomplete keyboard reopening retains accepted options after provider clears its array',async t=>{
 const {root,kit,Event}=fixture(t),selected=[],options=[{value:'original',label:'Original label'}];root.append(kit.autocomplete(async()=>options,value=>selected.push(value)));const input=root.querySelector('[role=combobox]');input.dispatchEvent(new Event('input'));await settle();options.length=0;
 for(const value of ['Escape','ArrowDown','Enter']){const event=new Event('keydown',{cancelable:true});event.key=value;input.dispatchEvent(event);}
 assert.deepEqual(selected,['original']);assert.equal(input.value,'Original label');
});

test('autocomplete does not dispatch replacement load after abort cleanup disposes scope',async t=>{
 const {root,kit,Event}=fixture(t),queries=[];let finish;
 root.append(kit.autocomplete((query,signal)=>{queries.push(query);if(query==='first'){signal.addEventListener('abort',()=>kit.dispose(),{once:true});return new Promise(resolve=>finish=resolve);}return Promise.resolve([{value:query,label:query}]);}));
 const input=root.querySelector('[role=combobox]');input.value='first';input.dispatchEvent(new Event('input'));input.value='replacement';input.dispatchEvent(new Event('input'));await settle();
 assert.deepEqual(queries,['first']);assert.equal(root.childElementCount,0);finish([{value:'late',label:'Late'}]);await settle();assert.equal(root.childElementCount,0);
});
test('autocomplete lets a query started by abort cleanup own the latest request',async t=>{
 const {root,kit,Event}=fixture(t),queries=[],selected=[];let input,finish;
 root.append(kit.autocomplete((query,signal)=>{queries.push(query);if(query==='first'){signal.addEventListener('abort',()=>{input.value='newer';input.dispatchEvent(new Event('input'));},{once:true});return new Promise(resolve=>finish=resolve);}return Promise.resolve([{value:query,label:query+' label'}]);},value=>selected.push(value)));
 input=root.querySelector('[role=combobox]');input.value='first';input.dispatchEvent(new Event('input'));input.value='superseded';input.dispatchEvent(new Event('input'));await settle();
 assert.deepEqual(queries,['first','newer']);assert.equal(root.querySelector('[role=option]').textContent,'newer label');root.querySelector('[role=option]').dispatchEvent(new Event('pointerdown'));assert.deepEqual(selected,['newer']);finish([{value:'late',label:'Late'}]);await settle();assert.equal(input.value,'newer label');
});
for(const mode of ['Escape','blur'])test('autocomplete dismissal does not invalidate a query started by '+mode+' abort cleanup',async t=>{
 const {root,kit,Event}=fixture(t);let input,finish;
 root.append(kit.autocomplete((query,signal)=>{if(query==='first'){signal.addEventListener('abort',()=>{input.value='newer';input.dispatchEvent(new Event('input'));},{once:true});return new Promise(resolve=>finish=resolve);}return Promise.resolve([{value:query,label:query+' label'}]);}));
 input=root.querySelector('[role=combobox]');input.value='first';input.dispatchEvent(new Event('input'));
 if(mode==='blur')input.dispatchEvent(new Event('blur'));else{const event=new Event('keydown');event.key=mode;input.dispatchEvent(event);}
 await settle();assert.equal(root.querySelector('[role=listbox]').hidden,false);assert.equal(root.querySelector('[role=option]').textContent,'newer label');assert.equal(input.value,'newer');finish([{value:'late',label:'Late'}]);await settle();assert.equal(root.querySelector('[role=option]').textContent,'newer label');
});

function maskSelectionFixture(input){
 let value=input.value;
 Object.defineProperty(input,'value',{configurable:true,get:()=>value,set:next=>{const changed=value!==String(next);value=String(next);if(changed){input.selectionStart=input.selectionEnd=value.length;input.selectionDirection='none';}}});
 input.setSelectionRange=(start,end,direction='none')=>{input.selectionStart=start;input.selectionEnd=end;input.selectionDirection=direction;};
}
test('mask retains selection when formatted text is unchanged',t=>{
 const {root,kit,Event}=fixture(t),field=kit.field('mask',{pattern:'###-###'},'123-456');root.append(field.element);maskSelectionFixture(field.input);field.input.setSelectionRange(2,2);field.input.dispatchEvent(new Event('input'));
 assert.equal(field.input.selectionStart,2);assert.equal(field.input.selectionEnd,2);assert.equal(field.input.value,'123-456');assert.equal(field.input.getAttribute('aria-invalid'),'false');
});
for(const range of [{start:2,end:2,direction:'none',mappedStart:2,mappedEnd:2},{start:2,end:5,direction:'backward',mappedStart:2,mappedEnd:5}])test('mask rebases '+range.direction+' selection through cleaned text',t=>{
 const {root,kit,Event}=fixture(t),field=kit.field('mask',{pattern:'###-###'});root.append(field.element);maskSelectionFixture(field.input);field.input.value='12x3456';field.input.setSelectionRange(range.start,range.end,range.direction);field.input.dispatchEvent(new Event('input'));
 assert.equal(field.input.value,'123-456');assert.equal(field.input.selectionStart,range.mappedStart);assert.equal(field.input.selectionEnd,range.mappedEnd);assert.equal(field.input.selectionDirection,range.direction);assert.equal(field.input.getAttribute('aria-invalid'),'false');
});

for(const hidden of ['middle','last'])test('table retains a keyboard entry cell after hiding '+hidden+' column',t=>{
 const {root,kit,Event}=fixture(t),columns=['first','middle','last'].map(key=>({key,label:key,width:100,visible:true,pinned:false}));
 const table=kit.table(columns,[{id:'r0',values:{first:'A',middle:'B',last:'C'}}],{rowHeight:48,height:240,minWidth:100,maxWidth:200,actionWidth:100});root.append(table.element);table.model.toggle('r0');
 root.querySelector('[data-cy=data-controls-table-cell-r0-last]').dispatchEvent(new Event('focus'));
 const toggle=root.querySelector('[data-cy=data-controls-visible-'+hidden+']');toggle.checked=false;toggle.dispatchEvent(new Event('change'));
 const current=root.querySelectorAll('[role=gridcell][tabindex="0"]');assert.equal(current.length,1);assert.equal(current[0].dataset.cy,'data-controls-table-cell-r0-'+(hidden==='middle'?'last':'middle'));assert.equal(table.model.selected.has('r0'),true);
});

for(const count of [1,2,3])test('autocomplete ArrowUp starts at last option and wraps for '+count+' choices',async t=>{
 const {root,kit,Event}=fixture(t),selected=[],options=Array.from({length:count},(_,index)=>({value:'v'+index,label:'Option '+index}));root.append(kit.autocomplete(async()=>options,value=>selected.push(value)));
 const input=root.querySelector('[role=combobox]');input.dispatchEvent(new Event('input'));await settle();
 const key=value=>{const event=new Event('keydown',{cancelable:true});event.key=value;input.dispatchEvent(event);};const active=()=>input.getAttribute('aria-activedescendant');
 key('ArrowUp');assert.equal(active(),'data-controls-options-'+(count-1));assert.equal(root.querySelectorAll('[role=option][aria-selected=true]').length,1);
 key('ArrowDown');assert.equal(active(),'data-controls-options-0');key('ArrowUp');assert.equal(active(),'data-controls-options-'+(count-1));key('Enter');assert.deepEqual(selected,['v'+(count-1)]);assert.equal(input.value,'Option '+(count-1));
});

test('virtual table keeps one visible keyboard entry while scrolling beyond remembered row',t=>{
 const {root,kit,Event}=fixture(t),table=kit.table([{key:'name',label:'Name',width:100,visible:true,pinned:false}],Array.from({length:1000},(_,index)=>({id:'r'+index,values:{name:'Row '+index}})),{rowHeight:48,height:240,minWidth:100,maxWidth:200,actionWidth:100,pageSize:1000});root.append(table.element);table.model.toggle('r0');const viewport=root.querySelector('[data-cy=data-controls-table-viewport]');
 for(const offset of [480,24000,0]){viewport.scrollTop=offset;viewport.dispatchEvent(new Event('scroll'));const entries=root.querySelectorAll('[role=gridcell][tabindex="0"]');assert.equal(entries.length,1,'visible rows must retain a keyboard entry at offset '+offset);assert.equal(table.model.selected.has('r0'),true);const rowIndex=Number(entries[0].parentElement.getAttribute('aria-rowindex'))-2;assert.ok(rowIndex>=Math.floor(offset/48)&&rowIndex<Math.ceil((offset+240)/48),'entry must be inside viewport, not just overscan');assert.ok(root.querySelectorAll('[data-cy^="data-controls-table-row-"]').length<=10);}
});
