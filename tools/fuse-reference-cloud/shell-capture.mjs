/** Full original skeleton, not a settings-panel substitute or business acceptance. */
import {chromium} from 'playwright';
import {mkdir,writeFile} from 'node:fs/promises';
import {resolve} from 'node:path';
const output=resolve(process.argv[2]);await mkdir(output,{recursive:true});
const browser=await chromium.launch({headless:true});const results=[];
try{
 for(const layout of ['layout1','layout2','layout3'])for(const [device,width,height] of [['desktop',1440,1000],['tablet',820,1180],['mobile',390,844]])for(const mode of ['light','dark']){
  const page=await browser.newPage({viewport:{width,height},deviceScaleFactor:1});const errors=[],external=[];
  page.on('pageerror',e=>errors.push(e.message));
  await page.route('**/*',route=>{const url=new URL(route.request().url());if(!['127.0.0.1','localhost'].includes(url.hostname)&&!['data:','blob:'].includes(url.protocol)){external.push(url.origin);return route.abort();}return route.continue();});
  const id=`${layout}-${device}-${mode}`;
  try{
   await page.goto(`http://127.0.0.1:4317/?layout=${layout}&mode=${mode}&surface=shell&enable-semantics=true`,{waitUntil:'networkidle'});
   await page.locator('#fuse-layout').waitFor({timeout:15000});await page.evaluate(()=>document.fonts.ready);
   await page.addStyleTag({content:'*,*::before,*::after{animation:none!important;transition:none!important}'});
   const boxes=await page.evaluate(()=>Object.fromEntries(['#fuse-layout','#fuse-main','#fuse-toolbar','#fuse-footer','#fuse-navbar'].map(selector=>{const el=document.querySelector(selector);if(!el)return[selector,null];const b=el.getBoundingClientRect();return[selector,{x:b.x,y:b.y,width:b.width,height:b.height}]})));
   if(!boxes['#fuse-layout']||!boxes['#fuse-main'])throw new Error('Original full shell absent');
   if(errors.length)throw new Error('Original shell page errors: '+errors.join('; '));
   if(external.length)throw new Error('External requests blocked: '+[...new Set(external)].join(', '));
   await page.screenshot({path:resolve(output,`fuse-shell-${id}.png`),fullPage:false});
   results.push({id,layout,device,mode,width,height,status:'captured',boxes,errors,external,identity:'isolated guest reference; no authenticated production session',visualAcceptance:false});
  }catch(error){await page.screenshot({path:resolve(output,`FAILED-${id}.png`),fullPage:false}).catch(()=>{});results.push({id,status:'failed',error:String(error),errors,external,visualAcceptance:false});}
  finally{await page.close();}
 }
}finally{await browser.close();await writeFile(resolve(output,'shell-measurements.json'),JSON.stringify({source:process.env.GITHUB_SHA??null,cases:results,fullShellVisualAcceptance:false,nativeComparisonComplete:false},null,2));}
if(results.length!==18||results.some(x=>x.status!=='captured'))throw new Error('Full-shell reference capture incomplete; inspect shell-measurements.json');
console.log('18 full original guest-shell captures; native matching and acceptance remain open');
