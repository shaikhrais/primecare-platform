import {build} from 'esbuild';import {test} from 'node:test';import assert from 'node:assert/strict';import {createServer} from 'node:http';import {readFile} from 'node:fs/promises';
import {createRequire} from 'node:module';
const require=createRequire(import.meta.url);
const playwright=process.env.SCREEN_TEXT_PLAYWRIGHT_PATH?require(process.env.SCREEN_TEXT_PLAYWRIGHT_PATH):require('playwright');
const {outputFiles}=await build({stdin:{contents:"import {screenTextEditor} from './websites/typescript/src/screen-text-editor'; screenTextEditor(document.getElementById('editor'),location.origin,new URLSearchParams(location.search).get('lang')||'en');",resolveDir:process.cwd()},bundle:true,platform:'browser',write:false,format:'iife'});
const server=createServer((req,res)=>{res.setHeader('content-type','text/html');res.end(`<html><head><style>body{font-family:sans-serif} .table-scroll{overflow-x:auto;max-width:100%} textarea{width:180px} input,select,button{min-height:36px}</style></head><body><div id=editor></div><script>${outputFiles[0].text.replaceAll('</script','<\\/script')}</script></body></html>`);});
await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));const base='http://127.0.0.1:'+server.address().port;
const browser=await playwright.chromium.launch({headless:true});
try{
 for(const language of ['en','fr','es'])await test(`editor saves safely, preserves stale drafts, restores, exports/imports in ${language}`,async()=>{
  const page=await browser.newPage({viewport:{width:language==='en'?1280:390,height:900}});
  let version=0,locales={en:{title:'Initial'},fr:{title:'Initial français'},es:{title:'Inicial'}};const history=[];
  await page.route('**/v1/governance/screen-text**',async route=>{
   const request=route.request(),path=new URL(request.url()).pathname;let status=200,data;
   if(path.endsWith('/screen-text'))data={screens:[{id:'fixture',version}]};
   else if(path.endsWith('/history'))data={history:history.toReversed()};
   else if(request.method()==='PUT'){
    const body=request.postDataJSON();if(body.version!==version){status=409;data={error:'Conflict'};}
    else{const previous=structuredClone(locales);locales=body.locales;version++;history.push({version,actor_id:'platform-editor',previous_locales:previous,locales:structuredClone(locales),created_at:'2026-10-13T00:00:00Z'});data={screen:'fixture',version,locales};}
   }else data={screen:'fixture',version,locales};
   await route.fulfill({status,contentType:'application/json',body:JSON.stringify(data)});
  });
  await page.goto(base+'/?lang='+language);await page.locator('textarea[data-locale=en]').waitFor();
  await page.locator('textarea[data-locale=en]').fill('<script>window.injected=true</script>');
  await page.locator('[data-cy=text-form] button:not([type="button"])').click();
  await page.waitForFunction(()=>document.querySelector('[data-version="1"]'));
  assert.equal(version,1);assert.equal(await page.evaluate(()=>window.injected),undefined);
  // Simulate a competing successful save and prove the draft survives a 409.
  version=2;await page.locator('textarea[data-locale=en]').fill('Unsaved competing draft');
  await page.locator('[data-cy=text-form] button:not([type="button"])').click();
  await page.waitForFunction(()=>!document.querySelector('textarea').disabled);
  assert.equal(await page.locator('textarea[data-locale=en]').inputValue(),'Unsaved competing draft');assert.equal(version,2);
  page.once('dialog',dialog=>dialog.accept());await page.locator('[data-cy=text-reload]').click();
  await page.waitForFunction(()=>!document.querySelector('textarea').disabled);
  page.once('dialog',dialog=>dialog.accept());await page.locator('[data-version="1"]').click();
  await page.waitForFunction(()=>document.querySelector('[data-version="3"]'));assert.equal(version,3);
  const download=page.waitForEvent('download');await page.locator('[data-cy=text-export]').click();assert.equal((await download).suggestedFilename(),'fixture.json');
  const imported={version:1,screen:'fixture',locales:{en:{title:'Imported'},fr:{title:'Importé'},es:{title:'Importado'}}};
  await page.locator('[data-cy=text-import]').setInputFiles({name:'fixture.json',mimeType:'application/json',buffer:Buffer.from(JSON.stringify(imported))});
  await page.waitForFunction(()=>document.querySelector('textarea')?.value==='Imported');assert.equal(version,3);
  await page.locator('[data-cy=text-form] button:not([type="button"])').click();await page.waitForFunction(()=>document.querySelector('[data-version="4"]'));assert.equal(locales.en.title,'Imported');
  await page.close();
 });
}finally{
 await browser.close();await new Promise(resolve=>server.close(resolve));
}
