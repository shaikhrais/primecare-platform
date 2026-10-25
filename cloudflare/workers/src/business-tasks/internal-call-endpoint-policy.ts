import {PostgresRegisteredCommunicationEndpointPolicy,registeredMetadataValue,registeredPermissionQuery} from './endpoint-policy.ts';
import definition from '../../../../tools/governance-production/internal-call-contracts-registration.json' with {type:'json'};
import type {Actor} from '../../../../packages/shared/src/communications/service-base.ts';
export function nativeCallMetadataValue(alias:string,column:string){
  const native:Record<string,readonly string[]>={r:['id','active'],ap:['role_id','api_id','can_access'],a:['id'],l:['api_id','screen_id'],s:['id','active'],sp:['role_id','screen_id','can_view']};
  if(alias==='r'&&column==='role_code'||['a','duplicate'].includes(alias)&&['http_method','route_path','service_name'].includes(column))return `${alias}."${column}"`;
  return native[alias]?.includes(column)?`${alias}."${column}"`:registeredMetadataValue(alias,column);
 }
export function nativeCallPermissionQuery(actor:Actor,method:string,path:string,code:string){return registeredPermissionQuery(actor,null,method,path,code,nativeCallMetadataValue,'$3::bigint');}
/** Native production key/flag columns are bigint. Preserve their type for joins
 * and filters, so PostgreSQL can use statistics and indexes. Only projections
 * become text. All current grant, identity, manifest and uniqueness checks are
 * inherited from the same policy; no authorization result is cached. */
export class PostgresInternalCallEndpointPolicy extends PostgresRegisteredCommunicationEndpointPolicy {
 protected override metadataValue(alias:string,column:string){return nativeCallMetadataValue(alias,column);}
 protected override apiIdParameter(){return '$3::bigint';}
 async authorize(actor:Actor,key:string,request:Request){const op=definition.operations.find(o=>o.key===key);if(!op||op.path!==new URL(request.url).pathname||request.method!==op.method)throw Error('Forbidden');return this.authorizeRegistered(actor,null,op.method,op.path,'INTERNAL_'+key.replaceAll('.','_').toUpperCase());}
}
