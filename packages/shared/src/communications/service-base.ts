/** Shared service contracts. No framework, role list, route or permissive policy default. */
export type Actor = Readonly<{id:string;tenantId:string}>;
export type RecordState = {id:string;tenantId:string;version:number;kind:string;[key:string]:any};
export type Command = {actor:Actor;id:string;key:string;expectedVersion:number;type:string;payload:unknown};
export type Change = {state:RecordState;event:string;result?:unknown};
export interface AtomicStore {
 run(command:Command,authorize:(state:RecordState|null)=>Promise<void>,apply:(state:RecordState|null)=>Promise<Change>):Promise<any>;
 read(actor:Actor,id:string,authorize:(state:RecordState)=>Promise<void>):Promise<RecordState>;
 inbox(actor:Actor,kind:'workflow'|'conversation',authorize:(state:RecordState)=>Promise<void>,limit?:number):Promise<RecordState[]>;
}
export interface AccessPolicy {
 /** Resolve authenticated identity, current registered permissions and restricted-case scope. */
 assert(actor:Actor,action:string,state:RecordState|null):Promise<void>;
 assignee(actor:Actor,userId:string,responsibility:string):Promise<void>;
}
export function required(value:unknown,max=200):asserts value is string {
 if(typeof value!=='string'||!value.trim()||value.length>max||/[\u0000-\u001f\u007f]/.test(value))throw Error('Invalid input');
}
export function assertActor(actor:Actor) {
 if(!actor||typeof actor!=='object')throw Error('Invalid actor');
 required(actor.id);required(actor.tenantId);
}

/** Services inherit tenant/type checks; a registered policy remains mandatory on every action. */
export abstract class ScopedServiceBase {
 readonly store:AtomicStore;
 readonly policy:AccessPolicy;
 constructor(store:AtomicStore,policy:AccessPolicy) {
  if(!store||typeof store.run!=='function'||typeof store.read!=='function'||typeof store.inbox!=='function'||!policy||typeof policy.assert!=='function'||typeof policy.assignee!=='function')throw Error('Scoped service adapters required');
  this.store=store;this.policy=policy;
 }
 protected async checkAccess(actor:Actor,action:string,state:RecordState|null,kinds:readonly string[],creating=false) {
  assertActor(actor);required(action);
  if(state&&(state.tenantId!==actor.tenantId||!kinds.includes(state.kind))||!state&&!creating)throw Error('Not found');
  await this.policy.assert(actor,action,state);
 }
 /** Initial scope must be visible to current policy, including idempotent retries.
  * A policy receives an isolated copy so it cannot rewrite the stored proposal.
  */
 protected async checkCreation(actor:Actor,action:string,state:RecordState|null,draft:RecordState,kinds:readonly string[],authorizeCurrent?:(state:RecordState|null)=>Promise<void>) {
  assertActor(actor);
  if(draft.tenantId!==actor.tenantId||!kinds.includes(draft.kind)||draft.version!==0||state&&(state.id!==draft.id||state.tenantId!==actor.tenantId||!kinds.includes(state.kind)))throw Error('Not found');
  if(authorizeCurrent)await authorizeCurrent(state);else await this.checkAccess(actor,action,state,kinds,true);
  await this.checkAccess(actor,action,structuredClone(draft),kinds);
 }
}

/** Common channel protocol. Only authenticated server context supplies actor. */
export abstract class CommunicationChannelBase<TRequest,TResult> {
 abstract readonly channel:'message'|'picture'|'audio'|'email';
 async execute(actor:Actor,request:TRequest):Promise<TResult> {
  assertActor(actor);
  if(!request||typeof request!=='object'||Array.isArray(request))throw Error('Invalid channel request');
  if(['actor','actorId','tenantId','roles'].some(field=>Object.hasOwn(request,field)))throw Error('Identity belongs to server context');
  return this.perform(actor,request);
 }
 protected abstract perform(actor:Actor,request:TRequest):Promise<TResult>;
}
