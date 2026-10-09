import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';

const load = async path => {
  const built = await build({entryPoints:[path], bundle:true, write:false, platform:'node', format:'esm'});
  return import('data:text/javascript;base64,' + Buffer.from(built.outputFiles[0].text).toString('base64'));
};
const {workerHandler} = await load('cloudflare/workers/src/core/base-worker.ts');
const {WorkerApplication} = await load('cloudflare/workers/src/runtime/worker-application.ts');
const {HandlerPipeline} = await load('cloudflare/workers/src/runtime/handler-pipeline.ts');
class FixtureApplication extends WorkerApplication {
  constructor(run = async () => null, health = async () => {}) { super(); this.run = run; this.health = health; }
  healthy(env) { return this.health(env); }
  dispatch(context) { return this.run(context); }
}
const env = {SERVICE_NAME: 'client'};
const request = (path, options = {}) => new Request('https://service' + path, options);

test('untrusted origins and preflight never reach handlers or health DB', async () => {
  let calls = 0;
  const app = new FixtureApplication(async () => {calls++;}, async () => {calls++;});
  for (const path of ['/', '/health', '/booking-requests']) {
    assert.equal((await app.fetch(request(path, {headers: {origin: 'https://attacker.example'}}), env)).status, 403);
    const response = await app.fetch(request(path, {method: 'OPTIONS', headers: {origin: 'https://primecare-client.pages.dev'}}), env);
    assert.equal(response.status, 204);
    assert.equal(response.headers.get('access-control-allow-origin'), 'https://primecare-client.pages.dev');
  }
  assert.equal(calls, 0);
});

test('root and DB-backed health retain existing service envelopes', async () => {
  let healthCalls = 0;
  const app = new FixtureApplication(async () => {throw Error('must not dispatch');}, async actual => {assert.equal(actual, env); healthCalls++;});
  assert.deepEqual(await (await app.fetch(request('/'), env)).json(), {status: 'ok', service: 'client'});
  assert.deepEqual(await (await app.fetch(request('/health'), env)).json(), {status: 'healthy', service: 'client', runtime: 'cloudflare-worker-typescript'});
  assert.equal(healthCalls, 1);
});

test('fallback methods preserve 404 and explicitly unimplemented 501 behavior', async () => {
  const app = new FixtureApplication();
  for (const [path, method, status] of [['/unknown','GET',404],['/api/client-screen','GET',501],['/api/client-screen/action','POST',501],['/api/client-screen','POST',404],['/api/client-screen/action','GET',404]]) {
    const response = await app.fetch(request(path, {method}), env);
    assert.equal(response.status, status);
    assert.equal(response.headers.get('access-control-allow-origin'), '*');
  }
});

test('handler response and private headers pass through without widening fields', async () => {
  const expected = Response.json({error: 'Forbidden'}, {status: 403, headers: {'cache-control':'no-store','idempotency-replayed':'true'}});
  const app = new FixtureApplication(async () => expected);
  assert.equal(await app.fetch(request('/owned'), env), expected);
});

test('health and dispatch failures return sanitized existing 500 envelope', async () => {
  const original = console.error; console.error = () => {};
  try {
    const app = new FixtureApplication(async () => {throw Error('private-token');}, async () => {throw Error('private-db');});
    for (const path of ['/health', '/owned']) {
      const response = await app.fetch(request(path), env);
      assert.equal(response.status, 500);
      assert.deepEqual(await response.json(), {error:'Internal server error',service:'client'});
    }
  } finally {console.error = original;}
});

test('ordered pipeline stops at first response and snapshots its stage registration', async () => {
  const calls = [], expected = new Response('owned');
  const stages = [{name:'first',handle:async () => {calls.push('first');return null;}},{name:'second',handle:() => {calls.push('second');return expected;}},{name:'third',handle:() => {throw Error('must not run');}}];
  const pipeline = new HandlerPipeline(stages);
  stages[0].handle = () => {throw Error('registration mutated');}; stages.reverse();
  assert.equal(await pipeline.run({}), expected);
  assert.deepEqual(calls, ['first','second']);
});

test('pipeline preserves failure and all-unmatched semantics', async () => {
  assert.equal(await new HandlerPipeline([{name:'unmatched',handle:() => null}]).run({}), null);
  let later = false;
  await assert.rejects(new HandlerPipeline([{name:'failed',handle:() => {throw Error('failure');}},{name:'later',handle:() => {later=true;return null;}}]).run({}), /failure/);
  assert.equal(later, false);
});

test('one application isolates concurrent requests and supports extracted fetch', async () => {
  let release;
  const paused = new Promise(resolve => {release=resolve;});
  const app = new FixtureApplication(async context => {
    if (context.env.SERVICE_NAME === 'client') await paused;
    return Response.json({service:context.env.SERVICE_NAME, token:context.request.headers.get('authorization'), origin:new Headers(context.headers).get('access-control-allow-origin')});
  });
  const {fetch} = workerHandler(app);
  const first = fetch(request('/owned', {headers:{authorization:'client-token',origin:'https://primecare-client.pages.dev'}}), {SERVICE_NAME:'client'});
  const second = await fetch(request('/owned', {headers:{authorization:'provider-token',origin:'https://primecare-provider.pages.dev'}}), {SERVICE_NAME:'provider'});
  release();
  assert.deepEqual(await second.json(), {service:'provider',token:'provider-token',origin:'https://primecare-provider.pages.dev'});
  assert.deepEqual(await (await first).json(), {service:'client',token:'client-token',origin:'https://primecare-client.pages.dev'});
});
