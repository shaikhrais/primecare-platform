import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';

const built=await build({entryPoints:['packages/primecare_ui/web/component-catalogue.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {PrimeComponentFactory}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const shellBuilt=await build({entryPoints:['packages/primecare_ui/web/shell-utilities.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {ShellUtilitiesView}=await import('data:text/javascript;base64,'+Buffer.from(shellBuilt.outputFiles[0].text).toString('base64'));
const settle=()=>new Promise(resolve=>setImmediate(resolve));
test('tab selection keeps rendered keys stable when caller entries are mutated',async()=>{
 const {kit,root,document,Event}=fixture();const items=[{key:'tabOne',content:document.createElement('p')},{key:'tabTwo',content:document.createElement('p')}];
 try{root.append(kit.tabs(items));items[0].key='tabTwo';items.splice(0);root.querySelector('[data-cy=component-catalogue-tab-two]').dispatchEvent(new Event('click'));await settle();
  assert.equal(root.querySelectorAll('[role=tab][aria-selected=true]').length,1);assert.equal(root.querySelector('[data-cy=component-catalogue-tab-one]').getAttribute('aria-selected'),'false');assert.equal(root.querySelector('[data-cy=component-catalogue-tab-two]').getAttribute('aria-selected'),'true');
 }finally{kit.dispose();}
});
test('tab keyboard navigation keeps the rendered disabled state despite caller mutation',()=>{
 const {kit,root,document,Event}=fixture();const items=[{key:'tabOne',content:document.createElement('p'),disabled:true},{key:'tabTwo',content:document.createElement('p')}];const prior=globalThis.getComputedStyle;globalThis.getComputedStyle=()=>({direction:'ltr'});
 try{root.append(kit.tabs(items));const first=root.querySelector('[data-cy=component-catalogue-tab-one]'),second=root.querySelector('[data-cy=component-catalogue-tab-two]');first.focus=()=>{};second.focus=()=>{};items[0].disabled=false;
  const event=new Event('keydown',{bubbles:true});event.key='Home';second.dispatchEvent(event);
  assert.equal(first.disabled,true);assert.equal(first.getAttribute('aria-selected'),'false');assert.equal(second.getAttribute('aria-selected'),'true');
 }finally{if(prior===undefined)delete globalThis.getComputedStyle;else globalThis.getComputedStyle=prior;kit.dispose();}
});
test('radio callbacks retain the value associated with the rendered option label',()=>{
 const {kit,root,Event}=fixture();const options=[{value:'original',label:'Original choice'}];let selected;
 try{root.append(kit.radio(options,'',value=>selected=value));const input=root.querySelector('input');options[0].value='mutated';options[0].label='Different choice';options.splice(0);input.checked=true;input.dispatchEvent(new Event('change'));
  assert.equal(input.value,'original');assert.equal(selected,'original');assert.equal(root.textContent.includes('Original choice'),true);
 }finally{kit.dispose();}
});
test('menu callbacks retain the action associated with the rendered label',async()=>{
 const {kit,root,Event}=fixture();let original=0,mutated=0;const items=[{label:'Original action',action:()=>{original++;}}];
 try{const menu=kit.menu(items);root.append(menu);menu.querySelector('button').focus=()=>{};const item=menu.querySelector('[role=menuitem]');items[0].action=()=>{mutated++;};items[0].label='Different action';items.splice(0);item.dispatchEvent(new Event('click'));await settle();
  assert.equal(original,1);assert.equal(mutated,0);assert.equal(item.textContent,'Original action');
 }finally{kit.dispose();}
});
test('asyncRegion ignores a rendered node after its callback starts a newer load or disposes the region',async()=>{
 for(const mode of ['replace','dispose']){
  const {kit,root,document}=fixture();let region,replacement,finish,retired;
  const render=value=>{const node=document.createElement('p');node.textContent=value;if(value==='retired'){retired=node;if(mode==='replace')replacement=region.load('newest',()=>new Promise(resolve=>finish=resolve));else region.dispose();}return node;};
  try{
   region=kit.asyncRegion('card','initial',async()=> 'initial',render);root.append(region.element);await settle();await region.load('retired',async()=> 'retired');
   assert.equal(retired.parentElement===null,true,'superseded render output must never be attached');
   if(mode==='replace'){assert.equal(region.element.textContent,kit.text('loading'));assert.equal(region.element.getAttribute('aria-busy'),'true');finish('newest content');await replacement;assert.equal(region.element.textContent,'newest content');assert.equal(region.element.getAttribute('aria-busy'),null);}
  }finally{kit.dispose();}
 }
});
test('asyncRegion retains the latest scope when abort callbacks replace or dispose an interrupted load',async()=>{
 for(const dispose of [false,true]){
  const {kit,root,document}=fixture();let region,latest,calls=0,signal;
  const render=value=>{const p=document.createElement('p');p.textContent=value;return p;};
  try{
   region=kit.asyncRegion('card','initial',async()=> 'initial',render);root.append(region.element);await settle();
   await region.load('abort-owner',async current=>{current.addEventListener('abort',()=>{if(dispose)region.dispose();else latest=region.load('latest',async current=>{signal=current;return 'latest retained content';});},{once:true});return 'previous content';});
   await region.load('interrupted',async()=>{calls++;return 'stale content';});if(latest)await latest;
   assert.equal(calls,0);assert.equal(region.element.textContent,dispose?'previous content':'latest retained content');assert.equal(region.element.getAttribute('aria-busy'),null);if(signal)assert.equal(signal.aborted,false);
  }finally{kit.dispose();}
 }
});
test('menu awaits consumer actions, serializes activation and reports rejection before retry',async()=>{
 const {kit,root,Event}=fixture();let calls=0,finish,fail,focused;
 const menu=kit.menu([{label:'Save draft',action:()=>{calls++;const pending=new Promise((resolve,reject)=>{finish=resolve;fail=reject;});pending.catch(()=>{});return pending;}}]);root.append(menu);
 const trigger=menu.querySelector('button'),item=menu.querySelector('[role=menuitem]');trigger.focus=()=>{focused=trigger;};
 const click=button=>button.dispatchEvent(new Event('click'));
 try{
  click(trigger);await settle();click(item);click(item);await settle();
  assert.equal(calls,1);assert.equal(item.disabled,true,'pending consumer action stays busy');assert.equal(item.getAttribute('aria-busy'),'true');
  assert.equal(menu.querySelector('[role=menu]').hidden,true);assert.equal(focused,trigger);
  const status=menu.querySelector('[data-cy="'+item.dataset.cy+'-status"]');assert.equal(status.textContent,kit.text('loading'));assert.equal(status.parentElement,menu,'action feedback remains outside the hidden menu');assert.equal(status.getAttribute('aria-label'),'Save draft');
  fail(Error('denied'));await settle();assert.equal(item.disabled,false);assert.equal(item.getAttribute('aria-busy'),null);assert.equal(status.textContent,kit.text('actionError'));
  click(trigger);await settle();click(item);await settle();assert.equal(calls,2);assert.equal(status.textContent,kit.text('loading'));finish();await settle();assert.equal(status.textContent,kit.text('success'));assert.equal(item.disabled,false);
 }finally{kit.dispose();}
});
test('late menu action outcomes cannot change feedback or focus after ownership disposal',async()=>{
 for(const failure of [false,true]){
  const {kit,root,Event}=fixture();let finish,focusMoves=0;
  const menu=kit.menu([{label:'Save draft',action:()=>new Promise((resolve,reject)=>{finish=failure?reject:resolve;})}]);root.append(menu);
  menu.querySelector('button').focus=()=>{focusMoves++;};const item=menu.querySelector('[role=menuitem]');item.dispatchEvent(new Event('click'));await Promise.resolve();
  const status=menu.querySelector('[data-cy="'+item.dataset.cy+'-status"]');kit.dispose();const replacement=new PrimeComponentFactory(root,'replacement-menu');root.textContent='Retained replacement draft';const moves=focusMoves;
  finish(failure?Error('late'):undefined);await settle();assert.equal(root.textContent,'Retained replacement draft');assert.equal(status.textContent,kit.text('loading'));assert.equal(focusMoves,moves);replacement.dispose();
 }
});
function fixture(){
 const {document,Event}=parseHTML('<html><head></head><body><main id="root"></main></body></html>');
 const root=document.getElementById('root');
 return {document,Event,root,kit:new PrimeComponentFactory(root,'lifecycle-test')};
}
test('disposed catalogue skips a queued action and cannot write into a replacement owner',async()=>{
 const {kit,root,Event}=fixture();let calls=0;
 const button=kit.button('button',()=>{calls++;});root.append(button);
 button.dispatchEvent(new Event('click'));kit.dispose();
 const replacement=new PrimeComponentFactory(root,'replacement');root.textContent='new owner';
 await settle();assert.equal(calls,0);assert.equal(root.textContent,'new owner');replacement.dispose();
});
test('live catalogue serializes clicks, reports rejection and permits retry',async()=>{
 const {kit,root,Event}=fixture();let calls=0,reject;
 const button=kit.button('button',()=>{calls++;return new Promise((_,fail)=>reject=fail);});root.append(button);
 try{
  button.dispatchEvent(new Event('click'));button.dispatchEvent(new Event('click'));
  await Promise.resolve();assert.equal(calls,1);assert.equal(button.disabled,true);
  reject(Error('unavailable'));await settle();assert.equal(button.disabled,false);
  assert.equal(root.querySelector('[role=status]').textContent,kit.text('actionError'));
  button.dispatchEvent(new Event('click'));await Promise.resolve();assert.equal(calls,2);
  reject(Error('unavailable'));await settle();
 }finally{kit.dispose();}
});
test('late catalogue completion cannot mutate a replacement owner',async()=>{
 for(const failure of [false,true]){
  const {kit,root,Event}=fixture();let finish;
  const button=kit.button('button',()=>new Promise((resolve,reject)=>finish=failure?reject:resolve));root.append(button);
  button.dispatchEvent(new Event('click'));await Promise.resolve();kit.dispose();
  const replacement=new PrimeComponentFactory(root,'replacement');root.textContent='retained';
  finish(failure?Error('late'):undefined);await settle();assert.equal(root.textContent,'retained');replacement.dispose();
 }
});
function shellButtonFixture(){
 const {document,Event}=parseHTML('<html><body><main></main></body></html>');
 const view=Object.create(ShellUtilitiesView.prototype);let renders=0;
 Object.assign(view,{root:document.querySelector('main'),abort:new AbortController(),dead:false,error:false,ids:{open:'shell-open'},labels:{open:'Open'},render:()=>renders++});
 return {view,Event,renders:()=>renders};
}
test('shared shell button skips disposed queued actions and disabled controls',async()=>{
 for(const mode of ['disposed','disabled']){
  const {view,Event}=shellButtonFixture();let calls=0;
  const button=view.button('open',()=>{calls++;});
  if(mode==='disabled')button.disabled=true;
  button.dispatchEvent(new Event('click'));if(mode==='disposed'){view.dead=true;view.abort.abort();}
  await settle();assert.equal(calls,0);
 }
});
test('shared shell button executes live actions and suppresses late error rendering',async()=>{
 const {view,Event,renders}=shellButtonFixture();let calls=0,reject;
 const button=view.button('open',()=>{calls++;return new Promise((_,fail)=>reject=fail);});
 button.dispatchEvent(new Event('click'));await Promise.resolve();assert.equal(calls,1);
 reject(Error('live'));await settle();assert.equal(view.error,true);assert.equal(renders(),1);
 button.dispatchEvent(new Event('click'));await Promise.resolve();view.dead=true;view.abort.abort();
 reject(Error('late'));await settle();assert.equal(renders(),1);
});
test('individual countdown disposal blocks explicit and visibility ticks',()=>{
 const {kit,root,document,Event}=fixture();let now=0,finished=0;
 try {
  const timer=kit.countdown(10000,{now:()=>now,onFinish:()=>finished++});root.append(timer.element);
  assert.equal(root.querySelector('[data-cy="component-catalogue-countdown-value"]').textContent,'10');
  timer.dispose();timer.dispose();now=10001;timer.tick();document.dispatchEvent(new Event('visibilitychange'));
  assert.equal(finished,0);
  assert.equal(root.querySelector('[data-cy="component-catalogue-countdown-value"]').textContent,'10');
 } finally {kit.dispose();}
});
test('async retry clears old alert semantics while retaining busy and recovery states',async()=>{
 const {kit,root}=fixture();let finish;
 const text=value=>{const p=root.ownerDocument.createElement('p');p.textContent=value;return p;};
 try {
  const region=kit.asyncRegion('card','initial',async()=>{throw Error('unavailable');},text);root.append(region.element);
  await region.load('failed',async()=>{throw Error('unavailable');});
  assert.equal(region.element.getAttribute('role'),'alert');
  const retry=region.load('retry',()=>new Promise(resolve=>finish=resolve));
  assert.equal(region.element.getAttribute('aria-busy'),'true');
  assert.equal(region.element.getAttribute('role'),null);
  finish('recovered');await retry;
  assert.equal(region.element.textContent,'recovered');
  assert.equal(region.element.getAttribute('aria-busy'),null);
 } finally {kit.dispose();}
});


test('all-disabled shared tabs expose no selected panel and retain caller content',()=>{
 const {kit,root,document}=fixture();const one=document.createElement('p'),two=document.createElement('p');one.textContent='First retained content';two.textContent='Second retained content';
 try{root.append(kit.tabs([{key:'tabOne',content:one,disabled:true},{key:'tabTwo',content:two,disabled:true}]));
  for(const tab of root.querySelectorAll('[role=tab]')){assert.equal(tab.disabled,true);assert.equal(tab.getAttribute('aria-selected'),'false');assert.equal(tab.tabIndex,-1);}
  for(const panel of root.querySelectorAll('[role=tabpanel]'))assert.equal(panel.hidden,true);
  assert.equal(one.textContent,'First retained content');assert.equal(two.textContent,'Second retained content');assert.equal(one.parentElement.getAttribute('role'),'tabpanel');
 }finally{kit.dispose();}
});
test('shared tabs skip a disabled first item and preserve active-panel relationships',()=>{
 const {kit,root,document}=fixture();const one=document.createElement('p'),two=document.createElement('p');
 try{root.append(kit.tabs([{key:'tabOne',content:one,disabled:true},{key:'tabTwo',content:two}]));
  const tabs=[...root.querySelectorAll('[role=tab]')],panels=[...root.querySelectorAll('[role=tabpanel]')];assert.equal(tabs[0].getAttribute('aria-selected'),'false');assert.equal(tabs[1].getAttribute('aria-selected'),'true');assert.equal(panels[0].hidden,true);assert.equal(panels[1].hidden,false);
  for(let i=0;i<2;i++){assert.equal(tabs[i].getAttribute('aria-controls'),panels[i].id);assert.equal(panels[i].getAttribute('aria-labelledby'),tabs[i].id);}
 }finally{kit.dispose();}
});

test('tooltip keeps help visible while either keyboard focus or pointer hover remains',()=>{
 const {kit,root,Event}=fixture();root.append(kit.tooltip('Retained help'));const trigger=root.querySelector('[data-cy=component-catalogue-tooltip-trigger]'),tip=root.querySelector('[role=tooltip]');
 const fire=name=>trigger.dispatchEvent(new Event(name));
 try{fire('focus');fire('pointerenter');fire('pointerleave');assert.equal(tip.hidden,false,'keyboard focus must survive pointer departure');fire('blur');assert.equal(tip.hidden,true);
  fire('pointerenter');fire('focus');fire('blur');assert.equal(tip.hidden,false,'pointer hover must survive keyboard blur');fire('pointerleave');assert.equal(tip.hidden,true);
 }finally{kit.dispose();}
});
test('Escape dismisses tooltip until a new interaction without focus or pointer departure reopening it',()=>{
 const {kit,root,Event}=fixture();root.append(kit.tooltip('Dismissible help'));const trigger=root.querySelector('[data-cy=component-catalogue-tooltip-trigger]'),tip=root.querySelector('[role=tooltip]');const fire=name=>trigger.dispatchEvent(new Event(name));
 try{fire('focus');fire('pointerenter');const escape=new Event('keydown');escape.key='Escape';trigger.dispatchEvent(escape);assert.equal(tip.hidden,true);fire('pointerleave');assert.equal(tip.hidden,true);fire('blur');assert.equal(tip.hidden,true);fire('focus');assert.equal(tip.hidden,false);}finally{kit.dispose();}
});

function modalFixture(key,confirm){
 const f=fixture();const group=f.kit.modal(key,f.document.createElement('p'),confirm);f.root.append(group);
 const dialog=group.querySelector('dialog'),trigger=group.querySelector('button');let focused=null,closes=0;
 // Model only the native dialog/focus boundary; real top-layer behavior runs in Actions.
 dialog.open=false;dialog.showModal=()=>{dialog.open=true;};dialog.close=()=>{dialog.open=false;closes++;};
 trigger.focus=()=>{focused=trigger;};
 return {...f,dialog,trigger,closes:()=>closes,focus:()=>focused,setFocus:value=>{focused=value;},click:button=>button.dispatchEvent(new f.Event('click'))};
}
for(const key of ['dialog','drawer'])test(`late ${key} confirmation cannot close or refocus a reopened opening`,async()=>{
 let finish,calls=0;const f=modalFixture(key,()=>{calls++;return new Promise(resolve=>finish=resolve);});
 try{
  f.click(f.trigger);await settle();const confirm=f.dialog.querySelector('[data-cy="component-catalogue-confirm-'+key+'"]');
  f.click(confirm);await Promise.resolve();assert.equal(calls,1);
  f.click(f.dialog.querySelector('[data-cy="component-catalogue-cancel-'+key+'"]'));await settle();assert.equal(f.dialog.open,false);
  f.click(f.trigger);await settle();const retainedFocus=f.document.createElement('input');f.dialog.prepend(retainedFocus);f.setFocus(retainedFocus);
  finish();await settle();assert.equal(f.dialog.open,true,'old confirmation must leave the current opening visible');assert.equal(f.focus()===retainedFocus,true,'old confirmation must not restore trigger focus');assert.equal(f.closes(),1);assert.equal(confirm.disabled,false);
  f.click(confirm);await Promise.resolve();assert.equal(calls,2);finish();await settle();assert.equal(f.dialog.open,false);assert.equal(f.focus()===f.trigger,true);assert.equal(f.closes(),2);
 }finally{f.kit.dispose();}
});
test('cancelled and disposed modal confirmations cannot close again or move replacement focus',async()=>{
 for(const mode of ['cancelled','disposed']){
  let finish;const f=modalFixture('dialog',()=>new Promise(resolve=>finish=resolve));
  try{f.click(f.trigger);await settle();f.click(f.dialog.querySelector('[data-cy="component-catalogue-confirm-dialog"]'));await Promise.resolve();
   if(mode==='cancelled'){f.click(f.dialog.querySelector('[data-cy="component-catalogue-cancel-dialog"]'));await settle();}else f.kit.dispose();
   const outside=f.document.createElement('input');f.setFocus(outside);const closes=f.closes();finish();await settle();assert.equal(f.closes(),closes);assert.equal(f.focus()===outside,true);
  }finally{f.kit.dispose();}
 }
});
