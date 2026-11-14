import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';
const built=await build({entryPoints:['packages/primecare_ui/web/page-template.ts'],bundle:true,write:false,format:'esm',platform:'node'});
const {PageTemplateView,PageWorkspaceChrome,defaultPageLayout}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
function fixture(){
 const {document}=parseHTML('<html><head><title>Existing host</title></head><body><main id="page"></main></body></html>');
 const events=new EventTarget(),signals=[];
 const host={innerWidth:1500,getComputedStyle:()=>({direction:'ltr'}),scrollTo:()=>{},
  addEventListener(type,callback,options){if(type==='resize')signals.push(options.signal);events.addEventListener(type,callback,options);}};
 Object.defineProperty(document,'defaultView',{configurable:true,value:host});
 const root=document.getElementById('page'),content=document.createElement('section');content.textContent='Authorized content';
 const options={scope:'page-test-actor',routes:[{id:'existing_page',route:'/existing',title:'Existing registered page',breadcrumbs:[],layout:defaultPageLayout()}],authority:{ids:['existing_page'],routes:['/existing']},currentRoute:'/existing',labels:{breadcrumbs:'Breadcrumbs',openLeft:'Open left',closeLeft:'Close left',openRight:'Open right',closeRight:'Close right'},onNavigate:()=>{throw Error('No navigation expected');}};
 return {document,root,content,options,signals,resize:()=>events.dispatchEvent(new Event('resize'))};
}
for(const failure of ['scope','route','slots'])test(`failed page construction releases its resize listener: ${failure}`,()=>{
 const f=fixture(),options=structuredClone({...f.options,onNavigate:undefined});options.onNavigate=f.options.onNavigate;const slots={content:f.content};
 if(failure==='scope')options.scope='';
 if(failure==='route')options.routes[0].layout.version=99;
 if(failure==='slots')slots.left=f.content;
 assert.throws(()=>new PageTemplateView(f.root,slots,options));
 assert.equal(f.signals.length,1);assert.equal(f.signals[0].aborted,true);
 assert.equal(f.document.title,'Existing host');assert.equal(f.root.hasAttribute('data-pc-page'),false);
 f.resize();assert.equal(f.root.childNodes.length,0);const recovered=new PageTemplateView(f.root,{content:f.document.createElement('section')},f.options);recovered.dispose();assert.equal(f.signals[1].aborted,true);
});
test('recoverable update errors keep the existing owner until explicit disposal',()=>{
 const f=fixture(),view=new PageTemplateView(f.root,{content:f.content},f.options);
 assert.equal(f.signals[0].aborted,false);
 assert.throws(()=>view.update({...f.options,scope:''}));assert.equal(f.signals[0].aborted,false);
 const fresh=f.document.createElement('section');fresh.textContent='Authorized replacement';view.update(f.options,{content:fresh});assert.match(f.root.textContent,/Authorized replacement/);assert.equal(f.root.contains(f.content),false);
 view.dispose();view.dispose();assert.equal(f.signals[0].aborted,true);assert.equal(f.document.title,'Existing host');
 assert.throws(()=>view.update(f.options));
});

test('cleared page retains exclusive ownership through failed updates until explicit disposal',()=>{
 const f=fixture(),view=new PageTemplateView(f.root,{content:f.content},f.options);assert.throws(()=>view.update({...f.options,scope:''}));assert.equal(f.root.hasAttribute('data-pc-page'),false);
 const rejected=f.document.createElement('section');rejected.textContent='Must not replace existing owner';
 for(let i=0;i<2;i++)assert.throws(()=>new PageTemplateView(f.root,{content:rejected},f.options),/already managed/);
 assert.equal(f.signals.length,1,'rejected duplicate must not subscribe or release the live owner');
 const restored=f.document.createElement('section');restored.textContent='Recovered authorized page';view.update(f.options,{content:restored});assert.match(f.root.textContent,/Recovered authorized page/);view.dispose();
 const next=f.document.createElement('section');next.textContent='New authorized owner';const replacement=new PageTemplateView(f.root,{content:next},f.options);assert.throws(()=>view.update(f.options,{content:f.content}),/disposed/);assert.match(f.root.textContent,/New authorized owner/);replacement.dispose();
});

