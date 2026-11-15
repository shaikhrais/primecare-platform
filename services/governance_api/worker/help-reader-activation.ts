import pin from '../../../tools/governance-production/production-pin.json';
import contract from '../../../tools/governance-production/pc10-help-reader-contract.json';
import operationalPolicy from '../../../packages/shared/src/help-reader/operational-policy.json';
import registeredBinding from './help-reader-runtime-binding.json';
import {HelpReadFailure,type HelpActor} from '../../../packages/shared/src/help-reader/protocol';

type Database={query:(sql:string,values?:unknown[])=>Promise<{rows:unknown[]}>};
type Row=Record<string,unknown>;
type Artifact=Readonly<{id:string;artifact_type:string;artifact_code:string;artifact_name:string;physical_path:string;status:string;health_status:string;deployment_status:string;version:string;checksum:string}>;
type ScreenPermission=Readonly<{id:string;role_id:51;screen_id:685;can_view:1;can_create:0;can_edit:0;can_delete:0;can_export:0}>;
type ScreenMap=Readonly<{id:string;role_id:51;screen_id:685;can_view:1;can_edit:0}>;
type Control=Readonly<{id:string;screen_id:685;component_code:string;component_name:string;component_type:string;data_cy:string;file_path:string;implementation_status:string}>;
export type HelpRuntimeDefinition=Readonly<{
 apiId:794;roleId:51;screenId:685;permissionKey:string;contractSha256:string;manifestSha256:string;
 producer:Readonly<{sourceCommit:string;worker:string;deploymentId:string;versionId:string;sourceFiles:Readonly<Record<string,string>>}>;
 artifact:Artifact;screenPermission:ScreenPermission;screenMap:ScreenMap;control:Control;
}>;
export type HelpRuntimeBinding=Readonly<{format:1;definitionSha256:string;definition:HelpRuntimeDefinition}>;

