/** GitHub Actions browser fixture only. Synthetic controls/transport are not live Help authority. */
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {createServer} from 'node:http';
import {chromium} from 'playwright';

const contents=`
import {HelpReaderView} from './packages/primecare_ui/web/help-reader';
import {createHelpReaderSession} from './packages/shared/src/help-reader/session';
import {AdvancedThemeRegions,defaultAdvancedTheme} from './packages/primecare_ui/web/advanced-theme';
const keys=['start','search','locale','previous','next','back','retry','article','open','idle','loading','empty','error','retired'];
const languages=['en','fr','es'];
const bindings=Object.fromEntries(keys.map(key=>[key,'help.'+key]));
const kind=key=>key==='search'?'prime_text_field':key==='locale'?'prime_dropdown_web':['article','idle','loading','empty','error','retired'].includes(key)?'prime_card':'prime_button';
const metadata={kind:'verified_metadata_export',controls:keys.map((key,index)=>({key:bindings[key],testId:'fixture-help-'+key,controlId:index+1,componentCode:kind(key)})),locales:Object.fromEntries(languages.map(locale=>[locale,Object.fromEntries(keys.map(key=>[bindings[key],locale+' '+key]))]))};
window.setup=(locale='en')=>{
 window.view?.dispose();window.session?.dispose();
 const root=document.querySelector('[data-cy="fixture-help-root"]');
 new AdvancedThemeRegions({main:root}).apply(defaultAdvancedTheme());
 window.commands=[];window.replyStatus=200;window.noResults=false;window.hold=false;window.currentOwner=true;
 const scope={tenantId:'tenant-a',userId:'psw-a',role:'psw',dataset:'live'};
 window.session=createHelpReaderSession({origin:'https://help.example',scope,getToken:()=> 't'.repeat(43),isCurrent:()=>window.currentOwner,fetcher:async(url,init)=>{
  if(url.endsWith('/v1/auth/me'))return Response.json({status:'authenticated',tenantId:scope.tenantId,userId:scope.userId,roles:scope.role});
  const request=JSON.parse(init.body);window.commands.push(request);
  if(window.hold)await new Promise(resolve=>window.release=()=>{window.hold=false;resolve();});
  if(window.replyStatus!==200)return new Response('PRIVATE provider diagnostic',{status:window.replyStatus});
  const article={id:request.articleId??'guide-'+request.offset,revision:1,title:request.locale+' Guide '+(request.offset??0),category:'Category',...(request.action==='read'?{body:'Plain <script>window.injected=true</script> body'}:{summary:'Summary'})};
  return Response.json({version:1,locale:request.locale,action:request.action,scope,...(request.action==='read'?{article}:{items:window.noResults?[]:[article],offset:request.offset,limit:request.limit,total:window.noResults?0:3})});
 }},{locale,limit:1});
 window.view=new HelpReaderView(root,{session:window.session,scope:'fixture-account',metadata,bindings,localeNames:language=>Object.fromEntries(languages.map(value=>[value,language+' '+value]))});
};
`;
const bundle=await build({stdin:{contents,resolveDir:process.cwd(),loader:'ts'},bundle:true,write:false,platform:'browser',format:'iife'});
const server=createServer((request,response)=>{
 if(request.url==='/fixture.js'){response.setHeader('content-type','text/javascript');response.end(bundle.outputFiles[0].text);}
 else{response.setHeader('content-type','text/html');response.end('<!doctype html><html><head><meta name="viewport" content="width=device-width,initial-scale=1"><title>Isolated Help reader</title></head><body><button data-cy="fixture-outside">Outside fixture</button><main data-cy="fixture-help-root"></main><script src="/fixture.js"></script></body></html>');}
});
await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
let browser;
const pages=[],errors=[];
const cy=(page,key,suffix='')=>page.locator('[data-cy="fixture-help-'+key+suffix+'"]');
const phase=(page,value)=>page.waitForFunction(value=>window.session.state.phase===value,value);
async function scene(locale='en',width=900,scale=false){
 const context=await browser.newContext({viewport:{width,height:720}}),page=await context.newPage();pages.push(page);
 page.on('pageerror',error=>errors.push(error.message));page.setDefaultTimeout(10000);
 await page.goto('http://127.0.0.1:'+server.address().port+'/?enable-semantics=true');
 await page.evaluate(({locale,scale})=>{if(scale)document.documentElement.style.fontSize='200%';window.setup(locale);},{locale,scale});return page;
}
try{
 browser=await chromium.launch({headless:true,...(process.env.PRIMECARE_CHROMIUM_EXECUTABLE?{executablePath:process.env.PRIMECARE_CHROMIUM_EXECUTABLE,args:['--no-sandbox']}:{} )});
 for(const locale of ['en','fr','es']){
  const page=await scene(locale,320,true);
  assert.equal(await page.evaluate(()=>window.commands.length),0);assert.equal(await cy(page,'idle').innerText(),locale+' idle');
  await cy(page,'start').click();await phase(page,'list');
  assert.ok(await cy(page,'open','-article-0').isVisible());assert.equal(await cy(page,'previous').isDisabled(),true);
  assert.ok((await cy(page,'next').boundingBox()).height>=44);
  assert.equal(await page.evaluate(()=>document.querySelector('[data-cy="fixture-help-root"]').scrollWidth<=document.querySelector('[data-cy="fixture-help-root"]').clientWidth+1),true);
  await cy(page,'next').click();await page.waitForFunction(()=>window.session.state.offset===1&&window.session.state.phase==='list');
  await cy(page,'search').fill('needle');await cy(page,'search').press('Enter');await page.waitForFunction(()=>window.session.state.query==='needle'&&window.session.state.phase==='list');
  assert.equal(await page.evaluate(()=>window.commands.at(-1).offset),0);assert.equal(await page.evaluate(()=>document.activeElement.getAttribute('data-cy')),'fixture-help-search');
  await cy(page,'open','-article-0').click();await phase(page,'detail');
  assert.ok((await cy(page,'article').innerText()).includes('Plain <script>window.injected=true</script> body'));
  assert.equal(await page.evaluate(()=>window.injected),undefined);assert.equal(await page.evaluate(()=>document.activeElement.getAttribute('data-cy')),'fixture-help-article');
  await cy(page,'back').click();await phase(page,'list');assert.equal(await page.evaluate(()=>document.activeElement.getAttribute('data-cy')),'fixture-help-search');
  const nextLocale=locale==='en'?'fr':locale==='fr'?'es':'en';await cy(page,'locale').selectOption(nextLocale);await page.waitForFunction(locale=>window.session.state.locale===locale&&window.session.state.phase==='list',nextLocale);
  assert.equal(await cy(page,'search').evaluate(input=>input.labels[0].textContent),nextLocale+' search');
 }
 const loading=await scene();await cy(loading,'start').click();await phase(loading,'list');
 await loading.evaluate(()=>{window.retained=document.querySelector('[data-cy="fixture-help-open-article-0"]');window.hold=true;});
 await cy(loading,'search').fill('replacement');await cy(loading,'search').press('Enter');await phase(loading,'loading');
 assert.equal(await cy(loading,'search').isDisabled(),true);assert.equal(await cy(loading,'loading').isVisible(),true);assert.equal(await cy(loading,'loading').getAttribute('role'),'status');assert.equal(await cy(loading,'root').innerText().then(text=>text.includes('Guide')),false);
 await loading.evaluate(()=>window.retained.click());assert.equal(await loading.evaluate(()=>window.commands.length),2);
 await loading.locator('[data-cy="fixture-outside"]').focus();await loading.evaluate(()=>window.release());await phase(loading,'list');
 assert.equal(await loading.evaluate(()=>document.activeElement.getAttribute('data-cy')),'fixture-outside','A pending read must not steal newly moved external focus');
 await loading.locator('[data-cy="fixture-outside"]').evaluate(element=>element.blur());await loading.evaluate(()=>window.session.load());await phase(loading,'list');
 assert.notEqual(await loading.evaluate(()=>document.activeElement.getAttribute('data-cy')),'fixture-help-search','A completed read cannot leave focus intent for a later programmatic read');
 await loading.evaluate(()=>{window.replyStatus=503;return window.session.backToList();});await phase(loading,'error');assert.equal((await cy(loading,'root').innerText()).includes('PRIVATE'),false);
 await loading.evaluate(()=>{window.replyStatus=200;window.noResults=true;});await cy(loading,'retry').click();await phase(loading,'empty');assert.equal(await cy(loading,'next').isDisabled(),true);
 await loading.evaluate(()=>{window.replyStatus=403;return window.session.backToList();});await phase(loading,'retired');assert.equal(await cy(loading,'retired').innerText(),'en retired');assert.equal(await cy(loading,'search').count(),0);assert.equal(await cy(loading,'locale').count(),0);assert.equal(await cy(loading,'retry').count(),0);
 const disposed=await scene();await cy(disposed,'start').click();await phase(disposed,'list');
 await disposed.evaluate(async()=>{window.retained=document.querySelector('[data-cy="fixture-help-open-article-0"]');window.view.dispose();window.retained.click();await window.session.load();});
 assert.equal(await cy(disposed,'root').innerText(),'');assert.equal(await disposed.evaluate(()=>window.session.state.phase),'list','Borrowed session remains usable after view disposal');
 assert.deepEqual(errors,[]);console.log('Help reader Actions fixture passed: EN/FR/ES, keyboard/focus, narrow 200% layout, plain text, lifecycle, retry and retirement.');
}finally{await Promise.all(pages.map(page=>page.context().close()));await browser?.close();await new Promise(resolve=>server.close(resolve));}
