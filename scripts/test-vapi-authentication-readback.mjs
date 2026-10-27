import {test} from 'node:test';import assert from 'node:assert/strict';
import {verifyVapiSpokenDeployment} from './vapi-authentication-readback.mjs';
import {savedAgents} from '../packages/shared/src/communications/vapi-agent-library.mjs';
const original='5ae2ab0c-fad0-454c-8cf7-64b81c91c850',phoneId='3e9cee92-b463-47c8-9e1a-cdbf179cb675',id='764dd85f-fafd-45c1-9352-45867ed94371',orgId='9e1d8550-4b84-4472-a782-67557fe73944',instruction='Trusted call instructions';
function fixture(){const receipt={deployed:true,registered:true,authenticationUpdated:true,toolId:id,assistantId:original,source:'a'.repeat(40),endpoint:'https://primecare-vapi-verification-api.owner.workers.dev/v1/vapi/voice/verification',credentialId:'existing-credential',savedAgentAuthentication:Array(8).fill({})},catalog={agents:Object.keys(savedAgents).map(key=>({key,name:key,prompt:'prompt '+key}))},rows=new Map(),requests=[];
 rows.set('/tool/'+id,{id,orgId,type:'function',async:false,function:{name:'primecare_phone_verification'},server:{url:receipt.endpoint,credentialId:receipt.credentialId}});
 const artifactPlan={recordingEnabled:false,loggingEnabled:false,transcriptPlan:{enabled:false}};
 for(const a of catalog.agents)rows.set('/assistant/'+savedAgents[a.key],{id:savedAgents[a.key],orgId,name:a.name,model:{toolIds:[id],messages:[{role:'system',content:a.prompt+'\n\n'+instruction}]},artifactPlan:structuredClone(artifactPlan)});
 rows.set('/assistant/'+original,{id:original,orgId,model:{toolIds:[id],messages:[{role:'system',content:instruction}]},artifactPlan});rows.set('/phone-number/'+phoneId,{id:phoneId,orgId,assistantId:original});
 const options={receipt,catalog,instruction,client:{async request(path){requests.push(path);assert.ok(!path.startsWith('/credential'));return rows.get(path);}},fetch:async(url,init)=>{assert.equal(url,receipt.endpoint);assert.equal(init.method,'POST');assert.ok(!init.headers.authorization);return new Response('{}',{status:401,headers:{'cache-control':'no-store'}});}};return {options,rows,requests};}
test('current tool, eight agent scripts, original reception and routing read back without SMS or credential access',async()=>{const f=fixture(),r=await verifyVapiSpokenDeployment(f.options);assert.equal(r.configurationVerified,true);assert.equal(r.agentsVerified,8);assert.equal(r.liveOtpVerified,false);assert.equal(r.smsSent,false);assert.equal(f.requests.length,11);});
test('missing receipt, arbitrary endpoint, foreign org, changed prompts, logging or routing cannot pass',async()=>{for(const mode of ['missing','url','org','prompt','logging','routing']){const f=fixture();if(mode==='missing')f.options.receipt=null;if(mode==='url')f.options.receipt.endpoint='https://foreign.invalid';if(mode==='org')f.rows.get('/tool/'+id).orgId='foreign';if(mode==='prompt')f.rows.get('/assistant/'+savedAgents.reception).model.messages[0].content='edited';if(mode==='logging')f.rows.get('/assistant/'+savedAgents.reception).artifactPlan.loggingEnabled=true;if(mode==='routing')f.rows.get('/phone-number/'+phoneId).assistantId=savedAgents.reception;const r=await verifyVapiSpokenDeployment(f.options);assert.equal(r.configurationVerified,false);if(['missing','url'].includes(mode))assert.equal(f.requests.length,0);}});
test('unexpected endpoint status and transport errors stay unverified without leaking errors',async()=>{for(const fetch of [async()=>new Response('{}',{status:200}),async()=>{throw Error('private provider token');}]){const f=fixture();const r=await verifyVapiSpokenDeployment({...f.options,fetch});assert.equal(r.configurationVerified,false);assert.ok(!JSON.stringify(r).includes('private'));}});

test('current protected client-read tool and all nine attachments are independently checked when recorded',async()=>{
 const f=fixture(),clientId='dddddddd-dddd-4ddd-8ddd-dddddddddddd';
 f.options.receipt.clientInformationToolId=clientId;
 f.options.fetch=async(url,init)=>{assert.ok([f.options.receipt.endpoint,f.options.receipt.endpoint.replace('/voice/verification','/client/read')].includes(url));assert.ok(!init.headers.authorization);return new Response('{}',{status:401,headers:{'cache-control':'no-store'}});};
 const {clientInformationTool}=await import('../packages/shared/src/communications/vapi-client-information-tool.mjs');
 f.rows.set('/tool/'+clientId,{...clientInformationTool(f.options.receipt.endpoint.replace('/voice/verification','/client/read'),f.options.receipt.credentialId),id:clientId,orgId});
 for(const [path,row] of f.rows)if(path.startsWith('/assistant/'))row.model.toolIds.push(clientId);
 assert.equal((await verifyVapiSpokenDeployment(f.options)).clientInformationVerified,true);
 f.rows.get('/assistant/'+savedAgents.onboarding).model.toolIds=f.rows.get('/assistant/'+savedAgents.onboarding).model.toolIds.filter(v=>v!==clientId);
 assert.equal((await verifyVapiSpokenDeployment(f.options)).configurationVerified,false);
});
