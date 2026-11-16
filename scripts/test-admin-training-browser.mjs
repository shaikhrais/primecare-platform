import {execFileSync} from 'node:child_process';
import {build} from 'esbuild';import {test} from 'node:test';import assert from 'node:assert/strict';import {createServer} from 'node:http';import {readFile} from 'node:fs/promises';import {chromium} from 'playwright';
const course=JSON.parse(await readFile('websites/typescript/src/training/admin-course.json','utf8'));const style=await readFile('websites/typescript/src/styles.css','utf8');const baseTheme=JSON.parse(execFileSync('python3',['-c',"import sqlite3,json;d=sqlite3.connect('.agents/governance/governance.db');print(json.dumps(dict(d.execute('SELECT css_variable_name,token_value FROM theme_design_tokens WHERE theme_id=1 AND active=1'))))"]).toString());const guideTheme={...baseTheme,...JSON.parse(await readFile('packages/shared/src/solid-theme.json','utf8'))};const guideTokens=Object.entries(guideTheme).map(([k,v])=>k+':'+v+';').join('');
const {outputFiles}=await build({stdin:{contents:"import {trainingPanel,openAdminTraining} from './websites/typescript/src/admin-training';import {liveScreenText} from './websites/typescript/src/screen-text';import course from './websites/typescript/src/training/admin-course.json';window.store=liveScreenText(location.origin);window.store.seed({admin_training:course.locales});const params=new URLSearchParams(location.search);document.getElementById('app').append(trainingPanel(location.origin,params.get('actor')||'test-user',params.get('lang')||'en',undefined,params.get('presentation')==='task-first'?'task-first':'shared'));document.getElementById('open').onclick=()=>openAdminTraining(location.origin,'test-user','en');",resolveDir:process.cwd()},bundle:true,platform:'browser',format:'iife',write:false});
const server=createServer(async(req,res)=>{if(req.url?.startsWith('/assets/guides/')){res.setHeader('content-type','image/png');res.end(await readFile('websites/typescript/public'+req.url));return;}res.setHeader('content-type','text/html; charset=utf-8');res.end(`<html data-surface-style="solid"><head><meta name="viewport" content="width=device-width,initial-scale=1"><style>:root{${guideTokens}}</style><style>${style}</style></head><body><button id=open data-cy=training-test-open>Open</button><main id=app></main><script>${outputFiles[0].text.replaceAll('</script','<\\/script')}</script></body></html>`);});await new Promise(r=>server.listen(0,'127.0.0.1',r));const base='http://127.0.0.1:'+server.address().port;const browser=await chromium.launch({headless:true});
try{
 for(const lang of ['en','fr','es'])await test(`admin course preserves local progress, safe export and keyboard access in ${lang}`,async()=>{
  const page=await browser.newPage({viewport:{width:lang==='en'?1440:390,height:900}});let requests=0;page.on('request',req=>{if(req.url().includes('/v1/'))requests++;});
  const el=id=>page.locator(`[data-cy=${id}]`);await page.goto(base+'/?lang='+lang+'&enable-semantics=true');await page.locator('.guide-detailed-lessons summary').click();await el('screen-admin-training').waitFor();assert.equal(await page.locator('[data-training-text=title]').first().textContent(),course.locales[lang].title);
  await el('training-submit').click();assert.equal(await el('training-status').textContent(),course.locales[lang].select_answer);
  await el('training-answer-0').click();await el('training-submit').click();assert.equal(await el('training-status').textContent(),course.locales[lang].incorrect);assert.match(await el('training-progress').textContent(),/0\/8/);
  await el('training-answer-1').click();await el('training-language-fr').click();assert.equal(await el('training-answer-1').getAttribute('aria-pressed'),'true');await page.evaluate(()=>{const c=window.store.catalog('admin_training');c.locales.fr.title='Device training';window.store.saveLocal('admin_training',c.version,c.locales);});assert.equal(await page.locator('[data-training-text=title]').first().textContent(),'Device training');assert.equal(await el('training-answer-1').getAttribute('aria-pressed'),'true');
  await el('training-language-'+lang).click();await el('training-submit').click();assert.match(await el('training-progress').textContent(),/1\/8/);await page.reload();await page.locator('.guide-detailed-lessons summary').click();await el('screen-admin-training').waitFor();assert.match(await el('training-progress').textContent(),/1\/8/);
  for(const module of course.modules.slice(1)){await el('training-lesson-'+module.id).click();await el('training-answer-'+module.correct).click();await el('training-submit').click();}
  assert.match(await el('training-progress').textContent(),/8\/8/);await el('training-complete').waitFor();
  const downloaded=page.waitForEvent('download');await el('training-export').click();const download=await downloaded;const summary=JSON.parse(await readFile(await download.path(),'utf8'));assert.equal(summary.recordType,'device-self-assessment');assert.equal(summary.supervisorVerified,false);assert.equal(summary.passed.length,8);assert.deepEqual(Object.keys(summary).sort(),['course','generatedAt','passed','recordType','supervisorVerified','total','version']);
  await page.goto(base+'/?actor=another&enable-semantics=true');await page.locator('.guide-detailed-lessons summary').click();await el('screen-admin-training').waitFor();assert.match(await el('training-progress').textContent(),/0\/8/);await page.goto(base+'/?lang='+lang+'&enable-semantics=true');await page.locator('.guide-detailed-lessons summary').click();await el('screen-admin-training').waitFor();assert.match(await el('training-progress').textContent(),/8\/8/);
  page.once('dialog',d=>d.accept());await el('training-reset').click();assert.match(await el('training-progress').textContent(),/0\/8/);await page.evaluate(()=>{Storage.prototype.setItem=()=>{throw Error('blocked');};});await el('training-answer-1').click();await el('training-submit').click();assert.equal(await el('training-status').textContent(),course.locales[lang].storage_error);assert.match(await el('training-progress').textContent(),/0\/8/);assert.equal(requests,0);
  assert.ok(await page.evaluate(()=>document.documentElement.scrollWidth<=window.innerWidth+1));await el('training-test-open').click();await el('training-dialog').waitFor();assert.equal(await page.evaluate(()=>document.querySelector('[data-cy=training-dialog]').contains(document.activeElement)),true);await page.keyboard.press('Escape');await el('training-dialog').waitFor({state:'detached'});assert.equal(await el('training-dialog').count(),0);assert.equal(await page.evaluate(()=>document.activeElement.dataset.cy),'training-test-open');await page.close();
 });
 await test('task-first admin training shows ordered lessons and resumes the next incomplete lesson',async()=>{
  const page=await browser.newPage({viewport:{width:390,height:900}});
  try{
   const cy=id=>page.locator('[data-cy="'+id+'"]');
   const current=()=>page.locator('[data-cy=training-lessons] [aria-current=step]').getAttribute('data-cy');
   await page.goto(base+'/?lang=fr&presentation=task-first&enable-semantics=true');
   await cy('screen-admin-training').waitFor();
   assert.equal(await page.locator('.guide-detailed-lessons').evaluate(e=>e.open),true);
   assert.equal(await page.locator('.guide-detailed-lessons summary').textContent(),course.locales.fr.lessons);
   assert.equal(await cy('screen-admin-training').evaluate(e=>!!(e.closest('details').compareDocumentPosition(document.querySelector('[data-cy=getting-started-guide]'))&Node.DOCUMENT_POSITION_FOLLOWING)),true);
   assert.deepEqual(await cy('training-lessons').locator('button').evaluateAll(e=>e.map(x=>x.dataset.lesson)),course.modules.map(m=>m.id));
   assert.equal(await current(),'training-lesson-authority');
   await cy('training-answer-'+course.modules[0].correct).click();await cy('training-submit').click();
   assert.match(await cy('training-progress').textContent(),/1\/8/);
   await page.reload();await cy('screen-admin-training').waitFor();
   assert.equal(await current(),'training-lesson-routine');
   page.once('dialog',d=>d.accept());await cy('training-reset').click();
   assert.equal(await current(),'training-lesson-authority');
   assert.match(await cy('training-progress').textContent(),/0\/8/);
   await page.locator('.guide-detailed-lessons summary').press('Enter');
   assert.equal(await page.locator('.guide-detailed-lessons').evaluate(e=>e.open),false);
   assert.equal(await cy('screen-admin-training').isVisible(),false);
  }finally{await page.close();}
 });
}finally{await browser.close();await new Promise(r=>server.close(r));}
