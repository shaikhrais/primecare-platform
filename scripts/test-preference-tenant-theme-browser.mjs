import assert from 'node:assert/strict';
import {createServer} from 'node:http';
import {build} from 'esbuild';
import {chromium} from 'playwright';
import {preferenceFixture} from './preference-sync-fixture.mjs';

const fixture=await preferenceFixture();
const bundle=await build({stdin:{resolveDir:process.cwd(),contents:`
export {mountTenantThemePreference} from './websites/typescript/src/tenant-dashboard/theme-preference-host';
export {PreferenceSyncClient} from './packages/shared/src/preference-sync/client';
export {preferenceHttpTransport,preferenceStorageCache} from './packages/shared/src/preference-sync/transport';
`},bundle:true,platform:'browser',format:'iife',globalName:'Migration',write:false});
const server=createServer(async(req,res)=>{
 try {
  if(req.url==='/client.js'){res.setHeader('content-type','text/javascript');return res.end(bundle.outputFiles[0].text);}
  if(req.url==='/v1/user/preferences'){
   const chunks=[];for await(const part of req)chunks.push(part);
   const response=await fixture.fetch(new Request('http://127.0.0.1'+req.url,{method:req.method,headers:req.headers,body:Buffer.concat(chunks)}));
   res.writeHead(response.status,Object.fromEntries(response.headers));return res.end(Buffer.from(await response.arrayBuffer()));
  }
  res.setHeader('content-type','text/html');res.end('<main id="root"><button data-cy="appearance-open">Appearance</button><section data-cy="theme-center"></section></main><script src="/client.js"></script>');
 }catch{res.writeHead(500);res.end();}
});
let browser;
try{
 assert.equal(fixture.native,true,'This rehearsal requires isolated PostgreSQL');
 await fixture.db.query('INSERT INTO '+fixture.table('api_permissions')+" VALUES(80124,777,72,1,'authenticated_self_preferences')");
 await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
 browser=await chromium.launch({headless:true,args:['--no-sandbox']});
 const page=await browser.newPage();
 await page.goto('http://127.0.0.1:'+server.address().port);
 const scope={tenantId:'tenant1',userId:'admin',role:'tenant_admin',dataset:'live'};
 const key='primecare-themes:v1:'+encodeURIComponent(JSON.stringify(['tenant-dashboard','live','tenant1','admin','tenant_admin']));
 const source=JSON.stringify({version:1,active:null,items:[]});
 const mount=async()=>page.evaluate(async({scope,key,source,token})=>{
  if(localStorage.getItem(key)===null)localStorage.setItem(key,source);
  window.disposeHost=Migration.mountTenantThemePreference(document.querySelector('#root'),{gateway:location.origin,token,locale:'en',tenantId:scope.tenantId,userId:scope.userId,dataset:scope.dataset,isCurrent:()=>true});
 },{scope,key,source,token:fixture.tokens.admin});
 // Hold the real PostgreSQL-backed read while the original owner is revoked.
 let held,releaseHeld;const holding=new Promise(resolve=>held=resolve),release=new Promise(resolve=>releaseHeld=resolve);
 await page.route('**/v1/user/preferences',async route=>{const response=await route.fetch();held();await release;await route.fulfill({response});},{times:1});
 await page.evaluate(({scope,key,source,token})=>{
  localStorage.setItem(key,source);window.ownerActive=true;window.resumeChecks=0;
  window.themeHostOptions={gateway:location.origin,token,locale:'en',tenantId:scope.tenantId,userId:scope.userId,dataset:scope.dataset,isCurrent:()=>window.ownerActive,whenActive:async()=>{window.resumeChecks++;return true;}};
  window.disposeHost=Migration.mountTenantThemePreference(document.querySelector('#root'),window.themeHostOptions);
 },{scope,key,source,token:fixture.tokens.admin});
 await page.locator('[data-cy=appearance-open]').click();await holding;
 await page.evaluate(()=>{window.ownerActive=false;window.themeHostOptions.isCurrent=()=>true;});releaseHeld();
 await page.waitForFunction(()=>window.resumeChecks===1);
 await page.evaluate(()=>new Promise(resolve=>requestAnimationFrame(()=>requestAnimationFrame(resolve))));
 assert.equal(await page.locator('[data-cy=theme-migration-review]').count(),0);
 await page.evaluate(()=>window.disposeHost());await page.reload();
 await mount();
 await page.locator('[data-cy=appearance-open]').click();
 await page.locator('[data-cy=theme-migration-review]').waitFor();
 await page.locator('[data-cy=theme-migration-review]').click();
 assert.equal(await page.locator('[data-cy=theme-migration-status]').textContent(),'Review ready');
 assert.equal(Number((await fixture.db.query('SELECT count(*) AS n FROM account_preference_documents')).rows[0].n),0);
 await page.route('**/v1/user/preferences',async route=>{await route.fetch();await route.abort();},{times:1});
 await page.locator('[data-cy=theme-migration-save]').click();
 await page.waitForFunction(()=>document.querySelector('[data-cy=theme-migration-status]').textContent.includes('pending'));
 await page.reload();
 await mount();
 await page.locator('[data-cy=appearance-open]').click();
 await page.locator('[data-cy=theme-migration-retry]').waitFor();
 assert.equal(await page.locator('[data-cy=theme-migration-retry]').isVisible(),true);
 assert.equal(await page.locator('[data-cy=theme-migration-review]').isDisabled(),true);
 await page.locator('[data-cy=theme-migration-retry]').click();
 await page.waitForFunction(()=>document.querySelector('[data-cy=theme-migration-status]').textContent==='Saved');
 const rows=(await fixture.db.query('SELECT tenant_id,user_id,actor_role,dataset,revision,document FROM account_preference_documents')).rows;
 assert.equal(rows.length,1);assert.deepEqual(rows[0].document,{version:2,active:null,items:[]});
 assert.equal(Number(rows[0].revision),1);assert.equal(rows[0].tenant_id,'tenant1');assert.equal(rows[0].user_id,'admin');
 const audits=(await fixture.db.query("SELECT action,revision FROM account_preference_audit WHERE user_id='admin'")).rows;
 assert.deepEqual(audits.map(row=>({action:row.action,revision:Number(row.revision)})),[{action:'write',revision:1}]);
 const denied=await fixture.fetch(new Request('https://fixture.test/v1/user/preferences',{
  method:'POST',headers:{authorization:'Bearer '+fixture.tokens.user2,'content-type':'application/json'},
  body:JSON.stringify({version:1,action:'read',expectedScope:scope,dataset:'live',kind:'theme',resource:'advanced-v2'})
 }));
 assert.equal(denied.status,409);
 assert.equal(await page.evaluate(k=>localStorage.getItem(k),key),source);
 await page.reload();
 const reloaded=await page.evaluate(async({scope,token})=>{
  const client=new Migration.PreferenceSyncClient({scope,kind:'theme',resource:'advanced-v2',policy:{panelIds:[],screenIds:[]}},Migration.preferenceHttpTransport(location.origin,token),Migration.preferenceStorageCache(localStorage));
  await client.load();return client.current;
 },{scope,token:fixture.tokens.admin});
 assert.equal(reloaded.base.revision,1);assert.deepEqual(reloaded.draft,{version:2,active:null,items:[]});
 console.log('Tenant theme review, gateway, PostgreSQL, audit and reload passed.');
}finally{await browser?.close();if(server.listening)await new Promise(resolve=>server.close(resolve));await fixture.close();}
