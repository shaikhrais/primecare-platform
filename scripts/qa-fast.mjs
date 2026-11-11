import {spawnSync} from 'node:child_process';
import {existsSync, readFileSync, mkdirSync, lstatSync, realpathSync} from 'node:fs';
import {createHash, randomUUID} from 'node:crypto';
import {resolve, relative, isAbsolute, sep} from 'node:path';
import {pathToFileURL} from 'node:url';
import {smokeOutput} from './fixtures/qa-run-identity.mjs';

// An additional developer feedback tier, never a release or acceptance gate.
export const profiles = Object.freeze({
  'quick-unit': Object.freeze({
    scope: 'Synthetic DOM contracts for real presentation, manager and session code',
    files: Object.freeze([
      'scripts/test-platform-browser-fixture.mjs',
      'scripts/test-platform-bundle-session.mjs',
      'scripts/test-platform-admin-manager.mjs',
      'scripts/test-typescript-screen-manager.mjs',
      'scripts/test-enquiry-manager.mjs',
      'scripts/test-admin-child-sessions.mjs',
    ]),
    fixtures: Object.freeze([
      'scripts/fixtures/platform-browser-bootstrap.ts',
      'scripts/fixtures/browser-request-arrival.mjs',
      'scripts/fixtures/platform-admin.mjs',
      'scripts/fixtures/admin-child-sessions.mjs',
    ]),
    minimumTests: 348, // Reviewed baseline; reducing coverage requires explicit review.
    timeoutMs: 90_000,
  }),
  'e2e-smoke': Object.freeze({
    scope: 'Chromium Growth renderer loading, 503/403/transport failures and retry; synthetic loopback HTTP',
    files: Object.freeze(['scripts/test-growth-loading-browser.mjs']),
    fixtures: Object.freeze([
      'scripts/fixtures/platform-browser-bootstrap.ts',
      'scripts/fixtures/browser-request-arrival.mjs',
      'scripts/fixtures/look-test-theme.json',
      'scripts/fixtures/growth-read-model.mjs',
      'scripts/fixtures/qa-run-identity.mjs',
      'scripts/care-browser-launch.mjs',
    ]),
    timeoutMs: 180_000,
  }),
});

export const notCovered = Object.freeze([
  'Growth manager suite and all other unit/integration suites',
  'Real login, role grants, tenant isolation and PostgreSQL persistence',
  'Native Dart/Flutter transport, widget and installed-device checks',
  'Full browser-engine, locale/viewport, accessibility and security gates',
  'Production governance, migration, deployment and release acceptance',
]);

export function childEnvironment(input = process.env) {
  // No NODE_OPTIONS, tokens, database URLs, cloud credentials or fixture adapters.
  // Preserve Windows executable discovery and the standard Playwright cache location.
  const allowed = /^(PATH|HOME|USERPROFILE|SYSTEMROOT|WINDIR|COMSPEC|PATHEXT|TEMP|TMP|TMPDIR|LOCALAPPDATA|APPDATA|PLAYWRIGHT_BROWSERS_PATH)$/i;
  const output = Object.fromEntries(Object.entries(input).filter(([key]) => allowed.test(key)));
  output.CI = '1';
  return output;
}

// Resolve the same ESM imports in the same sanitized process environment as tests.
// Parent createRequire() could otherwise accept ambient NODE_PATH-only packages.
export const dependencyProbe = `
import {readFileSync, existsSync} from 'node:fs';
const tier=process.argv[1], result={schemaVersion:1,tools:{node:process.versions.node},modulePaths:{},prerequisites:[]};
for(const name of ['esbuild','@twilio/voice-sdk',...(tier==='e2e-smoke'?['playwright']:[])]) {
  try {
    result.modulePaths[name]=import.meta.resolve(name);
    result.tools[name]=name==='@twilio/voice-sdk'?'resolved':JSON.parse(readFileSync(new URL(import.meta.resolve(name+'/package.json')),'utf8')).version;
  } catch { result.prerequisites.push('Missing dependency: '+name+' in sanitized ESM resolution'); }
}
if(tier==='e2e-smoke'&&result.tools.playwright) {
  try {const {chromium}=await import('playwright'); if(!existsSync(chromium.executablePath()))result.prerequisites.push('Playwright Chromium is not installed');}
  catch {result.prerequisites.push('Playwright Chromium executable could not be resolved');}
}
process.stdout.write(JSON.stringify(result));
`;

export function probeDependencies({root, tier, env, executable}, run = spawnSync) {
  const child = run(executable, ['--input-type=module', '--eval', dependencyProbe, tier], {
    cwd: root, env: childEnvironment(env), shell: false, encoding: 'utf8',
    timeout: 15_000, killSignal: 'SIGKILL', maxBuffer: 1024 * 1024, windowsHide: true,
  });
  if (child.error || child.signal || child.status !== 0) throw Error('Sanitized dependency probe failed: ' +
    (child.error?.message || child.signal || child.status) + '\n' + (child.stdout || '') + (child.stderr || ''));
  const result = JSON.parse(child.stdout);
  if (result?.schemaVersion !== 1 || !result.tools || !result.modulePaths || !Array.isArray(result.prerequisites)) {
    throw Error('Invalid sanitized dependency probe report');
  }
  return {...result, diagnostics: child.stderr || ''};
}

