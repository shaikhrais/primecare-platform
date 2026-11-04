import { readFile } from 'node:fs/promises';

const read = async name => JSON.parse(await readFile(new URL(name, import.meta.url), 'utf8'));
const [pin, plan, policy] = await Promise.all([
  read('./production-pin.json'),
  read('./preference-host-binding-plan.json'),
  read('./admin-self-preference-policy.json'),
]);
const quote = value => '"' + value.replaceAll('"', '""') + '"';
const table = name => quote(pin.schema) + '.' + quote(pin.tablePrefix + name);
const links = table('screen_api_links');
const purpose = 'Authenticated self-preferences via API 777';

export async function registerPreferenceHostBindings(db, { commit = false } = {}) {
  await db.query('BEGIN');
  try {
    await db.query("SET LOCAL lock_timeout='5s'");
    await db.query("SET LOCAL statement_timeout='30s'");
    const checkedTables = ['source_manifest', 'api_endpoints', 'screens', 'roles',
      'role_screen_permissions', 'api_permissions'].map(table);
    await db.query('LOCK TABLE ' + checkedTables.join(',') + ' IN SHARE MODE');
    await db.query('LOCK TABLE ' + links + ' IN SHARE ROW EXCLUSIVE MODE');

    const manifest = await db.query('SELECT manifest_sha256 FROM ' + table('source_manifest'));
    if (manifest.rows.length !== 1 || manifest.rows[0].manifest_sha256 !== pin.manifestSha256) {
      throw Error('Preference host authority mismatch');
    }
    const endpoint = await db.query(
      'SELECT id FROM ' + table('api_endpoints') +
      " WHERE id=$1 AND route_path=$2 AND permission_key=$3 AND http_method='POST' AND service_name='auth' AND auth_required=1",
      [plan.apiId, policy.path, policy.permissionKey],
    );
    if (endpoint.rows.length !== 1) throw Error('Preference endpoint identity mismatch');

    let inserted = 0;
    for (const binding of plan.bindings) {
      for (const roleId of binding.roleIds) {
        const role = policy.roles.find(entry => entry.id === roleId);
        const grant = policy.grants.find(entry => entry.role_id === roleId);
        const access = await db.query(
          'SELECT g.id FROM ' + table('screens') + ' s JOIN ' + table('role_screen_permissions') +
          ' v ON v.screen_id=s.id JOIN ' + table('roles') + ' r ON r.id=v.role_id JOIN ' +
          table('api_permissions') + ' g ON g.role_id=r.id WHERE s.id=$1 AND s.screen_code=$2 AND s.route_path=$3' +
          ' AND s.active=1 AND r.id=$4 AND r.role_code=$5 AND r.active=1 AND v.can_view=1' +
          ' AND g.api_id=$6 AND g.id=$7 AND g.permission_key=$8 AND g.runtime_artifact_id=$9 AND g.can_access=1',
          [binding.screenId, binding.screenCode, binding.route, roleId, role.code,
            plan.apiId, grant.id, policy.permissionKey, policy.artifactId],
        );
        if (access.rows.length !== 1) throw Error('Preference host access mismatch');
      }
      const existing = await db.query('SELECT purpose FROM ' + links + ' WHERE screen_id=$1 AND api_id=$2',
        [binding.screenId, plan.apiId]);
      if (existing.rows.length > 1 || (existing.rows.length === 1 && existing.rows[0].purpose !== purpose)) {
        throw Error('Conflicting preference host link');
      }
      if (existing.rows.length === 1) continue;
      await db.query(
        'INSERT INTO ' + links + ' (id,_primecare_import_row,screen_id,api_id,purpose)' +
        ' SELECT COALESCE(MAX(id),0)+1,COALESCE(MAX(_primecare_import_row),-1)+1,$1,$2,$3 FROM ' + links,
        [binding.screenId, plan.apiId, purpose],
      );
      inserted++;
    }
    await db.query(commit ? 'COMMIT' : 'ROLLBACK');
    return { inserted, committed: commit };
  } catch (error) {
    await db.query('ROLLBACK');
    throw error;
  }
}
