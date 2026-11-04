import {prepareStoredThemeMigration} from './advanced-theme-migration';
import {saveTenantThemeMigration, retryTenantThemeMigration} from './advanced-theme-tenant-migration';
import type {PreferenceSyncClient} from '../../shared/src/preference-sync/client';

/** Explicit review and save lifecycle, owned by a single authenticated host. */
export class TenantThemeMigrationReview {
  private candidate: unknown = null;
  private disposed = false;
  constructor(private readonly storage: Storage, private readonly client: PreferenceSyncClient) {}

  prepare() {
    this.assertActive();
    const scope = this.client.binding.scope;
    if (scope.role !== 'tenant_admin' || this.client.binding.kind !== 'theme' ||
        this.client.binding.resource !== 'advanced-v2') throw Error('Unsupported migration scope');
    const profile = JSON.stringify(['tenant-dashboard', scope.dataset, scope.tenantId, scope.userId, scope.role]);
    const prepared = prepareStoredThemeMigration(this.storage, 'primecare-themes:v1:' + encodeURIComponent(profile));
    this.candidate = structuredClone(prepared.candidate);
    return structuredClone({candidate: prepared.candidate, unmappedFields: prepared.unmappedFields});
  }

  async confirm() {
    this.assertActive();
    if (!this.candidate) throw Error('Review theme migration first');
    const candidate = this.candidate;
    this.candidate = null;
    return saveTenantThemeMigration(this.storage, this.client, candidate);
  }

  async retry() {
    this.assertActive();
    return retryTenantThemeMigration(this.client);
  }

  dispose() {
    this.disposed = true;
    this.candidate = null;
  }

  private assertActive() {
    if (this.disposed) throw Error('Theme migration review disposed');
  }
}
