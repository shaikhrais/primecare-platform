/** Isolated domain-test fixture only. Never imported by runtime services. */
import {commandValid,fingerprint} from '../../cloudflare/workers/src/business-tasks/store.ts';
export class MemoryAtomicStore {
 states=new Map();commands=new Map();locks=new Map();events=[];
 async run(command,authorize,apply) {
  commandValid(command);
  const id=JSON.stringify([command.actor.tenantId,command.id]);
  const prior=this.locks.get(id)??Promise.resolve();
  let unlock;const gate=new Promise(resolve=>{unlock=resolve;});
  this.locks.set(id,prior.then(()=>gate));await prior;
  try {
   const state=structuredClone(this.states.get(id)??null);await authorize(state);
   const hash=await fingerprint(command),cache=id+':'+command.key,previous=this.commands.get(cache);
   if(previous) {
    if(previous.actor!==command.actor.id||previous.hash!==hash)throw Error('Idempotency conflict');
    return structuredClone(previous.result);
   }
   if((state?.version??0)!==command.expectedVersion)throw Error('Version conflict');
   const change=await apply(state);
   if(change.state.id!==command.id||change.state.tenantId!==command.actor.tenantId)throw Error('Scope conflict');
   change.state.version=command.expectedVersion+1;
   const result=change.result??{id:command.id,version:change.state.version};
   this.states.set(id,structuredClone(change.state));this.commands.set(cache,{actor:command.actor.id,hash,result:structuredClone(result)});
   this.events.push({id:command.id,event:change.event,version:change.state.version});
   return structuredClone(result);
  } finally {unlock();}
 }
 async read(actor,id,authorize) {
  const state=structuredClone(this.states.get(JSON.stringify([actor.tenantId,id])));
  if(!state)throw Error('Not found');await authorize(state);return state;
 }
 async inbox(actor,kind,authorize,limit=50) {
  if(!['workflow','conversation'].includes(kind)||!Number.isSafeInteger(limit)||limit<1||limit>100)throw Error('Invalid inbox');
  const states=[...this.states.values()].filter(state=>state.tenantId===actor.tenantId&&state.kind===kind&&(kind==='workflow'?[state.ownerId,state.reviewerId,state.originatorId].includes(actor.id):state.members.includes(actor.id))).sort((a,b)=>a.id.localeCompare(b.id)).slice(0,limit);
  for(const state of states)await authorize(state);return structuredClone(states);
 }
 async mailInbox(actor,direction,mailboxId,authorize,limit=50,after) {
  if(!['inbound','outbound'].includes(direction)||!Number.isSafeInteger(limit)||limit<1||limit>100||direction==='outbound'&&mailboxId!==undefined)throw Error('Invalid inbox');
  const kind=direction==='inbound'?'inbound_mail':'outbound_mail';
  const records=[...this.states.values()].filter(state=>state.tenantId===actor.tenantId&&state.kind===kind&&(direction==='inbound'?state.mailboxId===mailboxId:state.ownerId===actor.id)&&(!after||state.id>after)).sort((a,b)=>a.id<b.id?-1:a.id>b.id?1:0).slice(0,limit+1);
  const headers=records.map(state=>Object.fromEntries(['id','tenantId','version','kind','ownerId','mailboxId','status','from','to','subject'].filter(key=>Object.hasOwn(state,key)).map(key=>[key,structuredClone(state[key])])));
  for(const state of headers)await authorize(state);
  const items=headers.slice(0,limit);return {items,nextAfter:headers.length>limit?items.at(-1).id:null};
 }
}
