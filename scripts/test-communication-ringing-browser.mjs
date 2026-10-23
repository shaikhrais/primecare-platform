import {test} from 'node:test';import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';import {createServer} from 'node:http';import {chromium} from 'playwright';
test('real browser renders answer/decline/mute/hangup and handles caller cancellation',async()=>{
 const server=createServer((request,response)=>{
  const path=({'/twilio-ringing.mjs':'packages/shared/src/communications/twilio-ringing.mjs','/adapter-base.mjs':'packages/shared/src/communications/adapter-base.mjs'})[request.url];
  response.setHeader('content-type',path?'text/javascript':'text/html');response.end(path?readFileSync(path):'<main id="ring"></main>');
 });await new Promise(r=>server.listen(0,'127.0.0.1',r));let browser;
 try{
  browser=await chromium.launch({headless:true,executablePath:process.env.BUSINESS_TEST_CHROMIUM_EXECUTABLE||undefined,args:['--no-sandbox']});const page=await browser.newPage();await page.goto(`http://127.0.0.1:${server.address().port}`);
  await page.evaluate(async()=>{
   const {mountTwilioCallPanel}=await import('/twilio-ringing.mjs');
   window.setup=()=>{const listeners=new Map();const call={answered:0,rejected:0,ended:0,on(event,f){if(!listeners.has(event))listeners.set(event,new Set());listeners.get(event).add(f);},off(event,f){listeners.get(event)?.delete(f);},emit(event){for(const f of [...listeners.get(event)??[]])f();},accept(){this.answered++;this.emit('accept');},reject(){this.rejected++;},disconnect(){this.ended++;},mute(value){this.muted=value;}};window.call=call;window.session=mountTwilioCallPanel({element:document.getElementById('ring'),call,currentScope:()=>window.scope,authorizeAnswer:async()=>true});};window.scope='session-a';window.setup();
  });
  assert.equal(await page.getByRole('status').textContent(),'Incoming call');assert.equal(await page.evaluate(()=>call.answered),0);
  await page.getByRole('button',{name:'Answer',exact:true}).click();await page.getByRole('status').filter({hasText:'Call connected'}).waitFor();
  await page.getByRole('button',{name:'Mute',exact:true}).click();await page.getByRole('button',{name:'Unmute',exact:true}).waitFor();assert.equal(await page.evaluate(()=>call.muted),true);
  await page.getByRole('button',{name:'End call',exact:true}).click();assert.equal(await page.getByRole('status').textContent(),'Call ended');assert.equal(await page.evaluate(()=>call.ended),1);
  await page.evaluate(()=>setup());await page.getByRole('button',{name:'Decline',exact:true}).click();assert.equal(await page.evaluate(()=>call.rejected),1);assert.equal(await page.evaluate(()=>call.answered),0);
  await page.evaluate(()=>{setup();call.emit('cancel');});assert.equal(await page.getByRole('button',{name:'Answer',exact:true}).isDisabled(),true);
  await page.evaluate(()=>{setup();window.scope=null;});await page.getByRole('button',{name:'Answer',exact:true}).click();assert.equal(await page.evaluate(()=>call.answered),0);
 }finally{await browser?.close();await new Promise(r=>server.close(r));}
});
