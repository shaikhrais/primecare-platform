import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {build} from 'esbuild';
import {resolve} from 'node:path';
import {createRequire} from 'node:module';
import {createBrowser} from './fixtures/care-dom-base.mjs';

// Actual bridge, manager, route resolution, renderer and client. DOM/CSS and fetch
// are isolated protocol probes, not browser, PostgreSQL, visual or API acceptance.
if(Object.keys(process.env).some(key=>/(?:DATABASE_URL|DB_URL|CLOUDFLARE|CF_API|PGPASSWORD)/i.test(key)))throw Error('Database/Cloudflare credentials forbidden in Look fixture contracts');
const source=await readFile('scripts/test-look-manager.mjs','utf8');
const theme=JSON.parse(await readFile('scripts/fixtures/look-test-theme.json','utf8'));
const result=await build({stdin:{contents:`export {presentPlatformFixture} from './scripts/fixtures/platform-browser-bootstrap';export {renderLookReview} from './websites/typescript/src/look-review';export {requireScreenManager} from './packages/primecare_ui/web/screen-manager';export {resolveManagedRoute} from './websites/typescript/src/managed-routes';`,resolveDir:process.cwd()},bundle:true,platform:'node',format:'cjs',write:false,metafile:true});
const module={exports:{}};new Function('require','module','exports',result.outputFiles[0].text)(createRequire(import.meta.url),module,module.exports);
const api=module.exports,gateway='https://fixture.invalid';
function fixture(t,locale='en'){
 const names=['document','window','location','history','sessionStorage','localStorage','MutationObserver','Element','HTMLElement','HTMLInputElement','HTMLDialogElement','FormData','addEventListener','removeEventListener','getComputedStyle','fetch'];
 const descriptors=new Map(names.map(name=>[name,Object.getOwnPropertyDescriptor(globalThis,name)]));
 const f=createBrowser(gateway+'/appearance-review?enable-semantics=true');f.doc.documentElement.lang=locale;
 const styles=()=>{const values=new Map();return {setProperty:(key,value)=>values.set(key,String(value)),getPropertyValue:key=>values.get(key)??'',removeProperty:key=>values.delete(key)};};
 for(const host of [f.doc.documentElement,f.doc.body,f.root])host.style=styles();
 f.root.classList={add(){},remove(){}};f.root.scrollTo=()=>{};
 f.events.CSS={supports:()=>true};f.events.scrollTo=()=>{};f.events.location=f.location;
 Object.defineProperty(f.location,'origin',{value:gateway});
 f.events.getComputedStyle=host=>({getPropertyValue:key=>key==='--primecare-responsive-styles'?'1':host.style.getPropertyValue(key)});
 globalThis.getComputedStyle=f.events.getComputedStyle;
 const requests=[];let respond=async()=>{throw Error('Unexpected Look request');};
 globalThis.fetch=(url,options)=>{requests.push({url,options});return respond(url,options);};
 t.after(()=>{f.event('pagehide',{persisted:false});for(const[name,descriptor]of descriptors)if(descriptor)Object.defineProperty(globalThis,name,descriptor);else delete globalThis[name];});
 return {...f,requests,setRespond:fn=>{respond=fn;}};
}
function entry(){
 const match=source.match(/const \{outputFiles(?:,metafile)?\}=await build\((\{stdin:.*?write:false(?:,metafile:true)?\})\);/);
 assert.ok(match,'Actual Look browser build is present');
 return new Function('theme','process','return '+match[1])(theme,process);
}
function deferred(){let resolve;const promise=new Promise(yes=>{resolve=yes;});return {promise,resolve};}

test('original direct Look renderer shows configuration failure before session or API activity',async t=>{
 const f=fixture(t);let sessionReads=0;const read=f.sessionStorage.getItem;
 f.sessionStorage.getItem=key=>{sessionReads++;return read(key);};
 // This intentional production failure is caught by the renderer, not thrown as a pageerror.
 await api.renderLookReview(f.root,gateway);
 assert.match(f.root.textContent,/Missing manager at route boundary/);
 assert.equal(f.cy('look-form'),null);assert.equal(sessionReads,0);assert.deepEqual(f.requests,[]);
 assert.equal(f.sessionStorage.values.get('primecare_session'),'token-A');
});

