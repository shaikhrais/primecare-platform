import assert from 'node:assert/strict';
import {test as nodeTest} from 'node:test';
import {
  runtime, setup, token, filters, deferred, flush, Element, control,
  click, submit, fillSale, overview, board, areaId, sale,
} from './fixtures/admin-child-sessions.mjs';

if (Object.keys(process.env).some(key => /(?:DATABASE_URL|DB_URL|CLOUDFLARE|CF_API|PGPASSWORD)/i.test(key))) {
  throw Error('Credentials forbidden in admin authentication tests');
}
const test = (name, run) => nodeTest(name, {timeout: 5000}, run);
const {OperationsClient, TerritoryClient, OperationsController, TerritoryController} = await runtime();
const gateway = 'https://gateway.invalid';
const replacement = 'synthetic-replacement-session';
const kinds = ['operations', 'territories'];
const client = kind => kind === 'operations'
  ? new OperationsClient(gateway, token)
  : new TerritoryClient(gateway, token, 'fixture-actor');
const read = (kind, target, owner = () => {}) => kind === 'operations'
  ? target.read(filters, owner)
  : target.request(undefined, undefined, false, owner);
const retryKeys = env => [...env.values.keys()].filter(key => key.startsWith('primecare-territory:'));
const outcome = promise => promise.then(value => ({value}), error => ({error}));
async function bounded(promise) {
  let timer;
  try {
    return await Promise.race([
      promise,
      new Promise((_, reject) => { timer = setTimeout(() => reject(Error('Authentication waited for a 401 body')), 500); }),
    ]);
  } finally { clearTimeout(timer); }
}
function fixture(removal = 'normal') {
  const env = setup();
  env.events = [];
  const remove = sessionStorage.removeItem;
  sessionStorage.removeItem = key => {
    env.events.push(['remove', key]);
    if (key === 'primecare_session' && removal === 'denied') throw Error('Synthetic session removal denied');
    remove(key);
    if (key === 'primecare_session' && removal === 'after-delete') throw Error('Synthetic storage failure after deletion');
  };
  location.assign = path => { env.events.push(['navigate', path]); env.redirects.push(path); };
  return env;
}
function response(status, bodyMode = 'valid') {
  const stats = {bodyAccesses: 0, bodyCalls: 0};
  const reply = {status, ok: status >= 200 && status < 300};
  Object.defineProperty(reply, 'json', {get() {
    stats.bodyAccesses++;
    if (bodyMode === 'getter-throw') throw Error('Synthetic body getter failed');
    return () => {
      stats.bodyCalls++;
      if (bodyMode === 'throw') throw Error('Synthetic JSON failure');
      if (bodyMode === 'reject') return Promise.reject(Error('Synthetic JSON rejection'));
      if (bodyMode === 'async-reject') return new Promise((_, reject) => setImmediate(() => reject(Error('Synthetic late JSON rejection'))));
      if (bodyMode === 'malformed') return new Response('{invalid JSON', {status}).json();
      if (bodyMode === 'pending') return new Promise(() => {});
      return Promise.resolve({fixture: 'response'});
    };
  }});
  return {reply, stats};
}
function assertNoAuthentication(env, expectedToken) {
  assert.equal(env.values.get('primecare_session'), expectedToken);
  assert.deepEqual(env.redirects, []);
  assert.equal(env.events.filter(([op, key]) => op === 'remove' && key === 'primecare_session').length, 0);
}

for (const kind of kinds) for (const removal of ['normal', 'denied', 'after-delete']) {
  test(`${kind}: current 401 redirects after ${removal} session removal`, async () => {
    const env = fixture(removal), {reply, stats} = response(401);
    env.handler = async () => reply;
    const result = await bounded(outcome(read(kind, client(kind))));
    assert.equal(result.error?.message, kind === 'operations' ? 'forbidden' : 'failed');
    assert.deepEqual(env.redirects, ['/login']);
    assert.equal(env.values.get('primecare_session'), removal === 'denied' ? token : undefined);
    assert.deepEqual(env.events, [['remove', 'primecare_session'], ['navigate', '/login']]);
    assert.equal(stats.bodyAccesses, 0);
  });
}
for (const kind of kinds) for (const bodyMode of ['getter-throw', 'throw', 'reject', 'async-reject', 'malformed', 'pending']) {
  test(`${kind}: current 401 ignores ${bodyMode} JSON`, async () => {
    const env = fixture(), {reply, stats} = response(401, bodyMode);
    env.handler = async () => reply;
    const result = await bounded(outcome(read(kind, client(kind))));
    assert.equal(result.error?.message, kind === 'operations' ? 'forbidden' : 'failed');
    assert.deepEqual(env.redirects, ['/login']);
    assert.equal(env.values.has('primecare_session'), false);
    assert.equal(stats.bodyAccesses, 0);
    assert.equal(stats.bodyCalls, 0);
  });
}

