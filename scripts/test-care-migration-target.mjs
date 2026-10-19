import {test} from 'node:test';
import assert from 'node:assert/strict';
import pg from 'pg';
import {spawnSync} from 'node:child_process';
import {checkCareMigrationTarget} from './check-care-migration-target.mjs';

const connectionString = process.env.CARE_TEST_DATABASE_URL;
if (!connectionString) throw new Error('CARE_TEST_DATABASE_URL must name an isolated test database');
const database = new pg.Client({connectionString});
await database.connect();
const schema = 'care_preflight_' + Date.now();
try {
  await database.query(`CREATE SCHEMA ${schema}; SET search_path TO ${schema}`);
  for (const type of ['uuid', 'text', 'character varying']) {
    await test(`catalog preflight accepts ${type} reference keys without reading records or leaving a transaction open`, async () => {
      for (const name of ['tenants', 'users', 'visits']) await database.query(`CREATE TABLE ${name}(id ${type} PRIMARY KEY)`);
      const result = await checkCareMigrationTarget(database);
      assert.equal(result.compatible, true, JSON.stringify(result.issues));
      assert.equal(result.identities.length, 3);
      assert.equal(result.migrationsApplied, 0);
      assert.equal(result.clinicalRecordsRead, 0);
      assert.equal(result.releaseApproved, false);
      assert.equal((await database.query('SHOW transaction_read_only')).rows[0].transaction_read_only, 'off');
      for (const name of ['tenants', 'users', 'visits']) await database.query(`DROP TABLE ${name}`);
    });
  }
  await test('missing relations and unsupported identity types fail closed', async () => {
    await database.query('CREATE TABLE tenants(id integer PRIMARY KEY)');
    const result = await checkCareMigrationTarget(database);
    assert.equal(result.compatible, false);
    assert.ok(result.issues.some(issue => issue.startsWith('users: relation')));
    assert.ok(result.issues.some(issue => issue.startsWith('visits: relation')));
    assert.ok(result.issues.some(issue => issue.startsWith('tenants: id type')));
    await database.query('DROP TABLE tenants');
  });
  await test('nullable and composite-only identities cannot masquerade as reference keys', async () => {
    await database.query('CREATE TABLE tenants(id text UNIQUE); CREATE TABLE users(id text NOT NULL,other_id text,UNIQUE(id,other_id)); CREATE TABLE visits(other_id text PRIMARY KEY)');
    const result = await checkCareMigrationTarget(database);
    assert.equal(result.compatible, false);
    assert.ok(result.issues.includes('tenants: id must be NOT NULL'));
    assert.ok(result.issues.some(issue => issue.startsWith('users: id requires')));
    assert.ok(result.issues.some(issue => issue.startsWith('visits: id type')));
    for (const name of ['tenants', 'users', 'visits']) await database.query(`DROP TABLE ${name}`);
  });
  await test('partial and deferrable unique indexes are not foreign-key reference keys', async () => {
    await database.query('CREATE TABLE tenants(id text PRIMARY KEY); CREATE TABLE users(id text NOT NULL UNIQUE DEFERRABLE); CREATE TABLE visits(id text NOT NULL); CREATE UNIQUE INDEX visits_partial_id ON visits(id) WHERE id IS NOT NULL');
    const result = await checkCareMigrationTarget(database);
    assert.equal(result.compatible, false);
    assert.ok(result.issues.some(issue => issue.startsWith('users: id requires')));
    assert.ok(result.issues.some(issue => issue.startsWith('visits: id requires')));
    for (const name of ['tenants', 'users', 'visits']) await database.query(`DROP TABLE ${name}`);
  });
  await test('the actual catalog query runs inside a read-only transaction', async () => {
    let observed = false;
    const inspected = {async query(sql) {
      if (sql.includes('WITH required')) {
        assert.equal((await database.query('SHOW transaction_read_only')).rows[0].transaction_read_only, 'on');
        observed = true;
      }
      return database.query(sql);
    }};
    await checkCareMigrationTarget(inspected);
    assert.equal(observed, true);
    assert.equal((await database.query('SHOW transaction_read_only')).rows[0].transaction_read_only, 'off');
  });
  await test('CLI refuses a missing connection without accessing a database', () => {
    const env = {...process.env};
    delete env.CARE_PREFLIGHT_DATABASE_URL;
    delete env.NODE_OPTIONS;
    const result = spawnSync(process.execPath, ['scripts/check-care-migration-target.mjs'], {env, encoding: 'utf8', timeout: 10000});
    assert.equal(result.status, 1);
    assert.match(result.stderr, /No database was accessed/);
  });
  await test('malformed connection URLs never expose credentials or an unhandled stack', () => {
    const env = {...process.env, CARE_PREFLIGHT_DATABASE_URL: 'postgresql://operator:synthetic-secret@%'};
    delete env.NODE_OPTIONS;
    const result = spawnSync(process.execPath, ['scripts/check-care-migration-target.mjs'], {env, encoding: 'utf8', timeout: 10000});
    assert.equal(result.status, 1);
    assert.match(result.stderr, /preflight failed/);
    assert.equal((result.stdout + result.stderr).includes('synthetic-secret'), false);
    assert.equal((result.stdout + result.stderr).includes('postgresql://'), false);
    assert.equal(result.stderr.includes('Error:'), false);
  });
  await test('catalog failures roll back the read-only transaction', async () => {
    const statements = [];
    const broken = {async query(sql) { statements.push(sql); if (sql.includes('current_schema')) throw new Error('synthetic catalog failure'); return {rows: []}; }};
    await assert.rejects(checkCareMigrationTarget(broken), /synthetic catalog failure/);
    assert.equal(statements[0], 'BEGIN READ ONLY');
    assert.equal(statements.at(-1), 'ROLLBACK');
  });
} finally {
  await database.query(`SET search_path TO public; DROP SCHEMA ${schema} CASCADE`);
  await database.end();
}
