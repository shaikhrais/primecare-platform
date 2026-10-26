// Diagnostic wrapper around the existing live acceptance. It observes safe
// protocol metadata only; it cannot modify auth, signaling, ICE or test results.
import {chromium} from 'playwright';import {mkdir,writeFile,readFile} from 'node:fs/promises';
const labels=JSON.parse(await readFile('tools/governance-production/internal-call-ui-registration.json','utf8')).locales.en,allowedLabels=new Set(Object.values(labels));
const report={harnessSource:process.env.GITHUB_SHA,deployedSources:[],responses:[],failures:[],mediaResponses:[],reads:[],browserStates:[],requestTimings:[]};
const launch=chromium.launch.bind(chromium);chromium.launch=async options=>{
 const browser=await launch({...options,...(process.env.CALL_BROWSER_EXECUTABLE?{executablePath:process.env.CALL_BROWSER_EXECUTABLE}:{})});report.browserVersion=browser.version();const newContext=browser.newContext.bind(browser);let serial=0;
 browser.newContext=async options=>{
  const context=await newContext(options),index=serial++,close=context.close.bind(context);
  context.on('page',page=>{
   const begins=new WeakMap();
   page.on('request',request=>begins.set(request,Date.now()));
   page.on('requestfinished',request=>{try{const url=new URL(request.url());if(url.hostname!=='primecare-api-gateway.itpro-mohammed.workers.dev'||!/^\/v1\/calls\/(?:directory|extension|dial|command|media|prepare)$/.test(url.pathname))return;let action;try{action=request.postDataJSON()?.action;}catch{}const timing=request.timing(),start=begins.get(request);report.requestTimings.push({browser:index,operation:url.pathname.split('/').at(-1),...(['read','inbox','heartbeat','accept','decline','end','expire','signal'].includes(action)?{action}:{}),startedAt:start,elapsedMilliseconds:start?Date.now()-start:null,serverWaitMilliseconds:timing.responseStart>=0&&timing.requestStart>=0?Math.round(timing.responseStart-timing.requestStart):null});if(report.requestTimings.length>500)report.requestTimings.shift();}catch{}});
   page.on('response',async response=>{try{
    const url=new URL(response.url());if(url.hostname!=='primecare-api-gateway.itpro-mohammed.workers.dev'||!/^\/v1\/calls\/(?:directory|extension|dial|command|media|prepare)$/.test(url.pathname))return;
    const timing=response.headers()['server-timing'];if(typeof timing==='string'&&timing.length<1024&&/^[a-z0-9 ;=",.-]+$/i.test(timing)){report.databaseTimings??=[];report.databaseTimings.push({browser:index,operation:url.pathname.split('/').at(-1),timing});if(report.databaseTimings.length>100)report.databaseTimings.shift();}const source=response.headers()['x-primecare-calls-source'];if(/^[a-f0-9]{40}$/.test(source??'')&&!report.deployedSources.includes(source))report.deployedSources.push(source);
    let action;try{action=response.request().postDataJSON()?.action;}catch{}if(!['read','inbox','heartbeat','accept','decline','end','expire','signal'].includes(action))action=undefined;
    const health=response.headers()['x-primecare-calls-health'];const safe={...(typeof health==='string'&&/^[a-z0-9_]{1,64}$/.test(health)?{health}:{}),browser:index,operation:url.pathname.split('/').at(-1),status:response.status(),...(action?{action}:{})};report.responses.push(safe);if(report.responses.length>80)report.responses.shift();
    if(response.status()>=400){const body=await response.json().catch(()=>({}));const known=['unavailable','unauthorized','forbidden','not_found','invalid_request','conflict','rate_limited'];report.failures.push({...safe,...(known.includes(body.error)?{error:body.error}:{})});if(report.failures.length>80)report.failures.shift();}
    if(safe.operation==='media')report.mediaResponses.push(safe);
    if(action==='read'&&response.status()===200&&report.reads.length<12){const body=await response.json();report.reads.push({browser:index,kind:body.kind,integerVersion:Number.isSafeInteger(body.version),members:body.members?.length,calls:body.calls?.map(c=>({status:c.status,offered:c.offered,answered:c.answered,signals:c.signals?.length}))});}
   }catch{}});
  });
  context.close=async(...args)=>{for(const page of context.pages()){try{const state=await page.evaluate(()=>({peers:window.__callPeers?.length,tracks:window.__callTracks?.length,status:document.querySelector('[data-cy=internal-call-status]')?.textContent}));report.browserStates.push({browser:index,...state,status:allowedLabels.has(state.status)?state.status:'redacted'});}catch{}}return close(...args);};return context;
 };return browser;
};
try{await import('./test-live-internal-calls.mjs');}finally{await mkdir('test-results/internal-calls',{recursive:true});await writeFile('test-results/internal-calls/browser-diagnostic.json',JSON.stringify(report,null,2)+'\n');console.log('CALL_BROWSER_DIAGNOSTIC '+JSON.stringify(report));}