for (const mutation of [false, true]) for (const removal of ['normal', 'denied']) {
  test(`territories: deferred ${mutation ? 'sale' : 'read'} 401 settles only on consume with ${removal} removal`, async () => {
    const env = fixture(removal), {reply, stats} = response(401, 'reject');
    env.handler = async () => reply;
    const receipt = await bounded(client('territories').request(mutation ? areaId : undefined, mutation ? sale : undefined, true));
    assert.equal(typeof receipt.consume, 'function');
    assertNoAuthentication(env, token);
    assert.equal(stats.bodyAccesses, 0);
    assert.equal(retryKeys(env).length, mutation ? 1 : 0);
    assert.throws(() => receipt.consume(), {message: 'failed'});
    assert.deepEqual(env.redirects, ['/login']);
    assert.equal(retryKeys(env).length, 0);
    assert.equal(env.values.get('primecare_session'), removal === 'denied' ? token : undefined);
    assert.deepEqual(env.events.slice(0, 2), [['remove', 'primecare_session'], ['navigate', '/login']]);
  });
}
for (const invalidation of ['account', 'owner']) for (const mutation of [false, true]) {
  test(`territories: deferred 401 cannot settle after ${invalidation} replacement (${mutation ? 'sale' : 'read'})`, async () => {
    const env = fixture('denied'), {reply, stats} = response(401, 'throw');
    let ownerCurrent = true;
    const owner = () => { if (!ownerCurrent) throw Error('view_changed'); };
    env.handler = async () => reply;
    const receipt = await bounded(client('territories').request(mutation ? areaId : undefined, mutation ? sale : undefined, true, owner));
    const pending = retryKeys(env).map(key => [key, env.values.get(key)]);
    if (invalidation === 'account') env.values.set('primecare_session', replacement);
    else ownerCurrent = false;
    assert.throws(() => receipt.consume(), {message: invalidation === 'account' ? 'account_changed' : 'view_changed'});
    assertNoAuthentication(env, invalidation === 'account' ? replacement : token);
    assert.equal(stats.bodyAccesses, 0);
    assert.deepEqual(retryKeys(env).map(key => [key, env.values.get(key)]), pending);
  });
}
for (const cleanup of ['own', 'replacement', 'read-denied', 'remove-denied']) for (const removal of ['normal', 'denied']) {
  test(`territories: current 401 navigates before ${cleanup} retry cleanup with ${removal} session removal`, async () => {
    const env = fixture(removal), {reply, stats} = response(401, 'malformed');
    let key, identity;
    env.handler = async () => {
      [key] = retryKeys(env);
      identity = env.values.get(key);
      if (cleanup === 'replacement') env.values.set(key, 'replacement-retry-identity');
      if (cleanup === 'read-denied') {
        const get = sessionStorage.getItem;
        sessionStorage.getItem = item => { if (item === key) throw Error('Synthetic retry read denied'); return get(item); };
      }
      if (cleanup === 'remove-denied') {
        const remove = sessionStorage.removeItem;
        sessionStorage.removeItem = item => { if (item === key) throw Error('Synthetic retry removal denied'); return remove(item); };
      }
      return reply;
    };
    const result = await bounded(outcome(client('territories').request(areaId, sale)));
    assert.ok(result.error);
    assert.deepEqual(env.redirects, ['/login']);
    assert.equal(env.values.get('primecare_session'), removal === 'denied' ? token : undefined);
    assert.equal(env.values.get(key), cleanup === 'own' ? undefined : cleanup === 'replacement' ? 'replacement-retry-identity' : identity);
    assert.deepEqual(env.events.slice(0, 2), [['remove', 'primecare_session'], ['navigate', '/login']]);
    assert.equal(stats.bodyAccesses, 0);
  });
}

