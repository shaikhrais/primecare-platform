import externalCalls from '../../../../tools/governance-production/external-call-registration.json' with {type:'json'};
import type {Actor} from './store.ts';
import {assertActor} from '../../../../packages/shared/src/communications/service-base.ts';
import platformContact from '../../../../tools/governance-production/voice-contact-platform-registration.json' with {type:'json'};
import contactAccess from '../../../../tools/governance-production/voice-contact-access-registration.json' with {type:'json'};
import contacts from '../../../../tools/governance-production/voice-contact-contracts-registration.json' with {type:'json'};
import voice from '../../../../tools/governance-production/twilio-contracts-registration.json' with {type:'json'};
import type {NativeVoiceSession} from '../../../../packages/shared/src/communications/voice-native-http.mjs';
import catalog from '../../../../packages/shared/src/communications/registered-contracts.json' with {type:'json'};
import pin from '../../../../tools/governance-production/production-pin.json' with {type:'json'};

type Client={query(sql:string,values?:(string|null)[]):Promise<{rows:Record<string,unknown>[]}>;release():void};
type Pool={connect():Promise<Client>};
// Imported metadata contains both native scalars and explicitly tagged values.
// Missing, wrong-type and unknown-tag values yield NULL and cannot grant access.
export const registeredMetadataValue=(alias:string,column:string)=>{
 // Convert only the required field. Serializing an entire API row repeatedly
 // also serializes its large schemas, making current permission rechecks slow.
 const x=`to_jsonb(${alias}."${column}")`;
 return `(CASE WHEN jsonb_typeof(${x}) IN ('string','number') THEN ${x}#>>'{}'
 WHEN jsonb_typeof(${x})='object' AND ${x}->>'t' IN ('text','integer') AND jsonb_typeof(${x}->'v')='string' THEN ${x}->>'v' ELSE NULL END)`;
};
const table=(name:string)=>`"${pin.schema}"."govt_${name}"`;
/** The platform host may authorize only the three exact self-contact APIs.
 * This selects a registered screen, never a role or an access bypass. */
export function isPlatformOwnContactEndpoint(apiId:number|null,method:string,path:string,endpointCode:string|null):boolean {
 const index=contacts.operations.findIndex(op=>op.method===method&&op.path===path&&endpointCode==='VOICE_'+op.key.replaceAll('.','_').toUpperCase());
 return index>=0&&(apiId===null||apiId===platformContact.apiIds[index]);
}
/** Platform host may link only the same registered native phone-call APIs.
 * A current explicit API AND platform-screen grant are still required. */
export function isPlatformExternalCallEndpoint(apiId:number|null,method:string,path:string,endpointCode:string|null):boolean {
 const op=externalCalls.operations.find(o=>o.authentication==='native-session-csrf'&&o.method===method&&o.path===path);
 return !!op&&endpointCode==='EXTERNAL_'+op.key.replaceAll('.','_').toUpperCase();
}
export function registeredPermissionQuery(actor:Actor,apiId:number|null,method:string,path:string,endpointCode:string|null,value=registeredMetadataValue,idParameter='$3',allowedRoles:readonly string[]|null=null){
 assertActor(actor);if(allowedRoles&&(!allowedRoles.length||allowedRoles.some(r=>! /^[a-z][a-z0-9_]{0,79}$/.test(r))))throw Error('Invalid role policy');return {text:`SELECT DISTINCT (${value('r','id')})::text AS role_id,(${value('s','id')})::text AS screen_id,(${value('a','id')})::text AS api_id
    FROM public.users u
    JOIN ${table('roles')} r ON ${value('r','role_code')}=u.roles::text AND ${value('r','active')}='1'
    JOIN ${table('api_permissions')} ap ON ${value('ap','role_id')}=${value('r','id')} AND ${value('ap','can_access')}='1' AND ${value('ap','permission_key')}='role_screen_permissions'
    JOIN ${table('api_endpoints')} a ON ${value('a','id')}=${value('ap','api_id')}
    JOIN ${table('screen_api_links')} l ON ${value('l','api_id')}=${value('a','id')}
    JOIN ${table('screens')} s ON ${value('s','id')}=${value('l','screen_id')} AND ${value('s','active')}='1'
    JOIN ${table('role_screen_permissions')} sp ON ${value('sp','screen_id')}=${value('s','id')} AND ${value('sp','role_id')}=${value('r','id')} AND ${value('sp','can_view')}='1'
    WHERE u.id::text=$1 AND u.tenant_id::text=$2 AND LOWER(u.status)='active'
    AND ($3::text IS NULL OR ${value('a','id')}=${idParameter}) AND ${value('a','http_method')}=$4 AND ${value('a','route_path')}=$5
    AND ${value('a','service_name')}='governance' AND ${value('a','auth_required')}='1'
    AND ${value('a','permission_key')}='role_screen_permissions'
    AND (${value('s','id')} IN ('234','331','559','578')${isPlatformOwnContactEndpoint(apiId,method,path,endpointCode)?` OR (${value('s','id')}='${platformContact.screenId}' AND ${value('a','id')}='${platformContact.apiIds[contacts.operations.findIndex(op=>op.method===method&&op.path===path)]}')`:''}${isPlatformExternalCallEndpoint(apiId,method,path,endpointCode)?` OR ${value('s','id')}='1269'`:''})
    ${allowedRoles?`AND u.roles::text IN (${allowedRoles.map(r=>"'"+r+"'").join(',')})`:''}
    ${endpointCode===null?'':`AND ${value('a','endpoint_code')}=$6 AND EXISTS (SELECT 1 FROM public.tenants t WHERE t.id=u.tenant_id AND LOWER(t.status)='active')
    AND (SELECT COUNT(*) FROM ${table('api_endpoints')} duplicate WHERE ${value('duplicate','http_method')}=$4 AND ${value('duplicate','route_path')}=$5 AND ${value('duplicate','service_name')}='governance')=1`} LIMIT 2`,values:[actor.id,actor.tenantId,apiId===null?null:String(apiId),method,path,...(endpointCode===null?[]:[endpointCode])]};
}
export function assertRegisteredPermissionRows(rows:Record<string,unknown>[],apiId:number|null=null){
 if(!Array.isArray(rows)||!rows.length||rows.some(row=>typeof row.role_id!=='string'||typeof row.screen_id!=='string'))throw Error('Forbidden');
 if(apiId===null&&(rows.some(row=>typeof row.api_id!=='string'||! /^[1-9][0-9]*$/.test(row.api_id))||new Set(rows.map(row=>row.api_id)).size!==1))throw Error('Forbidden');
}

