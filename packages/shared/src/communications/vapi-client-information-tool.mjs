import {isDeepStrictEqual} from 'node:util';
export const clientInformationParameters=Object.freeze({type:'object',properties:{section:{type:'string',enum:['appointments','service_history','onboarding_status']}},required:['section'],additionalProperties:false});
export function clientInformationTool(url,credentialId){return {type:'function',async:false,function:{name:'primecare_client_information',description:'After current-call OTP succeeds, read only the verified caller\'s own appointment, visit-history or onboarding administrative statuses. Does not create or change any record.',parameters:structuredClone(clientInformationParameters)},server:{url,credentialId,timeoutSeconds:60}};}

export async function resolveClientInformationTool(client){
 const tools=await client.request('/tool');if(!Array.isArray(tools)||tools.length>200)throw Error('invalid_tool_inventory');
 const matches=tools.filter(t=>t.function?.name==='primecare_client_information');if(!matches.length)return null;if(matches.length!==1)throw Error('ambiguous_client_information_tool');
 const tool=await client.request('/tool/'+matches[0].id),verification=await client.request('/tool/764dd85f-fafd-45c1-9352-45867ed94371');
 const endpoint='https://primecare-vapi-verification-api.itpro-mohammed.workers.dev/v1/vapi/client/read';
 if(tool.id!==matches[0].id||verification.id!=='764dd85f-fafd-45c1-9352-45867ed94371'||tool.orgId!=='9e1d8550-4b84-4472-a782-67557fe73944'||verification.orgId!==tool.orgId||tool.type!=='function'||tool.async!==false||tool.function?.name!=='primecare_client_information'||tool.server?.url!==endpoint||verification.server?.url!==endpoint.replace('/client/read','/voice/verification')||tool.server?.credentialId!==verification.server?.credentialId||!isDeepStrictEqual(tool.function.parameters,clientInformationParameters))throw Error('unreviewed_client_information_tool');
 return {toolId:tool.id,endpoint};
}
