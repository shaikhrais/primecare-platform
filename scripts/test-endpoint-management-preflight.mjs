import assert from 'node:assert/strict';
import {test} from 'node:test';
import {assessEndpointManagementSettings,inspectEndpointManagement} from './endpoint-management-preflight.mjs';
const gateway={bindings:[{name:'ENDPOINT_TRAFFIC_ENABLED',type:'plain_text',text:'1'},{name:'ENDPOINT_ANALYTICS',type:'analytics_engine',dataset:'primecare_endpoint_traffic_v1'}]};
const governance={bindings:[{name:'ENDPOINT_ANALYTICS_ACCOUNT_ID',type:'plain_text',text:'a'.repeat(32)},{name:'ENDPOINT_ANALYTICS_READER_ROLE',type:'plain_text',text:'governance'},{name:'ENDPOINT_ANALYTICS_READER_TENANT_ID',type:'plain_text',text:'private-tenant'},{name:'ENDPOINT_ANALYTICS_READ_TOKEN',type:'secret_text'}]};
test('preflight identifies exact gaps without exposing binding values',()=>{
 assert.equal(assessEndpointManagementSettings(gateway,governance).configured,true);
 const result=assessEndpointManagementSettings({bindings:[]},{bindings:[]});assert.equal(result.blockers.length,6);
 assert.ok(!JSON.stringify(assessEndpointManagementSettings(gateway,governance)).includes('private-tenant'));
 assert.throws(()=>assessEndpointManagementSettings({bindings:[...gateway.bindings,gateway.bindings[0]]},governance));
});
test('diagnostics perform only metadata GETs and a health check and redact credentials',async()=>{
 const methods=[];
 const report=await inspectEndpointManagement({CLOUDFLARE_ACCOUNT_ID:'a'.repeat(32),CLOUDFLARE_API_TOKEN:'private-token'},async(url,init)=>{
  methods.push(init.method??'GET');
  if(url.endsWith('/health'))return Response.json({runtime:'cloudflare-worker-typescript',services:{governance:true}});
  return Response.json({success:true,result:url.includes('api-gateway')?gateway:governance});
 });
 assert.deepEqual(methods,['GET','GET','GET']);assert.equal(report.providerWrites,0);assert.equal(report.blockers.length,0);
 assert.ok(!JSON.stringify(report).includes('private-token'));assert.ok(!JSON.stringify(report).includes('private-tenant'));
});
test('missing credentials and denied provider responses produce actionable redacted blockers',async()=>{
 const missing=await inspectEndpointManagement({},()=>assert.fail('Network touched'));assert.equal(missing.blockers[0].key,'providerCredentials');
 const denied=await inspectEndpointManagement({CLOUDFLARE_ACCOUNT_ID:'a'.repeat(32),CLOUDFLARE_API_TOKEN:'private'},async()=>new Response('private-provider-detail',{status:403}));
 assert.equal(denied.blockers.length,2);assert.ok(!JSON.stringify(denied).includes('private-provider-detail'));
});
