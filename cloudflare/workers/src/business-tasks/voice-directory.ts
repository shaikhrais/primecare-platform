import {ScopedServiceBase,required,type AtomicStore,type AccessPolicy,type Actor,type RecordState} from '../../../../packages/shared/src/communications/service-base.ts';
import type {TwilioExtensionDirectory,PublishedVoiceDestination} from '../../../../packages/shared/src/communications/twilio-voice.mjs';
import type {VoiceTokenDirectory} from './twilio-token.ts';
type DirectoryRow=PublishedVoiceDestination&{version:number};
type VoiceRegistry={assign(actor:Actor,userId:string,authorize:(row:DirectoryRow)=>Promise<void>):Promise<DirectoryRow>;publish(actor:Actor,userId:string,version:number,published:boolean,authorize:(row:DirectoryRow)=>Promise<void>):Promise<DirectoryRow>};
/** Reuses the same tenant/type/policy base as all communication services.
 * Assignment never grants permissions or publishes a real destination.
 */
export class VoiceExtensionService extends ScopedServiceBase{
 readonly registry:VoiceRegistry;
 constructor(store:AtomicStore,policy:AccessPolicy,registry:VoiceRegistry){super(store,policy);if(typeof registry?.assign!=='function'||typeof registry?.publish!=='function')throw Error('Voice registry required');this.registry=registry;}
 async #authorize(actor:Actor,action:string,row:DirectoryRow){
  if(row.userId===undefined||row.tenantActive!==true||row.userActive!==true)throw Error('Voice destination unavailable');
  const state:RecordState={id:'voice:'+row.userId,tenantId:row.tenantId,version:row.version,kind:'voice_destination',userId:row.userId,extension:row.extension,published:row.published,active:row.active};
  await this.checkAccess(actor,action,state,['voice_destination']);await this.policy.assignee(actor,row.userId,'voice');
 }
 async assign(actor:Actor,userId:string){
  required(userId);const owner=Object.freeze({id:actor.id,tenantId:actor.tenantId});
  return this.registry.assign(owner,userId,row=>this.#authorize(owner,'voice.extension.assign',row));
 }
 async publish(actor:Actor,userId:string,version:number,published:boolean){
  required(userId);if(!Number.isSafeInteger(version)||version<1||version>=Number.MAX_SAFE_INTEGER||typeof published!=='boolean')throw Error('Invalid publication');
  const owner=Object.freeze({id:actor.id,tenantId:actor.tenantId});
  return this.registry.publish(owner,userId,version,published,row=>this.#authorize(owner,'voice.extension.publish',row));
 }
}
const select=`SELECT v.extension,v.tenant_id AS "tenantId",v.user_id AS "userId",v.published,v.active,v.version::text AS version,
 (LOWER(t.status)='active') AS "tenantActive",(LOWER(u.status)='active' AND u.tenant_id::text=v.tenant_id) AS "userActive"
 FROM communication_voice_extensions v JOIN users u ON u.id::text=v.user_id JOIN tenants t ON t.id::text=v.tenant_id`;
function snapshot(row:any):DirectoryRow{
 return {extension:row.extension,tenantId:row.tenantId,userId:row.userId,published:row.published,active:row.active,tenantActive:row.tenantActive,userActive:row.userActive,version:Number(row.version)};
}
/** Trusted provider and session directory. Every lookup joins current native users
 * and tenants. SQL parameters, never a caller-supplied tenant override, select scope.
 */
export class PostgresVoiceDirectory implements TwilioExtensionDirectory,VoiceTokenDirectory,VoiceRegistry{
 readonly pool:any;
 constructor(pool:any){if(typeof pool?.query!=='function'||typeof pool?.connect!=='function')throw Error('Voice directory database required');this.pool=pool;}
 async lookup(extension:string,limit:2){
  if(!/^[1-9][0-9]{3}$/.test(extension)||limit!==2)throw Error('Invalid voice lookup');
  return (await this.pool.query(select+' WHERE v.extension=$1 LIMIT 2',[extension])).rows.map(snapshot);
 }
 async destinations(actor:Actor,limit:2){
  required(actor.id);required(actor.tenantId);if(limit!==2)throw Error('Invalid voice lookup');
  return (await this.pool.query(select+' WHERE v.tenant_id=$1 AND v.user_id=$2 LIMIT 2',[actor.tenantId,actor.id])).rows.map(snapshot);
 }
 /** id is the trusted server-side token hash, never a raw bearer token or user ID. */
 async currentSession(id:string){
  if(typeof id!=='string'||! /^[a-f0-9]{64}$/.test(id))return null;
  const rows=(await this.pool.query(`SELECT s.token_hash AS id,u.id::text AS "userId",u.tenant_id::text AS "tenantId",
   FLOOR(EXTRACT(EPOCH FROM s.expires_at)*1000)::text AS "expiresAt"
   FROM auth_sessions s JOIN users u ON u.id=s.user_id JOIN tenants t ON t.id=u.tenant_id
   WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' AND LOWER(t.status)='active' LIMIT 2`,[id])).rows;
  if(rows.length!==1)return null;const row=rows[0];
  return {id:row.id,userId:row.userId,tenantId:row.tenantId,expiresAt:Number(row.expiresAt),active:true};
 }
 async #transaction(actor:Actor,userId:string,action:(db:any)=>Promise<DirectoryRow>){
  required(actor.id);required(actor.tenantId);required(userId);
  const db=await this.pool.connect();
  try{
   await db.query('BEGIN');
   await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',[JSON.stringify(['voice-extension',actor.tenantId,userId])]);
   // Lock current directory rows so deletion/deactivation cannot race assignment.
   const current=(await db.query(`SELECT u.id FROM users u JOIN tenants t ON t.id=u.tenant_id
    WHERE u.id::text=$1 AND u.tenant_id::text=$2 AND LOWER(u.status)='active' AND LOWER(t.status)='active' FOR SHARE OF u,t`,[userId,actor.tenantId])).rows;
   if(current.length!==1)throw Error('Voice destination unavailable');
   const result=await action(db);await db.query('COMMIT');return result;
  }catch(error){await db.query('ROLLBACK');throw error;}finally{db.release();}
 }
 async assign(actor:Actor,userId:string,authorize:(row:DirectoryRow)=>Promise<void>){
  required(actor.id);required(actor.tenantId);required(userId);
  const existing=(await this.pool.query(select+' WHERE v.tenant_id=$1 AND v.user_id=$2 LIMIT 2',[actor.tenantId,userId])).rows;
  if(existing.length>1)throw Error('Ambiguous voice destination');
  const extension=existing.length?existing[0].extension:String((await this.pool.query("SELECT nextval('communication_voice_extension_seq') AS extension")).rows[0].extension);
  if(!/^[1-9][0-9]{3}$/.test(extension))throw Error('Voice extension capacity exhausted');
  const proposed:DirectoryRow=existing.length?snapshot(existing[0]):{extension,tenantId:actor.tenantId,userId,published:false,active:true,tenantActive:true,userActive:true,version:1};
  // Policy adapters may need their own pool connection. Authorize the exact
  // proposal before acquiring transaction locks, then compare its version.
  await authorize(Object.freeze({...proposed}));
  return this.#transaction(actor,userId,async db=>{
   const rows=(await db.query(select+' WHERE v.tenant_id=$1 AND v.user_id=$2 FOR UPDATE OF v',[actor.tenantId,userId])).rows;
   if(existing.length){if(rows.length!==1||rows[0].extension!==proposed.extension||Number(rows[0].version)!==proposed.version)throw Error('Voice destination version conflict');return snapshot(rows[0]);}
   if(rows.length)throw Error('Voice destination version conflict');
   await db.query('INSERT INTO communication_voice_extensions(extension,tenant_id,user_id) VALUES($1,$2,$3)',[extension,actor.tenantId,userId]);return proposed;
  });
 }
 async publish(actor:Actor,userId:string,version:number,published:boolean,authorize:(row:DirectoryRow)=>Promise<void>){
  required(actor.id);required(actor.tenantId);required(userId);
  if(!Number.isSafeInteger(version)||version<1||version>=Number.MAX_SAFE_INTEGER||typeof published!=='boolean')throw Error('Invalid publication');
  const initial=(await this.pool.query(select+' WHERE v.tenant_id=$1 AND v.user_id=$2 LIMIT 2',[actor.tenantId,userId])).rows;
  if(initial.length!==1)throw Error('Voice destination unavailable');const row=snapshot(initial[0]);
  if(row.version!==version||!row.active)throw Error('Voice destination version conflict');
  const proposed={...row,published,version:version+1};await authorize(Object.freeze({...proposed}));
  return this.#transaction(actor,userId,async db=>{
   const rows=(await db.query(select+' WHERE v.tenant_id=$1 AND v.user_id=$2 FOR UPDATE OF v',[actor.tenantId,userId])).rows;
   if(rows.length!==1||rows[0].extension!==row.extension||Number(rows[0].version)!==version||rows[0].active!==true)throw Error('Voice destination version conflict');
   await db.query('UPDATE communication_voice_extensions SET published=$1,version=version+1 WHERE extension=$2',[published,row.extension]);return proposed;
  });
 }
}
