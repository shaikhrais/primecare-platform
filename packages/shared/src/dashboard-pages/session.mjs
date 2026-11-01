import {projectDashboard} from './projection.mjs';
/** A read-only session. Hosts call invalidate on logout, tenant/role or token changes. */
export class DashboardPageSession {
  #epoch=0; #abort; #dead=false; #listeners=new Set(); #state={status:'idle',projection:null};
  constructor(family, scope, read, current) {
    this.family=family; this.scope=Object.freeze({...scope}); this.read=read; this.current=current;
  }
  get state(){return structuredClone(this.#state);}
  subscribe(listener){this.#listeners.add(listener);return ()=>this.#listeners.delete(listener);}
  #emit(status,projection=null){this.#state={status,projection};for(const listener of this.#listeners)listener(this.state);}
  #matches(){const now=this.current();return now && ['userId','tenantId','role','dataset'].every(k=>now[k]===this.scope[k]);}
  invalidate(){if(this.#dead)return;this.#epoch++;this.#abort?.abort();this.#emit('denied');}
  async load(){
    if(this.#dead)return;
    const epoch=++this.#epoch;this.#abort?.abort();const abort=this.#abort=new AbortController();
    this.#emit('loading');
    try{
      if(!this.#matches())throw Error('scope_changed');
      const raw=await this.read(abort.signal);
      if(this.#dead||epoch!==this.#epoch)return;
      if(!this.#matches())throw Error('scope_changed');
      const projection=projectDashboard(this.family,raw,this.scope);
      this.#emit(projection.status,projection);
    }catch(error){
      if(this.#dead||epoch!==this.#epoch)return;
      this.#emit(error?.message==='scope_changed'||error?.message==='denied'?'denied':'error');
    }
  }
  dispose(){if(this.#dead)return;this.#dead=true;this.#epoch++;this.#abort?.abort();this.#state={status:'disposed',projection:null};for(const listener of this.#listeners)listener(this.state);this.#listeners.clear();}
}
