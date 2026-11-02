/** Account-bound draft and durable retry for the existing tenant default-view preference. */
export type TenantPreference={view:string;version:number};
export type TenantPreferenceScope={tenantId:string;userId:string;role:string;dataset:'live'|'demo'};
export type TenantPreferenceCommand={requestId:string;body:{action:'preferences';version:number;value:{view:string};workspaceVersion?:number}};
type StoragePort=Pick<Storage,'getItem'|'setItem'|'removeItem'>;
const equal=(a:TenantPreference|null,b:TenantPreference|null)=>a?.view===b?.view&&a?.version===b?.version;
const keys=(v:unknown,names:string[]):v is Record<string,unknown>=>!!v&&typeof v==='object'&&!Array.isArray(v)&&Object.keys(v).sort().join(',')===[...names].sort().join(',');
function valid(v:unknown):v is TenantPreference{return keys(v,['view','version'])&&typeof v.view==='string'&&/^[a-z][a-z0-9_]{0,63}$/.test(v.view)&&Number.isSafeInteger(v.version)&&Number(v.version)>0;}
function command(raw:unknown,dataset:'live'|'demo'):TenantPreferenceCommand{
 if(!keys(raw,['requestId','body'])||typeof raw.requestId!=='string'||!/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/.test(raw.requestId))throw Error('Invalid pending preference');
 const body=raw.body;
 if(!keys(body,['action','version','value',...(dataset==='demo'?['workspaceVersion']:[])])||body.action!=='preferences'||!keys(body.value,['view'])||!valid({view:body.value.view,version:body.version})||dataset==='demo'&&(!Number.isSafeInteger(body.workspaceVersion)||Number(body.workspaceVersion)<0))throw Error('Invalid pending preference');
 return structuredClone(raw) as TenantPreferenceCommand;
}
/** Reads never rebase an unsaved choice or automatically retry a mutation. */
export class TenantPreferenceDraft {
 readonly key:string;
 private draft:TenantPreference|null=null;
 private failure:string|null=null;
 private invalid=false;
 private submitted:TenantPreference|null=null;
 private pending:TenantPreferenceCommand|null=null;
 private rejected=false;
 constructor(private scope:TenantPreferenceScope,private storage:StoragePort,private uuid:()=>string=()=>crypto.randomUUID()){
  if(!scope||!['live','demo'].includes(scope.dataset)||[scope.tenantId,scope.userId,scope.role].some(v=>typeof v!=='string'||!v.trim()||v.length>200||/[\x00-\x1f\x7f]/.test(v)))throw Error('Invalid preference scope');
  this.scope={...scope};this.key='primecare.tenant-default-view-draft.v1:'+JSON.stringify([scope.tenantId,scope.userId,scope.role,scope.dataset]);
  try{
   const raw=storage.getItem(this.key);if(raw===null)return;if(raw.length>4096)throw Error();const value=JSON.parse(raw);
   // Legacy drafts already carry the complete account/role/dataset scope in this exact key.
   if(valid(value)){this.draft={...value};return;}
   if(!keys(value,['format','draft','pending'])||value.format!==2||value.draft!==null&&!valid(value.draft))throw Error();
   this.draft=value.draft===null?null:{...value.draft as TenantPreference};
   this.pending=value.pending===null?null:command(value.pending,this.scope.dataset);
   if(this.pending){if(!this.draft||this.draft.version!==this.pending.body.version)throw Error();this.submitted={view:this.pending.body.value.view,version:this.pending.body.version};}
  }catch{this.invalid=true;this.failure='draft_unavailable';this.draft=null;this.pending=null;}
 }
 get current(){return this.draft?{...this.draft}:null;}
 get error(){return this.failure;}
 get pendingRequest(){return this.pending?structuredClone(this.pending):null;}
 get pendingWasRejected(){return this.rejected;}
 get unresolved(){return this.invalid||this.draft!==null||this.pending!==null;}
 private persist(required=false){
  try{if(this.draft||this.pending)this.storage.setItem(this.key,JSON.stringify({format:2,draft:this.draft,pending:this.pending}));else this.storage.removeItem(this.key);this.failure=null;}
  catch{this.failure='draft_cache_unavailable';if(required)throw Error('Unable to durably record this preference request');}
 }
 value(saved:TenantPreference,allowed:readonly string[]):string{
  if(!valid(saved))throw Error('Invalid saved preference');const fallback=allowed.includes(saved.view)?saved.view:allowed[0];if(!fallback)throw Error('No allowed preference view');
  if(this.draft&&!allowed.includes(this.draft.view)){this.failure='draft_view_revoked';return fallback;}return this.draft?.view??fallback;
 }
 edit(view:string,saved:TenantPreference,allowed:readonly string[]){
  if(this.invalid||!allowed.includes(view)||!valid({...saved,view}))throw Error('Resolve unavailable preference draft first');
  this.draft=view===saved.view&&!this.submitted?null:{view,version:this.draft?.version??saved.version};this.persist();
 }
 submission(saved:TenantPreference,allowed:readonly string[]):TenantPreference{
  if(this.invalid||this.draft&&!allowed.includes(this.draft.view))throw Error('Resolve unavailable preference draft first');
  const selected=this.draft??saved;if(!valid(selected)||!allowed.includes(selected.view))throw Error('Invalid preference');this.submitted={...selected};return {...selected};
 }
 /** Persist the immutable request before the host may dispatch it. Replays retain demo version too. */
 prepare(saved:TenantPreference,allowed:readonly string[],workspaceVersion?:number):TenantPreferenceCommand{
  if(this.invalid)throw Error('Resolve unavailable preference draft first');
  if(!this.pending){const selected=this.submission(saved,allowed);this.draft??={...selected};this.pending=command({requestId:this.uuid(),body:{action:'preferences',version:selected.version,value:{view:selected.view},...(this.scope.dataset==='demo'?{workspaceVersion}:{})}},this.scope.dataset);}
  if(!allowed.includes(this.pending.body.value.view)){this.failure='pending_view_revoked';throw Error('Pending preference view is no longer allowed');}
  this.persist(true);return structuredClone(this.pending);
 }
 acknowledge(submitted:TenantPreference,saved:TenantPreference,requestId?:string){
  if(!valid(submitted)||!valid(saved)||saved.version!==submitted.version+1||saved.view!==submitted.view||this.pending&&(requestId!==this.pending.requestId||!equal(submitted,{view:this.pending.body.value.view,version:this.pending.body.version})))throw Error('Preference acknowledgement mismatch');
  if(equal(this.draft,submitted))this.draft=null;else if(this.draft?.version===submitted.version)this.draft={...this.draft,version:saved.version};
  this.pending=null;this.submitted=null;this.rejected=false;this.persist();
 }
 /** Only a definitive server rejection permits explicit local discard of an uncertain request. */
 rejectPending(requestId:string){if(this.pending?.requestId!==requestId)throw Error('Unknown preference request');this.rejected=true;}
 discard(){if(this.pending&&!this.rejected&&this.failure!=='pending_view_revoked')throw Error('Confirm the pending preference save first');this.storage.removeItem(this.key);this.draft=null;this.invalid=false;this.failure=null;this.submitted=null;this.pending=null;this.rejected=false;}
}
