/** Presentation lifecycle only. Authentication, permissions and data projection belong to the caller. */
export class AsyncTask<T> {
 private generation=0;private dead=false;private abort=new AbortController();private status='idle';private data:T|null=null;private listeners=new Set<()=>void>();
 get current(){return {status:this.status,data:this.data};}
 subscribe(f:()=>void){this.listeners.add(f);return()=>{this.listeners.delete(f);};}
 private emit(){if(!this.dead)for(const f of this.listeners)f();}
 async load(scope:string,loader:(signal:AbortSignal)=>Promise<T>){if(this.dead||!scope.trim()||scope.length>1024)throw Error('invalid_async_scope');const generation=++this.generation;this.abort.abort();this.abort=new AbortController();this.status='loading';this.data=null;this.emit();try{const data=await loader(this.abort.signal);if(this.dead||generation!==this.generation)return;this.data=data;this.status='ready';}catch{if(this.dead||generation!==this.generation)return;this.data=null;this.status='error';}this.emit();}
 dispose(){if(this.dead)return;this.dead=true;this.generation++;this.abort.abort();this.status='disposed';this.data=null;this.listeners.clear();}
}
