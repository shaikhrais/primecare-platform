import {VapiApiRequestAdapter,type VapiApiRequestOptions} from '../../../../packages/shared/src/communications/vapi-api-request.mjs';
import type {Actor,RecordState} from '../../../../packages/shared/src/communications/service-base.ts';
import {createVapiToolCredentialVerifier} from '../../../../packages/shared/src/communications/vapi-service-auth.mjs';
import {DurableVapiBusinessJournal} from '../../../../packages/shared/src/communications/vapi-business-journal.mjs';
import {createPostgresReceptionCallbackServices} from './reception-callback.ts';
import {PostgresReceptionCallbackAccessPolicy} from './reception-callback-policy.ts';
import {VapiCallTaskIdentityBroker,VapiVerifiedCallIdentityService} from './vapi-call-identity.ts';
import {registeredMetadataValue as value} from './endpoint-policy.ts';
import pin from '../../../../tools/governance-production/production-pin.json' with {type:'json'};
import contract from '../../../../tools/governance-production/vapi-contracts-registration.json' with {type:'json'};
type Pool=Parameters<typeof createPostgresReceptionCallbackServices>[0]['pool'];
type Storage={transaction<T>(closure:(tx:{get(key:string):Promise<unknown>;put(key:string,value:unknown):Promise<void>})=>Promise<T>):Promise<T>};
/** Concrete callback-only composition: canonical calls, private OTP proof,
 * current PostgreSQL role policy, independent app approval and real persistence.
 * Construction mounts no route and attaches no provider tool. */
export function createPostgresVapiCallbackHost(options:{pool:Pool;identities:VapiVerifiedCallIdentityService;durableStorage:Storage;secret:string;orgId:string;assistantId:string;phoneNumberId:string;calls:VapiApiRequestOptions['calls'];admit:VapiApiRequestOptions['admit']}){
 if(typeof options.pool?.connect!=='function'||typeof options.pool?.query!=='function'||!(options.identities instanceof VapiVerifiedCallIdentityService)||!/^governance_[a-f0-9]+$/.test(pin.schema))throw Error('Verified callback host required');
 const op=contract.operations[0],url='https://primecare-vapi-tools-api.itpro-mohammed.workers.dev'+op.path;
 if(contract.operations.length!==1||op.method!=='POST'||op.path!=='/v1/vapi/voice/tasks'||op.permission!=='vapi.service.tasks')throw Error('Registered callback contract required');
 const authenticate=createVapiToolCredentialVerifier({secret:options.secret}),journal=new DurableVapiBusinessJournal(options.durableStorage);
 const binding=Object.freeze({...options});
 const authorize=async()=>{
  const db=await binding.pool.connect();
  try{
   await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');await db.query("SET LOCAL statement_timeout='5s'");
   const manifests=(await db.query(`SELECT manifest_sha256 FROM "${pin.schema}".govt_source_manifest`)).rows;
   if(manifests.length!==1||manifests[0].manifest_sha256!==pin.manifestSha256)throw Error('Manifest changed');
   const rows=(await db.query(`SELECT ${value('a','id')} AS id,${value('a','permission_key')} AS permission,${value('a','auth_required')} AS auth,${value('a','endpoint_code')} AS code FROM "${pin.schema}".govt_api_endpoints a WHERE ${value('a','http_method')}=$1 AND ${value('a','route_path')}=$2 AND ${value('a','service_name')}='governance' LIMIT 2`,[op.method,op.path])).rows;
   return rows.length===1&&rows[0].id==='16534'&&rows[0].permission===op.permission&&rows[0].auth==='1'&&rows[0].code==='VAPI_VOICE_TASKS';
  }finally{try{await db.query('ROLLBACK');}finally{db.release();}}
 };
 const policy=new class extends PostgresReceptionCallbackAccessPolicy {
  override async assert(actor:Actor,action:string,state:RecordState|null){
   if(!await authorize())throw Error('Callback tool registration unavailable');
   await super.assert(actor,action,state);
  }
 }(binding.pool);
 return Object.freeze({async respond(request:Request){
  // Header is only a lookup key: canonical directory and OTP broker must agree.
  const services=()=>createPostgresReceptionCallbackServices({pool:binding.pool,policy,identities:new VapiCallTaskIdentityBroker(binding.identities,request.headers.get('x-primecare-vapi-call-id')??'')});
  const adapter=new VapiApiRequestAdapter({url,orgId:binding.orgId,assistantId:binding.assistantId,phoneNumberId:binding.phoneNumberId,authenticate,authorize,admit:binding.admit,calls:binding.calls,
   claims:{async claim(input){return (await journal.begin({callId:input.vapiCallId,scopeKey:'registered_callback_request',toolCallId:input.requestId,digest:input.digest})).status==='new';}},
   tasks:{async propose(callSid,taskId,args){return services().tasks.propose(callSid,taskId,args);},async execute(callSid,intentId){return services().tasks.execute(callSid,intentId);}},taskIds:['reception.callback.request']});
  return adapter.respond(request);
 }});
}
