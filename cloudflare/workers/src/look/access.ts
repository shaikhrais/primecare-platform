import pin from '../../../../tools/governance-production/production-pin.json';
import {registry,fail} from '../../../../packages/shared/src/look/manager';
import {registeredMetadataValue as value} from '../business-tasks/endpoint-policy';
type Database={query(text:string,values?:unknown[]):Promise<{rows:any[]}>};
export class BaseLookAccess {
 async authorize(_db:Database,_actor:{id:string;roles:string;tenant_id:string|null},_method:string,_path:string):Promise<void>{fail(403,'forbidden');}
}
/** Current production API AND linked-screen grants. No static grant fallback. */
export class PostgresLookAccess extends BaseLookAccess {
 async screens(db:Database,actor:{roles:string},global:boolean){
  const table=(name:string)=>`"${pin.schema}"."govt_${name}"`;
  const result=await db.query(`SELECT DISTINCT ${value('s','screen_code')} AS code,${value('s','screen_name')} AS name,${value('s','route_path')} AS route
   FROM ${table('screens')} s WHERE ${value('s','active')}='1' AND ($2::boolean OR EXISTS (
    SELECT 1 FROM ${table('role_screen_permissions')} p JOIN ${table('roles')} r ON ${value('r','id')}=${value('p','role_id')}
    WHERE ${value('p','screen_id')}=${value('s','id')} AND ${value('p','can_view')}='1' AND ${value('r','role_code')}=$1 AND ${value('r','active')}='1')) ORDER BY 2,1 LIMIT 5000`,[actor.roles,global]);
  if(result.rows.some(r=>!r.code||!r.name||!r.route))fail(503,'governance_unavailable');return result.rows;
 }
 override async authorize(db:Database,actor:{id:string;roles:string;tenant_id:string|null},method:string,path:string){
  const normalized=path.replace(/\/reviews\/[0-9a-f-]{36}\//i,'/reviews/{id}/');
  const operation=registry.contracts.find(c=>c.method===method&&registry.endpoint+c.suffix==='/v1/governance'+normalized);
  if(!operation||!actor.tenant_id)fail(403,'forbidden');
  const manifest=await db.query(`SELECT manifest_sha256 FROM "${pin.schema}"."${pin.manifestTable}"`);
  if(manifest.rows.length!==1||manifest.rows[0].manifest_sha256!==pin.manifestSha256)fail(503,'governance_unavailable');
  const table=(name:string)=>`"${pin.schema}"."govt_${name}"`,write=method!=='GET';
  const result=await db.query(`SELECT DISTINCT ${value('a','id')} AS api_id FROM ${table('api_endpoints')} a
   JOIN ${table('api_permissions')} ap ON ${value('ap','api_id')}=${value('a','id')} AND ${value('ap','can_access')}='1' AND ${value('ap','permission_key')}='role_screen_permissions'
   JOIN ${table('roles')} r ON ${value('r','id')}=${value('ap','role_id')} AND ${value('r','role_code')}=$1 AND ${value('r','active')}='1'
   JOIN ${table('screen_api_links')} l ON ${value('l','api_id')}=${value('a','id')}
   JOIN ${table('screens')} s ON ${value('s','id')}=${value('l','screen_id')} AND ${value('s','screen_code')}='look_review_manager' AND ${value('s','active')}='1'
   JOIN ${table('role_screen_permissions')} p ON ${value('p','screen_id')}=${value('s','id')} AND ${value('p','role_id')}=${value('r','id')} AND ${value('p','can_view')}='1'
   WHERE ${value('a','http_method')}=$2 AND ${value('a','route_path')}=$3 AND ${value('a','service_name')}='governance'
   AND ${value('a','auth_required')}='1' AND ${value('a','permission_key')}='role_screen_permissions'
   ${write?`AND ${value('p','can_create')}='1' AND ${value('p','can_edit')}='1'`:''}
   AND (SELECT COUNT(*) FROM ${table('api_endpoints')} duplicate WHERE ${value('duplicate','http_method')}=$2 AND ${value('duplicate','route_path')}=$3 AND ${value('duplicate','service_name')}='governance')=1 LIMIT 2`,[actor.roles,method,registry.endpoint+operation.suffix]);
  if(result.rows.length!==1||typeof result.rows[0].api_id!=='string')fail(403,'forbidden');
 }
}