export const hash = bytes => createHash('sha256').update(bytes).digest('hex');

export function reserveSmokeRun(root, io = {}) {
  const fs = {mkdir: mkdirSync, lstat: lstatSync, realpath: realpathSync, uuid: randomUUID, ...io};
  const canonicalRoot = fs.realpath(root), runId = fs.uuid(), output = smokeOutput(runId);
  let parent = canonicalRoot;
  // Refuse symlink/junction artifact parents before writing into them.
  for (const name of ['test-results', 'growth', 'loading', 'runs']) {
    parent = resolve(parent, name);
    try { fs.mkdir(parent); } catch (error) { if (error.code !== 'EEXIST') throw error; }
    const stat = fs.lstat(parent);
    if (!stat.isDirectory() || stat.isSymbolicLink() || fs.realpath(parent) !== parent) {
      throw Error('QA artifact parent must be a real directory inside the repository: ' + parent);
    }
  }
  fs.mkdir(resolve(canonicalRoot, output)); // Exclusive: an existing run directory is never reused.
  return {runId, output, reportPath: output + '/results.json'};
}

export function validateSmokeIdentity(child, bytes, report, identity, root, read = readFileSync) {
  let summary;
  try { summary = JSON.parse(String(child.stdout || '').trim().split(/\r?\n/).at(-1)); }
  catch { throw Error('Missing or malformed browser completion summary'); }
  if (!identity || report.runId !== identity.runId || summary.runId !== identity.runId ||
      summary.report !== identity.reportPath || summary.reportSha256 !== hash(bytes) ||
      summary.passed !== true || summary.wholeTaskVerified !== false || summary.cases !== 6) {
    throw Error('Browser stdout, report and reserved run identity do not agree');
  }
  if (!report.sources || typeof report.sources !== 'object' || Array.isArray(report.sources)) {
    throw Error('Browser report lacks source hashes');
  }
  const required = [...profiles['e2e-smoke'].files, ...profiles['e2e-smoke'].fixtures,
    'websites/typescript/src/growth/dashboard.ts', 'websites/typescript/src/styles.css'];
  for (const path of required) if (!Object.hasOwn(report.sources, path)) throw Error('Missing browser source identity: ' + path);
  for (const [path, digest] of Object.entries(report.sources)) {
    const absolute = resolve(root, path), local = relative(root, absolute);
    if (!local || isAbsolute(path) || isAbsolute(local) || local === '..' || local.startsWith('..' + sep) ||
        typeof digest !== 'string' || !/^[a-f0-9]{64}$/.test(digest) || hash(read(absolute)) !== digest) {
      throw Error('Browser source identity differs or escapes the repository: ' + path);
    }
  }
  return Object.keys(report.sources).length;
}

export function parseOptions(args) {
  const [tier, ...rest] = args;
  if (!Object.hasOwn(profiles, tier)) throw Error('Choose quick-unit or e2e-smoke');
  let root = process.cwd(), checkOnly = false;
  for (let i = 0; i < rest.length; i++) {
    if (rest[i] === '--check' && !checkOnly) checkOnly = true;
    else if (rest[i] === '--root' && rest[i + 1] && !rest[i + 1].startsWith('--')) root = resolve(rest[++i]);
    else throw Error('Unknown or incomplete option: ' + rest[i]);
  }
  return {tier, root, checkOnly};
}

export function commandFor(tier, executable = process.execPath) {
  const profile = profiles[tier];
  if (!profile) throw Error('Unknown QA tier');
  return [executable, ...(tier === 'quick-unit'
    ? ['--test', '--test-reporter=tap', '--test-concurrency=1', '--test-timeout=60000']
    : []), ...profile.files];
}

export function tapTotals(output) {
  const totals = {};
  for (const key of ['tests', 'pass', 'fail', 'cancelled', 'skipped', 'todo']) {
    const values = [...String(output).matchAll(new RegExp('^# ' + key + ' (\\d+)\\r?$', 'gm'))];
    if (!values.length) return null;
    totals[key] = Number(values.at(-1)[1]);
  }
  return totals;
}

