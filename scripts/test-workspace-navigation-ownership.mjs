import test from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';
const bundle=await build({entryPoints:['packages/primecare_ui/web/workspace-navigation.ts'],bundle:true,write:false,format:'esm',platform:'node'});
const {WorkspaceNavigationView}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
function fixture(){
 const {document,window}=parseHTML('<html><head></head><body><div id="host"></div></body></html>');
 const events=new EventTarget(),signals=[];
 const view={matchMedia:()=>({matches:false}),addEventListener:(type,listener,options)=>{signals.push(options.signal);events.addEventListener(type,listener,options);}};
 Object.defineProperty(document,'defaultView',{configurable:true,value:view});
 globalThis.Node=window.Node;globalThis.HTMLAnchorElement=window.HTMLAnchorElement;globalThis.MutationObserver=class{observe(){}disconnect(){}};globalThis.getComputedStyle=()=>({direction:'ltr'});
 const host=document.getElementById('host'),navigated=[];
 const options={scope:'tenant:actor:role',items:[{id:'home',kind:'item',label:'Authorized home',route:'/home'}],authority:{ids:['home'],routes:['/home'],icons:[]},currentRoute:'/home',family:'vertical',labels:{navigation:'Navigation',open:'Open',close:'Close',pin:'Pin',unpin:'Unpin'},onNavigate:route=>navigated.push(route)};
 return {host,document,options,navigated,signals};
}
test('a second owner is rejected without replacing or revoking the active navigation',()=>{
 const f=fixture(),first=new WorkspaceNavigationView(f.host,f.options),link=f.host.querySelector('a'),count=f.signals.length;
 try{
  assert.throws(()=>new WorkspaceNavigationView(f.host,{...f.options,scope:'other-actor'}),/already managed/);
  assert.equal(f.host.querySelector('a')===link,true);assert.equal(link.getAttribute('href'),'/home');
  assert.equal(f.document.querySelectorAll('[data-workspace-navigation-portal]').length,1);
  assert.equal(f.signals.length,count,'rejected owner must not attach listeners');
 }finally{first.dispose();}
});
test('failed updates retain ownership until explicit disposal',()=>{
 const f=fixture(),first=new WorkspaceNavigationView(f.host,f.options);
 try{
  assert.throws(()=>first.update({...f.options,scope:''}));
  assert.throws(()=>new WorkspaceNavigationView(f.host,f.options),/already managed/);
  first.update(f.options);assert.equal(f.host.querySelector('a').textContent,'Authorized home');
 }finally{first.dispose();}
});
test('failed construction releases the host and removes its portal',()=>{
 const f=fixture();assert.throws(()=>new WorkspaceNavigationView(f.host,{...f.options,scope:''}));
 assert.equal(f.document.querySelectorAll('[data-workspace-navigation-portal]').length,0);
 const recovered=new WorkspaceNavigationView(f.host,f.options);assert.equal(f.host.querySelector('a').getAttribute('href'),'/home');recovered.dispose();
});
test('disposed owners cannot clear a newly mounted replacement',()=>{
 const f=fixture(),first=new WorkspaceNavigationView(f.host,f.options);first.dispose();
 const replacement=new WorkspaceNavigationView(f.host,{...f.options,scope:'replacement'}),link=f.host.querySelector('a');
 try{first.dispose();assert.equal(f.host.querySelector('a')===link,true);assert.throws(()=>first.update(f.options),/disposed/);}
 finally{replacement.dispose();}
});
test('failure after initial render revokes links, subscriptions and host ownership',()=>{
 const f=fixture();let retired;
 const observer=globalThis.MutationObserver;
 globalThis.MutationObserver=class{constructor(){retired=f.host.querySelector('a');throw Error('observer_unavailable');}};
 try{assert.throws(()=>new WorkspaceNavigationView(f.host,f.options),/observer_unavailable/);}
 finally{globalThis.MutationObserver=observer;}
 assert.equal(retired.hasAttribute('href'),false);assert.equal(f.host.childNodes.length,0);
 assert.equal(f.signals.every(signal=>signal.aborted),true);
 assert.equal(f.document.querySelectorAll('[data-workspace-navigation-portal]').length,0);
 const replacement=new WorkspaceNavigationView(f.host,f.options);replacement.dispose();
});
test('host ownership is released even when saved frame restoration fails',()=>{
 const f=fixture(),frame=f.document.createElement('div');f.document.body.append(frame);let failing=false;
 const first=new WorkspaceNavigationView(f.host,{...f.options,frame:{element:frame,profile:()=>{if(failing)throw Error('profile_unavailable');return {navigationWidth:280};}}});
 failing=true;assert.throws(()=>first.dispose(),/profile_unavailable/);
 const replacement=new WorkspaceNavigationView(f.host,f.options);try{first.dispose();assert.ok(f.host.querySelector('a'));}finally{replacement.dispose();}
});
