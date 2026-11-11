import {requireScreenManager,showScreenConfigurationError,ScreenConfigurationError} from '../../../../packages/primecare_ui/web/screen-manager';
import {resolveManagedRoute} from '../managed-routes';

const owners=new WeakMap<HTMLElement,CareOwnership>();
/** Presentation lifetime only. Existing server capabilities still authorize every read/write. */
export interface CareOwnership {
 readonly token:string|null;
 current():boolean;
 publish(work:()=>void):boolean;
 bind(root?:HTMLElement):void;
 child(root:HTMLElement):CareOwnership;
 dialog(root:HTMLDialogElement):CareOwnership;
 whenActive():Promise<void>;
 dispose():void;
 onDispose(work:()=>void):void;
 lock():()=>void;
 busy():boolean;
 unauthorized():void;
}
export function ownCareRoute(root:HTMLElement):CareOwnership {
 owners.get(root)?.dispose();
 const manager=requireScreenManager(root),route=location.pathname,documentRoute=route+location.search,entry=resolveManagedRoute(route,'');
 let token:string|null,charge:string|null;
 try{token=sessionStorage.getItem('primecare_session');charge=sessionStorage.getItem('primecare_care_charge');}catch{showScreenConfigurationError(root,new ScreenConfigurationError('Session storage is unavailable'));throw new ScreenConfigurationError('Session storage is unavailable');}
 let suspended=false,locks=0;
 const resumes=new Set<()=>void>(),target=root.ownerDocument.defaultView??window;
 const release=()=>{for(const resolve of resumes)resolve();resumes.clear();};
 const context=(owned:()=>boolean)=>{
  const retire=(error?:unknown)=>{if(!owned())return false;owner.dispose();if(error)showScreenConfigurationError(root,error);else root.replaceChildren();return false;};
  if(!['/care','/psw'].includes(route)||location.pathname+location.search!==documentRoute)return retire();
  try{if(sessionStorage.getItem('primecare_session')!==token||sessionStorage.getItem('primecare_care_charge')!==charge)return retire();}
  catch{return retire(new ScreenConfigurationError('Session storage is unavailable'));}
  try{manager.enter(entry.id,entry.route);}catch(error){return retire(error);}
  // A synchronous presentation callback may replace the host as well as change
  // navigation/session. Never clear that replacement on behalf of the old view.
  if(!owned())return false;
  if(location.pathname+location.search!==documentRoute)return retire();
  try{if(sessionStorage.getItem('primecare_session')!==token||sessionStorage.getItem('primecare_care_charge')!==charge)return retire();}
  catch{return retire(new ScreenConfigurationError('Session storage is unavailable'));}
  return true;
 };
 const owner=makeOwner(root,token,(owned)=>!suspended&&context(owned),()=>suspended?new Promise<void>(resolve=>resumes.add(resolve)):Promise.resolve(),()=>locks>0,()=>{locks++;let held=true;return()=>{if(held){held=false;locks--;}};},()=>{
  if(!owner.current())return;
  try{sessionStorage.removeItem('primecare_session');}catch{if(owner.current()){owner.dispose();showScreenConfigurationError(root,new ScreenConfigurationError('Session storage is unavailable'));}return;}
  owner.dispose();root.replaceChildren();
  try{location.assign('/login?enable-semantics=true');}catch(error){if(root.isConnected&&!root.childNodes.length)showScreenConfigurationError(root,error);}
 });
 const history=()=>{if(!suspended)owner.current();};
 const leave=(event:PageTransitionEvent)=>{if(event.persisted)suspended=true;else owner.dispose();};
 const resume=(event:PageTransitionEvent)=>{if(event.persisted&&suspended){suspended=false;owner.current();release();}};
 target.addEventListener('popstate',history);target.addEventListener('hashchange',history);target.addEventListener('pagehide',leave);target.addEventListener('pageshow',resume);
 owner.onDispose(()=>{suspended=false;release();target.removeEventListener('popstate',history);target.removeEventListener('hashchange',history);target.removeEventListener('pagehide',leave);target.removeEventListener('pageshow',resume);});
 return owner;
}
function makeOwner(root:HTMLElement,token:string|null,context:(owned:()=>boolean)=>boolean,wait:()=>Promise<void>,busy:()=>boolean,lock:()=>()=>void,unauthorized:()=>void):CareOwnership {
 owners.get(root)?.dispose();
 let alive=true,nodes=Array.from(root.childNodes);
 const cleanups=new Set<()=>void>();
 const bindings=new WeakMap<HTMLElement,Map<string,unknown>>();
 function owned(){
  if(!alive||owners.get(root)!==owner)return false;
  const next=Array.from(root.childNodes);
  if(!root.isConnected||next.length!==nodes.length||next.some((node,i)=>node!==nodes[i])){owner.dispose();return false;}
  return true;
 }
 const observer=new MutationObserver(()=>{owned();});
 const owner:CareOwnership={token,
  current(){return owned()&&context(owned)&&owned();},
  publish(work){if(!owner.current())return false;work();nodes=Array.from(root.childNodes);return true;},
  bind(host=root){
   for(const node of host.querySelectorAll<HTMLElement>('button,input,select,textarea,form,a')){
    for(const property of ['onclick','onchange','oninput','onsubmit'] as const){
     const prior=node[property];
     const known=bindings.get(node)??new Map<string,unknown>();if(known.get(property)===prior)continue;
     if(!prior&&!(property==='onclick'&&node.tagName==='A'))continue;
     node[property]=function(event:Event){
      const hidden=()=>{for(let ancestor:HTMLElement|null=node;ancestor;ancestor=ancestor.parentElement)if(ancestor.hidden)return true;return false;};
      if(!owner.current()||hidden()||busy()||!node.isConnected||!root.contains(node)||(node as HTMLButtonElement).disabled){event.preventDefault();return;}
      return prior?.call(this,event as never);
     };
     known.set(property,node[property]);bindings.set(node,known);
    }
   }
  },
  child(host){if(!owner.current()||!root.contains(host))throw Error('Care renderer is no longer current');const child=makeOwner(host,token,()=>owner.current()&&root.contains(host),()=>owner.whenActive(),busy,lock,()=>{if(child.current())owner.unauthorized();});const retire=()=>child.dispose();owner.onDispose(retire);child.onDispose(()=>cleanups.delete(retire));return child;},
  dialog(host){
   if(!owner.current()||host.ownerDocument!==root.ownerDocument||!host.isConnected||!host.open)throw Error('Care dialog is no longer current');
   const dialog=makeOwner(host,token,()=>{if(!host.open){dialog.dispose();return false;}return owner.current();},()=>owner.whenActive(),busy,lock,()=>{if(dialog.current())owner.unauthorized();});
   const close=()=>dialog.dispose();host.addEventListener('close',close);
   dialog.onDispose(()=>{host.removeEventListener('close',close);host.close();host.remove();});
   const retire=()=>dialog.dispose();owner.onDispose(retire);dialog.onDispose(()=>cleanups.delete(retire));return dialog;
  },
  async whenActive(){if(!alive)return;await wait();},
  dispose(){if(!alive)return;alive=false;observer.disconnect();for(const cleanup of cleanups)cleanup();cleanups.clear();if(owners.get(root)===owner)owners.delete(root);},
  onDispose(work){if(alive)cleanups.add(work);else work();},lock,busy,unauthorized,
 };
 owners.set(root,owner);observer.observe(root.ownerDocument,{childList:true,subtree:true});
 return owner;
}
