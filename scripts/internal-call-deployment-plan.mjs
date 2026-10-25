import {nativeContactGatewayServices} from './voice-contact-deployment-plan.mjs';
export const internalCallGatewayServices=nativeContactGatewayServices;
export function assertOwnedInternalCallTarget(settings,config){
 if(settings===null)return;
 const allowed=['INTERNAL_CALL_OWNER','INTERNAL_CALL_SOURCE','INTERNAL_CALL_ORIGIN','INTERNAL_CALL_GATEWAY_ORIGIN','TURN_KEY_ID','TURN_KEY_TOKEN','DB_URL','INTERNAL_CALL_LIMIT','CALL_RELAY_LIMIT'];
 if(!Array.isArray(settings?.bindings)||settings.bindings.find(b=>b.name==='INTERNAL_CALL_OWNER')?.text!==config.owner||settings.bindings.some(b=>!allowed.includes(b.name))||new Set(settings.bindings.map(b=>b.name)).size!==settings.bindings.length)throw Error('existing_worker_preserved');
}
