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
 abstract dispose():void;
}
