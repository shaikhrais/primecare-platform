import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {createServer} from 'node:http';
import {chromium} from 'playwright';
const built=await build({stdin:{contents:"export {renderShell,bindShell} from './packages/primecare_ui/web/shell';",resolveDir:process.cwd()},bundle:true,write:false,format:'iife',globalName:'Shell'});
const html='<!doctype html><html><body><div id="app"></div><script>'+built.outputFiles[0].text+'</script></body></html>';
const server=createServer((req,res)=>{if(req.url!=='/'){res.statusCode=404;res.end();return;}res.setHeader('content-type','text/html');res.end(html);});
await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
let browser;
try{
 browser=await chromium.launch({headless:true});const page=await browser.newPage(),errors=[];page.on('pageerror',error=>errors.push(error.message));
 await page.goto('http://127.0.0.1:'+server.address().port);
 await page.evaluate(()=>{
  const root=document.getElementById('app');
  Shell.renderShell(root,{home:'/',role:'Fixture',navigation:'<a href="#page">Page</a>',controls:'<button data-cy="platform-account-link">Account</button><button data-cy="platform-refresh">Refresh</button><button data-cy="platform-logout">Sign out</button>',content:'<input id="draft" value="Unfinished draft">'});
  window.bindFixture=()=>Shell.bindShell(root,'Fixture','en','actor',()=>[]);window.fixtureClicks=0;
  root.querySelector('[data-cy=platform-logout]').addEventListener('click',()=>fixtureClicks++);
  root.dir='rtl';bindFixture();
 });
 const logout=page.locator('[data-cy=platform-logout]');assert.equal(await logout.locator('svg g[transform*="scale(-1 1)"]').count(),1);assert.equal(await page.getByRole('button',{name:'Sign out',exact:true}).count(),1);assert.equal(await logout.textContent(),'Sign out');
 await logout.focus();await page.evaluate(()=>{document.getElementById('app').dir='ltr';bindFixture();});
 assert.equal(await logout.locator('svg g[transform*="scale(-1 1)"]').count(),0);assert.equal(await logout.evaluate(el=>el===document.activeElement),true);await logout.click();assert.equal(await page.evaluate(()=>fixtureClicks),1);
 await page.evaluate(()=>{document.getElementById('app').dir='rtl';bindFixture();});assert.equal(await logout.locator('svg g[transform*="scale(-1 1)"]').count(),1);assert.equal(await logout.locator('svg').count(),1);assert.equal(await page.locator('#draft').inputValue(),'Unfinished draft');assert.deepEqual(errors,[]);
 console.log(JSON.stringify({actualShell:true,resolvedDirection:true,englishRtl:true,rebindFocusAndCallbacks:true,draftRetained:true,productionHostAcceptance:false}));
}finally{await browser?.close();await new Promise(resolve=>server.close(resolve));}
