import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {build, transform} from 'esbuild';
import {tenantStyles, tenantView, taskForm, taskDetail, tenantNavigation} from '../packages/shared/src/tenant-dashboard/view.mjs';
import catalog from '../packages/shared/src/tenant-dashboard/catalog.json' with {type:'json'};
import solidTheme from '../packages/shared/src/solid-theme.json' with {type:'json'};
const {outputFiles}=await build({stdin:{contents:`export * from './packages/primecare_ui/web/layout-manager';export * from './packages/primecare_ui/web/theme-manager';export * from './packages/domain/src/theme_center';`,resolveDir:process.cwd()},bundle:true,write:false,platform:'node',format:'esm'});
const {BaseLayoutManager,defaultPersonalTheme,themePresets,contrastRatio}=await import('data:text/javascript;base64,'+Buffer.from(outputFiles[0].text).toString('base64'));
// These are source/token contracts and manager execution on a deterministic fixture,
// not browser computed-style, keyboard, responsive or production-service evidence.
function rule(selector){const start=tenantStyles.indexOf(selector+'{');assert.notEqual(start,-1,selector);return Object.fromEntries(tenantStyles.slice(start+selector.length+1,tenantStyles.indexOf('}',start)).split(';').filter(Boolean).map(entry=>{const i=entry.indexOf(':');return [entry.slice(0,i),entry.slice(i+1)];}));}
function element(doc){const values=new Map();return {ownerDocument:doc,dataset:{},children:[],style:{getPropertyValue:key=>values.get(key)??'',setProperty:(key,value)=>values.set(key,value),removeProperty:key=>values.delete(key)},querySelectorAll:()=>[]};}
function managerFixture(){const doc={};doc.documentElement=element(doc);const root=element(doc),shell=element(doc),storage=[];const original=Object.getOwnPropertyDescriptor(globalThis,'localStorage');Object.defineProperty(globalThis,'localStorage',{configurable:true,value:{getItem:key=>{storage.push(['read',key]);return null;},setItem:(key,value)=>storage.push(['write',key,value])}});const manager=new BaseLayoutManager(root,null,()=>shell);return {root,shell,doc,manager,storage,restore(){if(original)Object.defineProperty(globalThis,'localStorage',original);else delete globalThis.localStorage;}};}
const defaults={'--font-family':'Inter, sans-serif','--font-size-body':'14px','--font-size-heading':'24px','--font-size-caption':'12px','--radius-md':'8px','--radius-lg':'16px','--color-background':'#ffffff','--color-text':'#172033','--color-text-muted':'#526078','--color-primary':'#006b68','--color-surface':'#ffffff','--color-border':'#cbd5e1'};

