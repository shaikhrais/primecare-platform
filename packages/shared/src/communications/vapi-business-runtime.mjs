import {VapiBusinessFunctionAdapter} from './vapi-business-function.mjs';
import {createVapiBusinessToolRunner} from './vapi-business-tool-runner.mjs';
import {DurableVapiBusinessJournal} from './vapi-business-journal.mjs';
/** Compose the existing server protocol and native API clients. The host owns
 * authentication, current session bindings and durable receipts. No route or
 * permission is created here. Context is freshly resolved for every policy check. */
export function createVapiBusinessRuntime({authenticate,authorize,contexts,journal,durableStorage}) {
 if(typeof contexts?.current!=='function')throw Error('Existing trusted business context required');
 if(journal!==undefined&&durableStorage!==undefined)throw Error('Choose one execution receipt store');
 const receipts=durableStorage===undefined?journal:new DurableVapiBusinessJournal(durableStorage);
 const resolved={async current(callId){
  const c=await contexts.current(callId);
  if(!c)return null;
  const {scopeKey,agentKey,assistantId,expiresAt,fetch,currentScope,leadId,ownerId,appointmentId,search,support,bookingRequests}=c;
  if(typeof currentScope!=='function'||currentScope()!==scopeKey)throw Error('Native context mismatch');
  const runner=createVapiBusinessToolRunner({agentKey,fetch,currentScope,leadId,ownerId,appointmentId,search,support,bookingRequests});
  // Bind the receipt namespace to the host's business targets as well as its
  // native scope. The protocol compares this binding before/after execution.
  const binding=JSON.stringify([scopeKey,leadId??null,ownerId??null,appointmentId??null,search??'',support?[support.actorId,support.tenantId,support.conversationId,support.recipientId]:null,bookingRequests?[bookingRequests.serviceType??null,bookingRequests.requestId??null,bookingRequests.timeZone]:null]);
  const bytes=new TextEncoder().encode(binding);
  const hash=Array.from(new Uint8Array(await crypto.subtle.digest('SHA-256',bytes)),b=>b.toString(16).padStart(2,'0')).join('');
  return Object.freeze({scopeKey:'business_'+hash,agentKey,assistantId,expiresAt,runner,nativeScopeKey:scopeKey});
 }};
 const adapter=new VapiBusinessFunctionAdapter({authenticate,authorize,contexts:resolved,journal:receipts});
 return Object.freeze({respond:request=>adapter.respond(request)});
}
