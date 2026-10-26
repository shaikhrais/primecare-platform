import {test} from 'node:test';import assert from 'node:assert/strict';
import {readFileSync,mkdtempSync,rmSync} from 'node:fs';import {execFileSync} from 'node:child_process';import {tmpdir} from 'node:os';import {join} from 'node:path';
import {nativeContactGatewayServices,assertOwnedNativeContactTarget} from './voice-contact-deployment-plan.mjs';
const config=JSON.parse(readFileSync('cloudflare/workers/src/business-tasks/voice-contact-deployment.json'));
const names=['auth','client','provider','visit','notes','billing','scheduling','notification','verification','compliance','governance','franchise-reporting'];
const current=()=>({bindings:names.map(s=>({name:s.replaceAll('-','_').toUpperCase(),type:'service',service:'primecare-'+s+'-api',environment:'production'}))});
test('dedicated native service is added exactly once while all twelve existing targets remain identical',()=>{
 const before=current(),snapshot=structuredClone(before),result=nativeContactGatewayServices(before,config);assert.deepEqual(before,snapshot);assert.equal(result.length,13);assert.deepEqual(result.slice(0,12),before.bindings.map(b=>({binding:b.name,service:b.service})));
 before.bindings.push({name:config.gatewayBinding,type:'service',service:config.workerName});assert.deepEqual(nativeContactGatewayServices(before,config),result);
});
test('unknown credentials, service targets, environment, entrypoint or duplicate bindings cannot be overwritten',()=>{
 for(const alter of [b=>b.push({name:'PRIVATE_SECRET',type:'secret_text'}),b=>b[0].service='other-api',b=>b[0].environment='staging',b=>b[0].entrypoint='Other',b=>b.push(b[0]),b=>b.pop(),b=>b.push({name:config.gatewayBinding,type:'service',service:'other-api'})]){const before=current();alter(before.bindings);assert.throws(()=>nativeContactGatewayServices(before,config),/preserved/);}
});
test('new native target is permitted, owned target retained, and unknown or conflicting target preserved',()=>{
 assertOwnedNativeContactTarget(null,config);const owned={bindings:[{name:'VOICE_CONTACT_OWNER',text:config.owner},{name:'DB_URL',type:'secret_text'}]};assertOwnedNativeContactTarget(owned,config);
 for(const bad of [{bindings:[]},{bindings:[...owned.bindings,{name:'UNRELATED',type:'secret_text'}]},{bindings:[...owned.bindings,owned.bindings[0]]}])assert.throws(()=>assertOwnedNativeContactTarget(bad,config),/preserved/);
});
test('future full-worker configuration retains the dedicated native gateway binding',()=>{
 const dir=mkdtempSync(join(tmpdir(),'contact-gateway-plan-'));try{execFileSync(process.execPath,['scripts/generate-cloudflare-worker-config.mjs',dir],{stdio:'pipe'});const generated=JSON.parse(readFileSync(join(dir,'gateway.jsonc')));assert.equal(generated.services.filter(b=>b.binding===config.gatewayBinding&&b.service===config.workerName).length,1);assert.equal(generated.services.length,15);}finally{rmSync(dir,{recursive:true,force:true});}
});

test('existing encrypted gateway JWT binding is preserved by platform retention without reading or recreating its value',()=>{
 const before=current();before.bindings.push({name:'JWT_SECRET',type:'secret_text'});const snapshot=structuredClone(before);assert.equal(nativeContactGatewayServices(before,config).length,13);assert.deepEqual(before,snapshot);assert.equal('text' in before.bindings.at(-1),false);before.bindings.push({name:'JWT_SECRET',type:'secret_text'});assert.throws(()=>nativeContactGatewayServices(before,config),/preserved/);
});
