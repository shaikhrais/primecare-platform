import {test} from 'node:test';
import assert from 'node:assert/strict';
import {createServer} from 'node:http';
import {readFile,mkdir} from 'node:fs/promises';
import {resolve,extname} from 'node:path';
import {chromium} from 'playwright';

const portals=Object.keys(JSON.parse(await readFile('websites/typescript/projects.json','utf8')));
const root=resolve('websites/typescript/dist');
const server=createServer(async(req,res)=>{
 const url=new URL(req.url,'http://localhost');
 const portal=portals.find(p=>p===req.headers['x-review-portal']);
 if(!portal){res.writeHead(404).end();return;}
 const base=resolve(root,portal),relative=url.pathname;
 const path=resolve(base,'.'+relative);
 if(!path.startsWith(base+'/')){res.writeHead(403).end();return;}
 try{res.setHeader('content-type',({'.json':'application/json','.js':'text/javascript','.css':'text/css','.png':'image/png','.webp':'image/webp'})[extname(path)]||'application/octet-stream');res.end(await readFile(path));}
 catch{res.setHeader('content-type','text/html');const lang=(req.headers['accept-language']||'en').slice(0,2);res.end((await readFile(base+'/index.html','utf8')).replace('lang="en"',`lang="${['en','fr','es'].includes(lang)?lang:'en'}"`));}
});
// Test-only request header chooses the built portal; application paths remain unchanged.
await new Promise(r=>server.listen(0,'127.0.0.1',r));
const origin='http://127.0.0.1:'+server.address().port;
const browser=await chromium.launch({executablePath:process.env.GROWTH_BROWSER_EXECUTABLE||undefined,headless:true,args:['--no-sandbox']});
await mkdir('test-results/media',{recursive:true});
try {
 for(const [locale,width] of [['en',320],['en',390],['en',1440],['en',3840],['fr',390],['fr',1440],['es',390],['es',1440]]) {
  await test(`inherited entry media ${locale} ${width}`,async()=>{
   const context=await browser.newContext({viewport:{width,height:width>1000?1000:844},locale,reducedMotion:'reduce',extraHTTPHeaders:{'x-review-portal':'primecare-governance'}});
   const page=await context.newPage();const errors=[];page.on('pageerror',e=>errors.push(e.message));
   await page.route('**/*',route=>new URL(route.request().url()).origin!==origin?route.abort():route.continue());
   await page.goto(origin+'/login?enable-semantics=true');
   const image=page.locator('[data-cy=media-care-image]');await image.waitFor();
   await image.evaluate(async img=>{await img.decode();});
   assert.ok((await image.evaluate(img=>img.currentSrc)).endsWith('.webp'));
   assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth),false);
   const form=page.locator('[data-cy=login-form]');const bounds=await form.boundingBox();
   assert.ok(bounds.x>=0&&bounds.x+bounds.width<=width);
   if(width<1025)assert.ok(Math.abs(bounds.x-(width-bounds.x-bounds.width))<2,'equal mobile margins');
   await page.locator('[data-cy=login-email]').focus();await page.keyboard.type('visual-review@example.test');
   await page.keyboard.press('Tab');assert.equal(await page.locator('[data-cy=login-password]').evaluate(e=>e===document.activeElement),true);
   await page.keyboard.press('Tab');assert.equal(await page.locator('[data-cy=login-submit]').evaluate(e=>e===document.activeElement),true);
   const labels={en:'People at the heart',fr:'L’humain au cœur',es:'Las personas'};
   assert.ok((await page.locator('[data-cy=media-entry]').innerText()).includes(labels[locale]));
   await page.locator('[data-cy=login-email]').fill('');
   await page.locator('[data-cy=login-email]').evaluate(e=>e.blur());
   await page.screenshot({path:`test-results/media/login-${locale}-${width}.png`,fullPage:true});
   // Image failure must not hide sign-in controls or remove their accessible text.
   await page.locator('[data-cy=media-entry] picture').evaluate(e=>e.remove());
   assert.ok(await page.locator('[data-cy=login-submit]').isVisible());
   assert.ok((await page.locator('[data-cy=login-submit]').innerText()).trim());
   assert.deepEqual(errors,[]);await context.close();
  });
 }
 for(const portal of portals)await test(`inherited media available in ${portal}`,async()=>{
  const context=await browser.newContext({viewport:{width:1440,height:1000},extraHTTPHeaders:{'x-review-portal':portal}});const page=await context.newPage();
  await page.route('**/*',route=>new URL(route.request().url()).origin!==origin?route.abort():route.continue());
  await page.goto(origin+'/login?enable-semantics=true');
  await page.locator('[data-cy=media-care-image]').evaluate(async img=>{await img.decode();});
  assert.ok(await page.locator('[data-cy=login-submit]').isVisible());await context.close();
 });
} finally {await browser.close();await new Promise(r=>server.close(r));}
