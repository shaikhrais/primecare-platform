import {ScopedServiceBase,type AtomicStore,type AccessPolicy,type Actor} from '../../../../packages/shared/src/communications/service-base.ts';
export type VerifiedVoiceIdentity={actor:Actor;sessionId:string;authentication:'otp'|'passkey';active:boolean;expiresAt:number};
export type VoiceTaskIntent={id:string;callSid:string;actor:Actor;sessionId:string;taskId:string;taskVersion:number;args:Record<string,unknown>;summary:string;digest:string;expiresAt:number;status:'proposed'|'executing'|'completed'|'unknown'};
export class VoiceTaskConfirmationRequiredError extends Error {readonly code='VOICE_TASK_CONFIRMATION_REQUIRED';constructor(){super('Explicit confirmation required');}}
export interface VoiceTaskRepository {create(intent:VoiceTaskIntent):Promise<void>;read(id:string):Promise<VoiceTaskIntent|null>;claim(id:string,digest:string):Promise<boolean>;finish(id:string,status:'completed'|'unknown'):Promise<void>}
export interface VoiceTaskTrust {
 /** Server auth broker only. Caller ID, model claims and voice similarity are not authentication. */
 current(callSid:string):Promise<VerifiedVoiceIdentity|null>;
 /** Trusted app confirmation or dedicated signed provider speech/DTMF callback, bound to this exact digest.
  * Atomically consumes one approval. Never implement this from an AI transcript/tool argument; signed-speech requires the dedicated readback challenge callback.
  */
 consumeConfirmation(input:{callSid:string;intentId:string;digest:string;actor:Actor;sessionId:string}):Promise<{approved:boolean;method:'app'|'dtmf'|'signed-speech';approvedAt:number}|null>;
}
/** Task implementations bind existing typed services, never model-selected URLs. */
export abstract class VoiceTaskBase {
 readonly id:string;readonly version:number;
 constructor(id:string,version:number){if(!/^[a-z][a-z0-9_.]{1,79}$/.test(id)||!Number.isSafeInteger(version)||version<1)throw Error('Registered task required');this.id=id;this.version=version;}
 abstract validate(args:unknown):Record<string,unknown>;
 abstract describe(args:Record<string,unknown>):string;
 abstract execute(actor:Actor,args:Record<string,unknown>,idempotencyKey:string):Promise<void>;
}
export class BoundVoiceApiTask extends VoiceTaskBase {
 readonly ports:{validate(args:unknown):Record<string,unknown>;describe(args:Record<string,unknown>):string;execute(actor:Actor,args:Record<string,unknown>,idempotencyKey:string):Promise<void>};
 constructor(id:string,version:number,ports:BoundVoiceApiTask['ports']){super(id,version);if(['validate','describe','execute'].some(key=>typeof (ports as any)?.[key]!=='function'))throw Error('Task API ports required');this.ports=Object.freeze({...ports});}
 validate(args:unknown){return this.ports.validate(args);}describe(args:Record<string,unknown>){return this.ports.describe(args);}execute(actor:Actor,args:Record<string,unknown>,key:string){return this.ports.execute(actor,args,key);}
}
function canonical(value:unknown,depth=0):string {
 if(depth>8)throw Error('Task argument bounds');
 if(value===null||typeof value==='boolean'||typeof value==='string'&&value.length<=2000||typeof value==='number'&&Number.isFinite(value))return JSON.stringify(value);
 if(Array.isArray(value)&&value.length<=100)return '['+value.map(v=>canonical(v,depth+1)).join(',')+']';
 if(value&&typeof value==='object'&&[Object.prototype,null].includes(Object.getPrototypeOf(value))){const keys=Object.keys(value).sort();if(keys.length>100||keys.some(k=>['__proto__','constructor','prototype'].includes(k)))throw Error('Task argument bounds');return '{'+keys.map(k=>JSON.stringify(k)+':'+canonical((value as any)[k],depth+1)).join(',')+'}';}
 throw Error('Task argument bounds');
}
function argumentsSnapshot(value:unknown){if(!value||typeof value!=='object'||Array.isArray(value))throw Error('Task arguments required');const encoded=canonical(value);if(new TextEncoder().encode(encoded).length>8192)throw Error('Task argument bounds');return JSON.parse(encoded) as Record<string,unknown>;}
async function digest(value:unknown){const bytes=await crypto.subtle.digest('SHA-256',new TextEncoder().encode(canonical(value)));return Array.from(new Uint8Array(bytes),b=>b.toString(16).padStart(2,'0')).join('');}
/** Reuse the exact approval digest when a concrete request service rechecks a
 * claimed intent. The mutable execution status is not part of a new approval. */
