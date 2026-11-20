import {test} from 'node:test';import assert from 'node:assert/strict';
import {liveWorkerConfig,verifyUnchangedBindings} from './ems-analytics-live-config.mjs';
import {endpointAnalyticsConfigs} from './prepare-endpoint-analytics-config.mjs';
test('live config preserves service routing, mail restrictions, rate limits and secret exclusion',()=>{
 const settings={bindings:[{name:'SERVICE_NAME',type:'plain_text',text:'governance'},{name:'DB_URL',type:'secret_text',text:'private'},{name:'EMAIL',type:'send_email',allowed_sender_addresses:['test@example.test']},{name:'AUTH',type:'service',service:'primecare-auth-api'},{name:'SOURCE',type:'ratelimit',namespace_id:12,simple:{period:60,limit:5}}]};
 const config=liveWorkerConfig('primecare-governance-api',settings);assert.ok(!JSON.stringify(config).includes('private'));assert.equal(config.services[0].service,'primecare-auth-api');assert.deepEqual(config.send_email[0].allowed_sender_addresses,['test@example.test']);assert.equal(config.ratelimits[0].namespace_id,'12');
 const result=endpointAnalyticsConfigs(liveWorkerConfig('primecare-api-gateway',{bindings:[]}),config,'a'.repeat(32),'code_admin',{},'control-tenant');assert.equal(result.gateway.vars.ENDPOINT_TRAFFIC_ENABLED,'1');assert.equal(result.governance.vars.ENDPOINT_ANALYTICS_READER_TENANT_ID,'control-tenant');
});
test('unrecognized, duplicated and wrong-service metadata refuses deployment',()=>{assert.throws(()=>liveWorkerConfig('primecare-governance-api',{bindings:[]}));for(const bindings of [[{name:'X',type:'unknown'}],[{name:'X',type:'secret_text'},{name:'X',type:'secret_text'}]])assert.throws(()=>liveWorkerConfig('primecare-api-gateway',{bindings}));});
test('readback allows only the explicit EMS bindings and preserves all other metadata',()=>{
 const before={bindings:[{name:'AUTH',type:'service',service:'auth'},{name:'DB_URL',type:'secret_text'}]};
 verifyUnchangedBindings(before,{bindings:[...before.bindings,{name:'ENDPOINT_TRAFFIC_ENABLED',type:'plain_text',text:'1'}]},['ENDPOINT_TRAFFIC_ENABLED']);
 assert.throws(()=>verifyUnchangedBindings(before,{bindings:[{name:'AUTH',type:'service',service:'other'},{name:'DB_URL',type:'secret_text'}]},[]));
 assert.throws(()=>verifyUnchangedBindings(before,{bindings:[]},[]));
});
