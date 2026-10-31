import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {createServer} from 'node:http';
import {mkdir,readFile,writeFile} from 'node:fs/promises';
import {pathToFileURL} from 'node:url';
import {join} from 'node:path';
const {chromium} = await import('playwright').catch(error => {
  if (!process.env.CODEX_PRIMARY_RUNTIME_NODE_MODULES) throw error;
  return import(pathToFileURL(join(process.env.CODEX_PRIMARY_RUNTIME_NODE_MODULES,'playwright/index.mjs')).href);
});
const bundle = await build({stdin:{contents:`export * from './packages/primecare_ui/web/workspace-layout'; export {validateWorkspaceLayout,parseWorkspaceLayout} from './packages/domain/src/workspace_layout';`,resolveDir:process.cwd()},bundle:true,write:false,format:'iife',globalName:'Workspace'});
const fixture = (await readFile('scripts/fixtures/workspace-layout.html','utf8')).replace('__PRIMECARE_LAYOUT_BUNDLE__',bundle.outputFiles[0].text);
const server = createServer(async(req,res)=>{res.setHeader('Content-Type','text/html');res.end(req.url.startsWith('/preview')?await readFile('docs/appearance/previews/workspace-layout.html','utf8'):fixture);});
await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
const origin='http://127.0.0.1:'+server.address().port;
const browser=await chromium.launch({headless:true,...(process.env.PRIMECARE_CHROMIUM_EXECUTABLE?{executablePath:process.env.PRIMECARE_CHROMIUM_EXECUTABLE,args:['--no-sandbox','--disable-dev-shm-usage']}: {})}); const context=await browser.newContext({viewport:{width:1500,height:960}});const page=await context.newPage();const errors=[];page.on('pageerror',error=>errors.push(error.message));
const out='artifacts/workspace-layout';await mkdir(out,{recursive:true});
try {
  await page.goto(origin+'/?enable-semantics=true');
  await page.locator('[data-cy=test-input]').fill('Unsaved client note');
  const summary=await page.evaluate(()=>{
    const m=window.manager;const input=document.querySelector('[data-cy=test-input]');const main=window.slots.main;let clicks=0;input.addEventListener('click',()=>clicks++);
    for(const navigation of ['left','right','top','bottom','hidden'])for(const container of ['fullwidth','boxed','content'])for(const toolbar of ['top','bottom'])for(const scroll of ['page','content']) {
      m.change({...m.current,navigation,container,toolbar,scroll,toolbarStyle:'static'});
      const n=slots.navigation.getBoundingClientRect(), content=slots.main.getBoundingClientRect(), t=slots.toolbar.getBoundingClientRect();
      if(navigation==='left'&&n.right>content.left+1)throw Error('Left navigation overlaps main');
      if(navigation==='right'&&n.left<content.right-1)throw Error('Right navigation overlaps main');
      if(navigation==='top'&&n.bottom>content.top+1)throw Error('Top navigation overlaps main');
      if(navigation==='bottom'&&n.top<content.bottom-1)throw Error('Bottom navigation overlaps main');
      if(navigation==='hidden'&&slots.navigation.getClientRects().length)throw Error('Hidden navigation remains visible');
      const stage=document.querySelector('[data-pc-stage]').getBoundingClientRect();
      if(toolbar==='top'&&t.bottom>stage.top+1)throw Error('Top toolbar overlaps main');
      if(toolbar==='bottom'&&t.top<stage.bottom-1)throw Error('Bottom toolbar overlaps main');
      if(document.documentElement.scrollWidth>innerWidth+1)throw Error('Desktop layout overflows');
    }
    if(window.slots.main!==main||input.value!=='Unsaved client note'||!document.contains(input))throw Error('Layout replaced live content');input.click();if(clicks!==1)throw Error('Layout lost event handler');
    const source=m.exportJson();m.reset();m.importJson(source);if(m.exportJson()!==source)throw Error('JSON roundtrip failed');
    const snapshot=m.exportJson();const bad=[{...m.current,role:'admin'},{...m.current,navigation:'url(evil)'},{...m.current,maxWidth:NaN},{...m.current,version:2},{...m.current,panels:{...m.current.panels,unauthorized:m.current.panels.schedule}},{...m.current,panels:{schedule:m.current.panels.schedule}},{...m.current,panels:{...m.current.panels,schedule:{...m.current.panels.schedule,width:1}}}];
    for(const v of bad){let failed=false;try{m.change(v);}catch{failed=true;}if(!failed||m.exportJson()!==snapshot)throw Error('Invalid data changed layout');}
    let oversized=false;try{m.importJson(' '.repeat(32769));}catch{oversized=true;}if(!oversized)throw Error('Oversized JSON accepted');
    let denied=false;try{m.dockPanel('unauthorized','left');}catch{denied=true;}if(!denied)throw Error('Unauthorized panel accepted');
    m.reset();m.dockPanel('schedule','left');m.undo();if(m.current.panels.schedule.dock!=='right')throw Error('Undo failed');m.redo();if(m.current.panels.schedule.dock!=='left')throw Error('Redo failed');
    m.dockPanel('messages','floating');m.save();window.saved=m.exportJson();
    return {layoutCombinations:60,invalidProfiles:bad.length,liveInput:true,eventHandler:true,roundTrip:true,undoRedo:true,unknownPanelRejected:true};
  });
  // Pointer movement and a single undo checkpoint per gesture.
  const handle=page.locator('[data-cy=test-drag-a]');let box=await handle.boundingBox();await page.mouse.move(box.x+20,box.y+20);await page.mouse.down();await page.mouse.move(500,220,{steps:5});await page.mouse.up();
  assert.equal(await page.evaluate(()=>manager.current.panels.schedule.dock),'floating');
  await page.evaluate(()=>manager.undo());assert.equal(await page.evaluate(()=>manager.current.panels.schedule.dock),'left');
  await page.evaluate(()=>manager.redo());
  await handle.focus();await page.keyboard.press('Control+ArrowRight');assert.equal(await page.evaluate(()=>manager.current.panels.schedule.dock),'right');
  await handle.focus();await page.keyboard.press('ArrowLeft');assert.equal(await page.evaluate(()=>manager.current.panels.schedule.dock),'floating');
  const oldWidth=await page.evaluate(()=>manager.current.panels.schedule.width);await handle.focus();await page.keyboard.press('Shift+ArrowRight');assert.equal(await page.evaluate(()=>manager.current.panels.schedule.width),oldWidth+16);
  // Cancel must restore the profile without adding a history entry.
  const before=await page.evaluate(()=>manager.exportJson());box=await handle.boundingBox();await page.mouse.move(box.x+10,box.y+10);await page.mouse.down();await page.mouse.move(box.x+60,box.y+60);await page.keyboard.press('Escape');await page.mouse.up();assert.equal(await page.evaluate(()=>manager.exportJson()),before);
  // Saved geometry must remain recoverable after a smaller viewport.
  await page.evaluate(()=>{manager.change({...manager.current,navigation:'right',toolbar:'bottom',footer:'sticky',container:'boxed',scroll:'content',panels:{...manager.current.panels,schedule:{dock:'floating',x:9000,y:9000,width:500,height:600}}});manager.save();});
  const desktop=await page.locator('[data-cy=test-panel-a]').boundingBox();assert.ok(desktop.x+desktop.width<=1500&&desktop.y+desktop.height<=960);
  await page.screenshot({path:out+'/desktop.png'});
  await page.setViewportSize({width:390,height:844});await page.waitForFunction(()=>document.querySelector('[data-pc-workspace]').dataset.narrow==='true');
  assert.ok(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1));
  const mobile=await page.locator('[data-cy=test-panel-a]').boundingBox();assert.ok(mobile.x>=0&&mobile.x+mobile.width<=391);
  assert.equal(await page.evaluate(()=>manager.current.panels.schedule.x),9000);
  await page.screenshot({path:out+'/mobile.png'});
  await page.reload();assert.equal(await page.evaluate(()=>manager.current.navigation),'right');assert.equal(await page.evaluate(()=>manager.current.panels.schedule.x),9000);
  await page.evaluate(()=>{manager.dispose();window.other=new Workspace.WorkspaceLayoutManager(document.querySelector('#shell'),slots,'layout:tenant-b:actor-b:role-a');if(other.current.navigation!=='left')throw Error('Account preferences leaked');other.dispose();});
  assert.equal(await page.locator('[data-cy=test-input]').count(),1);
  assert.equal(await page.locator('[data-pc-workspace]').count(),0);
  await page.goto(origin+'/preview?enable-semantics=true');
  await page.locator('[data-cy=preview-navigation]').selectOption('top');
  await page.locator('[data-cy=preview-container]').selectOption('boxed');
  await page.locator('[data-cy=preview-panel]').selectOption('floating');
  await page.locator('[data-cy=preview-save]').click();
  assert.equal(await page.evaluate(()=>manager.current.navigation),'top');
  assert.equal(await page.evaluate(()=>manager.current.panels.schedule.dock),'floating');
  await page.locator('[data-cy=preview-reset]').click();
  assert.equal(await page.evaluate(()=>manager.current.navigation),'left');
  assert.ok(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1));
  await page.setViewportSize({width:1500,height:960});
  await page.screenshot({path:out+'/layout-lab.png'});
  assert.deepEqual(errors,[]);
  const result={...summary,pointerDrag:true,keyboardDockMoveResize:true,cancelGesture:true,viewportClamping:true,mobileReflow:true,persistence:true,accountIsolation:true,dispose:true,previewControls:true,productionMounted:false};
  await writeFile(out+'/results.json',JSON.stringify(result,null,2));
  console.log(JSON.stringify(result));
} finally {await context.close();await browser.close();await new Promise(resolve=>server.close(resolve));}
