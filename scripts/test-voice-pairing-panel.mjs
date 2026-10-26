import {createServer} from 'node:http';
import {build} from 'esbuild';
import {chromium} from 'playwright';
import assert from 'node:assert/strict';
const source=(await build({entryPoints:['websites/typescript/src/voice-pairing-panel.ts'],bundle:true,format:'esm',write:false})).outputFiles[0].text;
const server=createServer((req,res)=>{res.setHeader('content-type',req.url==='/ui.js'?'text/javascript':'text/html');res.end(req.url==='/ui.js'?source:'<main></main><script type="module">import{voicePairingMarkup,bindVoicePairing}from"/ui.js";sessionStorage.setItem("primecare_session","fixture");document.querySelector("main").innerHTML=voicePairingMarkup();window.dispose=bindVoicePairing(document.querySelector("main"),"https://native.example","fixture");</script>');});
await new Promise(r=>server.listen(0,'127.0.0.1',r));let browser;
try{
 browser=await chromium.launch({headless:true,args:['--no-sandbox']});const page=await browser.newPage();let requests=0,deny=false;
 await page.route('https://native.example/**',async route=>{requests++;const req=route.request();assert.equal(req.headers().authorization,'Bearer fixture');assert.equal(req.postDataJSON().callSid,'CA'+'a'.repeat(32));assert.equal(await page.locator('input:visible').inputValue(),'');await route.fulfill({status:deny?503:200,contentType:'application/json',body:JSON.stringify(req.url().endsWith('/start')?{verificationRequested:true}:{verified:true})});});
 await page.goto('http://127.0.0.1:'+server.address().port);
 const open=async()=>{await page.getByLabel('Call reference',{exact:true}).fill('CA'+'a'.repeat(32));await page.getByRole('button',{name:'Continue verification',exact:true}).click();};
 const start=async()=>{await page.getByLabel('Eight digit call pairing code').fill('12345678');await page.getByRole('button',{name:'Send SMS code',exact:true}).click();};
 await open();await start();await page.getByText('Enter the SMS code',{exact:true}).waitFor();await page.getByLabel('Six digit SMS code').fill('123456');await page.getByRole('button',{name:'Verify call',exact:true}).click();await page.getByText('Call verified. Each task still requires your approval.',{exact:true}).waitFor();assert.equal(requests,2);
 await page.getByRole('button',{name:'Close verification',exact:true}).click();deny=true;await open();await start();await page.getByText('Verification unavailable. Contact reception.',{exact:true}).waitFor();assert.equal(requests,3);
 await page.getByRole('button',{name:'Close verification',exact:true}).click();await open();await page.getByLabel('Eight digit call pairing code').fill('12345678');await page.evaluate(()=>{sessionStorage.removeItem('primecare_session');window.dispatchEvent(new StorageEvent('storage'));});assert.equal(await page.locator('[data-cy=voice-pairing-flow] input').count(),0);assert.equal(requests,3);await page.evaluate(()=>window.dispose());console.log('PASS pairing success, unavailable runtime, code clearing, logout disposal; synthetic endpoint');
}finally{await browser?.close();await new Promise(r=>server.close(r));}
