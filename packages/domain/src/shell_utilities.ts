export type UtilityKind='events'|'notes'|'settings'|'notifications';
export const utilityKinds:readonly UtilityKind[]=['events','notes','settings','notifications'];
export type UtilityItem={id:string;title:string;detail:string;read:boolean|null;status:string|null};
export function utilityItems(raw:unknown):UtilityItem[]{
 if(!Array.isArray(raw)||raw.length>100)throw Error('invalid_utility_response');const ids=new Set<string>();
 return raw.map(v=>{if(!v||typeof v!=='object'||Array.isArray(v)||Object.keys(v).sort().join(',')!=='detail,id,read,status,title'||typeof v.id!=='string'||!/^[A-Za-z0-9][A-Za-z0-9_.:-]{0,199}$/.test(v.id)||ids.has(v.id)||typeof v.title!=='string'||!v.title.trim()||v.title.length>200||typeof v.detail!=='string'||v.detail.length>4000||v.read!==null&&typeof v.read!=='boolean'||v.status!==null&&(typeof v.status!=='string'||v.status.length>200))throw Error('invalid_utility_response');ids.add(v.id);return {id:v.id,title:v.title,detail:v.detail,read:v.read,status:v.status};});
}
export type UtilityDestination={id:string;title:string;detail:string;disabled:boolean};
export function utilityDestinations(raw:readonly UtilityDestination[],screenIds:readonly string[]):readonly UtilityDestination[]{const seen=new Set<string>();return Object.freeze(raw.map(v=>{if(!/^[1-9][0-9]{0,9}$/.test(v.id)||seen.has(v.id)||!screenIds.includes(v.id)||typeof v.title!=='string'||!v.title.trim()||v.title.length>200||typeof v.detail!=='string'||v.detail.length>400||typeof v.disabled!=='boolean')throw Error('invalid_utility_destination');seen.add(v.id);return Object.freeze({...v});}));}
export function searchUtilityDestinations(nodes:readonly UtilityDestination[],query:string,locale='en'):readonly UtilityDestination[]{if(!['en','fr','es'].includes(locale)||query.length>100)throw Error('invalid_utility_search');const q=query.trim().toLocaleLowerCase(locale);return nodes.filter(n=>(n.title+' '+n.detail).toLocaleLowerCase(locale).includes(q));}
