import {projectDashboard} from './projection.mjs';
/** A read-only session. Hosts call invalidate on logout, tenant/role or token changes. */
export class DashboardPageSession {
  #epoch=0; #abort; #dead=false; #listeners=new Set(); #state={status:'idle',projection:null};
  constructor(family, scope, read, current, project = projectDashboard) {
    this.family=family; this.scope=Object.freeze({...scope}); this.read=read; this.current=current; this.project=project;
  }
  get state(){return structuredClone(this.#state);}
  subscribe(listener){if(this.#dead)return ()=>{};const owned=value=>listener(value);this.#listeners.add(owned);return ()=>this.#listeners.delete(owned);}
  #notify(){const state=this.#state;for(const listener of [...this.#listeners]){if(this.#state!==state)break;if(!this.#listeners.has(listener))continue;try{listener(this.state);}catch{ /* Display observers do not own transport or session state. */ }}}
  #emit(status,projection=null){this.#state={status,projection};this.#notify();}
  #matches(){try{const now=this.current();return !!now && ['userId','tenantId','role','dataset'].every(k=>now[k]===this.scope[k]);}catch{return false;}}
  invalidate(){if(this.#dead)return;this.#epoch++;this.#abort?.abort();this.#emit('denied');}
  async load(){
    if(this.#dead)return;
    const epoch=++this.#epoch;this.#abort?.abort();const abort=this.#abort=new AbortController();
    this.#emit('loading');
    try{
      if(this.#dead||epoch!==this.#epoch||abort.signal.aborted)return;
      if(!this.#matches())throw Error('scope_changed');
      if(this.#dead||epoch!==this.#epoch||abort.signal.aborted)return;
      const raw=await this.read(abort.signal);
      if(this.#dead||epoch!==this.#epoch)return;
      if(!this.#matches())throw Error('scope_changed');
      const projection=this.project(this.family,raw,this.scope);
      if(this.#dead||epoch!==this.#epoch||abort.signal.aborted)return;
      if(!this.#matches())throw Error('scope_changed');
      if(this.#dead||epoch!==this.#epoch||abort.signal.aborted)return;
      this.#emit(projection.status,projection);
    }catch(error){
      if(this.#dead||epoch!==this.#epoch)return;
      const denied=!this.#matches()||error?.message==='scope_changed'||error?.message==='denied';
      if(this.#dead||epoch!==this.#epoch)return;
      this.#emit(denied?'denied':'error');
    }
  }
  dispose(){if(this.#dead)return;this.#dead=true;this.#epoch++;this.#abort?.abort();this.#state={status:'disposed',projection:null};try{this.#notify();}finally{this.#listeners.clear();}}
}

