import {registeredMetadataValue as value} from './business-tasks/endpoint-policy';
import definition from '../../../packages/shared/src/communications/vapi-admin-contract.json';
import pin from '../../../tools/governance-production/production-pin.json';
const table=(name:string)=>`"${pin.schema}"."govt_${name}"`;
/** Separate candidate management policy; existing communication permissions and
 * their reviewed SQL/source fingerprints remain unchanged. */
export function vapiPermissionQuery(actor:{id:string;tenantId:string},method:string,path:string,code:string){
 if(!definition.operations.some(o=>o.method===method&&o.path===path&&o.code===code))throw Error('Forbidden');
 return {text:`SELECT DISTINCT (${value('r','id')})::text AS role_id,(${value('s','id')})::text AS screen_id,(${value('a','id')})::text AS api_id
 FROM public.users u
 JOIN public.tenants t ON t.id=u.tenant_id AND LOWER(t.status)='active'
 JOIN ${table('roles')} r ON ${value('r','role_code')}=u.roles::text AND ${value('r','active')}='1'
 JOIN ${table('api_permissions')} ap ON ${value('ap','role_id')}=${value('r','id')} AND ${value('ap','can_access')}='1' AND ${value('ap','permission_key')}='role_screen_permissions'
 JOIN ${table('api_endpoints')} a ON ${value('a','id')}=${value('ap','api_id')}
 JOIN ${table('screen_api_links')} l ON ${value('l','api_id')}=${value('a','id')}
 JOIN ${table('screens')} s ON ${value('s','id')}=${value('l','screen_id')} AND ${value('s','active')}='1' AND ${value('s','id')}='1269'
 JOIN ${table('role_screen_permissions')} sp ON ${value('sp','screen_id')}=${value('s','id')} AND ${value('sp','role_id')}=${value('r','id')} AND ${value('sp','can_view')}='1'
 WHERE u.id::text=$1 AND u.tenant_id::text=$2 AND u.roles::text='code_admin' AND LOWER(u.status)='active'
 AND ${value('a','http_method')}=$3 AND ${value('a','route_path')}=$4 AND ${value('a','endpoint_code')}=$5
 AND ${value('a','service_name')}='governance' AND ${value('a','auth_required')}='1' AND ${value('a','permission_key')}='role_screen_permissions'
 AND (SELECT COUNT(*) FROM ${table('api_endpoints')} d WHERE ${value('d','http_method')}=$3 AND ${value('d','route_path')}=$4 AND ${value('d','service_name')}='governance')=1 LIMIT 2`,values:[actor.id,actor.tenantId,method,path,code]};
}
