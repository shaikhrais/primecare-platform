/** Account-bound draft for the existing tenant dashboard default-view preference. */
export type TenantPreference={view:string;version:number};
export type TenantPreferenceScope={tenantId:string;userId:string;role:string;dataset:'live'|'demo'};
type StoragePort=Pick<Storage,'getItem'|'setItem'|'removeItem'>;
const equal=(a:TenantPreference|null,b:TenantPreference|null)=>a?.view===b?.view&&a?.version===b?.version;
function valid(v:unknown):v is TenantPreference{return !!v&&typeof v==='object'&&!Array.isArray(v)&&Object.keys(v).sort().join(',')==='version,view'&&typeof (v as TenantPreference).view==='string'&&/^[a-z][a-z0-9_]{0,63}$/.test((v as TenantPreference).view)&&Number.isSafeInteger((v as TenantPreference).version)&&(v as TenantPreference).version>0;}
/** Refreshes never rebase an unsaved choice over another device's revision. */
export class TenantPreferenceDraft {
 readonly key:string;
 private draft:TenantPreference|null=null;
 private failure:string|null=null;
 private invalid=false;
 private pending:TenantPreference|null=null;
 constructor(scope:TenantPreferenceScope,private storage:StoragePort){
  if(!scope||!['live','demo'].includes(scope.dataset)||[scope.tenantId,scope.userId,scope.role].some(v=>typeof v!=='string'||!v.trim()||v.length>200||/[\x00-\x1f\x7f]/.test(v)))throw Error('Invalid preference scope');
  this.key='primecare.tenant-default-view-draft.v1:'+JSON.stringify([scope.tenantId,scope.userId,scope.role,scope.dataset]);
  try{const raw=storage.getItem(this.key);if(raw!==null){if(raw.length>2048)throw Error();const value=JSON.parse(raw);if(!valid(value))throw Error();this.draft={...value};}}
  catch{this.invalid=true;this.failure='draft_unavailable';}
 }
 get current(){return this.draft?{...this.draft}:null;}
 get error(){return this.failure;}
 get unresolved(){return this.invalid||this.draft!==null;}
 private persist(){try{if(this.draft)this.storage.setItem(this.key,JSON.stringify(this.draft));else this.storage.removeItem(this.key);this.failure=null;}catch{this.failure='draft_cache_unavailable';}}
 value(saved:TenantPreference,allowed:readonly string[]):string{
  if(!valid(saved))throw Error('Invalid saved preference');
  if(this.draft&&!allowed.includes(this.draft.view)){this.failure='draft_view_revoked';return saved.view;}
  return this.draft?.view??saved.view;
 }
 edit(view:string,saved:TenantPreference,allowed:readonly string[]){
  if(this.invalid||!allowed.includes(view)||!valid({...saved,view}))throw Error('Resolve unavailable preference draft first');
  this.draft=view===saved.view&&!this.pending?null:{view,version:this.draft?.version??saved.version};this.persist();
 }
 submission(saved:TenantPreference,allowed:readonly string[]):TenantPreference{
  if(this.invalid||this.draft&&!allowed.includes(this.draft.view))throw Error('Resolve unavailable preference draft first');
  const selected=this.draft??saved;if(!valid(selected)||!allowed.includes(selected.view))throw Error('Invalid preference');this.pending={...selected};return {...selected};
 }
 acknowledge(submitted:TenantPreference,saved:TenantPreference){
  if(!valid(submitted)||!valid(saved)||saved.version!==submitted.version+1||saved.view!==submitted.view)throw Error('Preference acknowledgement mismatch');
  if(equal(this.draft,submitted))this.draft=null;
  else if(this.draft?.version===submitted.version)this.draft={...this.draft,version:saved.version};
  this.pending=null;this.persist();
 }
 /** Explicit local discard only. Failure retains the tab's unsaved choice. */
 discard(){this.storage.removeItem(this.key);this.draft=null;this.invalid=false;this.failure=null;this.pending=null;}
}
