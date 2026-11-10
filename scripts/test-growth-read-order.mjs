import {test} from 'node:test';
import assert from 'node:assert/strict';
import {createGrowthDOM,presentGrowth,closeGrowthDOM,renderGrowth} from './fixtures/growth-jsdom.mjs';
import {emptyGrowthReadModel} from './fixtures/growth-read-model.mjs';

const tick=()=>new Promise(resolve=>setImmediate(resolve));
for(const stale of ['success','failure'])await test('CEO remount keeps newest result after an older refresh '+stale,async()=>{
 const dom=createGrowthDOM('https://primecare-corporate.pages.dev/growth?enable-semantics=true');
 sessionStorage.setItem('primecare_session','synthetic-renderer-session');
 const root=document.querySelector('#app'),pending=[];
 globalThis.fetch=()=>new Promise(resolve=>pending.push(resolve));
 const response=total=>Response.json({...emptyGrowthReadModel,stats:{total,overdue:0}});
 try{
  const initial=presentGrowth(root,'https://gateway.test');
  pending.shift()(response(0));await initial;
  for(const key of ['business_ops','plan','intake'])assert.equal(root.querySelector('[data-cy=growth-nav-'+key+']'),null,'unavailable actions must not gain navigation');
  const refresh=()=>root.querySelector('[data-cy=growth-refresh]').click();
  refresh();refresh();assert.equal(pending.length,1,'repeat refresh is blocked while loading');
  // A new route owner may mount the same registered page before the old read
  // returns. Its response must win; do not bypass the loading control guard.
  const replacement=renderGrowth(root,'https://gateway.test');
  assert.equal(pending.length,2);
  pending[1](response(7));await replacement;await tick();await tick();
  const summary=()=>root.querySelector('[data-cy=growth-summary] .metric strong')?.textContent;
  assert.equal(summary(),'7');
  pending[0](stale==='success'?response(99):Response.json({error:'unavailable'},{status:503}));
  await tick();await tick();
  assert.equal(summary(),'7','an older request must not replace the newest CEO summary or show a stale error');
  assert.equal(root.querySelector('[data-cy=growth-error]'),null);
 }finally{closeGrowthDOM(dom);}
});

await test('growth renderer still rejects a missing Screen Manager before HTTP',async()=>{
 const dom=createGrowthDOM('https://primecare-corporate.pages.dev/growth?enable-semantics=true');
 sessionStorage.setItem('primecare_session','synthetic-renderer-session');
 let requests=0;globalThis.fetch=async()=>{requests++;throw Error('unexpected HTTP');};
 const root=document.querySelector('#app');
 try{
  await assert.rejects(renderGrowth(root,'https://gateway.test'),/Missing manager at route boundary/);
  assert.equal(requests,0);
  assert.ok(root.querySelector('[data-cy=error-state]'));
 }finally{closeGrowthDOM(dom);}
});
