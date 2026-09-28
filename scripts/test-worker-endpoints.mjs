// Execute actual gateway/Worker code in memory; database access is intercepted.
import { build } from 'esbuild';
import { readFile, writeFile, mkdir } from 'node:fs/promises';
import assert from 'node:assert/strict';
import { fileURLToPath } from 'node:url';
import { spawnSync } from 'node:child_process';

const root = fileURLToPath(new URL('../', import.meta.url));
const exported = spawnSync(process.execPath, ['scripts/export-openapi.mjs'], { cwd: root, encoding: 'utf8' });
if (exported.status !== 0) throw new Error('Governance export failed');
const contract = JSON.parse(await readFile(root + 'packages/contracts/openapi.json', 'utf8'));
let databaseAttempts = 0;
const virtualDependencies = {
  name: 'isolated-database',
  setup(builder) {
    builder.onResolve({ filter: /^(pg|bcryptjs)$/ }, ({ path }) => ({ path, namespace: 'isolated' }));
    builder.onLoad({ filter: /.*/, namespace: 'isolated' }, ({ path }) => ({
      contents: path === 'pg'
        ? 'export class Client { async connect() { globalThis.__recordDatabaseAttempt(); throw new Error("ISOLATED_TEST_DATABASE_BLOCKED"); } async end() {} }'
        : 'export default { compare: async () => false };',
      loader: 'js',
    }));
  },
};
globalThis.__recordDatabaseAttempt = () => { databaseAttempts++; };
async function load(relative) {
  const result = await build({ entryPoints: [root + relative], bundle: true, write: false,
    platform: 'node', format: 'esm', plugins: [virtualDependencies] });
  return (await import('data:text/javascript;base64,' + Buffer.from(result.outputFiles[0].text).toString('base64'))).default;
}
const gateway = await load('cloudflare/workers/src/gateway.ts');
const worker = await load('cloudflare/workers/src/service.ts');
const services = ['auth', 'client', 'provider', 'visit', 'notes', 'billing', 'scheduling',
  'notification', 'verification', 'compliance', 'governance', 'franchise-reporting'];
const bindings = Object.fromEntries(services.map(service => [service.toUpperCase().replaceAll('-', '_'), {
  fetch: request => worker.fetch(request, { SERVICE_NAME: service, DB_URL: 'isolated:no-network' }),
}]));
const results = [];
async function check(name, run) {
  try { await run(); results.push({ name, passed: true }); }
  catch (error) { results.push({ name, passed: false, error: error.message }); }
}
// Only suppress the expected isolated database exception; never log response bodies.
const originalError = console.error;
console.error = error => { if (error?.message !== 'ISOLATED_TEST_DATABASE_BLOCKED') originalError(error); };
for (const [path, methods] of Object.entries(contract.paths)) {
  for (const [method, op] of Object.entries(methods)) {
    await check(`${method.toUpperCase()} ${path}: rejects unauthenticated access before DB`, async () => {
      const before = databaseAttempts;
      const request = new Request('https://gateway.test' + path, {
        method: method.toUpperCase(),
        ...(['get', 'head'].includes(method) ? {} : { headers: { 'content-type': 'application/json' }, body: '{}' }),
      });
      const response = await gateway.fetch(request, bindings);
      // Login registry conflicts with actual intended public login behavior: report explicitly.
      assert.ok(op['x-governance-auth-required'] === 1, 'Governance auth requirement needs review');
      assert.ok([401, 403].includes(response.status), `Expected 401/403; received ${response.status}. A 404 is missing routing, not working authorization.`);
      assert.equal(databaseAttempts, before, 'Unauthenticated request reached database');
    });
  }
}
for (const service of services) {
  await check(`${service}: rejects untrusted Origin`, async () => {
    const response = await worker.fetch(new Request('https://service/', { headers: { Origin: 'https://untrusted.invalid' } }),
      { SERVICE_NAME: service, DB_URL: 'isolated:no-network' });
    assert.equal(response.status, 403);
  });
}
await check('auth: empty login is rejected before DB', async () => {
  const before = databaseAttempts;
  const response = await gateway.fetch(new Request('https://gateway.test/v1/auth/login', {
    method: 'POST', headers: { 'content-type': 'application/json' }, body: '{}',
  }), bindings);
  assert.equal(response.status, 400);
  assert.equal(databaseAttempts, before);
});
await check('auth: current GET session endpoint rejects missing token', async () => {
  const response = await gateway.fetch(new Request('https://gateway.test/v1/auth/me'), bindings);
  assert.equal(response.status, 401);
});
console.error = originalError;
delete globalThis.__recordDatabaseAttempt;
const report = {
  mode: 'unit: real routing and handlers; intercepted DB, no production mutations',
  limitation: 'No successful authentication, database persistence, or tenant isolation is proven.',
  total: results.length, passed: results.filter(r => r.passed).length,
  failed: results.filter(r => !r.passed).length, databaseAttempts, results,
};
await mkdir(root + 'docs/audits', { recursive: true });
await writeFile(root + 'docs/audits/worker-endpoint-tests.json', JSON.stringify(report, null, 2) + '\n');
console.log(JSON.stringify({ ...report, results: undefined }, null, 2));
process.exitCode = report.failed ? 1 : 0;
