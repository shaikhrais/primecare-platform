import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import pg from 'pg';
import { registerPreferenceHostBindings } from './preference-host-binding-registration.mjs';

const url = new URL(process.env.PREFERENCE_HOST_TEST_URL);
assert.equal(url.hostname, '127.0.0.1');
assert.equal(url.pathname, '/preference_host_test');
const pin = JSON.parse(await readFile(new URL('./production-pin.json', import.meta.url), 'utf8'));
const db = new pg.Client({ connectionString: url.href });
await db.connect();
try {
  assert.equal((await db.query('SELECT current_database() AS name')).rows[0].name, 'preference_host_test');
  const table = name => '"' + pin.schema + '"."' + pin.tablePrefix + name + '"';
  const links = table('screen_api_links');
  await db.query(`
    CREATE SCHEMA "${pin.schema}";
    CREATE TABLE ${table('source_manifest')} (manifest_sha256 text);
    CREATE TABLE ${table('api_endpoints')} (id int,route_path text,permission_key text,http_method text,service_name text,auth_required int);
    CREATE TABLE ${table('screens')} (id int,screen_code text,route_path text,active int);
    CREATE TABLE ${table('roles')} (id int,role_code text,active int);
    CREATE TABLE ${table('role_screen_permissions')} (screen_id int,role_id int,can_view int);
    CREATE TABLE ${table('api_permissions')} (id int,role_id int,api_id int,permission_key text,runtime_artifact_id int,can_access int);
    CREATE TABLE ${links} (id int PRIMARY KEY,_primecare_import_row int UNIQUE,screen_id int,api_id int,purpose text);
    INSERT INTO ${table('api_endpoints')} VALUES (777,'/v1/user/preferences','authenticated_self_preferences','POST','auth',1);
    INSERT INTO ${table('screens')} VALUES (1269,'PLATFORM_ADMINISTRATION','/platform/administration',1),(2534,'tenant_admin_command_center','/tenant-dashboard',1);
    INSERT INTO ${table('roles')} VALUES (70,'platform_admin',1),(72,'tenant_admin',1),(80,'code_admin',1);
    INSERT INTO ${table('role_screen_permissions')} VALUES (1269,70,1),(1269,80,1),(2534,72,1);
    INSERT INTO ${table('api_permissions')} VALUES (80123,70,777,'authenticated_self_preferences',2,1),
      (80124,72,777,'authenticated_self_preferences',2,1),(80125,80,777,'authenticated_self_preferences',2,1);
    INSERT INTO ${links} VALUES (9,20,1269,100,'Existing link');
  `);
  await db.query('INSERT INTO ' + table('source_manifest') + ' VALUES ($1)', [pin.manifestSha256]);
  const snapshot = async () => (await db.query('SELECT screen_id,api_id FROM ' + links + ' ORDER BY id')).rows;
  const initial = await snapshot();
  assert.deepEqual(await registerPreferenceHostBindings(db), { inserted: 2, committed: false });
  assert.deepEqual(await snapshot(), initial);

  await db.query('UPDATE ' + table('role_screen_permissions') + ' SET can_view=0 WHERE role_id=72');
  await assert.rejects(registerPreferenceHostBindings(db, { commit: true }), /access mismatch/);
  assert.deepEqual(await snapshot(), initial);
  await db.query('UPDATE ' + table('role_screen_permissions') + ' SET can_view=1 WHERE role_id=72');

  await db.query('INSERT INTO ' + links + " VALUES (10,21,2534,777,'Conflicting existing link')");
  const beforeConflict = (await db.query('SELECT * FROM ' + links + ' ORDER BY id')).rows;
  await assert.rejects(registerPreferenceHostBindings(db, { commit: true }), /Conflicting preference host link/);
  assert.deepEqual((await db.query('SELECT * FROM ' + links + ' ORDER BY id')).rows, beforeConflict);
  await db.query('DELETE FROM ' + links + ' WHERE id=10');

  const concurrent = new pg.Client({ connectionString: url.href });
  await concurrent.connect();
  try {
    const results = await Promise.all([
      registerPreferenceHostBindings(db, { commit: true }),
      registerPreferenceHostBindings(concurrent, { commit: true }),
    ]);
    assert.ok(results.every(result => result.committed));
    assert.deepEqual(results.map(result => result.inserted).sort(), [0, 2]);
    const readback = await concurrent.query('SELECT screen_id,api_id FROM ' + links + ' ORDER BY id');
    assert.deepEqual(readback.rows, [...initial, { screen_id: 1269, api_id: 777 }, { screen_id: 2534, api_id: 777 }]);
  } finally {
    await concurrent.end();
  }
  assert.deepEqual(await snapshot(), [...initial, { screen_id: 1269, api_id: 777 }, { screen_id: 2534, api_id: 777 }]);
  assert.deepEqual(await registerPreferenceHostBindings(db, { commit: true }), { inserted: 0, committed: true });
  console.log('Preference host transaction passed dry run, atomic rollback, conflict preservation, concurrent commit and replay.');
} finally {
  await db.end();
}
