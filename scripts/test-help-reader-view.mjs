/** Synthetic metadata/transport and a DOM model only; not live registrations or browser acceptance. */
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';

const built=await build({stdin:{contents:"export {HelpReaderView} from './packages/primecare_ui/web/help-reader';export {PrimeComponentFactory,catalogueRegistration} from './packages/primecare_ui/web/component-catalogue';export {createHelpReaderSession} from './packages/shared/src/help-reader/session';",resolveDir:process.cwd(),loader:'ts'},bundle:true,platform:'node',format:'esm',write:false});
const {HelpReaderView,PrimeComponentFactory,catalogueRegistration,createHelpReaderSession}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text+'\n//# sourceURL=help-reader-view-fixture.mjs').toString('base64'));
const keys=['start','search','locale','previous','next','back','retry','article','open','idle','loading','empty','error','retired'];
const locales=['en','fr','es'];
const bindings=Object.fromEntries(keys.map(key=>[key,'help.'+key]));
const kind=key=>key==='search'?'prime_text_field':key==='locale'?'prime_dropdown_web':['article','idle','loading','empty','error','retired'].includes(key)?'prime_card':'prime_button';
function metadata(){return{kind:'verified_metadata_export',controls:keys.map((key,index)=>({key:bindings[key],testId:'fixture-help-'+key,controlId:index+1,componentCode:kind(key)})),locales:Object.fromEntries(locales.map(locale=>[locale,Object.fromEntries(keys.map(key=>[bindings[key],locale+' '+key]))]))};}
const names=locale=>Object.fromEntries(locales.map(language=>[language,locale+' '+language]));
function dom(){
 const {document,window,Event}=parseHTML('<html><head></head><body><input id="outside"><main id="root"></main></body></html>');
 const descriptor=Object.getOwnPropertyDescriptor(window.HTMLSelectElement.prototype,'value');
 // Model only the standard select.value setter absent from Linkedom; Actions uses Chromium.
 if(!descriptor?.set)Object.defineProperty(window.HTMLSelectElement.prototype,'value',{configurable:true,get:descriptor.get,set(value){for(const option of this.options)option.removeAttribute('selected');[...this.options].find(option=>option.value===value)?.setAttribute('selected','');}});
 return{document,Event,root:document.getElementById('root')};
}
const settle=()=>new Promise(resolve=>setImmediate(resolve));
async function until(test){for(let i=0;i<40;i++){if(test())return;await settle();}assert.fail('Expected fixture state was not reached');}
function fixture(initial='en',limit=1){
 const d=dom(),commands=[],source=metadata(),scope={tenantId:'tenant-a',userId:'psw-a',role:'psw',dataset:'live'};
 let current=true,status=200,release,hold=false,empty=false;
 const session=createHelpReaderSession({origin:'https://help.example',scope,getToken:()=> 't'.repeat(43),isCurrent:()=>current,fetcher:async(url,init)=>{
  if(url.endsWith('/v1/auth/me'))return Response.json({status:'authenticated',tenantId:scope.tenantId,userId:scope.userId,roles:scope.role});
  const command=JSON.parse(init.body);commands.push(command);if(hold)await new Promise(resolve=>release=resolve);
  if(status!==200)return new Response('PRIVATE provider detail',{status});
  const item={id:'guide-'+command.offset,revision:1,title:command.locale+' Guide '+(command.offset??0),category:'Category',...(command.action==='read'?{id:command.articleId,body:'Plain <script>private body</script>'}:{summary:'Summary'})};
  const items=Array.from({length:Math.min(command.limit??0,3-(command.offset??0))},(_,index)=>({...item,id:'guide-'+(command.offset+index),title:command.locale+' Guide '+(command.offset+index)}));
  return Response.json({version:1,action:command.action,locale:command.locale,scope,...(command.action==='read'?{article:item}:{items:empty?[]:items,offset:command.offset,limit:command.limit,total:empty?0:3})});
 }},{locale:initial,limit});
 const options={session,scope:'fixture-account',metadata:source,bindings:{...bindings},localeNames:names};
 const view=new HelpReaderView(d.root,options);
 const control=(key,suffix='')=>d.root.querySelector('[data-cy="fixture-help-'+key+suffix+'"]');
 return{...d,commands,session,view,source,options,control,setStatus:value=>status=value,setEmpty:value=>empty=value,
  hold(){hold=true;},release(){hold=false;release?.();},retire(){current=false;session.sessionChanged();},
  async click(key,suffix=''){const node=control(key,suffix);assert.ok(node,key);node.dispatchEvent(new d.Event('click'));await settle();},
  async load(){await session.load();},close(){view.dispose();session.dispose();}};
}

