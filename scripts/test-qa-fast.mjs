import {test} from 'node:test';
import assert from 'node:assert/strict';
import {mkdtempSync, rmSync, mkdirSync, symlinkSync, writeFileSync, readFileSync, existsSync} from 'node:fs';
import {tmpdir} from 'node:os';
import {join, resolve, relative} from 'node:path';
import {profiles, childEnvironment, parseOptions, commandFor, tapTotals, validateChild, runProfile,
  dependencyProbe, probeDependencies, reserveSmokeRun, validateSmokeIdentity, hash} from './qa-fast.mjs';
import {smokeOutput} from './fixtures/qa-run-identity.mjs';

const root = resolve('/synthetic repository');
const idA = '12345678-1234-4234-8234-123456789012', idB = '23456789-2345-4345-9345-234567890123';
const identity = (runId = idA) => ({runId, output: smokeOutput(runId), reportPath: smokeOutput(runId) + '/results.json'});
const sourcePaths = [...profiles['e2e-smoke'].files, ...profiles['e2e-smoke'].fixtures,
  'websites/typescript/src/growth/dashboard.ts', 'websites/typescript/src/styles.css'];
const source = path => Buffer.from('synthetic source bytes: ' + path.replaceAll('\\', '/'));
const tap = (changes = {}) => Object.entries({tests: 348, pass: 348, fail: 0, cancelled: 0, skipped: 0, todo: 0, ...changes})
  .map(([key, value]) => '# ' + key + ' ' + value).join('\n') + '\n';
const child = (changes = {}) => ({status: 0, signal: null, stdout: tap(), stderr: '', ...changes});
const smoke = (runId = idA) => ({passed: true, wholeTaskVerified: false, runId,
  sources: Object.fromEntries(sourcePaths.map(path => [path, hash(source(path))])),
  criterion_results: {'growth-shared-loading-error-layout': 'passed'},
  cases: ['en', 'fr', 'es'].flatMap(locale => [320, 1440].map(width => ({
    locale, width, passed: true, requests: 6, initialLoadingShell: true, errorShell: true,
    retryRestoresChrome: true, emptyState: true, transportFailureRetry: true, deniedClearsContent: true,
  }))),
});
const bytes = report => Buffer.from(JSON.stringify(report));
const completion = (report = smoke(), changes = {}) => JSON.stringify({passed: true, wholeTaskVerified: false,
  cases: 6, runId: report.runId, report: identity(report.runId).reportPath, reportSha256: hash(bytes(report)), ...changes}) + '\n';
function harness(tier = 'quick-unit', overrides = {}, checkOnly = false) {
  const invocations = [], diagnostics = [], probes = [];
  const result = runProfile({tier, root, checkOnly}, {
    env: {Path: 'synthetic path', SystemRoot: 'synthetic Windows', DATABASE_URL: 'must not propagate',
      NODE_OPTIONS: '--require untrusted', NODE_PATH: 'ambient-only modules', QA_FAST_RUN_ID: 'caller supplied',
      GROWTH_BROWSER_EXECUTABLE: 'unapproved browser'},
    nodeVersion: '24.22.1', executable: '/synthetic node',
    exists: path => !path.endsWith('results.json'), now: () => 1000,
    probe: options => { probes.push(options); return {tools: {esbuild: 'fixture-only'}, modulePaths: {}, prerequisites: []}; },
    reserve: () => identity(),
    read: path => path.endsWith('results.json') ? bytes(smoke()) : source(relative(root, path)),
    run: (...args) => { invocations.push(args); return child(tier === 'e2e-smoke' ? {stdout: completion()} : {}); },
    diagnostics: value => diagnostics.push(value), ...overrides,
  });
  return {result, invocations, diagnostics, probes};
}

