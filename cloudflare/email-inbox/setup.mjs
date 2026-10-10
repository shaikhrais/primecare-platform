import {writeFile} from 'node:fs/promises';
const account = process.env.CLOUDFLARE_ACCOUNT_ID;
const token = process.env.CLOUDFLARE_API_TOKEN;
if (!account || !token) throw new Error('Cloudflare credentials missing');
async function api(path, method = 'GET', body) {
  const response = await fetch(`https://api.cloudflare.com/client/v4/accounts/${account}${path}`, {
    method, headers: {Authorization: `Bearer ${token}`, 'Content-Type': 'application/json'},
    ...(body ? {body: JSON.stringify(body)} : {}), signal: AbortSignal.timeout(30000)});
  const payload = await response.json();
  if (!response.ok || !payload.success) throw new Error(`Cloudflare ${method} ${path}: HTTP ${response.status}; codes ${(payload.errors || []).map(error => error.code).join(',')}`);
  return payload.result;
}
const namespaces = [];
for (let page = 1;;page++) {
  const batch = await api(`/storage/kv/namespaces?per_page=100&page=${page}`);
  namespaces.push(...batch); if (batch.length < 100) break;
}
let namespace = namespaces.find(value => value.title === 'primecare-email-inbox');
if (!namespace) namespace = await api('/storage/kv/namespaces', 'POST', {title: 'primecare-email-inbox'});
await writeFile('cloudflare/email-inbox/wrangler.generated.json', JSON.stringify({
  name: 'primecare-email-inbox', main: 'worker.mjs', compatibility_date: '2026-10-01',
  account_id: account, workers_dev: false, preview_urls: false,
  kv_namespaces: [{binding: 'INBOX', id: namespace.id}],
  vars: {INBOX_ADDRESSES: 'temp@15minutes-email.com,auth-test@15minutes-email.com'},
}, null, 2));
console.log('Private inbox storage configured; permanent auth-test mailbox and seven-day temp mailbox supported.');
