/** Full original skeleton, not a settings-panel substitute or business acceptance. */
import {chromium} from 'playwright';
import {mkdir,readFile,writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {resolve} from 'node:path';
const output=resolve(process.argv[2]);await mkdir(output,{recursive:true});
const fixtureBytes = process.argv[3] ? await readFile(process.argv[3]) : null;
const fixture = fixtureBytes ? JSON.parse(fixtureBytes) : null;
if (fixture && (fixture.version !== 1 || fixture.fixtureOnly !== true ||
    Object.keys(fixture.account ?? {}).sort().join(',') !== 'displayName,role' ||
    !fixture.account.displayName || !fixture.account.role || fixture.language !== 'en' ||
    fixture.entries?.length !== 1 || !fixture.entries[0].label ||
    !/^\/[a-z0-9/-]+$/.test(fixture.entries[0].route))) {
 throw new Error('Expected a single populated route from the isolated native navigation fixture');
}
const fixtureSha256 = fixtureBytes ? createHash('sha256').update(fixtureBytes).digest('hex') : null;
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
if (fixture) {
 cases.push(...cases.filter(item => item.sidebarCase ||
  (item.layout === 'layout2' && item.device === 'desktop'))
  .map(item => ({...item, dataSet: 'shared-navigation'})));
}
async function captureNavigationInteraction(page, id, sidebarCase, route) {
 const entry = page.locator(`a[href$="${route}"]:visible`);
 const candidateCount = await entry.count();
 if (candidateCount !== 1) {
  return {status:'unavailable', reason:'Expected one visible fixture navigation link', candidateCount};
 }
 const initial = await entry.evaluate(element => ({
  href: element.getAttribute('href'),
  label: element.getAttribute('aria-label') || element.textContent.trim() || null,
  current: element.getAttribute('aria-current'),
  selectedClass: element.classList.contains('active'),
  language: document.documentElement.lang || null,
  scroll: [window.scrollX, window.scrollY],
 }));
 const appearance = async () => {
  if (await entry.count() !== 1) return null;
  return entry.evaluate(element => {
   const style = getComputedStyle(element);
   const { x, y, width, height } = element.getBoundingClientRect();
   return {
    box: { x, y, width, height },
    current: element.getAttribute('aria-current'),
    selectedClass: element.classList.contains('active'),
    keyboardFocus: element.matches(':focus-visible'),
    background: style.backgroundColor,
    foreground: style.color,
    outline: style.outlineStyle,
    outlineColor: style.outlineColor,
    outlineWidth: style.outlineWidth,
    borderRadius: style.borderRadius,
   };
  });
 };
 const baseline = await appearance();
 const states = {};
 const screenshot = async state => {
  const filename = `fuse-shell-${id}-${state}.png`;
  await page.screenshot({path:resolve(output,filename),fullPage:false});
  return filename;
 };

 await entry.hover({timeout:3000});
 if (await entry.evaluate(element => element.matches(':hover'))) {
  states.hover = {status:'captured',appearance:await appearance(),file:await screenshot('hover')};
 } else {
  states.hover = {status:'unavailable',reason:'The navigation link did not enter hover state'};
 }
 await page.mouse.move(0,0);
 const focused = () => entry.evaluate(element => element === document.activeElement);
 for (let tab = 0; tab < 30 && !(await focused()); tab++) {
  await page.keyboard.press('Tab');
 }
 if (await focused()) {
  const focusVisible = await entry.evaluate(element => element.matches(':focus-visible'));
  states.focus = {status:'captured',focusVisible,appearance:await appearance(),file:await screenshot('focus')};
  const before = page.url();
  try {
   await page.keyboard.press('Enter');
   await page.waitForURL(url => url.pathname === initial.href && url.href !== before, {timeout:2500});
   if (id.startsWith('layout2-desktop')) {
    // The URL can change before the original link paints its selected state.
    await page.locator(`a.active[aria-current="page"][href$="${route}"]:visible`)
     .waitFor({timeout:3000});
    await page.evaluate(() => new Promise(resolve => requestAnimationFrame(resolve)));
   }
   if (sidebarCase === 'drawer') {
    const drawer = page.locator('.MuiDrawer-paper').filter({
     has: page.locator(`a[href$="${route}"]`),
    });
    await drawer.waitFor({state:'hidden',timeout:2500});
   }
   states.activated = {
    status:'captured',
    destination:new URL(page.url()).pathname,
    drawerClosed:sidebarCase === 'drawer' ? true : null,
    appearance:await appearance(),
    file:await screenshot('activated'),
   };
  } catch (error) {
   states.activated = {status:'unavailable',reason:String(error)};
  }

 } else {
  states.focus = {status:'unavailable',reason:'The navigation link was not reached by Tab within 30 stops'};
 }
 return {status:'observed',entry:initial,appearance:baseline,states};
}

async function captureAccountMenu(page, id) {
 const trigger = page.locator('.user-menu:visible');
 const candidateCount = await trigger.count();
 if (candidateCount !== 1) {
  return {status:'unavailable',reason:'Expected one visible Fuse user-menu trigger',candidateCount};
 }
 const triggerState = await trigger.evaluate(element => {
  const {x,y,width,height}=element.getBoundingClientRect();
  return {box:{x,y,width,height},label:element.textContent.trim()||null};
 });
 await trigger.click({timeout:5000});
 const popover = page.locator('.MuiPopover-root:visible');
 await popover.waitFor({timeout:5000});
 const paper = page.locator('.MuiPopover-paper:visible');
 await paper.waitFor({timeout:5000});
 const menuState = await paper.evaluate(element => {
  const {x,y,width,height}=element.getBoundingClientRect();
  return {box:{x,y,width,height},text:element.textContent.trim()||null};
 });
 const file=`fuse-shell-${id}-account-menu-open.png`;
 await page.screenshot({path:resolve(output,file),fullPage:false});
 await page.keyboard.press('Escape');
 await popover.waitFor({state:'hidden',timeout:5000});
 let keyboard;
 try {
  // Step to the preceding control when Escape restored the trigger. This
  // avoids wrapping through Search, whose own key handler opens it on Tab.
  const hasFocus = await trigger.evaluate(element => element === document.activeElement);
  if (hasFocus) await page.keyboard.press('Shift+Tab');
  await page.keyboard.press('Tab');
  const focusVisible = () => trigger.evaluate(element => {
   const {x,y,width,height} = element.getBoundingClientRect();
   const hit = document.elementFromPoint(x + width / 2, y + height / 2);
   return element === document.activeElement &&
    element.matches(':focus-visible') && element.contains(hit);
  });
  for (let tab = 0; tab < 30 && !(await focusVisible()); tab++) {
   await page.keyboard.press('Tab');
  }
  if (!(await focusVisible())) {
   throw new Error('Account trigger was not reached with visible focus within 30 Tab stops');
  }
  const focusFile = `fuse-shell-${id}-account-keyboard-focus.png`;
  await page.screenshot({path:resolve(output,focusFile),fullPage:false});
  await page.keyboard.press('Enter');
  await paper.waitFor({timeout:5000});
  const menuFile = `fuse-shell-${id}-account-keyboard-open.png`;
  await page.screenshot({path:resolve(output,menuFile),fullPage:false});
  await page.keyboard.press('Escape');
  await popover.waitFor({state:'hidden',timeout:5000});
  const focusReturned = await trigger.evaluate(element => element === document.activeElement);
  keyboard = {status:'captured',focusFile,menuFile,focusReturned};
 } catch (error) {
  if (await popover.isVisible()) {
   await page.keyboard.press('Escape');
   await popover.waitFor({state:'hidden',timeout:5000});
  }
  keyboard = {status:'unavailable',reason:String(error)};
 }
 return {status:'captured',trigger:triggerState,menu:menuState,file,keyboard};
}

try{
 for (const {layout,device,width,height,mode,sidebarCase,dataSet} of cases) {
  const page=await browser.newPage({viewport:{width,height},deviceScaleFactor:1});const errors=[],external=[];
  const shared = dataSet === 'shared-navigation';
  if (shared) await page.addInitScript(data => { window.__primecareNavigationFixture = data; }, fixture);
  const route = shared ? fixture.entries[0].route : '/example';
  page.on('pageerror',e=>errors.push(e.message));
  await page.route('**/*',route=>{const url=new URL(route.request().url());if(!['127.0.0.1','localhost'].includes(url.hostname)&&!['data:','blob:'].includes(url.protocol)){external.push(url.origin);return route.abort();}return route.continue();});
  const id=`${layout}-${device}-${mode}${sidebarCase ? '-' + sidebarCase : ''}${shared ? '-shared-navigation' : ''}`;
  try{
   const params = new URLSearchParams({layout,mode,surface:'shell'});
   if (sidebarCase) params.set('sidebarCase',sidebarCase);
   params.set('enable-semantics','true');
   const path = sidebarCase ? route : '/';
   await page.goto(`http://127.0.0.1:4317${path}?${params}`,{waitUntil:'networkidle'});
   await page.locator('#fuse-layout').waitFor({timeout:15000});await page.evaluate(()=>document.fonts.ready);
   if (sidebarCase === 'drawer') {
    // Layout 1 mounts its existing mobile sidebar toggle as the leading toolbar button.
    await page.locator('#fuse-toolbar button').first().click({timeout:8000});
    const drawer = page.locator('.MuiDrawer-paper').filter({
     has: page.locator(`a[href$="${route}"]`),
    });
    await drawer.waitFor({timeout:8000});
    await page.waitForFunction(href => [...document.querySelectorAll('.MuiDrawer-paper')].some(el => {
     const bounds = el.getBoundingClientRect();
     return el.querySelector(`a[href$="${href}"]`) && Math.abs(bounds.left) < 1;
    }), route, {timeout: 8000});
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
   let accountMenu = null;
   if (shared && (sidebarCase || (layout === 'layout2' && device === 'desktop'))) {
    try {
     accountMenu = await captureAccountMenu(page,id);
    } catch (error) {
     accountMenu = {status:'unavailable',reason:String(error)};
    }
   }
   let interaction = null;
   if (sidebarCase || (layout === 'layout2' && device === 'desktop')) {
    try {
     interaction = await captureNavigationInteraction(page,id,sidebarCase,route);
    } catch (error) {
     interaction = {status:'unavailable',reason:String(error)};
    }
   }
   if(errors.length)throw new Error('Original shell page errors: '+errors.join('; '));
   if(external.length)throw new Error('External requests blocked: '+[...new Set(external)].join(', '));
   if (shared && (interaction?.entry?.href !== route ||
       interaction.entry.language !== fixture.language ||
       interaction.entry.scroll.some(value => value !== 0) ||
       (sidebarCase !== 'folded' && interaction.entry.label !== fixture.entries[0].label))) {
    throw new Error('Shared navigation fixture route, label, locale or scroll did not reach the original renderer');
   }
   if (shared && layout === 'layout2' && device === 'desktop' &&
       (interaction.states.activated?.appearance?.current !== 'page' ||
        interaction.states.activated.appearance.selectedClass !== true)) {
    throw new Error('The horizontal reference did not render the selected destination after activation');
   }
   results.push({id,layout,device,mode,width,height,sidebarCase:sidebarCase??null,status:'captured',boxes,accountMenu,interaction,errors,external,
    dataSet:dataSet??'original-guest',fixtureSha256:shared?fixtureSha256:null,
    identity:shared?'same isolated role and presented navigation as native; no production session':'isolated guest reference; no production session',
    visualAcceptance:false});
  }catch(error){await page.screenshot({path:resolve(output,`FAILED-${id}.png`),fullPage:false}).catch(()=>{});results.push({id,status:'failed',error:String(error),errors,external,visualAcceptance:false});}
  finally{await page.close();}
 }
}finally{await browser.close();await writeFile(resolve(output,'shell-measurements.json'),JSON.stringify({source:process.env.GITHUB_SHA??null,cases:results,fullShellVisualAcceptance:false,nativeComparisonComplete:false},null,2));}
if(results.length!==cases.length||results.some(x=>x.status!=='captured'))throw new Error('Full-shell reference capture incomplete; inspect shell-measurements.json');
console.log(`Captured ${cases.length} cases using the original shell renderer. Visual acceptance remains open.`);
