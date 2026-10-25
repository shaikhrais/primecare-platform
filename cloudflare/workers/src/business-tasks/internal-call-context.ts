import {PostgresCommunicationSession,CommunicationSessionError} from './session.ts';
import {tokenFrom,sha256} from '../session-token.ts';
import {assertRegisteredPermissionRows} from './endpoint-policy.ts';
import {PostgresInternalCallPolicy,internalCallDirectoryScope} from './internal-call-application.ts';
import {validateCommunicationPolicyDocuments,conversationActions,assertConversationShape,assertConversationParticipants} from './access-policy.ts';
import {PostgresAtomicStore} from './store.ts';
import {assertActor,required,type Actor,type RecordState} from '../../../../packages/shared/src/communications/service-base.ts';
import definition from '../../../../tools/governance-production/internal-call-contracts-registration.json' with {type:'json'};
import contextQuery from '../../../../packages/shared/src/communications/internal-call-context-query.mjs';
import pin from '../../../../tools/governance-production/production-pin.json' with {type:'json'};
type Snapshot={actor:Actor;policies:Record<string,any>[];activeActor:boolean;members:string[];records:RecordState[];linked:RecordState[]};
type Database={query(sql:string,values?:any[]):Promise<{rows:Record<string,any>[]}>};
/** One SQL statement gives each check a fresh PostgreSQL snapshot. This object
 * belongs to one HTTP request; it never retains session or permission decisions. */
export class PostgresInternalCallContext extends PostgresCommunicationSession {
 readonly request:Request;
 private readonly receipts=new WeakMap<RecordState,Snapshot>();
 constructor(database:Database,request:Request){super(database);this.request=request;}
 async current(request:Request,key:string){
  if(request!==this.request)throw new CommunicationSessionError(401);
  return (await this.snapshot(undefined,{},key)).actor;
 }
 async snapshot(expected?:Actor,scope:{id?:string;members?:string[];reference?:string}={},key?:string):Promise<Snapshot>{
  const request=this.request,op=definition.operations.find(o=>o.path===new URL(request.url).pathname);
  if(!op||op.method!==request.method||key!==undefined&&op.key!==key)throw Error('Forbidden');
  const token=request.headers.has('authorization')?tokenFrom(request):null;if(!token)throw new CommunicationSessionError(401);
  const {rows}=await this.database.query(contextQuery,[await sha256(token),op.method,op.path,'INTERNAL_'+op.key.replaceAll('.','_').toUpperCase(),scope.id??null,scope.members??null,scope.reference??null]);
  const c:any=rows.length===1?rows[0].context:null;
  if(!c||typeof c!=='object'||!Array.isArray(c.identity))throw Error('Communication policy unavailable');
  const actor=this.actorFromRows(c.identity,request);
  if(expected&&(actor.id!==expected.id||actor.tenantId!==expected.tenantId))throw new CommunicationSessionError(401);
  if(!Array.isArray(c.manifest)||c.manifest.length!==1||c.manifest[0]?.manifest_sha256!==pin.manifestSha256)throw Error('Governance manifest mismatch');
  assertRegisteredPermissionRows(c.grants);
  for(const field of ['policies','members','records','linked'])if(!Array.isArray(c[field]))throw Error('Communication policy unavailable');
  if(c.policies.length>2||c.members.length>1000||c.records.length>2||c.linked.length>2||typeof c.activeActor!=='boolean'||c.members.some((id:unknown)=>typeof id!=='string'))throw Error('Communication policy unavailable');
  return {actor,policies:c.policies,activeActor:c.activeActor,members:c.members,records:c.records,linked:c.linked};
 }
 // A read receipt is consumed only by its immediate authorization callback.
 // It cannot authorize a later command, another object, or another request.
 offer(state:RecordState,snapshot:Snapshot){this.receipts.set(state,snapshot);}
 discard(state:RecordState){this.receipts.delete(state);}
 consume(state:RecordState,actor:Actor,action:string){
  const snapshot=this.receipts.get(state);this.receipts.delete(state);
  return action==='conversation.read'&&snapshot?.actor.id===actor.id&&snapshot.actor.tenantId===actor.tenantId?snapshot:undefined;
 }
}
/** Inherits the existing call policy, sharing its validators and source rules. */
export class PostgresInternalCallContextPolicy extends PostgresInternalCallPolicy {
 readonly context:PostgresInternalCallContext;
 constructor(pool:ConstructorParameters<typeof PostgresInternalCallPolicy>[0],context:PostgresInternalCallContext){super(pool);this.context=context;}
 private check(snapshot:Snapshot){validateCommunicationPolicyDocuments(snapshot.policies);if(!snapshot.activeActor)throw Error('Forbidden');}
 override async assert(actor:Actor,action:string,state:RecordState|null){
  assertActor(actor);const a={id:actor.id,tenantId:actor.tenantId};
  if(['internal.call.directory','internal.call.extension'].includes(action)){
   internalCallDirectoryScope(a,action,state);this.check(await this.context.snapshot(a));return;
  }
  if(!(conversationActions as readonly string[]).includes(action))throw Error('Forbidden');
  const receipt=state?this.context.consume(state,a,action):undefined,s=state===null?null:structuredClone(state);
  if(s)assertConversationShape(a,s);
  else if(!['conversation.create','conversation.inbox'].includes(action))throw Error('Forbidden');
  const snapshot=receipt??await this.context.snapshot(a,s?{id:s.id,members:s.members,reference:s.businessReference}:{});
  this.check(snapshot);if(s)assertConversationParticipants(a,s,snapshot.members,snapshot.linked);
 }
 override async assignee(actor:Actor,userId:string,responsibility:string){
  assertActor(actor);required(userId);if(responsibility!=='communication')throw Error('Forbidden');
  const snapshot=await this.context.snapshot({...actor},{members:[userId]});this.check(snapshot);
  if(snapshot.members.length!==1||snapshot.members[0]!==userId)throw Error('Forbidden');
 }
}
/** Mutation transactions, advisory locks and idempotency remain inherited. */
export class PostgresInternalCallContextStore extends PostgresAtomicStore {
 readonly context:PostgresInternalCallContext;
 constructor(pool:any,context:PostgresInternalCallContext){super(pool);this.context=context;}
 override async read(actor:Actor,id:string,authorize:(state:RecordState)=>Promise<void>){
  assertActor(actor);required(id);if(!id.startsWith('internal-call:'))throw Error('Not found');
  const snapshot=await this.context.snapshot({...actor},{id});if(snapshot.records.length!==1)throw Error('Not found');
  const state=snapshot.records[0];if(state?.id!==id)throw Error('Not found');
  this.context.offer(state,snapshot);try{await authorize(state);return state;}finally{this.context.discard(state);}
 }
}
