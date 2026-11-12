import {PreferenceScope,preferenceScope,samePreferenceScope,canonicalPreference} from '../../../domain/src/preference_sync';
import {DashboardLayout,WidgetSpec,ViewportSpec,validateRegistry,validateDashboard} from '../../../domain/src/dashboard_widgets';
export type DashboardSnapshot={scope:PreferenceScope;resource:string;revision:number;document:DashboardLayout|null};
export type DashboardPreferencePort={read:(scope:PreferenceScope,resource:string,signal:AbortSignal)=>Promise<DashboardSnapshot>;write:(request:{scope:PreferenceScope;resource:string;revision:number;document:DashboardLayout;requestId:string},signal:AbortSignal)=>Promise<DashboardSnapshot>};
/** No HTTP binding: API 777 has no approved dashboard kind. Host ports must enforce a registered server contract. */
export class DashboardSession {
 readonly scope:PreferenceScope;readonly widgets:readonly WidgetSpec[];readonly views:readonly ViewportSpec[];readonly #defaults:DashboardLayout;
 private pending:{document:DashboardLayout;revision:number;requestId:string;edits:number;acknowledged?:DashboardSnapshot}|null=null;private doc:DashboardLayout;private revision=0;private knownContent:string|undefined;private loaded=false;private edits=0;private epoch=0;private dead=false;private abort=new AbortController();private listeners=new Set<()=>void>();status:'idle'|'loading'|'ready'|'dirty'|'saving'|'clean'|'conflict'|'error'|'unavailable'|'disposed';
 constructor(scope:PreferenceScope,readonly resource:string,widgets:readonly WidgetSpec[],views:readonly ViewportSpec[],defaults:DashboardLayout,readonly port?:DashboardPreferencePort,private uuid:()=>string=()=>crypto.randomUUID()) {this.scope=Object.freeze(preferenceScope(scope));if(!/^[a-z][a-z0-9-]{0,63}$/.test(resource))throw Error('invalid_dashboard_resource');const r=validateRegistry(widgets,views);this.widgets=Object.freeze(r.widgets.map(w=>Object.freeze({...w,views:Object.freeze(w.views) as unknown as string[]})));this.views=Object.freeze(r.views.map(v=>Object.freeze(v)));this.#defaults=validateDashboard(defaults,this.widgets,this.views);this.doc=structuredClone(this.#defaults);this.status=port?'idle':'unavailable';}
 /** Callers may edit a reset draft without changing the validated fallback. */
 get defaults():DashboardLayout{return structuredClone(this.#defaults);}
 get current(){return{document:structuredClone(this.doc),revision:this.revision,loaded:this.loaded,status:this.status,pending:this.pending!==null};}
 subscribe(f:()=>void){this.listeners.add(f);return()=>{this.listeners.delete(f);};}private emit(){if(!this.dead)for(const f of this.listeners)f();}
 private snapshot(raw:DashboardSnapshot){if(!raw||Object.keys(raw).sort().join(',')!=='document,resource,revision,scope'||!samePreferenceScope(preferenceScope(raw.scope),this.scope)||raw.resource!==this.resource||!Number.isSafeInteger(raw.revision)||raw.revision<0||raw.revision===0&&raw.document!==null)throw Error('invalid_dashboard_snapshot');return{...raw,document:raw.document===null?null:validateDashboard(raw.document,this.widgets,this.views)};}
 edit(raw:unknown){if(this.dead||this.status==='loading')throw Error('dashboard_busy');this.doc=validateDashboard(raw,this.widgets,this.views);this.edits++;if(this.status!=='saving'&&this.status!=='conflict')this.status='dirty';this.emit();}
 async load(){if(this.dead||['loading','saving'].includes(this.status)||!this.port)return;if(this.pending)throw Error('dashboard_pending_resolution');const g=++this.epoch;this.status='loading';this.emit();if(this.dead||g!==this.epoch)return;try{const snapshot=this.snapshot(await this.port.read(this.scope,this.resource,this.abort.signal));if(this.dead||g!==this.epoch)return;if(snapshot.revision<this.revision)throw Error('stale_dashboard_snapshot');const content=canonicalPreference(snapshot.document);if(this.loaded&&snapshot.revision===this.revision&&content!==this.knownContent)throw Error('inconsistent_dashboard_snapshot');this.revision=snapshot.revision;this.knownContent=content;this.doc=snapshot.document??structuredClone(this.#defaults);this.loaded=true;this.status=snapshot.document?'clean':'ready';}catch{if(this.dead||g!==this.epoch)return;this.status='error';}this.emit();}
 async save(){
  if(this.dead||!this.port||!this.loaded||this.pending||['loading','saving','conflict'].includes(this.status))throw Error('dashboard_unavailable');
  if(this.revision>=Number.MAX_SAFE_INTEGER)throw Error('revision_exhausted');
  const generation=this.epoch,requestId=this.uuid();if(this.dead||generation!==this.epoch)throw Error('dashboard_unavailable');if(!/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(requestId))throw Error('invalid_request_id');
  this.pending={document:structuredClone(this.doc),revision:this.revision,requestId,edits:this.edits};await this.sendPending();
 }
 async retryPending(){if(this.dead||!this.port||!this.pending||['loading','saving','conflict'].includes(this.status))throw Error('dashboard_unavailable');await this.sendPending();}
 private async sendPending(){
  const g=++this.epoch,pending=this.pending!;this.status='saving';this.emit();if(this.dead||g!==this.epoch)return;
  try{
   if(!pending.acknowledged){
    const acknowledged=this.snapshot(await this.port!.write({scope:this.scope,resource:this.resource,revision:pending.revision,document:structuredClone(pending.document),requestId:pending.requestId},this.abort.signal));
    if(this.dead||g!==this.epoch)return;
    if(acknowledged.revision!==pending.revision+1||canonicalPreference(acknowledged.document)!==canonicalPreference(pending.document))throw Error('invalid_acknowledgement');
    pending.acknowledged=structuredClone(acknowledged);
   }
   const verified=this.snapshot(await this.port!.read(this.scope,this.resource,this.abort.signal));if(this.dead||g!==this.epoch)return;
   if(verified.revision<pending.acknowledged.revision)throw Error('stale_dashboard_readback');
   if(verified.revision!==pending.acknowledged.revision||canonicalPreference(verified.document)!==canonicalPreference(pending.document))throw Object.assign(Error('readback_mismatch'),{code:'revision_conflict'});
   this.revision=verified.revision;this.knownContent=canonicalPreference(verified.document);this.pending=null;this.status=this.edits===pending.edits?'clean':'dirty';
  }catch(e){if(this.dead||g!==this.epoch)return;this.status=(e as {code?:string})?.code==='revision_conflict'?'conflict':'error';if(this.status==='conflict')this.pending=null;}
  this.emit();if(this.status==='error'||this.status==='conflict')throw Error('dashboard_save_failed');
 }

 dispose(){this.dead=true;this.epoch++;this.abort.abort();this.pending=null;this.status='disposed';this.listeners.clear();}
}
