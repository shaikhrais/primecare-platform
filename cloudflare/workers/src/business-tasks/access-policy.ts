import {assertActor,required,type Actor,type AccessPolicy,type RecordState} from '../../../../packages/shared/src/communications/service-base.ts';
import type {MailboxPolicy} from './mail.ts';
import definition from '../../../../tools/governance-production/communication-access-policy.json' with {type:'json'};
import pin from '../../../../tools/governance-production/production-pin.json' with {type:'json'};

type Client={query(sql:string,values?:any[]):Promise<{rows:Record<string,any>[]}>;release():void};
type Pool={connect():Promise<Client>};
type Mailbox={id:string;tenantId:string;address:string;ownerId:string;delegateIds:string[];recipientAddresses:string[];active:boolean;ownershipVerified:boolean};
const denied=():never=>{throw Error('Forbidden');};
const unavailable=():never=>{throw Error('Communication policy unavailable');};
const canonical=(value:any):string=>Array.isArray(value)?'['+value.map(canonical).join(',')+']':value&&typeof value==='object'?'{'+Object.keys(value).sort().map(key=>JSON.stringify(key)+':'+canonical(value[key])).join(',')+'}':JSON.stringify(value);
const keys=(value:any,expected:string[])=>value&&typeof value==='object'&&!Array.isArray(value)&&Object.keys(value).sort().join(',')===[...expected].sort().join(',');
const email=(value:unknown):value is string=>typeof value==='string'&&value.length<=254&&/^[^\s<>@\u0000-\u001f\u007f]+@[^\s<>@\u0000-\u001f\u007f]+\.[^\s<>@\u0000-\u001f\u007f]+$/.test(value);
const address=(value:string)=>{if(!email(value))denied();return value.toLowerCase();};
const metadata=(column:string)=>{
 const x=`to_jsonb(p)->'${column}'`;
 return `(CASE WHEN jsonb_typeof(${x})='string' THEN ${x}#>>'{}' WHEN ${x}->>'t'='text' AND jsonb_typeof(${x}->'v')='string' THEN ${x}->>'v' ELSE NULL END)`;
};

/** Native adapters share current policy loading, account checks and mailbox scope.
 * This base grants no API/screen permission and never writes governance or content.
 */
