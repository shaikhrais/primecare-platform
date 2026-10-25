import {nativeContactGatewayServices} from './voice-contact-deployment-plan.mjs';
export const internalCallGatewayServices=nativeContactGatewayServices;
export const callDatabaseName='primecare-internal-calls-fresh-v1';
export function callDatabaseOrigin(connectionString){
 const u=new URL(connectionString);
 if(!['postgres:','postgresql:'].includes(u.protocol)||u.hostname!=='pooled.db.prisma.io'||u.port&&u.port!=='5432'||u.pathname!=='/postgres'||!u.username||!u.password)throw Error('pinned_call_database_required');
 return {scheme:'postgres',host:u.hostname,port:5432,database:'postgres',user:decodeURIComponent(u.username),password:decodeURIComponent(u.password)};
}
export function assertCallDatabaseConfiguration(value,origin,boundId){
 if(!value||!/^[a-f0-9]{32}$/.test(value.id??'')||value.name!==callDatabaseName||value.caching?.disabled!==true||value.origin_connection_limit!==5||value.origin?.scheme!=='postgres'||value.origin.host!==origin.host||value.origin.port!==origin.port||value.origin.database!==origin.database||value.origin.user!==origin.user||value.mtls?.sslmode&&value.mtls.sslmode!=='require'||boundId&&boundId!==value.id)throw Error('existing_call_database_preserved');
 return value.id;
}
export function assertOwnedInternalCallTarget(settings,config){
 if(settings===null)return;
 const allowed=['INTERNAL_CALL_OWNER','INTERNAL_CALL_SOURCE','INTERNAL_CALL_ORIGIN','INTERNAL_CALL_GATEWAY_ORIGIN','TURN_KEY_ID','TURN_KEY_TOKEN','DB_URL','INTERNAL_CALL_LIMIT','CALL_RELAY_LIMIT','CALL_DATABASE','CALL_EVENTS','CALL_EVENTS_LIMIT'];
 if(!Array.isArray(settings?.bindings)||settings.bindings.find(b=>b.name==='INTERNAL_CALL_OWNER')?.text!==config.owner||settings.bindings.some(b=>!allowed.includes(b.name))||new Set(settings.bindings.map(b=>b.name)).size!==settings.bindings.length)throw Error('existing_worker_preserved');
 const events=settings.bindings.find(b=>b.name==='CALL_EVENTS');if(events&&(events.type!=='durable_object_namespace'||events.class_name!=='InternalCallEventsHub'||events.script_name!==undefined&&events.script_name!==config.workerName))throw Error('existing_worker_preserved');
 const database=settings.bindings.find(b=>b.name==='CALL_DATABASE');if(database&&(database.type!=='hyperdrive'||!/^[a-f0-9]{32}$/.test(database.id??'')))throw Error('existing_worker_preserved');
}

/** Provider-compatible bounded fields; the API documentation's fixed key length
 * is narrower than some live responses. Never return key values in diagnostics. */
export function validOwnedTurnKey(key,config){
 return key?.name===config.turnKeyName&&typeof key.uid==='string'&&/^[A-Za-z0-9_-]{16,128}$/.test(key.uid)&&typeof key.key==='string'&&key.key.length>=16&&key.key.length<=512&&!/[^\x21-\x7e]/.test(key.key);
}
export function recoverableUnusedTurnKey({key,worker,gateway},config){
 return key?.name===config.turnKeyName&&typeof key.uid==='string'&&/^[A-Za-z0-9_-]{16,128}$/.test(key.uid)&&worker?.bindings?.some(b=>b.name==='INTERNAL_CALL_OWNER'&&b.text===config.owner)&&worker.bindings.some(b=>b.name==='INTERNAL_CALL_SOURCE'&&['b2b89613f2af779beb3b84ed9d513ff4b8741a6a','ae607bca0a1122c07f1efc88458351036ca4b9f7','c4789d2850198d25d02f9dade13cc12f8d835a09'].includes(b.text))&&!worker.bindings.some(b=>b.name==='TURN_KEY_TOKEN'||b.name==='TURN_KEY_ID')&&!gateway.bindings.some(b=>b.name===config.gatewayBinding);
}

/** Cloudflare deployments may return the one-time bearer alongside result.
 * Preserve it only in memory on successful key creation, never in a receipt. */
export function turnCreateResult(envelope){
 const result=envelope?.result;
 if(!result||typeof result!=='object'||Array.isArray(result))throw Error('invalid_turn_key');
 const keys=[result.key,result.secret,envelope.key].filter(v=>v!==undefined);
 if(keys.some(v=>typeof v!=='string')||new Set(keys).size>1)throw Error('invalid_turn_key');
 return {...result,key:keys[0]};
}