test('tenant CSS parses and typography consumes shared tokens instead of fixed type',async()=>{
 assert.deepEqual((await transform(tenantStyles,{loader:'css',target:'es2022'})).warnings,[]);
 assert.equal(rule('.td-root').font,'var(--font-size-body,14px)/1.55 var(--font-family,system-ui,sans-serif)');
 assert.equal(rule('.td-root h1')['font-size'],'var(--font-size-heading,32px)');
 assert.equal(rule('.td-root h2')['font-size'],'calc(var(--font-size-heading,24px) * .75)');
 for(const selector of ['.td-eyebrow','.td-stat small','.td-root .td-badge','.td-root th','.td-root td button','.td-avatar'])assert.match(rule(selector)['font-size'],/^var\(--font-size-caption,/);
 assert.equal(rule('.td-root table')['font-size'],'var(--font-size-body,13px)');
 assert.equal(rule('.td-root input,.td-root select,.td-root textarea').font,'inherit');
 // The mobile rule must not reintroduce a fixed heading size.
 assert.match(tenantStyles,/@media\(max-width:800px\)[\s\S]*\.td-root h1\{font-size:var\(--font-size-heading,26px\)/);
});
test('managed width, compact density and radii use the existing shell contract',async()=>{
 const root=rule('.td-root'),card=rule('.td-root .td-card');assert.equal(root['max-width'],catalog.theme.contentMax);
 assert.equal(rule('.tenant-dashboard-main>.td-root')['max-width'],'none');
 const compact=rule('.app-shell[data-density=compact] .td-root');assert.equal(compact['--td-gap'],'var(--spacing-md,16px)');assert.equal(compact['--td-pad'],'var(--spacing-md,16px)');
 assert.equal(root['--td-pad'],'var(--spacing-lg,22px)');assert.equal(root['--td-gap'],'var(--spacing-lg,20px)');assert.equal(root['--td-radius'],'var(--radius-lg,12px)');
 assert.equal(card.padding,'var(--td-pad)');assert.equal(card['border-radius'],'var(--td-radius)');assert.equal(rule('.td-grid').gap,'var(--td-gap)');
 assert.equal(rule('.td-root button,.td-root .td-button')['border-radius'],'var(--radius-md,8px)');assert.equal(rule('.td-dialog')['border-radius'],'var(--radius-lg,12px)');
 const shellCss=await readFile('websites/typescript/src/styles.css','utf8');assert.match(shellCss,/\.app-shell main\s*\{\s*width:var\(--layout-content-width,100%\)/);
});
test('surface text is paired locally with cards, inputs and body-mounted dialogs',()=>{
 const root=rule('.td-root'),surface=rule('.td-root .td-card,.td-dialog.td-root');assert.equal(root['--td-foreground'],'var(--color-text)');assert.equal(root['--td-muted'],'var(--color-text-muted)');
 assert.equal(surface['--td-foreground'],'var(--color-surface-text,var(--color-text))');assert.equal(surface['--td-muted'],'var(--color-surface-muted,var(--color-text-muted))');
 assert.equal(rule('.td-root p').color,'var(--td-muted)');assert.equal(rule('.td-quick').color,'var(--td-foreground)');
 for(const selector of ['.td-root button,.td-root .td-button','.td-root input,.td-root select,.td-root textarea','.td-dialog'])assert.equal(rule(selector).color,'var(--color-surface-text,var(--color-text))');
 assert.equal(rule('.td-root .td-badge.good').color,'var(--color-on-primary)');assert.equal(rule('.td-primary').color,'var(--color-on-primary)!important');
});
test('actual shared manager changes consumed tokens without replacing draft nodes or dispatching writes',()=>{
 const f=managerFixture();try{const {root,shell,doc,manager,storage}=f,submit=()=>{},form={onsubmit:submit},field={value:'Unsaved tenant task'},button={disabled:true};root.children=[form,field,button];const original=[...root.children];
 manager.setDefaultTheme(defaults);manager.change({...manager.current,theme:'dark',density:'compact',contentWidth:80});assert.equal(shell.dataset.density,'compact');assert.equal(shell.style.getPropertyValue('--layout-content-width'),'80%');assert.equal(doc.documentElement.style.colorScheme,'dark');
 manager.setPersonalTheme({...defaultPersonalTheme,fontFamily:'serif',fontScale:1.5,radius:0,colors:{background:'#ffffff',surface:'#f0f0f0',text:'#172033',muted:'#526078'}});
 assert.equal(doc.documentElement.style.getPropertyValue('--font-family'),'Georgia, serif');assert.equal(doc.documentElement.style.getPropertyValue('--font-size-body'),'calc(14px * 1.5)');assert.equal(doc.documentElement.style.getPropertyValue('--font-size-heading'),'calc(24px * 1.5)');assert.equal(doc.documentElement.style.getPropertyValue('--radius-lg'),'0px');
 for(const key of ['--color-surface-text','--color-surface-muted'])assert.ok(contrastRatio(doc.documentElement.style.getPropertyValue(key),doc.documentElement.style.getPropertyValue('--color-surface'))>=4.5);
 manager.setPersonalTheme(null);manager.undo();assert.equal(shell.dataset.density,'comfortable');assert.equal(shell.style.getPropertyValue('--layout-content-width'),'100%');assert.equal(doc.documentElement.style.getPropertyValue('--font-family'),defaults['--font-family']);manager.redo();assert.equal(shell.dataset.density,'compact');
 assert.deepEqual(root.children,original);assert.equal(form.onsubmit,submit);assert.equal(field.value,'Unsaved tenant task');assert.equal(button.disabled,true);assert.deepEqual(storage,[]);
 manager.dispose();assert.equal(shell.dataset.density,undefined);assert.equal(shell.style.getPropertyValue('--layout-content-width'),'');
 }finally{f.restore();}
});
test('responsive stacking, focus, disabled, hidden and dialog scrolling safeguards remain present',()=>{
 assert.match(tenantStyles,/@media\(max-width:800px\)\{\.td-grid,\.td-grid.two,\.td-grid.three,\.td-fields\{grid-template-columns:1fr\}/);
 assert.equal(rule('.td-table-wrap').overflow,'auto');assert.equal(rule('.td-view[hidden]').display,'none');assert.equal(rule('.td-root button:disabled').opacity,'.5');assert.equal(rule('.td-root :focus-visible').outline,'3px solid var(--color-primary)');
 const dialog=rule('.td-dialog');assert.equal(dialog.width,'min(800px,95vw)');assert.equal(dialog['max-height'],'90vh');assert.equal(dialog.overflow,'auto');
});
test('presentation keeps permitted navigation, server-provided actions and escaped task drafts',()=>{
 const denied=tenantNavigation('tasks',()=>'', ['tasks'],false);assert.match(denied,/tenant-nav-tasks/);assert.doesNotMatch(denied,/tenant-nav-people|tenant-admin-settings/);
 const data={dataset:'live',organization:{name:'Fixture tenant'},tasks:[],workflows:[],taskPage:{total:0,offset:0},preference:{view:'tasks'},allowedViews:['tasks'],users:[],canCreate:false,canManage:false,today:'2026-11-06',database:'Fixture PostgreSQL'};
 const html=tenantView(data,{view:'tasks',search:'draft<value>',notice:'Pending <save>'});assert.match(html,/value="draft&lt;value&gt;"/);assert.match(html,/Pending &lt;save&gt;/);assert.doesNotMatch(html,/data-cy="tenant-create-task"|<option value="people"/);
 const task={title:'Draft <title>',notes:'Private <draft>',due_on:'2026-11-06',actions:['start'],status:'open',ownerName:'Fixture'};
 const form=taskForm(data,task);assert.match(form,/value="Draft &lt;title&gt;"/);assert.match(form,/Private &lt;draft&gt;/);assert.match(form,/data-cy="tenant-task-save"/);assert.match(form,/data-cy="tenant-dialog-close"/);
 const detail=taskDetail(task);assert.match(detail,/data-cy="tenant-action-start"/);assert.doesNotMatch(detail,/tenant-action-complete/);
});

// Restricted cascade model for the selectors matching the tested banner/badges.
// It catches the generic paragraph specificity regression; it is not a browser CSS engine.
function winningDeclaration(selectors, property){
 const weight=selector=>{const classes=(selector.match(/\.[\w-]+/g)||[]).length;const tags=selector.replace(/\.[\w-]+/g,'').trim().split(/\s+/).filter(Boolean).length;return classes*100+tags;};
 const matches=selectors.map(selector=>({value:rule(selector)[property],weight:weight(selector),order:tenantStyles.indexOf(selector+'{')})).filter(x=>x.value!==undefined).sort((a,b)=>a.weight-b.weight||a.order-b.order);
 assert.ok(matches.length,property);return matches.at(-1).value;
}
function cssValue(value,host,scope=rule('.td-root')){
 for(let i=0;i<20&&value.includes('var(');i++){
  const next=value.replace(/var\((--[\w-]+)(?:,([^()]*))?\)/g,(_,key,fallback)=>host.style.getPropertyValue(key)||scope[key]||fallback||'');
  assert.notEqual(next,value,'unresolved CSS token '+value);value=next;
 }
 assert.doesNotMatch(value,/var\(/);return value;
}
function noticePairs(host){
 const nodes={banner:['.td-root p','.td-banner','.td-root .td-banner'],badge:['.td-root .td-badge'],goodBadge:['.td-root .td-badge','.td-root .td-badge.good']};
 return Object.fromEntries(Object.entries(nodes).map(([name,selectors])=>{const foreground=cssValue(winningDeclaration(selectors,'color'),host),background=cssValue(winningDeclaration(selectors,'background'),host);return [name,{foreground,background,ratio:contrastRatio(foreground,background)}];}));
}
test('root paragraph banners and neutral badges use the surface pair for the reported permitted theme',()=>{
 const f=managerFixture();try{
  f.manager.setDefaultTheme(defaults);f.manager.setPersonalTheme({...defaultPersonalTheme,colors:{background:'#ffffff',surface:'#777777',text:'#172033',muted:'#526078'}});
  const host=f.doc.documentElement,pairs=noticePairs(host);
  // Prove the fixture would expose both pre-existing unsafe main-background pairings.
  assert.ok(contrastRatio(host.style.getPropertyValue('--color-text-muted'),host.style.getPropertyValue('--color-surface-soft'))<1.5);
  assert.ok(contrastRatio(host.style.getPropertyValue('--color-text'),host.style.getPropertyValue('--color-surface-soft'))<4.5);
  for(const name of ['banner','badge']){assert.equal(pairs[name].foreground,'#000000');assert.equal(pairs[name].background,'#777777');assert.ok(pairs[name].ratio>=4.5,name+': '+pairs[name].ratio);}
  assert.deepEqual(rule('.td-root .td-banner'),{color:'var(--color-surface-text,var(--color-text))'},'override must not change banner geometry');
  assert.equal(winningDeclaration(['.td-root p','.td-banner','.td-root .td-banner'],'margin'),'6px 0 14px','preserve existing paragraph-banner margin precedence');
  assert.equal(winningDeclaration(['.td-root p','.td-banner','.td-root .td-banner'],'color'),'var(--color-surface-text,var(--color-text))');
  assert.equal(pairs.goodBadge.foreground,host.style.getPropertyValue('--color-on-primary'));assert.ok(pairs.goodBadge.ratio>=4.5);
 }finally{f.restore();}
});
test('banner and both badge variants preserve 4.5:1 token contrast across every accepted preset and base profiles',()=>{
 const f=managerFixture();try{
  f.manager.setDefaultTheme({...catalog.previewTheme,...solidTheme});let checked=0;
  for(const preset of Object.keys(themePresets)){
   f.manager.setPersonalTheme({...defaultPersonalTheme,preset});
   for(const [name,pair] of Object.entries(noticePairs(f.doc.documentElement)))assert.ok(pair.ratio>=4.5,`${preset} ${name}: ${pair.foreground}/${pair.background} = ${pair.ratio}`);
   checked++;
  }
  assert.equal(checked,Object.keys(themePresets).length);assert.ok(checked>=37);
  f.manager.setPersonalTheme(null);
  for(const theme of ['default','light','dark']){f.manager.change({...f.manager.current,theme});for(const [name,pair] of Object.entries(noticePairs(f.doc.documentElement)))assert.ok(pair.ratio>=4.5,`${theme} ${name}: ${pair.ratio}`);}
  // Standalone catalog consumers that only provide the legacy foreground still resolve.
  f.doc.documentElement.style.removeProperty('--color-surface-text');
  assert.equal(noticePairs(f.doc.documentElement).banner.foreground,f.doc.documentElement.style.getPropertyValue('--color-text'));
 }finally{f.restore();}
});
