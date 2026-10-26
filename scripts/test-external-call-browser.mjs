import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {chromium} from 'playwright';
import {createServer} from 'node:http';
import {mkdir,writeFile,readFile} from 'node:fs/promises';
const fake=`export class Call{};export class Device{constructor(){window.fixtureDevices??=[];window.fixtureDevices.push(this);this.events={};}on(k,f){this.events[k]=f;}emit(k){this.events[k]?.();}updateToken(){this.updated=true;}async connect(options){window.fixtureConnect=options;const events={};return window.fixtureCall={on(k,f){events[k]=f;},emit(k){events[k]?.();},mute(value){this.muted=value;},disconnect(){this.closed=true;events.disconnect?.();}};}destroy(){this.closed=true;}}`;
const bundle=await build({entryPoints:['websites/typescript/src/external-calls.ts'],bundle:true,write:false,platform:'browser',format:'esm',plugins:[{name:'test-sdk',setup(build){
 build.onResolve({filter:/^@twilio\/voice-sdk$/},()=>({path:'sdk',namespace:'fixture'}));
 build.onLoad({filter:/.*/,namespace:'fixture'},()=>({contents:fake,loader:'js'}));
}}]});
const css=await readFile('websites/typescript/src/styles.css','utf8');
const html=`<!doctype html><html lang="en"><head><meta name="viewport" content="width=device-width,initial-scale=1"><link rel="stylesheet" href="/styles.css"><style>:root{--font-family:system-ui;--font-size-body:16px;--color-primary:#006b68;--color-surface:#fff;--color-background:#f5f8fa;--color-text:#18323b;--color-secondary:#536a73}body{padding:16px}</style></head><body><main id="dialer"></main></body></html>`;
const server=createServer((req,res)=>{
 res.setHeader('content-type',req.url==='/dialer.mjs'?'text/javascript':req.url==='/styles.css'?'text/css':'text/html');
 res.end(req.url==='/dialer.mjs'?bundle.outputFiles[0].text:req.url==='/styles.css'?css:html);
});
await new Promise(r=>server.listen(0,'127.0.0.1',r));
let browser;
try{
 await mkdir('test-results/external-calls',{recursive:true});
 browser=await chromium.launch({headless:true,executablePath:process.env.CALL_BROWSER_EXECUTABLE||undefined,args:['--no-sandbox','--use-fake-device-for-media-stream']});
 const page=await browser.newPage(),requests=[];
 let revoked=false;
 await page.route('https://gateway.invalid/v1/external-calls/**',async route=>{
  const req=route.request();
  if(req.method()==='OPTIONS')return route.fulfill({status:204,headers:{'access-control-allow-origin':'*','access-control-allow-methods':'POST, OPTIONS','access-control-allow-headers':'authorization,content-type,idempotency-key'}});
  const body=req.postDataJSON();requests.push({path:new URL(req.url()).pathname,body});
  if(revoked)return route.fulfill({status:403,headers:{'access-control-allow-origin':'*'},contentType:'application/json',body:'{"error":"forbidden"}'});
  const payload=req.url().endsWith('/prepare')?{ticket:'11111111-1111-4111-8111-111111111111',phone:body.phone,callerId:'+16479302223',token:'fixture-only',status:'prepared',expiresAt:Date.now()+120000}
   :req.url().endsWith('/state')?(requests.some(r=>r.path.endsWith('/prepare'))?{status:'active',ticket:'11111111-1111-4111-8111-111111111111',expiresAt:Date.now()+120000}:{status:'idle'}):{status:'ended'};
  await route.fulfill({status:200,headers:{'access-control-allow-origin':'*'},contentType:'application/json',body:JSON.stringify(payload)});
 });
 const fixtureOrigin='http://127.0.0.1:'+server.address().port;
 await page.context().grantPermissions(['microphone'],{origin:fixtureOrigin});
 await page.addInitScript(()=>{const native=navigator.mediaDevices.getUserMedia.bind(navigator.mediaDevices);window.fixtureMicRequests=0;window.fixtureMicTracks=[];navigator.mediaDevices.getUserMedia=async constraints=>{window.fixtureMicRequests++;const stream=await native(constraints);window.fixtureMicTracks.push(...stream.getTracks());return stream;};});
 await page.goto(fixtureOrigin);
 await page.evaluate(async()=>{
  sessionStorage.setItem('primecare_session','a'.repeat(43));
  const {ExternalCallsPanel}=await import('/dialer.mjs');
  window.fixturePanel=new ExternalCallsPanel(document.querySelector('main'),'https://gateway.invalid',sessionStorage.getItem('primecare_session'));
 });
 await page.locator('main').waitFor({state:'visible'});
 assert.equal(await page.evaluate(()=>window.fixtureDevices?.length??0),0);
 assert.equal(await page.evaluate(()=>window.fixtureMicRequests),0);
 await page.locator('[data-cy=external-call-microphone]').click();
 await page.waitForFunction(()=>document.querySelector('[data-cy=external-microphone-status]').textContent.includes('Microphone ready'));
 assert.equal(requests.some(r=>r.path.endsWith('/prepare')),false);
 assert.equal(await page.evaluate(()=>window.fixtureMicTracks.every(t=>t.readyState==='ended')),true);
 // Actual layout, not just CSS-string assertions. No live provider is used.
 for(const width of [320,390,768,1280]){
  await page.setViewportSize({width,height:900});
  const layout=await page.evaluate(()=>({overflow:document.documentElement.scrollWidth>innerWidth,
   controls:[...document.querySelectorAll('button')].map(el=>({width:el.getBoundingClientRect().width,height:el.getBoundingClientRect().height})),
   card:document.querySelector('main').getBoundingClientRect().width}));
  assert.equal(layout.overflow,false,'Horizontal overflow at '+width);
  assert.ok(layout.controls.every(b=>b.height>=48&&b.width>=48));
  assert.ok(layout.card<=672);
 }
 await page.setViewportSize({width:390,height:844});
 await page.screenshot({path:'test-results/external-calls/ui-mobile-ready.png',fullPage:true});
 const phone=page.locator('[data-cy=external-call-phone]'),mute=page.locator('[data-cy=external-call-mute]');
 await phone.fill('+16475550123');
 assert.equal(await phone.evaluate(el=>el.checkValidity()),true);
 await page.locator('[data-cy=external-call-dial]').click();
 await page.waitForFunction(()=>window.fixtureCall);
 assert.equal(await phone.isDisabled(),true);
 assert.deepEqual(await page.evaluate(()=>window.fixtureConnect),{params:{Ticket:'11111111-1111-4111-8111-111111111111'}});
 await page.evaluate(()=>window.fixtureCall.emit('accept'));
 assert.match(await page.locator('[data-cy=external-call-status]').textContent(),/Connected/);
 assert.equal(await page.locator('main').getAttribute('data-call-state'),'connected');
 assert.equal(await page.locator('[data-cy=external-call-caller]').textContent(),'+16479302223');
 await page.screenshot({path:'test-results/external-calls/ui-mobile-connected.png',fullPage:true});
 await page.evaluate(()=>window.fixtureDevices[0].emit('tokenWillExpire'));
 await page.waitForFunction(()=>window.fixtureDevices[0].updated===true);
 await mute.click();
 assert.equal(await page.evaluate(()=>window.fixtureCall.muted),true);
 assert.equal(await mute.getAttribute('aria-pressed'),'true');
 await page.locator('[data-cy=external-call-end]').click();
 await page.waitForFunction(()=>window.fixtureDevices[0].closed);
 await page.waitForTimeout(100);
 assert.equal(requests.filter(r=>r.path.endsWith('/end')).length,1);
 assert.equal(await page.evaluate(()=>window.fixtureCall.closed),true);
 assert.equal(await phone.isEnabled(),true);
 assert.equal(await mute.textContent(),'Mute');
 assert.equal(await mute.getAttribute('aria-pressed'),'false');
 // Regression: after ending a muted call, Mute must mute the next call too.
 await page.locator('[data-cy=external-call-dial]').click();
 await page.waitForFunction(()=>window.fixtureDevices.length===2);
 await mute.click();
 assert.equal(await page.evaluate(()=>window.fixtureCall.muted),true);
 await page.locator('[data-cy=external-call-end]').click();
 await page.evaluate(()=>window.fixturePanel.close());
 // Permission denial must stop before reservation or provider creation.
 const prepares=requests.filter(r=>r.path.endsWith('/prepare')).length;
 await page.evaluate(async()=>{const {ExternalCallsPanel}=await import('/dialer.mjs');navigator.mediaDevices.getUserMedia=async()=>{throw new DOMException('Denied','NotAllowedError');};window.fixturePanel=new ExternalCallsPanel(document.querySelector('main'),'https://gateway.invalid',sessionStorage.getItem('primecare_session'));});
 await page.waitForTimeout(100);
 // This fixture restores the previous reservation; clear it before testing denial.
 await page.locator('[data-cy=external-call-end]').click();
 await page.locator('[data-cy=external-call-phone]').fill('+16475550123');
 await page.locator('[data-cy=external-call-dial]').click();
 await page.waitForFunction(()=>document.querySelector('[data-cy=external-call-status]').textContent.includes('Microphone blocked'));
 assert.equal(requests.filter(r=>r.path.endsWith('/prepare')).length,prepares);
 assert.equal(await page.evaluate(()=>window.fixtureDevices.length),2);
 await page.evaluate(()=>window.fixturePanel.close());
 const report={source:process.env.GITHUB_SHA,passed:true,realBrowser:true,providerSdkStubbed:true,noAutomaticCall:true,opaqueTicketOnly:true,muteAndHangup:true,tokenRenewal:true,cleanup:true,mobileWidths:[320,390,768,1280],noHorizontalOverflow:true,touchTargetsAtLeast48px:true,phoneLockedWhileCalling:true,muteStateResetsBetweenCalls:true,microphoneRequestedOnlyByUser:true,enableMicrophoneDoesNotReserve:true,preflightTracksStopped:true,deniedMicrophoneNeverPreparesOrDials:true,livePhoneTraffic:false};
 await writeFile('test-results/external-calls/browser.json',JSON.stringify(report,null,2)+'\n');
 console.log('EXTERNAL_CALL_BROWSER '+JSON.stringify(report));
}finally{await browser?.close();await new Promise(r=>server.close(r));}