/** Current explicit API AND linked-screen grants. Does not confer case/mailbox access. */
export abstract class PostgresRegisteredCommunicationEndpointPolicy {
 readonly pool:Pool;
 constructor(pool:Pool){if(typeof pool?.connect!=='function')throw Error('Governance pool required');this.pool=pool;}
 protected metadataValue(alias:string,column:string){return registeredMetadataValue(alias,column);}
 protected apiIdParameter(){return '$3';}
 protected permittedRoleCodes():readonly string[]|null{return null;}
 protected async authorizeRegistered(actor:Actor,apiId:number|null,method:string,path:string,endpointCode:string|null=null):Promise<void>{
  assertActor(actor);const value=(alias:string,column:string)=>this.metadataValue(alias,column);
  const client=await this.pool.connect();
  try{
   await client.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
   await client.query("SET LOCAL statement_timeout='10s'");
   const manifest=await client.query(`SELECT manifest_sha256 FROM "${pin.schema}"."${pin.manifestTable}"`);
   if(manifest.rows.length!==1||manifest.rows[0].manifest_sha256!==pin.manifestSha256)throw Error('Governance manifest mismatch');
   const statement=registeredPermissionQuery(actor,apiId,method,path,endpointCode,value,this.apiIdParameter(),this.permittedRoleCodes());const result=await client.query(statement.text,statement.values);
   assertRegisteredPermissionRows(result.rows,apiId);
  }finally{try{await client.query('ROLLBACK');}finally{client.release();}}
 }
}

/** Existing messaging contracts retain their explicit registered API IDs. */
export class PostgresCommunicationEndpointPolicy extends PostgresRegisteredCommunicationEndpointPolicy {
 async authorize(actor:Actor,apiId:number,request:Request):Promise<void>{
  const contract=catalog.apis.find(api=>api.id===apiId);
  if(!contract||contract.method!==request.method||contract.path!==new URL(request.url).pathname)throw Error('Forbidden');
  return this.authorizeRegistered(actor,apiId,contract.method,contract.path);
 }
}
/** Native voice permissions use the registered operation identity. Provider-signed
 * routes never acquire user grants through this adapter. No role is hardcoded. */
export class PostgresVoiceEndpointPolicy extends PostgresRegisteredCommunicationEndpointPolicy {
 async authorize(session:NativeVoiceSession,key:string,request:Request):Promise<void>{
  const contact=contacts.operations.find(op=>op.key===key);
  const contract=contact??voice.operations.find(op=>op.key===key);
  const url=new URL(request.url);
  if(!contract||contract.authentication!=='native-session-csrf'||contract.permission!=='role_screen_permissions'||contract.method!==request.method||contract.path!==url.pathname||url.search||url.hash||!request.headers.has('authorization')||request.headers.get('authorization')?.startsWith('Bearer ')!==true||! /^[a-f0-9]{64}$/.test(session?.sessionHash)||!Number.isSafeInteger(session.expiresAt)||session.expiresAt<=Date.now())throw Error('Forbidden');
  return this.authorizeRegistered(session.actor,contact?contactAccess.apiIds[contact.key as keyof typeof contactAccess.apiIds]:null,contract.method,contract.path,(contact?'VOICE_':'TWILIO_')+key.replaceAll('.','_').toUpperCase());
 }
}
