import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';
const built=await build({entryPoints:['packages/primecare_ui/web/page-template.ts'],bundle:true,write:false,format:'esm',platform:'node'});
const {PageTemplateView,defaultPageLayout}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
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
 f.resize();assert.equal(f.root.childNodes.length,0);
});
test('recoverable update errors keep the existing owner until explicit disposal',()=>{
 const f=fixture(),view=new PageTemplateView(f.root,{content:f.content},f.options);
 assert.equal(f.signals[0].aborted,false);
 assert.throws(()=>view.update({...f.options,scope:''}));assert.equal(f.signals[0].aborted,false);
 const fresh=f.document.createElement('section');fresh.textContent='Authorized replacement';view.update(f.options,{content:fresh});assert.match(f.root.textContent,/Authorized replacement/);assert.equal(f.root.contains(f.content),false);
 view.dispose();view.dispose();assert.equal(f.signals[0].aborted,true);assert.equal(f.document.title,'Existing host');
 assert.throws(()=>view.update(f.options));
});