function chromeFixture(){const f=fixture(),frame=f.document.createElement('div'),slots={navigation:f.document.createElement('nav'),toolbar:f.document.createElement('header'),footer:f.document.createElement('footer')};frame.append(slots.navigation,slots.toolbar,f.root,slots.footer);f.document.body.append(frame);slots.footer.hidden=true;slots.toolbar.inert=true;return {...f,frame,chromeSlots:slots};}
const chromeState=f=>({owner:f.frame.hasAttribute('data-pc-page-chrome-owner'),policy:['navigation','toolbar','footer'].map(key=>f.frame.getAttribute('data-pc-page-chrome-'+key)),slots:Object.values(f.chromeSlots).map(element=>({hidden:element.hidden,inert:element.inert}))});
test('disposed chrome ignores later apply and restores original hidden and inert state exactly once',()=>{
 const f=chromeFixture(),original=chromeState(f),chrome=new PageWorkspaceChrome(f.frame,f.chromeSlots);chrome.apply({navigation:false,toolbar:false,footer:false});chrome.dispose();assert.deepEqual(chromeState(f),original);chrome.apply({navigation:false,toolbar:false,footer:false});assert.deepEqual(chromeState(f),original);chrome.dispose();assert.deepEqual(chromeState(f),original);
});
test('retired chrome disposal cannot clear replacement ownership or visibility policy',()=>{
 const f=chromeFixture(),old=new PageWorkspaceChrome(f.frame,f.chromeSlots);old.dispose();const replacement=new PageWorkspaceChrome(f.frame,f.chromeSlots);replacement.apply({navigation:false,toolbar:false,footer:false});const expected=chromeState(f);old.dispose();assert.deepEqual(chromeState(f),expected);assert.throws(()=>new PageWorkspaceChrome(f.frame,f.chromeSlots),/already managed/);replacement.dispose();
});
test('page updates and disposal through retired chrome leave the replacement controller untouched',()=>{
 const f=chromeFixture(),old=new PageWorkspaceChrome(f.frame,f.chromeSlots),view=new PageTemplateView(f.root,{content:f.content},{...f.options,chrome:old});old.dispose();const replacement=new PageWorkspaceChrome(f.frame,f.chromeSlots);replacement.apply({navigation:false,toolbar:false,footer:false});const expected=chromeState(f);view.update({...f.options,chrome:old});assert.deepEqual(chromeState(f),expected);view.dispose();assert.deepEqual(chromeState(f),expected);replacement.dispose();
});

