import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {readFile} from 'node:fs/promises';
import {resolve} from 'node:path';
// Compile the actual report module; REPORT_PANEL_SOURCE permits a before-fix regression run.
const source=await readFile(process.env.REPORT_PANEL_SOURCE??'websites/typescript/src/reports.ts','utf8');
const {outputFiles}=await build({stdin:{contents:source+"\nexport {liveScreenText} from './screen-text';",resolveDir:resolve('websites/typescript/src'),loader:'ts'},bundle:true,write:false,platform:'node',format:'esm'});
const {reportPanel,liveScreenText}=await import('data:text/javascript;base64,'+Buffer.from(outputFiles[0].text).toString('base64'));
// Minimal deterministic DOM fixture. This checks handlers/state, not browser layout or accessibility.
class Element {
 dataset={};isConnected=true;value='';checked=false;disabled=false;lookup=new Map();html='';
 set innerHTML(html){this.html=html;this.lookup=new Map();for(const m of html.matchAll(/<\w+\b([^>]*data-cy="([^"]+)"[^>]*)>/g)){const node=new Element();node.value=m[1].match(/value="([^"]*)"/)?.[1]??'';node.disabled=/\sdisabled(?:\s|$)/.test(m[1]);node.checked=/\schecked(?:\s|$)/.test(m[1]);this.lookup.set(`[data-cy=${m[2]}]`,node);}}
 get innerHTML(){return this.html;}
 querySelector(s){return this.lookup.get(s)??null;}
 replaceChildren(){this.innerHTML='';}
 remove(){this.isConnected=false;}
 click(){downloads++;}
}
let downloads=0,objects=0,reloads=0,serial=0;
const tick=()=>new Promise(resolve=>setImmediate(resolve));
const deferred=()=>{let resolve,reject;const promise=new Promise((a,b)=>{resolve=a;reject=b;});return {promise,resolve,reject};};
const definition={id:'registered',title:'Private report',canExport:true,canEmail:true,supportsFilters:true};
const result={title:'PRIVATE OLD ACCOUNT',classification:'internal',generatedAt:'today',scope:'tenant-old',columns:[{key:'value',label:'Value'}],rows:[{value:'secret-row'}]};
const manifest=()=>Response.json({reports:[definition],resources:{accepted:'Accepted',error:'Failure',unknown:'Unknown'}});
function fixture(token='old-token',connected=true){
 downloads=objects=reloads=0;const storage=new Map(token?[['primecare_session',token]]:[]),calls=[];
 globalThis.sessionStorage={getItem:k=>storage.get(k)??null,setItem:(k,v)=>storage.set(k,v),removeItem:k=>storage.delete(k)};
 globalThis.localStorage={getItem:()=>null,setItem(){}};
 globalThis.document={createElement:()=>Object.assign(new Element(),{isConnected:connected})};globalThis.location={reload(){reloads++;}};
 URL.createObjectURL=()=>{objects++;return 'blob:fixture';};URL.revokeObjectURL=()=>{};
 let respond=async url=>url.includes('/screen-text')?Response.json({screens:[]}):new URL(url).pathname.endsWith('/reports')?manifest():Response.json(result);
 globalThis.fetch=(url,options)=>{calls.push({url,options});return respond(url,options);};
 const gateway='https://report-fixture-'+(++serial)+'.invalid';const root=reportPanel(gateway,'/v1/governance/reports','old-token','user-old');
 return {root,storage,calls,gateway,setRespond:fn=>respond=fn,el:id=>root.querySelector(`[data-cy=${id}]`),switch:()=>storage.set('primecare_session','new-token')};
}
async function ready(){const f=fixture();await tick();f.el('report-generate').onclick();await tick();assert.match(f.root.innerHTML,/PRIVATE OLD ACCOUNT/);return f;}
function cleared(f){assert.equal(f.root.innerHTML,'');assert.equal(downloads,0);assert.equal(objects,0);assert.equal(reloads,1);}
for(const stage of ['fetch','body'])test(`PDF discards old session at ${stage} boundary without restoring the preview`,async()=>{
 const f=await ready(),wait=deferred();let reads=0;
 f.setRespond(()=>stage==='fetch'?wait.promise:Promise.resolve({ok:true,arrayBuffer(){reads++;return wait.promise;}}));
 f.el('report-pdf').onclick();await tick();f.switch();wait.resolve(stage==='fetch'?{ok:true,arrayBuffer(){reads++;return Promise.resolve(new TextEncoder().encode('%PDF-1.7').buffer);}}:new TextEncoder().encode('%PDF-1.7').buffer);await tick();cleared(f);assert.equal(reads,stage==='fetch'?0:1);
});
test('PDF stale failures clear instead of redrawing private content',async()=>{const f=await ready(),wait=deferred();f.setRespond(()=>wait.promise);f.el('report-pdf').onclick();f.switch();wait.reject(new Error('network'));await tick();cleared(f);});
test('stale retained handlers cannot export, refresh, generate or email, even after token restoration',async()=>{
 const f=await ready(),handlers=['report-pdf','report-refresh','report-generate'].map(id=>f.el(id).onclick),form=f.el('report-email-form');f.el('report-confirm').checked=true;f.el('report-confirm').onchange();const count=f.calls.length;f.switch();handlers[0]();f.storage.set('primecare_session','old-token');for(const handler of handlers)handler();form.onsubmit({preventDefault(){}});await tick();cleared(f);assert.equal(f.calls.length,count);assert.equal(f.storage.has('primecare-report-pending:user-old:registered'),false);
});
for(const operation of ['load','generate'])for(const stage of ['fetch','json'])test(`${operation} ignores old-session ${stage} completion`,async()=>{
 const f=operation==='load'?fixture():await ready();await tick();const wait=deferred();let reads=0;const data=operation==='load'?{reports:[definition],resources:{}}:result;
 f.setRespond(()=>stage==='fetch'?wait.promise:Promise.resolve({ok:true,json(){reads++;return wait.promise;}}));f.el(operation==='load'?'report-refresh':'report-generate').onclick();await tick();f.switch();wait.resolve(stage==='fetch'?{ok:true,json(){reads++;return Promise.resolve(data);}}:data);await tick();cleared(f);assert.equal(reads,stage==='fetch'?0:1);
});
test('email requires consent, suppresses duplicate sends and preserves uncertain pending marker after session switch',async()=>{
 const f=await ready(),form=f.el('report-email-form'),wait=deferred();f.setRespond(()=>wait.promise);const count=f.calls.length;
 form.onsubmit({preventDefault(){}});assert.equal(f.calls.length,count);f.el('report-recipient').value='person@example.invalid';f.el('report-recipient').oninput();f.el('report-confirm').checked=true;f.el('report-confirm').onchange();form.onsubmit({preventDefault(){}});form.onsubmit({preventDefault(){}});assert.equal(f.calls.length,count+1);
 const pending=f.storage.get('primecare-report-pending:user-old:registered');assert.ok(pending);assert.equal(f.calls.at(-1).options.headers['Idempotency-Key'],pending);assert.equal(JSON.parse(f.calls.at(-1).options.body).confirmed,true);
 f.switch();wait.resolve(Response.json({state:'accepted'}));await tick();cleared(f);assert.equal(f.storage.get('primecare-report-pending:user-old:registered'),pending);
});
test('current-session PDF validates bytes and downloads once; current email accepted clears pending',async()=>{
 const f=await ready();f.setRespond(async()=>new Response('not a PDF'));f.el('report-pdf').onclick();await tick();assert.equal(downloads,0);assert.match(f.root.innerHTML,/Failure/);
 f.setRespond(async()=>new Response('%PDF-1.7'));f.el('report-pdf').onclick();await tick();assert.equal(downloads,1);assert.equal(objects,1);assert.equal(reloads,0);assert.match(f.root.innerHTML,/PRIVATE OLD ACCOUNT/);
 f.el('report-confirm').checked=true;f.el('report-confirm').onchange();f.setRespond(async()=>Response.json({state:'accepted'}));f.el('report-email-form').onsubmit({preventDefault(){}});await tick();assert.equal(f.storage.has('primecare-report-pending:user-old:registered'),false);assert.match(f.root.innerHTML,/Accepted/);assert.equal(f.el('report-confirm').checked,false);
});
test('missing or mismatched session prevents initial authorized report request',async()=>{for(const token of [null,'new-token']){const f=fixture(token);await tick();cleared(f);assert.equal(f.calls.filter(c=>c.url.includes('/reports')).length,0);}});
test('email JSON completion after account switch leaves the delivery outcome unknown',async()=>{
 const f=await ready(),wait=deferred();f.el('report-confirm').checked=true;f.el('report-confirm').onchange();f.setRespond(async()=>({ok:true,json:()=>wait.promise}));f.el('report-email-form').onsubmit({preventDefault(){}});await tick();const key=f.storage.get('primecare-report-pending:user-old:registered');f.switch();wait.resolve({state:'accepted'});await tick();cleared(f);assert.equal(f.storage.get('primecare-report-pending:user-old:registered'),key);
});
test('live label notifications cannot restore stale report data or drafts',async()=>{
 const f=await ready(),store=liveScreenText(f.gateway),locales={en:{title:'Reports'},fr:{title:'Rapports'},es:{title:'Informes'}};store.seed({reports:locales});f.el('report-recipient').value='private@example.invalid';f.el('report-recipient').oninput();f.switch();store.saveLocal('reports',0,locales);cleared(f);f.storage.set('primecare_session','old-token');store.saveLocal('reports',1,locales);cleared(f);
});


test('blocked session storage clears rendered private content instead of throwing',async()=>{
 const f=await ready();const count=f.calls.length;globalThis.sessionStorage.getItem=()=>{throw new Error('Storage blocked');};assert.doesNotThrow(()=>f.el('report-pdf').onclick());await tick();cleared(f);assert.equal(f.calls.length,count);
});
test('blocked storage during a PDF response clears private content and suppresses download',async()=>{
 const f=await ready(),wait=deferred();f.setRespond(()=>wait.promise);f.el('report-pdf').onclick();globalThis.sessionStorage.getItem=()=>{throw new Error('Storage blocked');};wait.resolve(new Response('%PDF-1.7'));await tick();cleared(f);
});
test('detached old panel completion clears only its own root without reloading newer navigation',async()=>{
 const f=await ready(),wait=deferred();f.setRespond(()=>wait.promise);f.el('report-pdf').onclick();f.root.isConnected=false;f.switch();wait.resolve(new Response('%PDF-1.7'));await tick();assert.equal(f.root.innerHTML,'');assert.equal(objects,0);assert.equal(downloads,0);assert.equal(reloads,0);
});

test('an initially detached mismatched panel does not reload the current route',async()=>{
 const f=fixture('new-token',false);await tick();assert.equal(f.root.innerHTML,'');assert.equal(reloads,0);assert.equal(f.calls.filter(c=>c.url.includes('/reports')).length,0);
});