test('Look fixture entry uses its existing theme and actual dependencies, not a replacement service',async()=>{
 const options=entry();assert.equal(options.write,false);assert.equal(options.metafile,true);
 assert.match(options.stdin.contents,/presentPlatformFixture\(root,/);assert.ok(options.stdin.contents.includes(JSON.stringify(theme)));
 assert.match(source,/readFile\('scripts\/fixtures\/look-test-theme.json','utf8'\)/);
 assert.match(source,/readFile\('websites\/typescript\/src\/styles.css','utf8'\)/);
 assert.match(source,/page\.goto\(base\+'\/appearance-review\?enable-semantics=true'\)/);
 assert.doesNotMatch(options.stdin.contents,/installScreenManager|new ScreenManager|sessionStorage\.setItem/);
 const compiled=await build({...options,write:false,metafile:true});const inputs=Object.keys(compiled.metafile.inputs);
 for(const path of ['websites/typescript/src/screen-presentation.ts','websites/typescript/src/managed-routes.ts','websites/typescript/src/look-review.ts','packages/primecare_ui/web/screen-manager.ts'])assert.ok(inputs.some(input=>input.endsWith(path)),path);
 assert.ok(!inputs.some(path=>path.includes('cloudflare/workers/src/look/service')||path.includes('node_modules/pg/')));
 assert.match(source,/for\(const lang of \['en','fr','es'\]\)for\(const width of \[320,1440\]\)/);
});

for(const locale of ['en','fr','es'])test('actual Look fixture dispatch at its managed route reaches its authenticated GET in '+locale,{timeout:1000},async t=>{
 const f=fixture(t,locale),arrival=deferred(),response=deferred();f.setRespond(()=>{arrival.resolve();return response.promise;});
 const route=api.resolveManagedRoute(location.pathname,'');assert.equal(route.adapter,'look');assert.equal(route.route,'/appearance-review');
 let pending;const start=(...args)=>{assert.equal(args[0],f.root);assert.deepEqual(args[1],theme);assert.equal(args[2],gateway);pending=api.presentPlatformFixture(...args);return pending;};
 const executable=entry().stdin.contents.replace(/import\s+\{[^}]+\}\s+from\s+['"][^'"]+['"];?/g,'');
 new Function('presentPlatformFixture','renderLookReview',executable)(start,api.renderLookReview);
 assert.ok(pending,'The actual browser entry must invoke the real bootstrap');
 // Attach rejection handling before waiting for its initial request.
 const completion=pending.then(()=>({ok:true}),error=>({error}));
 let timer;
 try{
  await Promise.race([arrival.promise,new Promise((_,reject)=>{timer=setTimeout(()=>reject(Error('Actual Look request did not arrive')),200);})]);
  assert.equal(f.requests.length,1);assert.equal(f.requests[0].url,gateway+'/v1/governance/look');
  assert.deepEqual(f.requests[0].options,{method:'GET',cache:'no-store',headers:{authorization:'Bearer token-A'}});
  api.requireScreenManager(f.root).enter(route.id,route.route);
  assert.equal(f.sessionStorage.values.get('primecare_session'),'token-A');assert.deepEqual(f.assigned,[]);
 }finally{
  clearTimeout(timer);
  // Release the protocol response only after invalidating this probe's owner.
  // Real route/session guards must prevent its late response from drawing.
  f.go('/growth?enable-semantics=true');response.resolve(Response.json({synthetic:true}));
  const settled=await completion;assert.equal(settled.error,undefined);
 }
 assert.equal(f.cy('look-form'),null);assert.equal(f.requests.length,1);
});

test('invalid fixture theme still fails before the actual Look renderer can issue a request',async t=>{
 const f=fixture(t);await assert.rejects(api.presentPlatformFixture(f.root,{},gateway,()=>api.renderLookReview(f.root,gateway)),/Missing or invalid portal theme/);
 assert.deepEqual(f.requests,[]);
});
test('missing Look session still redirects without an API request under the real bridge',async t=>{
 const f=fixture(t);f.sessionStorage.removeItem('primecare_session');
 await api.presentPlatformFixture(f.root,theme,gateway,()=>api.renderLookReview(f.root,gateway));
 assert.deepEqual(f.requests,[]);assert.deepEqual(f.assigned,['/login?enable-semantics=true']);
});
