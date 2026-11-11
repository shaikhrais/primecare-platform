import {requireScreenManager,ScreenConfigurationError,showScreenConfigurationError} from '../../../packages/primecare_ui/web/screen-manager';
import {clearLayoutCustomizer} from '../../../packages/primecare_ui/web/layout-customizer';
import {resolveManagedRoute} from './managed-routes';

const owners=new WeakMap<HTMLElement,()=>void>();
/** A presentation lease, not permission to access maintenance data. */
export function maintenanceOwner(root:HTMLElement){
 owners.get(root)?.();
 const entry=resolveManagedRoute('/maintenance/configuration',''),route=location.pathname+location.search;
 const events=root.ownerDocument.defaultView??window,resumes=new Set<()=>void>();
 let alive=true,suspended=false,generation=0,token:string|null=null,shellLease:(()=>boolean)|undefined;
 let frame=root.firstElementChild,main=root.querySelector('main'),children=Array.from(main?.childNodes??[]);
 let observer:MutationObserver|undefined,manager:ReturnType<typeof requireScreenManager>|undefined;
 const release=()=>{for(const resolve of resumes)resolve();resumes.clear();};
 const clearShell=()=>{if(shellLease)clearLayoutCustomizer(root,shellLease);shellLease=undefined;};
 function dispose(){if(!alive)return;alive=false;generation++;release();observer?.disconnect();clearShell();for(const[name,fn]of listeners)events.removeEventListener(name,fn as EventListener);if(owners.get(root)===dispose)owners.delete(root);}
 function owned(){
  if(!alive||owners.get(root)!==dispose)return false;
  const now=Array.from(main?.childNodes??[]);
  if(!root.isConnected||root.firstElementChild!==frame||root.querySelector('main')!==main||now.length!==children.length||now.some((node,i)=>node!==children[i])){dispose();return false;}
  return true;
 }
 function fail(error:unknown){if(owned()){dispose();showScreenConfigurationError(root,error);}return false;}
 function context(expectedToken=token){
  if(!owned())return false;
  if(location.pathname!==entry.route||location.pathname+location.search!==route){dispose();root.replaceChildren();return false;}
  try{if(sessionStorage.getItem('primecare_session')!==expectedToken){dispose();root.replaceChildren();return false;}}catch{return fail(new ScreenConfigurationError('Session storage is unavailable'));}
  return true;
 }
 function check(expectedToken=token,allowSuspended=false){
  if(suspended&&!allowSuspended||!context(expectedToken))return false;
  try{manager!.enter(entry.id,entry.route);}catch(error){return fail(error);}
  return context(expectedToken);
 }
 const current=()=>check();
 const history=()=>{if(!suspended)context();};
 const hide=(event:PageTransitionEvent)=>{if(event.persisted)suspended=true;else dispose();};
 const show=(event:PageTransitionEvent)=>{if(event.persisted&&suspended&&alive){suspended=false;current();release();}};
 const listeners:[string,EventListener|((e:PageTransitionEvent)=>void)][]=[['popstate',history],['hashchange',history],['storage',history],['pagehide',hide],['pageshow',show]];
 owners.set(root,dispose);
 try{manager=requireScreenManager(root);token=sessionStorage.getItem('primecare_session');}catch(error){if(manager)fail(error);else dispose();}
 if(alive){observer=new MutationObserver(()=>owned());observer.observe(root.ownerDocument,{childList:true,subtree:true});for(const[name,fn]of listeners)events.addEventListener(name,fn as EventListener);}
 function navigate(url:string,signedOut=false){
  if(!check(signedOut?null:token))return;
  dispose();root.replaceChildren();
  try{location.assign(url);}catch(error){if(root.isConnected&&!root.childNodes.length&&!owners.has(root))showScreenConfigurationError(root,error);}
 }
 return {token,current,dispose,fail,navigate,
  transportCurrent:()=>check(token,true),
  sessionEnded(){if(context(null))token=null;},
  wait:()=>suspended&&alive?new Promise<void>(resolve=>resumes.add(resolve)):Promise.resolve(),
  capture:()=>{const draw=generation;return()=>draw===generation&&current();},
  shell(lease:()=>boolean){shellLease=lease;},
  paint(action:()=>void){
   if(!current())return false;
   generation++;clearShell();
   try{action();}catch(error){dispose();throw error;}
   if(!alive||owners.get(root)!==dispose)return false;
   frame=root.firstElementChild;main=root.querySelector('main');children=Array.from(main?.childNodes??[]);
   return current();
  },
 };
}
