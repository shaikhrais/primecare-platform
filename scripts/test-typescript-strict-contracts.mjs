import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {resolve} from 'node:path';
import {fileURLToPath} from 'node:url';
import {build} from 'esbuild';
import ts from 'typescript';
import * as core from '../packages/shared/src/tenant-dashboard/core.mjs';
import * as tenant from '../packages/shared/src/tenant-dashboard/view.mjs';
import * as charge from '../packages/shared/src/coordinator-charge/view.mjs';
import * as dashboard from '../packages/shared/src/dashboard-pages/projection.mjs';
import tenantCatalog from '../packages/shared/src/tenant-dashboard/catalog.json' with {type: 'json'};
import maintenanceCatalog from '../packages/shared/src/maintenance.json' with {type: 'json'};

if (process.env.PRODUCTION_DATABASE_URL || process.env.GOVERNANCE_DATABASE_URL || process.env.DB_URL) {
  throw Error('Database credentials forbidden in strict TypeScript fixtures');
}

const root = fileURLToPath(new URL('../', import.meta.url));
const options = {
  strict: true,
  noEmit: true,
  target: ts.ScriptTarget.ES2022,
  module: ts.ModuleKind.ESNext,
  moduleResolution: ts.ModuleResolutionKind.Bundler,
  resolveJsonModule: true,
  allowImportingTsExtensions: true,
  lib: ['lib.es2022.d.ts', 'lib.dom.d.ts', 'lib.dom.iterable.d.ts'],
};
const describe = diagnostics => diagnostics.map(d => ts.flattenDiagnosticMessageText(d.messageText, '\n'));
function compileFixture(source) {
  const filename = resolve(root, 'scripts/strict-contract-virtual-fixture.ts');
  const fixtureOptions = {...options, types: [], skipLibCheck: false};
  const host = ts.createCompilerHost(fixtureOptions);
  const originalGetSourceFile = host.getSourceFile;
  host.getSourceFile = (path, ...args) => path === filename
    ? ts.createSourceFile(path, source, options.target, true)
    : originalGetSourceFile.call(host, path, ...args);
  return ts.getPreEmitDiagnostics(ts.createProgram([filename], fixtureOptions, host));
}
async function bundleModule(path) {
  const result = await build({entryPoints: [resolve(root, path)], bundle: true, write: false, platform: 'node', format: 'esm'});
  return import('data:text/javascript;base64,' + Buffer.from(result.outputFiles[0].contents).toString('base64'));
}

test('the complete browser entry passes the existing strict compiler options', () => {
  const program = ts.createProgram([resolve(root, 'websites/typescript/src/main.ts')], {...options, skipLibCheck: true});
  assert.deepEqual(describe(ts.getPreEmitDiagnostics(program)), []);
});

const imports = `
import {validDate, taskInput, transition, taskActions, seedTenantDemo, emptyTenantDemo} from '../packages/shared/src/tenant-dashboard/core.mjs';
import {esc, tenantStyles, tenantNavigation, tenantView, taskForm, taskDetail, type TenantViewData, type TenantIcon} from '../packages/shared/src/tenant-dashboard/view.mjs';
import {escape, chargeStyles, chargeView, type ChargeViewData} from '../packages/shared/src/coordinator-charge/view.mjs';
`;
test('MJS declarations accept validated core results and compact presentation data without skipped library checking', () => {
  const diagnostics = compileFixture(imports + `
const demo = seedTenantDemo();
const empty: typeof demo = emptyTenantDemo();
const task = demo.tasks[0];
const changed = transition(task, 'start', 'Verified task evidence.', 'actor', true);
const evidence: string = changed.evidence;
const submittedBy: string | null | undefined = changed.submitted_by;
const action: string | undefined = taskActions(task, 'actor', true)[0];
const input = taskInput({}, demo.users, [{flow_id: 'existing-flow'}]);
const owner: string = input.owner_id;
const candidate: unknown = '2026-11-07';
if (validDate(candidate)) { const date: string = candidate; }
const icon = (name: TenantIcon): string => name;
const data: TenantViewData = {
  ...demo, today: '2026-11-07', dataset: 'demo', organization: {id: 'demo', name: 'Fictional'},
  synthetic: true, canCreate: false, canManage: false, database: 'isolated fixture',
  stats: {staff: null}, taskStats: null, preference: {view: 'overview'},
  taskPage: {total: 3, offset: 0}, workflowPage: {total: 0, offset: 0}, workflows: [], events: [],
};
const views: string[] = [tenantView(data, {}, icon), tenantView(data, {view: 'tasks'}),
  tenantNavigation('overview', icon), taskForm(data), taskForm(data, {title: 'Draft'}),
  taskDetail({title: 'Compact task', due_on: data.today, status: 'open', actions: ['start']}),
  esc(null), tenantStyles];
const chargeData: ChargeViewData = {identity: {userId: 'fixture'}, canManage: false, assignments: [], users: [], events: []};
const chargeHtml: string = chargeView(chargeData) + escape(undefined) + chargeStyles;
`);
  assert.deepEqual(describe(diagnostics), []);
});

