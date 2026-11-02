import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {chromium} from 'playwright';
import {createServer} from 'node:http';
import {mkdir,writeFile,mkdtemp,readFile,rm} from 'node:fs/promises';
import {tmpdir} from 'node:os';import {join} from 'node:path';
import {portalIcon,portalManifest,portalServiceWorker,writePortalPwa} from './portal-pwa-assets.mjs';
const js=(await build({entryPoints:['websites/typescript/src/portal-install.ts'],bundle:true,write:false,format:'esm',platform:'browser'})).outputFiles[0].text;
const manifest=portalManifest('PrimeCare Calling Test');
const generated=await mkdtemp(join(tmpdir(),'portal-migration-browser-'));writePortalPwa(generated,manifest.name);
const compatibilityWorker=await readFile(join(generated,'flutter_service_worker.js'),'utf8');
const cachedLegacyWorker=`self.addEventListener('install',event=>event.waitUntil(caches.open('legacy-shell-fixture').then(cache=>cache.put('/',new Response('<!doctype html><html><body>Cached old shell fixture</body></html>',{headers:{'content-type':'text/html'}}))).then(()=>self.skipWaiting())));self.addEventListener('activate',event=>event.waitUntil(self.clients.claim()));self.addEventListener('fetch',event=>{if(event.request.mode==='navigate')event.respondWith(caches.open('legacy-shell-fixture').then(cache=>cache.match('/')));});`;
let upgradeLegacyWorker=false;
let failNavigation=false;
const server=createServer((req,res)=>{
 if(failNavigation&&req.url.startsWith('/platform/administration')){req.socket.destroy();return;}
 res.setHeader('cache-control','no-store');
 if(req.url==='/legacy-setup'){res.setHeader('content-type','text/html');res.end('<!doctype html><html><body>Legacy registration setup</body></html>');}
 else if(req.url.split('?')[0]==='/flutter_service_worker.js'){res.setHeader('content-type','text/javascript');res.end(upgradeLegacyWorker?compatibilityWorker:cachedLegacyWorker);}
 else if(req.url==='/manifest.webmanifest'){res.setHeader('content-type','application/manifest+json');res.end(JSON.stringify(manifest));}
 else if(req.url==='/service-worker.js'){res.setHeader('content-type','text/javascript');res.end(portalServiceWorker);}
 else if(req.url==='/install.mjs'){res.setHeader('content-type','text/javascript');res.end(js);}
 else if(/^\/icons\//.test(req.url)){res.setHeader('content-type','image/png');res.end(portalIcon(req.url.includes('192')?192:512));}
 else {res.setHeader('content-type','text/html');res.end('<!doctype html><html><head><meta name="viewport" content="width=device-width,initial-scale=1"><link rel="manifest" href="/manifest.webmanifest"><title>PrimeCare</title></head><body><main>Private fixture marker</main><script type="module">import {initializePortalInstall} from "/install.mjs";initializePortalInstall();</script></body></html>');}
});
await new Promise(r=>server.listen(0,'127.0.0.1',r));let browser;
try{
 browser=await chromium.launch({headless:true,executablePath:process.env.CALL_BROWSER_EXECUTABLE||undefined,args:['--no-sandbox']});
 const page=await browser.newPage({viewport:{width:390,height:844}}),origin='http://127.0.0.1:'+server.address().port;
 await page.goto(origin+'/login');await page.locator('[data-cy=portal-install-button]').waitFor();
 await page.evaluate(()=>navigator.serviceWorker.ready);
 await page.waitForFunction(()=>navigator.serviceWorker.controller!==null);
 const cdp=await page.context().newCDPSession(page);const app=await cdp.send('Page.getAppManifest');assert.equal(app.errors.length,0);assert.ok(app.url.endsWith('/manifest.webmanifest'));
 for(const size of [192,512])assert.equal(await page.evaluate(async s=>{const image=new Image();image.src='/icons/primecare-'+s+'.png';await image.decode();return image.naturalWidth;},size),size);
 await page.locator('[data-cy=portal-install-button]').click();assert.match(await page.locator('[data-cy=portal-install-status]').textContent(),/Add to Home screen/);
 await page.evaluate(()=>{const event=new Event('beforeinstallprompt',{cancelable:true});event.prompt=async()=>{window.fixturePrompted=true;};event.userChoice=Promise.resolve({outcome:'accepted'});window.dispatchEvent(event);});
 await page.locator('[data-cy=portal-install-button]').click();await page.waitForFunction(()=>window.fixturePrompted===true);assert.match(await page.locator('[data-cy=portal-install-status]').textContent(),/accepted/);
 await page.evaluate(()=>window.dispatchEvent(new Event('appinstalled')));assert.equal(await page.locator('[data-cy=portal-install]').isHidden(),true);
 assert.deepEqual(await page.evaluate(()=>caches.keys()),[]);
 failNavigation=true;await page.context().setOffline(true);await page.goto(origin+'/platform/administration');assert.match(await page.locator('body').textContent(),/You are offline/);assert.doesNotMatch(await page.locator('body').textContent(),/Private fixture marker/);
 const migration=await browser.newContext(),legacy=await migration.newPage();
 await legacy.goto(origin+'/legacy-setup');await legacy.evaluate(async()=>{
  localStorage.setItem('owned-theme-draft','unsaved fixture');const cache=await caches.open('unrelated-fixture');await cache.put('/unrelated',new Response('preserve me'));
  await navigator.serviceWorker.register('/flutter_service_worker.js',{scope:'/',updateViaCache:'none'});await navigator.serviceWorker.ready;
 });await legacy.waitForFunction(()=>navigator.serviceWorker.controller!==null);
 await legacy.goto(origin+'/login');assert.match(await legacy.locator('body').textContent(),/Cached old shell fixture/);
 upgradeLegacyWorker=true;
 await legacy.evaluate(async()=>{window.previousController=navigator.serviceWorker.controller;await (await navigator.serviceWorker.getRegistration('/')).update();});
 await legacy.waitForFunction(()=>navigator.serviceWorker.controller!==window.previousController);
 await legacy.reload();await legacy.locator('[data-cy=portal-install-button]').waitFor();
 assert.doesNotMatch(await legacy.locator('body').textContent(),/Cached old shell fixture/);
 await legacy.waitForFunction(()=>navigator.serviceWorker.controller?.scriptURL.endsWith('/service-worker.js'));
 assert.deepEqual(await legacy.evaluate(async()=>({draft:localStorage.getItem('owned-theme-draft'),other:await (await (await caches.open('unrelated-fixture')).match('/unrelated')).text()})),{draft:'unsaved fixture',other:'preserve me'});
 await migration.setOffline(true);await legacy.goto(origin+'/platform/administration');assert.match(await legacy.locator('body').textContent(),/You are offline/);assert.doesNotMatch(await legacy.locator('body').textContent(),/Cached old shell fixture|Private fixture marker/);await migration.close();
 const receipt={source:process.env.GITHUB_SHA,passed:true,realBrowser:true,nativeManifestParsed:true,iconsDecoded:[192,512],serviceWorkerControlsPage:true,installButtonFallback:true,installPromptEventSimulated:true,installedStateHidden:true,offlineNoPrivatePageReplay:true,workerFetchNetworkFailureForced:true,noCacheStorage:true,legacyRegisteredWorkerUpdate:true,legacyCachedShellReplaced:true,unsavedDraftAndUnrelatedCachePreserved:true,migratedOfflineNoPrivateReplay:true,legacyWorkerUsesSyntheticFixture:true,osInstallPromptVerified:false,callsPlaced:0};
 await mkdir('test-results/external-calls',{recursive:true});await writeFile('test-results/external-calls/pwa-browser.json',JSON.stringify(receipt,null,2)+'\n');console.log('PORTAL_PWA_BROWSER '+JSON.stringify(receipt));
}finally{await browser?.close();await new Promise(r=>server.close(r));await rm(generated,{recursive:true,force:true});}
