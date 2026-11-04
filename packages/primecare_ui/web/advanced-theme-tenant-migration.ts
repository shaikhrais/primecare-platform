import {prepareStoredThemeMigration} from './advanced-theme-migration';
import {canonicalPreference, type PreferenceScope} from '../../domain/src/preference_sync';
import type {PreferenceSyncClient} from '../../shared/src/preference-sync/client';

/** Explicitly stage a reviewed tenant dashboard theme for its authenticated actor. */
export async function stageTenantThemeMigration(
  storage: Storage, client: PreferenceSyncClient, reviewedCandidate: unknown,
) {
  const scope: PreferenceScope = client.binding.scope;
  if (scope.role !== 'tenant_admin' || client.binding.kind !== 'theme' ||
      client.binding.resource !== 'advanced-v2') {
    throw Error('Unsupported migration scope');
  }
  const profile = JSON.stringify(['tenant-dashboard', scope.dataset, scope.tenantId, scope.userId, scope.role]);
  const sourceKey = 'primecare-themes:v1:' + encodeURIComponent(profile);
  const prepared = prepareStoredThemeMigration(storage, sourceKey);
  if (canonicalPreference(reviewedCandidate) !== canonicalPreference(prepared.candidate)) {
    throw Error('Reviewed theme no longer matches local themes');
  }
  await client.adoptLocal(prepared.candidate, scope);
  if (client.current.status !== 'dirty') throw Error('Theme migration draft was not saved locally');
}
