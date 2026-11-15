import {ServiceApplication} from '../../../cloudflare/workers/src/service-application';
import {helpReader} from './help-reader';
import {workerHandler} from '../../../cloudflare/workers/src/core/base-worker';
import type {WorkerContext} from '../../../cloudflare/workers/src/runtime/handler-pipeline';
import type {Env} from '../../../cloudflare/workers/src/auth';

/** Governance-only composition. Auth and other generic Worker entry graphs
 * remain unchanged. The exact Help guard precedes inherited legacy dispatch.
 */
export class GovernanceHelpServiceApplication extends ServiceApplication {
 protected override async dispatch(context:WorkerContext<Env>):Promise<Response|null>{
  const response=await helpReader(context.request,context.env,context.path,context.headers);
  return response??super.dispatch(context);
 }
}
export default workerHandler(new GovernanceHelpServiceApplication()) satisfies ExportedHandler<Env>;
