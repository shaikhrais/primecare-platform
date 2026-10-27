import {ScopedServiceBase,type Actor,type AtomicStore,type AccessPolicy} from '../../../../packages/shared/src/communications/service-base.ts';
export type SpokenCandidate={actor:Actor;phone:string;version:number;callSid:string;callId:string};
export type SpokenPorts={current(callId:string):Promise<SpokenCandidate|null>;run(candidate:SpokenCandidate,input:{action:'request'|'check';requestId:string;code?:string}):Promise<{verified:boolean;codeRequested?:boolean}>};
/** Call-scoped SMS possession proof; never an appointment approval or native login. */
export class SpokenSmsVerificationService extends ScopedServiceBase {
 readonly ports:SpokenPorts;
 constructor(store:AtomicStore,policy:AccessPolicy,ports:SpokenPorts){super(store,policy);this.ports=ports;if(typeof ports?.current!=='function'||typeof ports?.run!=='function')throw Error('Verification ports required');}
 async execute(callId:string,requestId:string,input:unknown){
  if(!/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i.test(callId)||!/^[A-Za-z0-9_-]{1,160}$/.test(requestId)||!input||typeof input!=='object'||Array.isArray(input))throw Error('Verification unavailable');
  const args=input as Record<string,unknown>,keys=Object.keys(args).sort().join(',');
  if(args.action==='request'?keys!=='action,consent'||args.consent!==true:args.action!=='check'||keys!=='action,code'||typeof args.code!=='string'||!/^\d{6}$/.test(args.code))throw Error('Invalid verification request');
  const candidate=await this.ports.current(callId);if(!candidate||candidate.callId!==callId||!/^CA[a-f0-9]{32}$/i.test(candidate.callSid)||!/^\+[1-9][0-9]{6,14}$/.test(candidate.phone)||!Number.isSafeInteger(candidate.version)||candidate.version<1)throw Error('Verified account contact required');
  const snapshot=structuredClone(candidate);await this.authorize(snapshot);
  const result=await this.ports.run(snapshot,{action:args.action as 'request'|'check',requestId,...(args.action==='check'?{code:args.code as string}:{})});
  const latest=await this.ports.current(callId);if(!latest||JSON.stringify(latest)!==JSON.stringify(snapshot))throw Error('Call or account changed');await this.authorize(latest);
  if(args.action==='request'&&result?.verified!==false||typeof result?.verified!=='boolean'||result.codeRequested!==undefined&&typeof result.codeRequested!=='boolean')throw Error('Invalid verification receipt');
  return {verified:result.verified,...(result.codeRequested===true?{codeRequested:true}:{}),scope:'current_call_only',businessActionApproved:false};
 }
 private async authorize(candidate:SpokenCandidate){await this.checkAccess(candidate.actor,'voice.sms.spoken.verify',{id:'voice-call:'+candidate.callId,tenantId:candidate.actor.tenantId,ownerId:candidate.actor.id,kind:'voice_auth',version:1},['voice_auth']);}
}
