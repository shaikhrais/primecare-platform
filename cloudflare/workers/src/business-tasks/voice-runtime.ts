import {BaseWorker} from '../core/base-worker.ts';
import definition from '../../../../tools/governance-production/twilio-contracts-registration.json' with {type:'json'};
import type {RelaySocket} from '../../../../packages/shared/src/communications/twilio-relay-session.mjs';

type HttpAdapter={respond(request:Request):Promise<Response>};
type RelaySession={close():void};
export type VoiceRuntimePorts={
 native:HttpAdapter; voice:HttpAdapter; connect:HttpAdapter; voicemail:HttpAdapter;
 pairing:HttpAdapter; agent:HttpAdapter; smsStatus:HttpAdapter;
 relay:{open(request:Request,socket:RelaySocket):RelaySession};
 sockets:{pair():{client:unknown;server:RelaySocket};upgrade(client:unknown):Response};
};
const groups:Readonly<Record<string,keyof Omit<VoiceRuntimePorts,'relay'|'sockets'>>>=Object.freeze({
 token:'native','extension.assign':'native','extension.publish':'native',
 'voicemail.read':'native','voicemail.audio':'native','otp.start':'native','otp.check':'native',
 'task.preview':'native','task.approve':'native',
 'voice.incoming':'voice','voice.gather':'voice','voice.connect':'connect',
 'voice.dial_complete':'voicemail','voice.record_action':'voicemail','voice.recording_status':'voicemail',
 'voice.pair':'pairing','voice.wait':'pairing','voice.agent':'agent','voice.agent_complete':'agent',
 'sms.status':'smsStatus',
});
const headers={'cache-control':'no-store','x-content-type-options':'nosniff'};
const deny=(status:number,code:string,extra:HeadersInit={})=>Response.json({error:code},{status,headers:{...headers,...extra}});

/** Exact registered route dispatch. Hosts must compose current scoped services
 * and signed adapters before construction; there are no default grants or ports.
 * This worker owns no database/client identity and never rewrites signing URLs.
 */
export class CommunicationVoiceWorker<E> extends BaseWorker<E> {
 readonly origin:string;
 private readonly routes:ReadonlyMap<string,{method:string;key:string}>;
 private readonly handlers:Readonly<Record<string,HttpAdapter['respond']>>;
 private readonly open:VoiceRuntimePorts['relay']['open'];
 private readonly pair:VoiceRuntimePorts['sockets']['pair'];
 private readonly upgrade:VoiceRuntimePorts['sockets']['upgrade'];
 constructor(origin:string,ports:VoiceRuntimePorts){
  super();const url=new URL(origin);
  if(url.protocol!=='https:'||url.origin!==origin||url.username||url.password||definition.service!=='governance')throw Error('Exact voice origin required');
  this.origin=origin;
  const routes=new Map<string,{method:string;key:string}>(),handlers:Record<string,HttpAdapter['respond']>={};
  for(const op of definition.operations){
   if(routes.has(op.path)||op.key!=='voice.relay'&&!groups[op.key])throw Error('Voice runtime catalog mismatch');
   routes.set(op.path,Object.freeze({method:op.method,key:op.key}));
   if(op.key==='voice.relay')continue;
   const adapter=ports?.[groups[op.key]];
   if(typeof adapter?.respond!=='function')throw Error('Complete voice adapters required');
   handlers[op.key]=adapter.respond.bind(adapter);
  }
  if(routes.size!==21||!definition.operations.some(op=>op.key==='voice.relay'&&op.method==='GET')||typeof ports?.relay?.open!=='function'||typeof ports.sockets?.pair!=='function'||typeof ports.sockets?.upgrade!=='function')throw Error('Complete voice socket ports required');
  this.routes=routes;this.handlers=Object.freeze(handlers);
  this.open=ports.relay.open.bind(ports.relay);this.pair=ports.sockets.pair.bind(ports.sockets);this.upgrade=ports.sockets.upgrade.bind(ports.sockets);
 }
 protected async handle(request:Request,_env:E):Promise<Response>{
  const url=new URL(request.url),route=this.routes.get(url.pathname);
  if(url.origin!==this.origin||!route)return deny(404,'not_found');
  if(request.method!==route.method)return deny(405,'method_not_allowed',{allow:route.method});
  if(url.search||url.hash||url.username||url.password)return deny(400,'invalid_voice_url');
  if(route.key!=='voice.relay')return this.handlers[route.key](request);
  // Reject malformed upgrades before allocating sockets. The inherited relay
  // adapter remains responsible for exact Twilio signature validation.
  if(request.headers.get('upgrade')?.toLowerCase()!=='websocket'||request.body!==null)return deny(426,'websocket_required',{upgrade:'websocket'});
  const signature=request.headers.get('x-twilio-signature');
  if(!signature||signature.length>100)return deny(403,'forbidden');
  const pair=this.pair();let session:RelaySession|undefined;
  try{
   session=this.open(request,pair.server);
   // Return the original upgrade response: rebuilding/compressing it would
   // discard the client WebSocket and can break the live Twilio connection.
   const response=this.upgrade(pair.client);
   if(response.status!==101)throw Error('Voice upgrade required');
   return response;
  }catch{
   try{session?.close();}catch{}
   try{pair.server.close(1008,'Voice unavailable');}catch{}
   try{(pair.client as {close?:()=>void})?.close?.();}catch{}
   return deny(403,'forbidden');
  }
 }
 protected override onError():Response{return deny(503,'voice_unavailable');}
}