test('MJS declarations reject malformed callers rather than turning exports into implicit any', () => {
  const diagnostics = compileFixture(imports + `
transition({status: 'open'}, 'start', 'Evidence for transition.', 'actor', true);
const evidence: number = transition({status: 'open', owner_id: 'actor'}, 'start', 'Evidence for transition.', 'actor', true).evidence;
tenantNavigation('overview', (name: number) => String(name));
taskForm({today: '2026-11-07', users: [], workflows: []}, {priority: 'invented'});
taskDetail({title: 'Task', due_on: '2026-11-07', status: 'open', actions: ['invented']});
chargeView({identity: {userId: 'fixture'}, canManage: 'true', assignments: [], users: [], events: []});
`);
  assert.equal(diagnostics.length, 6, describe(diagnostics).join('\n'));
  assert.deepEqual(diagnostics.map(d => d.code), [2345, 2322, 2345, 2322, 2322, 2322]);
});

const dashboardImports = `
import {dashboardFamilies, projectDashboard, validateDashboardResponseScope, type DashboardFamily, type DashboardScope} from '../packages/shared/src/dashboard-pages/projection.mjs';
`;
test('dashboard declarations accept unknown wire data and preserve nullable metrics and scope types', () => {
  const diagnostics = compileFixture(dashboardImports + `
const raw: unknown = JSON.parse('{}');
const scope: DashboardScope = {dataset: 'live', userId: 'actor', tenantId: 'tenant', role: 'existing-role'};
validateDashboardResponseScope(raw, scope);
const projection = projectDashboard('analytics', raw, scope);
const family: DashboardFamily = projection.family;
const availableFamily: DashboardFamily | undefined = dashboardFamilies[0];
const count: number | null | undefined = projection.metrics[0]?.value;
const source: 16578 = projection.sourceApiId;
const dataset: 'live' | 'demo' = projection.dataset;
`);
  assert.deepEqual(describe(diagnostics), []);
});
test('dashboard declarations reject malformed scope, family types and unsafe metric assumptions', () => {
  const diagnostics = compileFixture(dashboardImports + `
const scope: DashboardScope = {dataset: 'live', userId: 'actor', tenantId: 'tenant', role: 'existing-role'};
projectDashboard(42, {}, scope);
validateDashboardResponseScope({}, {dataset: 'staging', userId: 'actor', tenantId: 'tenant', role: 'role'});
projectDashboard('project', {}, {dataset: 'live', userId: 'actor', tenantId: 'tenant'});
const count: number = projectDashboard('analytics', {}, scope).metrics[0].value;
const source: 777 = projectDashboard('project', {}, scope).sourceApiId;
dashboardFamilies.push('invented');
`);
  assert.equal(diagnostics.length, 6, describe(diagnostics).join('\n'));
  assert.deepEqual(diagnostics.map(d => d.code), [2345, 2322, 2345, 2322, 2322, 2339]);
});

