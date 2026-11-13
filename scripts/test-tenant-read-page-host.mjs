import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';
const built=await build({entryPoints:['websites/typescript/src/tenant-dashboard/read-page-host.ts'],bundle:true,write:false,format:'esm',platform:'node'});
const {mountTenantReadHost}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
function fixture(kind,locale='en'){
 const {document,window}=parseHTML('<html><head></head><body><div id="app"><main class="tenant-dashboard-main"><p>Existing workspace</p></main></div></body></html>');
 for(const key of ['HTMLElement','HTMLInputElement','HTMLTextAreaElement','HTMLSelectElement','Element'])globalThis[key]=window[key];
 globalThis.sessionStorage={getItem:()=> 'token'};
 const data={dataset:'live',synthetic:false,identity:{userId:'user',role:'tenant_admin'},organization:{id:'tenant'},today:'2026-11-13',allowedViews:['tasks','operations','audit','workflows'],taskStats:{open:7,review:2,blocked:1,overdue:3,completed:4},stats:{staff:10,clients:6,visits:null,requests:2,time:1,care:null,plans:2},tasks:[{id:'task1',title:'Authorized task'}],workflows:[{flow_id:'flow1',title:'Authorized workflow'}],events:[{action:'task_created',created_at:'2026-11-13T10:00:00.000Z'}]};
 const root=document.querySelector('#app'),options={gateway:'https://fixture.test',token:'token',data,params:new URLSearchParams({readPage:kind}),locale,isCurrent:()=>true,whenActive:async()=>true};
 return {root,options};
}
for(const kind of ['project','analytics','activity','search'])test('registered '+kind+' host projects authorized response without requests or hiding workspace',()=>{
 const {root,options}=fixture(kind);const h=mountTenantReadHost(root,options);assert.ok(h);assert.match(root.textContent,/Existing workspace/);assert.ok(root.querySelector('[data-cy="dashboard-pages-'+kind+'"]'));
 if(kind==='project')assert.match(root.textContent,/7/);
 if(kind==='analytics')assert.match(root.textContent,/Not available/);
 if(kind==='activity')assert.match(root.textContent,/task_created/);
 if(kind==='search')assert.match(root.textContent,/Authorized task/);
 h.dispose();h.dispose();assert.equal(root.textContent,'Existing workspace');
});
test('bounded search filters loaded records only and escapes titles',()=>{
 const {root,options}=fixture('search');options.params.set('readQuery','<img');options.data.tasks[0].title='<img src=x onerror=alert(1)>';
 const h=mountTenantReadHost(root,options);assert.match(root.textContent,/<img/);assert.equal(root.querySelector('img'),null);assert.doesNotMatch(root.textContent,/Authorized workflow/);h.dispose();
});
test('server view denial projects no protected rows or counts',()=>{
 for(const kind of ['project','analytics','activity','search']){const {root,options}=fixture(kind);options.data.allowedViews=[];const h=mountTenantReadHost(root,options);assert.match(root.textContent,/Access is not authorized/);assert.doesNotMatch(root.textContent,/Authorized task|task_created/);assert.equal(root.querySelectorAll('li,dd').length,0);h.dispose();}
});
test('unsupported, stale and demo profile requests do not mount',()=>{
 for(const kind of ['finance','crypto','settings','academy','']){const {root,options}=fixture(kind);assert.equal(mountTenantReadHost(root,options),null);}
 const {root,options}=fixture('project');options.isCurrent=()=>false;assert.equal(mountTenantReadHost(root,options),null);
 const demo=fixture('profile');demo.options.data.dataset='demo';demo.options.data.synthetic=true;assert.equal(mountTenantReadHost(demo.root,demo.options),null);
});
test('read host uses registered French and Spanish resources',()=>{
 for(const locale of ['fr','es']){const {root,options}=fixture('activity',locale),h=mountTenantReadHost(root,options);assert.doesNotMatch(root.textContent,/Current authorized data/);assert.match(root.textContent,/task_created/);h.dispose();}
});
test('old cleanup does not remove a replacement host',()=>{
 const {root,options}=fixture('project'),old=mountTenantReadHost(root,options);root.querySelector('main').replaceChildren();const next=mountTenantReadHost(root,{...options,params:new URLSearchParams({readPage:'search'})});old.dispose();assert.match(root.textContent,/Authorized task/);next.dispose();
});
test('profile host reads only self identity and removes late output after disposal',async()=>{
 const previous=globalThis.fetch;let release,started;
 try{
  const begun=new Promise(resolve=>started=resolve);
  globalThis.fetch=async(url,init)=>{assert.equal(String(url),'https://fixture.test/v1/auth/me');assert.equal(init.headers.authorization,'Bearer token');assert.equal(init.body,undefined);started();await new Promise(resolve=>release=resolve);return Response.json({status:'authenticated',userId:'user',tenantId:'tenant',roles:'tenant_admin'});};
  const {root,options}=fixture('profile'),h=mountTenantReadHost(root,options);await begun;
  h.dispose();root.querySelector('main').append('Replacement workspace');release();await new Promise(resolve=>setImmediate(resolve));
  assert.equal(root.querySelector('[data-pc-tenant-read-host]'),null);assert.match(root.textContent,/Replacement workspace/);assert.doesNotMatch(root.textContent,/user/);
 }finally{globalThis.fetch=previous;}
});
test('profile host displays self identity read only and clears it when parent invalidates',async()=>{
 const previous=globalThis.fetch;try{
  globalThis.fetch=async()=>Response.json({status:'authenticated',userId:'user',tenantId:'tenant',roles:'tenant_admin'});
  const {root,options}=fixture('profile'),h=mountTenantReadHost(root,options);for(let i=0;i<10&&!root.querySelector('[data-work-card]');i++)await new Promise(resolve=>setImmediate(resolve));
  assert.match(root.textContent,/user/);assert.equal(root.querySelector('[data-cy=application-modules-create]').disabled,true);assert.equal(root.querySelector('[data-cy=application-modules-save]'),null);
  h.dispose();assert.equal(root.textContent,'Existing workspace');
 }finally{globalThis.fetch=previous;}
});
