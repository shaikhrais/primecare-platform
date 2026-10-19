/** Shared-shell component regression only: no login, API mutation or whole duty claim. */
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {mkdir,readFile,writeFile} from 'node:fs/promises';
import {execFileSync} from 'node:child_process';
import {createHash} from 'node:crypto';
import {launchCareBrowser} from './care-browser-launch.mjs';
const out='test-results/care/sidebar-content';await mkdir(out,{recursive:true});await writeFile(out+'/results.json',JSON.stringify({passed:false,scope:'shared shell and care alert components only'}));
const hash=bytes=>createHash('sha256').update(bytes).digest('hex'),cy=id=>'[data-cy="'+id+'"]';
const {outputFiles,metafile}=await build({stdin:{contents:"export {renderShell,bindShell} from './websites/typescript/src/shell';export {detailView} from './websites/typescript/src/care/views';",resolveDir:process.cwd()},bundle:true,format:'iife',globalName:'ScopeTest',write:false,metafile:true});
const policy=JSON.parse(await readFile('packages/shared/src/care/registry.json','utf8')),css=await readFile('websites/typescript/src/styles.css','utf8');
const theme=JSON.parse(execFileSync('python3',['-c',"import sqlite3,json;d=sqlite3.connect('file:.agents/governance/governance.db?mode=ro',uri=True);print(json.dumps(dict(d.execute('SELECT css_variable_name,token_value FROM theme_design_tokens WHERE theme_id=1 AND active=1'))))"]).toString());
for(const id of ['care-staffing-warning','care-exception-summary','care-correction-request'])assert.ok(Object.hasOwn(policy.controls,id),'Existing governed control: '+id);
const sources={};for(const path of [...Object.keys(metafile.inputs).filter(p=>p!=='<stdin>'&&!p.includes('node_modules/')),'scripts/test-sidebar-content-browser.mjs','scripts/care-browser-launch.mjs','websites/typescript/src/styles.css'])sources[path]=hash(await readFile(path));
const browser=await launchCareBrowser(),cases=[];
try{
 for(const locale of ['en','fr','es'])for(const width of [320,768,1024,1025,1440]){
  const record=locale==='en'&&width===320,context=await browser.newContext({viewport:{width,height:900},...(record?{recordVideo:{dir:out+'/video',size:{width,height:900}}}:{})}),page=await context.newPage(),errors=[];page.on('pageerror',e=>errors.push(e.message));
  await page.setContent('<!doctype html><html><head><meta name="viewport" content="width=device-width,initial-scale=1"><title>PrimeCare layout regression</title></head><body><div id="app"></div></body></html>');await page.addStyleTag({content:css});await page.addScriptTag({content:outputFiles[0].text});
  for(const kind of ['staffing','exception','correction']){
   await page.evaluate(({locale,theme,labels,kind})=>{
    for(const [key,value] of Object.entries(theme))if(key.startsWith('--'))document.documentElement.style.setProperty(key,value);
    const t=key=>{if(!(key in labels))throw Error('Missing translation: '+locale+'/'+key);return labels[key];};
    const detail={id:'synthetic-case',visit_id:'synthetic-visit',state:kind==='staffing'?'accepted':kind==='exception'?'coverage_needed':'correction_requested',version:1,requested_start_at:'2026-10-20T12:00:00Z',clinical:false,actions:[],plan:null,taskOutcomes:[],events:[],openConcerns:[],...(kind==='staffing'?{staffingReason:'leave_conflict'}:kind==='exception'?{exception:{reason:'cannot_attend',createdAt:'2026-10-20T11:00:00Z'}}:{correctionRequest:{payload:{note:'Synthetic documentation correction'}}})};
    const root=document.getElementById('app');ScopeTest.renderShell(root,{home:'/care?enable-semantics=true',role:t('role_psw'),navigation:'',controls:'',content:ScopeTest.detailView(t,{detail,capabilities:{qualified:true},people:[]},null)});ScopeTest.bindShell(root,t('title'),locale,t('scope_note'),()=>[]);
   },{locale,theme,labels:policy.locales[locale],kind});
   const id=kind==='staffing'?'care-staffing-warning':kind==='exception'?'care-exception-summary':'care-correction-request';
   assert.equal(await page.locator(cy(id)).isVisible(),true,locale+':'+width+':'+kind);
   const style=await page.locator(cy(id)).evaluate(e=>{const s=getComputedStyle(e);return {position:s.position,display:s.display};});assert.equal(style.position,'static');assert.notEqual(style.display,'none');
   assert.equal(await page.locator(cy('app-shell')).count(),1);assert.equal(await page.locator(cy('app-topbar')).isVisible(),true);
   const sidebar=page.locator(cy('app-sidebar')),toggle=page.locator(cy('sidebar-toggle'));
   if(width<=1024){
    assert.equal(await sidebar.isVisible(),false);await toggle.click();assert.equal(await sidebar.isVisible(),true);assert.equal(await toggle.getAttribute('aria-expanded'),'true');assert.equal(await page.locator(cy(id)).isVisible(),true);await page.locator(cy('sidebar-close')).press('Escape');assert.equal(await sidebar.isVisible(),false);assert.equal(await toggle.getAttribute('aria-expanded'),'false');assert.equal(await toggle.evaluate(e=>document.activeElement===e),true);await toggle.click();await page.locator(cy('sidebar-close')).click();assert.equal(await sidebar.isVisible(),false);assert.equal(await page.locator(cy(id)).isVisible(),true);
   }else{assert.equal(await sidebar.isVisible(),true);assert.equal(await toggle.isVisible(),false);}
   assert.ok(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1),locale+':'+width+':'+kind+' overflow');
  }
  for(const hidden of [true,false]){
   await page.evaluate(({hidden,labels})=>{const root=document.getElementById('app'),content=root.querySelector('[data-cy=care-detail]').outerHTML;ScopeTest.renderShell(root,{home:'/care?enable-semantics=true',role:labels.role_psw,navigation:'',controls:'',content,hideChrome:hidden});},{hidden,labels:policy.locales[locale]});
   assert.equal(await page.locator(cy('app-topbar')).isVisible(),!hidden);assert.equal(await page.locator(cy('app-sidebar')).isVisible(),!hidden&&width>1024);assert.equal(await page.locator(cy('care-correction-request')).isVisible(),true);assert.ok(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1));
  }
  assert.deepEqual(errors,[]);const video=record?page.video():null;await context.close();if(video)await video.saveAs(out+'/mobile-alerts.webm');cases.push({locale,width,threeAlertKindsVisible:true,chromeHideRestore:true,sidebarResponsive:true,keyboardEscape:width<=1024?true:null,closeButton:width<=1024?true:null,noOverflow:true});
 }
 for(const [path,expected] of Object.entries(sources))assert.equal(hash(await readFile(path)),expected,'Source changed: '+path);
 await writeFile(out+'/results.json',JSON.stringify({passed:true,scope:'shared shell and care alert components only',wholeTaskVerified:false,cases,sources,limitations:['Synthetic component data; no role login or API/database workflow verification','No full accessibility or PWA acceptance claimed']},null,2)+'\n');console.log(JSON.stringify({passed:true,cases:cases.length,alertRenders:cases.length*3,wholeTaskVerified:false}));
}finally{await browser.close();}
