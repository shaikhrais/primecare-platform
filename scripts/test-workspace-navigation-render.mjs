import test from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';
const bundle=await build({entryPoints:['packages/primecare_ui/web/workspace-navigation.ts'],bundle:true,write:false,format:'esm',platform:'node'});
const {WorkspaceNavigationView}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
function fixture(){
 const {document,window}=parseHTML('<html><head></head><body><div id="host"></div></body></html>'),events=new EventTarget();
 Object.defineProperty(document,'defaultView',{configurable:true,value:{matchMedia:()=>({matches:false}),addEventListener:(...args)=>events.addEventListener(...args)}});
 globalThis.Node=window.Node;globalThis.HTMLAnchorElement=window.HTMLAnchorElement;globalThis.MutationObserver=class{observe(){}disconnect(){}};globalThis.getComputedStyle=()=>({direction:'ltr'});
 const host=document.getElementById('host'),navigated=[];
 const options={scope:'actor',items:[{id:'home',kind:'item',label:'Authorized home',route:'/home',icon:'home'}],authority:{ids:['home'],routes:['/home'],icons:['home']},currentRoute:'/home',family:'vertical',labels:{navigation:'Navigation',open:'Open',close:'Close',pin:'Pin',unpin:'Unpin'},onNavigate:route=>navigated.push(route)};
 const view=new WorkspaceNavigationView(host,options);return {document,host,options,view,navigated};
}
for(const transition of ['revocation','invalid-update','disposal'])test(`reentrant icon ${transition} cannot commit the stale outer navigation`,()=>{
 const f=fixture();let once=false;
 const renderIcon=()=>{
  if(!once){once=true;
   if(transition==='revocation')f.view.update({...f.options,scope:'replacement',authority:{...f.options.authority,ids:[]}});
   if(transition==='invalid-update')assert.throws(()=>f.view.update({...f.options,scope:''}));
   if(transition==='disposal')f.view.dispose();
  }
  return f.document.createElement('span');
 };
 try{f.view.update({...f.options,renderIcon});assert.equal(f.host.querySelectorAll('[data-navigation-id]').length,0,'retired render must not replace the latest cleared/denied/disposed content');assert.deepEqual(f.navigated,[]);}
 finally{f.view.dispose();}
});
test('current icon rendering still preserves naming and allowed navigation',()=>{
 const f=fixture();try{
  f.view.update({...f.options,renderIcon:()=>f.document.createElement('span')});const link=f.host.querySelector('a');
  assert.equal(link.getAttribute('aria-label'),'Authorized home');link.click();assert.deepEqual(f.navigated,['/home']);
 }finally{f.view.dispose();}
});
for(const transition of ['newer-update','replacement-owner'])test(`throwing retired renderer cannot clear ${transition}`,()=>{
 const f=fixture();let once=false,replacement;
 const renderIcon=()=>{if(!once){once=true;
  if(transition==='newer-update')f.view.update({...f.options,scope:'replacement'});
  else{f.view.dispose();replacement=new WorkspaceNavigationView(f.host,{...f.options,scope:'replacement'});}
  throw Error('retired_renderer_failed');
 }return f.document.createElement('span');};
 try{assert.throws(()=>f.view.update({...f.options,renderIcon}),/retired_renderer_failed/);assert.equal(f.host.querySelectorAll('[data-navigation-id=home]').length,1,'newer owner/update must retain its accepted UI');}
 finally{replacement?.dispose();f.view.dispose();}
});
