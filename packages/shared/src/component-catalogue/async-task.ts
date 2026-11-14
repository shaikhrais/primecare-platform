/** Presentation lifecycle only. Authentication, permissions and data projection belong to the caller. */
export class AsyncTask<T> {
 private generation=0;private dead=false;private abort=new AbortController();private status='idle';private data:T|null=null;private listeners=new Set<()=>void>();
 get current(){return {status:this.status,data:this.data};}
 subscribe(f:()=>void){if(this.dead)return()=>{};const subscription=()=>f();this.listeners.add(subscription);return()=>{this.listeners.delete(subscription);};}
 private emit(){if(this.dead)return;for(const subscription of [...this.listeners]){if(this.dead)break;if(this.listeners.has(subscription)){try{subscription();}catch{/* Presentation observers cannot replace model or persistence outcomes. */}}}}
 async load(scope:string,loader:(signal:AbortSignal)=>Promise<T>){if(this.dead||!scope.trim()||scope.length>1024)throw Error('invalid_async_scope');const generation=++this.generation,previous=this.abort,controller=new AbortController();this.abort=controller;previous.abort();if(this.dead||generation!==this.generation)return;this.status='loading';this.data=null;this.emit();if(this.dead||generation!==this.generation)return;try{const data=await loader(controller.signal);if(this.dead||generation!==this.generation)return;this.data=data;this.status='ready';}catch{if(this.dead||generation!==this.generation)return;this.data=null;this.status='error';}this.emit();}
 dispose(){if(this.dead)return;this.dead=true;this.generation++;this.abort.abort();this.status='disposed';this.data=null;this.listeners.clear();}
}