/** A finite implementation footprint, not a list of paths supplied by a request. */
export const helpRuntimeSourcePaths=Object.freeze([
 'services/governance_api/worker/help-reader.ts',
 'services/governance_api/worker/help-reader-activation.ts',
 'services/governance_api/worker/governance-help-service.ts',
 'services/api_gateway/worker/help-gateway.ts',
 'cloudflare/workers/src/service-application.ts',
 'cloudflare/workers/src/gateway.ts',
 'packages/shared/src/help-reader/service.ts',
 'packages/shared/src/help-reader/http.ts',
 'packages/shared/src/help-reader/protocol.ts',
 'packages/shared/src/help-reader/postgres-store.ts',
 'packages/shared/src/help-reader/operational-effects.ts',
 'packages/shared/src/help-reader/operational-policy.json',
 'tools/governance-production/pc10-help-reader-contract.json',
 'tools/governance-production/pc10-help-policy.definition.json',
]);
const artifactFields=['id','artifact_type','artifact_code','artifact_name','physical_path','status','health_status','deployment_status','version','checksum'] as const;
const permissionFields=['id','role_id','screen_id','can_view','can_create','can_edit','can_delete','can_export'] as const;
const mapFields=['id','role_id','screen_id','can_view','can_edit'] as const;
const controlFields=['id','screen_id','component_code','component_name','component_type','data_cy','file_path','implementation_status'] as const;
const unavailable=()=>new HelpReadFailure('unavailable',503);
const registeredBindings=new WeakSet<object>();
const object=(value:unknown):value is Row=>!!value&&typeof value==='object'&&!Array.isArray(value)&&Object.getPrototypeOf(value)===Object.prototype;
const keys=(value:unknown,expected:readonly string[]):value is Row=>object(value)&&Object.keys(value).length===expected.length&&expected.every(key=>Object.hasOwn(value,key));
const text=(value:unknown,max=2000):value is string=>typeof value==='string'&&value.length>0&&value.length<=max&&!/[\u0000-\u001f\u007f]/.test(value);
const digest=(value:unknown):value is string=>typeof value==='string'&&/^[a-f0-9]{64}$/.test(value);
const commit=(value:unknown):value is string=>typeof value==='string'&&/^[a-f0-9]{40}$/.test(value);
const uuid=(value:unknown):value is string=>typeof value==='string'&&/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i.test(value);
/** Canonical positive signed-bigint identities; never round an int8 through Number. */
function identity(value:unknown):string|null{
 if(typeof value==='number')return Number.isSafeInteger(value)&&value>0?String(value):null;
 if(typeof value!=='string'||!/^\d+$/.test(value)||value[0]==='0'||value.length>19||value.length===19&&value>'9223372036854775807')return null;
 return value;
}
function taggedInteger(value:unknown):string|null{return keys(value,['t','v'])&&value.t==='integer'&&typeof value.v==='string'?identity(value.v):null;}
function taggedText(value:unknown):string|null{return keys(value,['t','v'])&&value.t==='text'&&text(value.v)?value.v:null;}
function canonical(value:unknown):string{
 if(Array.isArray(value))return '['+value.map(canonical).join(',')+']';
 if(object(value))return '{'+Object.keys(value).sort().map(key=>JSON.stringify(key)+':'+canonical(value[key])).join(',')+'}';
 return JSON.stringify(value);
}
/** Semantic canonical JSON digest; producer.sourceFiles separately pins raw file bytes. */
export async function helpRuntimeDefinitionDigest(value:unknown):Promise<string>{
 const result=await crypto.subtle.digest('SHA-256',new TextEncoder().encode(canonical(value)));
 return Array.from(new Uint8Array(result),value=>value.toString(16).padStart(2,'0')).join('');
}
function freeze<T>(value:T):T{
 if(value&&typeof value==='object'){for(const child of Object.values(value))freeze(child);Object.freeze(value);}
 return value;
}
function definitionShape(value:unknown):value is HelpRuntimeDefinition{
 if(!keys(value,['apiId','roleId','screenId','permissionKey','contractSha256','manifestSha256','producer','artifact','screenPermission','screenMap','control']))return false;
 if(value.apiId!==794||value.roleId!==51||value.screenId!==685||value.permissionKey!==contract.permissionKey||value.manifestSha256!==pin.manifestSha256||!digest(value.contractSha256))return false;
 const producer=value.producer,artifact=value.artifact,permission=value.screenPermission,map=value.screenMap,control=value.control;
 if(!keys(producer,['sourceCommit','worker','deploymentId','versionId','sourceFiles'])||!commit(producer.sourceCommit)||producer.worker!=='primecare-governance-api'||!uuid(producer.deploymentId)||!uuid(producer.versionId)||!keys(producer.sourceFiles,helpRuntimeSourcePaths)||!Object.values(producer.sourceFiles).every(digest))return false;
 if(!keys(artifact,artifactFields)||typeof artifact.id!=='string'||!identity(artifact.id)||['1','2','3'].includes(artifact.id)||!artifactFields.filter(field=>field!=='id').every(field=>text(artifact[field]))||artifact.physical_path!=='services/governance_api/worker/help-reader.ts'||!digest(artifact.checksum)||artifact.version!==producer.versionId||artifact.checksum!==producer.sourceFiles[artifact.physical_path])return false;
 if(!keys(permission,permissionFields)||typeof permission.id!=='string'||!identity(permission.id)||permission.id==='6157'||permission.role_id!==51||permission.screen_id!==685||permission.can_view!==1||permission.can_create!==0||permission.can_edit!==0||permission.can_delete!==0||permission.can_export!==0)return false;
 if(!keys(map,mapFields)||typeof map.id!=='string'||!identity(map.id)||map.id==='603'||map.role_id!==51||map.screen_id!==685||map.can_view!==1||map.can_edit!==0)return false;
 if(!keys(control,controlFields)||typeof control.id!=='string'||!identity(control.id)||control.id==='779'||control.screen_id!==685||!controlFields.filter(field=>!['id','screen_id'].includes(field)).every(field=>text(control[field])))return false;
 return true;
}

/** Fixed feature-owned plan loader. No request, environment flag, callback or fallback can supply a plan.
 * A producer receipt is staged provenance, not per-request Cloudflare current-version attestation.
 * Fresh active-version/owned-host acceptance remains a separate activation prerequisite.
 */
