import {requireScreenManager,ScreenConfigurationError,showScreenConfigurationError} from '../../../../packages/primecare_ui/web/screen-manager';
import {clearLayoutCustomizer} from '../../../../packages/primecare_ui/web/layout-customizer';
import {resolveManagedRoute} from '../managed-routes';

const owners=new WeakMap<HTMLElement,()=>void>();
/** Presentation ownership only. Server grants, tenant scope and validation remain authoritative. */
export function growthOwner(root:HTMLElement){
 owners.get(root)?.();
 const manager=requireScreenManager(root),entry=resolveManagedRoute('/growth',''),route=location.pathname+location.search;
 const events=root.ownerDocument.defaultView??window,resumes=new Set<()=>void>(),cleanups=new Set<()=>void>();
 let alive=true,suspended=false,generation=0,nodes=Array.from(root.childNodes),observer:MutationObserver|undefined,token:string|null=null;
 const release=()=>{for(const resolve of resumes)resolve();resumes.clear();};
 function dispose(){if(!alive)return;alive=false;suspended=false;generation++;release();observer?.disconnect();for(const cleanup of cleanups)cleanup();cleanups.clear();clearLayoutCustomizer(root,current);for(const [name,fn]of listeners)events.removeEventListener(name,fn as EventListener);if(owners.get(root)===dispose)owners.delete(root);}
 function owned(){if(!alive||owners.get(root)!==dispose)return false;const now=Array.from(root.childNodes);if(!root.isConnected||now.length!==nodes.length||now.some((node,i)=>node!==nodes[i])){dispose();return false;}return true;}
 function fail(error:unknown){if(owned()){dispose();showScreenConfigurationError(root,error);}return false;}
 function context(){
  if(!owned())return false;
  if(location.pathname!==entry.route||location.pathname+location.search!==route){dispose();root.replaceChildren();return false;}
  try{if(sessionStorage.getItem('primecare_session')!==token){dispose();root.replaceChildren();return false;}}catch{return fail(new ScreenConfigurationError('Session storage is unavailable'));}
  return true;
 }
 function current(){if(suspended||!context())return false;try{manager.enter(entry.id,entry.route);}catch(error){return fail(error);}return context();}
 const history=()=>{if(!suspended)context();};
 const hide=(event:PageTransitionEvent)=>{if(event.persisted)suspended=true;else dispose();};
 const show=(event:PageTransitionEvent)=>{if(event.persisted&&suspended&&alive){suspended=false;current();release();}};
 const listeners:[string,EventListener|((e:PageTransitionEvent)=>void)][]=[['popstate',history],['hashchange',history],['pagehide',hide],['pageshow',show]];
 owners.set(root,dispose);
 try{token=sessionStorage.getItem('primecare_session');}catch{fail(new ScreenConfigurationError('Session storage is unavailable'));}
 if(alive){observer=new MutationObserver(()=>owned());observer.observe(root.ownerDocument,{childList:true,subtree:true});for(const[name,fn]of listeners)events.addEventListener(name,fn as EventListener);}
 function redirect(){if(!current())return;dispose();root.replaceChildren();try{location.assign('/login?enable-semantics=true');}catch(error){if(root.isConnected&&!root.childNodes.length)showScreenConfigurationError(root,error);}}
 return {token,current,fail,dispose,
  onDispose(cleanup:()=>void){if(alive)cleanups.add(cleanup);else cleanup();return()=>{cleanups.delete(cleanup);};},
  wait:()=>suspended&&alive?new Promise<void>(resolve=>resumes.add(resolve)):Promise.resolve(),
  capture:()=>{const drawn=generation;return()=>drawn===generation&&current();},
  commit(action:()=>void|boolean,published?:()=>boolean){
   if(!current())return false;generation++;
   try{if(action()===false){dispose();return false;}}
   catch(error){if(alive&&owners.get(root)===dispose&&published?.()){nodes=Array.from(root.childNodes);fail(error);}else dispose();return false;}
   if(!alive||owners.get(root)!==dispose)return false;nodes=Array.from(root.childNodes);return current();
  },
  redirect,
  denied(error:unknown){if(!current())return true;if((error as {status?:number}).status!==401)return false;try{sessionStorage.removeItem('primecare_session');}catch{return !fail(new ScreenConfigurationError('Session storage is unavailable'));}dispose();root.replaceChildren();try{location.assign('/login?enable-semantics=true');}catch(error){if(root.isConnected&&!root.childNodes.length)showScreenConfigurationError(root,error);}return true;},
 };
}

/** Wrap the actual handlers after child binding, including retained property callbacks.
 * No global/prototype interception: each existing node receives one current draw lease.
 */
const bindings=new WeakMap<HTMLElement,Map<string,{wrapper:unknown;original:any}>>();
export function guardGrowthBindings(root:HTMLElement,active:()=>boolean,ready:()=>boolean,invoke:(key:string,action:()=>unknown)=>void){
 root.querySelectorAll<HTMLElement>('a,button,form,input,select,textarea').forEach(node=>{
  const previous=bindings.get(node)??new Map();
  for(const property of ['onclick','onsubmit','onchange'] as const){
   const prior=previous.get(property),action=prior&&prior.wrapper===node[property]?prior.original:node[property];if(!action&&property!=='onclick')continue;
   node[property]=function(event:Event){if(property==='onsubmit')event.preventDefault();if(!active()||!root.contains(node)||!ready()||(node as HTMLButtonElement).disabled){event.preventDefault();return;}
    if(action)invoke(node.dataset.cy??'',()=>action.call(node,event));
   };
   previous.set(property,{wrapper:node[property],original:action});
  }
  bindings.set(node,previous);
 });
}
