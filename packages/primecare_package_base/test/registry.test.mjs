import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {PackageCatalog, PackageMaster, remoteBinding} from '../src/index.mjs';
import {createPrimeCarePackageCatalog} from '../src/catalog.g.mjs';

const descriptors = [
  {id: 'models', kind: 'library', contractVersion: 1, dependencies: []},
  {id: 'client_api', kind: 'service', contractVersion: 1, dependencies: ['models']},
  {id: 'ui', kind: 'ui', contractVersion: 1, dependencies: ['models']},
];
const catalog = () => new PackageCatalog(descriptors);

test('all actual packages and service hosts form one validated dependency graph', () => {
  const source = JSON.parse(readFileSync(new URL('../catalog.json', import.meta.url)));
  const graph = new PackageCatalog(source.packages);
  const order = graph.order();
  assert.deepEqual(createPrimeCarePackageCatalog().order(), order);
  for (const entry of source.packages) assert.deepEqual(createPrimeCarePackageCatalog().get(entry.id), graph.get(entry.id));
  for (const entry of source.packages) {
    for (const dependency of entry.dependencies) assert.ok(order.indexOf(dependency) < order.indexOf(entry.id));
  }
  assert.ok(source.packages.some(p => p.id === 'primecare_ui'));
  assert.ok(source.packages.some(p => p.id === 'auth_api'));
});

test('same caller contract works with local and remote placement without URL knowledge', () => {
  const make = bindings => {
    const host = new PackageMaster(catalog(), bindings);
    return host.register('client_api', {contractVersion: 1,
      local: () => ({read: () => 'local-result'}),
      remote: binding => ({read: () => `adapter-for:${binding.endpoint}`}),
    });
  };
  const consumer = master => master.resolve('client_api').read();
  assert.equal(consumer(make()), 'local-result');
  assert.equal(consumer(make({client_api: remoteBinding('https://example.test/service', 1)})),
    'adapter-for:https://example.test/service');
});

test('unknown, duplicate, missing and cyclic graph entries fail closed', () => {
  assert.throws(() => catalog().get('unknown'));
  assert.throws(() => new PackageCatalog([...descriptors, descriptors[0]]));
  assert.throws(() => new PackageCatalog([{...descriptors[0], dependencies: ['missing']}]));
  assert.throws(() => new PackageCatalog([{...descriptors[0], dependencies: ['models']}]));
});

test('remote configuration never activates libraries or accepts incompatible adapters', () => {
  assert.throws(() => new PackageMaster(catalog(), {ui: remoteBinding('https://example.test', 1)}));
  assert.throws(() => new PackageMaster(catalog(), {client_api: remoteBinding('https://example.test', 2)}));
  const host = new PackageMaster(catalog());
  assert.throws(() => host.register('client_api', {contractVersion: 2, local: () => ({})}));
  assert.throws(() => host.resolve('client_api'));
});

test('remote failures never call local implementation or cache failure', () => {
  let local = 0, attempts = 0;
  const host = new PackageMaster(catalog(), {client_api: remoteBinding('https://example.test', 1)});
  host.register('client_api', {contractVersion: 1,
    local: () => {local++; return {};},
    remote: () => {attempts++; throw new Error('remote unavailable');},
  });
  assert.throws(() => host.resolve('client_api'), /remote unavailable/);
  assert.throws(() => host.resolve('client_api'), /remote unavailable/);
  assert.equal(local, 0); assert.equal(attempts, 2);
});

test('endpoint configuration rejects plain HTTP and embedded credentials', () => {
  for (const url of ['http://example.test', 'https://user:pass@example.test',
    'https://example.test?token=secret', 'https://example.test/#secret',
    'https://example.test?', 'https://example.test/#', '/service']) {
    assert.throws(() => remoteBinding(url, 1));
  }
});

test('configuration is immutable and repeated resolutions reuse only the selected adapter', () => {
  const input = {client_api: {endpoint: 'https://example.test/a', contractVersion: 1}};
  const host = new PackageMaster(catalog(), input);
  input.client_api.endpoint = 'https://elsewhere.test';
  host.register('client_api', {contractVersion: 1, local: () => ({}), remote: binding => ({uri: binding.endpoint})});
  const instance = host.resolve('client_api');
  assert.equal(instance.uri, 'https://example.test/a');
  assert.equal(host.resolve('client_api'), instance);
  assert.throws(() => host.register('client_api', {contractVersion: 1, local: () => ({})}));
});

test('recursive factories and asynchronous factories fail explicitly', () => {
  const host = new PackageMaster(catalog());
  host.register('models', {contractVersion: 1, local: () => host.resolve('models')});
  assert.throws(() => host.resolve('models'), /cycle/);
  host.register('client_api', {contractVersion: 1, local: async () => ({})});
  assert.throws(() => host.resolve('client_api'), /synchronous/);
});