export async function voiceTaskIntentDigest(intent:VoiceTaskIntent){return digest({...intent,digest:'',status:'proposed'});}
/** Provider-neutral boundary for Vapi or Twilio ConversationRelay tool calls.
 * Neither the model nor a voice-match result may approve or select an actor.
 */
export class VoiceTaskService extends ScopedServiceBase {
 readonly repository:VoiceTaskRepository;readonly trust:VoiceTaskTrust;#tasks:ReadonlyMap<string,VoiceTaskBase>;
 constructor(store:AtomicStore,policy:AccessPolicy,repository:VoiceTaskRepository,trust:VoiceTaskTrust,tasks:readonly VoiceTaskBase[]){
  super(store,policy);if(['create','read','claim','finish'].some(k=>typeof (repository as any)?.[k]!=='function')||typeof trust?.current!=='function'||typeof trust?.consumeConfirmation!=='function'||!Array.isArray(tasks)||tasks.some(t=>!(t instanceof VoiceTaskBase))||new Set(tasks.map(t=>t.id)).size!==tasks.length)throw Error('Voice task ports required');
  this.repository=repository;this.trust=trust;this.#tasks=new Map(tasks.map(task=>[task.id,task]));
 }
 async #identity(callSid:string){
  if(!/^CA[a-fA-F0-9]{32}$/.test(callSid))throw Error('Voice task unavailable');
  const row=await this.trust.current(callSid);
  if(!row||row.active!==true||!['otp','passkey'].includes(row.authentication)||!row.sessionId||!row.actor?.id||!row.actor?.tenantId||!Number.isSafeInteger(row.expiresAt)||row.expiresAt<=Date.now())throw Error('Voice verification required');
  return Object.freeze({...row,actor:Object.freeze({id:row.actor.id,tenantId:row.actor.tenantId})});
 }
 async #authorized(identity:VerifiedVoiceIdentity,intent:VoiceTaskIntent,action:string){
  if(identity.actor.id!==intent.actor.id||identity.actor.tenantId!==intent.actor.tenantId||identity.sessionId!==intent.sessionId||intent.expiresAt<=Date.now())throw Error('Voice task unavailable');
  await this.checkAccess(identity.actor,action,{id:intent.id,tenantId:intent.actor.tenantId,kind:'voice_task',version:1,ownerId:intent.actor.id,taskId:intent.taskId,args:structuredClone(intent.args)},['voice_task']);
 }
 async propose(callSid:string,taskId:string,args:unknown){
  const identity=await this.#identity(callSid),task=this.#tasks.get(taskId);if(!task||task.id!==taskId)throw Error('Task not allowed');
  const validated=argumentsSnapshot(task.validate(argumentsSnapshot(args))),summary=task.describe(structuredClone(validated));
  if(typeof summary!=='string'||!summary.trim()||summary.length>1000||/[\u0000-\u001f\u007f]/.test(summary))throw Error('Task summary required');
  const intent:VoiceTaskIntent={id:crypto.randomUUID(),callSid,actor:identity.actor,sessionId:identity.sessionId,taskId:task.id,taskVersion:task.version,args:validated,summary,digest:'',expiresAt:Math.min(identity.expiresAt,Date.now()+120000),status:'proposed'};
  intent.digest=await digest({...intent,digest:''});
  await this.#authorized(await this.#identity(callSid),intent,'voice.task.propose');
  await this.repository.create(structuredClone(intent));
  return Object.freeze({intentId:intent.id,summary:intent.summary,digest:intent.digest,expiresAt:intent.expiresAt,requiresConfirmation:true});
 }
 async execute(callSid:string,intentId:string){
  const saved=await this.repository.read(intentId);if(!saved)throw Error('Voice task unavailable');const intent=structuredClone(saved);
  if(intent.callSid!==callSid||intent.status!=='proposed')throw Error('Voice task unavailable');
  const task=this.#tasks.get(intent.taskId);if(!task||task.version!==intent.taskVersion||task.id!==intent.taskId)throw Error('Task definition changed');
  if(await digest({...intent,digest:'',status:'proposed'})!==intent.digest||canonical(task.validate(argumentsSnapshot(intent.args)))!==canonical(intent.args)||task.describe(structuredClone(intent.args))!==intent.summary)throw Error('Task proposal changed');
  const identity=await this.#identity(callSid);await this.#authorized(identity,intent,'voice.task.execute');
  const confirmation=await this.trust.consumeConfirmation({callSid,intentId:intent.id,digest:intent.digest,actor:identity.actor,sessionId:identity.sessionId});
  if(!confirmation||confirmation.approved!==true||!['app','dtmf','signed-speech'].includes(confirmation.method)||!Number.isSafeInteger(confirmation.approvedAt)||confirmation.approvedAt>Date.now()||confirmation.approvedAt<Date.now()-60000)throw new VoiceTaskConfirmationRequiredError();
  if(!await this.repository.claim(intent.id,intent.digest))throw Error('Task already attempted');
  try{
   await this.#authorized(await this.#identity(callSid),intent,'voice.task.execute');
   // Underlying service must recheck resource ownership/version/current permission
   // atomically and honor this stable idempotency key. No automatic retries here.
   await task.execute(identity.actor,argumentsSnapshot(intent.args),'voice-task:'+intent.id);
   await this.repository.finish(intent.id,'completed');return {status:'completed' as const};
  }catch{
   try{await this.repository.finish(intent.id,'unknown');}catch{}
   throw Error('Task outcome unknown; do not retry automatically');
  }
 }
}
export class PostgresVoiceTaskRepository implements VoiceTaskRepository {
 readonly pool:any;constructor(pool:any){if(typeof pool?.query!=='function')throw Error('Voice task database required');this.pool=pool;}
 async create(intent:VoiceTaskIntent){await this.pool.query('INSERT INTO communication_voice_tasks(id,digest,status,intent) VALUES($1,$2,$3,$4)',[intent.id,intent.digest,intent.status,JSON.stringify(intent)]);}
 async read(id:string){const rows=(await this.pool.query('SELECT intent,status FROM communication_voice_tasks WHERE id=$1',[id])).rows;return rows.length===1?{...rows[0].intent,status:rows[0].status}:null;}
 async claim(id:string,hash:string){const rows=(await this.pool.query("UPDATE communication_voice_tasks SET status='executing',updated_at=now() WHERE id=$1 AND digest=$2 AND status='proposed' AND (intent->>'expiresAt')::bigint>EXTRACT(EPOCH FROM now())*1000 RETURNING id",[id,hash])).rows;return rows.length===1;}
 async finish(id:string,status:'completed'|'unknown'){if(!['completed','unknown'].includes(status))throw Error('Invalid task state');const rows=(await this.pool.query("UPDATE communication_voice_tasks SET status=$2,updated_at=now() WHERE id=$1 AND status='executing' RETURNING id",[id,status])).rows;if(rows.length!==1)throw Error('Task state conflict');}
}
