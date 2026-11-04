import {prepareLegacyThemeMigration} from '../../domain/src/legacy-theme-migration';

/** Stage a candidate only after preserving the exact account-scoped source bytes. */
export function prepareStoredThemeMigration(storage: Storage, sourceKey: string, backupKey: string) {
  if (!sourceKey || !backupKey || sourceKey === backupKey) throw Error('Invalid theme backup scope');
  const source = storage.getItem(sourceKey);
  if (source === null) throw Error('Theme library does not exist');
  const migration = prepareLegacyThemeMigration(JSON.parse(source));
  const prior = storage.getItem(backupKey);
  if (prior !== null && prior !== source) throw Error('Existing theme backup differs');
  if (prior === null) storage.setItem(backupKey, source);
  if (storage.getItem(backupKey) !== source || storage.getItem(sourceKey) !== source) {
    throw Error('Theme backup verification failed');
  }
  return migration;
}
