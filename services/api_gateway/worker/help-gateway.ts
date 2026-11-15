import {GatewayWorker} from '../../../cloudflare/workers/src/gateway';
import {workerHandler} from '../../../cloudflare/workers/src/core/base-worker';
import contract from '../../../tools/governance-production/pc10-help-reader-contract.json';

type GatewayEnvironment=Parameters<GatewayWorker['fetch']>[1];
/** One canonical API794 route on top of the unchanged gateway. The parent
 * supplies service binding, CORS, preflight, cache and failure semantics.
 */
export class HelpGatewayWorker extends GatewayWorker {
 protected override handle(request:Request,env:GatewayEnvironment):Promise<Response>{
  const url=new URL(request.url);
  if(url.pathname!==contract.path)return super.handle(request,env);
  // Parent dispatch strips exactly /v1/governance, retaining the full canonical
  // Help path for the concrete governance composition and its method checks.
  url.pathname='/v1/governance'+contract.path;
  return super.handle(new Request(url,request),env);
 }
}
export default workerHandler(new HelpGatewayWorker()) satisfies ExportedHandler<GatewayEnvironment>;
