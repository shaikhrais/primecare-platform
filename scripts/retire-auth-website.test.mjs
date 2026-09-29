import test from 'node:test';
import assert from 'node:assert/strict';
import { retireAuthWebsite } from './retire-auth-website.mjs';
const env = { CLOUDFLARE_ACCOUNT_ID: 'test-account', CLOUDFLARE_API_TOKEN: 'test-token' };
const project = { success: true, result: { name: 'primecare-auth', subdomain: 'primecare-auth.pages.dev', canonical_deployment: { id: 'live' } } };
const reply = (data, status = 200) => new Response(JSON.stringify(data), { status });

test('refuses a different project before deleting anything', async () => {
  const methods = [];
  await assert.rejects(retireAuthWebsite(env, async (_, options) => {
    methods.push(options.method || 'GET');
    return reply({ success: true, result: { name: 'primecare-clinic' } });
  }), /Unexpected project identity/);
  assert.deepEqual(methods, ['GET']);
});

test('cleans paginated history only within auth project, then verifies absence', async () => {
  const calls = [];
  const responses = [reply(project), reply({ success: false, errors: [{ code: 8000076 }] }, 400),
    reply({ success: true, result: [{ id: 'live' }, { id: 'old-1' }], result_info: { total_pages: 2 } }),
    reply({ success: true, result: [{ id: 'old-2' }], result_info: { total_pages: 2 } }),
    reply({ success: true }), reply({ success: true }), reply({ success: true }), reply({}, 404)];
  await retireAuthWebsite(env, async (url, options) => {
    calls.push({ url, method: options.method || 'GET' });
    assert.ok(url.startsWith('https://api.cloudflare.com/client/v4/accounts/test-account/pages/projects/primecare-auth'));
    return responses.shift();
  });
  assert.equal(responses.length, 0);
  assert.deepEqual(calls.filter(c => c.method === 'DELETE').map(c => c.url.split('primecare-auth')[1]),
    ['', '/deployments/old-1?force=true', '/deployments/old-2?force=true', '']);
  assert.ok(calls[3].url.endsWith('page=2'));
  assert.equal(calls.at(-1).method, 'GET');
});

test('does not clean history for unrelated deletion errors', async () => {
  let count = 0;
  await assert.rejects(retireAuthWebsite(env, async () => ++count === 1 ? reply(project) : reply({ success: false, errors: [{ code: 10000 }] }, 403)), /HTTP 403/);
  assert.equal(count, 2);
});
