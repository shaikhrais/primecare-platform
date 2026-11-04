import {build} from 'esbuild';
import {chromium} from 'playwright';
import {createServer} from 'node:http';
import assert from 'node:assert/strict';
const js=(await build({stdin:{resolveDir:process.cwd(),contents:`
import {TenantThemeMigrationReview} from './packages/primecare_ui/web/advanced-theme-tenant-review';
import {PreferenceSyncClient} from './packages/shared/src/preference-sync/client';
import {preferenceHttpTransport,preferenceStorageCache} from './packages/shared/src/preference-sync/transport';
void (async()=>{\nconst scope={tenantId:'tenant1',userId:'user1',role:'tenant_admin',dataset:'live'};
const key='primecare-themes:v1:'+encodeURIComponent(JSON.stringify(['tenant-dashboard','live','tenant1','user1','tenant_admin']));
if(!localStorage.getItem(key))localStorage.setItem(key,JSON.stringify({version:1,active:null,items:[]}));
const client=new PreferenceSyncClient({scope,kind:'theme',resource:'advanced-v2',policy:{panelIds:[],screenIds:[]}},preferenceHttpTransport(location.origin,'a'.repeat(43)),preferenceStorageCache(localStorage));
await client.load();const review=new TenantThemeMigrationReview(localStorage,client);
const status=document.querySelector('#status');document.querySelector('#review').onclick=()=>{const p=review.prepare();status.textContent='review '+p.unmappedFields.join(',');};
document.querySelector('#save').onclick=async()=>{const r=await review.confirm();status.textContent=r.status+' '+r.revision;};\n})();
`},bundle:true,write:false,format:'iife'})).outputFiles[0].text;
let snapshot={version:1,scope:{tenantId:'tenant1',userId:'user1',role:'tenant_admin',dataset:'live'},kind:'theme',resource:'advanced-v2',revision:0,document:null},writes=0;
const server=createServer(async(req,res)=>{if(req.url==='/app.js'){res.setHeader('content-type','text/javascript');return res.end(js);}if(req.url==='/v1/user/preferences'){const chunks=[];for await(const c of req)chunks.push(c);const body=JSON.parse(Buffer.concat(chunks));if(body.action==='write'){writes++;assert.equal(body.revision,snapshot.revision);snapshot={...snapshot,revision:1,document:body.document};}res.setHeader('content-type','application/json');return res.end(JSON.stringify(snapshot));}res.setHeader('content-type','text/html');res.end('<button id="review">Review</button><button id="save">Save</button><output id="status"></output><script src="/app.js"></script>');});
await new Promise(r=>server.listen(0,'127.0.0.1',r));let browser;
try{
 browser=await chromium.launch({headless:true,args:['--no-sandbox']});
 const page=await browser.newPage();const errors=[];page.on('pageerror',e=>errors.push(e.message));
 await page.goto('http://127.0.0.1:'+server.address().port);
 await page.locator('#review').click();await page.waitForFunction(()=>document.querySelector('#status').textContent.startsWith('review'));
 assert.equal(writes,0);
 await page.locator('#save').click();await page.waitForFunction(()=>document.querySelector('#status').textContent==='clean 1');
 assert.equal(writes,1);assert.equal(snapshot.document.version,2);
 await page.reload();assert.equal(snapshot.revision,1);assert.deepEqual(errors,[]);
 console.log('Isolated browser review and save passed using the real preference transport.');
}finally{await browser?.close();await new Promise(r=>server.close(r));}
