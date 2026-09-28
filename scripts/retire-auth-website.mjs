// User-approved retirement: targets only the obsolete Pages UI, never auth APIs.
const account = process.env.CLOUDFLARE_ACCOUNT_ID;
const token = process.env.CLOUDFLARE_API_TOKEN;
if (!account || !token) throw new Error('Cloudflare configuration is required');
const project = 'primecare-auth';
const url = `https://api.cloudflare.com/client/v4/accounts/${encodeURIComponent(account)}/pages/projects/${project}`;
const headers = { Authorization: `Bearer ${token}` };
const current = await fetch(url, { headers });
if (current.status === 404) {
  console.log('Standalone auth website is already absent.');
  process.exit(0);
}
if (!current.ok) throw new Error(`Project lookup failed: HTTP ${current.status}`);
const body = await current.json();
if (!body.success || body.result?.name !== project || body.result?.subdomain !== `${project}.pages.dev`) {
  throw new Error('Unexpected project identity; nothing deleted');
}
const response = await fetch(url, { method: 'DELETE', headers });
const result = await response.json();
if (!response.ok || !result.success) {
  throw new Error(`Project removal failed: HTTP ${response.status}; codes ${(result.errors || []).map(e => e.code).join(',')}`);
}
const verify = await fetch(url, { headers });
if (verify.status !== 404) throw new Error(`Removal verification returned HTTP ${verify.status}`);
console.log('Removed primecare-auth Pages website. Auth API and product apps are unchanged.');