for (const kind of kinds) for (const invalidation of ['account', 'owner']) {
  test(`${kind}: already stale ${invalidation} refuses 401 dispatch`, async () => {
    const env = fixture('denied');
    if (invalidation === 'account') env.values.set('primecare_session', replacement);
    const owner = () => { if (invalidation === 'owner') throw Error('view_changed'); };
    await assert.rejects(read(kind, client(kind), owner), {message: invalidation === 'account' ? 'account_changed' : 'view_changed'});
    assert.equal(env.requests.length, 0);
    assertNoAuthentication(env, invalidation === 'account' ? replacement : token);
  });
  for (const stage of ['pending-fetch', 'helper-continuation']) for (const failure of [false, true]) {
    test(`${kind}: ${invalidation} switch in ${stage} ${failure ? 'rejection' : '401 fulfillment'} cannot authenticate`, async () => {
      const env = fixture('denied'), target = client(kind), gate = deferred(), {reply, stats} = response(401, 'reject');
      let ownerCurrent = true;
      const invalidate = () => { if (invalidation === 'account') env.values.set('primecare_session', replacement); else ownerCurrent = false; };
      const owner = () => { if (!ownerCurrent) throw Error('view_changed'); };
      if (stage === 'pending-fetch') env.handler = () => gate.promise;
      else {
        env.handler = async () => { if (failure) throw Error('Synthetic fetch rejected'); return reply; };
        const original = target.readForSession.bind(target);
        target.readForSession = (...args) => {
          const pending = original(...args);
          pending.then(invalidate, invalidate);
          return pending;
        };
      }
      const pending = outcome(read(kind, target, owner));
      if (stage === 'pending-fetch') {
        assert.equal(env.requests.length, 1);
        invalidate();
        if (failure) gate.reject(Error('Synthetic fetch rejected')); else gate.resolve(reply);
      }
      const result = await pending;
      // A rejection already leaving the helper stays an error. Its caller has
      // no success/authentication continuation to execute in this window.
      const message = stage === 'helper-continuation' && failure ? 'Synthetic fetch rejected' : invalidation === 'account' ? 'account_changed' : 'view_changed';
      assert.equal(result.error?.message, message);
      assertNoAuthentication(env, invalidation === 'account' ? replacement : token);
      assert.equal(stats.bodyAccesses, 0);
    });
  }
}
for (const kind of kinds) test(`${kind}: denied session read still fails closed without dispatch or navigation`, async () => {
  const env = fixture();
  sessionStorage.getItem = () => { throw Error('Synthetic session read denied'); };
  await assert.rejects(read(kind, client(kind)), {message: 'Synthetic session read denied'});
  assert.equal(env.requests.length, 0);
  assertNoAuthentication(env, token);
});
for (const kind of kinds) for (const status of [200, 403, 409, 500, 503]) {
  test(`${kind}: status ${status} preserves payload, error and JSON handling`, async () => {
    const env = fixture('denied'), {reply, stats} = response(status);
    env.handler = async () => reply;
    const result = await outcome(read(kind, client(kind)));
    if (status === 200) assert.deepEqual(result.value, {fixture: 'response'});
    else assert.equal(result.error?.message, kind === 'operations' ? (status === 403 ? 'forbidden' : 'failed') : (status === 409 ? 'conflict' : 'failed'));
    assertNoAuthentication(env, token);
    assert.equal(stats.bodyCalls, kind === 'operations' && status !== 200 ? 0 : 1);
  });
}
for (const status of [200, 403, 409, 500, 503]) for (const bodyMode of ['valid', 'reject']) {
  test(`territories: non-401 sale ${status} ${bodyMode} body retains retry semantics`, async () => {
    const env = fixture(), {reply, stats} = response(status, bodyMode);
    env.handler = async () => reply;
    const result = await outcome(client('territories').request(areaId, sale));
    if (status === 200 && bodyMode === 'valid') assert.deepEqual(result.value, {fixture: 'response'});
    else assert.ok(result.error);
    assertNoAuthentication(env, token);
    assert.equal(stats.bodyCalls, 1);
    assert.equal(retryKeys(env).length, bodyMode === 'reject' || status >= 500 ? 1 : 0);
  });
}

