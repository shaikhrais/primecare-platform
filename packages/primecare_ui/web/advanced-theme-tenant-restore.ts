import {previewAdvancedLibraryInLegacyEditor} from '../../domain/src/advanced-theme-legacy-preview';
import {canonicalPreference, samePreferenceScope} from '../../domain/src/preference_sync';
import type {PreferenceSyncClient} from '../../shared/src/preference-sync/client';

/** Read-only review for a clean, authenticated account snapshot; never writes browser storage. */
export class TenantThemeRestoreReview {
 private reviewed: {revision:number; source:string; candidate:string}|null=null;
 private client:PreferenceSyncClient;
 private dead=false;
 constructor(client:PreferenceSyncClient) {this.client=client;}
 private snapshot() {
  if(this.dead)throw Error('Theme review disposed');
  const binding=this.client.binding, state=this.client.current;
  if(binding.scope.role!=='tenant_admin'||binding.kind!=='theme'||binding.resource!=='advanced-v2'||
     !state.loaded||state.status!=='clean'||state.dirty||state.pending||state.remote||
     state.base.revision<1||state.base.document===null||!samePreferenceScope(state.base.scope,binding.scope)) {
   throw Error('Account theme is not ready for restore');
  }
  return state.base;
 }
 prepare() {
  this.reviewed=null;
  const snapshot=this.snapshot(),preview=previewAdvancedLibraryInLegacyEditor(snapshot.document);
  this.reviewed={revision:snapshot.revision,source:canonicalPreference(snapshot.document),candidate:canonicalPreference(preview.candidate)};
  return structuredClone(preview);
 }
 /** Refresh the account snapshot, then recheck live local state before returning a candidate. */
 async confirm(candidate:unknown, inspectLocal:()=>{libraryAbsent:boolean;draftAbsent:boolean}) {
  const reviewed=this.reviewed;this.reviewed=null;
  if(!reviewed)throw Error('Theme review required');
  await this.client.load();
  const snapshot=this.snapshot();
  const local=inspectLocal();
  if(local.libraryAbsent!==true||local.draftAbsent!==true)throw Error('Local theme resolution required');
  if(snapshot.revision!==reviewed.revision||canonicalPreference(snapshot.document)!==reviewed.source||
     canonicalPreference(candidate)!==reviewed.candidate)throw Error('Account theme changed after review');
  return previewAdvancedLibraryInLegacyEditor(snapshot.document).candidate;
 }
 dispose(){this.dead=true;this.reviewed=null;}
}