for (const [path, runtime] of [
  ['tenant-dashboard/core', core], ['tenant-dashboard/view', tenant], ['coordinator-charge/view', charge],
  ['dashboard-pages/projection', dashboard],
]) test(path + ' declaration names match every runtime export', () => {
  const filename = resolve(root, 'packages/shared/src/' + path + '.d.mts');
  const source = ts.createSourceFile(filename, readFileSync(filename, 'utf8'), ts.ScriptTarget.ES2022, true);
  const names = source.statements.flatMap(statement => {
    if (!statement.modifiers?.some(m => m.kind === ts.SyntaxKind.ExportKeyword)) return [];
    if (ts.isFunctionDeclaration(statement)) return [statement.name.text];
    if (ts.isVariableStatement(statement)) return statement.declarationList.declarations.map(d => d.name.getText(source));
    return [];
  });
  assert.deepEqual(names.sort(), Object.keys(runtime).sort());
});

test('growth targets still require bounded, descending integer arrays for both registered pipelines', async () => {
  const growth = await bundleModule('packages/shared/src/growth/contract.ts');
  const targets = Object.fromEntries(['tenant', 'client'].map(pipeline => [pipeline, growth.stages(pipeline).map((_, index) => 100 - index)]));
  const value = {start: '2026-11-01', end: '2026-11-30', targets, version: 0};
  assert.deepEqual(growth.planBody(value), value);
  assert.equal(growth.planBody(value).targets, targets);
  for (const pipeline of ['tenant', 'client']) {
    const length = targets[pipeline].length;
    for (const invalid of [undefined, null, {}, 'invalid', new Uint8Array(length), [],
      Array(length), Array(length).fill('1'), Array(length).fill(null), Array(length).fill(true),
      Array(length).fill(-1), Array(length).fill(1.5), Array(length).fill(1000001),
      Array.from({length}, (_, index) => index), [...targets[pipeline], 0]]) {
      assert.throws(() => growth.planBody({...value, targets: {...targets, [pipeline]: invalid}}),
        error => error instanceof growth.GrowthFailure && error.status === 400 && error.code === 'invalid_request');
    }
    for (const count of [0, 1000000]) {
      const candidate = {...value, targets: {...targets, [pipeline]: Array(length).fill(count)}};
      assert.deepEqual(growth.planBody(candidate), candidate);
    }
  }
});

test('growth finance choices remain exactly the supplied registered choices', async () => {
  const {businessView} = await bundleModule('websites/typescript/src/growth/business.ts');
  const data = {canBusiness: true, summary: {}, partnerLeads: [], clientLeads: [], partners: [], handoffs: [], entries: [], financeKinds: ['invoice', 'payment']};
  const html = businessView(key => key, data, value => String(value));
  const choices = html.match(/data-cy="growth-business-finance-kind">(.*?)<\/select>/s)?.[1];
  assert.equal(choices, '<option value="invoice">invoice</option><option value="payment">payment</option>');
  assert.equal(businessView(key => key, {...data, canBusiness: false}, String), '');
});

test('maintenance known messages translate and unknown messages retain existing safe fallbacks', async () => {
  const {MaintenanceClient} = await bundleModule('websites/typescript/src/maintenance-client.ts');
  const previousStorage = globalThis.sessionStorage, previousFetch = globalThis.fetch;
  globalThis.sessionStorage = {getItem: () => 'fixture-session'};
  try {
    for (const locale of ['en', 'fr', 'es']) {
      const client = new MaintenanceClient('https://fixture.invalid', 'fixture-session', locale);
      for (const [message, key] of Object.entries(maintenanceCatalog.serverMessages)) {
        assert.equal(typeof maintenanceCatalog.locales[locale][key], 'string');
        assert.equal(client.message(message), maintenanceCatalog.locales[locale][key]);
        globalThis.fetch = async () => Response.json({error: message}, {status: 400});
        await assert.rejects(client.read(), error => error.message === maintenanceCatalog.locales[locale][key]);
      }
      for (const value of ['Unregistered server message', '', null, undefined, 17]) {
        assert.equal(client.message(value), String(value ?? ''));
        globalThis.fetch = async () => Response.json({error: value}, {status: 400});
        await assert.rejects(client.read(), error => error.message === maintenanceCatalog.locales[locale].failed);
      }
    }
  } finally {
    if (previousStorage === undefined) delete globalThis.sessionStorage;
    else globalThis.sessionStorage = previousStorage;
    globalThis.fetch = previousFetch;
  }
});

