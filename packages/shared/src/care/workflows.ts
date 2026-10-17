import {registry,identifier,uuid,fail} from './contract';
import {keys,integer,text,timestamp} from '../growth/contract';

export function handoverBody(v:Record<string,unknown>){
 const action=String(v.action),create=action==='create';
 if(!registry.handoverPolicy.actions.includes(action)||!text(v.note,1000))fail(400);
 keys(v,['action','note',...(create?['sourceCaseId','targetCaseId']:['id','version']),...(['create','revise'].includes(action)?['summary','outstanding','precautions']:[]),...(['approve','withdraw','acknowledge'].includes(action)?['checked']:[])]);
 if(create){if(!uuid(v.sourceCaseId)||!uuid(v.targetCaseId)||v.sourceCaseId===v.targetCaseId)fail(400);}
 else if(!uuid(v.id)||!integer(v.version,registry.handoverPolicy.maxVersions))fail(400);
 if(['create','revise'].includes(action)&&!['summary','outstanding','precautions'].every(k=>text(v[k],registry.handoverPolicy.clinicalTextMax)))fail(400);
 if(['approve','withdraw','acknowledge'].includes(action)&&v.checked!==true)fail(400);
 return {...v,action,...(create?{sourceCaseId:String(v.sourceCaseId).toLowerCase(),targetCaseId:String(v.targetCaseId).toLowerCase()}:{id:String(v.id).toLowerCase()})};
}
export function followupBody(v:Record<string,unknown>){
 const action=String(v.action),create=action==='create',p=registry.followupPolicy;
 if(!p.actions.includes(action)||!text(v.note,1000))fail(400);
 keys(v,['action','note',...(create?['caseId','category','ownerId','dueAt','prerequisiteIds']:['id','version']),...(action==='reassign'?['ownerId','dueAt']:action==='request_extension'?['dueAt']:[]),...(action==='release_dependency'?['prerequisiteId']:[]),...(['verify','approve_extension','release_dependency'].includes(action)?['checked']:[])]);
 if(create){if(!uuid(v.caseId)||!p.categories.includes(String(v.category)))fail(400);}else if(!uuid(v.id)||!integer(v.version,p.maxVersions-1))fail(400);
 if((create||action==='reassign')&&!identifier(v.ownerId))fail(400);
 if(create||['reassign','request_extension'].includes(action)){
  const due=timestamp(v.dueAt)!;
  if(Date.parse(due)<=Date.now()||Date.parse(due)>Date.now()+p.maxDaysAhead*86400000)fail(400);
 }
 if(['verify','approve_extension','release_dependency'].includes(action)&&v.checked!==true)fail(400);
 const parents=create?(v.prerequisiteIds??[]):[];
 if(!Array.isArray(parents)||parents.length>registry.dependencyPolicy.maxParents||!parents.every(uuid)||new Set(parents.map(id=>String(id).toLowerCase())).size!==parents.length)fail(400);
 if(action==='release_dependency'&&!uuid(v.prerequisiteId))fail(400);
 return {...v,action,...(create?{prerequisiteIds:(parents as string[]).map(id=>id.toLowerCase())}:{}),...(action==='release_dependency'?{prerequisiteId:String(v.prerequisiteId).toLowerCase()}: {})};
}
