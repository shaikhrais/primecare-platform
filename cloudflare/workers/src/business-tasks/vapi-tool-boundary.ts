import {BaseWorker,workerHandler} from '../core/base-worker.ts';
import contract from '../../../../tools/governance-production/vapi-contracts-registration.json' with {type:'json'};
import pin from '../../../../tools/governance-production/production-pin.json' with {type:'json'};
import {createVapiToolCredentialVerifier} from '../../../../packages/shared/src/communications/vapi-service-auth.mjs';
export type VapiBoundaryEnv={
 VAPI_TOOLS_ORIGIN:string;VAPI_TOOLS_SERVICE_SECRET:string;VAPI_CONTRACT_SHA256:string;
 VAPI_API_ID:string;VAPI_TOOL_LIMIT:{limit(input:{key:string}):Promise<{success:boolean}>};
};
const headers={'cache-control':'no-store','x-content-type-options':'nosniff'};
const error=(message:string,status:number,extra:HeadersInit={})=>Response.json({error:message},{status,headers:{...headers,...extra}});
/** Stage-two production boundary. It deliberately grants no business capability.
 * Only the registered operation is exposed. Provider authentication and a platform
 * rate limit are enforced; all authenticated requests remain unavailable until
 * canonical calls, native identity, policy, replay claims and task ports are wired.
 * No body, caller identifier or personal information is read or logged here.
 */
export class VapiToolBoundaryWorker extends BaseWorker<VapiBoundaryEnv>{
 protected async handle(request:Request,env:VapiBoundaryEnv):Promise<Response>{
  const target=new URL(request.url),origin=new URL(env.VAPI_TOOLS_ORIGIN);
  if(origin.protocol!=='https:'||origin.origin!==env.VAPI_TOOLS_ORIGIN||env.VAPI_CONTRACT_SHA256!==pin.vapiContractRegistrationWriter.definitionSha256||!/^[1-9][0-9]*$/.test(env.VAPI_API_ID)||contract.operations.length!==1)throw Error('Verified boundary configuration required');
  const operation=contract.operations[0];
  if(target.origin!==origin.origin||target.pathname!==operation.path)return error('Not found',404);
  if(target.search||target.hash||target.username||target.password)return error('Invalid tool URL',400);
  if(request.method!==operation.method)return error('Method not allowed',405,{allow:operation.method});
  const authenticate=createVapiToolCredentialVerifier({secret:env.VAPI_TOOLS_SERVICE_SECRET});
  if(!await authenticate(request))return error('Unauthorized',401);
  if(typeof env.VAPI_TOOL_LIMIT?.limit!=='function')throw Error('Rate limit binding required');
  const admitted=await env.VAPI_TOOL_LIMIT.limit({key:'vapi-tool-boundary:'+env.VAPI_API_ID});
  if(admitted?.success!==true)return error('Too many requests',429,{'retry-after':'60'});
  // This is an explicit unavailable release phase, not a successful fake task.
  // Attaching tools must wait until the subsequent business composition is tested.
  return error('Business tools are not enabled',503);
 }
 protected override onError():Response{return error('Tool endpoint unavailable',503);}
}
export default workerHandler(new VapiToolBoundaryWorker());