export abstract class PostgresCommunicationPolicyBase {
 readonly pool:Pool;
 constructor(pool:Pool){if(typeof pool?.connect!=='function')throw Error('Native policy database required');this.pool=pool;}
 protected async inspect<T>(work:(client:Client,mailboxes:Mailbox[])=>Promise<T>):Promise<T>{
  const db=await this.pool.connect();
  try{
   await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
   await db.query("SET LOCAL statement_timeout='10s'");
   const manifest=await db.query(`SELECT manifest_sha256 FROM "${pin.schema}"."${pin.manifestTable}"`);
   if(manifest.rows.length!==1||manifest.rows[0].manifest_sha256!==pin.manifestSha256)unavailable();
   const docs=await db.query(`SELECT ${metadata('id')} AS id,${metadata('definition')} AS definition,${metadata('requirement')} AS requirement
    FROM "${pin.schema}"."govt_platform_hierarchy_policy" p WHERE ${metadata('id')} IN ($1,$2)`,[definition.policy.id,definition.directory.id]);
   if(docs.rows.length!==2)unavailable();
   const parse=(id:string)=>{
    const rows=docs.rows.filter(row=>row.id===id);
    if(rows.length!==1||typeof rows[0].definition!=='string'||rows[0].definition.length>1048576)unavailable();
    try{const doc=JSON.parse(rows[0].definition);if(doc.requirement!==rows[0].requirement)unavailable();return doc;}catch{unavailable();}
   };
   if(canonical(parse(definition.policy.id))!==canonical(definition.policy))unavailable();
   const directory=parse(definition.directory.id);
   if(!keys(directory,Object.keys(definition.directory))||directory.id!==definition.directory.id||directory.version!==definition.directory.version||directory.requirement!==definition.directory.requirement||!Array.isArray(directory.mailboxes)||directory.mailboxes.length>1000)unavailable();
   const ids=new Set(),addresses=new Set();
   for(const box of directory.mailboxes){
    if(!keys(box,['id','tenantId','address','ownerId','delegateIds','recipientAddresses','active','ownershipVerified'])||typeof box.active!=='boolean'||typeof box.ownershipVerified!=='boolean')unavailable();
    try{for(const v of [box.id,box.tenantId,box.ownerId])required(v);}catch{unavailable();}
    if(!email(box.address)||box.address!==box.address.toLowerCase()||ids.has(box.id)||addresses.has(box.address))unavailable();
    ids.add(box.id);addresses.add(box.address);
    if(!Array.isArray(box.delegateIds)||box.delegateIds.length>1000||new Set(box.delegateIds).size!==box.delegateIds.length||!Array.isArray(box.recipientAddresses)||box.recipientAddresses.length>1000||new Set(box.recipientAddresses).size!==box.recipientAddresses.length)unavailable();
    try{box.delegateIds.forEach((id:unknown)=>required(id));}catch{unavailable();}
    if(box.recipientAddresses.some((v:unknown)=>!email(v)||v!==v.toLowerCase()))unavailable();
   }
   return await work(db,directory.mailboxes);
  }finally{try{await db.query('ROLLBACK');}finally{db.release();}}
 }
 protected async active(db:Client,actor:Actor){
  assertActor(actor);
  const result=await db.query(`SELECT u.id::text AS id FROM public.users u JOIN public.tenants t ON t.id=u.tenant_id
   WHERE u.id::text=$1 AND u.tenant_id::text=$2 AND LOWER(u.status)='active' AND LOWER(t.status)='active' LIMIT 2`,[actor.id,actor.tenantId]);
  if(result.rows.length!==1||result.rows[0].id!==actor.id)denied();
 }
 protected async owned(db:Client,box:Mailbox|undefined,tenantId?:string):Promise<Mailbox>{
  if(!box)throw Error('Forbidden');
  if(!box.active||!box.ownershipVerified||tenantId!==undefined&&box.tenantId!==tenantId)denied();
  await this.active(db,{id:box.ownerId,tenantId:box.tenantId});return box;
 }
 protected async accessible(db:Client,boxes:Mailbox[],actor:Actor,id:string){
  const box=await this.owned(db,boxes.find(box=>box.id===id),actor.tenantId);
  if(box.ownerId!==actor.id&&!box.delegateIds.includes(actor.id))denied();return box;
 }
}

