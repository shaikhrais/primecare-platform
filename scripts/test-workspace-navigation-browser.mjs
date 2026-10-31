import assert from 'node:assert/strict';import {build} from 'esbuild';import {createServer} from 'node:http';import {pathToFileURL} from 'node:url';import {join} from 'node:path';import {items,authority} from './workspace-navigation-fixtures.mjs';
const {chromium}=await import('playwright').catch(()=>import(pathToFileURL(join(process.env.CODEX_PRIMARY_RUNTIME_NODE_MODULES,'playwright/index.mjs')).href));
const compiled=await build({stdin:{contents:`export * from './packages/primecare_ui/web/workspace-navigation';export * from './packages/primecare_ui/web/workspace-layout';`,resolveDir:process.cwd()},bundle:true,write:false,format:'iife',globalName:'Navigation'});
const html='<!doctype html><html><head><style>body{margin:0;font:16px sans-serif}*{box-sizing:border-box}header{height:56px}#slot{min-width:0}#shell{min-height:100vh}main{padding:16px}button,a{font:inherit}</style></head><body><div id="shell"><aside><div id="slot"></div></aside><header>Existing toolbar</header><main><input id="unsaved"></main></div><script>'+compiled.outputFiles[0].text+'</script></body></html>';
const server=createServer((req,res)=>{res.setHeader('content-type','text/html');res.end(html);});await new Promise(r=>server.listen(0,'127.0.0.1',r));const origin='http://127.0.0.1:'+server.address().port;
const browser=await chromium.launch({headless:true,...(process.env.PRIMECARE_CHROMIUM_EXECUTABLE?{executablePath:process.env.PRIMECARE_CHROMIUM_EXECUTABLE,args:['--no-sandbox','--disable-dev-shm-usage']}: {})});const page=await browser.newPage({viewport:{width:1500,height:960}}),errors=[];page.on('pageerror',e=>errors.push(e.message));
const node=id=>page.locator('[data-navigation-id='+id+']');
try{
 await page.goto(origin);await page.evaluate(({items,authority})=>{
  window.routes=[];window.options={scope:'tenant:actor:role',items,authority,currentRoute:'/app/people',family:'vertical',labels:{navigation:'Navigation',open:'Open navigation',close:'Close navigation',pin:'Pin navigation',unpin:'Unpin navigation'},onNavigate:route=>window.routes.push(route)};
  window.manager=new Navigation.WorkspaceLayoutManager(document.querySelector('#shell'),{navigation:document.querySelector('aside'),toolbar:document.querySelector('header'),main:document.querySelector('main'),panels:{}},'fixture-layout');
  window.options.frame={element:document.querySelector('#shell'),profile:()=>manager.current};
  window.view=new Navigation.WorkspaceNavigationView(document.querySelector('#slot'),window.options);
 },{items,authority});
 await page.locator('#unsaved').fill('Unfinished main form');assert.equal(await page.getByText(/PRIVATE/).count(),0);
 for(const dir of ['ltr','rtl'])for(const family of ['vertical','horizontal-header','horizontal-footer']){
  await page.evaluate(({dir,family})=>{document.documentElement.dir=dir;manager.change(Navigation.navigationPreset(manager.current,family));options={...options,family};view.update(options);},{dir,family});
  await node('work').focus();await page.keyboard.press(family==='vertical'?(dir==='rtl'?'ArrowLeft':'ArrowRight'):'ArrowDown');assert.equal(await node('home').evaluate(e=>document.activeElement===e),true);
  await node('team').focus();await page.keyboard.press(dir==='rtl'?'ArrowLeft':'ArrowRight');assert.equal(await node('people').evaluate(e=>document.activeElement===e),true);assert.equal(await node('people').getAttribute('aria-current'),'page');
  await node('people').click();assert.equal(await page.locator('#unsaved').inputValue(),'Unfinished main form');
  await node('work').click();if(await node('work').getAttribute('aria-expanded')==='false')await node('work').click();
  if(family!=='vertical'){const panel=page.locator('[data-parent-id=work]');const box=await panel.boundingBox();assert.ok(box.x>=-1&&box.x+box.width<=1501,JSON.stringify({family,dir,box,style:await panel.getAttribute('style')}));}
  await page.keyboard.press('Escape');
 }
 await page.evaluate(()=>{manager.change(Navigation.navigationPreset(manager.current,'vertical'));options={...options,family:'vertical',mode:'folded',pinned:false};view.update(options);});
 await page.locator('#unsaved').focus();await page.mouse.move(750,900);assert.equal(await page.locator('#slot').getAttribute('data-expanded'),'false',JSON.stringify(await page.evaluate(()=>({p:view.presentation,active:document.activeElement?.outerHTML,hover:document.querySelector('#slot').matches(':hover'),box:document.querySelector('#slot').getBoundingClientRect().toJSON()}))));await node('work').focus();assert.equal(await page.locator('#slot').getAttribute('data-expanded'),'true');
 await page.locator('[data-nav-pin]').click();assert.equal(await page.locator('[data-nav-pin]').getAttribute('aria-pressed'),'true');
 await page.evaluate(()=>{options={...options,mode:'rail'};delete options.pinned;view.update(options);});await node('work').focus();await page.keyboard.press('ArrowDown');assert.equal(await node('other').getAttribute('aria-selected'),'true');assert.equal(await node('report').count(),1);assert.equal(await node('home').count(),0);
 await page.setViewportSize({width:390,height:844});await page.locator('[data-nav-open]').click();await page.locator('[data-nav-close]').waitFor({state:'visible'});await page.keyboard.press('Shift+Tab');assert.equal(await page.locator('nav a').last().evaluate(e=>document.activeElement===e),true);await page.keyboard.press('Escape');assert.equal(await page.locator('#slot').getAttribute('data-drawer-open'),'false');
 await page.locator('[data-nav-open]').click();await page.evaluate(()=>{window.old=document.querySelector('[data-navigation-id=report]');options={...options,scope:'tenant:other:role',authority:{...options.authority,ids:[]}};view.update(options);old?.click();});assert.equal(await page.locator('[data-navigation-id]').count(),0);assert.equal(await page.locator('#slot').getAttribute('data-drawer-open'),'false');
 await page.setViewportSize({width:1500,height:960});await page.evaluate(()=>{view.dispose();manager.dispose();});assert.equal(await page.locator('#slot').locator('*').count(),0);assert.equal(await page.locator('#unsaved').inputValue(),'Unfinished main form');assert.deepEqual(errors,[]);
 console.log(JSON.stringify({threeCompositions:true,ltrRtlNestedKeyboard:true,activeRoute:true,foldHoverFocusPin:true,railTabs:true,mobileTrapEscape:true,deniedSubtreeHidden:true,revocation:true,unsavedMainRetained:true,dispose:true,productionMounted:false}));
}finally{await browser.close();await new Promise(r=>server.close(r));}