test('core transitions retain independent review and omitted submitter semantics', () => {
  const task = {status: 'open', owner_id: 'owner'};
  assert.deepEqual(core.transition(task, 'start', '  Sufficient evidence.  ', 'owner', false),
    {status: 'in_progress', evidence: 'Sufficient evidence.', submitted_by: undefined});
  const submitted = core.transition(task, 'submit', 'Sufficient evidence.', 'owner', false);
  assert.equal(submitted.submitted_by, 'owner');
  assert.throws(() => core.transition({...task, ...submitted}, 'complete', 'Sufficient evidence.', 'owner', true), /Independent manager/);
  assert.equal(core.transition({...task, ...submitted}, 'complete', 'Sufficient evidence.', 'reviewer', true).status, 'completed');
  assert.equal(core.transition({...task, ...submitted}, 'return', 'Sufficient evidence.', 'reviewer', true).submitted_by, null);
  assert.throws(() => core.transition(task, 'start', 'Sufficient evidence.', 'other', false), /forbidden/);
  const demo = core.seedTenantDemo();
  assert.equal(demo.cleared, false);
  assert.deepEqual(core.emptyTenantDemo().tasks, []);
  assert.equal(core.validDate('2026-02-30'), false);
  const input = core.taskInput({title: ' A task ', notes: ' A note ', dueOn: '2026-11-07', ownerId: demo.users[0].id, flowId: 'registered', priority: 'normal'}, demo.users, [{flow_id: 'registered'}]);
  assert.equal(input.title, 'A task');
  assert.equal(input.notes, 'A note');
});

test('presentation declarations cover the existing icons, null metrics and compact form/detail inputs', () => {
  const source = readFileSync(resolve(root, 'packages/shared/src/tenant-dashboard/view.d.mts'), 'utf8');
  const ast = ts.createSourceFile('view.d.mts', source, ts.ScriptTarget.ES2022, true);
  const iconType = ast.statements.find(s => ts.isTypeAliasDeclaration(s) && s.name.text === 'TenantIcon');
  const declaredIcons = new Set(iconType.type.types.map(type => type.literal.text));
  const actualIcons = new Set();
  const icon = name => { actualIcons.add(name); return ''; };
  const demo = core.seedTenantDemo();
  const data = {...demo, today: '2026-11-07', dataset: 'demo', organization: {id: 'demo', name: '<Fictional>'},
    synthetic: true, canCreate: false, canManage: false, database: 'isolated fixture',
    stats: {staff: null}, taskStats: null, preference: {view: 'overview'}, taskPage: {total: 3, offset: 0},
    workflowPage: {total: 0, offset: 0}, workflows: [], events: []};
  tenant.tenantNavigation('overview', icon);
  for (const {id} of tenantCatalog.views) {
    const html = tenant.tenantView(data, {view: id}, icon);
    assert.ok(html.includes('&lt;Fictional&gt;'));
    assert.ok(!html.includes('data-cy="tenant-create-task"'));
  }
  assert.deepEqual([...actualIcons].sort(), [...declaredIcons].sort());
  assert.ok(tenant.taskForm(data, {title: '<Draft>'}).includes('&lt;Draft&gt;'));
  assert.ok(tenant.taskDetail({title: 'Task', due_on: data.today, status: 'open', actions: ['start']}).includes('data-cy="tenant-action-start"'));
  assert.ok(charge.chargeView({identity: {userId: 'fixture'}, canManage: false, assignments: [], users: [], events: []}).includes('No active additional charge'));
});
