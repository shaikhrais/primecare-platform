import {clientInformationParameters} from '../packages/shared/src/communications/vapi-client-information-tool.mjs';
import {isDeepStrictEqual} from 'node:util';
import {savedAgents} from '../packages/shared/src/communications/vapi-agent-library.mjs';
const org='9e1d8550-4b84-4472-a782-67557fe73944',original='5ae2ab0c-fad0-454c-8cf7-64b81c91c850',phoneId='3e9cee92-b463-47c8-9e1a-cdbf179cb675',verificationId='764dd85f-fafd-45c1-9352-45867ed94371';
/** Read provider configuration and an anonymous denial only. Never calls the
 * verification tool, reads a credential, sends SMS or creates a native session. */
export async function verifyVapiSpokenDeployment({receipt,client,catalog,instruction,fetch:send=globalThis.fetch}){
 const result={configurationRecorded:false,configurationVerified:false,agentsVerified:0,anonymousDenied:false,liveOtpVerified:false,smsSent:false,businessActionsEnabled:false};
 if(!receipt||receipt.deployed!==true||receipt.registered!==true||receipt.authenticationUpdated!==true||receipt.toolId!==verificationId||receipt.assistantId!==original||! /^[a-f0-9]{40}$/.test(receipt.source??'')||receipt.savedAgentAuthentication?.length!==8||typeof client?.request!=='function'||!instruction||catalog?.agents?.length!==8)return result;
 try{
  const url=new URL(receipt.endpoint);
  if(url.protocol!=='https:'||!/^primecare-vapi-verification-api\.[a-z0-9-]{1,63}\.workers\.dev$/.test(url.hostname)||url.href!==url.origin+'/v1/vapi/voice/verification')return result;
  result.configurationRecorded=true;result.source=receipt.source;
  const tool=await client.request('/tool/'+verificationId);
  if(tool.id!==verificationId||tool.orgId!==org||tool.type!=='function'||tool.async!==false||tool.function?.name!=='primecare_phone_verification'||tool.server?.url!==receipt.endpoint||tool.server?.credentialId!==receipt.credentialId)throw Error();
  result.toolReadback=true;
  if(receipt.clientInformationToolId){
   const read=await client.request('/tool/'+receipt.clientInformationToolId);
   if(read.id!==receipt.clientInformationToolId||read.orgId!==org||read.type!=='function'||read.async!==false||read.function?.name!=='primecare_client_information'||!isDeepStrictEqual(read.function.parameters,clientInformationParameters)||read.server?.credentialId!==receipt.credentialId||read.server?.url!==url.origin+'/v1/vapi/client/read')throw Error();result.clientInformationToolReadback=true;
   const denied=await send(read.server.url,{method:'POST',redirect:'manual',signal:AbortSignal.timeout(15000),headers:{'content-type':'application/json'},body:'{}'});
   try{result.clientInformationAnonymousDenied=denied.status===401&&denied.headers.get('cache-control')?.includes('no-store')===true;}finally{await denied.body?.cancel();}
   if(!result.clientInformationAnonymousDenied)throw Error();
  }

  for(const agent of catalog.agents){
   const id=savedAgents[agent.key];if(!id)throw Error();
   const row=await client.request('/assistant/'+id);
   if(row.id!==id||row.orgId!==org||row.name!==agent.name||!row.model?.toolIds?.includes(verificationId)||receipt.clientInformationToolId&&!row.model.toolIds.includes(receipt.clientInformationToolId)||row.model.messages?.filter(m=>m.role==='system').length!==1||row.model.messages.find(m=>m.role==='system').content!==agent.prompt+'\n\n'+instruction||row.artifactPlan?.recordingEnabled!==false||row.artifactPlan?.loggingEnabled!==false||row.artifactPlan?.transcriptPlan?.enabled!==false)throw Error();
   result.agentsVerified++;
  }
  const active=await client.request('/assistant/'+original);
  if(active.id!==original||active.orgId!==org||!active.model?.toolIds?.includes(verificationId)||receipt.clientInformationToolId&&!active.model.toolIds.includes(receipt.clientInformationToolId)||!active.model.messages?.some(m=>m.role==='system'&&m.content===instruction)||active.artifactPlan?.recordingEnabled!==false||active.artifactPlan?.loggingEnabled!==false||active.artifactPlan?.transcriptPlan?.enabled!==false)throw Error();
  const phone=await client.request('/phone-number/'+phoneId);
  if(phone.id!==phoneId||phone.orgId!==org||phone.assistantId!==original||phone.squadId||phone.workflowId)throw Error();
  result.activeReceptionVerified=true;result.phoneRoutingVerified=true;
  const response=await send(receipt.endpoint,{method:'POST',redirect:'manual',signal:AbortSignal.timeout(15000),headers:{'content-type':'application/json'},body:'{}'});
  try{result.anonymousDenied=response.status===401&&response.headers.get('cache-control')?.includes('no-store')===true;}finally{await response.body?.cancel();}
  result.configurationVerified=result.anonymousDenied;result.clientInformationVerified=result.anonymousDenied&&result.clientInformationToolReadback===true;
 }catch{result.configurationVerified=false;}
 return result;
}