test('default catalogue bindings and labels remain equal to the checked-in export',async()=>{
 const source=JSON.parse(await readFile('packages/primecare_ui/catalogs/component-catalogue.registration.json','utf8'));
 for(const locale of locales){const current=catalogueRegistration(locale);assert.deepEqual(current.controls,source.controls);assert.deepEqual(current.labels,source.locales[locale]);}
 const f=dom(),kit=new PrimeComponentFactory(f.root,'default');try{const button=kit.button('button',()=>{});f.root.append(button);assert.equal(button.dataset.cy,'component-catalogue-button');assert.equal(button.textContent,source.locales.en.button);}finally{kit.dispose();}
});

for(const [name,corrupt] of [
 ['unknown kind',m=>m.kind='unapproved'],['inherited kind',m=>{delete m.kind;Object.setPrototypeOf(m,{kind:'verified_metadata_export'});} ],
 ['zero id',m=>m.controls[0].controlId=0],['nonfinite id',m=>m.controls[0].controlId=NaN],['duplicate key',m=>m.controls[1].key=m.controls[0].key],
 ['duplicate id',m=>m.controls[1].controlId=m.controls[0].controlId],['duplicate test id',m=>m.controls[1].testId=m.controls[0].testId],
 ['invalid test id',m=>m.controls[0].testId='<script>'],['unknown component',m=>m.controls[0].componentCode='invented'],
 ['missing locale',m=>delete m.locales.fr],['missing translated control',m=>delete m.locales.es[bindings.open]],['blank translated label',m=>m.locales.fr[bindings.search]=' '],
 ['accessor field',m=>Object.defineProperty(m.controls[0],'key',{get(){throw Error('Must not evaluate metadata accessors');}})],
 ['accessor label',m=>Object.defineProperty(m.locales.en,bindings.open,{get(){throw Error('Must not evaluate label accessors');}})],
])test('caller metadata rejects '+name+' before claiming or changing a slot',()=>{
 const source=metadata();corrupt(source);const f=dom(),draft=f.document.createElement('p');draft.textContent='retained';f.root.append(draft);
 assert.throws(()=>new PrimeComponentFactory(f.root,'invalid','en',source));assert.equal(f.root.firstChild,draft);assert.equal(f.root.hasAttribute('data-pc-catalogue'),false);
 const retry=new PrimeComponentFactory(f.root,'retry');retry.dispose();
});

test('metadata inspection cannot steal ownership acquired reentrantly by another factory',async()=>{
 const f=dom();let inner,entered=false,calls=0;
 const proxy=new Proxy(metadata(),{getOwnPropertyDescriptor(target,key){if(!entered){entered=true;inner=new PrimeComponentFactory(f.root,'inner');f.root.append(inner.button('button',()=>calls++));}return Reflect.getOwnPropertyDescriptor(target,key);}});
 assert.throws(()=>new PrimeComponentFactory(f.root,'outer','en',proxy),/Distinct scoped/);
 f.root.querySelector('button').dispatchEvent(new f.Event('click'));await settle();assert.equal(calls,1);assert.equal(f.root.querySelector('button').dataset.cy,'component-catalogue-button');inner.dispose();
});

for(const suffix of ['-error','-status'])test('metadata rejects declared IDs colliding with derived '+suffix+' identifiers',()=>{
 const source=metadata();source.controls.find(control=>control.key===bindings.next).testId=source.controls.find(control=>control.key===bindings[suffix==='-error'?'search':'start']).testId+suffix;
 const f=dom();assert.throws(()=>new PrimeComponentFactory(f.root,'collision','en',source),/Unverified/);assert.equal(f.root.hasAttribute('data-pc-catalogue'),false);
});

test('generated field identifiers are reserved before detached controls are appended',()=>{
 const f=dom(),source=metadata();source.controls.find(control=>control.key===bindings.start).testId='fixture-help';
 const kit=new PrimeComponentFactory(f.root,'derived-collision','en',source);
 try{const field=kit.field(bindings.search);assert.throws(()=>kit.button(bindings.start,()=>{},{suffix:'-search-error',feedback:false}),/Duplicate governed/);f.root.append(field.element);assert.equal(f.document.querySelectorAll('[id="fixture-help-search-error"]').length,1);}finally{kit.dispose();}
});

