import {previewAdvancedLibraryInLegacyEditor} from '../../domain/src/advanced-theme-legacy-preview';
import {canonicalPreference, samePreferenceScope} from '../../domain/src/preference_sync';
import type {PreferenceSyncClient} from '../../shared/src/preference-sync/client';

/** Read-only review for a clean, authenticated account snapshot; never writes browser storage. */
export class TenantThemeRestoreReview {
 private reviewed: {revision:number; source:string; candidate:string}|null=null;
 private client:PreferenceSyncClient;
 constructor(client:PreferenceSyncClient) {this.client=client;}
 private snapshot() {
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
 /** Recheck source and explicit local state immediately before the host restores the preview. */
 confirm(candidate:unknown, localLibraryAbsent:boolean, localDraftAbsent:boolean) {
  const reviewed=this.reviewed;this.reviewed=null;
  if(!reviewed||localLibraryAbsent!==true||localDraftAbsent!==true)throw Error('Local theme resolution required');
  const snapshot=this.snapshot();
  if(snapshot.revision!==reviewed.revision||canonicalPreference(snapshot.document)!==reviewed.source||
     canonicalPreference(candidate)!==reviewed.candidate)throw Error('Account theme changed after review');
  return previewAdvancedLibraryInLegacyEditor(snapshot.document).candidate;
 }
 dispose(){this.reviewed=null;}
}