export function validateChild(tier, child, smokeReport) {
  if (child.error || child.signal || child.status !== 0) {
    return {status: 'failed', reason: child.error?.message || child.signal || 'Test process exited nonzero'};
  }
  if (tier === 'quick-unit') {
    const totals = tapTotals(child.stdout);
    if (!totals || totals.tests < profiles['quick-unit'].minimumTests || totals.pass !== totals.tests ||
        totals.fail || totals.cancelled || totals.skipped || totals.todo) {
      return {status: 'failed', reason: 'Missing, reduced, skipped or non-passing TAP summary', totals};
    }
    return {status: 'passed', totals};
  }
  // The existing fixture already exercises every combination. Do not filter it.
  const expected = new Set(['en:320', 'en:1440', 'fr:320', 'fr:1440', 'es:320', 'es:1440']);
  const cases = smokeReport?.cases;
  if (smokeReport?.passed !== true || smokeReport.wholeTaskVerified !== false ||
      smokeReport.criterion_results?.['growth-shared-loading-error-layout'] !== 'passed' ||
      !Array.isArray(cases) || cases.length !== expected.size ||
      cases.some(c => !c || !expected.delete(c.locale + ':' + c.width) || c.passed !== true ||
        c.requests !== 6 || ['initialLoadingShell', 'errorShell', 'retryRestoresChrome',
          'emptyState', 'transportFailureRetry', 'deniedClearsContent'].some(k => c[k] !== true))) {
    return {status: 'failed', reason: 'Missing or incomplete six-case browser smoke evidence'};
  }
  return {status: 'passed', cases: cases.length};
}

export function runProfile(options, overrides = {}) {
  const {tier, root, checkOnly = false} = options;
  const profile = profiles[tier];
  if (!profile) throw Error('Unknown QA tier');
  const io = {
    env: process.env, nodeVersion: process.versions.node, executable: process.execPath,
    exists: existsSync, read: readFileSync, now: Date.now,
    probe: probeDependencies, reserve: reserveSmokeRun, run: spawnSync,
    diagnostics: value => process.stderr.write(value),
    ...overrides,
  };
  const started = io.now();
  const result = {
    schemaVersion: 2, tier, scope: profile.scope, status: 'blocked', passed: false,
    wholeTaskVerified: false, releaseReady: false, executed: false,
    startedAt: new Date(started).toISOString(), command: commandFor(tier, io.executable),
    tools: {node: io.nodeVersion}, prerequisites: [], notCovered: [...notCovered],
  };
  const finish = () => ({...result, durationMs: Math.max(0, io.now() - started),
    exitCode: result.status === 'passed' || result.status === 'not_run' ? 0 : result.status === 'blocked' ? 2 : 1});
  if (Number(io.nodeVersion.split('.')[0]) < 22) result.prerequisites.push('Node 22 or later is required');
  for (const file of ['package.json', ...profile.files, ...profile.fixtures]) {
    if (!io.exists(resolve(root, file))) result.prerequisites.push('Missing repository file: ' + file);
  }
  const env = childEnvironment(io.env);
  try {
    const probe = io.probe({root, tier, env: {...env}, executable: io.executable});
    if (probe.diagnostics) io.diagnostics(probe.diagnostics);
    Object.assign(result.tools, probe.tools); result.modulePaths = probe.modulePaths;
    result.prerequisites.push(...probe.prerequisites);
  } catch (error) { result.prerequisites.push(String(error)); }
  if (result.prerequisites.length) return finish();
  if (checkOnly) {
    result.status = 'not_run';
    result.reason = 'Static prerequisites found; browser launch, OS libraries and tests were not executed';
    return finish();
  }
  let identity;
  if (tier === 'e2e-smoke') {
    try {
      identity = io.reserve(root);
      if (io.exists(resolve(root, identity.reportPath))) throw Error('Reserved run already contains a browser report');
      env.QA_FAST_RUN_ID = identity.runId; // Generated after sanitization; caller values are never trusted.
      result.runIdentity = identity;
    } catch (error) { result.prerequisites.push(String(error)); return finish(); }
  }
  result.executed = true;
  let child;
  try {
    child = io.run(result.command[0], result.command.slice(1), {
      cwd: root, env, shell: false, encoding: 'utf8', timeout: profile.timeoutMs,
      killSignal: 'SIGKILL', maxBuffer: 64 * 1024 * 1024, windowsHide: true,
    });
  } catch (error) {
    result.status = 'failed'; result.reason = String(error); return finish();
  }
  // Retain every captured diagnostic; stdout remains the machine-readable result.
  if (child.stdout) io.diagnostics(child.stdout);
  if (child.stderr) io.diagnostics(child.stderr);
  result.processExitCode = child.status ?? null;
  result.processSignal = child.signal ?? null;
  let report;
  if (tier === 'e2e-smoke' && child.status === 0 && !child.error && !child.signal) {
    try {
      const bytes = io.read(resolve(root, identity.reportPath));
      report = JSON.parse(bytes);
      result.verifiedSourceCount = validateSmokeIdentity(child, bytes, report, identity, root, io.read);
      result.report = identity.reportPath;
    } catch (error) {
      result.status = 'failed'; result.reason = String(error); return finish();
    }
  }
  Object.assign(result, validateChild(tier, child, report));
  result.passed = result.status === 'passed';
  return finish();
}

if (process.argv[1] && pathToFileURL(resolve(process.argv[1])).href === import.meta.url) {
  let result;
  try { result = runProfile(parseOptions(process.argv.slice(2))); }
  catch (error) {
    result = {schemaVersion: 2, status: 'blocked', passed: false, executed: false,
      wholeTaskVerified: false, releaseReady: false, reason: String(error), exitCode: 2};
  }
  process.stdout.write(JSON.stringify(result, null, 2) + '\n');
  process.exitCode = result.exitCode;
}
