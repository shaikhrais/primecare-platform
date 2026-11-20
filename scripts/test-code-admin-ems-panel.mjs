import {test} from 'node:test';import assert from 'node:assert/strict';import {build} from 'esbuild';import {JSDOM} from 'jsdom';import {setImmediate} from 'node:timers/promises';
const compiled=await build({entryPoints:['websites/typescript/src/code-admin-ems.ts'],bundle:true,write:false,platform:'browser',format:'esm'});
const {mountCodeAdminEms,readEmsSummary}=await import('data:text/javascript;base64,'+Buffer.from(compiled.outputFiles[0].text).toString('base64'));
const settle=async()=>{for(let i=0;i<12;i++)await setImmediate();};
const summary={declarations:1,uniqueOperations:1,implementation:{declared_implemented:1},protection:{unverified:1},readiness:{unverified:1},maintenance:{scheduled_maintenance:1}};
test('EMS summary reader rejects inconsistent totals rather than displaying false readiness',()=>{
 assert.equal(readEmsSummary(summary).declarations,1);assert.throws(()=>readEmsSummary({...summary,readiness:{ready:2}}));assert.throws(()=>readEmsSummary({...summary,uniqueOperations:2}));
});
test('Code Admin EMS consumes all six protected APIs and cleans up polling on exit',async()=>{
 const dom=new JSDOM('<main id="ems"></main>',{pretendToBeVisual:true});const original={document:globalThis.document,fetch:globalThis.fetch,setInterval:globalThis.setInterval,clearInterval:globalThis.clearInterval};
 globalThis.document=dom.window.document;const timers=new Map();let sequence=0,denied=false,active=true;let capacityReply={status:'unmeasured',recommendation:'Measure resources before scaling.'};const paths=[];
 globalThis.setInterval=fn=>{timers.set(++sequence,fn);return sequence;};globalThis.clearInterval=id=>timers.delete(id);
 globalThis.fetch=async(url,init)=>{assert.equal(init.headers.authorization,'Bearer fixture');const u=new URL(url);paths.push(u.pathname+u.search);if(denied)return Response.json({error:'forbidden'},{status:403});
  const operation=u.pathname.split('/').at(-1);
  if(operation==='summary')return Response.json(summary);
  if(operation==='services')return Response.json({data:[{service:'test',declaredOperations:1,managementStates:{ready:0,blocked:0,unverified:1,maintenance:0}}],pagination:{total:1,hasMore:false}});
  if(operation==='traffic')return Response.json({status:'not_configured'});
  if(operation==='capacity')return Response.json(capacityReply);
  if(operation==='maintenance'){const offset=Number(u.searchParams.get('offset'));return Response.json({data:offset===0?Array.from({length:100},(_,i)=>({api:'GET /fixture/'+i,management:{maintenance:'scheduled_maintenance',maintenanceWindow:{startsAt:'2026-12-01T10:00:00Z',endsAt:'2026-12-01T11:00:00Z',reason:'Reviewed maintenance'}}})):[{api:'GET /fixture/last',management:{maintenance:'recorded_maintenance'}}],pagination:{total:101,hasMore:offset===0}});}
  return Response.json({data:[{api:'GET /fixture',service:'test',management:{implementation:'declared_implemented',protection:'unverified',readiness:'unverified',maintenance:'unknown'}}],pagination:{total:1,hasMore:false}});
 };
 let stop;
 try{const panel=document.getElementById('ems');stop=mountCodeAdminEms(panel,'https://gateway.test','fixture','en',()=>active);await settle();
  for(const name of ['summary','endpoints','services','traffic','capacity','maintenance'])assert.ok(paths.some(path=>path.startsWith('/v1/governance/platform/ems/'+name)),name);
  assert.ok(panel.hasAttribute('data-pc-ems-dashboard'));
  assert.equal(panel.querySelectorAll('input[type=file]').length,0,'EMS uses authenticated APIs only');
  assert.doesNotMatch(panel.textContent,/Open traffic report|Open capacity benchmark/);
  const details=panel.querySelector('[data-cy=ems-detailed-columns]'),inventoryTable=panel.querySelector('[data-cy=ems-inventory] table');
  assert.equal(inventoryTable.dataset.emsDetailed,'false');details.checked=true;details.dispatchEvent(new dom.window.Event('change'));assert.equal(inventoryTable.dataset.emsDetailed,'true');
  assert.ok(panel.querySelector('.ems-capacity-card'));assert.equal(panel.querySelector('.ems-maintenance-panel').open,false);

  assert.match(panel.textContent,/Verified ready: 0/);assert.match(panel.textContent,/Full-system capacity is unmeasured/);assert.match(panel.textContent,/Live traffic reporting is not configured/);
  const next=panel.querySelector('[data-cy=ems-maintenance-next]');assert.equal(next.disabled,false);next.click();await settle();assert.ok(paths.some(path=>path.includes('maintenance?limit=100&offset=100')));assert.equal(next.disabled,true);assert.match(panel.querySelector('[data-cy=ems-maintenance]').textContent,/\/fixture\/last/);
  const now=Date.now();
  capacityReply={status:'reference',servingReleaseMatches:false,benchmark:{releaseId:'old-release',environment:'staging',workload:'fixture reads',evidenceUrl:'https://example.com/evidence',measuredAt:new Date(now-60000).toISOString(),expiresAt:new Date(now+3600000).toISOString(),sustainableRequestsPerSecond:100,p95LatencyMs:50,errorRate:0,targetP95LatencyMs:100,targetErrorRate:0.01,bottleneck:'unknown'}};
  for(const match of [false,undefined,true]){
   capacityReply.servingReleaseMatches=match;
   panel.querySelector('[data-cy=ems-refresh]').click();await settle();
   const capacityText=panel.querySelector('[data-cy=ems-capacity]').textContent;
   assert.match(capacityText,/Reference workload benchmark/);
   assert.match(capacityText,/full-system production capacity is not verified/);
   if(match===true)assert.doesNotMatch(capacityText,/Serving release does not match/);
   else assert.match(capacityText,/Serving release does not match this benchmark or is unknown/);
  }
  denied=true;panel.querySelector('[data-cy=ems-refresh]').click();await settle();assert.match(panel.querySelector('[data-cy=ems-summary]').textContent,/EMS access denied/);assert.doesNotMatch(panel.querySelector('[data-cy=ems-summary]').textContent,/Verified ready/);
  active=false;stop();stop=undefined;assert.equal(timers.size,0);
 }finally{stop?.();Object.assign(globalThis,original);dom.window.close();}
});
