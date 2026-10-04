import {chromium} from 'playwright';
import AxeBuilder from '@axe-core/playwright';
import {createServer} from 'node:http';
import {readFile,mkdir,writeFile} from 'node:fs/promises';
import {join,resolve} from 'node:path';
import assert from 'node:assert/strict';
const registry=JSON.parse(await readFile('cloudflare/workers/src/workspace-registry.json','utf8'));
const base=resolve('websites/typescript/dist/primecare-corporate');
const server=createServer(async(req,res)=>{
 try{const path=new URL(req.url,'http://localhost').pathname;const relative=path==='/portal.json'?'portal.json':path.startsWith('/assets/')?path.slice(1):'index.html';
  res.setHeader('content-type',relative.endsWith('.js')?'text/javascript':relative.endsWith('.css')?'text/css':relative.endsWith('.json')?'application/json':'text/html');res.end(await readFile(join(base,relative)));
 }catch{res.writeHead(404);res.end();}
});
await new Promise(r=>server.listen(4173,'127.0.0.1',r));const browser=await chromium.launch();
const output='artifacts/workspace-browser';await mkdir(output,{recursive:true});
try {
 const page=await browser.newPage({viewport:{width:1440,height:1100}});
 await page.addInitScript(()=>sessionStorage.setItem('primecare_session','browser-fixture'));
 const screens=registry.screens.filter(s=>s.renderer!=='account'&&s.grants.some(g=>g.role==='ceo'&&g.view));
 await page.route('**/v1/governance/workspace',async route=>{
  if(route.request().method()==='OPTIONS'){await route.fulfill({status:204,headers:{'access-control-allow-origin':'http://127.0.0.1:4173','access-control-allow-methods':'GET','access-control-allow-headers':'Authorization'}});return;}
  assert.equal(route.request().headers().authorization,'Bearer browser-fixture');
  await route.fulfill({headers:{'access-control-allow-origin':'http://127.0.0.1:4173'},json:{identity:{userId:'synthetic-browser-fixture',role:'ceo'},landing:registry.landings.ceo,screens,inventory:registry.screens,resources:registry.resources,
    overview:{activeAccounts:3,activeSessions:2,accountRoles:[{role:'ceo',count:1},{role:'rmt',count:2}],activity:[],metrics:[],scope:'organization'}}});
 });
 await page.goto('http://127.0.0.1:4173/?enable-semantics=true');
 await page.locator('[data-cy="screen-ceo_dashboard"]').waitFor();
 assert.ok(!(await page.locator('body').textContent()).includes('under construction'));
 for(const screen of screens){await page.locator(`[data-cy="sidebar-item-${screen.code}"]`).first().click();await page.locator(`[data-cy="screen-${screen.code}"]`).waitFor();}
 await page.locator('[data-cy="sidebar-item-ceo_dashboard"]').first().click();
 await page.locator('[data-cy="workspace-search"]').fill('ceo');
 const matches=registry.screens.filter(s=>`${s.name} ${s.role} ${s.appCode} ${s.route}`.toLowerCase().includes('ceo'));
 assert.ok((await page.locator('[data-cy="inventory-count"]').textContent()).startsWith(matches.length+' '));
 await page.locator('[data-cy="workspace-search"]').fill('');
 await page.locator('[data-cy="workspace-search"]').focus();
 assert.equal(await page.evaluate(()=>document.activeElement?.getAttribute('data-cy')),'workspace-search');
 const accessibility=await new AxeBuilder({page}).withTags(['wcag2a','wcag2aa','wcag21aa','wcag22aa']).analyze();
 await writeFile(join(output,'accessibility.json'),JSON.stringify({fixture:'synthetic CEO account; no production user data',violations:accessibility.violations},null,2));
 assert.equal(accessibility.violations.length,0,accessibility.violations.map(v=>v.id+': '+v.nodes.map(n=>n.target.join(' ')).join(',')).join('\n'));
 await page.screenshot({path:join(output,'ceo-dashboard.png'),fullPage:true});
 await page.setViewportSize({width:390,height:844});await page.locator('[data-cy="sidebar-toggle"]').click();
 assert.ok(await page.locator('[data-cy="app-sidebar"]').isVisible());
 await page.screenshot({path:join(output,'ceo-dashboard-mobile.png'),fullPage:true});
 console.log(`Chromium dashboard navigation verified ${screens.length} authorized pages; keyboard focus and WCAG automated checks passed. Fixture data only.`);
}finally{await browser.close();await new Promise(r=>server.close(r));}