/** Same native rules for every role/portal; endpoint grants remain a separate gate. */
export class PostgresCommunicationAccessPolicy extends PostgresCommunicationPolicyBase implements AccessPolicy {
 async assert(actor:Actor,action:string,state:RecordState|null):Promise<void>{
  assertActor(actor);actor={...actor};
  const allowed=['conversation.create','conversation.inbox','conversation.read','conversation.message','conversation.picture','conversation.call','mail.queue','mail.deliver','mail.read','mail.inbox','mail.receive'];
  if(!allowed.includes(action))denied();
  // Own the proposal before a native read can suspend this action.
  state=state===null?null:structuredClone(state);
  await this.inspect(async(db,boxes)=>{
   if(action==='mail.receive'){
    if(actor.id!==definition.policy.rules.inboundIdentity)denied();
    if(!state){const tenant=await db.query("SELECT id::text AS id FROM public.tenants WHERE id::text=$1 AND LOWER(status)='active' LIMIT 2",[actor.tenantId]);if(tenant.rows.length!==1)denied();return;}
    if(state.kind!=='inbound_mail'||state.tenantId!==actor.tenantId||state.status!=='quarantined'||state.senderIdentityVerified!==false)denied();
    const box=await this.owned(db,boxes.find(box=>box.id===state!.mailboxId),actor.tenantId);
    if(state.to!==box.address)denied();return;
   }
   await this.active(db,actor);
   if(!state){if(!['conversation.create','conversation.inbox','mail.queue'].includes(action))denied();return;}
   if(state.tenantId!==actor.tenantId)denied();
   if(action.startsWith('conversation.')){
    if(state.kind!=='conversation'||!Array.isArray(state.members)||state.members.length<2||state.members.length>1000||new Set(state.members).size!==state.members.length||!state.members.includes(actor.id))denied();
    state.members.forEach((member:unknown)=>required(member));required(state.businessReference);
    const members=await db.query(`SELECT u.id::text AS id FROM public.users u JOIN public.tenants t ON t.id=u.tenant_id
     WHERE u.id::text=ANY($1::text[]) AND u.tenant_id::text=$2 AND LOWER(u.status)='active' AND LOWER(t.status)='active'`,[state.members,actor.tenantId]);
    if(members.rows.length!==state.members.length||new Set(members.rows.map(row=>row.id)).size!==state.members.length)denied();
    if(state.businessReference===definition.policy.rules.generalReference)return;
    const linked=await db.query("SELECT state FROM public.business_work_aggregates WHERE tenant_id=$1 AND id=$2 AND state->>'kind'='workflow' LIMIT 2",[actor.tenantId,state.businessReference]);
    if(linked.rows.length!==1)denied();
    const task=linked.rows[0].state;
    if(task?.kind!=='workflow'||task.tenantId!==actor.tenantId||task.id!==state.businessReference)denied();
    const participants=definition.policy.rules.linkedParticipantFields.map(field=>task[field]);
    if(participants.some(id=>typeof id!=='string')||state.members.some((id:string)=>!participants.includes(id)))denied();
   }else if(state.kind==='outbound_mail'){
    if(state.ownerId!==actor.id)denied();
   }else if(state.kind==='inbound_mail'&&['mail.read','mail.inbox'].includes(action)){
    const box=await this.accessible(db,boxes,actor,state.mailboxId);
    if(action==='mail.read'&&state.to!==box.address)denied();
   }else denied();
  });
 }
 async assignee(actor:Actor,userId:string,responsibility:string):Promise<void>{
  assertActor(actor);required(userId);if(responsibility!=='communication')denied();actor={...actor};
  await this.inspect(async db=>{await this.active(db,actor);await this.active(db,{id:userId,tenantId:actor.tenantId});});
 }
}

/** Owned inbound routing and current owner/delegate/contact access from native metadata. */
export class PostgresCommunicationMailboxPolicy extends PostgresCommunicationPolicyBase implements MailboxPolicy {
 async resolve(value:string):Promise<{tenantId:string;mailboxId:string}|null>{
  const target=address(value);
  return this.inspect(async(db,boxes)=>{
   const configured=boxes.find(box=>box.address===target);
   if(!configured||!configured.active||!configured.ownershipVerified)return null;
   const box=await this.owned(db,configured);return {tenantId:box.tenantId,mailboxId:box.id};
  });
 }
 async access(actor:Actor,mailboxId:string):Promise<void>{
  assertActor(actor);required(mailboxId);actor={...actor};
  await this.inspect(async(db,boxes)=>{await this.active(db,actor);await this.accessible(db,boxes,actor,mailboxId);});
 }
 async recipient(actor:Actor,value:string):Promise<void>{
  assertActor(actor);actor={...actor};const target=address(value);
  await this.inspect(async(db,boxes)=>{
   await this.active(db,actor);
   // A known inactive/cross-tenant account cannot be relabelled an external contact.
   const accounts=await db.query('SELECT id::text AS id,tenant_id::text AS tenant_id FROM public.users WHERE LOWER(email)=$1 LIMIT 2',[target]);
   if(accounts.rows.length){
    if(accounts.rows.length!==1||accounts.rows[0].tenant_id!==actor.tenantId)denied();
    await this.active(db,{id:accounts.rows[0].id,tenantId:actor.tenantId});return;
   }
   for(const box of boxes){
    if(box.tenantId===actor.tenantId&&box.active&&box.ownershipVerified&&box.recipientAddresses.includes(target)&&(box.ownerId===actor.id||box.delegateIds.includes(actor.id))){await this.owned(db,box,actor.tenantId);return;}
   }
   denied();
  });
 }
}
