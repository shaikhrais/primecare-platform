import type {Actor} from './store.ts';
import catalog from '../../../../packages/shared/src/communications/registered-contracts.json' with {type:'json'};
import pin from '../../../../tools/governance-production/production-pin.json' with {type:'json'};

type Client={query(sql:string,values?:string[]):Promise<{rows:Record<string,unknown>[]}>;release():void};
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
export class PostgresCommunicationEndpointPolicy {
 readonly pool:Pool;
 constructor(pool:Pool){if(typeof pool?.connect!=='function')throw Error('Governance pool required');this.pool=pool;}
 async authorize(actor:Actor,apiId:number,request:Request):Promise<void>{
  const contract=catalog.apis.find(api=>api.id===apiId);
  if(!contract||contract.method!==request.method||contract.path!==new URL(request.url).pathname)throw Error('Forbidden');
  const client=await this.pool.connect();
  try{
   await client.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
   await client.query("SET LOCAL statement_timeout='10s'");
   const manifest=await client.query(`SELECT manifest_sha256 FROM "${pin.schema}"."${pin.manifestTable}"`);
   if(manifest.rows.length!==1||manifest.rows[0].manifest_sha256!==pin.manifestSha256)throw Error('Governance manifest mismatch');
   const result=await client.query(`SELECT DISTINCT ${value('r','id')} AS role_id,${value('s','id')} AS screen_id
    FROM public.users u
    JOIN ${table('roles')} r ON ${value('r','role_code')}=u.roles::text AND ${value('r','active')}='1'
    JOIN ${table('api_permissions')} ap ON ${value('ap','role_id')}=${value('r','id')} AND ${value('ap','can_access')}='1'
    JOIN ${table('api_endpoints')} a ON ${value('a','id')}=${value('ap','api_id')}
    JOIN ${table('screen_api_links')} l ON ${value('l','api_id')}=${value('a','id')}
    JOIN ${table('screens')} s ON ${value('s','id')}=${value('l','screen_id')} AND ${value('s','active')}='1'
    JOIN ${table('role_screen_permissions')} sp ON ${value('sp','screen_id')}=${value('s','id')} AND ${value('sp','role_id')}=${value('r','id')} AND ${value('sp','can_view')}='1'
    WHERE u.id::text=$1 AND u.tenant_id::text=$2 AND LOWER(u.status)='active'
    AND ${value('a','id')}=$3 AND ${value('a','http_method')}=$4 AND ${value('a','route_path')}=$5
    AND ${value('a','service_name')}='governance' AND ${value('a','auth_required')}='1'
    AND ${value('a','permission_key')}='role_screen_permissions'
    AND ${value('s','id')} IN ('234','331','559','578') LIMIT 2`,[actor.id,actor.tenantId,String(apiId),contract.method,contract.path]);
   if(!result.rows.length||result.rows.some(row=>typeof row.role_id!=='string'||typeof row.screen_id!=='string'))throw Error('Forbidden');
  }finally{try{await client.query('ROLLBACK');}finally{client.release();}}
 }
}
