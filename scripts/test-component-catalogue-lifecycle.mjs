import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';

const built=await build({entryPoints:['packages/primecare_ui/web/component-catalogue.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {PrimeComponentFactory}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const shellBuilt=await build({entryPoints:['packages/primecare_ui/web/shell-utilities.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {ShellUtilitiesView}=await import('data:text/javascript;base64,'+Buffer.from(shellBuilt.outputFiles[0].text).toString('base64'));
const settle=()=>new Promise(resolve=>setImmediate(resolve));
test('button feedback label overrides are validated before reserving control IDs or dispatching',()=>{
 for(const override of [{successKey:'unregistered'},{errorKey:'unregistered'}]){
  const {kit,root}=fixture();let calls=0;try{assert.throws(()=>kit.button('button',()=>{calls++;},override),/Registered label required/);root.append(kit.button('button',()=>{calls++;}));assert.equal(root.querySelectorAll('button').length,1);assert.equal(calls,0);}finally{kit.dispose();}
 }
});
for(const failure of [false,true])test('button feedback captures registered options before caller mutation: '+(failure?'error':'success'),async()=>{
 const {kit,root,Event}=fixture();let finish;const options={successKey:'copied',errorKey:'copyError',disabled:false};
 try{const button=kit.button('button',()=>new Promise((resolve,reject)=>finish=failure?reject:resolve),options);root.append(button);button.dispatchEvent(new Event('click'));await Promise.resolve();options.successKey='success';options.errorKey='actionError';options.disabled=true;finish(failure?Error('denied'):undefined);await settle();
  assert.equal(root.querySelector('[role=status]').textContent,kit.text(failure?'copyError':'copied'));assert.equal(button.disabled,false);
 }finally{kit.dispose();}
});
for(const key of ['dialog','drawer'])test(`late ${key} rejection cannot announce an error in a reopened opening`,async()=>{
 let reject;const f=modalFixture(key,()=>new Promise((_,fail)=>reject=fail));
 try{f.click(f.trigger);await settle();const confirm=f.dialog.querySelector('[data-cy="component-catalogue-confirm-'+key+'"]');f.click(confirm);await Promise.resolve();
  f.click(f.dialog.querySelector('[data-cy="component-catalogue-cancel-'+key+'"]'));await settle();f.click(f.trigger);await settle();
  const retained=f.document.createElement('input');f.dialog.prepend(retained);f.setFocus(retained);reject(Error('old opening failed'));await settle();
  const status=f.dialog.querySelector('[data-cy="component-catalogue-confirm-'+key+'-status"]');assert.equal(status.textContent,'');assert.equal(f.dialog.open,true);assert.equal(f.focus()===retained,true);assert.equal(confirm.disabled,false);
  f.click(confirm);await Promise.resolve();reject(Error('current opening failed'));await settle();assert.equal(status.textContent,f.kit.text('actionError'));assert.equal(confirm.disabled,false);assert.equal(f.dialog.open,true);
 }finally{f.kit.dispose();}
});
test('invalid shared forms focus the first invalid enabled field without submitting or losing drafts',async()=>{
 const {kit,root,Event}=fixture();let submitted=0,focused;
 const first=kit.field('input',{value:'retained draft',required:true}),second=kit.field('multiline',{required:true});
 for(const field of [first.input,second.input]){Object.defineProperty(field,'willValidate',{configurable:true,get:()=>!field.disabled});Object.defineProperty(field,'validity',{configurable:true,get:()=>({valid:!field.required||field.value.length>0})});field.focus=()=>{focused=field;};}
 const form=kit.form([first.element,second.element],async()=>{submitted++;});root.append(form);
 // Only native constraint validation is modeled here; Actions runs real validity/focus.
 form.reportValidity=()=>{let valid=true;for(const field of [first.input,second.input])if(field.willValidate&&!field.validity.valid){valid=false;field.dispatchEvent(new Event('invalid'));}return valid;};
 const submit=form.querySelector('button');
 try{submit.dispatchEvent(new Event('click'));await settle();assert.equal(submitted,0);assert.equal(focused===second.input,true);assert.equal(first.input.value,'retained draft');assert.equal(second.input.getAttribute('aria-invalid'),'true');
  first.input.value='';first.input.dispatchEvent(new Event('input'));submit.dispatchEvent(new Event('click'));await settle();assert.equal(focused===first.input,true);
  first.input.disabled=true;submit.dispatchEvent(new Event('click'));await settle();assert.equal(focused===second.input,true);assert.equal(submitted,0);focused=undefined;form.reportValidity=()=>{kit.dispose();return false;};submit.dispatchEvent(new Event('click'));await settle();assert.equal(focused,undefined,'retired form cannot steal replacement focus');
 }finally{kit.dispose();}
});
test('countdown rechecks disposal after caller clock callbacks before announcing completion',()=>{
 for(const mode of ['timer','factory']){
  const {kit,root}=fixture();let now=0,retire=false,finished=0,timer;const clock=()=>{if(retire){if(mode==='timer')timer.dispose();else kit.dispose();}return now;};
  try{timer=kit.countdown(10000,{now:clock,onFinish:()=>finished++});root.append(timer.element);const value=timer.element.querySelector('[data-cy="component-catalogue-countdown-value"]');assert.equal(value.textContent,'10');retire=true;now=10001;timer.tick();assert.equal(finished,0);assert.equal(value.textContent,'10');}
  finally{kit.dispose();}
 }
});
test('countdown never schedules an interval after its initial clock disposes the factory',()=>{
 const {kit}=fixture();const original=globalThis.setInterval;let intervals=0;globalThis.setInterval=()=>{intervals++;return 0;};
 try{kit.countdown(10000,{now:()=>{kit.dispose();return 0;}});assert.equal(intervals,0);}
 finally{globalThis.setInterval=original;kit.dispose();}
});
test('invalid asyncRegion scope fails synchronously without reserving its ID or starting work',async()=>{
 for(const scope of ['', '  ', 'x'.repeat(1025)]){
  const {kit,root,document}=fixture();let calls=0;const loader=async()=>{calls++;return 'ready';};const render=value=>{const p=document.createElement('p');p.textContent=value;return p;};
  try{assert.throws(()=>kit.asyncRegion('card',scope,loader,render),/invalid_async_scope/);assert.equal(calls,0);assert.equal(root.childElementCount,0);
   const region=kit.asyncRegion('card','corrected',loader,render);root.append(region.element);await settle();assert.equal(calls,1);assert.equal(region.element.textContent,'ready');
  }finally{kit.dispose();}
 }
});
test('invalid dropdown options do not consume the registered ID before corrected construction',()=>{
 for(const options of [[{value:'duplicate',label:'One'},{value:'duplicate',label:'Two'}],Array.from({length:101},(_,i)=>({value:String(i),label:String(i)}))]){
  const {kit,root}=fixture();try{assert.throws(()=>kit.select('select',options,()=>{}),/Invalid selection options/);root.append(kit.select('select',[{value:'valid',label:'Valid'}],()=>{}));assert.equal(root.querySelectorAll('select').length,1);}finally{kit.dispose();}
 }
});
test('oversized menu rejection preserves construction and callback ownership for a valid retry',()=>{
 const {kit,root}=fixture();let calls=0;
 try{assert.throws(()=>kit.menu(Array.from({length:101},(_,i)=>({label:String(i),action:()=>{calls++;}}))),/Bounded menu required/);root.append(kit.menu(Array.from({length:100},(_,i)=>({label:String(i),action:()=>{calls++;}}))));assert.equal(root.querySelectorAll('[role=menuitem]').length,100);assert.equal(calls,0);}
 finally{kit.dispose();}
});
test('asyncRegion reports render errors and recovers without leaking rejected updates',async()=>{
 const {kit,root,document}=fixture();const render=value=>{if(value==='broken')throw Error('renderer');const p=document.createElement('p');p.textContent=value;return p;};
 try{const region=kit.asyncRegion('card','initial',async()=> 'initial',render);root.append(region.element);await settle();
  await region.load('broken',async()=> 'broken');assert.equal(region.element.getAttribute('role'),'alert');assert.equal(region.element.textContent,kit.text('error'));assert.equal(region.element.getAttribute('aria-busy'),null);
  await region.load('recovered',async()=> 'recovered');assert.equal(region.element.textContent,'recovered');assert.equal(region.element.getAttribute('role'),null);
 }finally{kit.dispose();}
});
test('a retired renderer error cannot overwrite newer loading state or disposed content',async()=>{
 for(const mode of ['replace','dispose']){
  const {kit,root,document}=fixture();let region,pending,finish;
  const render=value=>{if(value==='broken'){if(mode==='replace')pending=region.load('newest',()=>new Promise(resolve=>finish=resolve));else{region.dispose();region.element.textContent='retained disposed content';}throw Error('retired renderer');}const p=document.createElement('p');p.textContent=value;return p;};
  try{region=kit.asyncRegion('card','initial',async()=> 'initial',render);root.append(region.element);await settle();await region.load('broken',async()=> 'broken');
   assert.equal(region.element.getAttribute('role'),null);assert.equal(region.element.textContent,mode==='replace'?kit.text('loading'):'retained disposed content');
   if(pending){finish('newest');await pending;assert.equal(region.element.textContent,'newest');}
  }finally{kit.dispose();}
 }
});
test('shared buttons cannot dispatch from outside their owner slot or after queued relocation',async()=>{
 for(const mode of ['detached','moved','queued-move']){
  const {kit,root,document,Event}=fixture();let calls=0;const outside=document.createElement('section');document.body.append(outside);const button=kit.button('button',()=>{calls++;});
  try{if(mode!=='detached')root.append(button);if(mode==='moved')outside.append(button);button.dispatchEvent(new Event('click'));if(mode==='queued-move')outside.append(button);await settle();assert.equal(calls,0,mode+' must skip consumer dispatch');}
  finally{kit.dispose();}
 }
});
test('late button outcomes cannot announce feedback moved outside the owner slot',async()=>{
 for(const failure of [false,true]){
  const {kit,root,document,Event}=fixture();let finish;const button=kit.button('button',()=>new Promise((resolve,reject)=>finish=failure?reject:resolve));root.append(button);
  try{button.dispatchEvent(new Event('click'));await Promise.resolve();const status=root.querySelector('[role=status]'),outside=document.createElement('section');document.body.append(outside);outside.append(status);finish(failure?Error('late'):undefined);await settle();assert.equal(status.textContent,kit.text('loading'));assert.equal(button.disabled,false);}
  finally{kit.dispose();}
 }
});
test('menu trigger arrows open at the enabled edge and skip disabled items',async()=>{
 const {kit,root,document,Event}=fixture();const prior=globalThis.Node;globalThis.Node=document.defaultView.Node;let focused;
 try{root.append(kit.menu([{label:'First',action:()=>{}},{label:'Disabled',disabled:true,action:()=>{}},{label:'Last',action:()=>{}}]));const buttons=[...root.querySelectorAll('button')],trigger=buttons[0];for(const button of buttons)button.focus=()=>{focused=button;};Object.defineProperty(document,'activeElement',{configurable:true,get:()=>focused});
  const key=async name=>{const e=new Event('keydown',{bubbles:true,cancelable:true});e.key=name;(focused??trigger).dispatchEvent(e);await settle();};
  await key('ArrowDown');assert.equal(root.querySelector('[role=menu]').hidden,false);assert.equal(focused,buttons[1]);await key('ArrowDown');assert.equal(focused,buttons[3]);await key('ArrowDown');assert.equal(focused,buttons[1]);focused=trigger;await key('ArrowUp');assert.equal(focused,buttons[3]);
  await key('Escape');assert.equal(focused,trigger);await key('ArrowUp');assert.equal(focused,buttons[3]);
 }finally{if(prior===undefined)delete globalThis.Node;else globalThis.Node=prior;kit.dispose();}
});
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

for(const kind of ['select','checkbox','switch','radio'])test('retired '+kind+' control cannot dispatch outside its factory root',()=>{const {kit,root,Event}=fixture();let calls=0;const row=kind==='select'?kit.select('select',[{value:'a',label:'A'}],()=>calls++):kind==='radio'?kit.radio([{value:'a',label:'A'}],'',()=>calls++):kit.boolean(kind,false,()=>calls++);root.append(row);const input=row.querySelector('input,select');if(kind!=='select')input.checked=true;try{row.remove();input.dispatchEvent(new Event('change'));assert.equal(calls,0);root.append(row);input.dispatchEvent(new Event('change'));assert.equal(calls,1);}finally{kit.dispose();}});
test('individually disabled radio cannot dispatch while its fieldset remains enabled',()=>{const {kit,root,Event}=fixture();let calls=0;const group=kit.radio([{value:'a',label:'A'}],'',()=>calls++);root.append(group);const input=group.querySelector('input');input.checked=true;try{input.disabled=true;input.dispatchEvent(new Event('change'));assert.equal(calls,0);input.disabled=false;input.dispatchEvent(new Event('change'));assert.equal(calls,1);}finally{kit.dispose();}});
test('radio moved outside its registered group cannot notify that group',()=>{const {kit,root,Event}=fixture();let calls=0;const group=kit.radio([{value:'a',label:'A'}],'',()=>calls++);root.append(group);const input=group.querySelector('input'),label=input.parentElement;input.checked=true;try{root.append(input);input.dispatchEvent(new Event('change'));assert.equal(calls,0);label.prepend(input);input.dispatchEvent(new Event('change'));assert.equal(calls,1);}finally{kit.dispose();}});

for(const afterAppend of [false,true])for(const prior of [null,'caller-marker'])test(`failed factory startup rolls back only its ownership (append=${afterAppend}, marker=${prior})`,async()=>{
 const {document,Event}=parseHTML('<html><head></head><body><main id="root"><input value="retained draft"></main></body></html>'),root=document.getElementById('root'),draft=root.firstElementChild;
 if(prior!==null)root.setAttribute('data-pc-catalogue',prior);
 const original=document.head.append,reason=Error('stylesheet installation failed');document.head.append=function(...nodes){if(afterAppend)original.apply(this,nodes);throw reason;};
 try{assert.throws(()=>new PrimeComponentFactory(root,'failed-startup'),error=>error===reason);}finally{document.head.append=original;}
 assert.equal(root.getAttribute('data-pc-catalogue'),prior);assert.equal(root.firstElementChild===draft,true);assert.equal(draft.value,'retained draft');assert.equal(document.querySelector('[data-pc-catalogue-style]'),null);
 const replacement=new PrimeComponentFactory(root,'corrected-startup');let calls=0;
 try{const button=replacement.button('button',()=>{calls++;});root.append(button);button.dispatchEvent(new Event('click'));await settle();assert.equal(calls,1);assert.equal(document.querySelectorAll('[data-pc-catalogue-style]').length,1);assert.throws(()=>new PrimeComponentFactory(root,'duplicate-owner'),/Distinct scoped/);assert.equal(root.firstElementChild===draft,true);}finally{replacement.dispose();}
});
test('failed factory startup never removes an existing shared stylesheet',()=>{
 const {document}=parseHTML('<html><head><style data-pc-catalogue-style>existing shared rules</style></head><body><main></main></body></html>'),root=document.querySelector('main'),style=document.querySelector('style'),query=document.querySelector,reason=Error('style lookup failed');root.dataset.pcCatalogue='caller-marker';
 document.querySelector=function(selector){if(selector==='[data-pc-catalogue-style]')throw reason;return query.call(this,selector);};
 try{assert.throws(()=>new PrimeComponentFactory(root,'failed-lookup'),error=>error===reason);}finally{document.querySelector=query;}
 assert.equal(root.dataset.pcCatalogue,'caller-marker');assert.equal(style.parentElement===document.head,true);assert.equal(style.textContent,'existing shared rules');const replacement=new PrimeComponentFactory(root,'lookup-retry');replacement.dispose();assert.equal(style.parentElement===document.head,true);
});

for(const failure of [Error('dialog close'),null,undefined])test('catalogue closes every dialog and timer after cleanup failure '+String(failure),()=>{const {kit,root}=fixture();let dialogs=0,timers=0;root.textContent='Private catalogue';kit.dialogs.add({close(){throw failure;}});kit.dialogs.add({close(){dialogs++;}});kit.timers.add(()=>timers++);let caught=false;try{kit.dispose();}catch(error){caught=true;assert.equal(error,failure);}assert.equal(caught,true);assert.equal(dialogs,1);assert.equal(timers,1);assert.equal(kit.dialogs.size,0);assert.equal(kit.timers.size,0);assert.equal(root.childNodes.length,0);assert.equal(root.hasAttribute('data-pc-catalogue'),false);const next=new PrimeComponentFactory(root,'replacement');root.textContent='Replacement';kit.dispose();assert.equal(root.textContent,'Replacement');next.dispose();});
