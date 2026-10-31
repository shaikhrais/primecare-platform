import {validateWorkspaceLayout,type WorkspaceLayout} from './workspace_layout';
export type NavigationFamily='vertical'|'horizontal-header'|'horizontal-footer';
export type NavigationMode='expanded'|'folded'|'rail';
export type WorkspaceNavigationNode={id:string;label:string;kind:'item'|'group';route?:string;icon?:string;subtitle?:string;badge?:string;disabled:boolean;match:'exact'|'prefix';children:readonly WorkspaceNavigationNode[]};
export type NavigationAuthority={ids:readonly string[];routes:readonly string[];icons:readonly string[]};
const fail=():never=>{throw Error('Invalid registered navigation model');};
export function navigationUrl(value:unknown):URL {
 if(typeof value!=='string'||value.length>512||!/^\/(?!\/)/.test(value)||/[\\\u0000-\u0020\u007f]/.test(value))return fail();
 const url=new URL(value,'https://primecare.invalid');if(url.origin!=='https://primecare.invalid')return fail();return url;
}
/** Validates metadata, then intersects both IDs and routes with the current server authority.
 * This function grants nothing; a denied parent hides its complete subtree. */
export function buildWorkspaceNavigation(raw:unknown,authority:NavigationAuthority):readonly WorkspaceNavigationNode[] {
 if(!Array.isArray(raw)||raw.length>1000)return fail();
 const permitted=new Set(authority.ids),routes=new Set(authority.routes),icons=new Set(authority.icons),seen=new Set<string>();let count=0;
 const text=(v:unknown,max:number)=>{if(typeof v!=='string'||!v.trim()||v.length>max||/[\u0000-\u001f\u007f]/.test(v))return fail();return v;};
 const parse=(list:unknown[],depth:number,parentDisabled=false):WorkspaceNavigationNode[]=>{
  if(depth>8)return fail();const out:WorkspaceNavigationNode[]=[];
  for(const input of list){
   if(!input||typeof input!=='object'||Array.isArray(input)||++count>1000)return fail();const v=input as Record<string,unknown>;
   if(Object.keys(v).some(k=>!['id','label','kind','route','icon','subtitle','badge','disabled','match','children'].includes(k)))return fail();
   const id=text(v.id,64);if(!/^[a-z][a-z0-9-]*$/.test(id)||seen.has(id))return fail();seen.add(id);
   const label=text(v.label,200),kind=v.kind;if(kind!=='item'&&kind!=='group')return fail();
   if(v.disabled!==undefined&&typeof v.disabled!=='boolean')return fail();const disabled=parentDisabled||v.disabled===true;
   if(v.match!==undefined&&v.match!=='exact'&&v.match!=='prefix')return fail();const match=(v.match??'exact') as 'exact'|'prefix';
   const optional=(key:string,max:number)=>v[key]===undefined?undefined:text(v[key],max);
   const icon=optional('icon',64),subtitle=optional('subtitle',400),badge=optional('badge',40);if(icon&&!icons.has(icon))return fail();
   let route:string|undefined,children:WorkspaceNavigationNode[]=[];
   if(kind==='item'){navigationUrl(v.route);route=v.route as string;if(v.children!==undefined)return fail();}
   else{if(v.route!==undefined||!Array.isArray(v.children))return fail();children=parse(v.children,depth+1,disabled);}
   if(!permitted.has(id)||(route&&!routes.has(route))||(kind==='group'&&!children.length))continue;
   out.push(Object.freeze({id,label,kind,...(route?{route}:{}),...(icon?{icon}:{}),...(subtitle?{subtitle}:{}),...(badge?{badge}:{}),disabled,match,children:Object.freeze(children)}));
  }return out;
 };
 return Object.freeze(parse(raw,0));
}
export function flattenWorkspaceNavigation(nodes:readonly WorkspaceNavigationNode[]):WorkspaceNavigationNode[]{return nodes.flatMap(n=>[n,...flattenWorkspaceNavigation(n.children)]);}
export function activeWorkspaceDestination(nodes:readonly WorkspaceNavigationNode[],current:string):string|undefined {
 const here=navigationUrl(current),path=(p:string)=>p==='/'?p:p.replace(/\/$/,'');let best:WorkspaceNavigationNode|undefined,score=-1;
 for(const node of flattenWorkspaceNavigation(nodes)){
  if(!node.route||node.disabled)continue;const target=navigationUrl(node.route),a=path(target.pathname),b=path(here.pathname);
  if((node.match==='exact'?a===b:(a==='/'||a===b||b.startsWith(a+'/')))&&(!target.search||target.search===here.search)&&(!target.hash||target.hash===here.hash)){
   const rank=a.length+(target.search?target.search.length:0)+(target.hash?target.hash.length:0);if(rank>score){best=node;score=rank;}
  }
 }return best?.id;
}
export function navigationPreset(profile:WorkspaceLayout,family:NavigationFamily):WorkspaceLayout {
 if(!['vertical','horizontal-header','horizontal-footer'].includes(family))throw Error('Unknown navigation family');
 return validateWorkspaceLayout({...profile,navigation:family==='vertical'?'left':family==='horizontal-header'?'top':'bottom',toolbar:'top'},Object.keys(profile.panels));
}
