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
