import assert from 'node:assert/strict';import {build} from 'esbuild';import {createServer} from 'node:http';import {readFile,mkdir,writeFile} from 'node:fs/promises';import {createRequire} from 'node:module';import {chromium} from 'playwright';import {clientInvoicesFixture} from './client-invoices-fixture.mjs';import metadata from '../packages/primecare_ui/catalogs/client-invoices.registration.json' with {type:'json'};
const f=await clientInvoicesFixture();let server,browser,page,writes=0,checks=0,hold=false,failInvoices=false,lastWorkspaceStatus=null;const pending=[];
try{
 const built=await build({stdin:{contents:`import {ClientInvoices} from './packages/shared/src/client-invoices/client';import {PrimeClientInvoices} from './packages/primecare_ui/web/client-invoices';import {renderWorkspace} from './websites/typescript/src/workspace';import {installPortalPresentation} from './websites/typescript/src/screen-presentation';import {resolveManagedRoute} from './websites/typescript/src/managed-routes';import {tenantPresentationTheme} from './scripts/fixtures/tenant-presentation-theme';const root=document.querySelector('#app'),manager=installPortalPresentation(root,tenantPresentationTheme,location.origin);manager.registerScope('entry',[resolveManagedRoute(location.pathname,'ci')]);window.__invoiceFixture={ClientInvoices,PrimeClientInvoices};window.__invoiceStates=[];const emit=ClientInvoices.prototype.emit;ClientInvoices.prototype.emit=function(){window.__invoiceStates.push({status:this.current.status,error:this.current.error});return emit.call(this);};window.render=()=>renderWorkspace(root,location.origin);window.render();`,resolveDir:process.cwd()},bundle:true,format:'iife',write:false});
 server=createServer(async(req,res)=>{try{
  const path=new URL(req.url,'http://fixture').pathname;
  if(path==='/style.css'){res.setHeader('content-type','text/css');res.end(await readFile('websites/typescript/src/styles.css'));return;}
  if(path==='/app.js'){res.setHeader('content-type','text/javascript');res.end(built.outputFiles[0].text);return;}
  if(path.startsWith('/v1/')){
   if(req.method!=='GET')writes++;
   const response=failInvoices&&path==='/v1/client/invoices'?new Response('{}',{status:503,headers:{'content-type':'application/json'}}):await f.fetch(new Request('http://127.0.0.1'+req.url,{method:req.method,headers:new Headers(req.headers)}));
   if(path==='/v1/governance/workspace')lastWorkspaceStatus=response.status;
   if(hold&&path==='/v1/client/invoices')await new Promise(resolve=>pending.push(resolve));
   if(res.destroyed)return;res.writeHead(response.status,Object.fromEntries(response.headers));res.end(Buffer.from(await response.arrayBuffer()));return;
  }
  res.setHeader('content-type','text/html');res.end('<!doctype html><html><head><link rel="stylesheet" href="/style.css"></head><body><div id="app"></div><script>document.documentElement.lang=new URLSearchParams(location.search).get("locale")||"en"</script><script src="/app.js"></script></body></html>');
 }catch(error){console.error(error);if(!res.headersSent)res.writeHead(500);res.end();}});await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));const origin='http://127.0.0.1:'+server.address().port;
 browser=await chromium.launch(process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH?{executablePath:process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH,args:['--no-sandbox','--disable-dev-shm-usage']}:{});const context=await browser.newContext();await context.addInitScript(token=>{const key='client_invoice_fixture_seeded';if(sessionStorage.getItem(key)!=='1'){sessionStorage.setItem('primecare_session',token);sessionStorage.setItem(key,'1');}},f.tokens.user1);page=await context.newPage();const errors=[];page.on('pageerror',e=>errors.push(e.message));
 const ready=async()=>{await page.waitForFunction(()=>document.querySelectorAll('[data-cy=client-invoice-row]').length>0);};const cy=k=>page.locator('[data-cy="client-invoices-'+k+'"]');
 const auditDir='artifacts/client-invoices-accessibility';await mkdir(auditDir,{recursive:true});
 const audit=async(locale,state)=>{
  if(!await page.evaluate(()=>Boolean(window.axe)))await page.addScriptTag({path:createRequire(import.meta.url).resolve('axe-core/axe.min.js')});
  const result=await page.locator('[data-cy=client-invoice-host]').evaluate(async element=>window.axe.run(element,{runOnly:{type:'tag',values:['wcag2a','wcag2aa','wcag21a','wcag21aa','wcag22aa']}}));
  await writeFile(`${auditDir}/${locale}-${state}.json`,JSON.stringify(result,null,2));await page.screenshot({path:`${auditDir}/${locale}-${state}.png`,fullPage:true});
  console.log('CLIENT_INVOICE_A11Y '+JSON.stringify({locale,state,width:page.viewportSize().width,violations:result.violations.length,incomplete:result.incomplete.map(v=>v.id)}));
  assert.deepEqual(result.violations.map(v=>({id:v.id,targets:v.nodes.map(n=>n.target)})),[],`${locale} ${state} automated accessibility`);
 };
 const held=async()=>{const deadline=Date.now()+5000;while(!pending.length&&Date.now()<deadline)await new Promise(resolve=>setTimeout(resolve,10));assert.equal(pending.length,1,'exactly one owned invoice request');};
 const original=Number((await f.db.query('SELECT COUNT(*)::int AS n FROM invoices')).rows[0].n);
 for(const [locale,width] of [['en',320],['fr',768],['es',1440]]){
  await page.setViewportSize({width,height:900});await page.goto(origin+'/clinic/client-profile?locale='+locale);await ready();assert.equal(await cy('panel').getAttribute('data-control-id'),'823');assert.equal(await page.locator('[data-cy=client-invoice-row]').count(),25);assert.match(await cy('panel').innerText(),/12345678901234567890\.123456790/);assert.ok((await cy('panel').innerText()).includes(metadata.locales[locale].missing));assert.ok(!(await cy('panel').innerText()).includes('PRIVATE-'));assert.equal(await cy('panel').locator('img').count(),0);assert.equal(await cy('panel').locator('th[scope=col]').count(),8);assert.equal(await cy('panel').locator('button').count(),3);assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1),true);checks++;
  await cy('next').click();await page.waitForFunction(()=>document.querySelectorAll('[data-cy=client-invoice-row]').length===2);assert.equal(await cy('next').isDisabled(),true);await cy('previous').click();await ready();assert.equal(await page.locator('[data-cy=client-invoice-row]').count(),25);await page.reload();await ready();checks++;
  await audit(locale,'ready');
  await page.evaluate(()=>{window.__statusNode=document.querySelector('[data-cy=client-invoices-status]');window.__refreshNode=document.querySelector('[data-cy=client-invoices-refresh]');});
  hold=true;await cy('refresh').focus();await page.keyboard.press('Enter');await held();await page.waitForFunction(()=>document.querySelector('[data-cy=client-invoices-status]').textContent.length>0);
  assert.equal(await cy('refresh').evaluate(el=>el===document.activeElement&&el===window.__refreshNode),true,'refresh keeps keyboard focus');
  assert.equal(await cy('status').evaluate(el=>el===window.__statusNode&&el.isConnected&&!el.closest('[aria-busy=true]')),true,'live region persists outside busy panel');
  await page.keyboard.press('Enter');await audit(locale,'loading');assert.equal(pending.length,1,'repeat activation cannot start another read');
  hold=false;pending.splice(0).forEach(fn=>fn());await ready();
  failInvoices=true;await page.keyboard.press('Enter');await page.waitForFunction(message=>document.querySelector('[data-cy=client-invoices-status]')?.textContent===message,metadata.locales[locale].error);
  assert.equal(await cy('refresh').evaluate(el=>el===document.activeElement&&el===window.__refreshNode),true);assert.equal(await cy('status').evaluate(el=>el===window.__statusNode),true);assert.equal(await page.locator('[data-cy=client-invoice-row]').count(),0);await audit(locale,'error');
  failInvoices=false;await page.keyboard.press('Enter');await ready();assert.equal(await cy('status').evaluate(el=>el===window.__statusNode),true);
  await cy('panel').locator('.table-scroll').focus();await page.keyboard.press('ArrowRight');assert.equal(await cy('panel').locator('.table-scroll').evaluate(el=>el===document.activeElement),true);checks++;

 }
 // Exercise failed construction and owner retirement with the actual browser and owned service.
 const construction=await page.evaluate(async()=>{
  const {ClientInvoices,PrimeClientInvoices}=window.__invoiceFixture,token=sessionStorage.getItem('primecare_session');
  const client=new ClientInvoices(location.origin,token,{userId:'user1',role:'guest'},()=>sessionStorage.getItem('primecare_session')===token);
  const root=document.createElement('section'),child=document.createElement('span');child.textContent='caller content';root.append(child);root.setAttribute('data-pc-client-invoices','caller-marker');document.querySelector('#app main').append(root);
  const create=document.createElement.bind(document),failure=Error('fixture button failure');let caught=false;
  try{document.createElement=(tag,...args)=>{if(tag==='button')throw failure;return create(tag,...args);};try{new PrimeClientInvoices(root,client,'en',()=>true);}catch(error){caught=error===failure;}}
  finally{document.createElement=create;}
  const restored=caught&&root.firstChild===child&&root.childNodes.length===1&&root.getAttribute('data-pc-client-invoices')==='caller-marker'&&client.current.status==='idle';
  await client.load();const outcomes=[];
  try{
   for(const error of [Error('fixture table failure'),undefined,null]){
    let same=false;try{document.createElement=(tag,...args)=>{if(tag==='table')throw error;return create(tag,...args);};try{new PrimeClientInvoices(root,client,'en',()=>true);}catch(thrown){same=thrown===error;}}
    finally{document.createElement=create;}
    outcomes.push(same&&root.firstChild===child&&root.getAttribute('data-pc-client-invoices')==='caller-marker'&&client.current.status==='ready');
   }
   const view=new PrimeClientInvoices(root,client,'en',()=>true),reused=root.querySelectorAll('[data-cy=client-invoice-row]').length===25;view.dispose();
   return{restored,outcomes,reused,cleared:root.childNodes.length===0&&client.current.status==='disposed'};
  }finally{client.dispose();root.remove();}
 });
 assert.deepEqual(construction,{restored:true,outcomes:[true,true,true],reused:true,cleared:true});checks++;
 for(const trigger of ['render','refresh']){
  const retired=await page.evaluate(async trigger=>{
   const {ClientInvoices,PrimeClientInvoices}=window.__invoiceFixture,token=sessionStorage.getItem('primecare_session');let reads=0,broken=false;
   const client=new ClientInvoices(location.origin,token,{userId:'user1',role:'guest'},()=>sessionStorage.getItem('primecare_session')===token,async(...args)=>{reads++;return fetch(...args);});
   const root=document.createElement('section');document.querySelector('#app main').append(root);const view=new PrimeClientInvoices(root,client,'en',()=>{if(broken)throw Error('fixture owner failed');return true;});
   try{await client.load();const visible=root.querySelectorAll('[data-cy=client-invoice-row]').length===25,before=reads;broken=true;
    if(trigger==='render')view.render();else root.querySelector('[data-cy=client-invoices-refresh]').click();
    return{visible,cleared:root.childNodes.length===0&&!root.hasAttribute('data-pc-client-invoices'),disposed:client.current.status==='disposed'&&client.current.page===null,noExtraRead:reads===before};
   }finally{view.dispose();client.dispose();root.remove();}
  },trigger);
  assert.deepEqual(retired,{visible:true,cleared:true,disposed:true,noExtraRead:true});checks++;
 }
 // BFCache ownership: hide must clear private content and restore must independently reload it.
 await page.evaluate(()=>dispatchEvent(new PageTransitionEvent('pagehide',{persisted:true})));assert.equal(await page.locator('[data-cy=client-invoice-host]').count(),0);await page.evaluate(()=>dispatchEvent(new PageTransitionEvent('pageshow',{persisted:true})));await ready();checks++;
 // The response is held only after the real database transaction ends. A changed actor cannot receive it.
 hold=true;await cy('refresh').click();await page.waitForFunction(()=>document.querySelector('[data-cy=client-invoices-panel]')?.getAttribute('aria-busy')==='true');const deadline=Date.now()+5000;while(!pending.length&&Date.now()<deadline)await new Promise(resolve=>setTimeout(resolve,10));assert.equal(pending.length,1,'actual database response must be held');await page.evaluate(async token=>{sessionStorage.setItem('primecare_session',token);await window.render();},f.tokens.admin);hold=false;pending.splice(0).forEach(fn=>fn());await page.waitForFunction(()=>!document.querySelector('[data-cy=client-invoice-host]'));assert.equal(lastWorkspaceStatus,200,'changed actor workspace must load normally before route denial');assert.ok(!(await page.locator('#app').innerText()).includes('12345678901234567890'));checks++;
 // A genuine new document must retain the changed actor rather than reseeding the original reader.
 const changedActorRead=page.waitForResponse(response=>new URL(response.url()).pathname==='/v1/governance/workspace'&&response.status()===200);
 await page.reload();await changedActorRead;await page.waitForFunction(()=>!document.querySelector('[data-cy=workspace-loading]'));
 assert.equal(await page.evaluate(()=>sessionStorage.getItem('primecare_session')),f.tokens.admin);assert.equal(await page.locator('[data-cy=client-invoice-host]').count(),0);assert.ok(!(await page.locator('#app').innerText()).includes('12345678901234567890'));checks++;
 assert.equal(writes,0);assert.equal(Number((await f.db.query('SELECT COUNT(*)::int AS n FROM invoices')).rows[0].n),original);assert.deepEqual(errors,[]);console.log(`PASS client invoice host: ${checks} real browser groups; registered EN/FR/ES controls, exact nullable decimals, native SQL counts, pagination/reload, owner/tenant isolation, no payment actions, responsive widths, constructor rollback/caller-client reuse/owner-error cleanup, BFCache and late-actor teardown; zero writes (${f.native?'native PostgreSQL':'PGlite PostgreSQL'}).`);
}catch(error){if(page)console.error('CLIENT_INVOICE_BROWSER_DIAGNOSTICS '+JSON.stringify(await page.evaluate(()=>({url:location.href,text:document.body.innerText.slice(0,4000),states:window.__invoiceStates?.slice(-20)})).catch(()=>({closed:true}))));throw error;}finally{hold=false;pending.splice(0).forEach(fn=>fn());await browser?.close();if(server)await new Promise(resolve=>server.close(resolve));await f.close();}