test('quick command enumerates all six files without filters or shell', () => {
  const command = commandFor('quick-unit', 'node with spaces');
  assert.equal(command[0], 'node with spaces');
  assert.deepEqual(command.slice(5), [...profiles['quick-unit'].files]);
  assert.equal(profiles['quick-unit'].files.length, 6);
  assert.ok(command.includes('--test-concurrency=1')); assert.ok(command.includes('--test-timeout=60000'));
});
test('smoke invokes existing whole fixture, not a filtered browser matrix', () => {
  assert.deepEqual(commandFor('e2e-smoke', 'node'), ['node', 'scripts/test-growth-loading-browser.mjs']);
});
test('CLI rejects unknown tiers, options and missing root', () => {
  for (const args of [[], ['all'], ['quick-unit', '--filter'], ['quick-unit', '--root'], ['quick-unit', '--check', '--check']]) {
    assert.throws(() => parseOptions(args));
  }
  assert.equal(parseOptions(['quick-unit', '--check']).checkOnly, true);
});
test('environment strips credentials, hooks, adapters, module paths and caller identities', () => {
  const clean = childEnvironment({Path: 'P', SystemRoot: 'W', HOME: 'H', TEMP: 'T',
    PLAYWRIGHT_BROWSERS_PATH: 'cache', PLATFORM_TEST_DATABASE_URL: 'secret',
    GOVERNANCE_DATABASE_URL: 'secret', PGPASSWORD: 'secret', CLOUDFLARE_TOKEN: 'secret',
    PLATFORM_TEST_ADAPTER: 'adapter', NODE_OPTIONS: 'hook', NODE_PATH: 'ambient',
    QA_FAST_RUN_ID: idA, GROWTH_BROWSER_EXECUTABLE: 'custom'});
  assert.deepEqual(clean, {Path: 'P', SystemRoot: 'W', HOME: 'H', TEMP: 'T', PLAYWRIGHT_BROWSERS_PATH: 'cache', CI: '1'});
});
test('preflight uses a sanitized ESM subprocess, not parent module resolution', () => {
  const missing = {schemaVersion: 1, tools: {node: '24.22.1'}, modulePaths: {},
    prerequisites: ['Missing dependency: playwright in sanitized ESM resolution']};
  let called = false;
  const probe = probeDependencies({root, tier: 'e2e-smoke', executable: 'node with spaces',
    env: {PATH: 'P', NODE_PATH: '/ambient/playwright', NODE_OPTIONS: 'hook', QA_FAST_RUN_ID: idA}},
  (executable, args, options) => {
    called = true; assert.equal(executable, 'node with spaces');
    assert.deepEqual(args, ['--input-type=module', '--eval', dependencyProbe, 'e2e-smoke']);
    assert.equal(options.cwd, root); assert.equal(options.shell, false);
    assert.deepEqual(options.env, {PATH: 'P', CI: '1'});
    assert.match(dependencyProbe, /import\.meta\.resolve/); assert.doesNotMatch(dependencyProbe, /createRequire/);
    return child({stdout: JSON.stringify(missing), stderr: 'probe warning\n'});
  });
  assert.equal(called, true); assert.deepEqual(probe.prerequisites, missing.prerequisites);
  assert.equal(probe.diagnostics, 'probe warning\n');
});
for (const bad of [child({status: 1}), child({error: Error('ETIMEDOUT')}), child({stdout: ''}), child({stdout: '{}'})]) {
  test('failed or unknown preflight is never ready: ' + JSON.stringify(bad), () => {
    assert.throws(() => probeDependencies({root, tier: 'quick-unit', env: {}, executable: 'node'}, () => bad));
  });
}
test('the same sanitized environment reaches preflight and test child', () => {
  const {probes, invocations} = harness();
  assert.deepEqual(probes[0].env, invocations[0][2].env);
  assert.equal(probes[0].env.NODE_PATH, undefined);
});
test('preflight missing dependency remains blocked despite parent availability', () => {
  const {result, invocations} = harness('e2e-smoke', {probe: () => ({tools: {}, modulePaths: {},
    prerequisites: ['Missing dependency: playwright in sanitized ESM resolution']})});
  assert.equal(result.status, 'blocked'); assert.equal(result.exitCode, 2);
  assert.equal(result.executed, false); assert.equal(invocations.length, 0);
});
test('probe warnings are retained', () => {
  const {diagnostics} = harness('quick-unit', {probe: () => ({tools: {}, modulePaths: {}, prerequisites: [], diagnostics: 'warning\n'})});
  assert.deepEqual(diagnostics, ['warning\n', tap()]);
});
test('missing repository inputs cannot silently omit tests', () => {
  const {result, invocations} = harness('quick-unit', {exists: path => !path.endsWith('test-admin-child-sessions.mjs')});
  assert.equal(result.status, 'blocked'); assert.equal(invocations.length, 0);
});
test('missing browser is a blocker, never a browser pass', () => {
  const {result, invocations} = harness('e2e-smoke', {probe: () => ({tools: {}, modulePaths: {},
    prerequisites: ['Playwright Chromium is not installed']})});
  assert.equal(result.status, 'blocked'); assert.equal(result.passed, false); assert.equal(invocations.length, 0);
});
test('unsupported Node is a visible blocker', () => {
  assert.equal(harness('quick-unit', {nodeVersion: '20.19.0'}).result.status, 'blocked');
});
test('preflight-only is not_run and does not reserve artifact directories', () => {
  const {result, invocations} = harness('e2e-smoke', {reserve: () => assert.fail('reserved')}, true);
  assert.equal(result.status, 'not_run'); assert.equal(result.passed, false);
  assert.equal(result.executed, false); assert.equal(invocations.length, 0);
});
test('TAP parser handles CRLF and final counters', () => {
  assert.deepEqual(tapTotals((tap({tests: 1, pass: 1}) + tap()).replaceAll('\n', '\r\n')),
    {tests: 348, pass: 348, fail: 0, cancelled: 0, skipped: 0, todo: 0});
});
for (const [name, output] of [
  ['zero tests', tap({tests: 0, pass: 0})], ['missing summary', ''],
  ['reduced baseline', tap({tests: 347, pass: 347})], ['failed test', tap({pass: 347, fail: 1})],
  ['skipped test', tap({pass: 347, skipped: 1})], ['todo test', tap({pass: 347, todo: 1})],
  ['cancelled test', tap({pass: 347, cancelled: 1})],
]) test(name + ' cannot pass quick tier', () => assert.equal(validateChild('quick-unit', child({stdout: output})).status, 'failed'));
for (const changes of [{status: 1}, {status: null, signal: 'SIGKILL'},
  {status: 0, error: Error('spawn ENOENT')}, {status: null, error: Error('ETIMEDOUT')}]) {
  test('child failure is preserved: ' + (changes.error?.message || changes.signal || changes.status), () => {
    assert.equal(harness('quick-unit', {run: () => child(changes)}).result.status, 'failed');
    assert.equal(harness('e2e-smoke', {run: () => child(changes)}).result.status, 'failed');
  });
}
test('stdout and stderr survive timeout failure', () => {
  const {result, diagnostics} = harness('quick-unit', {run: () => child({status: null,
    error: Error('ETIMEDOUT'), stdout: 'partial TAP\n', stderr: 'full diagnostic\n'})});
  assert.equal(result.status, 'failed'); assert.equal(result.exitCode, 1);
  assert.deepEqual(diagnostics, ['partial TAP\n', 'full diagnostic\n']);
});
test('spawn exceptions are structured failures', () => {
  assert.equal(harness('quick-unit', {run: () => {throw Error('spawn blocked');}}).result.status, 'failed');
});
test('successful quick tier stays scoped', () => {
  const {result, invocations} = harness();
  assert.equal(result.status, 'passed'); assert.equal(result.exitCode, 0);
  assert.equal(result.wholeTaskVerified, false); assert.equal(result.releaseReady, false);
  assert.ok(result.notCovered.some(x => x.includes('PostgreSQL')));
  assert.equal(invocations[0][2].shell, false); assert.equal(invocations[0][2].timeout, 90_000);
});
test('direct fixture output defaults remain unchanged; nonce paths cannot escape', () => {
  assert.equal(smokeOutput(undefined), 'test-results/growth/loading');
  assert.equal(smokeOutput(idA), 'test-results/growth/loading/runs/' + idA);
  for (const bad of ['', null, '../outside', '/tmp/outside', idA + '/..', idA.replace('4234', '1234')]) assert.throws(() => smokeOutput(bad));
});
test('real exclusive reservations isolate concurrent runs and never reuse old evidence', () => {
  const folder = mkdtempSync(join(tmpdir(), 'qa-reserve-test-'));
  try {
    const first = reserveSmokeRun(folder, {uuid: () => idA}), second = reserveSmokeRun(folder, {uuid: () => idB});
    assert.notEqual(first.reportPath, second.reportPath);
    writeFileSync(resolve(folder, first.reportPath), 'unchanged preexisting report');
    assert.throws(() => reserveSmokeRun(folder, {uuid: () => idA}), {code: 'EEXIST'});
    assert.equal(readFileSync(resolve(folder, first.reportPath), 'utf8'), 'unchanged preexisting report');
    assert.ok(existsSync(resolve(folder, second.output)));
  } finally {rmSync(folder, {recursive: true, force: true});}
});
test('artifact symlink parents are rejected before outside writes', () => {
  const folder = mkdtempSync(join(tmpdir(), 'qa-path-test-')), outside = join(folder, 'outside'), repo = join(folder, 'repo');
  try {
    mkdirSync(outside); mkdirSync(repo); symlinkSync(outside, join(repo, 'test-results'), process.platform === 'win32' ? 'junction' : 'dir');
    assert.throws(() => reserveSmokeRun(repo), /real directory inside/);
    assert.equal(existsSync(join(outside, 'growth')), false);
  } finally {rmSync(folder, {recursive: true, force: true});}
});
test('reservation collision blocks execution, with no old report consumed', () => {
  const {result, invocations} = harness('e2e-smoke', {reserve: () => {throw Object.assign(Error('exists'), {code: 'EEXIST'});},
    read: () => assert.fail('read prior report')});
  assert.equal(result.status, 'blocked'); assert.equal(result.executed, false); assert.equal(invocations.length, 0);
});
test('preexisting unchanged report blocks, regardless of future timestamps', () => {
  const {result, invocations} = harness('e2e-smoke', {exists: () => true, now: () => 9999999999999,
    read: () => assert.fail('read preexisting report')});
  assert.equal(result.status, 'blocked'); assert.equal(invocations.length, 0);
});
test('caller nonce is discarded and only generated nonce reaches child', () => {
  const {result, invocations, probes} = harness('e2e-smoke');
  assert.equal(result.status, 'passed'); assert.equal(result.runIdentity.runId, idA);
  assert.equal(probes[0].env.QA_FAST_RUN_ID, undefined);
  assert.equal(invocations[0][2].env.QA_FAST_RUN_ID, idA);
});
for (const stdout of ['', '{invalid', '{}', completion(smoke(), {runId: idB}), completion(smoke(), {report: 'wrong/results.json'}),
  completion(smoke(), {reportSha256: '0'.repeat(64)}), completion(smoke(), {cases: 5}), completion(smoke(), {passed: false})]) {
  test('unknown, absent or mismatched completion cannot pass: ' + stdout.slice(0, 50), () => {
    assert.equal(harness('e2e-smoke', {run: () => child({stdout})}).result.status, 'failed');
  });
}
test('foreign concurrent report cannot be accepted by another invocation', () => {
  const foreign = smoke(idB);
  const {result} = harness('e2e-smoke', {run: () => child({stdout: completion(foreign)}),
    read: path => path.endsWith('results.json') ? bytes(foreign) : source(relative(root, path))});
  assert.equal(result.status, 'failed');
});
test('future-dated prior report with wrong nonce fails and clock skew grants no authority', () => {
  const prior = {...smoke(idB), createdAt: '2999-01-01T00:00:00.000Z', mtimeMs: 9999999999999};
  assert.equal(harness('e2e-smoke', {now: () => 1, run: () => child({stdout: completion(prior)}),
    read: path => path.endsWith('results.json') ? bytes(prior) : source(relative(root, path))}).result.status, 'failed');
  let clock = 1000;
  assert.equal(harness('e2e-smoke', {now: () => clock--}).result.status, 'passed');
});
test('missing nonce, malformed report and report digest mismatch fail', () => {
  for (const read of [() => {throw Error('ENOENT');}, () => '{invalid',
    () => bytes({...smoke(), runId: undefined}), () => bytes({...smoke(), extra: 'changed after stdout'})]) {
    assert.equal(harness('e2e-smoke', {read}).result.status, 'failed');
  }
});
test('incomplete, duplicate and foreign cases cannot pass even with matching digest', () => {
  for (const mutate of [s => s.cases.pop(), s => s.cases[5] = s.cases[0], s => s.cases[0] = null,
    s => s.cases[0].locale = 'foreign', s => s.cases[0].deniedClearsContent = false,
    s => s.cases[0].requests = 5, s => s.passed = false, s => s.wholeTaskVerified = true,
    s => s.criterion_results['growth-shared-loading-error-layout'] = 'failed']) {
    const report = smoke(); mutate(report);
    const {result} = harness('e2e-smoke', {run: () => child({stdout: completion(report)}),
      read: path => path.endsWith('results.json') ? bytes(report) : source(relative(root, path))});
    assert.equal(result.status, 'failed');
  }
});
test('missing, changed or escaping source hashes fail independently of nonce and report digest', () => {
  for (const mutate of [s => delete s.sources[sourcePaths[0]], s => s.sources[sourcePaths[0]] = '0'.repeat(64),
    s => s.sources = {}, s => s.sources['../outside'] = hash('outside')]) {
    const report = smoke(); mutate(report);
    assert.throws(() => validateSmokeIdentity(child({stdout: completion(report)}), bytes(report), report, identity(), root,
      path => source(relative(root, path))));
  }
  assert.equal(harness('e2e-smoke', {read: path => path.endsWith('results.json') ? bytes(smoke()) : 'changed source'}).result.status, 'failed');
});
test('complete run-bound smoke evidence passes only its narrow scope', () => {
  const {result} = harness('e2e-smoke');
  assert.equal(result.status, 'passed'); assert.equal(result.cases, 6);
  assert.equal(result.verifiedSourceCount, sourcePaths.length);
  assert.equal(result.report, identity().reportPath);
  assert.equal(result.releaseReady, false); assert.equal(result.wholeTaskVerified, false);
});
