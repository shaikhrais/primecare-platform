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
async function captureNavigationInteraction(page, id, sidebarCase) {
 const entry = page.locator('a[href$="/example"]:visible');
 const candidateCount = await entry.count();
 if (candidateCount !== 1) {
  return {status:'unavailable', reason:'Expected one visible Example link', candidateCount};
 }
 const initial = await entry.evaluate(element => ({
  href: element.getAttribute('href'),
  label: element.getAttribute('aria-label') || element.textContent.trim() || null,
  current: element.getAttribute('aria-current'),
  selectedClass: element.classList.contains('active'),
  language: document.documentElement.lang || null,
  scroll: [window.scrollX, window.scrollY],
 }));
 const states = {};
 const screenshot = async state => {
  const filename = `fuse-shell-${id}-${state}.png`;
  await page.screenshot({path:resolve(output,filename),fullPage:false});
  return filename;
 };

 await entry.hover({timeout:3000});
 if (await entry.evaluate(element => element.matches(':hover'))) {
  states.hover = {status:'captured',file:await screenshot('hover')};
 } else {
  states.hover = {status:'unavailable',reason:'Example link did not enter hover state'};
 }
 await page.mouse.move(0,0);
 const focused = () => entry.evaluate(element => element === document.activeElement);
 for (let tab = 0; tab < 30 && !(await focused()); tab++) {
  await page.keyboard.press('Tab');
 }
 if (await focused()) {
  const focusVisible = await entry.evaluate(element => element.matches(':focus-visible'));
  states.focus = {status:'captured',focusVisible,file:await screenshot('focus')};
  const before = page.url();
  try {
   await page.keyboard.press('Enter');
   await page.waitForURL(url => url.pathname === initial.href && url.href !== before, {timeout:2500});
   if (sidebarCase === 'drawer') {
    const drawer = page.locator('.MuiDrawer-paper').filter({
     has: page.getByLabel('Example', {exact:true}),
    });
    await drawer.waitFor({state:'hidden',timeout:2500});
   }
   states.activated = {
    status:'captured',
    destination:new URL(page.url()).pathname,
    drawerClosed:sidebarCase === 'drawer' ? true : null,
    file:await screenshot('activated'),
   };
  } catch (error) {
   states.activated = {status:'unavailable',reason:String(error)};
  }

 } else {
  states.focus = {status:'unavailable',reason:'Example link was not reached by Tab within 30 stops'};
 }
 return {status:'observed',entry:initial,states};
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
   const path = ['selected', 'folded', 'right', 'drawer'].includes(sidebarCase) ? '/example' : '/';
   await page.goto(`http://127.0.0.1:4317${path}?${params}`,{waitUntil:'networkidle'});
   await page.locator('#fuse-layout').waitFor({timeout:15000});await page.evaluate(()=>document.fonts.ready);
   if (sidebarCase === 'drawer') {
    // Layout 1 mounts its existing mobile sidebar toggle as the leading toolbar button.
    await page.locator('#fuse-toolbar button').first().click({timeout:8000});
    const drawer = page.locator('.MuiDrawer-paper').filter({
     has: page.getByLabel('Example', {exact:true}),
    });
    await drawer.waitFor({timeout:8000});
    await page.waitForFunction(() => [...document.querySelectorAll('.MuiDrawer-paper')].some(el => {
     const bounds = el.getBoundingClientRect();
     return el.querySelector('[aria-label="Example"]') && Math.abs(bounds.left) < 1;
    }), null, {timeout: 8000});
   }
   await page.addStyleTag({content:'*,*::before,*::after{animation:none!important;transition:none!important}'});
   if (sidebarCase === 'folded') {
    await page.locator('#fuse-navbar-side-panel').waitFor({timeout:8000});
   }
   const boxes=await page.evaluate(()=>Object.fromEntries(['#fuse-layout','#fuse-main','#fuse-toolbar','#fuse-footer','#fuse-navbar','#fuse-navbar-side-panel','.MuiDrawer-paper'].map(selector=>{const el=document.querySelector(selector);if(!el)return[selector,null];const b=el.getBoundingClientRect();return[selector,{x:b.x,y:b.y,width:b.width,height:b.height}]})));
   if(!boxes['#fuse-layout']||!boxes['#fuse-main'])throw new Error('Original full shell absent');
   if (sidebarCase === 'right' && boxes['#fuse-main'].x !== 0) {
    throw new Error('Right sidebar case did not place main content at the left edge');
   }
   await page.screenshot({path:resolve(output,`fuse-shell-${id}.png`),fullPage:false});
   let interaction = null;
   if (sidebarCase || (layout === 'layout2' && device === 'desktop')) {
    try {
     interaction = await captureNavigationInteraction(page,id,sidebarCase);
    } catch (error) {
     interaction = {status:'unavailable',reason:String(error)};
    }
   }
   if(errors.length)throw new Error('Original shell page errors: '+errors.join('; '));
   if(external.length)throw new Error('External requests blocked: '+[...new Set(external)].join(', '));
   results.push({id,layout,device,mode,width,height,sidebarCase:sidebarCase??null,status:'captured',boxes,interaction,errors,external,identity:'isolated guest reference; no authenticated production session',visualAcceptance:false});
  }catch(error){await page.screenshot({path:resolve(output,`FAILED-${id}.png`),fullPage:false}).catch(()=>{});results.push({id,status:'failed',error:String(error),errors,external,visualAcceptance:false});}
  finally{await page.close();}
 }
}finally{await browser.close();await writeFile(resolve(output,'shell-measurements.json'),JSON.stringify({source:process.env.GITHUB_SHA??null,cases:results,fullShellVisualAcceptance:false,nativeComparisonComplete:false},null,2));}
if(results.length!==cases.length||results.some(x=>x.status!=='captured'))throw new Error('Full-shell reference capture incomplete; inspect shell-measurements.json');
console.log(`Captured ${cases.length} original guest shell cases. Visual acceptance remains open.`);
