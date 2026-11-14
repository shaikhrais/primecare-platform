export class HelpReadFailure extends Error {
 constructor(public readonly code:'invalid_request'|'unauthenticated'|'forbidden'|'not_found'|'conflict'|'rate_limited'|'unavailable',public readonly status:number){super(code);}
}
export type HelpActor=Readonly<{tenantId:string;userId:string;role:'psw';dataset:'live'}>;
export type HelpRequest={version:1;locale:'en'|'fr'|'es'}&({action:'list';query:string;offset:number;limit:number}|{action:'read';articleId:string});
type Summary=Readonly<{id:string;revision:number;title:string;category:string;summary:string}>;
type Article=Readonly<{id:string;revision:number;title:string;category:string;body:string}>;
export type HelpResponse={version:1;locale:HelpRequest['locale'];scope:HelpActor}&({action:'list';items:readonly Summary[];offset:number;limit:number;total:number}|{action:'read';article:Article});
export const helpId=(v:unknown):v is string=>typeof v==='string'&&/^[A-Za-z0-9][A-Za-z0-9._:-]{0,199}$/.test(v);
export const helpText=(v:unknown,min:number,max:number):v is string=>typeof v==='string'&&v.length<=max&&v.length>=min&&(!min||v.trim().length>0)&&!/[\u0000-\u0008\u000b\u000c\u000e-\u001f\u007f]/.test(v);
export const helpInteger=(v:unknown,min:number,max:number)=>typeof v==='number'&&Number.isSafeInteger(v)&&v>=min&&v<=max;
const object=(v:unknown):v is Record<string,any>=>!!v&&typeof v==='object'&&!Array.isArray(v);
const keys=(v:Record<string,any>,expected:string[])=>Object.keys(v).length===expected.length&&expected.every(k=>Object.hasOwn(v,k));
export function helpRequest(raw:unknown):HelpRequest{
 if(!object(raw))throw new HelpReadFailure('invalid_request',400);
 const expected=raw.action==='list'?['version','locale','action','query','offset','limit']:['version','locale','action','articleId'];
 if(!keys(raw,expected)||raw.version!==1||typeof raw.locale!=='string'||!['en','fr','es'].includes(raw.locale))throw new HelpReadFailure('invalid_request',400);
 if(raw.action==='list'){
  if(!helpText(raw.query,0,100)||!helpInteger(raw.offset,0,100000)||!helpInteger(raw.limit,1,100))throw new HelpReadFailure('invalid_request',400);
 }else if(raw.action!=='read'||!helpId(raw.articleId))throw new HelpReadFailure('invalid_request',400);
 return Object.freeze({...raw}) as HelpRequest;
}
export function helpScope(raw:unknown):HelpActor{
 if(!object(raw)||!keys(raw,['tenantId','userId','role','dataset'])||!helpId(raw.tenantId)||!helpId(raw.userId)||raw.role!=='psw'||raw.dataset!=='live')throw new HelpReadFailure('unavailable',503);
 return Object.freeze({...raw}) as HelpActor;
}
function projected(raw:unknown,detail:boolean):Summary|Article{
 if(!object(raw)||!keys(raw,['id','revision','title','category',detail?'body':'summary'])||!helpId(raw.id)||!helpInteger(raw.revision,1,Number.MAX_SAFE_INTEGER)||!helpText(raw.title,1,500)||!helpText(raw.category,1,100)||!helpText(detail?raw.body:raw.summary,detail?1:0,detail?5000:1000))throw new HelpReadFailure('unavailable',503);
 return Object.freeze({...raw}) as Summary|Article;
}
/** Producer and captured client use the same registered wire constraints. */
export function helpResponse(raw:unknown,request:HelpRequest,expected:HelpActor):HelpResponse{
 if(!object(raw)||raw.version!==1||raw.action!==request.action||raw.locale!==request.locale)throw new HelpReadFailure('unavailable',503);
 const scope=helpScope(raw.scope);
 if(scope.userId!==expected.userId||scope.tenantId!==expected.tenantId||scope.role!==expected.role||scope.dataset!==expected.dataset)throw new HelpReadFailure('conflict',409);
 if(request.action==='read'){
  if(!keys(raw,['version','locale','action','scope','article']))throw new HelpReadFailure('unavailable',503);
  const article=projected(raw.article,true) as Article;if(article.id!==request.articleId)throw new HelpReadFailure('unavailable',503);
  return Object.freeze({version:1,locale:request.locale,action:'read',scope,article});
 }
 if(!keys(raw,['version','locale','action','scope','items','offset','limit','total'])||raw.offset!==request.offset||raw.limit!==request.limit||!helpInteger(raw.total,0,Number.MAX_SAFE_INTEGER)||!Array.isArray(raw.items)||raw.items.length>request.limit||raw.items.length>Math.max(0,raw.total-request.offset))throw new HelpReadFailure('unavailable',503);
 const items=raw.items.map((v:unknown)=>projected(v,false) as Summary);
 if(new Set(items.map((v:Summary)=>v.id)).size!==items.length)throw new HelpReadFailure('unavailable',503);
 return Object.freeze({version:1,locale:request.locale,action:'list',scope,items:Object.freeze(items),offset:raw.offset,limit:raw.limit,total:raw.total});
}
