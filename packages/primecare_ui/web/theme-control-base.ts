/** Cleanup for existing scoped controls and non-widget shell adapters. No authority is granted. */
export function cleanupOwnedResources(cleanups:readonly (()=>void)[]):void {
 let failure:{error:unknown}|undefined;
 for(const cleanup of cleanups){try{cleanup();}catch(error){failure??={error};}}
 if(failure)throw failure.error;
}
/** Shared lifecycle for a scoped control group. Hosts remain responsible for authorization. */
export abstract class ThemeControlBase {
 protected readonly abort=new AbortController();
 protected dead=false;
 readonly root:HTMLElement;
 protected constructor(root:HTMLElement) {this.root=root;}
 /** Invalidate callbacks and remove listeners once; subclasses release their own resources. */
 protected endControlScope():boolean {
  if(this.dead)return false;
  this.dead=true;
  this.abort.abort();
  return true;
 }
 /** Release all owned resources and report the first failure, including thrown null/undefined. */
 protected cleanupControlResources(cleanups:readonly (()=>void)[]):void {
  cleanupOwnedResources(cleanups);
 }
 /** Retire callbacks before cleanup. Reentrant or repeated disposal cannot touch a replacement. */
 protected disposeControlScope(cleanups:readonly (()=>void)[]):void {
  if(this.dead)return;
  this.cleanupControlResources([()=>{this.endControlScope();},...cleanups]);
 }
 abstract dispose():void;
}
