import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';
const metadata=JSON.parse(await readFile('packages/primecare_ui/catalogs/work-modules.registration.json','utf8'));
const built=await build({entryPoints:['packages/primecare_ui/web/work-modules.ts'],bundle:true,write:false,format:'esm',platform:'node'});
const {PrimeWorkModule,WorkModuleSession,WorkFailure}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
for(const missing of ['filter','create'])for(const marker of [null,'host-marker'])for(const existingStyle of [false,true])test(`failed shared construction releases ownership: ${missing}/${marker}/${existingStyle}`,async()=>{
 const {document}=parseHTML('<html><head></head><body><main><button>Host-owned content</button></main></body></html>'),root=document.querySelector('main'),original=root.firstChild;
 if(marker!==null)root.setAttribute('data-pc-work-modules',marker);
 if(existingStyle){const style=document.createElement('style');style.setAttribute('data-pc-work-style','');style.textContent='/* pre-existing shared style */';document.head.append(style);}
 const headBefore=document.head.innerHTML;
 const scope={tenantId:'lifecycle-tenant',userId:'lifecycle-actor',role:'tenant_admin',dataset:'live'},session=new WorkModuleSession(scope,'calendar');
 let active=0;const subscribe=session.subscribe.bind(session);session.subscribe=(fn)=>{active++;const stop=subscribe(fn);return()=>{active--;stop();};};
 const bad=structuredClone(metadata);bad.controls=bad.controls.filter(c=>c.key!==missing);
 const options={locale:'en',year:2026,month:11,firstWeekday:1};
 assert.throws(()=>new PrimeWorkModule(root,session,{...options,metadata:bad}),e=>e instanceof WorkFailure&&e.code==='invalid');
 assert.equal(active,0);assert.equal(root.firstChild,original);assert.equal(root.childNodes.length,1);assert.equal(root.getAttribute('data-pc-work-modules'),marker);assert.equal(document.head.innerHTML,headBefore);assert.notEqual(session.status,'disposed');
 let clicks=0;original.addEventListener('click',()=>clicks++);original.click();assert.equal(clicks,1);
 const valid=new PrimeWorkModule(root,session,options);assert.equal(active,1);assert.match(root.textContent,/calendar/i);valid.dispose();assert.equal(active,0);assert.notEqual(session.status,'disposed');session.dispose();
});
test('a rejected duplicate constructor cannot release the existing owner',()=>{
 const {document}=parseHTML('<html><head></head><body><main></main></body></html>'),root=document.querySelector('main');
 const session=new WorkModuleSession({tenantId:'tenant-owner',userId:'actor-owner',role:'tenant_admin',dataset:'live'},'calendar');
 const options={locale:'en',year:2026,month:11,firstWeekday:0},owner=new PrimeWorkModule(root,session,options),original=root.firstChild;
 assert.throws(()=>new PrimeWorkModule(root,session,options),e=>e instanceof WorkFailure&&e.code==='invalid');assert.equal(root.firstChild,original);assert.equal(root.hasAttribute('data-pc-work-modules'),true);
 owner.render();assert.match(root.textContent,/calendar/i);owner.dispose();assert.notEqual(session.status,'disposed');session.dispose();
});