test('external derived field ID collision fails before reserving the primary ID',()=>{
 const f=dom(),outside=f.document.createElement('p');outside.id='fixture-help-search-error';f.document.body.append(outside);
 const kit=new PrimeComponentFactory(f.root,'external-collision','en',metadata());
 try{assert.throws(()=>kit.field(bindings.search),/Duplicate governed/);outside.remove();f.root.append(kit.field(bindings.search).element);assert.equal(f.root.querySelectorAll('input').length,1);}finally{kit.dispose();}
});

test('custom button feedback labels fail before ID reservation while state-driven opt-out remains usable',async()=>{
 const f=dom(),kit=new PrimeComponentFactory(f.root,'feedback-labels','en',metadata());let calls=0;
 try{assert.throws(()=>kit.button(bindings.start,()=>calls++),/Registered label/);const button=kit.button(bindings.start,()=>calls++,{feedback:false});f.root.append(button);button.dispatchEvent(new f.Event('click'));await settle();assert.equal(calls,1);assert.equal(button.disabled,false);assert.equal(f.root.querySelector('[data-cy="fixture-help-start-status"]'),null);}finally{kit.dispose();}
});

test('custom button explicit feedback keys replace generic defaults without inventing labels',async()=>{
 const f=dom(),source=metadata();for(const language of locales)source.locales[language].loading=language+' loading';const kit=new PrimeComponentFactory(f.root,'feedback-overrides','en',source);
 try{const button=kit.button(bindings.start,async()=>{},{successKey:bindings.idle,errorKey:bindings.error});f.root.append(button);button.dispatchEvent(new f.Event('click'));await settle();assert.equal(f.root.querySelector('[data-cy="fixture-help-start-status"]').textContent,'en idle');}finally{kit.dispose();}
});

test('custom required fields validate their error label before reserving IDs',()=>{
 const f=dom(),kit=new PrimeComponentFactory(f.root,'required-label','en',metadata());
 try{assert.throws(()=>kit.field(bindings.search,{required:true}),/Registered label/);f.root.append(kit.field(bindings.search).element);assert.equal(f.root.querySelectorAll('input').length,1);}finally{kit.dispose();}
});

test('caller metadata and localized names are captured before later mutation',async()=>{
 const f=fixture();try{f.source.controls[0].testId='changed';f.source.locales.fr[bindings.search]='PRIVATE changed';f.options.bindings.start='invented';f.options.localeNames=()=>({});
  assert.ok(f.control('start'));await f.session.changeLocale('fr');assert.ok(f.root.textContent.includes('fr search'));assert.equal(f.root.textContent.includes('PRIVATE'),false);
 }finally{f.close();}
});

test('unmounted reader starts idle without transport and renders only supplied bindings',()=>{
 const f=fixture();try{assert.equal(f.commands.length,0);assert.equal(f.session.state.phase,'idle');assert.ok(f.root.textContent.includes('en idle'));assert.equal(f.control('search').maxLength,100);assert.equal(f.control('locale').value,'en');assert.equal(f.root.querySelector('[data-cy^="component-catalogue-"]'),null);}finally{f.close();}
});

test('actual session list/detail/back/paging use shared registered controls and plain text',async()=>{
 const f=fixture();try{
  await f.click('start');await until(()=>f.session.state.phase==='list');assert.equal(f.commands[0].offset,0);assert.equal(f.control('previous').disabled,true);
  await f.click('open','-article-0');await until(()=>f.session.state.phase==='detail');assert.equal(f.commands.at(-1).action,'read');assert.ok(f.root.textContent.includes('Plain <script>private body</script>'));assert.equal(f.root.querySelector('script'),null);
  await f.click('back');await until(()=>f.session.state.phase==='list');await f.click('next');await until(()=>f.session.state.offset===1&&f.session.state.phase==='list');assert.equal(f.commands.at(-1).offset,1);assert.equal(f.control('previous').disabled,false);
  await f.click('previous');await until(()=>f.session.state.offset===0&&f.session.state.phase==='list');assert.equal(f.commands.at(-1).offset,0);
 }finally{f.close();}
});

