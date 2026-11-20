/** Requested screenshots of the actual EMS HTML renderer with isolated sample API data. */
import {chromium} from '@playwright/test';
import {createServer} from 'node:http';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {resolve} from 'node:path';
import assert from 'node:assert/strict';
const dir=resolve('test-results/requested-screenshots');await mkdir(dir,{recursive:true});
const html=await readFile('test-results/screen-preview/PrimeCare_Interactive_Preview.html');
const server=createServer((req,res)=>{res.setHeader('content-type','text/html');res.end(html);});
await new Promise(r=>server.listen(0,'127.0.0.1',r));const origin='http://127.0.0.1:'+server.address().port;
const browser=await chromium.launch({headless:true});const context=await browser.newContext();const external=[],errors=[];
await context.route('**/*',async route=>{const url=route.request().url();if(/^https?:/.test(url)&&!url.startsWith(origin+'/')){external.push(url);await route.abort();}else await route.continue();});
const page=await context.newPage();page.on('pageerror',e=>errors.push(e.message));
try{
 await page.goto(origin,{waitUntil:'domcontentloaded'});
 await page.waitForFunction(()=>document.querySelector('iframe')?.contentDocument?.querySelector('.ems-widget'));
 await page.locator('#preview-settings').evaluate(el=>el.open=true);
 for(let i=0;i<5;i++){await page.locator('#advance').click();await page.waitForTimeout(120);}
 await page.locator('#preview-settings').evaluate(el=>el.open=false);
 const frame=()=>page.frames().find(f=>f!==page.mainFrame());
 for(const[name,width,height]of [['desktop',1440,1000],['tablet',820,1180],['mobile',390,844]]){
  await page.setViewportSize({width,height});await page.waitForTimeout(250);
  assert.ok(await frame().locator('.ems-trend-line').count(),'EMS traffic chart must be rendered');
  assert.equal(await frame().locator('[data-cy=login-form]').count(),0);
  await frame().locator('body').screenshot({path:dir+'/ems-'+name+'.png'});
 }
 assert.deepEqual(errors,[]);assert.deepEqual(external,[]);
 await writeFile(dir+'/capture-receipt.json',JSON.stringify({source:process.env.GITHUB_SHA,ems:'actual HTML EMS renderer with isolated synthetic API responses',themeCenter:'actual Dart ThemeSettingsDrawer render',productionConnection:false,errors,external},null,2));
}finally{await context.close();await browser.close();await new Promise(r=>server.close(r));}
