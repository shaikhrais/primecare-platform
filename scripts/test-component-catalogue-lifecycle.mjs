import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {parseHTML} from 'linkedom';

const built=await build({entryPoints:['packages/primecare_ui/web/component-catalogue.ts'],bundle:true,platform:'node',format:'esm',write:false});
const {PrimeComponentFactory}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
function fixture(){
 const {document,Event}=parseHTML('<html><head></head><body><main id="root"></main></body></html>');
 const root=document.getElementById('root');
 return {document,Event,root,kit:new PrimeComponentFactory(root,'lifecycle-test')};
}
test('individual countdown disposal blocks explicit and visibility ticks',()=>{
 const {kit,root,document,Event}=fixture();let now=0,finished=0;
 try {
  const timer=kit.countdown(10000,{now:()=>now,onFinish:()=>finished++});root.append(timer.element);
  assert.equal(root.querySelector('[data-cy="component-catalogue-countdown-value"]').textContent,'10');
  timer.dispose();timer.dispose();now=10001;timer.tick();document.dispatchEvent(new Event('visibilitychange'));
  assert.equal(finished,0);
  assert.equal(root.querySelector('[data-cy="component-catalogue-countdown-value"]').textContent,'10');
 } finally {kit.dispose();}
});
test('async retry clears old alert semantics while retaining busy and recovery states',async()=>{
 const {kit,root}=fixture();let finish;
 const text=value=>{const p=root.ownerDocument.createElement('p');p.textContent=value;return p;};
 try {
  const region=kit.asyncRegion('card','initial',async()=>{throw Error('unavailable');},text);root.append(region.element);
  await region.load('failed',async()=>{throw Error('unavailable');});
  assert.equal(region.element.getAttribute('role'),'alert');
  const retry=region.load('retry',()=>new Promise(resolve=>finish=resolve));
  assert.equal(region.element.getAttribute('aria-busy'),'true');
  assert.equal(region.element.getAttribute('role'),null);
  finish('recovered');await retry;
  assert.equal(region.element.textContent,'recovered');
  assert.equal(region.element.getAttribute('aria-busy'),null);
 } finally {kit.dispose();}
});
