import {nativeGrowthToolSchemas} from './vapi-growth-tool-schemas.mjs';
import pack from '../vapi-agent-tool-pack.json' with {type:'json'};
import registry from '../growth/registry.json' with {type:'json'};
import taskContracts from '../../../../tools/governance-production/vapi-contracts-registration.json' with {type:'json'};
/** Build-only contracts. Missing server URLs/credentials are never fabricated,
 * and this planner never creates or attaches a Vapi tool or launches a call. */
export function prepareAgentTools(agentKey,registrations=[]){
 const keys=pack.agents[agentKey];if(!keys)throw Error('Unknown agent');
 return keys.map(key=>{
  const tool=pack.tools.find(t=>t.key===key);if(!tool)throw Error('Missing tool contract');
  const result=structuredClone(tool);result.liveBusinessReady=false;if(nativeGrowthToolSchemas[key]){result.functionName='primecare_'+key.replaceAll('.','_');result.inputSchema=structuredClone(nativeGrowthToolSchemas[key]);result.runtime='existing-authenticated-native-client';}
  if(tool.api){
   const matches=registrations.filter(r=>r.route_path===tool.api.path&&r.http_method===tool.api.method);
   result.registration=matches.length===1?{id:matches[0].id,permission:matches[0].permission_key,status:matches[0].implementation_status}:null;
   result.registrationState=matches.length===1?'registered':matches.length?'ambiguous':'not_found';
  }
  if(tool.action){
   const schema=taskContracts.operations[0].request.oneOf.find(s=>s.properties?.action?.const===tool.action&&(!tool.taskId||s.properties?.taskId?.const===tool.taskId));
   if(!schema)throw Error('Existing task contract missing');result.requestSchema=structuredClone(schema);
  }
  return result;
 });
}
/** CRM stage selection only. Input must come from the current authorized backend;
 * returning an agent is a plan, never permission to call or mutate a stage. */
export function planLeadFollowup(lead){
 if(!lead||!['client','tenant'].includes(lead.pipeline)||![...registry.pipelines[lead.pipeline],'lost'].includes(lead.stage))throw Error('Unknown CRM stage');
 if(lead.stage==='lost'||lead.contact_blocked===true||lead.duplicate_of)return {eligible:false,reason:'closed_or_suppressed',automaticCall:false};
 if(lead.contact_blocked!==false||lead.contact_basis!=='requested'||typeof lead.phone!=='string'||!lead.phone.trim())return {eligible:false,reason:'contact_permission_missing',automaticCall:false};
 const agentKey=pack.stageRouting[lead.pipeline]?.[lead.stage];if(!agentKey)throw Error('Missing stage mapping');
 return {eligible:true,pipeline:lead.pipeline,stage:lead.stage,agentKey,toolKeys:[...pack.agents[agentKey]],automaticCall:false,outboundAuthorizationRequired:true};
}
export const agentToolPack=pack;
