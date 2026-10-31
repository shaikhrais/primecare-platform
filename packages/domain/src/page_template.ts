import {navigationUrl} from './workspace_navigation';
export type PageSidebar={mode:'none'|'permanent'|'temporary'|'responsive';width:number;open:boolean};
export type PageChrome={navigation:boolean;toolbar:boolean;footer:boolean};
export type PageLayout={version:1;template:'simple'|'carded';scroll:'normal'|'page'|'content';left:PageSidebar;right:PageSidebar;chrome:PageChrome};
export type PageBreadcrumb={id:string;label:string;route?:string};
export type RegisteredPageRoute={id:string;route:string;title:string;breadcrumbs:readonly PageBreadcrumb[];layout:PageLayout};
export type PageAuthority={ids:readonly string[];routes:readonly string[]};
const fail=():never=>{throw Error('Invalid registered page metadata');};
function object(raw:unknown,keys:string[]):Record<string,unknown>{
 if(!raw||typeof raw!=='object'||Array.isArray(raw))return fail();const v=raw as Record<string,unknown>;
 if(Object.keys(v).length!==keys.length||keys.some(k=>!Object.hasOwn(v,k)))return fail();return v;
}
function text(v:unknown,max:number):string{if(typeof v!=='string'||!v.trim()||v.length>max||/[\u0000-\u001f\u007f]/.test(v))return fail();return v;}
function id(v:unknown):string{const s=text(v,64);if(!/^[A-Za-z0-9][A-Za-z0-9_.:-]*$/.test(s))return fail();return s;}
function bool(v:unknown):boolean{if(typeof v!=='boolean')return fail();return v;}
function choice<T extends string>(v:unknown,values:readonly T[]):T{if(typeof v!=='string'||!values.includes(v as T))return fail();return v as T;}
export function defaultPageLayout():PageLayout{return validatePageLayout({version:1,template:'simple',scroll:'normal',left:{mode:'none',width:280,open:false},right:{mode:'none',width:280,open:false},chrome:{navigation:true,toolbar:true,footer:true}});}
export function validatePageLayout(raw:unknown):PageLayout{
 const v=object(raw,['version','template','scroll','left','right','chrome']);if(v.version!==1)return fail();
 const side=(raw:unknown):PageSidebar=>{const s=object(raw,['mode','width','open']);if(typeof s.width!=='number'||!Number.isInteger(s.width)||s.width<180||s.width>400)return fail();return Object.freeze({mode:choice(s.mode,['none','permanent','temporary','responsive']),width:s.width,open:bool(s.open)});};
 const c=object(v.chrome,['navigation','toolbar','footer']);return Object.freeze({version:1,template:choice(v.template,['simple','carded']),scroll:choice(v.scroll,['normal','page','content']),left:side(v.left),right:side(v.right),chrome:Object.freeze({navigation:bool(c.navigation),toolbar:bool(c.toolbar),footer:bool(c.footer)})});
}
/** Hash changes stay within the same page. Query changes require their own registered binding. */
export function pageRouteKey(route:string):string{navigationUrl(route);return route.split('#')[0];}
export function buildPageRoutes(raw:unknown,authority:PageAuthority):readonly RegisteredPageRoute[]{
 if(!Array.isArray(raw)||raw.length>1000)return fail();const seen=new Set<string>(),destinations=new Set<string>(),ids=new Set(authority.ids),routes=new Set(authority.routes);
 return Object.freeze(raw.map(input=>{
  const v=object(input,['id','route','title','breadcrumbs','layout']),key=id(v.id),route=text(v.route,512);navigationUrl(route);
  const binding=pageRouteKey(route);if(seen.has(key)||destinations.has(binding))return fail();seen.add(key);destinations.add(binding);
  const title=text(v.title,200),layout=validatePageLayout(v.layout);if(!Array.isArray(v.breadcrumbs)||v.breadcrumbs.length>12)return fail();const crumbIds=new Set<string>();
  const breadcrumbs=v.breadcrumbs.map(raw=>{
   if(!raw||typeof raw!=='object'||Array.isArray(raw))return fail();const hasRoute=Object.hasOwn(raw,'route'),c=object(raw,hasRoute?['id','label','route']:['id','label']),key=id(c.id),label=text(c.label,200);
   if(crumbIds.has(key))return fail();crumbIds.add(key);let route:string|undefined;if(hasRoute){route=text(c.route,512);navigationUrl(route);}
   return Object.freeze({id:key,label,...(route?{route}:{})});
  }).filter(c=>ids.has(c.id)&&(!c.route||routes.has(c.route)));
  return Object.freeze({id:key,route,title,breadcrumbs:Object.freeze(breadcrumbs),layout});
 }).filter(p=>ids.has(p.id)&&routes.has(p.route)));
}
export function resolvePageRoute(routes:readonly RegisteredPageRoute[],current:string):RegisteredPageRoute|undefined{const key=pageRouteKey(current);return routes.find(p=>pageRouteKey(p.route)===key);}
