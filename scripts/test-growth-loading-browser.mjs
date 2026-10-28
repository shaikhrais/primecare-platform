import {emptyGrowthReadModel as data} from './fixtures/growth-read-model.mjs';
/** Real Growth renderer with controlled HTTP failures; no login or database verification. */
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {createServer} from 'node:http';
import {mkdir,readFile,writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {launchCareBrowser} from './care-browser-launch.mjs';

const out='test-results/growth/loading';
await mkdir(out,{recursive:true});
const cy=id=>'[data-cy="'+id+'"]',hash=bytes=>createHash('sha256').update(bytes).digest('hex');
const criterion='growth-shared-loading-error-layout',cases=[];
const report={passed:false,scope:'Growth renderer shared layout, loading, HTTP and transport retry',wholeTaskVerified:false,criterion_results:{[criterion]:'failed'},cases,limitations:['Synthetic renderer session and HTTP fixtures; no real login, role grant, tenant-isolation or database verification','Initial loading uses the existing default EN locale; recovered errors exercise EN/FR/ES','No full accessibility, device installation or PWA verification']};
await writeFile(out+'/results.json',JSON.stringify(report,null,2)+'\n');
const bundle=await build({stdin:{contents:"export {renderGrowth} from './websites/typescript/src/growth/dashboard';",resolveDir:process.cwd()},bundle:true,format:'iife',globalName:'GrowthStateTest',write:false,metafile:true});
const css=await readFile('websites/typescript/src/styles.css'),policy=JSON.parse(await readFile('packages/shared/src/growth/registry.json'));
const sources={};
for(const path of [...Object.keys(bundle.metafile.inputs).filter(p=>p!=='<stdin>'&&!p.includes('node_modules/')),'scripts/test-growth-loading-browser.mjs','scripts/care-browser-launch.mjs','websites/typescript/src/styles.css'])sources[path]=hash(await readFile(path));
report.sources=sources;
// Only the complete empty read model needed by the production renderer. It grants no mutation.

const server=createServer((req,res)=>{
 const path=new URL(req.url,'http://test').pathname;
 if(path==='/app.js'){res.setHeader('content-type','text/javascript');res.end(bundle.outputFiles[0].text);}
 else if(path==='/styles.css'){res.setHeader('content-type','text/css');res.end(css);}
 else if(path==='/growth'){res.setHeader('content-type','text/html');res.end('<!doctype html><html><head><meta name="viewport" content="width=device-width,initial-scale=1"><title>Growth state regression</title><link rel="stylesheet" href="/styles.css"></head><body><div id="app"></div><script src="/app.js"></script><script>sessionStorage.setItem("primecare_session","synthetic-renderer-session");void GrowthStateTest.renderGrowth(document.getElementById("app"),location.origin)</script></body></html>');}
 else{res.writeHead(404);res.end();}
});
await new Promise(r=>server.listen(0,'127.0.0.1',r));
const origin='http://127.0.0.1:'+server.address().port,browser=await launchCareBrowser();
let failure;
try{
 for(const locale of ['en','fr','es'])for(const width of [320,1440]){
  const record=locale==='en'&&width===320,context=await browser.newContext({viewport:{width,height:900},...(record?{recordVideo:{dir:out+'/video',size:{width,height:900}}}:{})}),page=await context.newPage(),errors=[];
  page.on('pageerror',e=>errors.push(e.message));
  let release,arrived,mode='initial',requests=0,stage='initial-loading';
  const gate=new Promise(r=>release=r),requestArrived=new Promise(r=>arrived=r);
  const checkShell=async busy=>{
   assert.equal(await page.locator(cy('app-shell')).count(),1,stage+': page state must use the shared shell');
   assert.equal(await page.locator(cy('screen-founder-growth-dashboard')).getAttribute('aria-busy'),String(busy),stage+': shared content exposes loading state');
   assert.equal(await page.locator(cy('app-topbar')).isVisible(),false,stage+': unavailable identity hides chrome');
   assert.equal(await page.locator(cy('app-sidebar')).isVisible(),false,stage+': unavailable identity hides chrome');
  };
  const retryToSuccess=async()=>{
   mode='success';await page.locator(cy('growth-retry')).click();
   await page.locator(cy('growth-summary')).waitFor();
   assert.equal(await page.locator(cy('app-shell')).count(),1);
   assert.equal(await page.locator(cy('app-topbar')).isVisible(),true);
   assert.equal(await page.locator(cy('app-sidebar')).isVisible(),width>1024);
   assert.equal(await page.locator(cy('growth-notice')).innerText(),'');
  };
  try{
   await page.route('**/v1/governance/growth?**',async route=>{
    requests++;
    if(mode==='initial'){arrived();await gate;if(!page.isClosed())await route.fulfill({status:503,contentType:'application/json',body:'{"error":"unavailable"}'});}
    else if(mode==='transport')await route.abort('failed');
    else if(mode==='denied')await route.fulfill({status:403,contentType:'application/json',body:'{"error":"forbidden"}'});
    else await route.fulfill({status:200,contentType:'application/json',body:JSON.stringify(data)});
   });
   await page.goto(origin+'/growth?enable-semantics=true',{waitUntil:'domcontentloaded'});await requestArrived;
   if(record)await page.screenshot({path:out+'/initial-state.png'});
   await checkShell(true);assert.ok((await page.locator(cy('growth-loading')).innerText()).includes(policy.locales.en.loading));
   release();stage='initial-http-error';await page.locator(cy('growth-retry')).waitFor();await checkShell(false);
   assert.ok((await page.locator(cy('growth-error')).innerText()).includes(policy.locales.en.error_unavailable));
   assert.equal(await page.locator(cy('growth-retry')).isEnabled(),true);
   assert.equal(await page.locator(cy('growth-back')).getAttribute('href'),'/dashboard?enable-semantics=true');
   await retryToSuccess();await page.locator(cy('growth-language')).selectOption(locale);
   stage='transport-error';mode='transport';await page.locator(cy('growth-refresh')).click();await page.locator(cy('growth-retry')).waitFor();await checkShell(false);
   assert.equal(await page.locator(cy('growth-summary')).count(),0,'error content must not show a stale successful summary');
   assert.equal(await page.locator(cy('growth-retry')).innerText(),policy.locales[locale].refresh);
   await retryToSuccess();assert.equal(await page.locator(cy('growth-language')).inputValue(),locale);
   stage='denied-error';mode='denied';await page.locator(cy('growth-refresh')).click();await page.locator(cy('growth-retry')).waitFor();await checkShell(false);
   assert.ok((await page.locator(cy('growth-error')).innerText()).includes(policy.locales[locale].error_forbidden));
   assert.equal(await page.locator(cy('growth-summary')).count(),0,'denied access removes cached business content');
   await retryToSuccess();
   assert.ok(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1));
   assert.deepEqual(errors,[]);assert.equal(requests,6);
   cases.push({locale,width,passed:true,initialLoadingShell:true,errorShell:true,retryRestoresChrome:true,emptyState:true,transportFailureRetry:true,deniedClearsContent:true,requests});
  }catch(error){
   cases.push({locale,width,passed:false,stage,requests,error:String(error),pageErrors:errors});
   if(record)await page.screenshot({path:out+'/failure.png'});
   throw error;
  }finally{
   release();const video=record?page.video():null;await context.close();
   if(video){await video.saveAs(out+'/growth-loading-retry.webm');report.video=out+'/growth-loading-retry.webm';}
  }
 }
 for(const [path,expected] of Object.entries(sources))assert.equal(hash(await readFile(path)),expected,'Source changed during renderer check: '+path);
 report.passed=true;report.criterion_results[criterion]='passed';
}catch(error){failure=error;report.error=String(error);}
finally{
 await browser.close();await new Promise(r=>server.close(r));
 await writeFile(out+'/results.json',JSON.stringify(report,null,2)+'\n');
}
console.log(JSON.stringify({passed:report.passed,cases:cases.length,wholeTaskVerified:false,report:out+'/results.json',...(failure?{failure:String(failure)}:{})}));
if(failure)throw failure;
