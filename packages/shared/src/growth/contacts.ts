import {fail,integer,keys,text,uuid,registry,stages,type Actor} from './contract';
export type LeadFilters={q?:string;pipeline?:string;stage?:string;source?:string;owner?:string};
export function leadFilters(params:URLSearchParams):LeadFilters {
 for(const key of params.keys())if(!registry.leadFilters.includes(key)||params.getAll(key).length!==1)fail(400);
 const q=params.get('q')??'',pipeline=params.get('pipeline')??'',stage=params.get('stage')??'',source=params.get('source')??'',owner=params.get('owner')??'';
 if(!text(q,100,true)||pipeline&&!['tenant','client'].includes(pipeline)||stage&&![...registry.pipelines.tenant,...registry.pipelines.client,'lost'].includes(stage)||pipeline&&stage&&stage!=='lost'&&!stages(pipeline as 'tenant'|'client').includes(stage)||source&&!registry.sources.includes(source)||owner&&!['mine','unassigned'].includes(owner)&&!uuid(owner))fail(400);
 return {q:q.trim(),pipeline,stage,source,owner};
}
export function filterSQL(filters:LeadFilters,actor:Actor,alias='',start=2){
 const col=(name:string)=>alias?alias+'.'+name:name;const values:unknown[]=[],parts:string[]=[];const param=(v:unknown)=>{values.push(v);return '$'+(start+values.length-1);};
 if(filters.q){const p=param(filters.q.toLowerCase());const digits=filters.q.replace(/\D/g,'');const phoneMatch=/^[+()\d .-]+$/.test(filters.q)&&digits.length>=3?` OR POSITION(${param(digits)} IN regexp_replace(${col('phone')},'[^0-9]','','g'))>0`:'';parts.push(`(POSITION(${p} IN LOWER(${col('name')}))>0 OR POSITION(${p} IN LOWER(${col('email')}))>0 OR POSITION(${p} IN ${col('phone')})>0${phoneMatch})`);}
 for(const key of ['pipeline','stage','source'] as const)if(filters[key])parts.push(`${col(key)}=${param(filters[key])}`);
 if(filters.owner==='unassigned')parts.push(col('owner_id')+' IS NULL');else if(filters.owner)parts.push(col('owner_id')+'::text='+param(filters.owner==='mine'?actor.id:filters.owner));
 return {sql:parts.length?' AND '+parts.join(' AND '):'',values};
}
export function contactBody(v:Record<string,unknown>):Record<string,unknown>&{name:string;email:string;phone:string}{
 keys(v,['name','email','phone','version','evidence']);integer(v.version,2147483647);
 if(v.version===0||!text(v.name,150)||!text(v.email,254,true)||v.email&&!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(String(v.email))||!text(v.phone,40,true)||v.phone&&(!/^[+()\d .-]{5,40}$/.test(String(v.phone))||String(v.phone).replace(/\D/g,'').length<5)||!text(v.evidence,500))fail(400);
 return {...v,name:String(v.name).trim(),email:String(v.email).trim().toLowerCase(),phone:String(v.phone).trim()};
}
export const contactIdentity=(v:{name:unknown;email:unknown;phone:unknown})=>String(v.email)||String(v.phone).replace(/\D/g,'')||String(v.name).toLowerCase().replace(/\s+/g,' ');
export function shareContact(a:{email:unknown;phone:unknown},b:{email:unknown;phone:unknown}){const email=(v:unknown)=>String(v).trim().toLowerCase(),phone=(v:unknown)=>String(v).replace(/\D/g,'');return !!(email(a.email)&&email(a.email)===email(b.email)||phone(a.phone).length>=5&&phone(a.phone)===phone(b.phone));}
export function duplicateBody(v:Record<string,unknown>):Record<string,unknown>&{canonicalId:string;duplicateId:string}{
 keys(v,['canonicalId','duplicateId','canonicalVersion','duplicateVersion','reviewVersion','decision','evidence']);
 if(!uuid(v.canonicalId)||!uuid(v.duplicateId)||String(v.canonicalId).toLowerCase()===String(v.duplicateId).toLowerCase()||!['distinct_person','duplicate_confirmed'].includes(String(v.decision))||!text(v.evidence,500))fail(400);
 for(const k of ['canonicalVersion','duplicateVersion','reviewVersion'])integer(v[k],2147483647);if(!v.canonicalVersion||!v.duplicateVersion)fail(400);
 return {...v,canonicalId:String(v.canonicalId).toLowerCase(),duplicateId:String(v.duplicateId).toLowerCase()};
}