async function mounted(kind) {
  const env = fixture();
  env.handler = async () => Response.json(kind === 'operations' ? overview() : board());
  const controller = kind === 'operations'
    ? new OperationsController(gateway, token, () => {})
    : new TerritoryController(gateway, token, 'fixture-actor');
  await controller.load();
  const root = new Element();
  controller.mount(root, 'en');
  return {env, controller, root};
}
for (const kind of kinds) for (const removal of ['normal', 'denied']) {
  test(`${kind}: mounted refresh 401 redirects and releases navigation with ${removal} storage removal`, async () => {
    const {env, controller, root} = await mounted(kind), {reply, stats} = response(401, 'reject');
    if (removal === 'denied') sessionStorage.removeItem = () => { throw Error('Synthetic session removal denied'); };
    env.handler = async () => reply;
    click(control(root, kind === 'operations' ? 'operations-refresh' : 'territory-refresh'));
    await flush(() => !controller.navigationPending);
    assert.deepEqual(env.redirects, ['/login']);
    assert.equal(controller.navigationPending, false);
    assert.equal(env.values.get('primecare_session'), removal === 'denied' ? token : undefined);
    assert.equal(stats.bodyAccesses, 0);
  });
}
for (const kind of kinds) for (const invalidation of ['account', 'dispose', 'detach', 'replacement']) for (const failure of [false, true]) {
  test(`${kind}: mounted ${invalidation} during fetch ${failure ? 'rejection' : '401'} protects the current owner`, async () => {
    const {env, controller, root} = await mounted(kind), gate = deferred(), {reply, stats} = response(401, 'reject');
    env.handler = () => gate.promise;
    click(control(root, kind === 'operations' ? 'operations-refresh' : 'territory-refresh'));
    if (invalidation === 'account') env.values.set('primecare_session', replacement);
    if (invalidation === 'dispose') controller.dispose();
    if (invalidation === 'detach') root.isConnected = false;
    if (invalidation === 'replacement') {
      const newer = kind === 'operations' ? new OperationsController(gateway, token, () => {}) : new TerritoryController(gateway, token, 'fixture-actor');
      env.handler = async () => Response.json(kind === 'operations' ? overview() : board());
      await newer.load();
      newer.mount(root, 'fr');
    }
    const html = root.innerHTML, renders = root.renderCount;
    if (failure) gate.reject(Error('Synthetic stale transport rejection')); else gate.resolve(reply);
    await flush(() => !controller.navigationPending);
    assertNoAuthentication(env, invalidation === 'account' ? replacement : token);
    assert.equal(stats.bodyAccesses, 0);
    if (invalidation === 'replacement') { assert.equal(root.innerHTML, html); assert.equal(root.renderCount, renders); }
  });
}
for (const invalidation of ['account', 'dispose', 'detach', 'replacement']) {
  test(`territories: 401 receipt-to-sale continuation after ${invalidation} preserves retry identity and draft`, async () => {
    const {env, controller, root} = await mounted('territories');
    click(control(root, 'territory-detail-' + areaId));
    const form = fillSale(root), draft = JSON.stringify(controller.state.draft), before = env.requests.length;
    const {reply, stats} = response(401, 'malformed');
    env.handler = async () => reply;
    const original = controller.client.request.bind(controller.client);
    controller.client.request = (...args) => original(...args).then(receipt => {
      if (invalidation === 'account') env.values.set('primecare_session', replacement);
      if (invalidation === 'dispose') controller.dispose();
      if (invalidation === 'detach') root.isConnected = false;
      if (invalidation === 'replacement') {
        const newer = new TerritoryController(gateway, token, 'fixture-actor');
        newer.board = board();
        newer.mount(root, 'fr');
      }
      return receipt;
    });
    submit(form);
    await flush(() => !controller.navigationPending);
    assert.equal(env.requests.length, before + 1);
    assert.equal(JSON.stringify(controller.state.draft), draft);
    assert.equal(retryKeys(env).length, 1);
    assertNoAuthentication(env, invalidation === 'account' ? replacement : token);
    assert.equal(stats.bodyAccesses, 0);
    assert.notEqual(controller.state.notice, 'saved');
  });
}
console.log('BOUNDARY: actual clients/controllers/panels with synthetic fetch, storage, timing, and DOM peripherals. No browser, server, or production acceptance.');