for(const locale of locales)test('search reset and locale '+locale+' preserve actual session wire requests and translated controls',async()=>{
 const f=fixture();try{
  await f.load();await f.session.nextPage();const field=f.control('search');field.value='needle';const enter=new f.Event('keydown');enter.key='Enter';field.dispatchEvent(enter);
  await until(()=>f.session.state.query==='needle'&&f.session.state.phase==='list');assert.equal(f.commands.at(-1).offset,0);
  const select=f.control('locale');select.value=locale;select.dispatchEvent(new f.Event('change'));await until(()=>f.session.state.locale===locale&&f.session.state.phase==='list');
  assert.equal(f.commands.at(-1).locale,locale);assert.equal(f.commands.at(-1).query,'needle');assert.ok(f.root.textContent.includes(locale+' search'));
 }finally{f.close();}
});

test('loading removes previously rendered article text and retained callbacks cannot issue another read',async()=>{
 const f=fixture();try{
  await f.load();const old=f.control('open','-article-0');f.hold();const pending=f.session.search('new');await until(()=>f.commands.length===2);
  assert.equal(f.session.state.phase,'loading');assert.equal(f.root.textContent.includes('en Guide'),false);assert.equal(f.control('search').disabled,true);assert.ok(f.control('loading').querySelector('progress'));
  old.dispatchEvent(new f.Event('click'));await settle();assert.equal(f.commands.length,2);f.release();await pending;
 }finally{f.release();f.close();}
});

test('sanitized error/retry/empty and denial/retirement use registered state labels',async()=>{
 const f=fixture();try{
  f.setStatus(503);await f.load();assert.equal(f.session.state.phase,'error');assert.ok(f.control('retry'));assert.equal(f.root.textContent.includes('PRIVATE'),false);
  f.setStatus(200);f.setEmpty(true);await f.click('retry');await until(()=>f.session.state.phase==='empty');assert.ok(f.control('empty'));assert.equal(f.control('next').disabled,true);
  f.setStatus(403);await f.session.backToList();assert.equal(f.session.state.phase,'retired');assert.ok(f.control('retired'));assert.equal(f.root.querySelector('input,button,select'),null);assert.equal(f.root.textContent.includes('PRIVATE'),false);
 }finally{f.close();}
});

test('retirement immediately clears private DOM and dispose releases listeners without disposing the borrowed session',async()=>{
 const f=fixture();try{
  await f.load();const old=f.control('open','-article-0');f.retire();assert.equal(f.root.textContent.includes('Guide'),false);assert.ok(f.control('retired'));
  f.view.dispose();assert.equal(f.root.childNodes.length,0);old.dispatchEvent(new f.Event('click'));await settle();assert.equal(f.commands.length,1);
 }finally{f.close();}
 const live=fixture();try{live.view.dispose();await live.session.load();assert.equal(live.session.state.phase,'list');assert.equal(live.root.childNodes.length,0);}finally{live.close();}
});

test('session callbacks and getters are captured before caller mutation',async()=>{
 const f=fixture();let redirected=0;
 try{
  for(const key of ['load','search','changeLocale','nextPage','previousPage','backToList','retry','openArticle','subscribe'])f.session[key]=()=>{redirected++;};
  for(const key of ['state','canNext','canPrevious','canRetry'])Object.defineProperty(f.session,key,{get(){redirected++;throw Error('Mutated session getter');}});
  await f.click('start');await until(()=>!!f.control('open','-article-0'));await f.click('open','-article-0');await until(()=>!!f.control('back'));assert.equal(redirected,0);assert.ok(f.root.textContent.includes('Plain <script>private body</script>'));
 }finally{f.close();}
});

test('view disposal cannot remove replacement DOM and old callbacks stay inert',async()=>{
 const f=fixture();try{const old=f.control('start');f.view.dispose();const replacement=new PrimeComponentFactory(f.root,'replacement');f.root.append(replacement.button('button',()=>{}));old.dispatchEvent(new f.Event('click'));f.view.dispose();await settle();assert.equal(f.commands.length,0);assert.equal(f.root.querySelector('button').dataset.cy,'component-catalogue-button');replacement.dispose();}finally{f.close();}
});

