import {utilityItems,utilityKinds,utilityDestinations,searchUtilityDestinations,type UtilityKind,type UtilityItem,type UtilityDestination} from '../../../domain/src/shell_utilities';
import {PreferenceSyncClient,preferenceScope,type PreferenceScope} from '../preference-sync/client';
export * from '../../../domain/src/shell_utilities';
export type UtilityPort={load:(signal:AbortSignal)=>Promise<unknown>;markRead?:(id:string,read:boolean,signal:AbortSignal)=>Promise<unknown>;activate?:(id:string)=>void};
export type UtilityState={status:'idle'|'loading'|'ready'|'error'|'unavailable';error:string|null;items:UtilityItem[];busy:boolean};
/** Ports must be bound by an authorized host to registered business resources, never demo fallback data. */
export class ShellUtilitiesController {
 readonly scope:PreferenceScope;readonly destinations:readonly UtilityDestination[];
 private ports:Partial<Record<UtilityKind,UtilityPort>>;private states={} as Record<UtilityKind,UtilityState>;private dead=false;private abort=new AbortController();private listeners=new Set<()=>void>();
 constructor(scope:PreferenceScope,ports:Partial<Record<UtilityKind,UtilityPort>>,readonly favourites:PreferenceSyncClient,destinations:readonly UtilityDestination[],private navigate:(id:string)=>void){
  this.scope=Object.freeze(preferenceScope(scope));if(JSON.stringify(this.scope)!==JSON.stringify(preferenceScope(favourites.binding.scope))||favourites.binding.kind!=='shortcuts'||favourites.binding.resource!=='navigation')throw Error('utility_scope_mismatch');this.destinations=utilityDestinations(destinations,favourites.binding.policy.screenIds);this.ports=Object.fromEntries(Object.entries(ports).map(([k,p])=>[k,{...p}]));for(const k of utilityKinds)this.states[k]={status:this.ports[k]?'idle':'unavailable',error:null,items:[],busy:false};
 }
 subscribe(listener:()=>void){this.listeners.add(listener);return ()=>{this.listeners.delete(listener);};}
 private emit(){if(!this.dead)for(const f of this.listeners)f();}
 get current(){return structuredClone(this.states);}
 canActivate(kind:UtilityKind){return !!this.ports[kind]?.activate;}
 canMarkRead(kind:UtilityKind){return !!this.ports[kind]?.markRead;}
 async load(kind:UtilityKind){if(this.dead||this.states[kind].busy)throw Error('utility_unavailable');const s=this.states[kind],port=this.ports[kind];if(!port){s.status='unavailable';this.emit();return;}s.busy=true;s.status='loading';s.error=null;this.emit();try{const items=utilityItems(await port.load(this.abort.signal));if(this.dead)return;s.items=items;s.status='ready';}catch{if(this.dead)return;s.status='error';s.error='resource_unavailable';s.items=[];}finally{if(!this.dead){s.busy=false;this.emit();}}}
 async markRead(kind:UtilityKind,id:string,read:boolean){if(this.dead||this.states[kind].busy)throw Error('utility_unavailable');const s=this.states[kind],port=this.ports[kind],item=s.items.find(i=>i.id===id);if(!port?.markRead||!item||item.read===null)throw Error('action_unavailable');s.busy=true;s.error=null;this.emit();try{const result=utilityItems([await port.markRead(id,read,this.abort.signal)])[0];if(result.id!==id||result.read!==read)throw Error();if(this.dead)return;s.items=s.items.map(i=>i.id===id?result:i);s.status='ready';}catch{if(this.dead)return;s.status='error';s.error='action_unavailable';}finally{if(!this.dead){s.busy=false;this.emit();}}}
 activate(kind:UtilityKind,id:string){if(this.dead||!this.states[kind].items.some(i=>i.id===id)||!this.ports[kind]?.activate)throw Error('action_unavailable');this.ports[kind]!.activate!(id);}
 search(query:string,locale='en'){if(this.dead)throw Error('utility_disposed');return searchUtilityDestinations(this.destinations,query,locale);}
 open(id:string){if(this.dead||!this.destinations.some(n=>n.id===id&&!n.disabled))throw Error('destination_unavailable');this.navigate(id);}
 async toggle(id:string){if(this.dead||!this.destinations.some(n=>n.id===id&&!n.disabled))throw Error('destination_unavailable');const draft=this.favourites.current.draft as {version:1;screenIds:string[]}|null;const ids=[...(draft?.screenIds??[])];const at=ids.indexOf(id);if(at<0)ids.push(id);else ids.splice(at,1);await this.favourites.edit({version:1,screenIds:ids});this.emit();}
 async preference(action:'load'|'save'|'retryPending'|'acceptRemote'|'keepLocal'){if(this.dead)throw Error('utility_disposed');try{const work=this.favourites[action]();this.emit();await work;}finally{this.emit();}}
 async dispose(){if(this.dead)return;this.dead=true;this.abort.abort();this.listeners.clear();for(const k of utilityKinds)this.states[k]={status:'unavailable',error:null,items:[],busy:false};await this.favourites.dispose();}
}
