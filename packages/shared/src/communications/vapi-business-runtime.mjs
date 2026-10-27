import {VapiBusinessFunctionAdapter} from './vapi-business-function.mjs';
import {createVapiBusinessToolRunner} from './vapi-business-tool-runner.mjs';
/** Compose the existing server protocol and native API clients. The host owns
 * authentication, current session bindings and durable receipts. No route or
 * permission is created here. Context is freshly resolved for every policy check. */
export function createVapiBusinessRuntime({authenticate,authorize,contexts,journal}) {
 if(typeof contexts?.current!=='function')throw Error('Existing trusted business context required');
 const resolved={async current(callId){
  const c=await contexts.current(callId);
  if(!c)return null;
  const {scopeKey,agentKey,assistantId,expiresAt,fetch,currentScope,leadId,ownerId,appointmentId,search}=c;
  if(typeof currentScope!=='function'||currentScope()!==scopeKey)throw Error('Native context mismatch');
  const runner=createVapiBusinessToolRunner({agentKey,fetch,currentScope,leadId,ownerId,appointmentId,search});
  // Bind the receipt namespace to the host's business targets as well as its
  // native scope. The protocol compares this binding before/after execution.
  const binding=JSON.stringify([scopeKey,leadId??null,ownerId??null,appointmentId??null,search??'']);
  const bytes=new TextEncoder().encode(binding);
  const hash=Array.from(new Uint8Array(await crypto.subtle.digest('SHA-256',bytes)),b=>b.toString(16).padStart(2,'0')).join('');
  return Object.freeze({scopeKey:'business_'+hash,agentKey,assistantId,expiresAt,runner,nativeScopeKey:scopeKey});
 }};
 const adapter=new VapiBusinessFunctionAdapter({authenticate,authorize,contexts:resolved,journal});
 return Object.freeze({respond:request=>adapter.respond(request)});
}
