import type {Actor} from './store.ts';
import {assertActor} from '../../../../packages/shared/src/communications/service-base.ts';
import contacts from '../../../../tools/governance-production/voice-contact-contracts-registration.json' with {type:'json'};
import voice from '../../../../tools/governance-production/twilio-contracts-registration.json' with {type:'json'};
import type {NativeVoiceSession} from '../../../../packages/shared/src/communications/voice-native-http.mjs';
import catalog from '../../../../packages/shared/src/communications/registered-contracts.json' with {type:'json'};
import pin from '../../../../tools/governance-production/production-pin.json' with {type:'json'};

type Client={query(sql:string,values?:(string|null)[]):Promise<{rows:Record<string,unknown>[]}>;release():void};
type Pool={connect():Promise<Client>};
// Imported metadata contains both native scalars and explicitly tagged values.
// Missing, wrong-type and unknown-tag values yield NULL and cannot grant access.
const value=(alias:string,column:string)=>{
 const x=`to_jsonb(${alias})->'${column}'`;
 return `(CASE WHEN jsonb_typeof(${x}) IN ('string','number') THEN ${x}#>>'{}'
 WHEN jsonb_typeof(${x})='object' AND ${x}->>'t' IN ('text','integer') AND jsonb_typeof(${x}->'v')='string' THEN ${x}->>'v' ELSE NULL END)`;
};
const table=(name:string)=>`"${pin.schema}"."govt_${name}"`;
/** Current explicit API AND linked-screen grants. Does not confer case/mailbox access. */
export abstract class PostgresRegisteredCommunicationEndpointPolicy {
 readonly pool:Pool;
 constructor(pool:Pool){if(typeof pool?.connect!=='function')throw Error('Governance pool required');this.pool=pool;}
 protected async authorizeRegistered(actor:Actor,apiId:number|null,method:string,path:string,endpointCode:string|null=null):Promise<void>{
  assertActor(actor);
  const client=await this.pool.connect();
  try{
   await client.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
   await client.query("SET LOCAL statement_timeout='10s'");
   const manifest=await client.query(`SELECT manifest_sha256 FROM "${pin.schema}"."${pin.manifestTable}"`);
   if(manifest.rows.length!==1||manifest.rows[0].manifest_sha256!==pin.manifestSha256)throw Error('Governance manifest mismatch');
   const result=await client.query(`SELECT DISTINCT ${value('r','id')} AS role_id,${value('s','id')} AS screen_id,${value('a','id')} AS api_id
    FROM public.users u
    JOIN ${table('roles')} r ON ${value('r','role_code')}=u.roles::text AND ${value('r','active')}='1'
    JOIN ${table('api_permissions')} ap ON ${value('ap','role_id')}=${value('r','id')} AND ${value('ap','can_access')}='1' AND ${value('ap','permission_key')}='role_screen_permissions'
    JOIN ${table('api_endpoints')} a ON ${value('a','id')}=${value('ap','api_id')}
    JOIN ${table('screen_api_links')} l ON ${value('l','api_id')}=${value('a','id')}
    JOIN ${table('screens')} s ON ${value('s','id')}=${value('l','screen_id')} AND ${value('s','active')}='1'
    JOIN ${table('role_screen_permissions')} sp ON ${value('sp','screen_id')}=${value('s','id')} AND ${value('sp','role_id')}=${value('r','id')} AND ${value('sp','can_view')}='1'
    WHERE u.id::text=$1 AND u.tenant_id::text=$2 AND LOWER(u.status)='active'
    AND ($3::text IS NULL OR ${value('a','id')}=$3) AND ${value('a','http_method')}=$4 AND ${value('a','route_path')}=$5
    AND ${value('a','service_name')}='governance' AND ${value('a','auth_required')}='1'
    AND ${value('a','permission_key')}='role_screen_permissions'
    AND ${value('s','id')} IN ('234','331','559','578')
    ${endpointCode===null?'':`AND ${value('a','endpoint_code')}=$6 AND EXISTS (SELECT 1 FROM public.tenants t WHERE t.id=u.tenant_id AND LOWER(t.status)='active')
    AND (SELECT COUNT(*) FROM ${table('api_endpoints')} duplicate WHERE ${value('duplicate','http_method')}=$4 AND ${value('duplicate','route_path')}=$5 AND ${value('duplicate','service_name')}='governance')=1`} LIMIT 2`,
    [actor.id,actor.tenantId,apiId===null?null:String(apiId),method,path,...(endpointCode===null?[]:[endpointCode])]);
   if(!result.rows.length||result.rows.some(row=>typeof row.role_id!=='string'||typeof row.screen_id!=='string'))throw Error('Forbidden');
   if(apiId===null&&(result.rows.some(row=>typeof row.api_id!=='string'||! /^[1-9][0-9]*$/.test(row.api_id))||new Set(result.rows.map(row=>row.api_id)).size!==1))throw Error('Forbidden');
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
  return this.authorizeRegistered(session.actor,null,contract.method,contract.path,(contact?'VOICE_':'TWILIO_')+key.replaceAll('.','_').toUpperCase());
 }
}
