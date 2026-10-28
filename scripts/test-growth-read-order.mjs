import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {JSDOM} from 'jsdom';
import {mkdtemp,writeFile} from 'node:fs/promises';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {pathToFileURL} from 'node:url';
import {emptyGrowthReadModel} from './fixtures/growth-read-model.mjs';

const bundle=await build({entryPoints:['websites/typescript/src/growth/dashboard.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const file=join(await mkdtemp(join(tmpdir(),'growth-read-order-')),'dashboard.mjs');
await writeFile(file,bundle.outputFiles[0].text);
const {renderGrowth}=await import(pathToFileURL(file).href);
const tick=()=>new Promise(resolve=>setImmediate(resolve));
for(const stale of ['success','failure'])await test('CEO refresh keeps newest result after an older '+stale,async()=>{
 const dom=new JSDOM('<div id="app"></div>',{url:'https://primecare-corporate.pages.dev/growth?enable-semantics=true'});
 for(const key of ['window','document','location','history','sessionStorage','localStorage','HTMLElement','HTMLInputElement','HTMLSelectElement','HTMLButtonElement','HTMLDetailsElement','HTMLFormElement','Element','Node','FormData'])globalThis[key]=dom.window[key];
 globalThis.getComputedStyle=dom.window.getComputedStyle.bind(dom.window);
 sessionStorage.setItem('primecare_session','synthetic-renderer-session');
 const root=document.querySelector('#app'),pending=[];
 globalThis.fetch=()=>new Promise(resolve=>pending.push(resolve));
 const response=total=>Response.json({...emptyGrowthReadModel,stats:{total,overdue:0}});
 try{
  const initial=renderGrowth(root,'https://gateway.test');
  pending.shift()(response(0));await initial;
  for(const key of ['business_ops','plan','intake'])assert.equal(root.querySelector('[data-cy=growth-nav-'+key+']'),null,'unavailable actions must not gain navigation');
  const refresh=()=>root.querySelector('[data-cy=growth-refresh]').click();
  refresh();refresh();assert.equal(pending.length,2);
  pending[1](response(7));await tick();await tick();
  const summary=()=>root.querySelector('[data-cy=growth-summary] .metric strong')?.textContent;
  assert.equal(summary(),'7');
  pending[0](stale==='success'?response(99):Response.json({error:'unavailable'},{status:503}));
  await tick();await tick();
  assert.equal(summary(),'7','an older request must not replace the newest CEO summary or show a stale error');
  assert.equal(root.querySelector('[data-cy=growth-error]'),null);
 }finally{dom.window.close();}
});
