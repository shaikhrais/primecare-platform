import {nativeContactGatewayServices} from './voice-contact-deployment-plan.mjs';
export const internalCallGatewayServices=nativeContactGatewayServices;
export function assertOwnedInternalCallTarget(settings,config){
 if(settings===null)return;
 const allowed=['INTERNAL_CALL_OWNER','INTERNAL_CALL_SOURCE','INTERNAL_CALL_ORIGIN','INTERNAL_CALL_GATEWAY_ORIGIN','TURN_KEY_ID','TURN_KEY_TOKEN','DB_URL','INTERNAL_CALL_LIMIT','CALL_RELAY_LIMIT'];
 if(!Array.isArray(settings?.bindings)||settings.bindings.find(b=>b.name==='INTERNAL_CALL_OWNER')?.text!==config.owner||settings.bindings.some(b=>!allowed.includes(b.name))||new Set(settings.bindings.map(b=>b.name)).size!==settings.bindings.length)throw Error('existing_worker_preserved');
}

/** Provider-compatible bounded fields; the API documentation's fixed key length
 * is narrower than some live responses. Never return key values in diagnostics. */
export function validOwnedTurnKey(key,config){
 return key?.name===config.turnKeyName&&typeof key.uid==='string'&&/^[A-Za-z0-9_-]{16,128}$/.test(key.uid)&&typeof key.key==='string'&&key.key.length>=16&&key.key.length<=512&&!/[^\x21-\x7e]/.test(key.key);
}
export function recoverableUnusedTurnKey({key,worker,gateway},config){
 return key?.name===config.turnKeyName&&typeof key.uid==='string'&&/^[A-Za-z0-9_-]{16,128}$/.test(key.uid)&&worker?.bindings?.some(b=>b.name==='INTERNAL_CALL_OWNER'&&b.text===config.owner)&&worker.bindings.some(b=>b.name==='INTERNAL_CALL_SOURCE'&&['b2b89613f2af779beb3b84ed9d513ff4b8741a6a','ae607bca0a1122c07f1efc88458351036ca4b9f7'].includes(b.text))&&!worker.bindings.some(b=>b.name==='TURN_KEY_TOKEN'||b.name==='TURN_KEY_ID')&&!gateway.bindings.some(b=>b.name===config.gatewayBinding);
}

/** Cloudflare deployments may return the one-time bearer alongside result.
 * Preserve it only in memory on successful key creation, never in a receipt. */
export function turnCreateResult(envelope){
 const result=envelope?.result;
 if(!result||typeof result!=='object'||Array.isArray(result))throw Error('invalid_turn_key');
 if(typeof result.key==='string'&&typeof envelope.key==='string'&&result.key!==envelope.key)throw Error('invalid_turn_key');
 return {...result,key:result.key??envelope.key};
}
