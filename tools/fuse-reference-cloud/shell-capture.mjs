/** Full original skeleton, not a settings-panel substitute or business acceptance. */
import {chromium} from 'playwright';
import {mkdir,writeFile} from 'node:fs/promises';
import {resolve} from 'node:path';
const output=resolve(process.argv[2]);await mkdir(output,{recursive:true});
const browser=await chromium.launch({headless:true});const results=[];
const cases = [];
const devices = [['desktop',1440,1000],['tablet',820,1180],['mobile',390,844]];
for (const mode of ['light','dark']) {
 for (const layout of ['layout1','layout2','layout3']) {
  for (const [device,width,height] of devices) cases.push({layout,device,width,height,mode});
 }
 for (const sidebarCase of ['selected','folded','right','drawer']) {
  const [device,width,height] = sidebarCase === 'drawer' ? devices[2] : devices[0];
  cases.push({layout:'layout1',device,width,height,mode,sidebarCase});
 }
}
try{
 for (const {layout,device,width,height,mode,sidebarCase} of cases) {
  const page=await browser.newPage({viewport:{width,height},deviceScaleFactor:1});const errors=[],external=[];
  page.on('pageerror',e=>errors.push(e.message));
  await page.route('**/*',route=>{const url=new URL(route.request().url());if(!['127.0.0.1','localhost'].includes(url.hostname)&&!['data:','blob:'].includes(url.protocol)){external.push(url.origin);return route.abort();}return route.continue();});
  const id=`${layout}-${device}-${mode}${sidebarCase ? '-' + sidebarCase : ''}`;
  try{
   const params = new URLSearchParams({layout,mode,surface:'shell'});
   if (sidebarCase) params.set('sidebarCase',sidebarCase);
   params.set('enable-semantics','true');
   const path = sidebarCase === 'selected' ? '/example' : '/';
   await page.goto(`http://127.0.0.1:4317${path}?${params}`,{waitUntil:'networkidle'});
   await page.locator('#fuse-layout').waitFor({timeout:15000});await page.evaluate(()=>document.fonts.ready);
   await page.addStyleTag({content:'*,*::before,*::after{animation:none!important;transition:none!important}'});
   if (sidebarCase === 'drawer') {
    await page.locator('.MuiDrawer-paper').filter({has:page.getByLabel('Example',{exact:true})}).waitFor({timeout:8000});
   }
   if (sidebarCase === 'folded') {
    await page.locator('#fuse-navbar-side-panel').waitFor({timeout:8000});
   }
   const boxes=await page.evaluate(()=>Object.fromEntries(['#fuse-layout','#fuse-main','#fuse-toolbar','#fuse-footer','#fuse-navbar','#fuse-navbar-side-panel','.MuiDrawer-paper'].map(selector=>{const el=document.querySelector(selector);if(!el)return[selector,null];const b=el.getBoundingClientRect();return[selector,{x:b.x,y:b.y,width:b.width,height:b.height}]})));
   if(!boxes['#fuse-layout']||!boxes['#fuse-main'])throw new Error('Original full shell absent');
   if (sidebarCase === 'right' && boxes['#fuse-main'].x !== 0) {
    throw new Error('Right sidebar case did not place main content at the left edge');
   }
   if(errors.length)throw new Error('Original shell page errors: '+errors.join('; '));
   if(external.length)throw new Error('External requests blocked: '+[...new Set(external)].join(', '));
   await page.screenshot({path:resolve(output,`fuse-shell-${id}.png`),fullPage:false});
   results.push({id,layout,device,mode,width,height,sidebarCase:sidebarCase??null,status:'captured',boxes,errors,external,identity:'isolated guest reference; no authenticated production session',visualAcceptance:false});
  }catch(error){await page.screenshot({path:resolve(output,`FAILED-${id}.png`),fullPage:false}).catch(()=>{});results.push({id,status:'failed',error:String(error),errors,external,visualAcceptance:false});}
  finally{await page.close();}
 }
}finally{await browser.close();await writeFile(resolve(output,'shell-measurements.json'),JSON.stringify({source:process.env.GITHUB_SHA??null,cases:results,fullShellVisualAcceptance:false,nativeComparisonComplete:false},null,2));}
if(results.length!==cases.length||results.some(x=>x.status!=='captured'))throw new Error('Full-shell reference capture incomplete; inspect shell-measurements.json');
console.log(`Captured ${cases.length} original guest shell cases. Visual acceptance remains open.`);
