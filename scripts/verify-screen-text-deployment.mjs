import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
const defaults=JSON.parse(await readFile('cloudflare/workers/src/screen-text-defaults.json','utf8'));
const gateway='https://primecare-api-gateway.itpro-mohammed.workers.dev';
async function get(url){
 for(let attempt=0;attempt<10;attempt++){
  try{const response=await fetch(url,{headers:{'cache-control':'no-cache'},signal:AbortSignal.timeout(15000)});assert.equal(response.status,200);return await response.text();}
  catch(error){if(attempt===9)throw error;await new Promise(resolve=>setTimeout(resolve,5000));}
 }
}
const manifest=JSON.parse(await get(gateway+'/v1/governance/screen-text'));
assert.ok(Array.isArray(manifest.screens));
for(const screen of Object.keys(defaults)){
 assert.ok(manifest.screens.some(row=>row.id===screen));
 const catalog=JSON.parse(await get(gateway+'/v1/governance/screen-text/'+screen));
 assert.equal(catalog.screen,screen);assert.ok(Number.isSafeInteger(catalog.version)&&catalog.version>=0);
 for(const language of ['en','fr','es']){
  assert.deepEqual(Object.keys(catalog.locales[language]).sort(),Object.keys(defaults[screen][language]).sort());
  assert.ok(Object.values(catalog.locales[language]).every(text=>typeof text==='string'&&text.trim().length>0));
 }
 assert.equal(catalog.actor_id,undefined);assert.equal(catalog.history,undefined);
}
const projects=JSON.parse(await readFile('websites/typescript/projects.json','utf8'));
for(const project of Object.keys(projects)){
 const js=await get(`https://${project}.pages.dev/assets/app.js`);
 assert.ok(js.includes('primecare.screen-text.v1.'),`${project}: persistent screen-text cache missing`);
}
console.log(`Verified ${Object.keys(defaults).length} public text catalogs and ${Object.keys(projects).length} website cache bundles; no production data writes`);
