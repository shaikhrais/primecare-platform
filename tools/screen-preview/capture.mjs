/** Capture the exported preview over isolated loopback HTTP, never production. */
import {chromium} from '@playwright/test';
import {createServer} from 'node:http';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {resolve} from 'node:path';
import assert from 'node:assert/strict';
const dir=resolve(process.argv[2]??'test-results/screen-preview');const html=await readFile(dir+'/PrimeCare_Interactive_Preview.html');
await mkdir(dir+'/screenshots',{recursive:true});await mkdir(dir+'/video',{recursive:true});
const server=createServer((req,res)=>{if(req.url==='/'||req.url?.startsWith('/?')){res.writeHead(200,{'content-type':'text/html','cache-control':'no-store'});res.end(html);}else{res.writeHead(404);res.end();}});server.listen(0,'127.0.0.1');await new Promise(r=>server.once('listening',r));const origin='http://127.0.0.1:'+server.address().port;
const browser=await chromium.launch({headless:true});const external=[],errors=[],scan=[],screenshots=[];
const context=await browser.newContext({viewport:{width:1440,height:1000},recordVideo:{dir:dir+'/video',size:{width:1440,height:1000}}});
await context.route('**/*',async route=>{const url=route.request().url();if(/^https?:/.test(url)&&!url.startsWith(origin+'/')){external.push(url);await route.abort();}else await route.continue();});
const consoleErrors=[];const page=await context.newPage();page.on('pageerror',e=>{errors.push(e.message);console.log('PREVIEW_PAGE_ERROR '+e.message);});page.on('console',message=>{if(message.type()==='error')consoleErrors.push(message.text());});
const open=async(code)=>{await page.evaluate(async code=>{const done=window.PreviewHost.waitReady();window.PreviewHost.openScreen(code);return await Promise.race([done,new Promise((_,reject)=>setTimeout(()=>reject(new Error('Preview readiness timed out: '+code)),15000))]);},code);};
const frame=()=>page.frames().find(f=>f!==page.mainFrame());
try{
 await page.goto(origin,{waitUntil:'domcontentloaded'});await page.waitForFunction(()=>document.querySelector('iframe')?.contentWindow?.PreviewFrame);await page.waitForFunction(()=>document.querySelector('iframe')?.contentDocument?.querySelector('.ems-widget'));
 await frame().locator('[data-cy=ems-summary]').filter({hasText:'120'}).waitFor();
 await page.locator('#preview-settings').evaluate(el=>el.open=true);for(let i=0;i<5;i++){await page.locator('#advance').click();await page.waitForTimeout(120);}
 await page.locator('#preview-settings').evaluate(el=>el.open=false);const geometry=await frame().evaluate(()=>({titleHeight:document.querySelector('h1').getBoundingClientRect().height,widgetTop:document.querySelector('.ems-widget').getBoundingClientRect().top}));assert.ok(geometry.titleHeight<=1,'page title still consumes visible space');assert.ok(geometry.widgetTop<160,'excessive space before first widget');console.log('PREVIEW_SPACE '+JSON.stringify(geometry));const operations=frame().locator('.ems-widget-grid');assert.equal(await operations.locator('.ems-widget').count(),6);
 assert.ok(await frame().locator('.ems-trend-line').count()>0,'real EMS chart must plot the synthetic traffic history');
 for(const[name,width,height]of [['ems-desktop',1440,1000],['ems-tablet',820,1180],['ems-mobile',390,844]]){await page.setViewportSize({width,height});await page.waitForTimeout(200);if(width===390){const smallestLabel=await frame().evaluate(()=>Math.min(...[...document.querySelectorAll('.ems-chart-grid svg text')].map(el=>el.getBoundingClientRect().height).filter(h=>h>0)));assert.ok(smallestLabel>=10,'mobile chart labels are too small');console.log('PREVIEW_MOBILE_TEXT '+smallestLabel);}await page.screenshot({path:dir+'/screenshots/'+name+'.png',fullPage:true});screenshots.push(name);}
 await page.setViewportSize({width:1440,height:1000});
 // Exercise the existing Theme Center against the shared spatial manager.
 await frame().locator('[data-cy=appearance-open]').evaluate(el=>el.click());
 await frame().locator('[data-cy=appearance-dialog]').waitFor();
 const pagePadding=await frame().locator('.workspace>main').evaluate(el=>getComputedStyle(el).paddingTop);
 await frame().locator('[data-cy=appearance-density]').selectOption('compact');
 const compactPadding=await frame().locator('.workspace>main').evaluate(el=>getComputedStyle(el).paddingTop);
 assert.ok(parseFloat(compactPadding)<parseFloat(pagePadding),'density control did not compact the shared layout');
 await frame().locator('[data-cy=appearance-navigation]').selectOption('compact');const railWidth=await frame().locator('[data-cy=app-sidebar]').evaluate(el=>el.getBoundingClientRect().width);assert.equal(railWidth,64,'compact navigation did not become an icon rail');
 await frame().locator('[data-cy=appearance-theme]').selectOption('dark');
 const darkPalette=await frame().evaluate(()=>getComputedStyle(document.documentElement).getPropertyValue('--color-background').trim());assert.equal(darkPalette,'#0b1220');
 await frame().locator('[data-cy=appearance-close]').click();await page.waitForTimeout(150);
 const controlContrast=await frame().evaluate(()=>{const luminance=value=>{const rgb=value.match(/[\d.]+/g).slice(0,3).map(Number).map(v=>{v/=255;return v<=.04045?v/12.92:((v+.055)/1.055)**2.4;});return .2126*rgb[0]+.7152*rgb[1]+.0722*rgb[2];};return ['[data-cy=ems-refresh]','[data-cy=ems-inventory] button','[data-cy=ems-inventory] select'].map(selector=>{const style=getComputedStyle(document.querySelector(selector));const a=luminance(style.color),b=luminance(style.backgroundColor);return {selector,ratio:(Math.max(a,b)+.05)/(Math.min(a,b)+.05)};});});assert.ok(controlContrast.every(row=>row.ratio>=4.5),'dark theme controls have insufficient contrast');console.log('PREVIEW_CONTROL_CONTRAST '+JSON.stringify(controlContrast));
 await page.screenshot({path:dir+'/screenshots/ems-dark-compact.png',fullPage:true});screenshots.push('ems-dark-compact');
 await frame().locator('[data-cy=sidebar-profile-menu]>summary').click();await frame().locator('[data-cy=sidebar-theme]').click();await frame().locator('[data-cy=appearance-theme]').selectOption('default');await frame().locator('[data-cy=appearance-density]').selectOption('comfortable');await frame().locator('[data-cy=appearance-navigation]').selectOption('expanded');await frame().locator('[data-cy=appearance-close]').click();
 console.log('PREVIEW_MANAGERS '+JSON.stringify({pagePadding,compactPadding,darkPalette,railWidth}));
 // Exercise a real form and round trip through the synthetic API adapter.
 await open('preview-admin-tenants');await frame().locator('[data-cy=platform-tenant-form]').waitFor();
 await frame().locator('[data-cy=platform-tenant-form] [name=name]').fill('Demo · Browser created');await frame().locator('[data-cy=platform-tenant-form] [name=slug]').fill('preview-browser-created');await frame().locator('[data-cy=platform-tenant-form] button').click();await frame().locator('[data-cy=platform-account-form]').waitFor({timeout:10000});
 const admin=await page.evaluate(()=>window.PREVIEW_DATA.screens.filter(s=>s.kind==='admin').map(s=>s.code));
 for(const code of admin){console.log('PREVIEW_OPEN '+code);await open(code);if(['preview-admin-accounts','preview-admin-masters','preview-admin-audit'].includes(code)){const tenant=frame().locator('[data-cy=platform-topbar-tenant]');await tenant.selectOption('demo-org-1');await page.waitForTimeout(100);}await page.waitForTimeout(100);const info=await frame().evaluate(()=>({alert:document.querySelector('#app>[role=alert]')?.textContent??null,title:document.querySelector('h1')?.textContent??null}));scan.push({code,kind:'actual-renderer',...info});await page.screenshot({path:dir+'/screenshots/'+code+'.png',fullPage:true});screenshots.push(code);}
 const registry=await page.evaluate(()=>window.PREVIEW_DATA.screens.filter(s=>s.kind==='registry').map(s=>({code:s.code,role:s.role})));
 const roleShots=new Set();
 for(const entry of registry){if(scan.length%100===0)console.log('PREVIEW_SCAN '+scan.length+' '+entry.code);await open(entry.code);const info=await frame().evaluate(()=>({alert:document.querySelector('#app>[role=alert]')?.textContent??null,title:document.querySelector('h1')?.textContent??null}));scan.push({...entry,kind:'registry-template',...info});if(!roleShots.has(entry.role)){roleShots.add(entry.role);await page.screenshot({path:dir+'/screenshots/role-'+entry.role+'.png',fullPage:true});screenshots.push('role-'+entry.role);}if(process.env.PREVIEW_CAPTURE_ALL==='1'){await page.screenshot({path:dir+'/screenshots/screen-'+entry.code+'.png',fullPage:true});}}
 // End the video on the fully populated EMS renderer.
 await open('preview-admin-ems');await page.waitForTimeout(2000);
 const snapshot=await page.evaluate(()=>window.PreviewHost.snapshot());
 const report={layoutGeometry:geometry,sourceKind:'real_browser_of_exported_preview',synthetic:true,productionConnections:false,registeredPagesScanned:registry.length,actualAdminViewsScanned:admin.length,rolesCaptured:roleShots.size,screenshots,scan,pageErrors:errors,externalRequests:external,unsupportedApis:snapshot.runtime?.missingApis??[],observedAt:new Date().toISOString()};
 await writeFile(dir+'/browser-report.json',JSON.stringify(report,null,2));
 assert.equal(external.length,0,'preview attempted an external request');assert.equal(errors.length,0,'preview JavaScript errors');assert.equal(scan.filter(s=>s.alert||!s.title).length,0,'one or more screen renderers failed');
 console.log('PREVIEW_BROWSER '+JSON.stringify({registeredPagesScanned:registry.length,actualAdminViewsScanned:admin.length,rolesCaptured:roleShots.size,screenshots:screenshots.length,externalRequests:external.length,pageErrors:errors.length,unsupportedApis:report.unsupportedApis}));
}finally{await page.screenshot({path:dir+'/screenshots/last-state.png',fullPage:true}).catch(()=>{});await writeFile(dir+'/diagnostics.json',JSON.stringify({pageErrors:errors,consoleErrors,externalRequests:external,frames:page.frames().map(f=>f.url())},null,2));await context.close();await browser.close();server.close();}
