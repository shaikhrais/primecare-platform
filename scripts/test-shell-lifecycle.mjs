import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {chromium} from 'playwright';
import {createServer} from 'node:http';
const bundle=await build({stdin:{contents:`export {renderShell,bindShell} from './packages/primecare_ui/web/shell';export {defaultPersonalTheme} from './packages/domain/src/theme_center';`,resolveDir:process.cwd()},bundle:true,format:'iife',globalName:'PrimeShellLifecycle',write:false});
const server=createServer((req,res)=>{res.setHeader('content-type',req.url==='/app.js'?'text/javascript':'text/html');res.end(req.url==='/app.js'?bundle.outputFiles[0].text:'<!doctype html><html><head></head><body><div id="app"></div><script src="/app.js"></script></body></html>');});
await new Promise(r=>server.listen(0,'127.0.0.1',r));
const origin=`http://127.0.0.1:${server.address().port}`;
let browser;
try{
 browser=await chromium.launch();const page=await browser.newPage(),errors=[];
 page.on('pageerror',e=>errors.push(e.message));await page.route('**/*',route=>{assert.equal(new URL(route.request().url()).origin,origin);return route.continue();});await page.goto(origin);
 const checks=await page.evaluate(async()=>{
  const {renderShell,bindShell,defaultPersonalTheme}=PrimeShellLifecycle,root=document.querySelector('#app'),checks=[];
  const expect=(value,name)=>{if(!value)throw Error(name);checks.push(name);};
  const mount=(scope='actor-a',locale='en',controls='account')=>{renderShell(root,{home:'/',role:'staff',navigation:'<a>Allowed</a>',controls:`<span>${controls}</span>`,content:'<input id="business" value="draft">'});bindShell(root,'Workspace',locale,'staff',()=>[],scope);};
  const token=()=>document.documentElement.style.getPropertyValue('--color-primary');
  const pending=(selector,source)=>{const input=root.querySelector(`[data-cy=${selector}]`);let resolve,reject;const promise=new Promise((a,b)=>{resolve=a;reject=b;});Object.defineProperty(input,'files',{configurable:true,value:[{size:source.length,text:()=>promise}]});const done=input.onchange(new Event('change'));return {resolve:()=>resolve(source),reject:()=>reject(Error('read failure')),done,input};};
  const theme=color=>JSON.stringify({...defaultPersonalTheme,name:'Imported',colors:{primary:color}});
  const xml=color=>`<PrimeCareLayout version="1"><Theme preset="default" accent="${color}"/><Shell sidebar="left" navigation="expanded" density="comfortable" contentWidth="100"/></PrimeCareLayout>`;
  mount();let slow=pending('theme-center-import',theme('#123456'));mount('actor-b');const actorB=token();slow.resolve();await slow.done;expect(token()===actorB,'old actor theme import ignored');
  slow=pending('appearance-import',xml('#654321'));mount('actor-c');const actorC=token();slow.resolve();await slow.done;expect(token()===actorC,'old actor XML import ignored');
  slow=pending('theme-center-import',theme('#102030'));mount('actor-c','fr');const localized=token();slow.resolve();await slow.done;expect(token()===localized,'replaced locale dialog ignores old import');
  let first=pending('theme-center-import',theme('#112233')),second=pending('theme-center-import',theme('#223344'));second.resolve();await second.done;first.resolve();await first.done;expect(token()==='#223344','newest theme import wins');
  first=pending('appearance-import',xml('#334455'));second=pending('appearance-import',xml('#445566'));second.resolve();await second.done;first.resolve();await first.done;expect(document.documentElement.style.getPropertyValue('--color-primary')!=='#334455','older XML import cannot replace newer import');
  // Remove the active personal theme so the XML accent is observable.
  root.querySelector('[data-cy=theme-center-reset]').click();
  first=pending('appearance-import',xml('#556677'));second=pending('appearance-import',xml('#667788'));second.resolve();await second.done;first.resolve();await first.done;expect(token()==='#667788','newest XML import wins');
  slow=pending('theme-center-import',theme('#778899'));const liveDialog=root.querySelector('[data-cy=appearance-dialog]');mount('actor-c','fr','refreshed');slow.resolve();await slow.done;expect(token()==='#778899'&&root.querySelector('[data-cy=appearance-dialog]')===liveDialog,'ordinary redraw preserves live dialog and import');
  slow=pending('theme-center-import',theme('#8899aa'));root.querySelector('[data-cy=appearance-open]').remove();mount('actor-c','fr','new-host');const refreshed=token();slow.resolve();await slow.done;expect(token()===refreshed,'replaced controls invalidate old dialog callbacks');
  slow=pending('appearance-import',xml('#8899aa'));bindShell(root,'Workspace','en','staff',()=>[]);const signedOut=token(),shell=root.querySelector('.app-shell');expect(!shell.dataset.layoutVersion&&!shell.dataset.sidebarPosition&&!shell.style.getPropertyValue('--layout-content-width'),'unbound account clears layout attributes');slow.resolve();await slow.done;expect(!root.querySelector('[data-cy=appearance-dialog]')&&token()===signedOut,'unbound account clears appearance host and pending imports');
  mount('actor-d');root.querySelector('[data-cy=theme-quick-teal]').click();slow=pending('theme-center-import',theme('#99aabb'));root.replaceChildren();await new Promise(r=>setTimeout(r,0));const cleared=token();slow.resolve();await slow.done;expect(token()===cleared&&!root.querySelector('[data-cy=appearance-dialog]'),'host removal releases presentation and imports');
  mount('actor-e');slow=pending('appearance-import',xml('#aabbcc'));root.remove();await new Promise(r=>setTimeout(r,0));const detached=token();slow.reject();await slow.done;expect(token()===detached,'detached root suppresses late import failure');
  document.body.append(root);mount('actor-e');const dialogs=root.querySelectorAll('[data-cy=appearance-dialog]').length;expect(dialogs===1,'same root can mount again after disposal');
  return checks;
 });
 assert.deepEqual(errors,[]);console.log(JSON.stringify({checks:checks.length,passed:checks,scope:'shared web shell lifecycle; no production activation'}));
}finally{await browser?.close();await new Promise(r=>server.close(r));}