for(const side of ['left','right'])test(`same-route overlay update retains focused ${side} draft`,()=>{
 const f=fixture();let focused=null;
 Object.defineProperty(f.document,'activeElement',{configurable:true,get:()=>focused});
 const prototype=Object.getPrototypeOf(f.content),originalFocus=prototype.focus;
 prototype.focus=function(){focused=this;};
 const create=f.document.createElement.bind(f.document);
 f.document.createElement=function(tag){const el=create(tag);if(tag==='dialog'){el.showModal=()=>el.setAttribute('open','');el.close=()=>el.removeAttribute('open');}return el;};
 const sidebar=create('section'),input=create('input');input.value='Unfinished sidebar draft';sidebar.append(input);
 const layout={...defaultPageLayout(),[side]:{mode:'temporary',width:280,open:false}};
 const options={...f.options,routes:[{...f.options.routes[0],layout}]};
 const view=new PageTemplateView(f.root,{content:f.content,[side]:sidebar},options);
 try{
  view.toggle(side);input.focus();assert.equal(f.document.activeElement,input);
  view.update(options);
  assert.equal(f.document.activeElement===input,true,'metadata refresh must restore focus inside the reopened overlay');
  assert.equal(input.value,'Unfinished sidebar draft');
  assert.equal(f.document.querySelector('dialog').contains(input),true);
  const hidden={...options,routes:[{...options.routes[0],layout:{...layout,[side]:{mode:'none',width:280,open:false}}}]};
  view.update(hidden);assert.equal(f.document.activeElement===input,false,'hidden sidebar must not reclaim focus');
  const fresh=create('section');view.update({...options,scope:'replacement-actor'},{content:fresh});
  assert.equal(f.document.activeElement===f.root.querySelector('[data-pc-page-heading]'),true,'new actor receives heading focus');
  assert.equal(f.root.contains(input),false,'retired draft is detached');
 }finally{view.dispose();prototype.focus=originalFocus;}
});
test('caller scope mutation cannot bypass fresh-actor content validation',()=>{
 const f=fixture(),view=new PageTemplateView(f.root,{content:f.content},f.options);
 try{f.options.scope='replacement-actor';assert.throws(()=>view.update(f.options),/fresh authorized content/);assert.equal(f.root.childNodes.length,0);}
 finally{view.dispose();}
});
for(const key of ['content','left'])test(`implicit refresh retains validated ${key} slot after caller descriptor mutation`,()=>{
 const f=fixture(),left=f.document.createElement('section'),external=f.document.createElement('section');left.textContent='Authorized sidebar';external.textContent='External owner';f.document.body.append(external);
 const options={...f.options,routes:[{...f.options.routes[0],layout:{...defaultPageLayout(),left:{mode:'permanent',width:280,open:true}}}]};
 const slots={content:f.content,left},view=new PageTemplateView(f.root,slots,options);
 try{slots[key]=external;view.update(options);assert.equal(external.parentElement===f.document.body,true);assert.equal(f.root.contains(f.content),true);assert.equal(f.root.contains(left),true);}
 finally{view.dispose();external.remove();}
});
test('explicit fresh-actor slot update still accepts authorized replacement content',()=>{
 const f=fixture(),view=new PageTemplateView(f.root,{content:f.content},f.options),fresh=f.document.createElement('section');fresh.textContent='Replacement authorized content';
 try{f.options.scope='replacement-actor';view.update(f.options,{content:fresh});assert.equal(f.root.contains(fresh),true);assert.equal(f.root.contains(f.content),false);}
 finally{view.dispose();}
});

for(const failure of [Error('chrome cleanup'),null,undefined])test('page disposal clears content title and resize ownership after '+String(failure),()=>{const f=fixture();let fail=false;f.options.chrome={apply(){if(fail)throw failure;}};const view=new PageTemplateView(f.root,{content:f.content},f.options);fail=true;let caught=false;try{view.dispose();}catch(error){caught=true;assert.equal(error,failure);}assert.equal(caught,true);assert.equal(f.root.childNodes.length,0);assert.equal(f.signals[0].aborted,true);assert.equal(f.document.title,'Existing host');assert.throws(()=>view.update(f.options),/disposed/);fail=false;const next=new PageTemplateView(f.root,{content:f.document.createElement('section')},f.options);f.root.textContent='Replacement';view.dispose();assert.equal(f.root.textContent,'Replacement');next.dispose();});

for(const failure of [Error('first modal close'),null,undefined])test('page cleanup removes all owned modal overlays after '+String(failure),()=>{const f=fixture(),view=new PageTemplateView(f.root,{content:f.content},f.options),left=f.document.createElement('dialog'),right=f.document.createElement('dialog');let closed=0;left.close=()=>{throw failure;};right.close=()=>closed++;f.document.body.append(left,right);view.dialogs={left,right};let caught=false;try{view.dispose();}catch(error){caught=true;assert.equal(error,failure);}assert.equal(caught,true);assert.equal(closed,1);assert.equal(left.isConnected,false);assert.equal(right.isConnected,false);assert.deepEqual(view.dialogs,{});assert.equal(f.signals[0].aborted,true);assert.equal(f.root.childNodes.length,0);const next=new PageTemplateView(f.root,{content:f.document.createElement('section')},f.options);next.dispose();});
for(const failure of [Error('cleanup chrome'),null,undefined])test('page update preserves original validation failure despite cleanup '+String(failure),()=>{const f=fixture();let fail=false;f.options.chrome={apply(){if(fail)throw failure;}};const view=new PageTemplateView(f.root,{content:f.content},f.options);fail=true;assert.throws(()=>view.update({...f.options,scope:''}),error=>error?.message==='Page scope and registered labels required');assert.equal(f.root.childNodes.length,0);assert.equal(f.document.title,'Existing host');fail=false;view.update(f.options,{content:f.document.createElement('section')});view.dispose();});
