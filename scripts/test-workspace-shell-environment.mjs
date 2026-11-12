import test from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
const bundle=await build({entryPoints:['packages/primecare_ui/web/shell-environment.ts'],bundle:true,write:false,format:'esm',platform:'node'});
const {ShellEnvironment}=await import('data:text/javascript;base64,'+Buffer.from(bundle.outputFiles[0].text).toString('base64'));
const deferred=()=>{let resolve,reject;const promise=new Promise((yes,no)=>{resolve=yes;reject=no;});return {promise,resolve,reject};};
function fixture(){
 const attributes=new Map([['dir','ltr']]);let exits=0;
 const document={body:{},documentElement:{},fullscreenEnabled:true,fullscreenElement:null,exitFullscreen:async()=>{exits++;document.fullscreenElement=null;}};
 const root={ownerDocument:document,style:{scrollbarColor:'original-scroll'},getAttribute:key=>attributes.get(key)??null,setAttribute:(key,value)=>attributes.set(key,value),removeAttribute:key=>attributes.delete(key),contains:el=>el===root,requestFullscreen:async()=>{document.fullscreenElement=root;}};
 Object.defineProperty(root,'dir',{get:()=>attributes.get('dir'),set:value=>attributes.set('dir',value)});
 return {root,document,attributes,exits:()=>exits};
}
test('concurrent disposal callers both wait for fullscreen exit and ownership release',async()=>{
 const f=fixture(),exit=deferred(),view=new ShellEnvironment(f.root,'rtl');f.document.fullscreenElement=f.root;
 f.document.exitFullscreen=async()=>{await exit.promise;f.document.fullscreenElement=null;};
 const first=view.dispose();let secondDone=false;const second=view.dispose().then(()=>{secondDone=true;});
 await Promise.resolve();assert.equal(secondDone,false,'second disposal must not resolve while cleanup is pending');
 assert.throws(()=>new ShellEnvironment(f.root,'ltr'),/invalid_shell_environment/);
 exit.resolve();await Promise.all([first,second]);assert.equal(f.root.dir,'ltr');assert.equal(f.root.style.scrollbarColor,'original-scroll');
 const replacement=new ShellEnvironment(f.root,'rtl');await view.dispose();assert.equal(f.root.dir,'rtl');await replacement.dispose();
});
test('concurrent disposal during a pending fullscreen request waits for its cleanup',async()=>{
 const f=fixture(),request=deferred(),view=new ShellEnvironment(f.root,'rtl');
 f.root.requestFullscreen=async()=>{await request.promise;f.document.fullscreenElement=f.root;};
 const toggle=view.toggleFullscreen(),first=view.dispose();let done=false;const second=view.dispose().then(()=>{done=true;});
 await Promise.resolve();assert.equal(done,false,'retired owner is still waiting for its request');request.resolve();await Promise.all([toggle,first,second]);
 assert.equal(f.document.fullscreenElement,null);assert.equal(f.exits(),1);assert.equal(f.attributes.has('data-pc-shell-environment'),false);
});
test('all disposal callers observe cleanup failure and ownership is still restored',async()=>{
 const f=fixture(),exit=deferred(),view=new ShellEnvironment(f.root,'rtl');f.document.fullscreenElement=f.root;
 f.document.exitFullscreen=()=>exit.promise;
 const first=view.dispose(),second=view.dispose(),results=Promise.allSettled([first,second]);
 exit.reject(Error('fullscreen_exit_failed'));const settled=await results;
 assert.deepEqual(settled.map(item=>item.status),['rejected','rejected']);
 assert.equal(f.root.dir,'ltr');assert.equal(f.root.style.scrollbarColor,'original-scroll');assert.equal(f.attributes.has('data-pc-shell-environment'),false);
});
test('route and fullscreen operations remain unavailable once disposal begins',async()=>{
 const f=fixture(),view=new ShellEnvironment(f.root,'rtl');const cleanup=view.dispose();
 assert.throws(()=>view.routeChanged('next'),/invalid_shell_route/);await assert.rejects(view.toggleFullscreen(),/fullscreen_unavailable/);await cleanup;
});
