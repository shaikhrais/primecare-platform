import {chromium} from 'playwright';
import assert from 'node:assert/strict';
import {createServer} from 'node:http';
import {readFileSync,mkdirSync} from 'node:fs';
const bundle=readFileSync(process.env.SESSION_BUNDLE);
const server=createServer((req,res)=>{
 if(req.url.startsWith('/account.js')){res.setHeader('content-type','application/javascript');res.end(bundle);return;}
 if(req.url.startsWith('/login')){res.end('<main data-cy="login-destination"></main>');return;}
 res.setHeader('content-type','text/html');res.end('<!doctype html><html><body><main id="account"></main><script src="/account.js"></script></body></html>');
});
await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
const origin='http://127.0.0.1:'+server.address().port;
mkdirSync('test-results/account-sessions',{recursive:true});
const browser=await chromium.launch();
try{
 for(const [locale,width] of [['en',320],['fr',768],['es',1440]]){
  const page=await browser.newPage({viewport:{width,height:900}});
  const errors=[];page.on('pageerror',e=>errors.push(e.message));
  let gets=0,deletes=0,fail=true;
  await page.route('**/v1/user/sessions**',async route=>{
   const req=route.request();assert.equal(req.headers().authorization,'Bearer synthetic-session');
   if(req.method()==='DELETE'){deletes++;assert.equal(req.postData(),null);await route.fulfill({status:fail?503:200,json:fail?{error:'unavailable'}:{status:'signed_out_all_devices',revokedSessions:26}});return;}
   gets++;const offset=Number(new URL(req.url()).searchParams.get('offset'));
   assert([0,25].includes(offset));
   await route.fulfill({json:{sessions:Array.from({length:offset===0?25:1},(_,n)=>({created_at:'2026-10-20T10:00:00.000Z',expires_at:'2026-10-21T10:00:00.000Z',current:offset===0&&n===0})),pagination:{limit:25,offset,total:26,hasMore:offset===0}}});
  });
  await page.goto(origin+'/success?locale='+locale+'&enable-semantics=true');
  await page.evaluate(({locale,origin})=>{
   document.documentElement.lang=locale;sessionStorage.setItem('primecare_session','synthetic-session');
   const root=document.querySelector('#account');root.innerHTML=Sessions.sessionsMarkup();Sessions.bindSessions(root,origin,'synthetic-session');
  },{locale,origin});
  const by=id=>page.locator('[data-cy="'+id+'"]');
  await by('own-sessions-table-row-24').waitFor();
  assert.equal(await by('own-sessions-table').getAttribute('aria-label'),({'en':'Active sessions','fr':'Sessions actives','es':'Sesiones activas'})[locale]);
  assert.equal(await by('own-sessions-previous').isDisabled(),true);
  await by('own-sessions-next').click();await by('own-sessions-table-row-1').waitFor({state:'detached'});
  assert.equal(await by('own-sessions-next').isDisabled(),true);
  await by('own-sessions-previous').click();await by('own-sessions-table-row-24').waitFor();
  await by('own-sessions-revoke').click();
  assert.equal(await by('own-sessions-confirmation').isVisible(),true);
  assert.equal(await by('own-sessions-confirm-revoke').evaluate(el=>el===document.activeElement),true);
  await by('own-sessions-cancel-revoke').click();
  assert.equal(deletes,0);assert.equal(await by('own-sessions-confirmation').isHidden(),true);
  assert.equal(await by('own-sessions-revoke').evaluate(el=>el===document.activeElement),true);
  await by('own-sessions-revoke').click();await by('own-sessions-confirm-revoke').click();
  await page.waitForFunction(()=>document.querySelector('[data-cy="own-sessions-panel"]').getAttribute('aria-busy')==='false');
  assert.equal(deletes,1);assert.equal(await page.evaluate(()=>sessionStorage.getItem('primecare_session')),'synthetic-session');
  assert.equal(await by('own-sessions-status').innerText(),({'en':'Sign-out could not be confirmed. Retry or sign in again.','fr':'La déconnexion n’a pas pu être confirmée. Réessayez ou reconnectez-vous.','es':'No se pudo confirmar el cierre. Reinténtalo o inicia sesión de nuevo.'})[locale]);
  await page.screenshot({path:'test-results/account-sessions/'+locale+'-'+width+'.png',fullPage:true});
  fail=false;await by('own-sessions-confirm-revoke').click();
  await page.waitForURL('**/login?'+(locale==='en'?'':'locale='+locale+'&')+'enable-semantics=true');
  assert.equal(await page.evaluate(()=>sessionStorage.getItem('primecare_session')),null);
  assert.equal(deletes,2);assert.equal(gets,3);assert.deepEqual(errors,[]);
  console.log('PASS isolated browser '+locale+' '+width+': pagination, confirmation, focus, cancellation, localized failure, retry and sign-out navigation');
  await page.close();
 }
}finally{await browser.close();await new Promise(resolve=>server.close(resolve));}