export async function loadRegisteredHelpBinding():Promise<HelpRuntimeBinding|null>{
 const candidate:unknown=registeredBinding;
 if(candidate===null||operationalPolicy.runtimeBound!==true||operationalPolicy.purgeScheduleVerified!==true)return null;
 try{
  const encoded=JSON.stringify(candidate);if(encoded.length>32768)throw unavailable();
  const binding:unknown=JSON.parse(encoded);
  if(!keys(binding,['format','definitionSha256','definition'])||binding.format!==1||!digest(binding.definitionSha256)||!definitionShape(binding.definition)||binding.definition.contractSha256!==await helpRuntimeDefinitionDigest(contract)||binding.definitionSha256!==await helpRuntimeDefinitionDigest(binding.definition))throw unavailable();
  const accepted=freeze(binding as unknown as HelpRuntimeBinding);registeredBindings.add(accepted);return accepted;
 }catch{throw unavailable();}
}
const table=(name:string)=>'"'+pin.schema+'"."'+pin.tablePrefix+name+'"';
function one(rows:unknown[],expected:readonly string[]):Row{
 if(rows.length!==1||!keys(rows[0],expected))throw unavailable();return rows[0];
}
function scalarSnapshot(row:Row,expected:Row,idFields:readonly string[]){
 for(const key of Object.keys(expected)){
  if(idFields.includes(key)){if(identity(row[key])!==String(expected[key]))throw unavailable();}
  else if(typeof expected[key]==='number'){if(row[key]!==expected[key]&&row[key]!==String(expected[key]))throw unavailable();}
  else if(row[key]!==expected[key])throw unavailable();
 }
}
/** Only call inside readPublishedHelp's transaction, immediately before its real quota adapter.
 * This function never begins/commits a transaction or queries unrelated permission rows.
 */
export async function verifyHelpRuntimeBinding(db:Database,binding:HelpRuntimeBinding,actor:HelpActor):Promise<void>{
 if(!db||typeof db.query!=='function'||!binding||!registeredBindings.has(binding)||actor?.role!=='psw'||actor.dataset!=='live')throw unavailable();
 const query=db.query.bind(db),definition=binding.definition;
 const endpoint=one((await query('SELECT runtime_artifact_id FROM '+table('api_endpoints')+' WHERE id=794 FOR SHARE')).rows,['runtime_artifact_id']);
 if(taggedInteger(endpoint.runtime_artifact_id)!==definition.artifact.id)throw unavailable();
 const artifact=one((await query('SELECT '+artifactFields.join(',')+' FROM '+table('runtime_artifacts')+' WHERE id=$1::jsonb LIMIT 2 FOR SHARE',[JSON.stringify({t:'integer',v:definition.artifact.id})])).rows,artifactFields);
 for(const field of artifactFields){const actual=field==='id'?taggedInteger(artifact[field]):taggedText(artifact[field]);if(actual!==definition.artifact[field])throw unavailable();}
 const permission=one((await query('SELECT '+permissionFields.join(',')+' FROM '+table('role_screen_permissions')+' WHERE id=$1 AND role_id=51 AND screen_id=685 FOR SHARE',[definition.screenPermission.id])).rows,permissionFields);
 scalarSnapshot(permission,definition.screenPermission as unknown as Row,['id','role_id','screen_id']);
 const map=one((await query('SELECT '+mapFields.join(',')+' FROM '+table('role_screen_map')+' WHERE id=$1 AND role_id=51 AND screen_id=685 FOR SHARE',[definition.screenMap.id])).rows,mapFields);
 scalarSnapshot(map,definition.screenMap as unknown as Row,['id','role_id','screen_id']);
 const control=one((await query('SELECT '+controlFields.join(',')+' FROM '+table('screen_components')+' WHERE id=$1 AND screen_id=685 FOR SHARE',[definition.control.id])).rows,controlFields);
 scalarSnapshot(control,definition.control as unknown as Row,['id','screen_id']);
}