test('repeated article controls retain registered IDs with distinct approved instance suffixes',async()=>{
 const f=fixture('en',2);try{await f.load();assert.equal(f.root.querySelectorAll('[data-cy^="fixture-help-article-article-"]').length,2);assert.ok(f.control('open','-article-0'));assert.ok(f.control('open','-article-1'));const ids=[...f.root.querySelectorAll('[id]')].map(node=>node.id);assert.equal(new Set(ids).size,ids.length);await f.click('open','-article-1');await until(()=>f.session.state.phase==='detail');assert.equal(f.commands.at(-1).articleId,'guide-1');}finally{f.close();}
});

for(const mode of ['disabled','moved input','moved field','disposed'])test('search Enter cannot dispatch from '+mode+' presentation controls',async()=>{
 const f=fixture();try{
  const input=f.control('search'),field=input.parentElement;input.value='private retained draft';
  if(mode==='disabled')input.disabled=true;
  if(mode==='moved input')f.root.append(input);
  if(mode==='moved field')f.document.body.append(field);
  if(mode==='disposed')f.view.dispose();
  const enter=new f.Event('keydown');enter.key='Enter';input.dispatchEvent(enter);await settle();assert.equal(f.commands.length,0);
 }finally{f.close();}
});

for(const status of [401,403,409,404,429,503])test('HTTP '+status+' projects only registered '+([401,403,409].includes(status)?'retired':'error')+' presentation',async()=>{
 const f=fixture();try{f.setStatus(status);await f.load();const closed=[401,403,409].includes(status);assert.equal(f.session.state.phase,closed?'retired':'error');assert.ok(f.control(closed?'retired':'error'));assert.equal(f.root.textContent.includes('PRIVATE'),false);assert.equal(!!f.control('retry'),!closed);}finally{f.close();}
});

test('custom metadata construction failure restores caller DOM and original error before a valid retry',()=>{
 const f=fixture();f.view.dispose();const retained=f.document.createElement('p');retained.textContent='caller draft';f.root.append(retained);f.root.setAttribute('data-pc-catalogue','caller-marker');f.document.querySelector('[data-pc-catalogue-style]').remove();
 const append=f.document.head.append,reason=Error('isolated style insertion failure');f.document.head.append=()=>{throw reason;};
 try{assert.throws(()=>new HelpReaderView(f.root,f.options),error=>error===reason);}finally{f.document.head.append=append;}
 assert.equal(f.root.firstChild===retained,true);assert.equal(f.root.getAttribute('data-pc-catalogue'),'caller-marker');const retry=new HelpReaderView(f.root,f.options);retry.dispose();f.session.dispose();
});

test('unsubscribe failure cannot prevent private DOM clearing or release of view ownership',()=>{
 const f=fixture();f.view.dispose();const subscribe=f.session.subscribe,reason=Error('isolated unsubscribe failure');f.session.subscribe=listener=>{const off=subscribe(listener);return()=>{off();throw reason;};};
 const view=new HelpReaderView(f.root,f.options);assert.throws(()=>view.dispose(),error=>error===reason);assert.equal(f.root.childNodes.length,0);f.session.subscribe=subscribe;
 const retry=new HelpReaderView(f.root,f.options);retry.dispose();f.session.dispose();
});

for(const mode of ['state on retirement','state on click','canRetry during error'])test('observation failure clears private DOM without disposing the borrowed session: '+mode,async()=>{
 const f=fixture();f.view.dispose();let fail=false;
 const descriptor=Object.getOwnPropertyDescriptors(f.session),key=mode==='canRetry during error'?'canRetry':'state',getter=descriptor[key].get;
 descriptor[key]={configurable:true,get(){if(fail)throw Error('PRIVATE observation failure');return getter.call(f.session);}};
 const borrowed=Object.defineProperties({},descriptor),view=new HelpReaderView(f.root,{...f.options,session:borrowed});
 try{
  await f.session.load();assert.ok(f.root.textContent.includes('Guide'));const old=f.control('open','-article-0');fail=true;
  if(mode==='state on retirement')f.session.retire();
  else if(mode==='state on click'){old.dispatchEvent(new f.Event('click'));await settle();assert.equal(f.commands.length,1);}
  else{f.setStatus(503);await f.session.backToList();}
  assert.equal(f.root.childNodes.length,0);assert.notEqual(f.session.state.phase,'disposed');fail=false;
  const replacement=new HelpReaderView(f.root,f.options);replacement.dispose();
 }finally{view.dispose();f.close();}
});
