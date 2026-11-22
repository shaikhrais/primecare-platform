import assert from 'node:assert/strict';
import {createServer} from 'node:http';
import fs from 'node:fs/promises';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {chromium} from '@playwright/test';
const root=path.resolve(path.dirname(fileURLToPath(import.meta.url)),'../..');
const directory=path.join(root,'packages/primecare_kitchen_sink_web/dist');
const server=createServer(async(req,res)=>{
  const route=new URL(req.url,'http://fixture.test').pathname;
  const file=path.resolve(directory,'.'+(route==='/'?'/index.html':route));
  if(!file.startsWith(directory+path.sep)){res.writeHead(404).end();return;}
  try{const data=await fs.readFile(file);res.setHeader('content-type',file.endsWith('.js')?'text/javascript':file.endsWith('.css')?'text/css':'text/html');res.end(data);}catch{res.writeHead(404).end();}
});
await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
let browser;
try{
  browser=await chromium.launch({headless:true,...(process.env.PRIMECARE_CHROMIUM_EXECUTABLE?{executablePath:process.env.PRIMECARE_CHROMIUM_EXECUTABLE,args:['--no-sandbox']}: {})});
  const page=await browser.newPage({viewport:{width:1280,height:900}}),errors=[];
  page.on('pageerror',error=>errors.push(error.message));
  const origin='http://127.0.0.1:'+server.address().port;
  await page.route('**/*',route=>new URL(route.request().url()).origin===origin?route.continue():route.abort());
  await page.goto(origin+'/?enable-semantics=true');
  assert.match(await page.locator('[data-cy=kitchen-sink-root]').evaluate(el=>getComputedStyle(el).fontFamily),/Inter|system-ui|sans-serif/);
  const captures=path.join(root,'artifacts/kitchen-sink-visual');await fs.mkdir(captures,{recursive:true});
  for(const [device,width,height] of [['desktop',1440,1000],['tablet',820,1180],['mobile',390,844]]){
    await page.setViewportSize({width,height});
    for(const theme of ['light','dark']){
      if((await page.locator('[data-cy=kitchen-sink-root]').getAttribute('data-theme'))!==theme)await page.locator('[data-cy=ks-theme]').click();
      await page.screenshot({path:path.join(captures,device+'-'+theme+'.png'),fullPage:true,animations:'disabled'});
    }
  }
  const assetRegistry=JSON.parse(await fs.readFile(path.join(root,'packages/primecare_ui/assets/original/registry.json'),'utf8'));
  const assetKeys=Object.keys(assetRegistry.assets).sort();
  assert.deepEqual((await page.locator('[data-cy^="ks-asset-"] figcaption').allTextContents()).sort(),assetKeys);
  assert.equal(await page.locator('[data-cy^="ks-asset-"] svg[aria-hidden="true"]').count(),assetKeys.length);
  await page.locator('[data-cy=ks-assets] summary').click();
  for(const [device,width,height] of [['desktop',1440,1000],['mobile',390,844]]){
    await page.setViewportSize({width,height});
    assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth<=document.documentElement.clientWidth),true);
    for(const theme of ['light','dark']){
      if((await page.locator('[data-cy=kitchen-sink-root]').getAttribute('data-theme'))!==theme)await page.locator('[data-cy=ks-theme]').click();
      await page.locator('[data-cy=ks-assets]').screenshot({path:path.join(captures,'assets-'+device+'-'+theme+'.png'),animations:'disabled'});
    }
  }
  await page.locator('[data-cy=ks-assets] summary').click();
  await page.setViewportSize({width:1280,height:900});
  if((await page.locator('[data-cy=kitchen-sink-root]').getAttribute('data-theme'))==='dark')await page.locator('[data-cy=ks-theme]').click();
  const cy=id=>page.locator('[data-cy="'+id+'"]');
  await cy('ks-results').waitFor();assert.equal(await cy('ks-results').textContent(),'36 / 36');
  assert.equal(await page.locator('[data-cy^="ks-story-"]').count(),36);
  assert.equal(await page.evaluate(()=>{const ids=[...document.querySelectorAll('[id]')].map(e=>e.id);return ids.length===new Set(ids).size;}),true);
  await cy('ks-preview-button').locator('[data-cy$="-normal"]').click();assert.equal(await cy('ks-output-button').textContent(),'1');
  await cy('ks-preview-input').locator('[data-cy^="component-catalogue-input-"]:not([data-cy$="-error"])').fill('Retained input');
  await cy('ks-preview-form').locator('[data-cy^="component-catalogue-input-"]:not([data-cy$="-error"])').fill('Independent form draft');
  await cy('ks-preview-form').locator('[data-cy^="component-catalogue-multiline-"]:not([data-cy$="-error"])').fill('Independent multiline draft');
  await cy('ks-search').fill('PrimeComponentFactory.field');assert.equal(await cy('ks-results').textContent(),'2 / 36');
  await cy('ks-search').fill('');await cy('ks-locale').selectOption('fr');
  assert.equal(await cy('ks-preview-input').locator('[data-cy^="component-catalogue-input-"]:not([data-cy$="-error"])').inputValue(),'Retained input');
  assert.equal(await cy('ks-preview-form').locator('[data-cy^="component-catalogue-input-"]:not([data-cy$="-error"])').inputValue(),'Independent form draft');
  assert.equal(await cy('ks-preview-form').locator('[data-cy^="component-catalogue-multiline-"]:not([data-cy$="-error"])').inputValue(),'Independent multiline draft');
  await cy('ks-theme').click();assert.equal(await cy('kitchen-sink-root').getAttribute('data-theme'),'dark');
  await cy('ks-preview-dialog').locator('[data-cy^="component-catalogue-button-"]').click();
  assert.equal(await cy('ks-preview-dialog').locator('[data-cy^="component-catalogue-dialog-"]').getAttribute('open'),'');
  await cy('ks-preview-dialog').locator('[data-cy^="component-catalogue-cancel-"]').click();
  await page.setViewportSize({width:375,height:812});
  assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth<=document.documentElement.clientWidth),true);
  const result=await page.evaluate(async()=>{
    const {showcase,mountKitchenSink}=await import('/assets/app.js');
    const root=document.querySelector('[data-cy=kitchen-sink-root]');
    const retained=root.querySelector('[data-cy$="-normal"]');
    showcase.dispose();retained.click();
    const clean=root.children.length===0;
    const next=mountKitchenSink(root,{bridgeTheme:true,locale:'es'});
    const result=root.querySelector('[data-cy=ks-results]').textContent;next.dispose();
    return {clean,result,restored:root.children.length===0};
  });
  assert.deepEqual(result,{clean:true,result:'36 / 36',restored:true});assert.deepEqual(errors,[]);
  console.log('PASS: all canonical asset previews with desktop/mobile light/dark captures, 36 real component previews, unique IDs, actions, draft/search/locale retention, theme, modal, mobile overflow, teardown and remount. Local synthetic examples only.');
}finally{await browser?.close();await new Promise(resolve=>server.close(resolve));}
